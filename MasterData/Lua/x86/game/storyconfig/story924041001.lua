return {
	Play924041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 924041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play924041002(arg_1_1)
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

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily08", "bgm_side_daily08", "bgm_side_daily08.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_side_daily08", "bgm_side_daily08")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.775

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(924041001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 31 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 31)

				if (31 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 31)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play924041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 924041002
		arg_9_1.duration_ = 7

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play924041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.bgs_.ST01 == nil then
				local var_12_0 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_12_0.name = "ST01"
				var_12_0.transform.parent = arg_9_1.stage_.transform
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_.ST01 = var_12_0
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_1 = arg_9_1.bgs_.ST01

				arg_9_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_12_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_2 = var_12_1:GetComponent("SpriteRenderer")

				if var_12_2 and var_12_2.sprite then
					local var_12_3 = 2 * (var_12_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_12_1.transform.localScale = Vector3.New(var_12_3 / var_12_2.sprite.bounds.size.y < var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x and var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x or var_12_3 / var_12_2.sprite.bounds.size.y, var_12_3 / var_12_2.sprite.bounds.size.y < var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x and var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x or var_12_3 / var_12_2.sprite.bounds.size.y, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "ST01" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_4 = 2

			if 2 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_4 + 0.3 and arg_9_1.time_ < var_12_4 + 0.3 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_5 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_6 = 2

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 then
				local var_12_7 = Color.New(0, 0, 0)

				var_12_7.a = Mathf.Lerp(1, 0, (arg_9_1.time_ - var_12_5) / var_12_6)
				arg_9_1.mask_.color = var_12_7
			end

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 then
				local var_12_8 = Color.New(0, 0, 0)

				arg_9_1.mask_.enabled = false
				var_12_8.a = 0
				arg_9_1.mask_.color = var_12_8
			end

			if 0.125 < arg_9_1.time_ and arg_9_1.time_ <= 0.125 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_10 = 2
			local var_12_11 = 0.9

			if 2 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_12 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_12:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_13 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(924041002).content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 36 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 36)

				if (36 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 36)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15
					var_12_10 = var_12_10 + 0.3

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = var_12_10 + 0.3
			local var_12_17 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_16 + var_12_17 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_16) / var_12_17

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play924041003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 924041003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play924041004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.225

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(924041003).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 9 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 9)

				if (9 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 9)) > 0 and var_18_0 < var_18_3 then
					arg_15_1.talkMaxDuration = var_18_3

					if var_18_3 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_3 + 0
					end
				end

				arg_15_1.text_.text = var_18_1
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_4 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_4

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play924041004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 924041004
		arg_19_1.duration_ = 3.23

		local var_19_0 = {
			zh = 3.233,
			ja = 3.2
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play924041005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "1020ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1020ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["1020ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["1020ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["1020ui_story"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1020ui_story = var_22_3.localPosition
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_3.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_19_1.time_ - 0) / var_22_4)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_3.localPosition = Vector3.New(0, -0.85, -6.25)
				var_22_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_3.position).x, (manager.ui.mainCamera.transform.position - var_22_3.position).y, (manager.ui.mainCamera.transform.position - var_22_3.position).z)
				var_22_3.localEulerAngles.z = 0
				var_22_3.localEulerAngles.x = 0
				var_22_3.localEulerAngles = var_22_3.localEulerAngles
			end

			local var_22_5 = arg_19_1.actors_["1020ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1020ui_story == nil then
				arg_19_1.var_.characterEffect1020ui_story = var_22_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_6 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_6 and not isNil(var_22_5) then
				if arg_19_1.var_.characterEffect1020ui_story and not isNil(var_22_5) then
					arg_19_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_6 and arg_19_1.time_ < 0 + var_22_6 + arg_22_0 and not isNil(var_22_5) and arg_19_1.var_.characterEffect1020ui_story then
				arg_19_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_22_8 = 0
			local var_22_9 = 0.25

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_10 = arg_19_1:GetWordFromCfg(924041004)
				local var_22_11 = arg_19_1:FormatText(var_22_10.content)

				arg_19_1.text_.text = var_22_11

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_13 = 10 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 10)

				if (10 <= 0 and var_22_9 or var_22_9 * (utf8.len(var_22_11) / 10)) > 0 and var_22_9 < var_22_13 then
					arg_19_1.talkMaxDuration = var_22_13

					if var_22_13 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_8
					end
				end

				arg_19_1.text_.text = var_22_11
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb") ~= 0 then
					local var_22_14 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb") / 1000

					if var_22_14 + var_22_8 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_14 + var_22_8
					end

					if var_22_10.prefab_name ~= "" and arg_19_1.actors_[var_22_10.prefab_name] ~= nil then
						local var_22_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_10.prefab_name].transform, "story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb")

						arg_19_1:RecordAudio("924041004", var_22_15)
						arg_19_1:RecordAudio("924041004", var_22_15)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041004", "story_v_side_old_924041.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_16 = math.max(var_22_9, arg_19_1.talkMaxDuration)

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_16 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_8) / var_22_16

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_8 + var_22_16 and arg_19_1.time_ < var_22_8 + var_22_16 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play924041005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 924041005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play924041006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1020ui_story"]) and arg_23_1.var_.characterEffect1020ui_story == nil then
				arg_23_1.var_.characterEffect1020ui_story = arg_23_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1020ui_story"]) then
				if arg_23_1.var_.characterEffect1020ui_story and not isNil(arg_23_1.actors_["1020ui_story"]) then
					arg_23_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1020ui_story"]) and arg_23_1.var_.characterEffect1020ui_story then
				arg_23_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_26_1 = 0
			local var_26_2 = 0.15

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(924041005).content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 6 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 6)

				if (6 <= 0 and var_26_2 or var_26_2 * (utf8.len(var_26_3) / 6)) > 0 and var_26_2 < var_26_5 then
					arg_23_1.talkMaxDuration = var_26_5

					if var_26_5 + var_26_1 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + var_26_1
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_6 = math.max(var_26_2, arg_23_1.talkMaxDuration)

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_6 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_1) / var_26_6

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_1 + var_26_6 and arg_23_1.time_ < var_26_1 + var_26_6 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play924041006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 924041006
		arg_27_1.duration_ = 8.7

		local var_27_0 = {
			zh = 5.5,
			ja = 8.7
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
				arg_27_0:Play924041007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1020ui_story = arg_27_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1020ui_story"].transform.position).z)
				arg_27_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1020ui_story"].transform.localEulerAngles = arg_27_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_27_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1020ui_story"].transform.position).z)
				arg_27_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1020ui_story"].transform.localEulerAngles = arg_27_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1020ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1020ui_story == nil then
				arg_27_1.var_.characterEffect1020ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1020ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1020ui_story then
				arg_27_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action483")
			end

			local var_30_4 = 0
			local var_30_5 = 0.65

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:GetWordFromCfg(924041006)
				local var_30_7 = arg_27_1:FormatText(var_30_6.content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 26 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 26)

				if (26 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 26)) > 0 and var_30_5 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb") ~= 0 then
					local var_30_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb") / 1000

					if var_30_10 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_4
					end

					if var_30_6.prefab_name ~= "" and arg_27_1.actors_[var_30_6.prefab_name] ~= nil then
						local var_30_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_6.prefab_name].transform, "story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb")

						arg_27_1:RecordAudio("924041006", var_30_11)
						arg_27_1:RecordAudio("924041006", var_30_11)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041006", "story_v_side_old_924041.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_12 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_12 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_4) / var_30_12

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_4 + var_30_12 and arg_27_1.time_ < var_30_4 + var_30_12 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play924041007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 924041007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play924041008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1020ui_story = arg_31_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1020ui_story"].transform.position).z)
				arg_31_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1020ui_story"].transform.localEulerAngles = arg_31_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1020ui_story"].transform.position).z)
				arg_31_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1020ui_story"].transform.localEulerAngles = arg_31_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1020ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1020ui_story == nil then
				arg_31_1.var_.characterEffect1020ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1020ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_2)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1020ui_story then
				arg_31_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_34_3 = 0
			local var_34_4 = 0.45

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(924041007).content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 18 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 18)

				if (18 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 18)) > 0 and var_34_4 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_8 and arg_31_1.time_ < var_34_3 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 924041008
		arg_35_1.duration_ = 3.63

		local var_35_0 = {
			zh = 3.266,
			ja = 3.633
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
				arg_35_0:Play924041009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1020ui_story = arg_35_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1020ui_story"].transform.position).z)
				arg_35_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1020ui_story"].transform.localEulerAngles = arg_35_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_35_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1020ui_story"].transform.position).z)
				arg_35_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1020ui_story"].transform.localEulerAngles = arg_35_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1020ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1020ui_story == nil then
				arg_35_1.var_.characterEffect1020ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1020ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1020ui_story then
				arg_35_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			local var_38_4 = 0
			local var_38_5 = 0.275

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(924041008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 11 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 11)

				if (11 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 11)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb")

						arg_35_1:RecordAudio("924041008", var_38_11)
						arg_35_1:RecordAudio("924041008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041008", "story_v_side_old_924041.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 924041009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play924041010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1020ui_story"]) and arg_39_1.var_.characterEffect1020ui_story == nil then
				arg_39_1.var_.characterEffect1020ui_story = arg_39_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1020ui_story"]) then
				if arg_39_1.var_.characterEffect1020ui_story and not isNil(arg_39_1.actors_["1020ui_story"]) then
					arg_39_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1020ui_story"]) and arg_39_1.var_.characterEffect1020ui_story then
				arg_39_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.175

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

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(924041009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 7 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 7)

				if (7 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 7)) > 0 and var_42_2 < var_42_5 then
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
	Play924041010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 924041010
		arg_43_1.duration_ = 4.1

		local var_43_0 = {
			zh = 2.566,
			ja = 4.1
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
				arg_43_0:Play924041011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1020ui_story = arg_43_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1020ui_story"].transform.position).z)
				arg_43_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1020ui_story"].transform.localEulerAngles = arg_43_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_43_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1020ui_story"].transform.position).z)
				arg_43_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1020ui_story"].transform.localEulerAngles = arg_43_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1020ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1020ui_story == nil then
				arg_43_1.var_.characterEffect1020ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1020ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1020ui_story then
				arg_43_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			local var_46_4 = 0
			local var_46_5 = 0.275

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(924041010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 11 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 11)

				if (11 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 11)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb")

						arg_43_1:RecordAudio("924041010", var_46_11)
						arg_43_1:RecordAudio("924041010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041010", "story_v_side_old_924041.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
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
	Play924041011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 924041011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play924041012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1020ui_story"]) and arg_47_1.var_.characterEffect1020ui_story == nil then
				arg_47_1.var_.characterEffect1020ui_story = arg_47_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1020ui_story"]) then
				if arg_47_1.var_.characterEffect1020ui_story and not isNil(arg_47_1.actors_["1020ui_story"]) then
					arg_47_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1020ui_story"]) and arg_47_1.var_.characterEffect1020ui_story then
				arg_47_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.525

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(924041011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 21 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 21)

				if (21 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 21)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play924041012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 924041012
		arg_51_1.duration_ = 14.2

		local var_51_0 = {
			zh = 10.1,
			ja = 14.2
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
				arg_51_0:Play924041013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1020ui_story = arg_51_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1020ui_story"].transform.position).z)
				arg_51_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1020ui_story"].transform.localEulerAngles = arg_51_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_51_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1020ui_story"].transform.position).z)
				arg_51_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1020ui_story"].transform.localEulerAngles = arg_51_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1020ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1020ui_story == nil then
				arg_51_1.var_.characterEffect1020ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1020ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1020ui_story then
				arg_51_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			local var_54_4 = 0
			local var_54_5 = 1.125

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(924041012)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 45 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 45)

				if (45 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 45)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb")

						arg_51_1:RecordAudio("924041012", var_54_11)
						arg_51_1:RecordAudio("924041012", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041012", "story_v_side_old_924041.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play924041013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 924041013
		arg_55_1.duration_ = 1

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"

			SetActive(arg_55_1.choicesGo_, true)

			for iter_56_0, iter_56_1 in ipairs(arg_55_1.choices_) do
				SetActive(iter_56_1.go, iter_56_0 <= 1)
			end

			arg_55_1.choices_[1].txt.text = arg_55_1:FormatText(StoryChoiceCfg[1210].name)
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play924041014(arg_55_1)
			end

			arg_55_1:RecordChoiceLog(924041013, 1210)
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1020ui_story"]) and arg_55_1.var_.characterEffect1020ui_story == nil then
				arg_55_1.var_.characterEffect1020ui_story = arg_55_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1020ui_story"]) then
				if arg_55_1.var_.characterEffect1020ui_story and not isNil(arg_55_1.actors_["1020ui_story"]) then
					arg_55_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1020ui_story"]) and arg_55_1.var_.characterEffect1020ui_story then
				arg_55_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			if arg_55_1.time_ >= var_58_1 + 0.6 and arg_55_1.time_ < var_58_1 + 0.6 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play924041014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 924041014
		arg_59_1.duration_ = 7.53

		local var_59_0 = {
			zh = 5.8,
			ja = 7.533
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play924041015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1020ui_story"]) and arg_59_1.var_.characterEffect1020ui_story == nil then
				arg_59_1.var_.characterEffect1020ui_story = arg_59_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1020ui_story"]) then
				if arg_59_1.var_.characterEffect1020ui_story and not isNil(arg_59_1.actors_["1020ui_story"]) then
					arg_59_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1020ui_story"]) and arg_59_1.var_.characterEffect1020ui_story then
				arg_59_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action463")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_62_2 = 0
			local var_62_3 = 0.625

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(924041014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 25 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 25)

				if (25 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 25)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb")

						arg_59_1:RecordAudio("924041014", var_62_9)
						arg_59_1:RecordAudio("924041014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041014", "story_v_side_old_924041.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play924041015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 924041015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play924041016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1020ui_story"]) and arg_63_1.var_.characterEffect1020ui_story == nil then
				arg_63_1.var_.characterEffect1020ui_story = arg_63_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1020ui_story"]) then
				if arg_63_1.var_.characterEffect1020ui_story and not isNil(arg_63_1.actors_["1020ui_story"]) then
					arg_63_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1020ui_story"]) and arg_63_1.var_.characterEffect1020ui_story then
				arg_63_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_66_1 = 0
			local var_66_2 = 0.35

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
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

				local var_66_3 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(924041015).content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 14 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 14)

				if (14 <= 0 and var_66_2 or var_66_2 * (utf8.len(var_66_3) / 14)) > 0 and var_66_2 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_1 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_1
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_6 = math.max(var_66_2, arg_63_1.talkMaxDuration)

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_6 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_1) / var_66_6

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_1 + var_66_6 and arg_63_1.time_ < var_66_1 + var_66_6 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play924041016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 924041016
		arg_67_1.duration_ = 6.1

		local var_67_0 = {
			zh = 3.166,
			ja = 6.1
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
				arg_67_0:Play924041017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1020ui_story = arg_67_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1020ui_story"].transform.position).z)
				arg_67_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1020ui_story"].transform.localEulerAngles = arg_67_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_67_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1020ui_story"].transform.position).z)
				arg_67_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1020ui_story"].transform.localEulerAngles = arg_67_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1020ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1020ui_story == nil then
				arg_67_1.var_.characterEffect1020ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1020ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1020ui_story then
				arg_67_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_70_4 = 0
			local var_70_5 = 0.375

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(924041016)
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

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb")

						arg_67_1:RecordAudio("924041016", var_70_11)
						arg_67_1:RecordAudio("924041016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041016", "story_v_side_old_924041.awb")
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
				actorName = "1020ui_story",
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
	Play924041017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 924041017
		arg_71_1.duration_ = 11.73

		local var_71_0 = {
			zh = 7.5,
			ja = 11.733
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
				arg_71_0:Play924041018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.85

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(924041017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 34 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 34)

				if (34 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 34)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb")

						arg_71_1:RecordAudio("924041017", var_74_6)
						arg_71_1:RecordAudio("924041017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041017", "story_v_side_old_924041.awb")
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
	Play924041018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 924041018
		arg_75_1.duration_ = 6.1

		local var_75_0 = {
			zh = 3.8,
			ja = 6.1
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
				arg_75_0:Play924041019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1020ui_story = arg_75_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1020ui_story"].transform.position).z)
				arg_75_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1020ui_story"].transform.localEulerAngles = arg_75_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_75_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1020ui_story"].transform.position).z)
				arg_75_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1020ui_story"].transform.localEulerAngles = arg_75_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action7_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_78_1 = 0
			local var_78_2 = 0.3

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(924041018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 12 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 12)

				if (12 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_4) / 12)) > 0 and var_78_2 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb") ~= 0 then
					local var_78_7 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb") / 1000

					if var_78_7 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_1
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb")

						arg_75_1:RecordAudio("924041018", var_78_8)
						arg_75_1:RecordAudio("924041018", var_78_8)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041018", "story_v_side_old_924041.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_9 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_9 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_9

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_9 and arg_75_1.time_ < var_78_1 + var_78_9 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play924041019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 924041019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play924041020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1020ui_story = arg_79_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1020ui_story"].transform.position).z)
				arg_79_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1020ui_story"].transform.localEulerAngles = arg_79_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1020ui_story"].transform.position).z)
				arg_79_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1020ui_story"].transform.localEulerAngles = arg_79_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1020ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1020ui_story == nil then
				arg_79_1.var_.characterEffect1020ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1020ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_2)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1020ui_story then
				arg_79_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_82_3 = 0
			local var_82_4 = 0.725

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_5 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(924041019).content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 29 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_5) / 29)

				if (29 <= 0 and var_82_4 or var_82_4 * (utf8.len(var_82_5) / 29)) > 0 and var_82_4 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_3
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_4, arg_79_1.talkMaxDuration)

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_3) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_3 + var_82_8 and arg_79_1.time_ < var_82_3 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play924041020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 924041020
		arg_83_1.duration_ = 1

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"

			SetActive(arg_83_1.choicesGo_, true)

			for iter_84_0, iter_84_1 in ipairs(arg_83_1.choices_) do
				SetActive(iter_84_1.go, iter_84_0 <= 1)
			end

			arg_83_1.choices_[1].txt.text = arg_83_1:FormatText(StoryChoiceCfg[1211].name)
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play924041021(arg_83_1)
			end

			arg_83_1:RecordChoiceLog(924041020, 1211)
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			return
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play924041021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 924041021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play924041022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.025

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(924041021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 41 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 41)

				if (41 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 41)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play924041022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 924041022
		arg_91_1.duration_ = 5.3

		local var_91_0 = {
			zh = 5,
			ja = 5.3
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play924041023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1020ui_story = arg_91_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).z)
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles = arg_91_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_91_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["1020ui_story"].transform.position).z)
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["1020ui_story"].transform.localEulerAngles = arg_91_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["1020ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1020ui_story == nil then
				arg_91_1.var_.characterEffect1020ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect1020ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect1020ui_story then
				arg_91_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_94_4 = 0
			local var_94_5 = 0.45

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(924041022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 18 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 18)

				if (18 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 18)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb")

						arg_91_1:RecordAudio("924041022", var_94_11)
						arg_91_1:RecordAudio("924041022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041022", "story_v_side_old_924041.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play924041023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 924041023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play924041024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1020ui_story"]) and arg_95_1.var_.characterEffect1020ui_story == nil then
				arg_95_1.var_.characterEffect1020ui_story = arg_95_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1020ui_story"]) then
				if arg_95_1.var_.characterEffect1020ui_story and not isNil(arg_95_1.actors_["1020ui_story"]) then
					arg_95_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_0)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1020ui_story"]) and arg_95_1.var_.characterEffect1020ui_story then
				arg_95_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_98_1 = 0
			local var_98_2 = 0.475

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(924041023).content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 19 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 19)

				if (19 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_3) / 19)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_6 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_6 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_6

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_6 and arg_95_1.time_ < var_98_1 + var_98_6 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play924041024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 924041024
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play924041025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1020ui_story"]) and arg_99_1.var_.characterEffect1020ui_story == nil then
				arg_99_1.var_.characterEffect1020ui_story = arg_99_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1020ui_story"]) then
				if arg_99_1.var_.characterEffect1020ui_story and not isNil(arg_99_1.actors_["1020ui_story"]) then
					arg_99_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1020ui_story"]) and arg_99_1.var_.characterEffect1020ui_story then
				arg_99_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action4_2")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_102_2 = 0
			local var_102_3 = 0.075

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_4 = arg_99_1:GetWordFromCfg(924041024)
				local var_102_5 = arg_99_1:FormatText(var_102_4.content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 3 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 3)

				if (3 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_5) / 3)) > 0 and var_102_3 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_2
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb") / 1000

					if var_102_8 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_2
					end

					if var_102_4.prefab_name ~= "" and arg_99_1.actors_[var_102_4.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_4.prefab_name].transform, "story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb")

						arg_99_1:RecordAudio("924041024", var_102_9)
						arg_99_1:RecordAudio("924041024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041024", "story_v_side_old_924041.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_3, arg_99_1.talkMaxDuration)

			if var_102_2 <= arg_99_1.time_ and arg_99_1.time_ < var_102_2 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_2) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_2 + var_102_10 and arg_99_1.time_ < var_102_2 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play924041025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 924041025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play924041026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1020ui_story"]) and arg_103_1.var_.characterEffect1020ui_story == nil then
				arg_103_1.var_.characterEffect1020ui_story = arg_103_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1020ui_story"]) then
				if arg_103_1.var_.characterEffect1020ui_story and not isNil(arg_103_1.actors_["1020ui_story"]) then
					arg_103_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1020ui_story"]) and arg_103_1.var_.characterEffect1020ui_story then
				arg_103_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 0.175

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(924041025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 7 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 7)

				if (7 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 7)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play924041026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 924041026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play924041027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.475

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(924041026).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 19 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 19)

				if (19 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 19)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play924041027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 924041027
		arg_111_1.duration_ = 6.13

		local var_111_0 = {
			zh = 3.8,
			ja = 6.133
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play924041028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1020ui_story = arg_111_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1020ui_story"].transform.position).z)
				arg_111_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1020ui_story"].transform.localEulerAngles = arg_111_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_111_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1020ui_story"].transform.position).z)
				arg_111_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1020ui_story"].transform.localEulerAngles = arg_111_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["1020ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1020ui_story == nil then
				arg_111_1.var_.characterEffect1020ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect1020ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1020ui_story then
				arg_111_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_114_4 = 0
			local var_114_5 = 0.275

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(924041027)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 11 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 11)

				if (11 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 11)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb")

						arg_111_1:RecordAudio("924041027", var_114_11)
						arg_111_1:RecordAudio("924041027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041027", "story_v_side_old_924041.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_12 and arg_111_1.time_ < var_114_4 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play924041028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 924041028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play924041029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1020ui_story = arg_115_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).z)
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles = arg_115_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).z)
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles = arg_115_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1020ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1020ui_story == nil then
				arg_115_1.var_.characterEffect1020ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1020ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_2)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1020ui_story then
				arg_115_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_118_3 = 0
			local var_118_4 = 0.775

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_5 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(924041028).content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 31 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 31)

				if (31 <= 0 and var_118_4 or var_118_4 * (utf8.len(var_118_5) / 31)) > 0 and var_118_4 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_3 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_3
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_4, arg_115_1.talkMaxDuration)

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_3) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_3 + var_118_8 and arg_115_1.time_ < var_118_3 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play924041029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 924041029
		arg_119_1.duration_ = 3.33

		local var_119_0 = {
			zh = 2.9,
			ja = 3.333
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play924041030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1020ui_story = arg_119_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1020ui_story"].transform.position).z)
				arg_119_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1020ui_story"].transform.localEulerAngles = arg_119_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_119_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1020ui_story"].transform.position).z)
				arg_119_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1020ui_story"].transform.localEulerAngles = arg_119_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1020ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1020ui_story == nil then
				arg_119_1.var_.characterEffect1020ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1020ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1020ui_story then
				arg_119_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_2")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_122_4 = 0
			local var_122_5 = 0.225

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(924041029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 9 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 9)

				if (9 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 9)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb")

						arg_119_1:RecordAudio("924041029", var_122_11)
						arg_119_1:RecordAudio("924041029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041029", "story_v_side_old_924041.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play924041030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 924041030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play924041031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1020ui_story"]) and arg_123_1.var_.characterEffect1020ui_story == nil then
				arg_123_1.var_.characterEffect1020ui_story = arg_123_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1020ui_story"]) then
				if arg_123_1.var_.characterEffect1020ui_story and not isNil(arg_123_1.actors_["1020ui_story"]) then
					arg_123_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1020ui_story"]) and arg_123_1.var_.characterEffect1020ui_story then
				arg_123_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 0.6

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(924041030).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 24 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 24)

				if (24 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 24)) > 0 and var_126_2 < var_126_5 then
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
	Play924041031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 924041031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play924041032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.6

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(924041031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 24 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 24)

				if (24 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 24)) > 0 and var_130_0 < var_130_3 then
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
	Play924041032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 924041032
		arg_131_1.duration_ = 2

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play924041033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1020ui_story = arg_131_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1020ui_story"].transform.position).z)
				arg_131_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1020ui_story"].transform.localEulerAngles = arg_131_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_131_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1020ui_story"].transform.position).z)
				arg_131_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1020ui_story"].transform.localEulerAngles = arg_131_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1020ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1020ui_story == nil then
				arg_131_1.var_.characterEffect1020ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1020ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1020ui_story then
				arg_131_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_134_4 = 0
			local var_134_5 = 0.125

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(924041032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 5 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 5)

				if (5 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 5)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb")

						arg_131_1:RecordAudio("924041032", var_134_11)
						arg_131_1:RecordAudio("924041032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041032", "story_v_side_old_924041.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play924041033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 924041033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play924041034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1020ui_story"]) and arg_135_1.var_.characterEffect1020ui_story == nil then
				arg_135_1.var_.characterEffect1020ui_story = arg_135_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1020ui_story"]) then
				if arg_135_1.var_.characterEffect1020ui_story and not isNil(arg_135_1.actors_["1020ui_story"]) then
					arg_135_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1020ui_story"]) and arg_135_1.var_.characterEffect1020ui_story then
				arg_135_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.2

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(924041033).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 8 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 8)

				if (8 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 8)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_1 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_1
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_6 = math.max(var_138_2, arg_135_1.talkMaxDuration)

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_6 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_1) / var_138_6

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_1 + var_138_6 and arg_135_1.time_ < var_138_1 + var_138_6 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play924041034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 924041034
		arg_139_1.duration_ = 12.87

		local var_139_0 = {
			zh = 9.133,
			ja = 12.866
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play924041035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1020ui_story = arg_139_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1020ui_story"].transform.position).z)
				arg_139_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1020ui_story"].transform.localEulerAngles = arg_139_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_139_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1020ui_story"].transform.position).z)
				arg_139_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1020ui_story"].transform.localEulerAngles = arg_139_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1020ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1020ui_story == nil then
				arg_139_1.var_.characterEffect1020ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1020ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1020ui_story then
				arg_139_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action484")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_142_4 = 0
			local var_142_5 = 0.775

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(924041034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 31 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 31)

				if (31 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 31)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb")

						arg_139_1:RecordAudio("924041034", var_142_11)
						arg_139_1:RecordAudio("924041034", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041034", "story_v_side_old_924041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play924041035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 924041035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play924041036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1020ui_story"]) and arg_143_1.var_.characterEffect1020ui_story == nil then
				arg_143_1.var_.characterEffect1020ui_story = arg_143_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1020ui_story"]) then
				if arg_143_1.var_.characterEffect1020ui_story and not isNil(arg_143_1.actors_["1020ui_story"]) then
					arg_143_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1020ui_story"]) and arg_143_1.var_.characterEffect1020ui_story then
				arg_143_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.475

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(924041035).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 19 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 19)

				if (19 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 19)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play924041036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 924041036
		arg_147_1.duration_ = 4.7

		local var_147_0 = {
			zh = 2.5,
			ja = 4.7
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play924041037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1020ui_story = arg_147_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1020ui_story"].transform.position).z)
				arg_147_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1020ui_story"].transform.localEulerAngles = arg_147_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_147_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1020ui_story"].transform.position).z)
				arg_147_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1020ui_story"].transform.localEulerAngles = arg_147_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1020ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1020ui_story == nil then
				arg_147_1.var_.characterEffect1020ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1020ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1020ui_story then
				arg_147_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action446")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_150_4 = 0
			local var_150_5 = 0.275

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(924041036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 11 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 11)

				if (11 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 11)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb")

						arg_147_1:RecordAudio("924041036", var_150_11)
						arg_147_1:RecordAudio("924041036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041036", "story_v_side_old_924041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play924041037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 924041037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play924041038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1020ui_story"]) and arg_151_1.var_.characterEffect1020ui_story == nil then
				arg_151_1.var_.characterEffect1020ui_story = arg_151_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1020ui_story"]) then
				if arg_151_1.var_.characterEffect1020ui_story and not isNil(arg_151_1.actors_["1020ui_story"]) then
					arg_151_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1020ui_story"]) and arg_151_1.var_.characterEffect1020ui_story then
				arg_151_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.475

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(924041037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 19 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 19)

				if (19 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 19)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play924041038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 924041038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play924041039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1020ui_story = arg_155_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1020ui_story"].transform.position).z)
				arg_155_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1020ui_story"].transform.localEulerAngles = arg_155_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1020ui_story"].transform.position).z)
				arg_155_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1020ui_story"].transform.localEulerAngles = arg_155_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_158_1 = 0
			local var_158_2 = 0.875

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(924041038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 35 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 35)

				if (35 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 35)) > 0 and var_158_2 < var_158_5 then
					arg_155_1.talkMaxDuration = var_158_5

					if var_158_5 + var_158_1 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + var_158_1
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_6 = math.max(var_158_2, arg_155_1.talkMaxDuration)

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_6 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_1) / var_158_6

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_1 + var_158_6 and arg_155_1.time_ < var_158_1 + var_158_6 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play924041039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 924041039
		arg_159_1.duration_ = 2

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play924041040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1020ui_story = arg_159_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1020ui_story"].transform.position).z)
				arg_159_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1020ui_story"].transform.localEulerAngles = arg_159_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_159_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1020ui_story"].transform.position).z)
				arg_159_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1020ui_story"].transform.localEulerAngles = arg_159_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1020ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1020ui_story == nil then
				arg_159_1.var_.characterEffect1020ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1020ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1020ui_story then
				arg_159_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			local var_162_4 = 0
			local var_162_5 = 0.05

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(924041039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 2 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 2)

				if (2 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 2)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb")

						arg_159_1:RecordAudio("924041039", var_162_11)
						arg_159_1:RecordAudio("924041039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041039", "story_v_side_old_924041.awb")
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
				actorName = "1020ui_story",
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
	Play924041040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 924041040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play924041041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1020ui_story"]) and arg_163_1.var_.characterEffect1020ui_story == nil then
				arg_163_1.var_.characterEffect1020ui_story = arg_163_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1020ui_story"]) then
				if arg_163_1.var_.characterEffect1020ui_story and not isNil(arg_163_1.actors_["1020ui_story"]) then
					arg_163_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1020ui_story"]) and arg_163_1.var_.characterEffect1020ui_story then
				arg_163_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_166_1 = arg_163_1.actors_["1020ui_story"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1020ui_story = var_166_1.localPosition
			end

			local var_166_2 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 then
				var_166_1.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_2)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 then
				var_166_1.localPosition = Vector3.New(0, 100, 0)
				var_166_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_166_1.position).x, (manager.ui.mainCamera.transform.position - var_166_1.position).y, (manager.ui.mainCamera.transform.position - var_166_1.position).z)
				var_166_1.localEulerAngles.z = 0
				var_166_1.localEulerAngles.x = 0
				var_166_1.localEulerAngles = var_166_1.localEulerAngles
			end

			local var_166_3 = 0
			local var_166_4 = 0.85

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_3 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_5 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(924041040).content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 34 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_5) / 34)

				if (34 <= 0 and var_166_4 or var_166_4 * (utf8.len(var_166_5) / 34)) > 0 and var_166_4 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_3 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_3
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_4, arg_163_1.talkMaxDuration)

			if var_166_3 <= arg_163_1.time_ and arg_163_1.time_ < var_166_3 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_3) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_3 + var_166_8 and arg_163_1.time_ < var_166_3 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play924041041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 924041041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play924041042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.35

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(924041041).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 54 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 54)

				if (54 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 54)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play924041042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 924041042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play924041043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.85

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

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(924041042).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 34 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 34)

				if (34 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 34)) > 0 and var_174_0 < var_174_3 then
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
	Play924041043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 924041043
		arg_175_1.duration_ = 1

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"

			SetActive(arg_175_1.choicesGo_, true)

			for iter_176_0, iter_176_1 in ipairs(arg_175_1.choices_) do
				SetActive(iter_176_1.go, iter_176_0 <= 2)
			end

			arg_175_1.choices_[1].txt.text = arg_175_1:FormatText(StoryChoiceCfg[1212].name)
			arg_175_1.choices_[2].txt.text = arg_175_1:FormatText(StoryChoiceCfg[1213].name)
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play924041044(arg_175_1)
			end

			if arg_177_0 == 2 then
				arg_175_0:Play924041044(arg_175_1)
			end

			arg_175_1:RecordChoiceLog(924041043, 1212, 1213)
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= 0 + 0.6 and arg_175_1.time_ < 0 + 0.6 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play924041044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 924041044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play924041045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0.125 < arg_179_1.time_ and arg_179_1.time_ <= 0.125 + arg_182_0 then
				arg_179_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_handle", "")
			end

			local var_182_1 = 0
			local var_182_2 = 1.15

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(924041044).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 46 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 46)

				if (46 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 46)) > 0 and var_182_2 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_6 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_6

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_6 and arg_179_1.time_ < var_182_1 + var_182_6 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play924041045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 924041045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play924041046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.2

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(924041045).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 8 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 8)

				if (8 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 8)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play924041046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 924041046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play924041047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.125

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(924041046).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 45 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 45)

				if (45 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 45)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play924041047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 924041047
		arg_191_1.duration_ = 2

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play924041048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1020ui_story = arg_191_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).z)
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles = arg_191_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_191_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).z)
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles = arg_191_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1020ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1020ui_story == nil then
				arg_191_1.var_.characterEffect1020ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1020ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1020ui_story then
				arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_194_4 = 0
			local var_194_5 = 0.1

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(924041047)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 4 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 4)

				if (4 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 4)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb")

						arg_191_1:RecordAudio("924041047", var_194_11)
						arg_191_1:RecordAudio("924041047", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041047", "story_v_side_old_924041.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play924041048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 924041048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play924041049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1020ui_story = arg_195_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1020ui_story"].transform.position).z)
				arg_195_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1020ui_story"].transform.localEulerAngles = arg_195_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1020ui_story"].transform.position).z)
				arg_195_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1020ui_story"].transform.localEulerAngles = arg_195_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1020ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1020ui_story == nil then
				arg_195_1.var_.characterEffect1020ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1020ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_2)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1020ui_story then
				arg_195_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_195_1.time_ and arg_195_1.time_ <= 0.034000001847744 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_141", "se_story_141_win", "")
			end

			local var_198_4 = 0
			local var_198_5 = 0.875

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(924041048).content)

				arg_195_1.text_.text = var_198_6

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_8 = 35 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_6) / 35)

				if (35 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_6) / 35)) > 0 and var_198_5 < var_198_8 then
					arg_195_1.talkMaxDuration = var_198_8

					if var_198_8 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_6
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_9 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_9 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_9

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_9 and arg_195_1.time_ < var_198_4 + var_198_9 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play924041049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 924041049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play924041050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.475

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(924041049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 19 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 19)

				if (19 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 19)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play924041050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 924041050
		arg_203_1.duration_ = 3.33

		local var_203_0 = {
			zh = 3.2,
			ja = 3.333
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play924041051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1020ui_story = arg_203_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1020ui_story"].transform.position).z)
				arg_203_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1020ui_story"].transform.localEulerAngles = arg_203_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_203_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1020ui_story"].transform.position).z)
				arg_203_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1020ui_story"].transform.localEulerAngles = arg_203_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1020ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1020ui_story == nil then
				arg_203_1.var_.characterEffect1020ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1020ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1020ui_story then
				arg_203_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action4311")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_206_4 = 0
			local var_206_5 = 0.3

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(924041050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 12 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 12)

				if (12 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 12)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb")

						arg_203_1:RecordAudio("924041050", var_206_11)
						arg_203_1:RecordAudio("924041050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041050", "story_v_side_old_924041.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play924041051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 924041051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play924041052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1020ui_story"]) and arg_207_1.var_.characterEffect1020ui_story == nil then
				arg_207_1.var_.characterEffect1020ui_story = arg_207_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1020ui_story"]) then
				if arg_207_1.var_.characterEffect1020ui_story and not isNil(arg_207_1.actors_["1020ui_story"]) then
					arg_207_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1020ui_story"]) and arg_207_1.var_.characterEffect1020ui_story then
				arg_207_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 0.475

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(924041051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 19 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 19)

				if (19 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 19)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play924041052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 924041052
		arg_211_1.duration_ = 7.8

		local var_211_0 = {
			zh = 6.1,
			ja = 7.8
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play924041053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1020ui_story"]) and arg_211_1.var_.characterEffect1020ui_story == nil then
				arg_211_1.var_.characterEffect1020ui_story = arg_211_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1020ui_story"]) then
				if arg_211_1.var_.characterEffect1020ui_story and not isNil(arg_211_1.actors_["1020ui_story"]) then
					arg_211_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1020ui_story"]) and arg_211_1.var_.characterEffect1020ui_story then
				arg_211_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_214_2 = 0
			local var_214_3 = 0.675

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(924041052)
				local var_214_5 = arg_211_1:FormatText(var_214_4.content)

				arg_211_1.text_.text = var_214_5

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_7 = 27 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 27)

				if (27 <= 0 and var_214_3 or var_214_3 * (utf8.len(var_214_5) / 27)) > 0 and var_214_3 < var_214_7 then
					arg_211_1.talkMaxDuration = var_214_7

					if var_214_7 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_7 + var_214_2
					end
				end

				arg_211_1.text_.text = var_214_5
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb")

						arg_211_1:RecordAudio("924041052", var_214_9)
						arg_211_1:RecordAudio("924041052", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041052", "story_v_side_old_924041.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_3, arg_211_1.talkMaxDuration)

			if var_214_2 <= arg_211_1.time_ and arg_211_1.time_ < var_214_2 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_2) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_2 + var_214_10 and arg_211_1.time_ < var_214_2 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play924041053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 924041053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play924041054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1020ui_story"]) and arg_215_1.var_.characterEffect1020ui_story == nil then
				arg_215_1.var_.characterEffect1020ui_story = arg_215_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1020ui_story"]) then
				if arg_215_1.var_.characterEffect1020ui_story and not isNil(arg_215_1.actors_["1020ui_story"]) then
					arg_215_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1020ui_story"]) and arg_215_1.var_.characterEffect1020ui_story then
				arg_215_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.5

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(924041053).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 20 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 20)

				if (20 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 20)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play924041054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 924041054
		arg_219_1.duration_ = 5.9

		local var_219_0 = {
			zh = 5.9,
			ja = 4.666
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play924041055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1020ui_story"]) and arg_219_1.var_.characterEffect1020ui_story == nil then
				arg_219_1.var_.characterEffect1020ui_story = arg_219_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1020ui_story"]) then
				if arg_219_1.var_.characterEffect1020ui_story and not isNil(arg_219_1.actors_["1020ui_story"]) then
					arg_219_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1020ui_story"]) and arg_219_1.var_.characterEffect1020ui_story then
				arg_219_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_222_2 = 0
			local var_222_3 = 0.525

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(924041054)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 21 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 21)

				if (21 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 21)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb")

						arg_219_1:RecordAudio("924041054", var_222_9)
						arg_219_1:RecordAudio("924041054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041054", "story_v_side_old_924041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play924041055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 924041055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play924041056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1020ui_story = arg_223_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1020ui_story"].transform.position).z)
				arg_223_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1020ui_story"].transform.localEulerAngles = arg_223_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_223_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1020ui_story"].transform.position).z)
				arg_223_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1020ui_story"].transform.localEulerAngles = arg_223_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1020ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1020ui_story == nil then
				arg_223_1.var_.characterEffect1020ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1020ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_2)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1020ui_story then
				arg_223_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_226_3 = 0
			local var_226_4 = 0.975

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_3 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_5 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(924041055).content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 39 <= 0 and var_226_4 or var_226_4 * (utf8.len(var_226_5) / 39)

				if (39 <= 0 and var_226_4 or var_226_4 * (utf8.len(var_226_5) / 39)) > 0 and var_226_4 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_3 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_3
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_8 = math.max(var_226_4, arg_223_1.talkMaxDuration)

			if var_226_3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_3 + var_226_8 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_3) / var_226_8

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_3 + var_226_8 and arg_223_1.time_ < var_226_3 + var_226_8 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play924041056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 924041056
		arg_227_1.duration_ = 3.83

		local var_227_0 = {
			zh = 1.9,
			ja = 3.833
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play924041057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.225

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1020")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:GetWordFromCfg(924041056)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 9 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 9)

				if (9 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 9)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb")

						arg_227_1:RecordAudio("924041056", var_230_6)
						arg_227_1:RecordAudio("924041056", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041056", "story_v_side_old_924041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play924041057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 924041057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play924041058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1020ui_story"]) and arg_231_1.var_.characterEffect1020ui_story == nil then
				arg_231_1.var_.characterEffect1020ui_story = arg_231_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1020ui_story"]) then
				if arg_231_1.var_.characterEffect1020ui_story and not isNil(arg_231_1.actors_["1020ui_story"]) then
					arg_231_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1020ui_story"]) and arg_231_1.var_.characterEffect1020ui_story then
				arg_231_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 0.05

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(924041057).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 2 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 2)

				if (2 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 2)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play924041058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 924041058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play924041059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1020ui_story = arg_235_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1020ui_story"].transform.position).z)
				arg_235_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1020ui_story"].transform.localEulerAngles = arg_235_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1020ui_story"].transform.position).z)
				arg_235_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1020ui_story"].transform.localEulerAngles = arg_235_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_238_1 = 0
			local var_238_2 = 0.65

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(924041058).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 26 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 26)

				if (26 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 26)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play924041059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 924041059
		arg_239_1.duration_ = 3.13

		local var_239_0 = {
			zh = 1.999999999999,
			ja = 3.133
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
				arg_239_0:Play924041060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1020ui_story = arg_239_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1020ui_story"].transform.position).z)
				arg_239_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1020ui_story"].transform.localEulerAngles = arg_239_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_239_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1020ui_story"].transform.position).z)
				arg_239_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1020ui_story"].transform.localEulerAngles = arg_239_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1020ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1020ui_story == nil then
				arg_239_1.var_.characterEffect1020ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1020ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1020ui_story then
				arg_239_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_242_4 = 0
			local var_242_5 = 0.25

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(924041059)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 10 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 10)

				if (10 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 10)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb")

						arg_239_1:RecordAudio("924041059", var_242_11)
						arg_239_1:RecordAudio("924041059", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041059", "story_v_side_old_924041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play924041060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 924041060
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play924041061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1020ui_story"]) and arg_243_1.var_.characterEffect1020ui_story == nil then
				arg_243_1.var_.characterEffect1020ui_story = arg_243_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1020ui_story"]) then
				if arg_243_1.var_.characterEffect1020ui_story and not isNil(arg_243_1.actors_["1020ui_story"]) then
					arg_243_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1020ui_story"]) and arg_243_1.var_.characterEffect1020ui_story then
				arg_243_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 0.275

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(924041060).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 11 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 11)

				if (11 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 11)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play924041061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 924041061
		arg_247_1.duration_ = 8.5

		local var_247_0 = {
			zh = 6.533,
			ja = 8.5
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
				arg_247_0:Play924041062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1020ui_story"]) and arg_247_1.var_.characterEffect1020ui_story == nil then
				arg_247_1.var_.characterEffect1020ui_story = arg_247_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1020ui_story"]) then
				if arg_247_1.var_.characterEffect1020ui_story and not isNil(arg_247_1.actors_["1020ui_story"]) then
					arg_247_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1020ui_story"]) and arg_247_1.var_.characterEffect1020ui_story then
				arg_247_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action2_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_250_2 = 0
			local var_250_3 = 0.65

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_4 = arg_247_1:GetWordFromCfg(924041061)
				local var_250_5 = arg_247_1:FormatText(var_250_4.content)

				arg_247_1.text_.text = var_250_5

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 26 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 26)

				if (26 <= 0 and var_250_3 or var_250_3 * (utf8.len(var_250_5) / 26)) > 0 and var_250_3 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_5
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb") ~= 0 then
					local var_250_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb") / 1000

					if var_250_8 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_2
					end

					if var_250_4.prefab_name ~= "" and arg_247_1.actors_[var_250_4.prefab_name] ~= nil then
						local var_250_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_4.prefab_name].transform, "story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb")

						arg_247_1:RecordAudio("924041061", var_250_9)
						arg_247_1:RecordAudio("924041061", var_250_9)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041061", "story_v_side_old_924041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play924041062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 924041062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play924041063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1020ui_story"]) and arg_251_1.var_.characterEffect1020ui_story == nil then
				arg_251_1.var_.characterEffect1020ui_story = arg_251_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1020ui_story"]) then
				if arg_251_1.var_.characterEffect1020ui_story and not isNil(arg_251_1.actors_["1020ui_story"]) then
					arg_251_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1020ui_story"]) and arg_251_1.var_.characterEffect1020ui_story then
				arg_251_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 0.6

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(924041062).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 24 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 24)

				if (24 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 24)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play924041063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 924041063
		arg_255_1.duration_ = 9.3

		local var_255_0 = {
			zh = 5.8,
			ja = 9.3
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
				arg_255_0:Play924041064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1020ui_story"]) and arg_255_1.var_.characterEffect1020ui_story == nil then
				arg_255_1.var_.characterEffect1020ui_story = arg_255_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1020ui_story"]) then
				if arg_255_1.var_.characterEffect1020ui_story and not isNil(arg_255_1.actors_["1020ui_story"]) then
					arg_255_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1020ui_story"]) and arg_255_1.var_.characterEffect1020ui_story then
				arg_255_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action426")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_258_2 = 0
			local var_258_3 = 0.525

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:GetWordFromCfg(924041063)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_7 = 21 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 21)

				if (21 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_5) / 21)) > 0 and var_258_3 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb") / 1000

					if var_258_8 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_2
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb")

						arg_255_1:RecordAudio("924041063", var_258_9)
						arg_255_1:RecordAudio("924041063", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041063", "story_v_side_old_924041.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_10 and arg_255_1.time_ < var_258_2 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play924041064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 924041064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play924041065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1020ui_story"]) and arg_259_1.var_.characterEffect1020ui_story == nil then
				arg_259_1.var_.characterEffect1020ui_story = arg_259_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1020ui_story"]) then
				if arg_259_1.var_.characterEffect1020ui_story and not isNil(arg_259_1.actors_["1020ui_story"]) then
					arg_259_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1020ui_story"]) and arg_259_1.var_.characterEffect1020ui_story then
				arg_259_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.325

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(924041064).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 13 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 13)

				if (13 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 13)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play924041065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 924041065
		arg_263_1.duration_ = 8.98

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play924041066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				local var_266_0 = arg_263_1.bgs_.STblack

				arg_263_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_1 = var_266_0:GetComponent("SpriteRenderer")

				if var_266_1 and var_266_1.sprite then
					local var_266_2 = 2 * (var_266_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_0.transform.localScale = Vector3.New(var_266_2 / var_266_1.sprite.bounds.size.y < var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x and var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x or var_266_2 / var_266_1.sprite.bounds.size.y, var_266_2 / var_266_1.sprite.bounds.size.y < var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x and var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x or var_266_2 / var_266_1.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "STblack" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_3 = 3.98343144403771

			if 3.98343144403771 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			if arg_263_1.time_ >= var_266_3 + 0.3 and arg_263_1.time_ < var_266_3 + 0.3 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_4 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_5 = 2

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_5 then
				local var_266_6 = Color.New(0, 0, 0)

				var_266_6.a = Mathf.Lerp(0, 1, (arg_263_1.time_ - var_266_4) / var_266_5)
				arg_263_1.mask_.color = var_266_6
			end

			if arg_263_1.time_ >= var_266_4 + var_266_5 and arg_263_1.time_ < var_266_4 + var_266_5 + arg_266_0 then
				local var_266_7 = Color.New(0, 0, 0)

				var_266_7.a = 1
				arg_263_1.mask_.color = var_266_7
			end

			local var_266_8 = 2

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_9 = 2

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_9 then
				local var_266_10 = Color.New(0, 0, 0)

				var_266_10.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_8) / var_266_9)
				arg_263_1.mask_.color = var_266_10
			end

			if arg_263_1.time_ >= var_266_8 + var_266_9 and arg_263_1.time_ < var_266_8 + var_266_9 + arg_266_0 then
				local var_266_11 = Color.New(0, 0, 0)

				arg_263_1.mask_.enabled = false
				var_266_11.a = 0
				arg_263_1.mask_.color = var_266_11
			end

			local var_266_12 = arg_263_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 then
				arg_263_1.var_.moveOldPos1020ui_story = var_266_12.localPosition
			end

			local var_266_13 = 0.001

			if 1.96599999815226 <= arg_263_1.time_ and arg_263_1.time_ < 1.96599999815226 + var_266_13 then
				var_266_12.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 1.96599999815226) / var_266_13)
				var_266_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_12.position).x, (manager.ui.mainCamera.transform.position - var_266_12.position).y, (manager.ui.mainCamera.transform.position - var_266_12.position).z)
				var_266_12.localEulerAngles.z = 0
				var_266_12.localEulerAngles.x = 0
				var_266_12.localEulerAngles = var_266_12.localEulerAngles
			end

			if arg_263_1.time_ >= 1.96599999815226 + var_266_13 and arg_263_1.time_ < 1.96599999815226 + var_266_13 + arg_266_0 then
				var_266_12.localPosition = Vector3.New(0, 100, 0)
				var_266_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_12.position).x, (manager.ui.mainCamera.transform.position - var_266_12.position).y, (manager.ui.mainCamera.transform.position - var_266_12.position).z)
				var_266_12.localEulerAngles.z = 0
				var_266_12.localEulerAngles.x = 0
				var_266_12.localEulerAngles = var_266_12.localEulerAngles
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_14 = 3.98343144403771
			local var_266_15 = 1.35

			if 3.98343144403771 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_16 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_16:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_17 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(924041065).content)

				arg_263_1.text_.text = var_266_17

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_19 = 54 <= 0 and var_266_15 or var_266_15 * (utf8.len(var_266_17) / 54)

				if (54 <= 0 and var_266_15 or var_266_15 * (utf8.len(var_266_17) / 54)) > 0 and var_266_15 < var_266_19 then
					arg_263_1.talkMaxDuration = var_266_19
					var_266_14 = var_266_14 + 0.3

					if var_266_19 + var_266_14 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_19 + var_266_14
					end
				end

				arg_263_1.text_.text = var_266_17
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_20 = var_266_14 + 0.3
			local var_266_21 = math.max(var_266_15, arg_263_1.talkMaxDuration)

			if var_266_14 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_20 + var_266_21 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_20) / var_266_21

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_20 + var_266_21 and arg_263_1.time_ < var_266_20 + var_266_21 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play924041066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 924041066
		arg_269_1.duration_ = 5.18

		local var_269_0 = {
			zh = 4.741,
			ja = 5.175
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
				arg_269_0:Play924041067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if arg_269_1.bgs_.X204_g == nil then
				local var_272_0 = Object.Instantiate(arg_269_1.paintGo_)

				var_272_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X204_g")
				var_272_0.name = "X204_g"
				var_272_0.transform.parent = arg_269_1.stage_.transform
				var_272_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.bgs_.X204_g = var_272_0
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				local var_272_1 = arg_269_1.bgs_.X204_g

				arg_269_1.bgs_.X204_g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_272_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_272_2 = var_272_1:GetComponent("SpriteRenderer")

				if var_272_2 and var_272_2.sprite then
					local var_272_3 = 2 * (var_272_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_272_1.transform.localScale = Vector3.New(var_272_3 / var_272_2.sprite.bounds.size.y < var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x and var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x or var_272_3 / var_272_2.sprite.bounds.size.y, var_272_3 / var_272_2.sprite.bounds.size.y < var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x and var_272_3 * manager.ui.mainCameraCom_.aspect / var_272_2.sprite.bounds.size.x or var_272_3 / var_272_2.sprite.bounds.size.y, 0)
				end

				for iter_272_0, iter_272_1 in pairs(arg_269_1.bgs_) do
					if iter_272_0 ~= "X204_g" then
						iter_272_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_272_4 = 2

			if 2 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			if arg_269_1.time_ >= var_272_4 + 0.3 and arg_269_1.time_ < var_272_4 + 0.3 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end

			local var_272_5 = 0

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.mask_.enabled = true
				arg_269_1.mask_.raycastTarget = true

				arg_269_1:SetGaussion(false)
			end

			local var_272_6 = 2

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_6 then
				local var_272_7 = Color.New(0, 0, 0)

				var_272_7.a = Mathf.Lerp(1, 0, (arg_269_1.time_ - var_272_5) / var_272_6)
				arg_269_1.mask_.color = var_272_7
			end

			if arg_269_1.time_ >= var_272_5 + var_272_6 and arg_269_1.time_ < var_272_5 + var_272_6 + arg_272_0 then
				local var_272_8 = Color.New(0, 0, 0)

				arg_269_1.mask_.enabled = false
				var_272_8.a = 0
				arg_269_1.mask_.color = var_272_8
			end

			local var_272_9 = "102003ui_story"

			if arg_269_1.actors_["102003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "102003ui_story"))) then
				local var_272_10 = Object.Instantiate(Asset.Load("Char/" .. "102003ui_story"), arg_269_1.stage_.transform)

				var_272_10.name = var_272_9
				var_272_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_[var_272_9] = var_272_10

				local var_272_11 = var_272_10:GetComponentInChildren(typeof(CharacterEffect))

				var_272_11.enabled = true

				local var_272_12 = GameObjectTools.GetOrAddComponent(var_272_10, typeof(DynamicBoneHelper))

				if var_272_12 then
					var_272_12:EnableDynamicBone(false)
				end

				arg_269_1:ShowWeapon(var_272_11.transform, false)

				arg_269_1.var_[var_272_9 .. "Animator"] = var_272_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_269_1.var_[var_272_9 .. "Animator"].applyRootMotion = true
				arg_269_1.var_[var_272_9 .. "LipSync"] = var_272_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_272_13 = arg_269_1.actors_["102003ui_story"].transform

			if 1.8 < arg_269_1.time_ and arg_269_1.time_ <= 1.8 + arg_272_0 then
				arg_269_1.var_.moveOldPos102003ui_story = var_272_13.localPosition
			end

			local var_272_14 = 0.001

			if 1.8 <= arg_269_1.time_ and arg_269_1.time_ < 1.8 + var_272_14 then
				var_272_13.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_269_1.time_ - 1.8) / var_272_14)
				var_272_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_13.position).x, (manager.ui.mainCamera.transform.position - var_272_13.position).y, (manager.ui.mainCamera.transform.position - var_272_13.position).z)
				var_272_13.localEulerAngles.z = 0
				var_272_13.localEulerAngles.x = 0
				var_272_13.localEulerAngles = var_272_13.localEulerAngles
			end

			if arg_269_1.time_ >= 1.8 + var_272_14 and arg_269_1.time_ < 1.8 + var_272_14 + arg_272_0 then
				var_272_13.localPosition = Vector3.New(0, -0.85, -6.21)
				var_272_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_272_13.position).x, (manager.ui.mainCamera.transform.position - var_272_13.position).y, (manager.ui.mainCamera.transform.position - var_272_13.position).z)
				var_272_13.localEulerAngles.z = 0
				var_272_13.localEulerAngles.x = 0
				var_272_13.localEulerAngles = var_272_13.localEulerAngles
			end

			local var_272_15 = arg_269_1.actors_["102003ui_story"]

			if 1.8 < arg_269_1.time_ and arg_269_1.time_ <= 1.8 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.characterEffect102003ui_story == nil then
				arg_269_1.var_.characterEffect102003ui_story = var_272_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_16 = 0.200000002980232

			if 1.8 <= arg_269_1.time_ and arg_269_1.time_ < 1.8 + var_272_16 and not isNil(var_272_15) then
				if arg_269_1.var_.characterEffect102003ui_story and not isNil(var_272_15) then
					arg_269_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 1.8 + var_272_16 and arg_269_1.time_ < 1.8 + var_272_16 + arg_272_0 and not isNil(var_272_15) and arg_269_1.var_.characterEffect102003ui_story then
				arg_269_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 1.8 < arg_269_1.time_ and arg_269_1.time_ <= 1.8 + arg_272_0 then
				arg_269_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 1.8 < arg_269_1.time_ and arg_269_1.time_ <= 1.8 + arg_272_0 then
				arg_269_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.166666666666667 < arg_269_1.time_ and arg_269_1.time_ <= 0.166666666666667 + arg_272_0 then
				arg_269_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_269_1.frameCnt_ <= 1 then
				arg_269_1.dialog_:SetActive(false)
			end

			local var_272_20 = 1.975
			local var_272_21 = 0.325

			if 1.975 < arg_269_1.time_ and arg_269_1.time_ <= var_272_20 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0

				arg_269_1.dialog_:SetActive(true)

				arg_269_1.dialogCg_.alpha = 0

				local var_272_22 = LeanTween.value(arg_269_1.dialog_, 0, 1, 0.3)

				var_272_22:setOnUpdate(LuaHelper.FloatAction(function(arg_273_0)
					arg_269_1.dialogCg_.alpha = arg_273_0
				end))
				var_272_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_269_1.dialog_)
					var_272_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_269_1.duration_ = arg_269_1.duration_ + 0.3

				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_23 = arg_269_1:GetWordFromCfg(924041066)
				local var_272_24 = arg_269_1:FormatText(var_272_23.content)

				arg_269_1.text_.text = var_272_24

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_26 = 13 <= 0 and var_272_21 or var_272_21 * (utf8.len(var_272_24) / 13)

				if (13 <= 0 and var_272_21 or var_272_21 * (utf8.len(var_272_24) / 13)) > 0 and var_272_21 < var_272_26 then
					arg_269_1.talkMaxDuration = var_272_26
					var_272_20 = var_272_20 + 0.3

					if var_272_26 + var_272_20 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_26 + var_272_20
					end
				end

				arg_269_1.text_.text = var_272_24
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb") ~= 0 then
					local var_272_27 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb") / 1000

					if var_272_27 + var_272_20 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_27 + var_272_20
					end

					if var_272_23.prefab_name ~= "" and arg_269_1.actors_[var_272_23.prefab_name] ~= nil then
						local var_272_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_23.prefab_name].transform, "story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb")

						arg_269_1:RecordAudio("924041066", var_272_28)
						arg_269_1:RecordAudio("924041066", var_272_28)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041066", "story_v_side_old_924041.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_29 = var_272_20 + 0.3
			local var_272_30 = math.max(var_272_21, arg_269_1.talkMaxDuration)

			if var_272_20 + 0.3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_29 + var_272_30 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_29) / var_272_30

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_29 + var_272_30 and arg_269_1.time_ < var_272_29 + var_272_30 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play924041067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 924041067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play924041068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["102003ui_story"]) and arg_275_1.var_.characterEffect102003ui_story == nil then
				arg_275_1.var_.characterEffect102003ui_story = arg_275_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["102003ui_story"]) then
				if arg_275_1.var_.characterEffect102003ui_story and not isNil(arg_275_1.actors_["102003ui_story"]) then
					arg_275_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_275_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["102003ui_story"]) and arg_275_1.var_.characterEffect102003ui_story then
				arg_275_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_275_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 0.4

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(924041067).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 16 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 16)

				if (16 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 16)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play924041068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 924041068
		arg_279_1.duration_ = 7.6

		local var_279_0 = {
			zh = 5.033,
			ja = 7.6
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play924041069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["102003ui_story"]) and arg_279_1.var_.characterEffect102003ui_story == nil then
				arg_279_1.var_.characterEffect102003ui_story = arg_279_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["102003ui_story"]) then
				if arg_279_1.var_.characterEffect102003ui_story and not isNil(arg_279_1.actors_["102003ui_story"]) then
					arg_279_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["102003ui_story"]) and arg_279_1.var_.characterEffect102003ui_story then
				arg_279_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action436")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_282_2 = 0
			local var_282_3 = 0.55

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:GetWordFromCfg(924041068)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 22 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 22)

				if (22 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 22)) > 0 and var_282_3 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb") / 1000

					if var_282_8 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_2
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb")

						arg_279_1:RecordAudio("924041068", var_282_9)
						arg_279_1:RecordAudio("924041068", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041068", "story_v_side_old_924041.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_10 and arg_279_1.time_ < var_282_2 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play924041069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 924041069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play924041070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["102003ui_story"]) and arg_283_1.var_.characterEffect102003ui_story == nil then
				arg_283_1.var_.characterEffect102003ui_story = arg_283_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["102003ui_story"]) then
				if arg_283_1.var_.characterEffect102003ui_story and not isNil(arg_283_1.actors_["102003ui_story"]) then
					arg_283_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_283_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["102003ui_story"]) and arg_283_1.var_.characterEffect102003ui_story then
				arg_283_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_283_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.475

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(924041069).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 19 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 19)

				if (19 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 19)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play924041070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 924041070
		arg_287_1.duration_ = 3.5

		local var_287_0 = {
			zh = 3.366,
			ja = 3.5
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play924041071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["102003ui_story"]) and arg_287_1.var_.characterEffect102003ui_story == nil then
				arg_287_1.var_.characterEffect102003ui_story = arg_287_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["102003ui_story"]) then
				if arg_287_1.var_.characterEffect102003ui_story and not isNil(arg_287_1.actors_["102003ui_story"]) then
					arg_287_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["102003ui_story"]) and arg_287_1.var_.characterEffect102003ui_story then
				arg_287_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action468")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_290_2 = 0
			local var_290_3 = 0.375

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(924041070)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 15 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 15)

				if (15 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 15)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb")

						arg_287_1:RecordAudio("924041070", var_290_9)
						arg_287_1:RecordAudio("924041070", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041070", "story_v_side_old_924041.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play924041071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 924041071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play924041072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["102003ui_story"]) and arg_291_1.var_.characterEffect102003ui_story == nil then
				arg_291_1.var_.characterEffect102003ui_story = arg_291_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["102003ui_story"]) then
				if arg_291_1.var_.characterEffect102003ui_story and not isNil(arg_291_1.actors_["102003ui_story"]) then
					arg_291_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_291_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["102003ui_story"]) and arg_291_1.var_.characterEffect102003ui_story then
				arg_291_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_291_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 0.25

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(924041071).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 10 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 10)

				if (10 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 10)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play924041072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 924041072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play924041073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos102003ui_story = arg_295_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["102003ui_story"].transform.position).z)
				arg_295_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["102003ui_story"].transform.localEulerAngles = arg_295_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_295_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["102003ui_story"].transform.position).z)
				arg_295_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["102003ui_story"].transform.localEulerAngles = arg_295_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_298_1 = 0
			local var_298_2 = 0.775

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(924041072).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 65 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 65)

				if (65 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 65)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play924041073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 924041073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play924041074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.05

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(924041073).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 42 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 42)

				if (42 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 42)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play924041074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 924041074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play924041075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.025

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(924041074).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 41 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 41)

				if (41 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 41)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play924041075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 924041075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play924041076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.675

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(924041075).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 27 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 27)

				if (27 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 27)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play924041076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 924041076
		arg_311_1.duration_ = 4.23

		local var_311_0 = {
			zh = 3.666,
			ja = 4.233
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play924041077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos102003ui_story = arg_311_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["102003ui_story"].transform.position).z)
				arg_311_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["102003ui_story"].transform.localEulerAngles = arg_311_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_311_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["102003ui_story"].transform.position).z)
				arg_311_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["102003ui_story"].transform.localEulerAngles = arg_311_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["102003ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect102003ui_story == nil then
				arg_311_1.var_.characterEffect102003ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect102003ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect102003ui_story then
				arg_311_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action12_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_314_4 = 0
			local var_314_5 = 0.375

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(924041076)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 15 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 15)

				if (15 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 15)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb")

						arg_311_1:RecordAudio("924041076", var_314_11)
						arg_311_1:RecordAudio("924041076", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041076", "story_v_side_old_924041.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_12 = math.max(var_314_5, arg_311_1.talkMaxDuration)

			if var_314_4 <= arg_311_1.time_ and arg_311_1.time_ < var_314_4 + var_314_12 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_4) / var_314_12

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_4 + var_314_12 and arg_311_1.time_ < var_314_4 + var_314_12 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924041077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 924041077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play924041078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["102003ui_story"]) and arg_315_1.var_.characterEffect102003ui_story == nil then
				arg_315_1.var_.characterEffect102003ui_story = arg_315_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["102003ui_story"]) then
				if arg_315_1.var_.characterEffect102003ui_story and not isNil(arg_315_1.actors_["102003ui_story"]) then
					arg_315_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_315_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["102003ui_story"]) and arg_315_1.var_.characterEffect102003ui_story then
				arg_315_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_315_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.3

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(924041077).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 12 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 12)

				if (12 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 12)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play924041078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 924041078
		arg_319_1.duration_ = 9.7

		local var_319_0 = {
			zh = 6.4,
			ja = 9.7
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play924041079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["102003ui_story"]) and arg_319_1.var_.characterEffect102003ui_story == nil then
				arg_319_1.var_.characterEffect102003ui_story = arg_319_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["102003ui_story"]) then
				if arg_319_1.var_.characterEffect102003ui_story and not isNil(arg_319_1.actors_["102003ui_story"]) then
					arg_319_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["102003ui_story"]) and arg_319_1.var_.characterEffect102003ui_story then
				arg_319_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action12_2")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_322_2 = 0
			local var_322_3 = 0.8

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_4 = arg_319_1:GetWordFromCfg(924041078)
				local var_322_5 = arg_319_1:FormatText(var_322_4.content)

				arg_319_1.text_.text = var_322_5

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_7 = 32 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 32)

				if (32 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 32)) > 0 and var_322_3 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_5
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb") / 1000

					if var_322_8 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_2
					end

					if var_322_4.prefab_name ~= "" and arg_319_1.actors_[var_322_4.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_4.prefab_name].transform, "story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb")

						arg_319_1:RecordAudio("924041078", var_322_9)
						arg_319_1:RecordAudio("924041078", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041078", "story_v_side_old_924041.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_10 and arg_319_1.time_ < var_322_2 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play924041079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 924041079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play924041080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["102003ui_story"]) and arg_323_1.var_.characterEffect102003ui_story == nil then
				arg_323_1.var_.characterEffect102003ui_story = arg_323_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["102003ui_story"]) then
				if arg_323_1.var_.characterEffect102003ui_story and not isNil(arg_323_1.actors_["102003ui_story"]) then
					arg_323_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_323_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_0)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["102003ui_story"]) and arg_323_1.var_.characterEffect102003ui_story then
				arg_323_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_323_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_326_1 = 0
			local var_326_2 = 0.225

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_3 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(924041079).content)

				arg_323_1.text_.text = var_326_3

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 9 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 9)

				if (9 <= 0 and var_326_2 or var_326_2 * (utf8.len(var_326_3) / 9)) > 0 and var_326_2 < var_326_5 then
					arg_323_1.talkMaxDuration = var_326_5

					if var_326_5 + var_326_1 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_5 + var_326_1
					end
				end

				arg_323_1.text_.text = var_326_3
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_6 = math.max(var_326_2, arg_323_1.talkMaxDuration)

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_6 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_1) / var_326_6

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_1 + var_326_6 and arg_323_1.time_ < var_326_1 + var_326_6 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play924041080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 924041080
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play924041081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos102003ui_story = arg_327_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["102003ui_story"].transform.position).z)
				arg_327_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["102003ui_story"].transform.localEulerAngles = arg_327_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["102003ui_story"].transform.position).z)
				arg_327_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["102003ui_story"].transform.localEulerAngles = arg_327_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_330_1 = 0
			local var_330_2 = 0.4

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

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(924041080).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 16 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 16)

				if (16 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 16)) > 0 and var_330_2 < var_330_5 then
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

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play924041081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 924041081
		arg_331_1.duration_ = 2.87

		local var_331_0 = {
			zh = 1.999999999999,
			ja = 2.866
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play924041082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos102003ui_story = arg_331_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["102003ui_story"].transform.position).z)
				arg_331_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["102003ui_story"].transform.localEulerAngles = arg_331_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_331_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["102003ui_story"].transform.position).z)
				arg_331_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["102003ui_story"].transform.localEulerAngles = arg_331_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_334_1 = arg_331_1.actors_["102003ui_story"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect102003ui_story == nil then
				arg_331_1.var_.characterEffect102003ui_story = var_334_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_2 and not isNil(var_334_1) then
				if arg_331_1.var_.characterEffect102003ui_story and not isNil(var_334_1) then
					arg_331_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_2 and arg_331_1.time_ < 0 + var_334_2 + arg_334_0 and not isNil(var_334_1) and arg_331_1.var_.characterEffect102003ui_story then
				arg_331_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_334_4 = 0
			local var_334_5 = 0.125

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_6 = arg_331_1:GetWordFromCfg(924041081)
				local var_334_7 = arg_331_1:FormatText(var_334_6.content)

				arg_331_1.text_.text = var_334_7

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 5 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 5)

				if (5 <= 0 and var_334_5 or var_334_5 * (utf8.len(var_334_7) / 5)) > 0 and var_334_5 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_7
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb") ~= 0 then
					local var_334_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb") / 1000

					if var_334_10 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_4
					end

					if var_334_6.prefab_name ~= "" and arg_331_1.actors_[var_334_6.prefab_name] ~= nil then
						local var_334_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_6.prefab_name].transform, "story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb")

						arg_331_1:RecordAudio("924041081", var_334_11)
						arg_331_1:RecordAudio("924041081", var_334_11)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041081", "story_v_side_old_924041.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_12 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_12 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_12

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_12 and arg_331_1.time_ < var_334_4 + var_334_12 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
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
	Play924041082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 924041082
		arg_335_1.duration_ = 9

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play924041083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 2 < arg_335_1.time_ and arg_335_1.time_ <= 2 + arg_338_0 then
				local var_338_0 = arg_335_1.bgs_.STblack

				arg_335_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_338_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_338_1 = var_338_0:GetComponent("SpriteRenderer")

				if var_338_1 and var_338_1.sprite then
					local var_338_2 = 2 * (var_338_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_338_0.transform.localScale = Vector3.New(var_338_2 / var_338_1.sprite.bounds.size.y < var_338_2 * manager.ui.mainCameraCom_.aspect / var_338_1.sprite.bounds.size.x and var_338_2 * manager.ui.mainCameraCom_.aspect / var_338_1.sprite.bounds.size.x or var_338_2 / var_338_1.sprite.bounds.size.y, var_338_2 / var_338_1.sprite.bounds.size.y < var_338_2 * manager.ui.mainCameraCom_.aspect / var_338_1.sprite.bounds.size.x and var_338_2 * manager.ui.mainCameraCom_.aspect / var_338_1.sprite.bounds.size.x or var_338_2 / var_338_1.sprite.bounds.size.y, 0)
				end

				for iter_338_0, iter_338_1 in pairs(arg_335_1.bgs_) do
					if iter_338_0 ~= "STblack" then
						iter_338_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_338_3 = 4

			if 4 < arg_335_1.time_ and arg_335_1.time_ <= var_338_3 + arg_338_0 then
				arg_335_1.allBtn_.enabled = false
			end

			if arg_335_1.time_ >= var_338_3 + 0.3 and arg_335_1.time_ < var_338_3 + 0.3 + arg_338_0 then
				arg_335_1.allBtn_.enabled = true
			end

			local var_338_4 = 0

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_5 = 2

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_5 then
				local var_338_6 = Color.New(0, 0, 0)

				var_338_6.a = Mathf.Lerp(0, 1, (arg_335_1.time_ - var_338_4) / var_338_5)
				arg_335_1.mask_.color = var_338_6
			end

			if arg_335_1.time_ >= var_338_4 + var_338_5 and arg_335_1.time_ < var_338_4 + var_338_5 + arg_338_0 then
				local var_338_7 = Color.New(0, 0, 0)

				var_338_7.a = 1
				arg_335_1.mask_.color = var_338_7
			end

			local var_338_8 = 2

			if 2 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.mask_.enabled = true
				arg_335_1.mask_.raycastTarget = true

				arg_335_1:SetGaussion(false)
			end

			local var_338_9 = 2

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_9 then
				local var_338_10 = Color.New(0, 0, 0)

				var_338_10.a = Mathf.Lerp(1, 0, (arg_335_1.time_ - var_338_8) / var_338_9)
				arg_335_1.mask_.color = var_338_10
			end

			if arg_335_1.time_ >= var_338_8 + var_338_9 and arg_335_1.time_ < var_338_8 + var_338_9 + arg_338_0 then
				local var_338_11 = Color.New(0, 0, 0)

				arg_335_1.mask_.enabled = false
				var_338_11.a = 0
				arg_335_1.mask_.color = var_338_11
			end

			local var_338_12 = arg_335_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_335_1.time_ and arg_335_1.time_ <= 1.96599999815226 + arg_338_0 then
				arg_335_1.var_.moveOldPos102003ui_story = var_338_12.localPosition
			end

			local var_338_13 = 0.001

			if 1.96599999815226 <= arg_335_1.time_ and arg_335_1.time_ < 1.96599999815226 + var_338_13 then
				var_338_12.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_335_1.time_ - 1.96599999815226) / var_338_13)
				var_338_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_12.position).x, (manager.ui.mainCamera.transform.position - var_338_12.position).y, (manager.ui.mainCamera.transform.position - var_338_12.position).z)
				var_338_12.localEulerAngles.z = 0
				var_338_12.localEulerAngles.x = 0
				var_338_12.localEulerAngles = var_338_12.localEulerAngles
			end

			if arg_335_1.time_ >= 1.96599999815226 + var_338_13 and arg_335_1.time_ < 1.96599999815226 + var_338_13 + arg_338_0 then
				var_338_12.localPosition = Vector3.New(0, 100, 0)
				var_338_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_12.position).x, (manager.ui.mainCamera.transform.position - var_338_12.position).y, (manager.ui.mainCamera.transform.position - var_338_12.position).z)
				var_338_12.localEulerAngles.z = 0
				var_338_12.localEulerAngles.x = 0
				var_338_12.localEulerAngles = var_338_12.localEulerAngles
			end

			local var_338_14 = arg_335_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_335_1.time_ and arg_335_1.time_ <= 1.96599999815226 + arg_338_0 and not isNil(var_338_14) and arg_335_1.var_.characterEffect102003ui_story == nil then
				arg_335_1.var_.characterEffect102003ui_story = var_338_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_15 = 0.034000001847744

			if 1.96599999815226 <= arg_335_1.time_ and arg_335_1.time_ < 1.96599999815226 + var_338_15 and not isNil(var_338_14) then
				if arg_335_1.var_.characterEffect102003ui_story and not isNil(var_338_14) then
					arg_335_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_335_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 1.96599999815226) / var_338_15)
				end
			end

			if arg_335_1.time_ >= 1.96599999815226 + var_338_15 and arg_335_1.time_ < 1.96599999815226 + var_338_15 + arg_338_0 and not isNil(var_338_14) and arg_335_1.var_.characterEffect102003ui_story then
				arg_335_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_335_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0.133333333333333 < arg_335_1.time_ and arg_335_1.time_ <= 0.133333333333333 + arg_338_0 then
				arg_335_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_button", "")
			end

			if 0.133333333333333 < arg_335_1.time_ and arg_335_1.time_ <= 0.133333333333333 + arg_338_0 then
				arg_335_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_338_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_335_1.bgmTxt_.text ~= var_338_19 and arg_335_1.bgmTxt_.text ~= "" then
						if arg_335_1.bgmTxt2_.text ~= "" then
							arg_335_1.bgmTxt_.text = arg_335_1.bgmTxt2_.text
						end

						arg_335_1.bgmTxt2_.text = var_338_19

						arg_335_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_335_1.bgmTxt_.text = var_338_19
						arg_335_1.bgmTxt2_.text = var_338_19
					end

					if arg_335_1.bgmTimer then
						arg_335_1.bgmTimer:Stop()

						arg_335_1.bgmTimer = nil
					end

					if arg_335_1.settingData.show_music_name == 1 then
						arg_335_1.musicController:SetSelectedState("show")
						arg_335_1.musicAnimator_:Play("open", 0, 0)

						if arg_335_1.settingData.music_time ~= 0 then
							arg_335_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_335_1.settingData.music_time), function()
								if arg_335_1 == nil or isNil(arg_335_1.bgmTxt_) then
									return
								end

								arg_335_1.musicController:SetSelectedState("hide")
								arg_335_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_335_1.frameCnt_ <= 1 then
				arg_335_1.dialog_:SetActive(false)
			end

			local var_338_20 = 4
			local var_338_21 = 0.75

			if 4 < arg_335_1.time_ and arg_335_1.time_ <= var_338_20 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0

				arg_335_1.dialog_:SetActive(true)

				arg_335_1.dialogCg_.alpha = 0

				local var_338_22 = LeanTween.value(arg_335_1.dialog_, 0, 1, 0.3)

				var_338_22:setOnUpdate(LuaHelper.FloatAction(function(arg_340_0)
					arg_335_1.dialogCg_.alpha = arg_340_0
				end))
				var_338_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_335_1.dialog_)
					var_338_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_335_1.duration_ = arg_335_1.duration_ + 0.3

				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_23 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(924041082).content)

				arg_335_1.text_.text = var_338_23

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_25 = 30 <= 0 and var_338_21 or var_338_21 * (utf8.len(var_338_23) / 30)

				if (30 <= 0 and var_338_21 or var_338_21 * (utf8.len(var_338_23) / 30)) > 0 and var_338_21 < var_338_25 then
					arg_335_1.talkMaxDuration = var_338_25
					var_338_20 = var_338_20 + 0.3

					if var_338_25 + var_338_20 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_25 + var_338_20
					end
				end

				arg_335_1.text_.text = var_338_23
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_26 = var_338_20 + 0.3
			local var_338_27 = math.max(var_338_21, arg_335_1.talkMaxDuration)

			if var_338_20 + 0.3 <= arg_335_1.time_ and arg_335_1.time_ < var_338_26 + var_338_27 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_26) / var_338_27

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_26 + var_338_27 and arg_335_1.time_ < var_338_26 + var_338_27 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play924041083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 924041083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play924041084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.6

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(924041083).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 24 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 24)

				if (24 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 24)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play924041084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 924041084
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play924041085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0.5

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_1 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(924041084).content)

				arg_346_1.text_.text = var_349_1

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_3 = 16 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 16)

				if (16 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 16)) > 0 and var_349_0 < var_349_3 then
					arg_346_1.talkMaxDuration = var_349_3

					if var_349_3 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_3 + 0
					end
				end

				arg_346_1.text_.text = var_349_1
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_4 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_4

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play924041085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 924041085
		arg_350_1.duration_ = 1.1

		local var_350_0 = {
			zh = 0.999999999999,
			ja = 1.1
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play924041086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.1

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_1 = arg_350_1:GetWordFromCfg(924041085)
				local var_353_2 = arg_350_1:FormatText(var_353_1.content)

				arg_350_1.text_.text = var_353_2

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_4 = 4 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_2) / 4)

				if (4 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_2) / 4)) > 0 and var_353_0 < var_353_4 then
					arg_350_1.talkMaxDuration = var_353_4

					if var_353_4 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_4 + 0
					end
				end

				arg_350_1.text_.text = var_353_2
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb") ~= 0 then
					local var_353_5 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb") / 1000

					if var_353_5 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_5 + 0
					end

					if var_353_1.prefab_name ~= "" and arg_350_1.actors_[var_353_1.prefab_name] ~= nil then
						local var_353_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_1.prefab_name].transform, "story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb")

						arg_350_1:RecordAudio("924041085", var_353_6)
						arg_350_1:RecordAudio("924041085", var_353_6)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041085", "story_v_side_old_924041.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_7 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_7 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_7

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_7 and arg_350_1.time_ < 0 + var_353_7 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play924041086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 924041086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play924041087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["102003ui_story"]) and arg_354_1.var_.characterEffect102003ui_story == nil then
				arg_354_1.var_.characterEffect102003ui_story = arg_354_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_0 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["102003ui_story"]) then
				if arg_354_1.var_.characterEffect102003ui_story and not isNil(arg_354_1.actors_["102003ui_story"]) then
					arg_354_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_354_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_0)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["102003ui_story"]) and arg_354_1.var_.characterEffect102003ui_story then
				arg_354_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_354_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_357_1 = 0
			local var_357_2 = 0.575

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_3 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(924041086).content)

				arg_354_1.text_.text = var_357_3

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_5 = 23 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 23)

				if (23 <= 0 and var_357_2 or var_357_2 * (utf8.len(var_357_3) / 23)) > 0 and var_357_2 < var_357_5 then
					arg_354_1.talkMaxDuration = var_357_5

					if var_357_5 + var_357_1 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_5 + var_357_1
					end
				end

				arg_354_1.text_.text = var_357_3
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_6 = math.max(var_357_2, arg_354_1.talkMaxDuration)

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_6 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_1) / var_357_6

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_1 + var_357_6 and arg_354_1.time_ < var_357_1 + var_357_6 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play924041087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 924041087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play924041088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.75

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(924041087).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 30 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 30)

				if (30 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 30)) > 0 and var_361_0 < var_361_3 then
					arg_358_1.talkMaxDuration = var_361_3

					if var_361_3 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_3 + 0
					end
				end

				arg_358_1.text_.text = var_361_1
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_4 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_4

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play924041088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 924041088
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play924041089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0.666666666666667 < arg_362_1.time_ and arg_362_1.time_ <= 0.666666666666667 + arg_365_0 then
				arg_362_1:AudioAction("play", "effect", "se_story_140", "se_story_140_snap", "")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_365_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_3 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_3

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_3
						arg_362_1.bgmTxt2_.text = var_365_3
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_362_1.time_ and arg_362_1.time_ <= 0.4 + arg_365_0 then
				arg_362_1:AudioAction("play", "music", "bgm_activity_4_0_scene_102003_story", "bgm_activity_4_0_scene_102003_story", "bgm_activity_4_0_scene_102003_story.awb")

				local var_365_6 = manager.audio:GetAudioName("bgm_activity_4_0_scene_102003_story", "bgm_activity_4_0_scene_102003_story")

				if "" ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_6 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_6

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_6
						arg_362_1.bgmTxt2_.text = var_365_6
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_365_7 = 0
			local var_365_8 = 0.5

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_7 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_9 = arg_362_1:FormatText(arg_362_1:GetWordFromCfg(924041088).content)

				arg_362_1.text_.text = var_365_9

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_11 = 20 <= 0 and var_365_8 or var_365_8 * (utf8.len(var_365_9) / 20)

				if (20 <= 0 and var_365_8 or var_365_8 * (utf8.len(var_365_9) / 20)) > 0 and var_365_8 < var_365_11 then
					arg_362_1.talkMaxDuration = var_365_11

					if var_365_11 + var_365_7 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_11 + var_365_7
					end
				end

				arg_362_1.text_.text = var_365_9
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_12 = math.max(var_365_8, arg_362_1.talkMaxDuration)

			if var_365_7 <= arg_362_1.time_ and arg_362_1.time_ < var_365_7 + var_365_12 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_7) / var_365_12

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_7 + var_365_12 and arg_362_1.time_ < var_365_7 + var_365_12 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play924041089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 924041089
		arg_368_1.duration_ = 7

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play924041090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if arg_368_1.bgs_.ST0107 == nil then
				local var_371_0 = Object.Instantiate(arg_368_1.paintGo_)

				var_371_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0107")
				var_371_0.name = "ST0107"
				var_371_0.transform.parent = arg_368_1.stage_.transform
				var_371_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_368_1.bgs_.ST0107 = var_371_0
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				local var_371_1 = arg_368_1.bgs_.ST0107

				arg_368_1.bgs_.ST0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_371_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_371_2 = var_371_1:GetComponent("SpriteRenderer")

				if var_371_2 and var_371_2.sprite then
					local var_371_3 = 2 * (var_371_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_371_1.transform.localScale = Vector3.New(var_371_3 / var_371_2.sprite.bounds.size.y < var_371_3 * manager.ui.mainCameraCom_.aspect / var_371_2.sprite.bounds.size.x and var_371_3 * manager.ui.mainCameraCom_.aspect / var_371_2.sprite.bounds.size.x or var_371_3 / var_371_2.sprite.bounds.size.y, var_371_3 / var_371_2.sprite.bounds.size.y < var_371_3 * manager.ui.mainCameraCom_.aspect / var_371_2.sprite.bounds.size.x and var_371_3 * manager.ui.mainCameraCom_.aspect / var_371_2.sprite.bounds.size.x or var_371_3 / var_371_2.sprite.bounds.size.y, 0)
				end

				for iter_371_0, iter_371_1 in pairs(arg_368_1.bgs_) do
					if iter_371_0 ~= "ST0107" then
						iter_371_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_371_4 = 2

			if 2 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.allBtn_.enabled = false
			end

			if arg_368_1.time_ >= var_371_4 + 0.3 and arg_368_1.time_ < var_371_4 + 0.3 + arg_371_0 then
				arg_368_1.allBtn_.enabled = true
			end

			local var_371_5 = 0

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_5 + arg_371_0 then
				arg_368_1.mask_.enabled = true
				arg_368_1.mask_.raycastTarget = true

				arg_368_1:SetGaussion(false)
			end

			local var_371_6 = 2

			if var_371_5 <= arg_368_1.time_ and arg_368_1.time_ < var_371_5 + var_371_6 then
				local var_371_7 = Color.New(0, 0, 0)

				var_371_7.a = Mathf.Lerp(1, 0, (arg_368_1.time_ - var_371_5) / var_371_6)
				arg_368_1.mask_.color = var_371_7
			end

			if arg_368_1.time_ >= var_371_5 + var_371_6 and arg_368_1.time_ < var_371_5 + var_371_6 + arg_371_0 then
				local var_371_8 = Color.New(0, 0, 0)

				arg_368_1.mask_.enabled = false
				var_371_8.a = 0
				arg_368_1.mask_.color = var_371_8
			end

			if 0.125 < arg_368_1.time_ and arg_368_1.time_ <= 0.125 + arg_371_0 then
				arg_368_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night", "")
			end

			if 0.125 < arg_368_1.time_ and arg_368_1.time_ <= 0.125 + arg_371_0 then
				arg_368_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if arg_368_1.frameCnt_ <= 1 then
				arg_368_1.dialog_:SetActive(false)
			end

			local var_371_11 = 2
			local var_371_12 = 1.125

			if 2 < arg_368_1.time_ and arg_368_1.time_ <= var_371_11 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0

				arg_368_1.dialog_:SetActive(true)

				arg_368_1.dialogCg_.alpha = 0

				local var_371_13 = LeanTween.value(arg_368_1.dialog_, 0, 1, 0.3)

				var_371_13:setOnUpdate(LuaHelper.FloatAction(function(arg_372_0)
					arg_368_1.dialogCg_.alpha = arg_372_0
				end))
				var_371_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_368_1.dialog_)
					var_371_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_368_1.duration_ = arg_368_1.duration_ + 0.3

				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_14 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(924041089).content)

				arg_368_1.text_.text = var_371_14

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_16 = 45 <= 0 and var_371_12 or var_371_12 * (utf8.len(var_371_14) / 45)

				if (45 <= 0 and var_371_12 or var_371_12 * (utf8.len(var_371_14) / 45)) > 0 and var_371_12 < var_371_16 then
					arg_368_1.talkMaxDuration = var_371_16
					var_371_11 = var_371_11 + 0.3

					if var_371_16 + var_371_11 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_16 + var_371_11
					end
				end

				arg_368_1.text_.text = var_371_14
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_17 = var_371_11 + 0.3
			local var_371_18 = math.max(var_371_12, arg_368_1.talkMaxDuration)

			if var_371_11 + 0.3 <= arg_368_1.time_ and arg_368_1.time_ < var_371_17 + var_371_18 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_17) / var_371_18

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_17 + var_371_18 and arg_368_1.time_ < var_371_17 + var_371_18 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play924041090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 924041090
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play924041091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 1.375

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(924041090).content)

				arg_374_1.text_.text = var_377_1

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_3 = 55 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 55)

				if (55 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 55)) > 0 and var_377_0 < var_377_3 then
					arg_374_1.talkMaxDuration = var_377_3

					if var_377_3 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_3 + 0
					end
				end

				arg_374_1.text_.text = var_377_1
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_4 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_4

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play924041091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 924041091
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play924041092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.95

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_1 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(924041091).content)

				arg_378_1.text_.text = var_381_1

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_3 = 38 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_1) / 38)

				if (38 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_1) / 38)) > 0 and var_381_0 < var_381_3 then
					arg_378_1.talkMaxDuration = var_381_3

					if var_381_3 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_3 + 0
					end
				end

				arg_378_1.text_.text = var_381_1
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_4 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_4 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_4

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_4 and arg_378_1.time_ < 0 + var_381_4 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play924041092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 924041092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play924041093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 1.425

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_1 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(924041092).content)

				arg_382_1.text_.text = var_385_1

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_3 = 57 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 57)

				if (57 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 57)) > 0 and var_385_0 < var_385_3 then
					arg_382_1.talkMaxDuration = var_385_3

					if var_385_3 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_3 + 0
					end
				end

				arg_382_1.text_.text = var_385_1
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_4 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_4

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play924041093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 924041093
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play924041094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.725

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(924041093).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 29 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 29)

				if (29 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 29)) > 0 and var_389_0 < var_389_3 then
					arg_386_1.talkMaxDuration = var_389_3

					if var_389_3 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_3 + 0
					end
				end

				arg_386_1.text_.text = var_389_1
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_4 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_4

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play924041094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 924041094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play924041095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 1.15

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(924041094).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 46 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 46)

				if (46 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 46)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play924041095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 924041095
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play924041096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 1.025

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(924041095).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 41 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 41)

				if (41 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 41)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play924041096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 924041096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play924041097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 1.525

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_1 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(924041096).content)

				arg_398_1.text_.text = var_401_1

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_3 = 61 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 61)

				if (61 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 61)) > 0 and var_401_0 < var_401_3 then
					arg_398_1.talkMaxDuration = var_401_3

					if var_401_3 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_3 + 0
					end
				end

				arg_398_1.text_.text = var_401_1
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_4 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_4 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_4

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_4 and arg_398_1.time_ < 0 + var_401_4 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play924041097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 924041097
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play924041098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.25

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(924041097).content)

				arg_402_1.text_.text = var_405_1

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_3 = 10 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 10)

				if (10 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 10)) > 0 and var_405_0 < var_405_3 then
					arg_402_1.talkMaxDuration = var_405_3

					if var_405_3 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_3 + 0
					end
				end

				arg_402_1.text_.text = var_405_1
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_4 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_4

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play924041098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 924041098
		arg_406_1.duration_ = 5

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play924041099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 1.425

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:FormatText(arg_406_1:GetWordFromCfg(924041098).content)

				arg_406_1.text_.text = var_409_1

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_3 = 57 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_1) / 57)

				if (57 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_1) / 57)) > 0 and var_409_0 < var_409_3 then
					arg_406_1.talkMaxDuration = var_409_3

					if var_409_3 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_3 + 0
					end
				end

				arg_406_1.text_.text = var_409_1
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_4 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_4 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_4

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_4 and arg_406_1.time_ < 0 + var_409_4 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play924041099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 924041099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play924041100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0.775

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_1 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(924041099).content)

				arg_410_1.text_.text = var_413_1

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_3 = 31 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 31)

				if (31 <= 0 and var_413_0 or var_413_0 * (utf8.len(var_413_1) / 31)) > 0 and var_413_0 < var_413_3 then
					arg_410_1.talkMaxDuration = var_413_3

					if var_413_3 + 0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_3 + 0
					end
				end

				arg_410_1.text_.text = var_413_1
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_4 = math.max(var_413_0, arg_410_1.talkMaxDuration)

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_4 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - 0) / var_413_4

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= 0 + var_413_4 and arg_410_1.time_ < 0 + var_413_4 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play924041100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 924041100
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play924041101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0.75

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_1 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(924041100).content)

				arg_414_1.text_.text = var_417_1

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_3 = 30 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 30)

				if (30 <= 0 and var_417_0 or var_417_0 * (utf8.len(var_417_1) / 30)) > 0 and var_417_0 < var_417_3 then
					arg_414_1.talkMaxDuration = var_417_3

					if var_417_3 + 0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_3 + 0
					end
				end

				arg_414_1.text_.text = var_417_1
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_4 = math.max(var_417_0, arg_414_1.talkMaxDuration)

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_4 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - 0) / var_417_4

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= 0 + var_417_4 and arg_414_1.time_ < 0 + var_417_4 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play924041101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 924041101
		arg_418_1.duration_ = 5.73

		local var_418_0 = {
			zh = 5.633,
			ja = 5.733
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play924041102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if arg_418_1.bgs_.SP92401 == nil then
				local var_421_0 = Object.Instantiate(arg_418_1.paintGo_)

				var_421_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP92401")
				var_421_0.name = "SP92401"
				var_421_0.transform.parent = arg_418_1.stage_.transform
				var_421_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_418_1.bgs_.SP92401 = var_421_0
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				local var_421_1 = arg_418_1.bgs_.SP92401

				arg_418_1.bgs_.SP92401.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_421_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_421_2 = var_421_1:GetComponent("SpriteRenderer")

				if var_421_2 and var_421_2.sprite then
					local var_421_3 = 2 * (var_421_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_421_1.transform.localScale = Vector3.New(var_421_3 / var_421_2.sprite.bounds.size.y < var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x and var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x or var_421_3 / var_421_2.sprite.bounds.size.y, var_421_3 / var_421_2.sprite.bounds.size.y < var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x and var_421_3 * manager.ui.mainCameraCom_.aspect / var_421_2.sprite.bounds.size.x or var_421_3 / var_421_2.sprite.bounds.size.y, 0)
				end

				for iter_421_0, iter_421_1 in pairs(arg_418_1.bgs_) do
					if iter_421_0 ~= "SP92401" then
						iter_421_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_421_4 = 2

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1.allBtn_.enabled = false
			end

			if arg_418_1.time_ >= var_421_4 + 0.3 and arg_418_1.time_ < var_421_4 + 0.3 + arg_421_0 then
				arg_418_1.allBtn_.enabled = true
			end

			local var_421_5 = 0

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_5 + arg_421_0 then
				arg_418_1.mask_.enabled = true
				arg_418_1.mask_.raycastTarget = true

				arg_418_1:SetGaussion(false)
			end

			local var_421_6 = 2

			if var_421_5 <= arg_418_1.time_ and arg_418_1.time_ < var_421_5 + var_421_6 then
				local var_421_7 = Color.New(0, 0, 0)

				var_421_7.a = Mathf.Lerp(1, 0, (arg_418_1.time_ - var_421_5) / var_421_6)
				arg_418_1.mask_.color = var_421_7
			end

			if arg_418_1.time_ >= var_421_5 + var_421_6 and arg_418_1.time_ < var_421_5 + var_421_6 + arg_421_0 then
				local var_421_8 = Color.New(0, 0, 0)

				arg_418_1.mask_.enabled = false
				var_421_8.a = 0
				arg_418_1.mask_.color = var_421_8
			end

			if 5.55111512312578e-17 < arg_418_1.time_ and arg_418_1.time_ <= 5.55111512312578e-17 + arg_421_0 then
				arg_418_1:AudioAction("play", "effect", "se_story_141", "se_story_141_firework", "")
			end

			if arg_418_1.frameCnt_ <= 1 then
				arg_418_1.dialog_:SetActive(false)
			end

			local var_421_10 = 2
			local var_421_11 = 0.3

			if 2 < arg_418_1.time_ and arg_418_1.time_ <= var_421_10 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0

				arg_418_1.dialog_:SetActive(true)

				arg_418_1.dialogCg_.alpha = 0

				local var_421_12 = LeanTween.value(arg_418_1.dialog_, 0, 1, 0.3)

				var_421_12:setOnUpdate(LuaHelper.FloatAction(function(arg_422_0)
					arg_418_1.dialogCg_.alpha = arg_422_0
				end))
				var_421_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_418_1.dialog_)
					var_421_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_418_1.duration_ = arg_418_1.duration_ + 0.3

				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_13 = arg_418_1:GetWordFromCfg(924041101)
				local var_421_14 = arg_418_1:FormatText(var_421_13.content)

				arg_418_1.text_.text = var_421_14

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_16 = 12 <= 0 and var_421_11 or var_421_11 * (utf8.len(var_421_14) / 12)

				if (12 <= 0 and var_421_11 or var_421_11 * (utf8.len(var_421_14) / 12)) > 0 and var_421_11 < var_421_16 then
					arg_418_1.talkMaxDuration = var_421_16
					var_421_10 = var_421_10 + 0.3

					if var_421_16 + var_421_10 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_16 + var_421_10
					end
				end

				arg_418_1.text_.text = var_421_14
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb") ~= 0 then
					local var_421_17 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb") / 1000

					if var_421_17 + var_421_10 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_17 + var_421_10
					end

					if var_421_13.prefab_name ~= "" and arg_418_1.actors_[var_421_13.prefab_name] ~= nil then
						local var_421_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_13.prefab_name].transform, "story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb")

						arg_418_1:RecordAudio("924041101", var_421_18)
						arg_418_1:RecordAudio("924041101", var_421_18)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041101", "story_v_side_old_924041.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_19 = var_421_10 + 0.3
			local var_421_20 = math.max(var_421_11, arg_418_1.talkMaxDuration)

			if var_421_10 + 0.3 <= arg_418_1.time_ and arg_418_1.time_ < var_421_19 + var_421_20 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_19) / var_421_20

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_19 + var_421_20 and arg_418_1.time_ < var_421_19 + var_421_20 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play924041102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 924041102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play924041103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(arg_424_1.actors_["102003ui_story"]) and arg_424_1.var_.characterEffect102003ui_story == nil then
				arg_424_1.var_.characterEffect102003ui_story = arg_424_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_0 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 and not isNil(arg_424_1.actors_["102003ui_story"]) then
				if arg_424_1.var_.characterEffect102003ui_story and not isNil(arg_424_1.actors_["102003ui_story"]) then
					arg_424_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_424_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_0)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 and not isNil(arg_424_1.actors_["102003ui_story"]) and arg_424_1.var_.characterEffect102003ui_story then
				arg_424_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_424_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_427_1 = 0
			local var_427_2 = 0.475

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_3 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(924041102).content)

				arg_424_1.text_.text = var_427_3

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_5 = 19 <= 0 and var_427_2 or var_427_2 * (utf8.len(var_427_3) / 19)

				if (19 <= 0 and var_427_2 or var_427_2 * (utf8.len(var_427_3) / 19)) > 0 and var_427_2 < var_427_5 then
					arg_424_1.talkMaxDuration = var_427_5

					if var_427_5 + var_427_1 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + var_427_1
					end
				end

				arg_424_1.text_.text = var_427_3
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_6 = math.max(var_427_2, arg_424_1.talkMaxDuration)

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_6 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_1) / var_427_6

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_1 + var_427_6 and arg_424_1.time_ < var_427_1 + var_427_6 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play924041103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 924041103
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play924041104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.65

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_1 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(924041103).content)

				arg_428_1.text_.text = var_431_1

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_3 = 26 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 26)

				if (26 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 26)) > 0 and var_431_0 < var_431_3 then
					arg_428_1.talkMaxDuration = var_431_3

					if var_431_3 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_3 + 0
					end
				end

				arg_428_1.text_.text = var_431_1
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_4 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_4 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_4

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_4 and arg_428_1.time_ < 0 + var_431_4 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play924041104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 924041104
		arg_432_1.duration_ = 2

		local var_432_0 = {
			zh = 2,
			ja = 1.5
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play924041105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["102003ui_story"]) and arg_432_1.var_.characterEffect102003ui_story == nil then
				arg_432_1.var_.characterEffect102003ui_story = arg_432_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["102003ui_story"]) then
				if arg_432_1.var_.characterEffect102003ui_story and not isNil(arg_432_1.actors_["102003ui_story"]) then
					arg_432_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["102003ui_story"]) and arg_432_1.var_.characterEffect102003ui_story then
				arg_432_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_435_2 = 0
			local var_435_3 = 0.05

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_2 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_4 = arg_432_1:GetWordFromCfg(924041104)
				local var_435_5 = arg_432_1:FormatText(var_435_4.content)

				arg_432_1.text_.text = var_435_5

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_7 = 2 <= 0 and var_435_3 or var_435_3 * (utf8.len(var_435_5) / 2)

				if (2 <= 0 and var_435_3 or var_435_3 * (utf8.len(var_435_5) / 2)) > 0 and var_435_3 < var_435_7 then
					arg_432_1.talkMaxDuration = var_435_7

					if var_435_7 + var_435_2 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_7 + var_435_2
					end
				end

				arg_432_1.text_.text = var_435_5
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb") ~= 0 then
					local var_435_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb") / 1000

					if var_435_8 + var_435_2 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_8 + var_435_2
					end

					if var_435_4.prefab_name ~= "" and arg_432_1.actors_[var_435_4.prefab_name] ~= nil then
						local var_435_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_4.prefab_name].transform, "story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb")

						arg_432_1:RecordAudio("924041104", var_435_9)
						arg_432_1:RecordAudio("924041104", var_435_9)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041104", "story_v_side_old_924041.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_10 = math.max(var_435_3, arg_432_1.talkMaxDuration)

			if var_435_2 <= arg_432_1.time_ and arg_432_1.time_ < var_435_2 + var_435_10 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_2) / var_435_10

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_2 + var_435_10 and arg_432_1.time_ < var_435_2 + var_435_10 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play924041105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 924041105
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play924041106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(arg_436_1.actors_["102003ui_story"]) and arg_436_1.var_.characterEffect102003ui_story == nil then
				arg_436_1.var_.characterEffect102003ui_story = arg_436_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_0 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 and not isNil(arg_436_1.actors_["102003ui_story"]) then
				if arg_436_1.var_.characterEffect102003ui_story and not isNil(arg_436_1.actors_["102003ui_story"]) then
					arg_436_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_436_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_436_1.time_ - 0) / var_439_0)
				end
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 and not isNil(arg_436_1.actors_["102003ui_story"]) and arg_436_1.var_.characterEffect102003ui_story then
				arg_436_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_436_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_439_1 = 0
			local var_439_2 = 0.725

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_3 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(924041105).content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_5 = 29 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 29)

				if (29 <= 0 and var_439_2 or var_439_2 * (utf8.len(var_439_3) / 29)) > 0 and var_439_2 < var_439_5 then
					arg_436_1.talkMaxDuration = var_439_5

					if var_439_5 + var_439_1 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + var_439_1
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_6 = math.max(var_439_2, arg_436_1.talkMaxDuration)

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_6 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_1) / var_439_6

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_1 + var_439_6 and arg_436_1.time_ < var_439_1 + var_439_6 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play924041106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 924041106
		arg_440_1.duration_ = 1.47

		local var_440_0 = {
			zh = 1.033,
			ja = 1.466
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
				arg_440_0:Play924041107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["102003ui_story"]) and arg_440_1.var_.characterEffect102003ui_story == nil then
				arg_440_1.var_.characterEffect102003ui_story = arg_440_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_0 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["102003ui_story"]) then
				if arg_440_1.var_.characterEffect102003ui_story and not isNil(arg_440_1.actors_["102003ui_story"]) then
					arg_440_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["102003ui_story"]) and arg_440_1.var_.characterEffect102003ui_story then
				arg_440_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_443_2 = 0
			local var_443_3 = 0.05

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_2 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_4 = arg_440_1:GetWordFromCfg(924041106)
				local var_443_5 = arg_440_1:FormatText(var_443_4.content)

				arg_440_1.text_.text = var_443_5

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_7 = 2 <= 0 and var_443_3 or var_443_3 * (utf8.len(var_443_5) / 2)

				if (2 <= 0 and var_443_3 or var_443_3 * (utf8.len(var_443_5) / 2)) > 0 and var_443_3 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_2 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_2
					end
				end

				arg_440_1.text_.text = var_443_5
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb") ~= 0 then
					local var_443_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb") / 1000

					if var_443_8 + var_443_2 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_8 + var_443_2
					end

					if var_443_4.prefab_name ~= "" and arg_440_1.actors_[var_443_4.prefab_name] ~= nil then
						local var_443_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_4.prefab_name].transform, "story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb")

						arg_440_1:RecordAudio("924041106", var_443_9)
						arg_440_1:RecordAudio("924041106", var_443_9)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041106", "story_v_side_old_924041.awb")
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
	Play924041107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 924041107
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play924041108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["102003ui_story"]) and arg_444_1.var_.characterEffect102003ui_story == nil then
				arg_444_1.var_.characterEffect102003ui_story = arg_444_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_0 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["102003ui_story"]) then
				if arg_444_1.var_.characterEffect102003ui_story and not isNil(arg_444_1.actors_["102003ui_story"]) then
					arg_444_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_444_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_0)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["102003ui_story"]) and arg_444_1.var_.characterEffect102003ui_story then
				arg_444_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_444_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_447_1 = 0
			local var_447_2 = 0.225

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

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_3 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(924041107).content)

				arg_444_1.text_.text = var_447_3

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 9 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_3) / 9)

				if (9 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_3) / 9)) > 0 and var_447_2 < var_447_5 then
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
	Play924041108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 924041108
		arg_448_1.duration_ = 1.3

		local var_448_0 = {
			zh = 1.3,
			ja = 1.133
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play924041109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(arg_448_1.actors_["102003ui_story"]) and arg_448_1.var_.characterEffect102003ui_story == nil then
				arg_448_1.var_.characterEffect102003ui_story = arg_448_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_0 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 and not isNil(arg_448_1.actors_["102003ui_story"]) then
				if arg_448_1.var_.characterEffect102003ui_story and not isNil(arg_448_1.actors_["102003ui_story"]) then
					arg_448_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 and not isNil(arg_448_1.actors_["102003ui_story"]) and arg_448_1.var_.characterEffect102003ui_story then
				arg_448_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_451_2 = 0
			local var_451_3 = 0.15

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_2 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_4 = arg_448_1:GetWordFromCfg(924041108)
				local var_451_5 = arg_448_1:FormatText(var_451_4.content)

				arg_448_1.text_.text = var_451_5

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_7 = 6 <= 0 and var_451_3 or var_451_3 * (utf8.len(var_451_5) / 6)

				if (6 <= 0 and var_451_3 or var_451_3 * (utf8.len(var_451_5) / 6)) > 0 and var_451_3 < var_451_7 then
					arg_448_1.talkMaxDuration = var_451_7

					if var_451_7 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_7 + var_451_2
					end
				end

				arg_448_1.text_.text = var_451_5
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb") ~= 0 then
					local var_451_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb") / 1000

					if var_451_8 + var_451_2 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_8 + var_451_2
					end

					if var_451_4.prefab_name ~= "" and arg_448_1.actors_[var_451_4.prefab_name] ~= nil then
						local var_451_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_4.prefab_name].transform, "story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb")

						arg_448_1:RecordAudio("924041108", var_451_9)
						arg_448_1:RecordAudio("924041108", var_451_9)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041108", "story_v_side_old_924041.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_10 = math.max(var_451_3, arg_448_1.talkMaxDuration)

			if var_451_2 <= arg_448_1.time_ and arg_448_1.time_ < var_451_2 + var_451_10 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_2) / var_451_10

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_2 + var_451_10 and arg_448_1.time_ < var_451_2 + var_451_10 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play924041109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 924041109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play924041110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["102003ui_story"]) and arg_452_1.var_.characterEffect102003ui_story == nil then
				arg_452_1.var_.characterEffect102003ui_story = arg_452_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_0 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["102003ui_story"]) then
				if arg_452_1.var_.characterEffect102003ui_story and not isNil(arg_452_1.actors_["102003ui_story"]) then
					arg_452_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_452_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_0)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["102003ui_story"]) and arg_452_1.var_.characterEffect102003ui_story then
				arg_452_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_452_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_455_1 = 0
			local var_455_2 = 0.275

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_3 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(924041109).content)

				arg_452_1.text_.text = var_455_3

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 11 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 11)

				if (11 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 11)) > 0 and var_455_2 < var_455_5 then
					arg_452_1.talkMaxDuration = var_455_5

					if var_455_5 + var_455_1 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + var_455_1
					end
				end

				arg_452_1.text_.text = var_455_3
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_6 = math.max(var_455_2, arg_452_1.talkMaxDuration)

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_6 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_1) / var_455_6

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_1 + var_455_6 and arg_452_1.time_ < var_455_1 + var_455_6 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play924041110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 924041110
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play924041111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if arg_456_1.bgs_.SP92401b == nil then
				local var_459_0 = Object.Instantiate(arg_456_1.paintGo_)

				var_459_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP92401b")
				var_459_0.name = "SP92401b"
				var_459_0.transform.parent = arg_456_1.stage_.transform
				var_459_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_456_1.bgs_.SP92401b = var_459_0
			end

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				local var_459_1 = arg_456_1.bgs_.SP92401b

				arg_456_1.bgs_.SP92401b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_459_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_459_2 = var_459_1:GetComponent("SpriteRenderer")

				if var_459_2 and var_459_2.sprite then
					local var_459_3 = 2 * (var_459_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_459_1.transform.localScale = Vector3.New(var_459_3 / var_459_2.sprite.bounds.size.y < var_459_3 * manager.ui.mainCameraCom_.aspect / var_459_2.sprite.bounds.size.x and var_459_3 * manager.ui.mainCameraCom_.aspect / var_459_2.sprite.bounds.size.x or var_459_3 / var_459_2.sprite.bounds.size.y, var_459_3 / var_459_2.sprite.bounds.size.y < var_459_3 * manager.ui.mainCameraCom_.aspect / var_459_2.sprite.bounds.size.x and var_459_3 * manager.ui.mainCameraCom_.aspect / var_459_2.sprite.bounds.size.x or var_459_3 / var_459_2.sprite.bounds.size.y, 0)
				end

				for iter_459_0, iter_459_1 in pairs(arg_456_1.bgs_) do
					if iter_459_0 ~= "SP92401b" then
						iter_459_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_459_4 = 0

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_4 + arg_459_0 then
				arg_456_1.allBtn_.enabled = false
			end

			if arg_456_1.time_ >= var_459_4 + 0.3 and arg_456_1.time_ < var_459_4 + 0.3 + arg_459_0 then
				arg_456_1.allBtn_.enabled = true
			end

			local var_459_5 = 0

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_5 + arg_459_0 then
				arg_456_1.mask_.enabled = true
				arg_456_1.mask_.raycastTarget = true

				arg_456_1:SetGaussion(false)
			end

			local var_459_6 = 2

			if var_459_5 <= arg_456_1.time_ and arg_456_1.time_ < var_459_5 + var_459_6 then
				local var_459_7 = Color.New(0, 0, 0)

				var_459_7.a = Mathf.Lerp(1, 0, (arg_456_1.time_ - var_459_5) / var_459_6)
				arg_456_1.mask_.color = var_459_7
			end

			if arg_456_1.time_ >= var_459_5 + var_459_6 and arg_456_1.time_ < var_459_5 + var_459_6 + arg_459_0 then
				local var_459_8 = Color.New(0, 0, 0)

				arg_456_1.mask_.enabled = false
				var_459_8.a = 0
				arg_456_1.mask_.color = var_459_8
			end

			local var_459_9 = 0
			local var_459_10 = 1.275

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_9 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0

				arg_456_1.dialog_:SetActive(true)

				arg_456_1.dialogCg_.alpha = 0

				local var_459_11 = LeanTween.value(arg_456_1.dialog_, 0, 1, 0.3)

				var_459_11:setOnUpdate(LuaHelper.FloatAction(function(arg_460_0)
					arg_456_1.dialogCg_.alpha = arg_460_0
				end))
				var_459_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_456_1.dialog_)
					var_459_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_456_1.duration_ = arg_456_1.duration_ + 0.3

				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_12 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(924041110).content)

				arg_456_1.text_.text = var_459_12

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_14 = 51 <= 0 and var_459_10 or var_459_10 * (utf8.len(var_459_12) / 51)

				if (51 <= 0 and var_459_10 or var_459_10 * (utf8.len(var_459_12) / 51)) > 0 and var_459_10 < var_459_14 then
					arg_456_1.talkMaxDuration = var_459_14
					var_459_9 = var_459_9 + 0.3

					if var_459_14 + var_459_9 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_14 + var_459_9
					end
				end

				arg_456_1.text_.text = var_459_12
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_15 = var_459_9 + 0.3
			local var_459_16 = math.max(var_459_10, arg_456_1.talkMaxDuration)

			if var_459_9 + 0.3 <= arg_456_1.time_ and arg_456_1.time_ < var_459_15 + var_459_16 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_15) / var_459_16

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_15 + var_459_16 and arg_456_1.time_ < var_459_15 + var_459_16 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play924041111 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 924041111
		arg_462_1.duration_ = 4.77

		local var_462_0 = {
			zh = 4.766,
			ja = 3.3
		}
		local var_462_1 = manager.audio:GetLocalizationFlag()

		if var_462_0[var_462_1] ~= nil then
			arg_462_1.duration_ = var_462_0[var_462_1]
		end

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play924041112(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 and not isNil(arg_462_1.actors_["102003ui_story"]) and arg_462_1.var_.characterEffect102003ui_story == nil then
				arg_462_1.var_.characterEffect102003ui_story = arg_462_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_465_0 = 0.200000002980232

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_0 and not isNil(arg_462_1.actors_["102003ui_story"]) then
				if arg_462_1.var_.characterEffect102003ui_story and not isNil(arg_462_1.actors_["102003ui_story"]) then
					arg_462_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_462_1.time_ >= 0 + var_465_0 and arg_462_1.time_ < 0 + var_465_0 + arg_465_0 and not isNil(arg_462_1.actors_["102003ui_story"]) and arg_462_1.var_.characterEffect102003ui_story then
				arg_462_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_465_2 = 0
			local var_465_3 = 0.325

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_2 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				arg_462_1.leftNameTxt_.text = arg_462_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_4 = arg_462_1:GetWordFromCfg(924041111)
				local var_465_5 = arg_462_1:FormatText(var_465_4.content)

				arg_462_1.text_.text = var_465_5

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_7 = 13 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 13)

				if (13 <= 0 and var_465_3 or var_465_3 * (utf8.len(var_465_5) / 13)) > 0 and var_465_3 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_2
					end
				end

				arg_462_1.text_.text = var_465_5
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb") ~= 0 then
					local var_465_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb") / 1000

					if var_465_8 + var_465_2 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_8 + var_465_2
					end

					if var_465_4.prefab_name ~= "" and arg_462_1.actors_[var_465_4.prefab_name] ~= nil then
						local var_465_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_462_1.actors_[var_465_4.prefab_name].transform, "story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb")

						arg_462_1:RecordAudio("924041111", var_465_9)
						arg_462_1:RecordAudio("924041111", var_465_9)
					else
						arg_462_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb")
					end

					arg_462_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041111", "story_v_side_old_924041.awb")
				end

				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_10 = math.max(var_465_3, arg_462_1.talkMaxDuration)

			if var_465_2 <= arg_462_1.time_ and arg_462_1.time_ < var_465_2 + var_465_10 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_2) / var_465_10

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_2 + var_465_10 and arg_462_1.time_ < var_465_2 + var_465_10 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play924041112 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 924041112
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play924041113(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["102003ui_story"]) and arg_466_1.var_.characterEffect102003ui_story == nil then
				arg_466_1.var_.characterEffect102003ui_story = arg_466_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["102003ui_story"]) then
				if arg_466_1.var_.characterEffect102003ui_story and not isNil(arg_466_1.actors_["102003ui_story"]) then
					arg_466_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_466_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_466_1.time_ - 0) / var_469_0)
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["102003ui_story"]) and arg_466_1.var_.characterEffect102003ui_story then
				arg_466_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_466_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_469_1 = 0
			local var_469_2 = 0.25

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_3 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(924041112).content)

				arg_466_1.text_.text = var_469_3

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_5 = 10 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 10)

				if (10 <= 0 and var_469_2 or var_469_2 * (utf8.len(var_469_3) / 10)) > 0 and var_469_2 < var_469_5 then
					arg_466_1.talkMaxDuration = var_469_5

					if var_469_5 + var_469_1 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + var_469_1
					end
				end

				arg_466_1.text_.text = var_469_3
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_6 = math.max(var_469_2, arg_466_1.talkMaxDuration)

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_6 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_1) / var_469_6

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_1 + var_469_6 and arg_466_1.time_ < var_469_1 + var_469_6 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play924041113 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 924041113
		arg_470_1.duration_ = 10.03

		local var_470_0 = {
			zh = 7.633,
			ja = 10.033
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play924041114(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(arg_470_1.actors_["102003ui_story"]) and arg_470_1.var_.characterEffect102003ui_story == nil then
				arg_470_1.var_.characterEffect102003ui_story = arg_470_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_0 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 and not isNil(arg_470_1.actors_["102003ui_story"]) then
				if arg_470_1.var_.characterEffect102003ui_story and not isNil(arg_470_1.actors_["102003ui_story"]) then
					arg_470_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 and not isNil(arg_470_1.actors_["102003ui_story"]) and arg_470_1.var_.characterEffect102003ui_story then
				arg_470_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_473_2 = 0
			local var_473_3 = 0.85

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_2 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_4 = arg_470_1:GetWordFromCfg(924041113)
				local var_473_5 = arg_470_1:FormatText(var_473_4.content)

				arg_470_1.text_.text = var_473_5

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_7 = 34 <= 0 and var_473_3 or var_473_3 * (utf8.len(var_473_5) / 34)

				if (34 <= 0 and var_473_3 or var_473_3 * (utf8.len(var_473_5) / 34)) > 0 and var_473_3 < var_473_7 then
					arg_470_1.talkMaxDuration = var_473_7

					if var_473_7 + var_473_2 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_7 + var_473_2
					end
				end

				arg_470_1.text_.text = var_473_5
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb") ~= 0 then
					local var_473_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb") / 1000

					if var_473_8 + var_473_2 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_8 + var_473_2
					end

					if var_473_4.prefab_name ~= "" and arg_470_1.actors_[var_473_4.prefab_name] ~= nil then
						local var_473_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_4.prefab_name].transform, "story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb")

						arg_470_1:RecordAudio("924041113", var_473_9)
						arg_470_1:RecordAudio("924041113", var_473_9)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041113", "story_v_side_old_924041.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_10 = math.max(var_473_3, arg_470_1.talkMaxDuration)

			if var_473_2 <= arg_470_1.time_ and arg_470_1.time_ < var_473_2 + var_473_10 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_2) / var_473_10

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_2 + var_473_10 and arg_470_1.time_ < var_473_2 + var_473_10 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play924041114 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 924041114
		arg_474_1.duration_ = 5

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play924041115(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 and not isNil(arg_474_1.actors_["102003ui_story"]) and arg_474_1.var_.characterEffect102003ui_story == nil then
				arg_474_1.var_.characterEffect102003ui_story = arg_474_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_0 = 0.200000002980232

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_0 and not isNil(arg_474_1.actors_["102003ui_story"]) then
				if arg_474_1.var_.characterEffect102003ui_story and not isNil(arg_474_1.actors_["102003ui_story"]) then
					arg_474_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_474_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_474_1.time_ - 0) / var_477_0)
				end
			end

			if arg_474_1.time_ >= 0 + var_477_0 and arg_474_1.time_ < 0 + var_477_0 + arg_477_0 and not isNil(arg_474_1.actors_["102003ui_story"]) and arg_474_1.var_.characterEffect102003ui_story then
				arg_474_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_474_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_477_1 = 0
			local var_477_2 = 1.3

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_1 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_3 = arg_474_1:FormatText(arg_474_1:GetWordFromCfg(924041114).content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 52 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 52)

				if (52 <= 0 and var_477_2 or var_477_2 * (utf8.len(var_477_3) / 52)) > 0 and var_477_2 < var_477_5 then
					arg_474_1.talkMaxDuration = var_477_5

					if var_477_5 + var_477_1 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + var_477_1
					end
				end

				arg_474_1.text_.text = var_477_3
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_6 = math.max(var_477_2, arg_474_1.talkMaxDuration)

			if var_477_1 <= arg_474_1.time_ and arg_474_1.time_ < var_477_1 + var_477_6 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_1) / var_477_6

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_1 + var_477_6 and arg_474_1.time_ < var_477_1 + var_477_6 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play924041115 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 924041115
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play924041116(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0.325

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_1 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(924041115).content)

				arg_478_1.text_.text = var_481_1

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_3 = 13 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_1) / 13)

				if (13 <= 0 and var_481_0 or var_481_0 * (utf8.len(var_481_1) / 13)) > 0 and var_481_0 < var_481_3 then
					arg_478_1.talkMaxDuration = var_481_3

					if var_481_3 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_3 + 0
					end
				end

				arg_478_1.text_.text = var_481_1
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_4 = math.max(var_481_0, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_4 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - 0) / var_481_4

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_4 and arg_478_1.time_ < 0 + var_481_4 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play924041116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 924041116
		arg_482_1.duration_ = 6.57

		local var_482_0 = {
			zh = 6.566,
			ja = 6.133
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play924041117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["102003ui_story"]) and arg_482_1.var_.characterEffect102003ui_story == nil then
				arg_482_1.var_.characterEffect102003ui_story = arg_482_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_0 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["102003ui_story"]) then
				if arg_482_1.var_.characterEffect102003ui_story and not isNil(arg_482_1.actors_["102003ui_story"]) then
					arg_482_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["102003ui_story"]) and arg_482_1.var_.characterEffect102003ui_story then
				arg_482_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_485_2 = 0
			local var_485_3 = 0.425

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_2 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_4 = arg_482_1:GetWordFromCfg(924041116)
				local var_485_5 = arg_482_1:FormatText(var_485_4.content)

				arg_482_1.text_.text = var_485_5

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_7 = 17 <= 0 and var_485_3 or var_485_3 * (utf8.len(var_485_5) / 17)

				if (17 <= 0 and var_485_3 or var_485_3 * (utf8.len(var_485_5) / 17)) > 0 and var_485_3 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_2 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_2
					end
				end

				arg_482_1.text_.text = var_485_5
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb") / 1000

					if var_485_8 + var_485_2 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_2
					end

					if var_485_4.prefab_name ~= "" and arg_482_1.actors_[var_485_4.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_4.prefab_name].transform, "story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb")

						arg_482_1:RecordAudio("924041116", var_485_9)
						arg_482_1:RecordAudio("924041116", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041116", "story_v_side_old_924041.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_3, arg_482_1.talkMaxDuration)

			if var_485_2 <= arg_482_1.time_ and arg_482_1.time_ < var_485_2 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_2) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_2 + var_485_10 and arg_482_1.time_ < var_485_2 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play924041117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 924041117
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play924041118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(arg_486_1.actors_["102003ui_story"]) and arg_486_1.var_.characterEffect102003ui_story == nil then
				arg_486_1.var_.characterEffect102003ui_story = arg_486_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_0 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 and not isNil(arg_486_1.actors_["102003ui_story"]) then
				if arg_486_1.var_.characterEffect102003ui_story and not isNil(arg_486_1.actors_["102003ui_story"]) then
					arg_486_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_486_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_486_1.time_ - 0) / var_489_0)
				end
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 and not isNil(arg_486_1.actors_["102003ui_story"]) and arg_486_1.var_.characterEffect102003ui_story then
				arg_486_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_486_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_489_1 = 0
			local var_489_2 = 0.925

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_1 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_3 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(924041117).content)

				arg_486_1.text_.text = var_489_3

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 37 <= 0 and var_489_2 or var_489_2 * (utf8.len(var_489_3) / 37)

				if (37 <= 0 and var_489_2 or var_489_2 * (utf8.len(var_489_3) / 37)) > 0 and var_489_2 < var_489_5 then
					arg_486_1.talkMaxDuration = var_489_5

					if var_489_5 + var_489_1 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_5 + var_489_1
					end
				end

				arg_486_1.text_.text = var_489_3
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_6 = math.max(var_489_2, arg_486_1.talkMaxDuration)

			if var_489_1 <= arg_486_1.time_ and arg_486_1.time_ < var_489_1 + var_489_6 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_1) / var_489_6

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_1 + var_489_6 and arg_486_1.time_ < var_489_1 + var_489_6 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play924041118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 924041118
		arg_490_1.duration_ = 1.73

		local var_490_0 = {
			zh = 1.533,
			ja = 1.733
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play924041119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["102003ui_story"]) and arg_490_1.var_.characterEffect102003ui_story == nil then
				arg_490_1.var_.characterEffect102003ui_story = arg_490_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["102003ui_story"]) then
				if arg_490_1.var_.characterEffect102003ui_story and not isNil(arg_490_1.actors_["102003ui_story"]) then
					arg_490_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["102003ui_story"]) and arg_490_1.var_.characterEffect102003ui_story then
				arg_490_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_493_2 = 0
			local var_493_3 = 0.1

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_2 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_4 = arg_490_1:GetWordFromCfg(924041118)
				local var_493_5 = arg_490_1:FormatText(var_493_4.content)

				arg_490_1.text_.text = var_493_5

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_7 = 4 <= 0 and var_493_3 or var_493_3 * (utf8.len(var_493_5) / 4)

				if (4 <= 0 and var_493_3 or var_493_3 * (utf8.len(var_493_5) / 4)) > 0 and var_493_3 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_2 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_2
					end
				end

				arg_490_1.text_.text = var_493_5
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb") / 1000

					if var_493_8 + var_493_2 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_2
					end

					if var_493_4.prefab_name ~= "" and arg_490_1.actors_[var_493_4.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_4.prefab_name].transform, "story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb")

						arg_490_1:RecordAudio("924041118", var_493_9)
						arg_490_1:RecordAudio("924041118", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041118", "story_v_side_old_924041.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_3, arg_490_1.talkMaxDuration)

			if var_493_2 <= arg_490_1.time_ and arg_490_1.time_ < var_493_2 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_2) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_2 + var_493_10 and arg_490_1.time_ < var_493_2 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play924041119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 924041119
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play924041120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["102003ui_story"]) and arg_494_1.var_.characterEffect102003ui_story == nil then
				arg_494_1.var_.characterEffect102003ui_story = arg_494_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_0 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["102003ui_story"]) then
				if arg_494_1.var_.characterEffect102003ui_story and not isNil(arg_494_1.actors_["102003ui_story"]) then
					arg_494_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_494_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_0)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["102003ui_story"]) and arg_494_1.var_.characterEffect102003ui_story then
				arg_494_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_494_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_497_1 = 0
			local var_497_2 = 0.55

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_3 = arg_494_1:FormatText(arg_494_1:GetWordFromCfg(924041119).content)

				arg_494_1.text_.text = var_497_3

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 22 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 22)

				if (22 <= 0 and var_497_2 or var_497_2 * (utf8.len(var_497_3) / 22)) > 0 and var_497_2 < var_497_5 then
					arg_494_1.talkMaxDuration = var_497_5

					if var_497_5 + var_497_1 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + var_497_1
					end
				end

				arg_494_1.text_.text = var_497_3
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_6 = math.max(var_497_2, arg_494_1.talkMaxDuration)

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_6 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_1) / var_497_6

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_1 + var_497_6 and arg_494_1.time_ < var_497_1 + var_497_6 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play924041120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 924041120
		arg_498_1.duration_ = 4.3

		local var_498_0 = {
			zh = 3.6,
			ja = 4.3
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play924041121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["102003ui_story"]) and arg_498_1.var_.characterEffect102003ui_story == nil then
				arg_498_1.var_.characterEffect102003ui_story = arg_498_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["102003ui_story"]) then
				if arg_498_1.var_.characterEffect102003ui_story and not isNil(arg_498_1.actors_["102003ui_story"]) then
					arg_498_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["102003ui_story"]) and arg_498_1.var_.characterEffect102003ui_story then
				arg_498_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_501_2 = 0
			local var_501_3 = 0.25

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_2 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_4 = arg_498_1:GetWordFromCfg(924041120)
				local var_501_5 = arg_498_1:FormatText(var_501_4.content)

				arg_498_1.text_.text = var_501_5

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_7 = 10 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 10)

				if (10 <= 0 and var_501_3 or var_501_3 * (utf8.len(var_501_5) / 10)) > 0 and var_501_3 < var_501_7 then
					arg_498_1.talkMaxDuration = var_501_7

					if var_501_7 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_7 + var_501_2
					end
				end

				arg_498_1.text_.text = var_501_5
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb") ~= 0 then
					local var_501_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb") / 1000

					if var_501_8 + var_501_2 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_8 + var_501_2
					end

					if var_501_4.prefab_name ~= "" and arg_498_1.actors_[var_501_4.prefab_name] ~= nil then
						local var_501_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_4.prefab_name].transform, "story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb")

						arg_498_1:RecordAudio("924041120", var_501_9)
						arg_498_1:RecordAudio("924041120", var_501_9)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041120", "story_v_side_old_924041.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_10 = math.max(var_501_3, arg_498_1.talkMaxDuration)

			if var_501_2 <= arg_498_1.time_ and arg_498_1.time_ < var_501_2 + var_501_10 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_2) / var_501_10

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_2 + var_501_10 and arg_498_1.time_ < var_501_2 + var_501_10 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play924041121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 924041121
		arg_502_1.duration_ = 7

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play924041122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				local var_505_0 = arg_502_1.bgs_.ST0107

				arg_502_1.bgs_.ST0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_505_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_505_1 = var_505_0:GetComponent("SpriteRenderer")

				if var_505_1 and var_505_1.sprite then
					local var_505_2 = 2 * (var_505_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_505_0.transform.localScale = Vector3.New(var_505_2 / var_505_1.sprite.bounds.size.y < var_505_2 * manager.ui.mainCameraCom_.aspect / var_505_1.sprite.bounds.size.x and var_505_2 * manager.ui.mainCameraCom_.aspect / var_505_1.sprite.bounds.size.x or var_505_2 / var_505_1.sprite.bounds.size.y, var_505_2 / var_505_1.sprite.bounds.size.y < var_505_2 * manager.ui.mainCameraCom_.aspect / var_505_1.sprite.bounds.size.x and var_505_2 * manager.ui.mainCameraCom_.aspect / var_505_1.sprite.bounds.size.x or var_505_2 / var_505_1.sprite.bounds.size.y, 0)
				end

				for iter_505_0, iter_505_1 in pairs(arg_502_1.bgs_) do
					if iter_505_0 ~= "ST0107" then
						iter_505_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_505_3 = 2

			if 2 < arg_502_1.time_ and arg_502_1.time_ <= var_505_3 + arg_505_0 then
				arg_502_1.allBtn_.enabled = false
			end

			if arg_502_1.time_ >= var_505_3 + 0.3 and arg_502_1.time_ < var_505_3 + 0.3 + arg_505_0 then
				arg_502_1.allBtn_.enabled = true
			end

			local var_505_4 = 0

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.mask_.enabled = true
				arg_502_1.mask_.raycastTarget = true

				arg_502_1:SetGaussion(false)
			end

			local var_505_5 = 2

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_5 then
				local var_505_6 = Color.New(0, 0, 0)

				var_505_6.a = Mathf.Lerp(1, 0, (arg_502_1.time_ - var_505_4) / var_505_5)
				arg_502_1.mask_.color = var_505_6
			end

			if arg_502_1.time_ >= var_505_4 + var_505_5 and arg_502_1.time_ < var_505_4 + var_505_5 + arg_505_0 then
				local var_505_7 = Color.New(0, 0, 0)

				arg_502_1.mask_.enabled = false
				var_505_7.a = 0
				arg_502_1.mask_.color = var_505_7
			end

			if 0.125 < arg_502_1.time_ and arg_502_1.time_ <= 0.125 + arg_505_0 then
				arg_502_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_firework", "")
			end

			if arg_502_1.frameCnt_ <= 1 then
				arg_502_1.dialog_:SetActive(false)
			end

			local var_505_9 = 2
			local var_505_10 = 0.6

			if 2 < arg_502_1.time_ and arg_502_1.time_ <= var_505_9 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0

				arg_502_1.dialog_:SetActive(true)

				arg_502_1.dialogCg_.alpha = 0

				local var_505_11 = LeanTween.value(arg_502_1.dialog_, 0, 1, 0.3)

				var_505_11:setOnUpdate(LuaHelper.FloatAction(function(arg_506_0)
					arg_502_1.dialogCg_.alpha = arg_506_0
				end))
				var_505_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_502_1.dialog_)
					var_505_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_502_1.duration_ = arg_502_1.duration_ + 0.3

				SetActive(arg_502_1.leftNameGo_, false)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_12 = arg_502_1:FormatText(arg_502_1:GetWordFromCfg(924041121).content)

				arg_502_1.text_.text = var_505_12

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_14 = 24 <= 0 and var_505_10 or var_505_10 * (utf8.len(var_505_12) / 24)

				if (24 <= 0 and var_505_10 or var_505_10 * (utf8.len(var_505_12) / 24)) > 0 and var_505_10 < var_505_14 then
					arg_502_1.talkMaxDuration = var_505_14
					var_505_9 = var_505_9 + 0.3

					if var_505_14 + var_505_9 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_14 + var_505_9
					end
				end

				arg_502_1.text_.text = var_505_12
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)
				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_15 = var_505_9 + 0.3
			local var_505_16 = math.max(var_505_10, arg_502_1.talkMaxDuration)

			if var_505_9 + 0.3 <= arg_502_1.time_ and arg_502_1.time_ < var_505_15 + var_505_16 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_15) / var_505_16

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_15 + var_505_16 and arg_502_1.time_ < var_505_15 + var_505_16 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play924041122 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 924041122
		arg_508_1.duration_ = 8.8

		local var_508_0 = {
			zh = 8.8,
			ja = 8.166
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
				arg_508_0:Play924041123(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPos102003ui_story = arg_508_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_511_0 = 0.001

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 then
				arg_508_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_508_1.time_ - 0) / var_511_0)
				arg_508_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).z)
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles = arg_508_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 then
				arg_508_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_508_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_508_1.actors_["102003ui_story"].transform.position).z)
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_508_1.actors_["102003ui_story"].transform.localEulerAngles = arg_508_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_511_1 = arg_508_1.actors_["102003ui_story"]

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 and not isNil(var_511_1) and arg_508_1.var_.characterEffect102003ui_story == nil then
				arg_508_1.var_.characterEffect102003ui_story = var_511_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_2 = 0.200000002980232

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_2 and not isNil(var_511_1) then
				if arg_508_1.var_.characterEffect102003ui_story and not isNil(var_511_1) then
					arg_508_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_508_1.time_ >= 0 + var_511_2 and arg_508_1.time_ < 0 + var_511_2 + arg_511_0 and not isNil(var_511_1) and arg_508_1.var_.characterEffect102003ui_story then
				arg_508_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action4_1")
			end

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_511_4 = 0
			local var_511_5 = 0.6

			if 0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_4 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_6 = arg_508_1:GetWordFromCfg(924041122)
				local var_511_7 = arg_508_1:FormatText(var_511_6.content)

				arg_508_1.text_.text = var_511_7

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_9 = 24 <= 0 and var_511_5 or var_511_5 * (utf8.len(var_511_7) / 24)

				if (24 <= 0 and var_511_5 or var_511_5 * (utf8.len(var_511_7) / 24)) > 0 and var_511_5 < var_511_9 then
					arg_508_1.talkMaxDuration = var_511_9

					if var_511_9 + var_511_4 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_9 + var_511_4
					end
				end

				arg_508_1.text_.text = var_511_7
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb") ~= 0 then
					local var_511_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb") / 1000

					if var_511_10 + var_511_4 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_10 + var_511_4
					end

					if var_511_6.prefab_name ~= "" and arg_508_1.actors_[var_511_6.prefab_name] ~= nil then
						local var_511_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_6.prefab_name].transform, "story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb")

						arg_508_1:RecordAudio("924041122", var_511_11)
						arg_508_1:RecordAudio("924041122", var_511_11)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041122", "story_v_side_old_924041.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_12 = math.max(var_511_5, arg_508_1.talkMaxDuration)

			if var_511_4 <= arg_508_1.time_ and arg_508_1.time_ < var_511_4 + var_511_12 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_4) / var_511_12

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_4 + var_511_12 and arg_508_1.time_ < var_511_4 + var_511_12 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play924041123 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 924041123
		arg_512_1.duration_ = 5

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play924041124(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			if 0 < arg_512_1.time_ and arg_512_1.time_ <= 0 + arg_515_0 and not isNil(arg_512_1.actors_["102003ui_story"]) and arg_512_1.var_.characterEffect102003ui_story == nil then
				arg_512_1.var_.characterEffect102003ui_story = arg_512_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_515_0 = 0.200000002980232

			if 0 <= arg_512_1.time_ and arg_512_1.time_ < 0 + var_515_0 and not isNil(arg_512_1.actors_["102003ui_story"]) then
				if arg_512_1.var_.characterEffect102003ui_story and not isNil(arg_512_1.actors_["102003ui_story"]) then
					arg_512_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_512_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_512_1.time_ - 0) / var_515_0)
				end
			end

			if arg_512_1.time_ >= 0 + var_515_0 and arg_512_1.time_ < 0 + var_515_0 + arg_515_0 and not isNil(arg_512_1.actors_["102003ui_story"]) and arg_512_1.var_.characterEffect102003ui_story then
				arg_512_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_512_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_515_1 = 0
			local var_515_2 = 0.225

			if 0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0
				arg_512_1.dialogCg_.alpha = 1

				arg_512_1.dialog_:SetActive(true)
				SetActive(arg_512_1.leftNameGo_, true)

				arg_512_1.leftNameTxt_.text = arg_512_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, true)
				arg_512_1.iconController_:SetSelectedState("hero")

				arg_512_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_512_1.callingController_:SetSelectedState("normal")

				arg_512_1.keyicon_.color = Color.New(1, 1, 1)
				arg_512_1.icon_.color = Color.New(1, 1, 1)

				local var_515_3 = arg_512_1:FormatText(arg_512_1:GetWordFromCfg(924041123).content)

				arg_512_1.text_.text = var_515_3

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_5 = 9 <= 0 and var_515_2 or var_515_2 * (utf8.len(var_515_3) / 9)

				if (9 <= 0 and var_515_2 or var_515_2 * (utf8.len(var_515_3) / 9)) > 0 and var_515_2 < var_515_5 then
					arg_512_1.talkMaxDuration = var_515_5

					if var_515_5 + var_515_1 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_5 + var_515_1
					end
				end

				arg_512_1.text_.text = var_515_3
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)
				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_6 = math.max(var_515_2, arg_512_1.talkMaxDuration)

			if var_515_1 <= arg_512_1.time_ and arg_512_1.time_ < var_515_1 + var_515_6 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_1) / var_515_6

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_1 + var_515_6 and arg_512_1.time_ < var_515_1 + var_515_6 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play924041124 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 924041124
		arg_516_1.duration_ = 4.83

		local var_516_0 = {
			zh = 4.833,
			ja = 3.333
		}
		local var_516_1 = manager.audio:GetLocalizationFlag()

		if var_516_0[var_516_1] ~= nil then
			arg_516_1.duration_ = var_516_0[var_516_1]
		end

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play924041125(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1.var_.moveOldPos102003ui_story = arg_516_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_519_0 = 0.001

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_0 then
				arg_516_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_516_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_516_1.time_ - 0) / var_519_0)
				arg_516_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_516_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_516_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_516_1.actors_["102003ui_story"].transform.position).z)
				arg_516_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_516_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_516_1.actors_["102003ui_story"].transform.localEulerAngles = arg_516_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_516_1.time_ >= 0 + var_519_0 and arg_516_1.time_ < 0 + var_519_0 + arg_519_0 then
				arg_516_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_516_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_516_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_516_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_516_1.actors_["102003ui_story"].transform.position).z)
				arg_516_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_516_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_516_1.actors_["102003ui_story"].transform.localEulerAngles = arg_516_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_519_1 = arg_516_1.actors_["102003ui_story"]

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 and not isNil(var_519_1) and arg_516_1.var_.characterEffect102003ui_story == nil then
				arg_516_1.var_.characterEffect102003ui_story = var_519_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_519_2 = 0.200000002980232

			if 0 <= arg_516_1.time_ and arg_516_1.time_ < 0 + var_519_2 and not isNil(var_519_1) then
				if arg_516_1.var_.characterEffect102003ui_story and not isNil(var_519_1) then
					arg_516_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_516_1.time_ >= 0 + var_519_2 and arg_516_1.time_ < 0 + var_519_2 + arg_519_0 and not isNil(var_519_1) and arg_516_1.var_.characterEffect102003ui_story then
				arg_516_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action448")
			end

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= 0 + arg_519_0 then
				arg_516_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_519_4 = 0
			local var_519_5 = 0.35

			if 0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_4 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, true)

				arg_516_1.leftNameTxt_.text = arg_516_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_516_1.leftNameTxt_.transform)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1.leftNameTxt_.text)
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_6 = arg_516_1:GetWordFromCfg(924041124)
				local var_519_7 = arg_516_1:FormatText(var_519_6.content)

				arg_516_1.text_.text = var_519_7

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_9 = 14 <= 0 and var_519_5 or var_519_5 * (utf8.len(var_519_7) / 14)

				if (14 <= 0 and var_519_5 or var_519_5 * (utf8.len(var_519_7) / 14)) > 0 and var_519_5 < var_519_9 then
					arg_516_1.talkMaxDuration = var_519_9

					if var_519_9 + var_519_4 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_9 + var_519_4
					end
				end

				arg_516_1.text_.text = var_519_7
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb") ~= 0 then
					local var_519_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb") / 1000

					if var_519_10 + var_519_4 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_10 + var_519_4
					end

					if var_519_6.prefab_name ~= "" and arg_516_1.actors_[var_519_6.prefab_name] ~= nil then
						local var_519_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_516_1.actors_[var_519_6.prefab_name].transform, "story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb")

						arg_516_1:RecordAudio("924041124", var_519_11)
						arg_516_1:RecordAudio("924041124", var_519_11)
					else
						arg_516_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb")
					end

					arg_516_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041124", "story_v_side_old_924041.awb")
				end

				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_12 = math.max(var_519_5, arg_516_1.talkMaxDuration)

			if var_519_4 <= arg_516_1.time_ and arg_516_1.time_ < var_519_4 + var_519_12 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_4) / var_519_12

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_4 + var_519_12 and arg_516_1.time_ < var_519_4 + var_519_12 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_516_1:InitPlayNodeList()
	end,
	Play924041125 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 924041125
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play924041126(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			if 0 < arg_520_1.time_ and arg_520_1.time_ <= 0 + arg_523_0 and not isNil(arg_520_1.actors_["102003ui_story"]) and arg_520_1.var_.characterEffect102003ui_story == nil then
				arg_520_1.var_.characterEffect102003ui_story = arg_520_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_523_0 = 0.200000002980232

			if 0 <= arg_520_1.time_ and arg_520_1.time_ < 0 + var_523_0 and not isNil(arg_520_1.actors_["102003ui_story"]) then
				if arg_520_1.var_.characterEffect102003ui_story and not isNil(arg_520_1.actors_["102003ui_story"]) then
					arg_520_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_520_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_520_1.time_ - 0) / var_523_0)
				end
			end

			if arg_520_1.time_ >= 0 + var_523_0 and arg_520_1.time_ < 0 + var_523_0 + arg_523_0 and not isNil(arg_520_1.actors_["102003ui_story"]) and arg_520_1.var_.characterEffect102003ui_story then
				arg_520_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_520_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_523_1 = 0
			local var_523_2 = 0.125

			if 0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_1 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				arg_520_1.leftNameTxt_.text = arg_520_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_3 = arg_520_1:FormatText(arg_520_1:GetWordFromCfg(924041125).content)

				arg_520_1.text_.text = var_523_3

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 5 <= 0 and var_523_2 or var_523_2 * (utf8.len(var_523_3) / 5)

				if (5 <= 0 and var_523_2 or var_523_2 * (utf8.len(var_523_3) / 5)) > 0 and var_523_2 < var_523_5 then
					arg_520_1.talkMaxDuration = var_523_5

					if var_523_5 + var_523_1 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_5 + var_523_1
					end
				end

				arg_520_1.text_.text = var_523_3
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_6 = math.max(var_523_2, arg_520_1.talkMaxDuration)

			if var_523_1 <= arg_520_1.time_ and arg_520_1.time_ < var_523_1 + var_523_6 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_1) / var_523_6

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_1 + var_523_6 and arg_520_1.time_ < var_523_1 + var_523_6 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play924041126 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 924041126
		arg_524_1.duration_ = 5

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play924041127(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			if 0 < arg_524_1.time_ and arg_524_1.time_ <= 0 + arg_527_0 then
				arg_524_1.var_.moveOldPos102003ui_story = arg_524_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_527_0 = 0.001

			if 0 <= arg_524_1.time_ and arg_524_1.time_ < 0 + var_527_0 then
				arg_524_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_524_1.time_ - 0) / var_527_0)
				arg_524_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["102003ui_story"].transform.position).z)
				arg_524_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["102003ui_story"].transform.localEulerAngles = arg_524_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_524_1.time_ >= 0 + var_527_0 and arg_524_1.time_ < 0 + var_527_0 + arg_527_0 then
				arg_524_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_524_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_524_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_524_1.actors_["102003ui_story"].transform.position).z)
				arg_524_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_524_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_524_1.actors_["102003ui_story"].transform.localEulerAngles = arg_524_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_527_1 = 0
			local var_527_2 = 0.175

			if 0 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, false)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_3 = arg_524_1:FormatText(arg_524_1:GetWordFromCfg(924041126).content)

				arg_524_1.text_.text = var_527_3

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_5 = 7 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 7)

				if (7 <= 0 and var_527_2 or var_527_2 * (utf8.len(var_527_3) / 7)) > 0 and var_527_2 < var_527_5 then
					arg_524_1.talkMaxDuration = var_527_5

					if var_527_5 + var_527_1 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_5 + var_527_1
					end
				end

				arg_524_1.text_.text = var_527_3
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)
				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_6 = math.max(var_527_2, arg_524_1.talkMaxDuration)

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_6 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_1) / var_527_6

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_1 + var_527_6 and arg_524_1.time_ < var_527_1 + var_527_6 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play924041127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 924041127
		arg_528_1.duration_ = 5.87

		local var_528_0 = {
			zh = 5.866,
			ja = 4.666
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play924041128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1.var_.moveOldPos102003ui_story = arg_528_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_531_0 = 0.001

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_0 then
				arg_528_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_528_1.time_ - 0) / var_531_0)
				arg_528_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_528_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["102003ui_story"].transform.position).z)
				arg_528_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_528_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_528_1.actors_["102003ui_story"].transform.localEulerAngles = arg_528_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_528_1.time_ >= 0 + var_531_0 and arg_528_1.time_ < 0 + var_531_0 + arg_531_0 then
				arg_528_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_528_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_528_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_528_1.actors_["102003ui_story"].transform.position).z)
				arg_528_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_528_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_528_1.actors_["102003ui_story"].transform.localEulerAngles = arg_528_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_531_1 = arg_528_1.actors_["102003ui_story"]

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 and not isNil(var_531_1) and arg_528_1.var_.characterEffect102003ui_story == nil then
				arg_528_1.var_.characterEffect102003ui_story = var_531_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_2 = 0.200000002980232

			if 0 <= arg_528_1.time_ and arg_528_1.time_ < 0 + var_531_2 and not isNil(var_531_1) then
				if arg_528_1.var_.characterEffect102003ui_story and not isNil(var_531_1) then
					arg_528_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_528_1.time_ >= 0 + var_531_2 and arg_528_1.time_ < 0 + var_531_2 + arg_531_0 and not isNil(var_531_1) and arg_528_1.var_.characterEffect102003ui_story then
				arg_528_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= 0 + arg_531_0 then
				arg_528_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_531_4 = 0
			local var_531_5 = 0.3

			if 0 < arg_528_1.time_ and arg_528_1.time_ <= var_531_4 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				arg_528_1.leftNameTxt_.text = arg_528_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_6 = arg_528_1:GetWordFromCfg(924041127)
				local var_531_7 = arg_528_1:FormatText(var_531_6.content)

				arg_528_1.text_.text = var_531_7

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_9 = 12 <= 0 and var_531_5 or var_531_5 * (utf8.len(var_531_7) / 12)

				if (12 <= 0 and var_531_5 or var_531_5 * (utf8.len(var_531_7) / 12)) > 0 and var_531_5 < var_531_9 then
					arg_528_1.talkMaxDuration = var_531_9

					if var_531_9 + var_531_4 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_9 + var_531_4
					end
				end

				arg_528_1.text_.text = var_531_7
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb") ~= 0 then
					local var_531_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb") / 1000

					if var_531_10 + var_531_4 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_10 + var_531_4
					end

					if var_531_6.prefab_name ~= "" and arg_528_1.actors_[var_531_6.prefab_name] ~= nil then
						local var_531_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_6.prefab_name].transform, "story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb")

						arg_528_1:RecordAudio("924041127", var_531_11)
						arg_528_1:RecordAudio("924041127", var_531_11)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041127", "story_v_side_old_924041.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_12 = math.max(var_531_5, arg_528_1.talkMaxDuration)

			if var_531_4 <= arg_528_1.time_ and arg_528_1.time_ < var_531_4 + var_531_12 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_4) / var_531_12

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_4 + var_531_12 and arg_528_1.time_ < var_531_4 + var_531_12 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_528_1:InitPlayNodeList()
	end,
	Play924041128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 924041128
		arg_532_1.duration_ = 6

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play924041129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 and not isNil(arg_532_1.actors_["102003ui_story"]) and arg_532_1.var_.characterEffect102003ui_story == nil then
				arg_532_1.var_.characterEffect102003ui_story = arg_532_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_535_0 = 0.200000002980232

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_0 and not isNil(arg_532_1.actors_["102003ui_story"]) then
				if arg_532_1.var_.characterEffect102003ui_story and not isNil(arg_532_1.actors_["102003ui_story"]) then
					arg_532_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_532_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_532_1.time_ - 0) / var_535_0)
				end
			end

			if arg_532_1.time_ >= 0 + var_535_0 and arg_532_1.time_ < 0 + var_535_0 + arg_535_0 and not isNil(arg_532_1.actors_["102003ui_story"]) and arg_532_1.var_.characterEffect102003ui_story then
				arg_532_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_532_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_535_1 = arg_532_1.actors_["102003ui_story"].transform

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.var_.moveOldPos102003ui_story = var_535_1.localPosition
			end

			local var_535_2 = 0.001

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_2 then
				var_535_1.localPosition = Vector3.Lerp(arg_532_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_532_1.time_ - 0) / var_535_2)
				var_535_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_535_1.position).x, (manager.ui.mainCamera.transform.position - var_535_1.position).y, (manager.ui.mainCamera.transform.position - var_535_1.position).z)
				var_535_1.localEulerAngles.z = 0
				var_535_1.localEulerAngles.x = 0
				var_535_1.localEulerAngles = var_535_1.localEulerAngles
			end

			if arg_532_1.time_ >= 0 + var_535_2 and arg_532_1.time_ < 0 + var_535_2 + arg_535_0 then
				var_535_1.localPosition = Vector3.New(0, 100, 0)
				var_535_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_535_1.position).x, (manager.ui.mainCamera.transform.position - var_535_1.position).y, (manager.ui.mainCamera.transform.position - var_535_1.position).z)
				var_535_1.localEulerAngles.z = 0
				var_535_1.localEulerAngles.x = 0
				var_535_1.localEulerAngles = var_535_1.localEulerAngles
			end

			local var_535_3 = manager.ui.mainCamera.transform

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= 0 + arg_535_0 then
				arg_532_1.var_.shakeOldPos = var_535_3.localPosition
			end

			local var_535_4 = 0.766666666666667

			if 0 <= arg_532_1.time_ and arg_532_1.time_ < 0 + var_535_4 then
				local var_535_5, var_535_6 = math.modf((arg_532_1.time_ - 0) / 0.066)

				var_535_3.localPosition = Vector3.New(var_535_6 * 0.13, var_535_6 * 0.13, var_535_6 * 0.13) + arg_532_1.var_.shakeOldPos
			end

			if arg_532_1.time_ >= 0 + var_535_4 and arg_532_1.time_ < 0 + var_535_4 + arg_535_0 then
				var_535_3.localPosition = arg_532_1.var_.shakeOldPos
			end

			local var_535_7 = 0

			if 0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_7 + arg_535_0 then
				arg_532_1.allBtn_.enabled = false
			end

			if arg_532_1.time_ >= var_535_7 + 1.2 and arg_532_1.time_ < var_535_7 + 1.2 + arg_535_0 then
				arg_532_1.allBtn_.enabled = true
			end

			if arg_532_1.frameCnt_ <= 1 then
				arg_532_1.dialog_:SetActive(false)
			end

			local var_535_8 = 1
			local var_535_9 = 0.35

			if 1 < arg_532_1.time_ and arg_532_1.time_ <= var_535_8 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0

				arg_532_1.dialog_:SetActive(true)

				arg_532_1.dialogCg_.alpha = 0

				local var_535_10 = LeanTween.value(arg_532_1.dialog_, 0, 1, 0.3)

				var_535_10:setOnUpdate(LuaHelper.FloatAction(function(arg_536_0)
					arg_532_1.dialogCg_.alpha = arg_536_0
				end))
				var_535_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_532_1.dialog_)
					var_535_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_532_1.duration_ = arg_532_1.duration_ + 0.3

				SetActive(arg_532_1.leftNameGo_, true)

				arg_532_1.leftNameTxt_.text = arg_532_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_11 = arg_532_1:FormatText(arg_532_1:GetWordFromCfg(924041128).content)

				arg_532_1.text_.text = var_535_11

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_13 = 14 <= 0 and var_535_9 or var_535_9 * (utf8.len(var_535_11) / 14)

				if (14 <= 0 and var_535_9 or var_535_9 * (utf8.len(var_535_11) / 14)) > 0 and var_535_9 < var_535_13 then
					arg_532_1.talkMaxDuration = var_535_13
					var_535_8 = var_535_8 + 0.3

					if var_535_13 + var_535_8 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_13 + var_535_8
					end
				end

				arg_532_1.text_.text = var_535_11
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_14 = var_535_8 + 0.3
			local var_535_15 = math.max(var_535_9, arg_532_1.talkMaxDuration)

			if var_535_8 + 0.3 <= arg_532_1.time_ and arg_532_1.time_ < var_535_14 + var_535_15 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_14) / var_535_15

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_14 + var_535_15 and arg_532_1.time_ < var_535_14 + var_535_15 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_532_1:InitPlayNodeList()
	end,
	Play924041129 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 924041129
		arg_538_1.duration_ = 6.07

		local var_538_0 = {
			zh = 4.166,
			ja = 6.066
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
				arg_538_0:Play924041130(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.var_.moveOldPos102003ui_story = arg_538_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_541_0 = 0.001

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 then
				arg_538_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_538_1.time_ - 0) / var_541_0)
				arg_538_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).z)
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles = arg_538_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 then
				arg_538_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_538_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["102003ui_story"].transform.position).z)
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["102003ui_story"].transform.localEulerAngles = arg_538_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_541_1 = arg_538_1.actors_["102003ui_story"]

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(var_541_1) and arg_538_1.var_.characterEffect102003ui_story == nil then
				arg_538_1.var_.characterEffect102003ui_story = var_541_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_2 and not isNil(var_541_1) then
				if arg_538_1.var_.characterEffect102003ui_story and not isNil(var_541_1) then
					arg_538_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= 0 + var_541_2 and arg_538_1.time_ < 0 + var_541_2 + arg_541_0 and not isNil(var_541_1) and arg_538_1.var_.characterEffect102003ui_story then
				arg_538_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action7_1")
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_541_4 = 0
			local var_541_5 = 0.45

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_4 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_6 = arg_538_1:GetWordFromCfg(924041129)
				local var_541_7 = arg_538_1:FormatText(var_541_6.content)

				arg_538_1.text_.text = var_541_7

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_9 = 18 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 18)

				if (18 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 18)) > 0 and var_541_5 < var_541_9 then
					arg_538_1.talkMaxDuration = var_541_9

					if var_541_9 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_9 + var_541_4
					end
				end

				arg_538_1.text_.text = var_541_7
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb") ~= 0 then
					local var_541_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb") / 1000

					if var_541_10 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_10 + var_541_4
					end

					if var_541_6.prefab_name ~= "" and arg_538_1.actors_[var_541_6.prefab_name] ~= nil then
						local var_541_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_6.prefab_name].transform, "story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb")

						arg_538_1:RecordAudio("924041129", var_541_11)
						arg_538_1:RecordAudio("924041129", var_541_11)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041129", "story_v_side_old_924041.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_12 = math.max(var_541_5, arg_538_1.talkMaxDuration)

			if var_541_4 <= arg_538_1.time_ and arg_538_1.time_ < var_541_4 + var_541_12 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_4) / var_541_12

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_4 + var_541_12 and arg_538_1.time_ < var_541_4 + var_541_12 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play924041130 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 924041130
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play924041131(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(arg_542_1.actors_["102003ui_story"]) and arg_542_1.var_.characterEffect102003ui_story == nil then
				arg_542_1.var_.characterEffect102003ui_story = arg_542_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_0 = 0.200000002980232

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 and not isNil(arg_542_1.actors_["102003ui_story"]) then
				if arg_542_1.var_.characterEffect102003ui_story and not isNil(arg_542_1.actors_["102003ui_story"]) then
					arg_542_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_542_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_542_1.time_ - 0) / var_545_0)
				end
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 and not isNil(arg_542_1.actors_["102003ui_story"]) and arg_542_1.var_.characterEffect102003ui_story then
				arg_542_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_542_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_545_1 = 0
			local var_545_2 = 0.75

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_3 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(924041130).content)

				arg_542_1.text_.text = var_545_3

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 30 <= 0 and var_545_2 or var_545_2 * (utf8.len(var_545_3) / 30)

				if (30 <= 0 and var_545_2 or var_545_2 * (utf8.len(var_545_3) / 30)) > 0 and var_545_2 < var_545_5 then
					arg_542_1.talkMaxDuration = var_545_5

					if var_545_5 + var_545_1 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_5 + var_545_1
					end
				end

				arg_542_1.text_.text = var_545_3
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_6 = math.max(var_545_2, arg_542_1.talkMaxDuration)

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_6 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_1) / var_545_6

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_1 + var_545_6 and arg_542_1.time_ < var_545_1 + var_545_6 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play924041131 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 924041131
		arg_546_1.duration_ = 5

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play924041132(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.var_.moveOldPos102003ui_story = arg_546_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_549_0 = 0.001

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_0 then
				arg_546_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_546_1.time_ - 0) / var_549_0)
				arg_546_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_546_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["102003ui_story"].transform.position).z)
				arg_546_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_546_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_546_1.actors_["102003ui_story"].transform.localEulerAngles = arg_546_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_546_1.time_ >= 0 + var_549_0 and arg_546_1.time_ < 0 + var_549_0 + arg_549_0 then
				arg_546_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_546_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_546_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["102003ui_story"].transform.position).z)
				arg_546_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_546_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_546_1.actors_["102003ui_story"].transform.localEulerAngles = arg_546_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if 0.125 < arg_546_1.time_ and arg_546_1.time_ <= 0.125 + arg_549_0 then
				arg_546_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_message_get", "")
			end

			local var_549_2 = 0
			local var_549_3 = 1.05

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_2 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, false)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_4 = arg_546_1:FormatText(arg_546_1:GetWordFromCfg(924041131).content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_6 = 42 <= 0 and var_549_3 or var_549_3 * (utf8.len(var_549_4) / 42)

				if (42 <= 0 and var_549_3 or var_549_3 * (utf8.len(var_549_4) / 42)) > 0 and var_549_3 < var_549_6 then
					arg_546_1.talkMaxDuration = var_549_6

					if var_549_6 + var_549_2 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_6 + var_549_2
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)
				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_7 = math.max(var_549_3, arg_546_1.talkMaxDuration)

			if var_549_2 <= arg_546_1.time_ and arg_546_1.time_ < var_549_2 + var_549_7 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_2) / var_549_7

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_2 + var_549_7 and arg_546_1.time_ < var_549_2 + var_549_7 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_546_1:InitPlayNodeList()
	end,
	Play924041132 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 924041132
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play924041133(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = 0.125

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_1 = arg_550_1:FormatText(arg_550_1:GetWordFromCfg(924041132).content)

				arg_550_1.text_.text = var_553_1

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_3 = 5 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_1) / 5)

				if (5 <= 0 and var_553_0 or var_553_0 * (utf8.len(var_553_1) / 5)) > 0 and var_553_0 < var_553_3 then
					arg_550_1.talkMaxDuration = var_553_3

					if var_553_3 + 0 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_3 + 0
					end
				end

				arg_550_1.text_.text = var_553_1
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_4 = math.max(var_553_0, arg_550_1.talkMaxDuration)

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_4 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - 0) / var_553_4

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= 0 + var_553_4 and arg_550_1.time_ < 0 + var_553_4 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play924041133 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 924041133
		arg_554_1.duration_ = 1.73

		local var_554_0 = {
			zh = 1.533,
			ja = 1.733
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play924041134(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.var_.moveOldPos102003ui_story = arg_554_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_557_0 = 0.001

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_0 then
				arg_554_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_554_1.time_ - 0) / var_557_0)
				arg_554_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_554_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["102003ui_story"].transform.position).z)
				arg_554_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_554_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_554_1.actors_["102003ui_story"].transform.localEulerAngles = arg_554_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_554_1.time_ >= 0 + var_557_0 and arg_554_1.time_ < 0 + var_557_0 + arg_557_0 then
				arg_554_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_554_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_554_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["102003ui_story"].transform.position).z)
				arg_554_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_554_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_554_1.actors_["102003ui_story"].transform.localEulerAngles = arg_554_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_557_1 = arg_554_1.actors_["102003ui_story"]

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(var_557_1) and arg_554_1.var_.characterEffect102003ui_story == nil then
				arg_554_1.var_.characterEffect102003ui_story = var_557_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_2 = 0.200000002980232

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_2 and not isNil(var_557_1) then
				if arg_554_1.var_.characterEffect102003ui_story and not isNil(var_557_1) then
					arg_554_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= 0 + var_557_2 and arg_554_1.time_ < 0 + var_557_2 + arg_557_0 and not isNil(var_557_1) and arg_554_1.var_.characterEffect102003ui_story then
				arg_554_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action1_1")
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_557_4 = 0
			local var_557_5 = 0.15

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_4 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_6 = arg_554_1:GetWordFromCfg(924041133)
				local var_557_7 = arg_554_1:FormatText(var_557_6.content)

				arg_554_1.text_.text = var_557_7

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_9 = 6 <= 0 and var_557_5 or var_557_5 * (utf8.len(var_557_7) / 6)

				if (6 <= 0 and var_557_5 or var_557_5 * (utf8.len(var_557_7) / 6)) > 0 and var_557_5 < var_557_9 then
					arg_554_1.talkMaxDuration = var_557_9

					if var_557_9 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_9 + var_557_4
					end
				end

				arg_554_1.text_.text = var_557_7
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb") ~= 0 then
					local var_557_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb") / 1000

					if var_557_10 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_10 + var_557_4
					end

					if var_557_6.prefab_name ~= "" and arg_554_1.actors_[var_557_6.prefab_name] ~= nil then
						local var_557_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_6.prefab_name].transform, "story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb")

						arg_554_1:RecordAudio("924041133", var_557_11)
						arg_554_1:RecordAudio("924041133", var_557_11)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041133", "story_v_side_old_924041.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_12 = math.max(var_557_5, arg_554_1.talkMaxDuration)

			if var_557_4 <= arg_554_1.time_ and arg_554_1.time_ < var_557_4 + var_557_12 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_4) / var_557_12

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_4 + var_557_12 and arg_554_1.time_ < var_557_4 + var_557_12 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	Play924041134 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 924041134
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play924041135(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(arg_558_1.actors_["102003ui_story"]) and arg_558_1.var_.characterEffect102003ui_story == nil then
				arg_558_1.var_.characterEffect102003ui_story = arg_558_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_0 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_0 and not isNil(arg_558_1.actors_["102003ui_story"]) then
				if arg_558_1.var_.characterEffect102003ui_story and not isNil(arg_558_1.actors_["102003ui_story"]) then
					arg_558_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_558_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_558_1.time_ - 0) / var_561_0)
				end
			end

			if arg_558_1.time_ >= 0 + var_561_0 and arg_558_1.time_ < 0 + var_561_0 + arg_561_0 and not isNil(arg_558_1.actors_["102003ui_story"]) and arg_558_1.var_.characterEffect102003ui_story then
				arg_558_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_558_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_561_1 = 0
			local var_561_2 = 0.05

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_3 = arg_558_1:FormatText(arg_558_1:GetWordFromCfg(924041134).content)

				arg_558_1.text_.text = var_561_3

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 2 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_3) / 2)

				if (2 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_3) / 2)) > 0 and var_561_2 < var_561_5 then
					arg_558_1.talkMaxDuration = var_561_5

					if var_561_5 + var_561_1 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_5 + var_561_1
					end
				end

				arg_558_1.text_.text = var_561_3
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_6 = math.max(var_561_2, arg_558_1.talkMaxDuration)

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_6 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_1) / var_561_6

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_1 + var_561_6 and arg_558_1.time_ < var_561_1 + var_561_6 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play924041135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 924041135
		arg_562_1.duration_ = 4.83

		local var_562_0 = {
			zh = 4.066,
			ja = 4.833
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play924041136(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.var_.moveOldPos102003ui_story = arg_562_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_565_0 = 0.001

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_0 then
				arg_562_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_562_1.time_ - 0) / var_565_0)
				arg_562_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_562_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["102003ui_story"].transform.position).z)
				arg_562_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_562_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_562_1.actors_["102003ui_story"].transform.localEulerAngles = arg_562_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_562_1.time_ >= 0 + var_565_0 and arg_562_1.time_ < 0 + var_565_0 + arg_565_0 then
				arg_562_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_562_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_562_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["102003ui_story"].transform.position).z)
				arg_562_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_562_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_562_1.actors_["102003ui_story"].transform.localEulerAngles = arg_562_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_565_1 = arg_562_1.actors_["102003ui_story"]

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 and not isNil(var_565_1) and arg_562_1.var_.characterEffect102003ui_story == nil then
				arg_562_1.var_.characterEffect102003ui_story = var_565_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_2 = 0.200000002980232

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_2 and not isNil(var_565_1) then
				if arg_562_1.var_.characterEffect102003ui_story and not isNil(var_565_1) then
					arg_562_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_562_1.time_ >= 0 + var_565_2 and arg_562_1.time_ < 0 + var_565_2 + arg_565_0 and not isNil(var_565_1) and arg_562_1.var_.characterEffect102003ui_story then
				arg_562_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_565_4 = 0
			local var_565_5 = 0.375

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_4 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_6 = arg_562_1:GetWordFromCfg(924041135)
				local var_565_7 = arg_562_1:FormatText(var_565_6.content)

				arg_562_1.text_.text = var_565_7

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_9 = 15 <= 0 and var_565_5 or var_565_5 * (utf8.len(var_565_7) / 15)

				if (15 <= 0 and var_565_5 or var_565_5 * (utf8.len(var_565_7) / 15)) > 0 and var_565_5 < var_565_9 then
					arg_562_1.talkMaxDuration = var_565_9

					if var_565_9 + var_565_4 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_9 + var_565_4
					end
				end

				arg_562_1.text_.text = var_565_7
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb") ~= 0 then
					local var_565_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb") / 1000

					if var_565_10 + var_565_4 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_10 + var_565_4
					end

					if var_565_6.prefab_name ~= "" and arg_562_1.actors_[var_565_6.prefab_name] ~= nil then
						local var_565_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_6.prefab_name].transform, "story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb")

						arg_562_1:RecordAudio("924041135", var_565_11)
						arg_562_1:RecordAudio("924041135", var_565_11)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041135", "story_v_side_old_924041.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_12 = math.max(var_565_5, arg_562_1.talkMaxDuration)

			if var_565_4 <= arg_562_1.time_ and arg_562_1.time_ < var_565_4 + var_565_12 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_4) / var_565_12

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_4 + var_565_12 and arg_562_1.time_ < var_565_4 + var_565_12 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play924041136 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 924041136
		arg_566_1.duration_ = 9

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play924041137(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 2 < arg_566_1.time_ and arg_566_1.time_ <= 2 + arg_569_0 then
				local var_569_0 = arg_566_1.bgs_.STblack

				arg_566_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_569_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_569_1 = var_569_0:GetComponent("SpriteRenderer")

				if var_569_1 and var_569_1.sprite then
					local var_569_2 = 2 * (var_569_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_569_0.transform.localScale = Vector3.New(var_569_2 / var_569_1.sprite.bounds.size.y < var_569_2 * manager.ui.mainCameraCom_.aspect / var_569_1.sprite.bounds.size.x and var_569_2 * manager.ui.mainCameraCom_.aspect / var_569_1.sprite.bounds.size.x or var_569_2 / var_569_1.sprite.bounds.size.y, var_569_2 / var_569_1.sprite.bounds.size.y < var_569_2 * manager.ui.mainCameraCom_.aspect / var_569_1.sprite.bounds.size.x and var_569_2 * manager.ui.mainCameraCom_.aspect / var_569_1.sprite.bounds.size.x or var_569_2 / var_569_1.sprite.bounds.size.y, 0)
				end

				for iter_569_0, iter_569_1 in pairs(arg_566_1.bgs_) do
					if iter_569_0 ~= "STblack" then
						iter_569_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_569_3 = 4

			if 4 < arg_566_1.time_ and arg_566_1.time_ <= var_569_3 + arg_569_0 then
				arg_566_1.allBtn_.enabled = false
			end

			if arg_566_1.time_ >= var_569_3 + 0.3 and arg_566_1.time_ < var_569_3 + 0.3 + arg_569_0 then
				arg_566_1.allBtn_.enabled = true
			end

			local var_569_4 = 0

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_4 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = true

				arg_566_1:SetGaussion(false)
			end

			local var_569_5 = 2

			if var_569_4 <= arg_566_1.time_ and arg_566_1.time_ < var_569_4 + var_569_5 then
				local var_569_6 = Color.New(0, 0, 0)

				var_569_6.a = Mathf.Lerp(0, 1, (arg_566_1.time_ - var_569_4) / var_569_5)
				arg_566_1.mask_.color = var_569_6
			end

			if arg_566_1.time_ >= var_569_4 + var_569_5 and arg_566_1.time_ < var_569_4 + var_569_5 + arg_569_0 then
				local var_569_7 = Color.New(0, 0, 0)

				var_569_7.a = 1
				arg_566_1.mask_.color = var_569_7
			end

			local var_569_8 = 2

			if 2 < arg_566_1.time_ and arg_566_1.time_ <= var_569_8 + arg_569_0 then
				arg_566_1.mask_.enabled = true
				arg_566_1.mask_.raycastTarget = true

				arg_566_1:SetGaussion(false)
			end

			local var_569_9 = 2

			if var_569_8 <= arg_566_1.time_ and arg_566_1.time_ < var_569_8 + var_569_9 then
				local var_569_10 = Color.New(0, 0, 0)

				var_569_10.a = Mathf.Lerp(1, 0, (arg_566_1.time_ - var_569_8) / var_569_9)
				arg_566_1.mask_.color = var_569_10
			end

			if arg_566_1.time_ >= var_569_8 + var_569_9 and arg_566_1.time_ < var_569_8 + var_569_9 + arg_569_0 then
				local var_569_11 = Color.New(0, 0, 0)

				arg_566_1.mask_.enabled = false
				var_569_11.a = 0
				arg_566_1.mask_.color = var_569_11
			end

			local var_569_12 = arg_566_1.actors_["102003ui_story"].transform

			if 1.96599999815226 < arg_566_1.time_ and arg_566_1.time_ <= 1.96599999815226 + arg_569_0 then
				arg_566_1.var_.moveOldPos102003ui_story = var_569_12.localPosition
			end

			local var_569_13 = 0.001

			if 1.96599999815226 <= arg_566_1.time_ and arg_566_1.time_ < 1.96599999815226 + var_569_13 then
				var_569_12.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_566_1.time_ - 1.96599999815226) / var_569_13)
				var_569_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_569_12.position).x, (manager.ui.mainCamera.transform.position - var_569_12.position).y, (manager.ui.mainCamera.transform.position - var_569_12.position).z)
				var_569_12.localEulerAngles.z = 0
				var_569_12.localEulerAngles.x = 0
				var_569_12.localEulerAngles = var_569_12.localEulerAngles
			end

			if arg_566_1.time_ >= 1.96599999815226 + var_569_13 and arg_566_1.time_ < 1.96599999815226 + var_569_13 + arg_569_0 then
				var_569_12.localPosition = Vector3.New(0, 100, 0)
				var_569_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_569_12.position).x, (manager.ui.mainCamera.transform.position - var_569_12.position).y, (manager.ui.mainCamera.transform.position - var_569_12.position).z)
				var_569_12.localEulerAngles.z = 0
				var_569_12.localEulerAngles.x = 0
				var_569_12.localEulerAngles = var_569_12.localEulerAngles
			end

			local var_569_14 = arg_566_1.actors_["102003ui_story"]

			if 1.96599999815226 < arg_566_1.time_ and arg_566_1.time_ <= 1.96599999815226 + arg_569_0 and not isNil(var_569_14) and arg_566_1.var_.characterEffect102003ui_story == nil then
				arg_566_1.var_.characterEffect102003ui_story = var_569_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_15 = 0.034000001847744

			if 1.96599999815226 <= arg_566_1.time_ and arg_566_1.time_ < 1.96599999815226 + var_569_15 and not isNil(var_569_14) then
				if arg_566_1.var_.characterEffect102003ui_story and not isNil(var_569_14) then
					arg_566_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_566_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_566_1.time_ - 1.96599999815226) / var_569_15)
				end
			end

			if arg_566_1.time_ >= 1.96599999815226 + var_569_15 and arg_566_1.time_ < 1.96599999815226 + var_569_15 + arg_569_0 and not isNil(var_569_14) and arg_566_1.var_.characterEffect102003ui_story then
				arg_566_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_566_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if arg_566_1.frameCnt_ <= 1 then
				arg_566_1.dialog_:SetActive(false)
			end

			local var_569_16 = 4
			local var_569_17 = 0.425

			if 4 < arg_566_1.time_ and arg_566_1.time_ <= var_569_16 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0

				arg_566_1.dialog_:SetActive(true)

				arg_566_1.dialogCg_.alpha = 0

				local var_569_18 = LeanTween.value(arg_566_1.dialog_, 0, 1, 0.3)

				var_569_18:setOnUpdate(LuaHelper.FloatAction(function(arg_570_0)
					arg_566_1.dialogCg_.alpha = arg_570_0
				end))
				var_569_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_566_1.dialog_)
					var_569_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_566_1.duration_ = arg_566_1.duration_ + 0.3

				SetActive(arg_566_1.leftNameGo_, false)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_19 = arg_566_1:FormatText(arg_566_1:GetWordFromCfg(924041136).content)

				arg_566_1.text_.text = var_569_19

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_21 = 17 <= 0 and var_569_17 or var_569_17 * (utf8.len(var_569_19) / 17)

				if (17 <= 0 and var_569_17 or var_569_17 * (utf8.len(var_569_19) / 17)) > 0 and var_569_17 < var_569_21 then
					arg_566_1.talkMaxDuration = var_569_21
					var_569_16 = var_569_16 + 0.3

					if var_569_21 + var_569_16 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_21 + var_569_16
					end
				end

				arg_566_1.text_.text = var_569_19
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_22 = var_569_16 + 0.3
			local var_569_23 = math.max(var_569_17, arg_566_1.talkMaxDuration)

			if var_569_16 + 0.3 <= arg_566_1.time_ and arg_566_1.time_ < var_569_22 + var_569_23 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_22) / var_569_23

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_22 + var_569_23 and arg_566_1.time_ < var_569_22 + var_569_23 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play924041137 = function(arg_572_0, arg_572_1)
		arg_572_1.time_ = 0
		arg_572_1.frameCnt_ = 0
		arg_572_1.state_ = "playing"
		arg_572_1.curTalkId_ = 924041137
		arg_572_1.duration_ = 7

		SetActive(arg_572_1.tipsGo_, false)

		function arg_572_1.onSingleLineFinish_()
			arg_572_1.onSingleLineUpdate_ = nil
			arg_572_1.onSingleLineFinish_ = nil
			arg_572_1.state_ = "waiting"
		end

		function arg_572_1.playNext_(arg_574_0)
			if arg_574_0 == 1 then
				arg_572_0:Play924041138(arg_572_1)
			end
		end

		function arg_572_1.onSingleLineUpdate_(arg_575_0)
			if arg_572_1.bgs_.X204_f == nil then
				local var_575_0 = Object.Instantiate(arg_572_1.paintGo_)

				var_575_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X204_f")
				var_575_0.name = "X204_f"
				var_575_0.transform.parent = arg_572_1.stage_.transform
				var_575_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_572_1.bgs_.X204_f = var_575_0
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				local var_575_1 = arg_572_1.bgs_.X204_f

				arg_572_1.bgs_.X204_f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_575_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_575_2 = var_575_1:GetComponent("SpriteRenderer")

				if var_575_2 and var_575_2.sprite then
					local var_575_3 = 2 * (var_575_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_575_1.transform.localScale = Vector3.New(var_575_3 / var_575_2.sprite.bounds.size.y < var_575_3 * manager.ui.mainCameraCom_.aspect / var_575_2.sprite.bounds.size.x and var_575_3 * manager.ui.mainCameraCom_.aspect / var_575_2.sprite.bounds.size.x or var_575_3 / var_575_2.sprite.bounds.size.y, var_575_3 / var_575_2.sprite.bounds.size.y < var_575_3 * manager.ui.mainCameraCom_.aspect / var_575_2.sprite.bounds.size.x and var_575_3 * manager.ui.mainCameraCom_.aspect / var_575_2.sprite.bounds.size.x or var_575_3 / var_575_2.sprite.bounds.size.y, 0)
				end

				for iter_575_0, iter_575_1 in pairs(arg_572_1.bgs_) do
					if iter_575_0 ~= "X204_f" then
						iter_575_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_575_4 = 2

			if 2 < arg_572_1.time_ and arg_572_1.time_ <= var_575_4 + arg_575_0 then
				arg_572_1.allBtn_.enabled = false
			end

			if arg_572_1.time_ >= var_575_4 + 0.3 and arg_572_1.time_ < var_575_4 + 0.3 + arg_575_0 then
				arg_572_1.allBtn_.enabled = true
			end

			local var_575_5 = 0

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= var_575_5 + arg_575_0 then
				arg_572_1.mask_.enabled = true
				arg_572_1.mask_.raycastTarget = true

				arg_572_1:SetGaussion(false)
			end

			local var_575_6 = 2

			if var_575_5 <= arg_572_1.time_ and arg_572_1.time_ < var_575_5 + var_575_6 then
				local var_575_7 = Color.New(0, 0, 0)

				var_575_7.a = Mathf.Lerp(1, 0, (arg_572_1.time_ - var_575_5) / var_575_6)
				arg_572_1.mask_.color = var_575_7
			end

			if arg_572_1.time_ >= var_575_5 + var_575_6 and arg_572_1.time_ < var_575_5 + var_575_6 + arg_575_0 then
				local var_575_8 = Color.New(0, 0, 0)

				arg_572_1.mask_.enabled = false
				var_575_8.a = 0
				arg_572_1.mask_.color = var_575_8
			end

			if 5.55111512312578e-17 < arg_572_1.time_ and arg_572_1.time_ <= 5.55111512312578e-17 + arg_575_0 then
				arg_572_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_firework", "")
			end

			if 5.55111512312578e-17 < arg_572_1.time_ and arg_572_1.time_ <= 5.55111512312578e-17 + arg_575_0 then
				arg_572_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night", "")
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:AudioAction("play", "effect", "se_story_140", "se_story_140_tinnitus", "")
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum03", "")
			end

			if 0 < arg_572_1.time_ and arg_572_1.time_ <= 0 + arg_575_0 then
				arg_572_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_575_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_572_1.bgmTxt_.text ~= var_575_16 and arg_572_1.bgmTxt_.text ~= "" then
						if arg_572_1.bgmTxt2_.text ~= "" then
							arg_572_1.bgmTxt_.text = arg_572_1.bgmTxt2_.text
						end

						arg_572_1.bgmTxt2_.text = var_575_16

						arg_572_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_572_1.bgmTxt_.text = var_575_16
						arg_572_1.bgmTxt2_.text = var_575_16
					end

					if arg_572_1.bgmTimer then
						arg_572_1.bgmTimer:Stop()

						arg_572_1.bgmTimer = nil
					end

					if arg_572_1.settingData.show_music_name == 1 then
						arg_572_1.musicController:SetSelectedState("show")
						arg_572_1.musicAnimator_:Play("open", 0, 0)

						if arg_572_1.settingData.music_time ~= 0 then
							arg_572_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_572_1.settingData.music_time), function()
								if arg_572_1 == nil or isNil(arg_572_1.bgmTxt_) then
									return
								end

								arg_572_1.musicController:SetSelectedState("hide")
								arg_572_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_572_1.frameCnt_ <= 1 then
				arg_572_1.dialog_:SetActive(false)
			end

			local var_575_17 = 2
			local var_575_18 = 1.15

			if 2 < arg_572_1.time_ and arg_572_1.time_ <= var_575_17 + arg_575_0 then
				arg_572_1.talkMaxDuration = 0

				arg_572_1.dialog_:SetActive(true)

				arg_572_1.dialogCg_.alpha = 0

				local var_575_19 = LeanTween.value(arg_572_1.dialog_, 0, 1, 0.3)

				var_575_19:setOnUpdate(LuaHelper.FloatAction(function(arg_577_0)
					arg_572_1.dialogCg_.alpha = arg_577_0
				end))
				var_575_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_572_1.dialog_)
					var_575_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_572_1.duration_ = arg_572_1.duration_ + 0.3

				SetActive(arg_572_1.leftNameGo_, false)

				arg_572_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_572_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_572_1:RecordName(arg_572_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_572_1.iconTrs_.gameObject, false)
				arg_572_1.callingController_:SetSelectedState("normal")

				local var_575_20 = arg_572_1:FormatText(arg_572_1:GetWordFromCfg(924041137).content)

				arg_572_1.text_.text = var_575_20

				LuaForUtil.ClearLinePrefixSymbol(arg_572_1.text_)

				local var_575_22 = 46 <= 0 and var_575_18 or var_575_18 * (utf8.len(var_575_20) / 46)

				if (46 <= 0 and var_575_18 or var_575_18 * (utf8.len(var_575_20) / 46)) > 0 and var_575_18 < var_575_22 then
					arg_572_1.talkMaxDuration = var_575_22
					var_575_17 = var_575_17 + 0.3

					if var_575_22 + var_575_17 > arg_572_1.duration_ then
						arg_572_1.duration_ = var_575_22 + var_575_17
					end
				end

				arg_572_1.text_.text = var_575_20
				arg_572_1.typewritter.percent = 0

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(false)
				arg_572_1:RecordContent(arg_572_1.text_.text)
			end

			local var_575_23 = var_575_17 + 0.3
			local var_575_24 = math.max(var_575_18, arg_572_1.talkMaxDuration)

			if var_575_17 + 0.3 <= arg_572_1.time_ and arg_572_1.time_ < var_575_23 + var_575_24 then
				arg_572_1.typewritter.percent = (arg_572_1.time_ - var_575_23) / var_575_24

				arg_572_1.typewritter:SetDirty()
			end

			if arg_572_1.time_ >= var_575_23 + var_575_24 and arg_572_1.time_ < var_575_23 + var_575_24 + arg_575_0 then
				arg_572_1.typewritter.percent = 1

				arg_572_1.typewritter:SetDirty()
				arg_572_1:ShowNextGo(true)
			end
		end

		arg_572_1.nodeConfigList_ = {}

		arg_572_1:InitPlayNodeList()
	end,
	Play924041138 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 924041138
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play924041139(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			local var_582_0 = 0.825

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, false)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_1 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(924041138).content)

				arg_579_1.text_.text = var_582_1

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_3 = 33 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_1) / 33)

				if (33 <= 0 and var_582_0 or var_582_0 * (utf8.len(var_582_1) / 33)) > 0 and var_582_0 < var_582_3 then
					arg_579_1.talkMaxDuration = var_582_3

					if var_582_3 + 0 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_3 + 0
					end
				end

				arg_579_1.text_.text = var_582_1
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_4 = math.max(var_582_0, arg_579_1.talkMaxDuration)

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_4 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - 0) / var_582_4

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= 0 + var_582_4 and arg_579_1.time_ < 0 + var_582_4 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play924041139 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 924041139
		arg_583_1.duration_ = 5

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play924041140(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			local var_586_0 = 0.275

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, true)
				arg_583_1.iconController_:SetSelectedState("hero")

				arg_583_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_583_1.callingController_:SetSelectedState("normal")

				arg_583_1.keyicon_.color = Color.New(1, 1, 1)
				arg_583_1.icon_.color = Color.New(1, 1, 1)

				local var_586_1 = arg_583_1:FormatText(arg_583_1:GetWordFromCfg(924041139).content)

				arg_583_1.text_.text = var_586_1

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_3 = 11 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 11)

				if (11 <= 0 and var_586_0 or var_586_0 * (utf8.len(var_586_1) / 11)) > 0 and var_586_0 < var_586_3 then
					arg_583_1.talkMaxDuration = var_586_3

					if var_586_3 + 0 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_3 + 0
					end
				end

				arg_583_1.text_.text = var_586_1
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)
				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_4 = math.max(var_586_0, arg_583_1.talkMaxDuration)

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_4 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - 0) / var_586_4

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= 0 + var_586_4 and arg_583_1.time_ < 0 + var_586_4 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {}

		arg_583_1:InitPlayNodeList()
	end,
	Play924041140 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 924041140
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play924041141(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0.1 < arg_587_1.time_ and arg_587_1.time_ <= 0.1 + arg_590_0 then
				arg_587_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sofa", "")
			end

			local var_590_1 = 0
			local var_590_2 = 0.575

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_1 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_3 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(924041140).content)

				arg_587_1.text_.text = var_590_3

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_5 = 23 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 23)

				if (23 <= 0 and var_590_2 or var_590_2 * (utf8.len(var_590_3) / 23)) > 0 and var_590_2 < var_590_5 then
					arg_587_1.talkMaxDuration = var_590_5

					if var_590_5 + var_590_1 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_5 + var_590_1
					end
				end

				arg_587_1.text_.text = var_590_3
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_6 = math.max(var_590_2, arg_587_1.talkMaxDuration)

			if var_590_1 <= arg_587_1.time_ and arg_587_1.time_ < var_590_1 + var_590_6 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_1) / var_590_6

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_1 + var_590_6 and arg_587_1.time_ < var_590_1 + var_590_6 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play924041141 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 924041141
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play924041142(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.45

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(924041141).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 18 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 18)

				if (18 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 18)) > 0 and var_594_0 < var_594_3 then
					arg_591_1.talkMaxDuration = var_594_3

					if var_594_3 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_3 + 0
					end
				end

				arg_591_1.text_.text = var_594_1
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_4 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_4 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_4

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_4 and arg_591_1.time_ < 0 + var_594_4 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play924041142 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 924041142
		arg_595_1.duration_ = 4.83

		local var_595_0 = {
			zh = 2.6,
			ja = 4.833
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play924041143(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 0.25

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_1 = arg_595_1:GetWordFromCfg(924041142)
				local var_598_2 = arg_595_1:FormatText(var_598_1.content)

				arg_595_1.text_.text = var_598_2

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 10 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 10)

				if (10 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 10)) > 0 and var_598_0 < var_598_4 then
					arg_595_1.talkMaxDuration = var_598_4

					if var_598_4 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_4 + 0
					end
				end

				arg_595_1.text_.text = var_598_2
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb") ~= 0 then
					local var_598_5 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb") / 1000

					if var_598_5 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_5 + 0
					end

					if var_598_1.prefab_name ~= "" and arg_595_1.actors_[var_598_1.prefab_name] ~= nil then
						local var_598_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_1.prefab_name].transform, "story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb")

						arg_595_1:RecordAudio("924041142", var_598_6)
						arg_595_1:RecordAudio("924041142", var_598_6)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041142", "story_v_side_old_924041.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_7 and arg_595_1.time_ < 0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play924041143 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 924041143
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play924041144(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0.325

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_1 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(924041143).content)

				arg_599_1.text_.text = var_602_1

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_3 = 13 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 13)

				if (13 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 13)) > 0 and var_602_0 < var_602_3 then
					arg_599_1.talkMaxDuration = var_602_3

					if var_602_3 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_3 + 0
					end
				end

				arg_599_1.text_.text = var_602_1
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_4 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_4 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_4

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_4 and arg_599_1.time_ < 0 + var_602_4 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play924041144 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 924041144
		arg_603_1.duration_ = 8.5

		local var_603_0 = {
			zh = 6.633,
			ja = 8.5
		}
		local var_603_1 = manager.audio:GetLocalizationFlag()

		if var_603_0[var_603_1] ~= nil then
			arg_603_1.duration_ = var_603_0[var_603_1]
		end

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play924041145(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0.55

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, true)
				arg_603_1.iconController_:SetSelectedState("hero")

				arg_603_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_603_1.callingController_:SetSelectedState("normal")

				arg_603_1.keyicon_.color = Color.New(1, 1, 1)
				arg_603_1.icon_.color = Color.New(1, 1, 1)

				local var_606_1 = arg_603_1:GetWordFromCfg(924041144)
				local var_606_2 = arg_603_1:FormatText(var_606_1.content)

				arg_603_1.text_.text = var_606_2

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_4 = 22 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_2) / 22)

				if (22 <= 0 and var_606_0 or var_606_0 * (utf8.len(var_606_2) / 22)) > 0 and var_606_0 < var_606_4 then
					arg_603_1.talkMaxDuration = var_606_4

					if var_606_4 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_4 + 0
					end
				end

				arg_603_1.text_.text = var_606_2
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb") ~= 0 then
					local var_606_5 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb") / 1000

					if var_606_5 + 0 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_5 + 0
					end

					if var_606_1.prefab_name ~= "" and arg_603_1.actors_[var_606_1.prefab_name] ~= nil then
						local var_606_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_1.prefab_name].transform, "story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb")

						arg_603_1:RecordAudio("924041144", var_606_6)
						arg_603_1:RecordAudio("924041144", var_606_6)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041144", "story_v_side_old_924041.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_7 = math.max(var_606_0, arg_603_1.talkMaxDuration)

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_7 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - 0) / var_606_7

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= 0 + var_606_7 and arg_603_1.time_ < 0 + var_606_7 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play924041145 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 924041145
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play924041146(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0.3

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_1 = arg_607_1:FormatText(arg_607_1:GetWordFromCfg(924041145).content)

				arg_607_1.text_.text = var_610_1

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_3 = 12 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_1) / 12)

				if (12 <= 0 and var_610_0 or var_610_0 * (utf8.len(var_610_1) / 12)) > 0 and var_610_0 < var_610_3 then
					arg_607_1.talkMaxDuration = var_610_3

					if var_610_3 + 0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_3 + 0
					end
				end

				arg_607_1.text_.text = var_610_1
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_4 = math.max(var_610_0, arg_607_1.talkMaxDuration)

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_4 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - 0) / var_610_4

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= 0 + var_610_4 and arg_607_1.time_ < 0 + var_610_4 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play924041146 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 924041146
		arg_611_1.duration_ = 3.47

		local var_611_0 = {
			zh = 2.9,
			ja = 3.466
		}
		local var_611_1 = manager.audio:GetLocalizationFlag()

		if var_611_0[var_611_1] ~= nil then
			arg_611_1.duration_ = var_611_0[var_611_1]
		end

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play924041147(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.var_.moveOldPos102003ui_story = arg_611_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_614_0 = 0.001

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_0 then
				arg_611_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_611_1.time_ - 0) / var_614_0)
				arg_611_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_611_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_611_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_611_1.actors_["102003ui_story"].transform.position).z)
				arg_611_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_611_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_611_1.actors_["102003ui_story"].transform.localEulerAngles = arg_611_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_611_1.time_ >= 0 + var_614_0 and arg_611_1.time_ < 0 + var_614_0 + arg_614_0 then
				arg_611_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_611_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_611_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_611_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_611_1.actors_["102003ui_story"].transform.position).z)
				arg_611_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_611_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_611_1.actors_["102003ui_story"].transform.localEulerAngles = arg_611_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_614_1 = arg_611_1.actors_["102003ui_story"]

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 and not isNil(var_614_1) and arg_611_1.var_.characterEffect102003ui_story == nil then
				arg_611_1.var_.characterEffect102003ui_story = var_614_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.200000002980232

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_2 and not isNil(var_614_1) then
				if arg_611_1.var_.characterEffect102003ui_story and not isNil(var_614_1) then
					arg_611_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= 0 + var_614_2 and arg_611_1.time_ < 0 + var_614_2 + arg_614_0 and not isNil(var_614_1) and arg_611_1.var_.characterEffect102003ui_story then
				arg_611_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0.125 < arg_611_1.time_ and arg_611_1.time_ <= 0.125 + arg_614_0 then
				arg_611_1:AudioAction("play", "effect", "se_story_141", "se_story_141_knock", "")
			end

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_614_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_611_1.bgmTxt_.text ~= var_614_7 and arg_611_1.bgmTxt_.text ~= "" then
						if arg_611_1.bgmTxt2_.text ~= "" then
							arg_611_1.bgmTxt_.text = arg_611_1.bgmTxt2_.text
						end

						arg_611_1.bgmTxt2_.text = var_614_7

						arg_611_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_611_1.bgmTxt_.text = var_614_7
						arg_611_1.bgmTxt2_.text = var_614_7
					end

					if arg_611_1.bgmTimer then
						arg_611_1.bgmTimer:Stop()

						arg_611_1.bgmTimer = nil
					end

					if arg_611_1.settingData.show_music_name == 1 then
						arg_611_1.musicController:SetSelectedState("show")
						arg_611_1.musicAnimator_:Play("open", 0, 0)

						if arg_611_1.settingData.music_time ~= 0 then
							arg_611_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_611_1.settingData.music_time), function()
								if arg_611_1 == nil or isNil(arg_611_1.bgmTxt_) then
									return
								end

								arg_611_1.musicController:SetSelectedState("hide")
								arg_611_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_611_1.time_ and arg_611_1.time_ <= 0.4 + arg_614_0 then
				arg_611_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_614_10 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_611_1.bgmTxt_.text ~= var_614_10 and arg_611_1.bgmTxt_.text ~= "" then
						if arg_611_1.bgmTxt2_.text ~= "" then
							arg_611_1.bgmTxt_.text = arg_611_1.bgmTxt2_.text
						end

						arg_611_1.bgmTxt2_.text = var_614_10

						arg_611_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_611_1.bgmTxt_.text = var_614_10
						arg_611_1.bgmTxt2_.text = var_614_10
					end

					if arg_611_1.bgmTimer then
						arg_611_1.bgmTimer:Stop()

						arg_611_1.bgmTimer = nil
					end

					if arg_611_1.settingData.show_music_name == 1 then
						arg_611_1.musicController:SetSelectedState("show")
						arg_611_1.musicAnimator_:Play("open", 0, 0)

						if arg_611_1.settingData.music_time ~= 0 then
							arg_611_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_611_1.settingData.music_time), function()
								if arg_611_1 == nil or isNil(arg_611_1.bgmTxt_) then
									return
								end

								arg_611_1.musicController:SetSelectedState("hide")
								arg_611_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_614_11 = 0
			local var_614_12 = 0.225

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_11 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				arg_611_1.leftNameTxt_.text = arg_611_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_13 = arg_611_1:GetWordFromCfg(924041146)
				local var_614_14 = arg_611_1:FormatText(var_614_13.content)

				arg_611_1.text_.text = var_614_14

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_16 = 9 <= 0 and var_614_12 or var_614_12 * (utf8.len(var_614_14) / 9)

				if (9 <= 0 and var_614_12 or var_614_12 * (utf8.len(var_614_14) / 9)) > 0 and var_614_12 < var_614_16 then
					arg_611_1.talkMaxDuration = var_614_16

					if var_614_16 + var_614_11 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_16 + var_614_11
					end
				end

				arg_611_1.text_.text = var_614_14
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb") ~= 0 then
					local var_614_17 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb") / 1000

					if var_614_17 + var_614_11 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_17 + var_614_11
					end

					if var_614_13.prefab_name ~= "" and arg_611_1.actors_[var_614_13.prefab_name] ~= nil then
						local var_614_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_13.prefab_name].transform, "story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb")

						arg_611_1:RecordAudio("924041146", var_614_18)
						arg_611_1:RecordAudio("924041146", var_614_18)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041146", "story_v_side_old_924041.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_19 = math.max(var_614_12, arg_611_1.talkMaxDuration)

			if var_614_11 <= arg_611_1.time_ and arg_611_1.time_ < var_614_11 + var_614_19 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_11) / var_614_19

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_11 + var_614_19 and arg_611_1.time_ < var_614_11 + var_614_19 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_611_1:InitPlayNodeList()
	end,
	Play924041147 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 924041147
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play924041148(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.var_.moveOldPos102003ui_story = arg_617_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_620_0 = 0.001

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 then
				arg_617_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_617_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_617_1.time_ - 0) / var_620_0)
				arg_617_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_617_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["102003ui_story"].transform.position).z)
				arg_617_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_617_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_617_1.actors_["102003ui_story"].transform.localEulerAngles = arg_617_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 then
				arg_617_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_617_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_617_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["102003ui_story"].transform.position).z)
				arg_617_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_617_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_617_1.actors_["102003ui_story"].transform.localEulerAngles = arg_617_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_620_1 = arg_617_1.actors_["102003ui_story"]

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(var_620_1) and arg_617_1.var_.characterEffect102003ui_story == nil then
				arg_617_1.var_.characterEffect102003ui_story = var_620_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_2 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_2 and not isNil(var_620_1) then
				if arg_617_1.var_.characterEffect102003ui_story and not isNil(var_620_1) then
					arg_617_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_617_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_617_1.time_ - 0) / var_620_2)
				end
			end

			if arg_617_1.time_ >= 0 + var_620_2 and arg_617_1.time_ < 0 + var_620_2 + arg_620_0 and not isNil(var_620_1) and arg_617_1.var_.characterEffect102003ui_story then
				arg_617_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_617_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_620_3 = 0
			local var_620_4 = 0.725

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_3 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, false)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_5 = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(924041147).content)

				arg_617_1.text_.text = var_620_5

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_7 = 29 <= 0 and var_620_4 or var_620_4 * (utf8.len(var_620_5) / 29)

				if (29 <= 0 and var_620_4 or var_620_4 * (utf8.len(var_620_5) / 29)) > 0 and var_620_4 < var_620_7 then
					arg_617_1.talkMaxDuration = var_620_7

					if var_620_7 + var_620_3 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_7 + var_620_3
					end
				end

				arg_617_1.text_.text = var_620_5
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_8 = math.max(var_620_4, arg_617_1.talkMaxDuration)

			if var_620_3 <= arg_617_1.time_ and arg_617_1.time_ < var_620_3 + var_620_8 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_3) / var_620_8

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_3 + var_620_8 and arg_617_1.time_ < var_620_3 + var_620_8 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_617_1:InitPlayNodeList()
	end,
	Play924041148 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 924041148
		arg_621_1.duration_ = 5.77

		local var_621_0 = {
			zh = 5.2,
			ja = 5.766
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play924041149(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.var_.moveOldPos102003ui_story = arg_621_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_624_0 = 0.001

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_0 then
				arg_621_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_621_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_621_1.time_ - 0) / var_624_0)
				arg_621_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_621_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_621_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_621_1.actors_["102003ui_story"].transform.position).z)
				arg_621_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_621_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_621_1.actors_["102003ui_story"].transform.localEulerAngles = arg_621_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_621_1.time_ >= 0 + var_624_0 and arg_621_1.time_ < 0 + var_624_0 + arg_624_0 then
				arg_621_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_621_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_621_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_621_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_621_1.actors_["102003ui_story"].transform.position).z)
				arg_621_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_621_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_621_1.actors_["102003ui_story"].transform.localEulerAngles = arg_621_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_624_1 = arg_621_1.actors_["102003ui_story"]

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 and not isNil(var_624_1) and arg_621_1.var_.characterEffect102003ui_story == nil then
				arg_621_1.var_.characterEffect102003ui_story = var_624_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_2 = 0.200000002980232

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_2 and not isNil(var_624_1) then
				if arg_621_1.var_.characterEffect102003ui_story and not isNil(var_624_1) then
					arg_621_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_621_1.time_ >= 0 + var_624_2 and arg_621_1.time_ < 0 + var_624_2 + arg_624_0 and not isNil(var_624_1) and arg_621_1.var_.characterEffect102003ui_story then
				arg_621_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action483")
			end

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_624_4 = 0
			local var_624_5 = 0.55

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_4 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_6 = arg_621_1:GetWordFromCfg(924041148)
				local var_624_7 = arg_621_1:FormatText(var_624_6.content)

				arg_621_1.text_.text = var_624_7

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_9 = 22 <= 0 and var_624_5 or var_624_5 * (utf8.len(var_624_7) / 22)

				if (22 <= 0 and var_624_5 or var_624_5 * (utf8.len(var_624_7) / 22)) > 0 and var_624_5 < var_624_9 then
					arg_621_1.talkMaxDuration = var_624_9

					if var_624_9 + var_624_4 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_9 + var_624_4
					end
				end

				arg_621_1.text_.text = var_624_7
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb") ~= 0 then
					local var_624_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb") / 1000

					if var_624_10 + var_624_4 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_10 + var_624_4
					end

					if var_624_6.prefab_name ~= "" and arg_621_1.actors_[var_624_6.prefab_name] ~= nil then
						local var_624_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_6.prefab_name].transform, "story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb")

						arg_621_1:RecordAudio("924041148", var_624_11)
						arg_621_1:RecordAudio("924041148", var_624_11)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041148", "story_v_side_old_924041.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_12 = math.max(var_624_5, arg_621_1.talkMaxDuration)

			if var_624_4 <= arg_621_1.time_ and arg_621_1.time_ < var_624_4 + var_624_12 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_4) / var_624_12

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_4 + var_624_12 and arg_621_1.time_ < var_624_4 + var_624_12 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_621_1:InitPlayNodeList()
	end,
	Play924041149 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 924041149
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play924041150(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 and not isNil(arg_625_1.actors_["102003ui_story"]) and arg_625_1.var_.characterEffect102003ui_story == nil then
				arg_625_1.var_.characterEffect102003ui_story = arg_625_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_0 = 0.200000002980232

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_0 and not isNil(arg_625_1.actors_["102003ui_story"]) then
				if arg_625_1.var_.characterEffect102003ui_story and not isNil(arg_625_1.actors_["102003ui_story"]) then
					arg_625_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_625_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_625_1.time_ - 0) / var_628_0)
				end
			end

			if arg_625_1.time_ >= 0 + var_628_0 and arg_625_1.time_ < 0 + var_628_0 + arg_628_0 and not isNil(arg_625_1.actors_["102003ui_story"]) and arg_625_1.var_.characterEffect102003ui_story then
				arg_625_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_625_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_628_1 = 0
			local var_628_2 = 0.2

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_1 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, true)
				arg_625_1.iconController_:SetSelectedState("hero")

				arg_625_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_625_1.callingController_:SetSelectedState("normal")

				arg_625_1.keyicon_.color = Color.New(1, 1, 1)
				arg_625_1.icon_.color = Color.New(1, 1, 1)

				local var_628_3 = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(924041149).content)

				arg_625_1.text_.text = var_628_3

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_5 = 8 <= 0 and var_628_2 or var_628_2 * (utf8.len(var_628_3) / 8)

				if (8 <= 0 and var_628_2 or var_628_2 * (utf8.len(var_628_3) / 8)) > 0 and var_628_2 < var_628_5 then
					arg_625_1.talkMaxDuration = var_628_5

					if var_628_5 + var_628_1 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_5 + var_628_1
					end
				end

				arg_625_1.text_.text = var_628_3
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_6 = math.max(var_628_2, arg_625_1.talkMaxDuration)

			if var_628_1 <= arg_625_1.time_ and arg_625_1.time_ < var_628_1 + var_628_6 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_1) / var_628_6

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_1 + var_628_6 and arg_625_1.time_ < var_628_1 + var_628_6 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play924041150 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 924041150
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play924041151(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 1.15

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_1 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(924041150).content)

				arg_629_1.text_.text = var_632_1

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_3 = 46 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 46)

				if (46 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 46)) > 0 and var_632_0 < var_632_3 then
					arg_629_1.talkMaxDuration = var_632_3

					if var_632_3 + 0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_3 + 0
					end
				end

				arg_629_1.text_.text = var_632_1
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_4 = math.max(var_632_0, arg_629_1.talkMaxDuration)

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_4 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - 0) / var_632_4

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= 0 + var_632_4 and arg_629_1.time_ < 0 + var_632_4 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play924041151 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 924041151
		arg_633_1.duration_ = 3.7

		local var_633_0 = {
			zh = 2.4,
			ja = 3.7
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play924041152(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1.var_.moveOldPos102003ui_story = arg_633_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_636_0 = 0.001

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_0 then
				arg_633_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_633_1.time_ - 0) / var_636_0)
				arg_633_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_633_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["102003ui_story"].transform.position).z)
				arg_633_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_633_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_633_1.actors_["102003ui_story"].transform.localEulerAngles = arg_633_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_633_1.time_ >= 0 + var_636_0 and arg_633_1.time_ < 0 + var_636_0 + arg_636_0 then
				arg_633_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_633_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_633_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["102003ui_story"].transform.position).z)
				arg_633_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_633_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_633_1.actors_["102003ui_story"].transform.localEulerAngles = arg_633_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_636_1 = arg_633_1.actors_["102003ui_story"]

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 and not isNil(var_636_1) and arg_633_1.var_.characterEffect102003ui_story == nil then
				arg_633_1.var_.characterEffect102003ui_story = var_636_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_2 = 0.200000002980232

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_2 and not isNil(var_636_1) then
				if arg_633_1.var_.characterEffect102003ui_story and not isNil(var_636_1) then
					arg_633_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= 0 + var_636_2 and arg_633_1.time_ < 0 + var_636_2 + arg_636_0 and not isNil(var_636_1) and arg_633_1.var_.characterEffect102003ui_story then
				arg_633_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action438")
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_636_4 = 0
			local var_636_5 = 0.25

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_4 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_6 = arg_633_1:GetWordFromCfg(924041151)
				local var_636_7 = arg_633_1:FormatText(var_636_6.content)

				arg_633_1.text_.text = var_636_7

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_9 = 10 <= 0 and var_636_5 or var_636_5 * (utf8.len(var_636_7) / 10)

				if (10 <= 0 and var_636_5 or var_636_5 * (utf8.len(var_636_7) / 10)) > 0 and var_636_5 < var_636_9 then
					arg_633_1.talkMaxDuration = var_636_9

					if var_636_9 + var_636_4 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_9 + var_636_4
					end
				end

				arg_633_1.text_.text = var_636_7
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb") ~= 0 then
					local var_636_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb") / 1000

					if var_636_10 + var_636_4 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_10 + var_636_4
					end

					if var_636_6.prefab_name ~= "" and arg_633_1.actors_[var_636_6.prefab_name] ~= nil then
						local var_636_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_6.prefab_name].transform, "story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb")

						arg_633_1:RecordAudio("924041151", var_636_11)
						arg_633_1:RecordAudio("924041151", var_636_11)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041151", "story_v_side_old_924041.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_12 = math.max(var_636_5, arg_633_1.talkMaxDuration)

			if var_636_4 <= arg_633_1.time_ and arg_633_1.time_ < var_636_4 + var_636_12 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_4) / var_636_12

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_4 + var_636_12 and arg_633_1.time_ < var_636_4 + var_636_12 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play924041152 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 924041152
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play924041153(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 then
				arg_637_1.var_.moveOldPos102003ui_story = arg_637_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_640_0 = 0.001

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_0 then
				arg_637_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_637_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_637_1.time_ - 0) / var_640_0)
				arg_637_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_637_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_637_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_637_1.actors_["102003ui_story"].transform.position).z)
				arg_637_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_637_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_637_1.actors_["102003ui_story"].transform.localEulerAngles = arg_637_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_637_1.time_ >= 0 + var_640_0 and arg_637_1.time_ < 0 + var_640_0 + arg_640_0 then
				arg_637_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_637_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_637_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_637_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_637_1.actors_["102003ui_story"].transform.position).z)
				arg_637_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_637_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_637_1.actors_["102003ui_story"].transform.localEulerAngles = arg_637_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_640_1 = arg_637_1.actors_["102003ui_story"]

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 and not isNil(var_640_1) and arg_637_1.var_.characterEffect102003ui_story == nil then
				arg_637_1.var_.characterEffect102003ui_story = var_640_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_2 = 0.200000002980232

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_2 and not isNil(var_640_1) then
				if arg_637_1.var_.characterEffect102003ui_story and not isNil(var_640_1) then
					arg_637_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_637_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_637_1.time_ - 0) / var_640_2)
				end
			end

			if arg_637_1.time_ >= 0 + var_640_2 and arg_637_1.time_ < 0 + var_640_2 + arg_640_0 and not isNil(var_640_1) and arg_637_1.var_.characterEffect102003ui_story then
				arg_637_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_637_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_640_3 = 0
			local var_640_4 = 0.775

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_3 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, false)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_5 = arg_637_1:FormatText(arg_637_1:GetWordFromCfg(924041152).content)

				arg_637_1.text_.text = var_640_5

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_7 = 31 <= 0 and var_640_4 or var_640_4 * (utf8.len(var_640_5) / 31)

				if (31 <= 0 and var_640_4 or var_640_4 * (utf8.len(var_640_5) / 31)) > 0 and var_640_4 < var_640_7 then
					arg_637_1.talkMaxDuration = var_640_7

					if var_640_7 + var_640_3 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_7 + var_640_3
					end
				end

				arg_637_1.text_.text = var_640_5
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_8 = math.max(var_640_4, arg_637_1.talkMaxDuration)

			if var_640_3 <= arg_637_1.time_ and arg_637_1.time_ < var_640_3 + var_640_8 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_3) / var_640_8

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_3 + var_640_8 and arg_637_1.time_ < var_640_3 + var_640_8 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_637_1:InitPlayNodeList()
	end,
	Play924041153 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 924041153
		arg_641_1.duration_ = 4.87

		local var_641_0 = {
			zh = 3.733,
			ja = 4.866
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play924041154(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.var_.moveOldPos102003ui_story = arg_641_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_644_0 = 0.001

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_0 then
				arg_641_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_641_1.time_ - 0) / var_644_0)
				arg_641_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_641_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["102003ui_story"].transform.position).z)
				arg_641_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_641_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_641_1.actors_["102003ui_story"].transform.localEulerAngles = arg_641_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_641_1.time_ >= 0 + var_644_0 and arg_641_1.time_ < 0 + var_644_0 + arg_644_0 then
				arg_641_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_641_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_641_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["102003ui_story"].transform.position).z)
				arg_641_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_641_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_641_1.actors_["102003ui_story"].transform.localEulerAngles = arg_641_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_644_1 = arg_641_1.actors_["102003ui_story"]

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 and not isNil(var_644_1) and arg_641_1.var_.characterEffect102003ui_story == nil then
				arg_641_1.var_.characterEffect102003ui_story = var_644_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_2 = 0.200000002980232

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_2 and not isNil(var_644_1) then
				if arg_641_1.var_.characterEffect102003ui_story and not isNil(var_644_1) then
					arg_641_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= 0 + var_644_2 and arg_641_1.time_ < 0 + var_644_2 + arg_644_0 and not isNil(var_644_1) and arg_641_1.var_.characterEffect102003ui_story then
				arg_641_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action5_1")
			end

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_644_4 = 0
			local var_644_5 = 0.45

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_4 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_6 = arg_641_1:GetWordFromCfg(924041153)
				local var_644_7 = arg_641_1:FormatText(var_644_6.content)

				arg_641_1.text_.text = var_644_7

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_9 = 18 <= 0 and var_644_5 or var_644_5 * (utf8.len(var_644_7) / 18)

				if (18 <= 0 and var_644_5 or var_644_5 * (utf8.len(var_644_7) / 18)) > 0 and var_644_5 < var_644_9 then
					arg_641_1.talkMaxDuration = var_644_9

					if var_644_9 + var_644_4 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_9 + var_644_4
					end
				end

				arg_641_1.text_.text = var_644_7
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb") ~= 0 then
					local var_644_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb") / 1000

					if var_644_10 + var_644_4 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_10 + var_644_4
					end

					if var_644_6.prefab_name ~= "" and arg_641_1.actors_[var_644_6.prefab_name] ~= nil then
						local var_644_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_6.prefab_name].transform, "story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb")

						arg_641_1:RecordAudio("924041153", var_644_11)
						arg_641_1:RecordAudio("924041153", var_644_11)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041153", "story_v_side_old_924041.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_12 = math.max(var_644_5, arg_641_1.talkMaxDuration)

			if var_644_4 <= arg_641_1.time_ and arg_641_1.time_ < var_644_4 + var_644_12 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_4) / var_644_12

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_4 + var_644_12 and arg_641_1.time_ < var_644_4 + var_644_12 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_641_1:InitPlayNodeList()
	end,
	Play924041154 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 924041154
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play924041155(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 and not isNil(arg_645_1.actors_["102003ui_story"]) and arg_645_1.var_.characterEffect102003ui_story == nil then
				arg_645_1.var_.characterEffect102003ui_story = arg_645_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_0 = 0.200000002980232

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_0 and not isNil(arg_645_1.actors_["102003ui_story"]) then
				if arg_645_1.var_.characterEffect102003ui_story and not isNil(arg_645_1.actors_["102003ui_story"]) then
					arg_645_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_645_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_645_1.time_ - 0) / var_648_0)
				end
			end

			if arg_645_1.time_ >= 0 + var_648_0 and arg_645_1.time_ < 0 + var_648_0 + arg_648_0 and not isNil(arg_645_1.actors_["102003ui_story"]) and arg_645_1.var_.characterEffect102003ui_story then
				arg_645_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_645_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_648_1 = 0
			local var_648_2 = 0.175

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, true)
				arg_645_1.iconController_:SetSelectedState("hero")

				arg_645_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_645_1.callingController_:SetSelectedState("normal")

				arg_645_1.keyicon_.color = Color.New(1, 1, 1)
				arg_645_1.icon_.color = Color.New(1, 1, 1)

				local var_648_3 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(924041154).content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 7 <= 0 and var_648_2 or var_648_2 * (utf8.len(var_648_3) / 7)

				if (7 <= 0 and var_648_2 or var_648_2 * (utf8.len(var_648_3) / 7)) > 0 and var_648_2 < var_648_5 then
					arg_645_1.talkMaxDuration = var_648_5

					if var_648_5 + var_648_1 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_5 + var_648_1
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_6 = math.max(var_648_2, arg_645_1.talkMaxDuration)

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_6 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_1) / var_648_6

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_1 + var_648_6 and arg_645_1.time_ < var_648_1 + var_648_6 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play924041155 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 924041155
		arg_649_1.duration_ = 3.47

		local var_649_0 = {
			zh = 3.266,
			ja = 3.466
		}
		local var_649_1 = manager.audio:GetLocalizationFlag()

		if var_649_0[var_649_1] ~= nil then
			arg_649_1.duration_ = var_649_0[var_649_1]
		end

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play924041156(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 and not isNil(arg_649_1.actors_["102003ui_story"]) and arg_649_1.var_.characterEffect102003ui_story == nil then
				arg_649_1.var_.characterEffect102003ui_story = arg_649_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_0 = 0.200000002980232

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_0 and not isNil(arg_649_1.actors_["102003ui_story"]) then
				if arg_649_1.var_.characterEffect102003ui_story and not isNil(arg_649_1.actors_["102003ui_story"]) then
					arg_649_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_649_1.time_ >= 0 + var_652_0 and arg_649_1.time_ < 0 + var_652_0 + arg_652_0 and not isNil(arg_649_1.actors_["102003ui_story"]) and arg_649_1.var_.characterEffect102003ui_story then
				arg_649_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action453")
			end

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_652_2 = 0
			local var_652_3 = 0.175

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_2 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_4 = arg_649_1:GetWordFromCfg(924041155)
				local var_652_5 = arg_649_1:FormatText(var_652_4.content)

				arg_649_1.text_.text = var_652_5

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_7 = 7 <= 0 and var_652_3 or var_652_3 * (utf8.len(var_652_5) / 7)

				if (7 <= 0 and var_652_3 or var_652_3 * (utf8.len(var_652_5) / 7)) > 0 and var_652_3 < var_652_7 then
					arg_649_1.talkMaxDuration = var_652_7

					if var_652_7 + var_652_2 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_7 + var_652_2
					end
				end

				arg_649_1.text_.text = var_652_5
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb") ~= 0 then
					local var_652_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb") / 1000

					if var_652_8 + var_652_2 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_8 + var_652_2
					end

					if var_652_4.prefab_name ~= "" and arg_649_1.actors_[var_652_4.prefab_name] ~= nil then
						local var_652_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_649_1.actors_[var_652_4.prefab_name].transform, "story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb")

						arg_649_1:RecordAudio("924041155", var_652_9)
						arg_649_1:RecordAudio("924041155", var_652_9)
					else
						arg_649_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb")
					end

					arg_649_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041155", "story_v_side_old_924041.awb")
				end

				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_10 = math.max(var_652_3, arg_649_1.talkMaxDuration)

			if var_652_2 <= arg_649_1.time_ and arg_649_1.time_ < var_652_2 + var_652_10 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_2) / var_652_10

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_2 + var_652_10 and arg_649_1.time_ < var_652_2 + var_652_10 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play924041156 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 924041156
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play924041157(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.var_.moveOldPos102003ui_story = arg_653_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_656_0 = 0.001

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_0 then
				arg_653_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_653_1.time_ - 0) / var_656_0)
				arg_653_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_653_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["102003ui_story"].transform.position).z)
				arg_653_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_653_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_653_1.actors_["102003ui_story"].transform.localEulerAngles = arg_653_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_653_1.time_ >= 0 + var_656_0 and arg_653_1.time_ < 0 + var_656_0 + arg_656_0 then
				arg_653_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_653_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_653_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["102003ui_story"].transform.position).z)
				arg_653_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_653_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_653_1.actors_["102003ui_story"].transform.localEulerAngles = arg_653_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_656_1 = arg_653_1.actors_["102003ui_story"]

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 and not isNil(var_656_1) and arg_653_1.var_.characterEffect102003ui_story == nil then
				arg_653_1.var_.characterEffect102003ui_story = var_656_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_2 = 0.200000002980232

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_2 and not isNil(var_656_1) then
				if arg_653_1.var_.characterEffect102003ui_story and not isNil(var_656_1) then
					arg_653_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_653_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_653_1.time_ - 0) / var_656_2)
				end
			end

			if arg_653_1.time_ >= 0 + var_656_2 and arg_653_1.time_ < 0 + var_656_2 + arg_656_0 and not isNil(var_656_1) and arg_653_1.var_.characterEffect102003ui_story then
				arg_653_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_653_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_656_3 = 0
			local var_656_4 = 0.525

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_3 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_5 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(924041156).content)

				arg_653_1.text_.text = var_656_5

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_7 = 21 <= 0 and var_656_4 or var_656_4 * (utf8.len(var_656_5) / 21)

				if (21 <= 0 and var_656_4 or var_656_4 * (utf8.len(var_656_5) / 21)) > 0 and var_656_4 < var_656_7 then
					arg_653_1.talkMaxDuration = var_656_7

					if var_656_7 + var_656_3 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_7 + var_656_3
					end
				end

				arg_653_1.text_.text = var_656_5
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_8 = math.max(var_656_4, arg_653_1.talkMaxDuration)

			if var_656_3 <= arg_653_1.time_ and arg_653_1.time_ < var_656_3 + var_656_8 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_3) / var_656_8

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_3 + var_656_8 and arg_653_1.time_ < var_656_3 + var_656_8 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_653_1:InitPlayNodeList()
	end,
	Play924041157 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 924041157
		arg_657_1.duration_ = 9

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play924041158(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 2 < arg_657_1.time_ and arg_657_1.time_ <= 2 + arg_660_0 then
				local var_660_0 = arg_657_1.bgs_.STblack

				arg_657_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_660_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_660_1 = var_660_0:GetComponent("SpriteRenderer")

				if var_660_1 and var_660_1.sprite then
					local var_660_2 = 2 * (var_660_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_660_0.transform.localScale = Vector3.New(var_660_2 / var_660_1.sprite.bounds.size.y < var_660_2 * manager.ui.mainCameraCom_.aspect / var_660_1.sprite.bounds.size.x and var_660_2 * manager.ui.mainCameraCom_.aspect / var_660_1.sprite.bounds.size.x or var_660_2 / var_660_1.sprite.bounds.size.y, var_660_2 / var_660_1.sprite.bounds.size.y < var_660_2 * manager.ui.mainCameraCom_.aspect / var_660_1.sprite.bounds.size.x and var_660_2 * manager.ui.mainCameraCom_.aspect / var_660_1.sprite.bounds.size.x or var_660_2 / var_660_1.sprite.bounds.size.y, 0)
				end

				for iter_660_0, iter_660_1 in pairs(arg_657_1.bgs_) do
					if iter_660_0 ~= "STblack" then
						iter_660_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_660_3 = 4

			if 4 < arg_657_1.time_ and arg_657_1.time_ <= var_660_3 + arg_660_0 then
				arg_657_1.allBtn_.enabled = false
			end

			if arg_657_1.time_ >= var_660_3 + 0.3 and arg_657_1.time_ < var_660_3 + 0.3 + arg_660_0 then
				arg_657_1.allBtn_.enabled = true
			end

			local var_660_4 = 0

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_4 + arg_660_0 then
				arg_657_1.mask_.enabled = true
				arg_657_1.mask_.raycastTarget = true

				arg_657_1:SetGaussion(false)
			end

			local var_660_5 = 2

			if var_660_4 <= arg_657_1.time_ and arg_657_1.time_ < var_660_4 + var_660_5 then
				local var_660_6 = Color.New(0, 0, 0)

				var_660_6.a = Mathf.Lerp(0, 1, (arg_657_1.time_ - var_660_4) / var_660_5)
				arg_657_1.mask_.color = var_660_6
			end

			if arg_657_1.time_ >= var_660_4 + var_660_5 and arg_657_1.time_ < var_660_4 + var_660_5 + arg_660_0 then
				local var_660_7 = Color.New(0, 0, 0)

				var_660_7.a = 1
				arg_657_1.mask_.color = var_660_7
			end

			local var_660_8 = 2

			if 2 < arg_657_1.time_ and arg_657_1.time_ <= var_660_8 + arg_660_0 then
				arg_657_1.mask_.enabled = true
				arg_657_1.mask_.raycastTarget = true

				arg_657_1:SetGaussion(false)
			end

			local var_660_9 = 2

			if var_660_8 <= arg_657_1.time_ and arg_657_1.time_ < var_660_8 + var_660_9 then
				local var_660_10 = Color.New(0, 0, 0)

				var_660_10.a = Mathf.Lerp(1, 0, (arg_657_1.time_ - var_660_8) / var_660_9)
				arg_657_1.mask_.color = var_660_10
			end

			if arg_657_1.time_ >= var_660_8 + var_660_9 and arg_657_1.time_ < var_660_8 + var_660_9 + arg_660_0 then
				local var_660_11 = Color.New(0, 0, 0)

				arg_657_1.mask_.enabled = false
				var_660_11.a = 0
				arg_657_1.mask_.color = var_660_11
			end

			if arg_657_1.frameCnt_ <= 1 then
				arg_657_1.dialog_:SetActive(false)
			end

			local var_660_12 = 4
			local var_660_13 = 1.15

			if 4 < arg_657_1.time_ and arg_657_1.time_ <= var_660_12 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0

				arg_657_1.dialog_:SetActive(true)

				arg_657_1.dialogCg_.alpha = 0

				local var_660_14 = LeanTween.value(arg_657_1.dialog_, 0, 1, 0.3)

				var_660_14:setOnUpdate(LuaHelper.FloatAction(function(arg_661_0)
					arg_657_1.dialogCg_.alpha = arg_661_0
				end))
				var_660_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_657_1.dialog_)
					var_660_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_657_1.duration_ = arg_657_1.duration_ + 0.3

				SetActive(arg_657_1.leftNameGo_, false)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_15 = arg_657_1:FormatText(arg_657_1:GetWordFromCfg(924041157).content)

				arg_657_1.text_.text = var_660_15

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_17 = 46 <= 0 and var_660_13 or var_660_13 * (utf8.len(var_660_15) / 46)

				if (46 <= 0 and var_660_13 or var_660_13 * (utf8.len(var_660_15) / 46)) > 0 and var_660_13 < var_660_17 then
					arg_657_1.talkMaxDuration = var_660_17
					var_660_12 = var_660_12 + 0.3

					if var_660_17 + var_660_12 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_17 + var_660_12
					end
				end

				arg_657_1.text_.text = var_660_15
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_18 = var_660_12 + 0.3
			local var_660_19 = math.max(var_660_13, arg_657_1.talkMaxDuration)

			if var_660_12 + 0.3 <= arg_657_1.time_ and arg_657_1.time_ < var_660_18 + var_660_19 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_18) / var_660_19

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_18 + var_660_19 and arg_657_1.time_ < var_660_18 + var_660_19 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play924041158 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 924041158
		arg_663_1.duration_ = 7

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play924041159(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				local var_666_0 = arg_663_1.bgs_.X204_g

				arg_663_1.bgs_.X204_g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_666_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_666_1 = var_666_0:GetComponent("SpriteRenderer")

				if var_666_1 and var_666_1.sprite then
					local var_666_2 = 2 * (var_666_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_666_0.transform.localScale = Vector3.New(var_666_2 / var_666_1.sprite.bounds.size.y < var_666_2 * manager.ui.mainCameraCom_.aspect / var_666_1.sprite.bounds.size.x and var_666_2 * manager.ui.mainCameraCom_.aspect / var_666_1.sprite.bounds.size.x or var_666_2 / var_666_1.sprite.bounds.size.y, var_666_2 / var_666_1.sprite.bounds.size.y < var_666_2 * manager.ui.mainCameraCom_.aspect / var_666_1.sprite.bounds.size.x and var_666_2 * manager.ui.mainCameraCom_.aspect / var_666_1.sprite.bounds.size.x or var_666_2 / var_666_1.sprite.bounds.size.y, 0)
				end

				for iter_666_0, iter_666_1 in pairs(arg_663_1.bgs_) do
					if iter_666_0 ~= "X204_g" then
						iter_666_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_666_3 = 1.999999999999

			if 1.999999999999 < arg_663_1.time_ and arg_663_1.time_ <= var_666_3 + arg_666_0 then
				arg_663_1.allBtn_.enabled = false
			end

			if arg_663_1.time_ >= var_666_3 + 0.3 and arg_663_1.time_ < var_666_3 + 0.3 + arg_666_0 then
				arg_663_1.allBtn_.enabled = true
			end

			local var_666_4 = 0

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_4 + arg_666_0 then
				arg_663_1.mask_.enabled = true
				arg_663_1.mask_.raycastTarget = true

				arg_663_1:SetGaussion(false)
			end

			local var_666_5 = 2

			if var_666_4 <= arg_663_1.time_ and arg_663_1.time_ < var_666_4 + var_666_5 then
				local var_666_6 = Color.New(0, 0, 0)

				var_666_6.a = Mathf.Lerp(1, 0, (arg_663_1.time_ - var_666_4) / var_666_5)
				arg_663_1.mask_.color = var_666_6
			end

			if arg_663_1.time_ >= var_666_4 + var_666_5 and arg_663_1.time_ < var_666_4 + var_666_5 + arg_666_0 then
				local var_666_7 = Color.New(0, 0, 0)

				arg_663_1.mask_.enabled = false
				var_666_7.a = 0
				arg_663_1.mask_.color = var_666_7
			end

			if arg_663_1.frameCnt_ <= 1 then
				arg_663_1.dialog_:SetActive(false)
			end

			local var_666_8 = 1.999999999999
			local var_666_9 = 1.2

			if 1.999999999999 < arg_663_1.time_ and arg_663_1.time_ <= var_666_8 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0

				arg_663_1.dialog_:SetActive(true)

				arg_663_1.dialogCg_.alpha = 0

				local var_666_10 = LeanTween.value(arg_663_1.dialog_, 0, 1, 0.3)

				var_666_10:setOnUpdate(LuaHelper.FloatAction(function(arg_667_0)
					arg_663_1.dialogCg_.alpha = arg_667_0
				end))
				var_666_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_663_1.dialog_)
					var_666_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_663_1.duration_ = arg_663_1.duration_ + 0.3

				SetActive(arg_663_1.leftNameGo_, false)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_11 = arg_663_1:FormatText(arg_663_1:GetWordFromCfg(924041158).content)

				arg_663_1.text_.text = var_666_11

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_13 = 48 <= 0 and var_666_9 or var_666_9 * (utf8.len(var_666_11) / 48)

				if (48 <= 0 and var_666_9 or var_666_9 * (utf8.len(var_666_11) / 48)) > 0 and var_666_9 < var_666_13 then
					arg_663_1.talkMaxDuration = var_666_13
					var_666_8 = var_666_8 + 0.3

					if var_666_13 + var_666_8 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_13 + var_666_8
					end
				end

				arg_663_1.text_.text = var_666_11
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_14 = var_666_8 + 0.3
			local var_666_15 = math.max(var_666_9, arg_663_1.talkMaxDuration)

			if var_666_8 + 0.3 <= arg_663_1.time_ and arg_663_1.time_ < var_666_14 + var_666_15 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_14) / var_666_15

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_14 + var_666_15 and arg_663_1.time_ < var_666_14 + var_666_15 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	Play924041159 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 924041159
		arg_669_1.duration_ = 7.9

		local var_669_0 = {
			zh = 6.333,
			ja = 7.9
		}
		local var_669_1 = manager.audio:GetLocalizationFlag()

		if var_669_0[var_669_1] ~= nil then
			arg_669_1.duration_ = var_669_0[var_669_1]
		end

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play924041160(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1.var_.moveOldPos102003ui_story = arg_669_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_672_0 = 0.001

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_0 then
				arg_669_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_669_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_669_1.time_ - 0) / var_672_0)
				arg_669_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_669_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_669_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_669_1.actors_["102003ui_story"].transform.position).z)
				arg_669_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_669_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_669_1.actors_["102003ui_story"].transform.localEulerAngles = arg_669_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_669_1.time_ >= 0 + var_672_0 and arg_669_1.time_ < 0 + var_672_0 + arg_672_0 then
				arg_669_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_669_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_669_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_669_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_669_1.actors_["102003ui_story"].transform.position).z)
				arg_669_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_669_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_669_1.actors_["102003ui_story"].transform.localEulerAngles = arg_669_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_672_1 = arg_669_1.actors_["102003ui_story"]

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 and not isNil(var_672_1) and arg_669_1.var_.characterEffect102003ui_story == nil then
				arg_669_1.var_.characterEffect102003ui_story = var_672_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_2 = 0.200000002980232

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_2 and not isNil(var_672_1) then
				if arg_669_1.var_.characterEffect102003ui_story and not isNil(var_672_1) then
					arg_669_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_669_1.time_ >= 0 + var_672_2 and arg_669_1.time_ < 0 + var_672_2 + arg_672_0 and not isNil(var_672_1) and arg_669_1.var_.characterEffect102003ui_story then
				arg_669_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action6_1")
			end

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_672_4 = 0
			local var_672_5 = 0.5

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_4 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_6 = arg_669_1:GetWordFromCfg(924041159)
				local var_672_7 = arg_669_1:FormatText(var_672_6.content)

				arg_669_1.text_.text = var_672_7

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_9 = 20 <= 0 and var_672_5 or var_672_5 * (utf8.len(var_672_7) / 20)

				if (20 <= 0 and var_672_5 or var_672_5 * (utf8.len(var_672_7) / 20)) > 0 and var_672_5 < var_672_9 then
					arg_669_1.talkMaxDuration = var_672_9

					if var_672_9 + var_672_4 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_9 + var_672_4
					end
				end

				arg_669_1.text_.text = var_672_7
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb") ~= 0 then
					local var_672_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb") / 1000

					if var_672_10 + var_672_4 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_10 + var_672_4
					end

					if var_672_6.prefab_name ~= "" and arg_669_1.actors_[var_672_6.prefab_name] ~= nil then
						local var_672_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_6.prefab_name].transform, "story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb")

						arg_669_1:RecordAudio("924041159", var_672_11)
						arg_669_1:RecordAudio("924041159", var_672_11)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041159", "story_v_side_old_924041.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_12 = math.max(var_672_5, arg_669_1.talkMaxDuration)

			if var_672_4 <= arg_669_1.time_ and arg_669_1.time_ < var_672_4 + var_672_12 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_4) / var_672_12

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_4 + var_672_12 and arg_669_1.time_ < var_672_4 + var_672_12 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_669_1:InitPlayNodeList()
	end,
	Play924041160 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 924041160
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play924041161(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 and not isNil(arg_673_1.actors_["102003ui_story"]) and arg_673_1.var_.characterEffect102003ui_story == nil then
				arg_673_1.var_.characterEffect102003ui_story = arg_673_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_0 = 0.200000002980232

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_0 and not isNil(arg_673_1.actors_["102003ui_story"]) then
				if arg_673_1.var_.characterEffect102003ui_story and not isNil(arg_673_1.actors_["102003ui_story"]) then
					arg_673_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_673_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_673_1.time_ - 0) / var_676_0)
				end
			end

			if arg_673_1.time_ >= 0 + var_676_0 and arg_673_1.time_ < 0 + var_676_0 + arg_676_0 and not isNil(arg_673_1.actors_["102003ui_story"]) and arg_673_1.var_.characterEffect102003ui_story then
				arg_673_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_673_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_676_1 = 0
			local var_676_2 = 0.125

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				arg_673_1.leftNameTxt_.text = arg_673_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, true)
				arg_673_1.iconController_:SetSelectedState("hero")

				arg_673_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_673_1.callingController_:SetSelectedState("normal")

				arg_673_1.keyicon_.color = Color.New(1, 1, 1)
				arg_673_1.icon_.color = Color.New(1, 1, 1)

				local var_676_3 = arg_673_1:FormatText(arg_673_1:GetWordFromCfg(924041160).content)

				arg_673_1.text_.text = var_676_3

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_5 = 5 <= 0 and var_676_2 or var_676_2 * (utf8.len(var_676_3) / 5)

				if (5 <= 0 and var_676_2 or var_676_2 * (utf8.len(var_676_3) / 5)) > 0 and var_676_2 < var_676_5 then
					arg_673_1.talkMaxDuration = var_676_5

					if var_676_5 + var_676_1 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_5 + var_676_1
					end
				end

				arg_673_1.text_.text = var_676_3
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_6 = math.max(var_676_2, arg_673_1.talkMaxDuration)

			if var_676_1 <= arg_673_1.time_ and arg_673_1.time_ < var_676_1 + var_676_6 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_1) / var_676_6

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_1 + var_676_6 and arg_673_1.time_ < var_676_1 + var_676_6 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play924041161 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 924041161
		arg_677_1.duration_ = 3.37

		local var_677_0 = {
			zh = 3.366,
			ja = 2.933
		}
		local var_677_1 = manager.audio:GetLocalizationFlag()

		if var_677_0[var_677_1] ~= nil then
			arg_677_1.duration_ = var_677_0[var_677_1]
		end

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play924041162(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 and not isNil(arg_677_1.actors_["102003ui_story"]) and arg_677_1.var_.characterEffect102003ui_story == nil then
				arg_677_1.var_.characterEffect102003ui_story = arg_677_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_0 = 0.200000002980232

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_0 and not isNil(arg_677_1.actors_["102003ui_story"]) then
				if arg_677_1.var_.characterEffect102003ui_story and not isNil(arg_677_1.actors_["102003ui_story"]) then
					arg_677_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= 0 + var_680_0 and arg_677_1.time_ < 0 + var_680_0 + arg_680_0 and not isNil(arg_677_1.actors_["102003ui_story"]) and arg_677_1.var_.characterEffect102003ui_story then
				arg_677_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action468")
			end

			local var_680_2 = 0
			local var_680_3 = 0.3

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= var_680_2 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_4 = arg_677_1:GetWordFromCfg(924041161)
				local var_680_5 = arg_677_1:FormatText(var_680_4.content)

				arg_677_1.text_.text = var_680_5

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_7 = 12 <= 0 and var_680_3 or var_680_3 * (utf8.len(var_680_5) / 12)

				if (12 <= 0 and var_680_3 or var_680_3 * (utf8.len(var_680_5) / 12)) > 0 and var_680_3 < var_680_7 then
					arg_677_1.talkMaxDuration = var_680_7

					if var_680_7 + var_680_2 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_7 + var_680_2
					end
				end

				arg_677_1.text_.text = var_680_5
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb") ~= 0 then
					local var_680_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb") / 1000

					if var_680_8 + var_680_2 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_8 + var_680_2
					end

					if var_680_4.prefab_name ~= "" and arg_677_1.actors_[var_680_4.prefab_name] ~= nil then
						local var_680_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_4.prefab_name].transform, "story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb")

						arg_677_1:RecordAudio("924041161", var_680_9)
						arg_677_1:RecordAudio("924041161", var_680_9)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041161", "story_v_side_old_924041.awb")
				end

				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_10 = math.max(var_680_3, arg_677_1.talkMaxDuration)

			if var_680_2 <= arg_677_1.time_ and arg_677_1.time_ < var_680_2 + var_680_10 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_2) / var_680_10

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_2 + var_680_10 and arg_677_1.time_ < var_680_2 + var_680_10 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {}

		arg_677_1:InitPlayNodeList()
	end,
	Play924041162 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 924041162
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play924041163(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 and not isNil(arg_681_1.actors_["102003ui_story"]) and arg_681_1.var_.characterEffect102003ui_story == nil then
				arg_681_1.var_.characterEffect102003ui_story = arg_681_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_0 = 0.200000002980232

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_0 and not isNil(arg_681_1.actors_["102003ui_story"]) then
				if arg_681_1.var_.characterEffect102003ui_story and not isNil(arg_681_1.actors_["102003ui_story"]) then
					arg_681_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_681_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_681_1.time_ - 0) / var_684_0)
				end
			end

			if arg_681_1.time_ >= 0 + var_684_0 and arg_681_1.time_ < 0 + var_684_0 + arg_684_0 and not isNil(arg_681_1.actors_["102003ui_story"]) and arg_681_1.var_.characterEffect102003ui_story then
				arg_681_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_681_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_684_1 = 0
			local var_684_2 = 0.475

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= var_684_1 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				arg_681_1.leftNameTxt_.text = arg_681_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, true)
				arg_681_1.iconController_:SetSelectedState("hero")

				arg_681_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_681_1.callingController_:SetSelectedState("normal")

				arg_681_1.keyicon_.color = Color.New(1, 1, 1)
				arg_681_1.icon_.color = Color.New(1, 1, 1)

				local var_684_3 = arg_681_1:FormatText(arg_681_1:GetWordFromCfg(924041162).content)

				arg_681_1.text_.text = var_684_3

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_5 = 19 <= 0 and var_684_2 or var_684_2 * (utf8.len(var_684_3) / 19)

				if (19 <= 0 and var_684_2 or var_684_2 * (utf8.len(var_684_3) / 19)) > 0 and var_684_2 < var_684_5 then
					arg_681_1.talkMaxDuration = var_684_5

					if var_684_5 + var_684_1 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_5 + var_684_1
					end
				end

				arg_681_1.text_.text = var_684_3
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_6 = math.max(var_684_2, arg_681_1.talkMaxDuration)

			if var_684_1 <= arg_681_1.time_ and arg_681_1.time_ < var_684_1 + var_684_6 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_1) / var_684_6

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_1 + var_684_6 and arg_681_1.time_ < var_684_1 + var_684_6 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play924041163 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 924041163
		arg_685_1.duration_ = 2.4

		local var_685_0 = {
			zh = 2.4,
			ja = 1.9
		}
		local var_685_1 = manager.audio:GetLocalizationFlag()

		if var_685_0[var_685_1] ~= nil then
			arg_685_1.duration_ = var_685_0[var_685_1]
		end

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play924041164(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 and not isNil(arg_685_1.actors_["102003ui_story"]) and arg_685_1.var_.characterEffect102003ui_story == nil then
				arg_685_1.var_.characterEffect102003ui_story = arg_685_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_0 = 0.200000002980232

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_0 and not isNil(arg_685_1.actors_["102003ui_story"]) then
				if arg_685_1.var_.characterEffect102003ui_story and not isNil(arg_685_1.actors_["102003ui_story"]) then
					arg_685_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_685_1.time_ >= 0 + var_688_0 and arg_685_1.time_ < 0 + var_688_0 + arg_688_0 and not isNil(arg_685_1.actors_["102003ui_story"]) and arg_685_1.var_.characterEffect102003ui_story then
				arg_685_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_688_2 = 0
			local var_688_3 = 0.15

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= var_688_2 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				arg_685_1.leftNameTxt_.text = arg_685_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_4 = arg_685_1:GetWordFromCfg(924041163)
				local var_688_5 = arg_685_1:FormatText(var_688_4.content)

				arg_685_1.text_.text = var_688_5

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_7 = 6 <= 0 and var_688_3 or var_688_3 * (utf8.len(var_688_5) / 6)

				if (6 <= 0 and var_688_3 or var_688_3 * (utf8.len(var_688_5) / 6)) > 0 and var_688_3 < var_688_7 then
					arg_685_1.talkMaxDuration = var_688_7

					if var_688_7 + var_688_2 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_7 + var_688_2
					end
				end

				arg_685_1.text_.text = var_688_5
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb") ~= 0 then
					local var_688_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb") / 1000

					if var_688_8 + var_688_2 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_8 + var_688_2
					end

					if var_688_4.prefab_name ~= "" and arg_685_1.actors_[var_688_4.prefab_name] ~= nil then
						local var_688_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_685_1.actors_[var_688_4.prefab_name].transform, "story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb")

						arg_685_1:RecordAudio("924041163", var_688_9)
						arg_685_1:RecordAudio("924041163", var_688_9)
					else
						arg_685_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb")
					end

					arg_685_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041163", "story_v_side_old_924041.awb")
				end

				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_10 = math.max(var_688_3, arg_685_1.talkMaxDuration)

			if var_688_2 <= arg_685_1.time_ and arg_685_1.time_ < var_688_2 + var_688_10 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_2) / var_688_10

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_2 + var_688_10 and arg_685_1.time_ < var_688_2 + var_688_10 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play924041164 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 924041164
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play924041165(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 and not isNil(arg_689_1.actors_["102003ui_story"]) and arg_689_1.var_.characterEffect102003ui_story == nil then
				arg_689_1.var_.characterEffect102003ui_story = arg_689_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_692_0 = 0.200000002980232

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_0 and not isNil(arg_689_1.actors_["102003ui_story"]) then
				if arg_689_1.var_.characterEffect102003ui_story and not isNil(arg_689_1.actors_["102003ui_story"]) then
					arg_689_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_689_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_689_1.time_ - 0) / var_692_0)
				end
			end

			if arg_689_1.time_ >= 0 + var_692_0 and arg_689_1.time_ < 0 + var_692_0 + arg_692_0 and not isNil(arg_689_1.actors_["102003ui_story"]) and arg_689_1.var_.characterEffect102003ui_story then
				arg_689_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_689_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_692_1 = 0
			local var_692_2 = 1.1

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, true)
				arg_689_1.iconController_:SetSelectedState("hero")

				arg_689_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_689_1.callingController_:SetSelectedState("normal")

				arg_689_1.keyicon_.color = Color.New(1, 1, 1)
				arg_689_1.icon_.color = Color.New(1, 1, 1)

				local var_692_3 = arg_689_1:FormatText(arg_689_1:GetWordFromCfg(924041164).content)

				arg_689_1.text_.text = var_692_3

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_5 = 44 <= 0 and var_692_2 or var_692_2 * (utf8.len(var_692_3) / 44)

				if (44 <= 0 and var_692_2 or var_692_2 * (utf8.len(var_692_3) / 44)) > 0 and var_692_2 < var_692_5 then
					arg_689_1.talkMaxDuration = var_692_5

					if var_692_5 + var_692_1 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_5 + var_692_1
					end
				end

				arg_689_1.text_.text = var_692_3
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_6 = math.max(var_692_2, arg_689_1.talkMaxDuration)

			if var_692_1 <= arg_689_1.time_ and arg_689_1.time_ < var_692_1 + var_692_6 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_1) / var_692_6

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_1 + var_692_6 and arg_689_1.time_ < var_692_1 + var_692_6 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play924041165 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 924041165
		arg_693_1.duration_ = 3.6

		local var_693_0 = {
			zh = 2.3,
			ja = 3.6
		}
		local var_693_1 = manager.audio:GetLocalizationFlag()

		if var_693_0[var_693_1] ~= nil then
			arg_693_1.duration_ = var_693_0[var_693_1]
		end

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play924041166(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 and not isNil(arg_693_1.actors_["102003ui_story"]) and arg_693_1.var_.characterEffect102003ui_story == nil then
				arg_693_1.var_.characterEffect102003ui_story = arg_693_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_0 = 0.200000002980232

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_0 and not isNil(arg_693_1.actors_["102003ui_story"]) then
				if arg_693_1.var_.characterEffect102003ui_story and not isNil(arg_693_1.actors_["102003ui_story"]) then
					arg_693_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_693_1.time_ >= 0 + var_696_0 and arg_693_1.time_ < 0 + var_696_0 + arg_696_0 and not isNil(arg_693_1.actors_["102003ui_story"]) and arg_693_1.var_.characterEffect102003ui_story then
				arg_693_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_696_2 = 0
			local var_696_3 = 0.275

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= var_696_2 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				arg_693_1.leftNameTxt_.text = arg_693_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_4 = arg_693_1:GetWordFromCfg(924041165)
				local var_696_5 = arg_693_1:FormatText(var_696_4.content)

				arg_693_1.text_.text = var_696_5

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_7 = 11 <= 0 and var_696_3 or var_696_3 * (utf8.len(var_696_5) / 11)

				if (11 <= 0 and var_696_3 or var_696_3 * (utf8.len(var_696_5) / 11)) > 0 and var_696_3 < var_696_7 then
					arg_693_1.talkMaxDuration = var_696_7

					if var_696_7 + var_696_2 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_7 + var_696_2
					end
				end

				arg_693_1.text_.text = var_696_5
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb") ~= 0 then
					local var_696_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb") / 1000

					if var_696_8 + var_696_2 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_8 + var_696_2
					end

					if var_696_4.prefab_name ~= "" and arg_693_1.actors_[var_696_4.prefab_name] ~= nil then
						local var_696_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_4.prefab_name].transform, "story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb")

						arg_693_1:RecordAudio("924041165", var_696_9)
						arg_693_1:RecordAudio("924041165", var_696_9)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041165", "story_v_side_old_924041.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_10 = math.max(var_696_3, arg_693_1.talkMaxDuration)

			if var_696_2 <= arg_693_1.time_ and arg_693_1.time_ < var_696_2 + var_696_10 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_2) / var_696_10

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_2 + var_696_10 and arg_693_1.time_ < var_696_2 + var_696_10 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play924041166 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 924041166
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play924041167(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 and not isNil(arg_697_1.actors_["102003ui_story"]) and arg_697_1.var_.characterEffect102003ui_story == nil then
				arg_697_1.var_.characterEffect102003ui_story = arg_697_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_700_0 = 0.200000002980232

			if 0 <= arg_697_1.time_ and arg_697_1.time_ < 0 + var_700_0 and not isNil(arg_697_1.actors_["102003ui_story"]) then
				if arg_697_1.var_.characterEffect102003ui_story and not isNil(arg_697_1.actors_["102003ui_story"]) then
					arg_697_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_697_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_697_1.time_ - 0) / var_700_0)
				end
			end

			if arg_697_1.time_ >= 0 + var_700_0 and arg_697_1.time_ < 0 + var_700_0 + arg_700_0 and not isNil(arg_697_1.actors_["102003ui_story"]) and arg_697_1.var_.characterEffect102003ui_story then
				arg_697_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_697_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_700_1 = 0
			local var_700_2 = 1.15

			if 0 < arg_697_1.time_ and arg_697_1.time_ <= var_700_1 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				arg_697_1.leftNameTxt_.text = arg_697_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, true)
				arg_697_1.iconController_:SetSelectedState("hero")

				arg_697_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_697_1.callingController_:SetSelectedState("normal")

				arg_697_1.keyicon_.color = Color.New(1, 1, 1)
				arg_697_1.icon_.color = Color.New(1, 1, 1)

				local var_700_3 = arg_697_1:FormatText(arg_697_1:GetWordFromCfg(924041166).content)

				arg_697_1.text_.text = var_700_3

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_5 = 46 <= 0 and var_700_2 or var_700_2 * (utf8.len(var_700_3) / 46)

				if (46 <= 0 and var_700_2 or var_700_2 * (utf8.len(var_700_3) / 46)) > 0 and var_700_2 < var_700_5 then
					arg_697_1.talkMaxDuration = var_700_5

					if var_700_5 + var_700_1 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_5 + var_700_1
					end
				end

				arg_697_1.text_.text = var_700_3
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_6 = math.max(var_700_2, arg_697_1.talkMaxDuration)

			if var_700_1 <= arg_697_1.time_ and arg_697_1.time_ < var_700_1 + var_700_6 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_1) / var_700_6

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_1 + var_700_6 and arg_697_1.time_ < var_700_1 + var_700_6 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play924041167 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 924041167
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play924041168(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0.35

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				arg_701_1.leftNameTxt_.text = arg_701_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, true)
				arg_701_1.iconController_:SetSelectedState("hero")

				arg_701_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_701_1.callingController_:SetSelectedState("normal")

				arg_701_1.keyicon_.color = Color.New(1, 1, 1)
				arg_701_1.icon_.color = Color.New(1, 1, 1)

				local var_704_1 = arg_701_1:FormatText(arg_701_1:GetWordFromCfg(924041167).content)

				arg_701_1.text_.text = var_704_1

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_3 = 14 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 14)

				if (14 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 14)) > 0 and var_704_0 < var_704_3 then
					arg_701_1.talkMaxDuration = var_704_3

					if var_704_3 + 0 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_3 + 0
					end
				end

				arg_701_1.text_.text = var_704_1
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_4 = math.max(var_704_0, arg_701_1.talkMaxDuration)

			if 0 <= arg_701_1.time_ and arg_701_1.time_ < 0 + var_704_4 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - 0) / var_704_4

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= 0 + var_704_4 and arg_701_1.time_ < 0 + var_704_4 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play924041168 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 924041168
		arg_705_1.duration_ = 1

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"

			SetActive(arg_705_1.choicesGo_, true)

			for iter_706_0, iter_706_1 in ipairs(arg_705_1.choices_) do
				SetActive(iter_706_1.go, iter_706_0 <= 1)
			end

			arg_705_1.choices_[1].txt.text = arg_705_1:FormatText(StoryChoiceCfg[1214].name)
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play924041169(arg_705_1)
			end

			arg_705_1:RecordChoiceLog(924041168, 1214)
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1.allBtn_.enabled = false
			end

			if arg_705_1.time_ >= 0 + 0.6 and arg_705_1.time_ < 0 + 0.6 + arg_708_0 then
				arg_705_1.allBtn_.enabled = true
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play924041169 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 924041169
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play924041170(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 then
				arg_709_1.var_.moveOldPos102003ui_story = arg_709_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_712_0 = 0.001

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_0 then
				arg_709_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_709_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_709_1.time_ - 0) / var_712_0)
				arg_709_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_709_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_709_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_709_1.actors_["102003ui_story"].transform.position).z)
				arg_709_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_709_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_709_1.actors_["102003ui_story"].transform.localEulerAngles = arg_709_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_709_1.time_ >= 0 + var_712_0 and arg_709_1.time_ < 0 + var_712_0 + arg_712_0 then
				arg_709_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_709_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_709_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_709_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_709_1.actors_["102003ui_story"].transform.position).z)
				arg_709_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_709_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_709_1.actors_["102003ui_story"].transform.localEulerAngles = arg_709_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 then
				arg_709_1:AudioAction("play", "effect", "se_story_141", "se_story_141_firework02", "")
			end

			local var_712_2 = 0
			local var_712_3 = 0.5

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= var_712_2 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, false)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_4 = arg_709_1:FormatText(arg_709_1:GetWordFromCfg(924041169).content)

				arg_709_1.text_.text = var_712_4

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_6 = 20 <= 0 and var_712_3 or var_712_3 * (utf8.len(var_712_4) / 20)

				if (20 <= 0 and var_712_3 or var_712_3 * (utf8.len(var_712_4) / 20)) > 0 and var_712_3 < var_712_6 then
					arg_709_1.talkMaxDuration = var_712_6

					if var_712_6 + var_712_2 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_6 + var_712_2
					end
				end

				arg_709_1.text_.text = var_712_4
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_7 = math.max(var_712_3, arg_709_1.talkMaxDuration)

			if var_712_2 <= arg_709_1.time_ and arg_709_1.time_ < var_712_2 + var_712_7 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_2) / var_712_7

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_2 + var_712_7 and arg_709_1.time_ < var_712_2 + var_712_7 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_709_1:InitPlayNodeList()
	end,
	Play924041170 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 924041170
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play924041171(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.3

			if 0 < arg_713_1.time_ and arg_713_1.time_ <= 0 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				arg_713_1.leftNameTxt_.text = arg_713_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, true)
				arg_713_1.iconController_:SetSelectedState("hero")

				arg_713_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_713_1.callingController_:SetSelectedState("normal")

				arg_713_1.keyicon_.color = Color.New(1, 1, 1)
				arg_713_1.icon_.color = Color.New(1, 1, 1)

				local var_716_1 = arg_713_1:FormatText(arg_713_1:GetWordFromCfg(924041170).content)

				arg_713_1.text_.text = var_716_1

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_3 = 12 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 12)

				if (12 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 12)) > 0 and var_716_0 < var_716_3 then
					arg_713_1.talkMaxDuration = var_716_3

					if var_716_3 + 0 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_3 + 0
					end
				end

				arg_713_1.text_.text = var_716_1
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_4 = math.max(var_716_0, arg_713_1.talkMaxDuration)

			if 0 <= arg_713_1.time_ and arg_713_1.time_ < 0 + var_716_4 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - 0) / var_716_4

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= 0 + var_716_4 and arg_713_1.time_ < 0 + var_716_4 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {}

		arg_713_1:InitPlayNodeList()
	end,
	Play924041171 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 924041171
		arg_717_1.duration_ = 7.8

		local var_717_0 = {
			zh = 5.1,
			ja = 7.8
		}
		local var_717_1 = manager.audio:GetLocalizationFlag()

		if var_717_0[var_717_1] ~= nil then
			arg_717_1.duration_ = var_717_0[var_717_1]
		end

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play924041172(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			if 2 < arg_717_1.time_ and arg_717_1.time_ <= 2 + arg_720_0 then
				local var_720_0 = arg_717_1.bgs_.SP92401b

				arg_717_1.bgs_.SP92401b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_720_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_720_1 = var_720_0:GetComponent("SpriteRenderer")

				if var_720_1 and var_720_1.sprite then
					local var_720_2 = 2 * (var_720_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_720_0.transform.localScale = Vector3.New(var_720_2 / var_720_1.sprite.bounds.size.y < var_720_2 * manager.ui.mainCameraCom_.aspect / var_720_1.sprite.bounds.size.x and var_720_2 * manager.ui.mainCameraCom_.aspect / var_720_1.sprite.bounds.size.x or var_720_2 / var_720_1.sprite.bounds.size.y, var_720_2 / var_720_1.sprite.bounds.size.y < var_720_2 * manager.ui.mainCameraCom_.aspect / var_720_1.sprite.bounds.size.x and var_720_2 * manager.ui.mainCameraCom_.aspect / var_720_1.sprite.bounds.size.x or var_720_2 / var_720_1.sprite.bounds.size.y, 0)
				end

				for iter_720_0, iter_720_1 in pairs(arg_717_1.bgs_) do
					if iter_720_0 ~= "SP92401b" then
						iter_720_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_720_3 = 4

			if 4 < arg_717_1.time_ and arg_717_1.time_ <= var_720_3 + arg_720_0 then
				arg_717_1.allBtn_.enabled = false
			end

			if arg_717_1.time_ >= var_720_3 + 0.3 and arg_717_1.time_ < var_720_3 + 0.3 + arg_720_0 then
				arg_717_1.allBtn_.enabled = true
			end

			local var_720_4 = 0

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= var_720_4 + arg_720_0 then
				arg_717_1.mask_.enabled = true
				arg_717_1.mask_.raycastTarget = true

				arg_717_1:SetGaussion(false)
			end

			local var_720_5 = 2

			if var_720_4 <= arg_717_1.time_ and arg_717_1.time_ < var_720_4 + var_720_5 then
				local var_720_6 = Color.New(0, 0, 0)

				var_720_6.a = Mathf.Lerp(0, 1, (arg_717_1.time_ - var_720_4) / var_720_5)
				arg_717_1.mask_.color = var_720_6
			end

			if arg_717_1.time_ >= var_720_4 + var_720_5 and arg_717_1.time_ < var_720_4 + var_720_5 + arg_720_0 then
				local var_720_7 = Color.New(0, 0, 0)

				var_720_7.a = 1
				arg_717_1.mask_.color = var_720_7
			end

			local var_720_8 = 2

			if 2 < arg_717_1.time_ and arg_717_1.time_ <= var_720_8 + arg_720_0 then
				arg_717_1.mask_.enabled = true
				arg_717_1.mask_.raycastTarget = true

				arg_717_1:SetGaussion(false)
			end

			local var_720_9 = 2

			if var_720_8 <= arg_717_1.time_ and arg_717_1.time_ < var_720_8 + var_720_9 then
				local var_720_10 = Color.New(0, 0, 0)

				var_720_10.a = Mathf.Lerp(1, 0, (arg_717_1.time_ - var_720_8) / var_720_9)
				arg_717_1.mask_.color = var_720_10
			end

			if arg_717_1.time_ >= var_720_8 + var_720_9 and arg_717_1.time_ < var_720_8 + var_720_9 + arg_720_0 then
				local var_720_11 = Color.New(0, 0, 0)

				arg_717_1.mask_.enabled = false
				var_720_11.a = 0
				arg_717_1.mask_.color = var_720_11
			end

			if 1.6 < arg_717_1.time_ and arg_717_1.time_ <= 1.6 + arg_720_0 then
				arg_717_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night", "")
			end

			if 0.125 < arg_717_1.time_ and arg_717_1.time_ <= 0.125 + arg_720_0 then
				arg_717_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if arg_717_1.frameCnt_ <= 1 then
				arg_717_1.dialog_:SetActive(false)
			end

			local var_720_14 = 4
			local var_720_15 = 0.125

			if 4 < arg_717_1.time_ and arg_717_1.time_ <= var_720_14 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0

				arg_717_1.dialog_:SetActive(true)

				arg_717_1.dialogCg_.alpha = 0

				local var_720_16 = LeanTween.value(arg_717_1.dialog_, 0, 1, 0.3)

				var_720_16:setOnUpdate(LuaHelper.FloatAction(function(arg_721_0)
					arg_717_1.dialogCg_.alpha = arg_721_0
				end))
				var_720_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_717_1.dialog_)
					var_720_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_717_1.duration_ = arg_717_1.duration_ + 0.3

				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, false)
				arg_717_1.callingController_:SetSelectedState("normal")

				local var_720_17 = arg_717_1:GetWordFromCfg(924041171)
				local var_720_18 = arg_717_1:FormatText(var_720_17.content)

				arg_717_1.text_.text = var_720_18

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_20 = 5 <= 0 and var_720_15 or var_720_15 * (utf8.len(var_720_18) / 5)

				if (5 <= 0 and var_720_15 or var_720_15 * (utf8.len(var_720_18) / 5)) > 0 and var_720_15 < var_720_20 then
					arg_717_1.talkMaxDuration = var_720_20
					var_720_14 = var_720_14 + 0.3

					if var_720_20 + var_720_14 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_20 + var_720_14
					end
				end

				arg_717_1.text_.text = var_720_18
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb") ~= 0 then
					local var_720_21 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb") / 1000

					if var_720_21 + var_720_14 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_21 + var_720_14
					end

					if var_720_17.prefab_name ~= "" and arg_717_1.actors_[var_720_17.prefab_name] ~= nil then
						local var_720_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_717_1.actors_[var_720_17.prefab_name].transform, "story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb")

						arg_717_1:RecordAudio("924041171", var_720_22)
						arg_717_1:RecordAudio("924041171", var_720_22)
					else
						arg_717_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb")
					end

					arg_717_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041171", "story_v_side_old_924041.awb")
				end

				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_23 = var_720_14 + 0.3
			local var_720_24 = math.max(var_720_15, arg_717_1.talkMaxDuration)

			if var_720_14 + 0.3 <= arg_717_1.time_ and arg_717_1.time_ < var_720_23 + var_720_24 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_23) / var_720_24

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_23 + var_720_24 and arg_717_1.time_ < var_720_23 + var_720_24 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play924041172 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 924041172
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play924041173(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 and not isNil(arg_723_1.actors_["102003ui_story"]) and arg_723_1.var_.characterEffect102003ui_story == nil then
				arg_723_1.var_.characterEffect102003ui_story = arg_723_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_726_0 = 0.200000002980232

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_0 and not isNil(arg_723_1.actors_["102003ui_story"]) then
				if arg_723_1.var_.characterEffect102003ui_story and not isNil(arg_723_1.actors_["102003ui_story"]) then
					arg_723_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_723_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_723_1.time_ - 0) / var_726_0)
				end
			end

			if arg_723_1.time_ >= 0 + var_726_0 and arg_723_1.time_ < 0 + var_726_0 + arg_726_0 and not isNil(arg_723_1.actors_["102003ui_story"]) and arg_723_1.var_.characterEffect102003ui_story then
				arg_723_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_723_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_726_1 = 0
			local var_726_2 = 0.8

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_1 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, false)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_3 = arg_723_1:FormatText(arg_723_1:GetWordFromCfg(924041172).content)

				arg_723_1.text_.text = var_726_3

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_5 = 32 <= 0 and var_726_2 or var_726_2 * (utf8.len(var_726_3) / 32)

				if (32 <= 0 and var_726_2 or var_726_2 * (utf8.len(var_726_3) / 32)) > 0 and var_726_2 < var_726_5 then
					arg_723_1.talkMaxDuration = var_726_5

					if var_726_5 + var_726_1 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_5 + var_726_1
					end
				end

				arg_723_1.text_.text = var_726_3
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_6 = math.max(var_726_2, arg_723_1.talkMaxDuration)

			if var_726_1 <= arg_723_1.time_ and arg_723_1.time_ < var_726_1 + var_726_6 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_1) / var_726_6

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_1 + var_726_6 and arg_723_1.time_ < var_726_1 + var_726_6 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play924041173 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 924041173
		arg_727_1.duration_ = 3.93

		local var_727_0 = {
			zh = 1.766,
			ja = 3.933
		}
		local var_727_1 = manager.audio:GetLocalizationFlag()

		if var_727_0[var_727_1] ~= nil then
			arg_727_1.duration_ = var_727_0[var_727_1]
		end

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play924041174(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 and not isNil(arg_727_1.actors_["102003ui_story"]) and arg_727_1.var_.characterEffect102003ui_story == nil then
				arg_727_1.var_.characterEffect102003ui_story = arg_727_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_730_0 = 0.200000002980232

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_0 and not isNil(arg_727_1.actors_["102003ui_story"]) then
				if arg_727_1.var_.characterEffect102003ui_story and not isNil(arg_727_1.actors_["102003ui_story"]) then
					arg_727_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_727_1.time_ >= 0 + var_730_0 and arg_727_1.time_ < 0 + var_730_0 + arg_730_0 and not isNil(arg_727_1.actors_["102003ui_story"]) and arg_727_1.var_.characterEffect102003ui_story then
				arg_727_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_730_2 = 0
			local var_730_3 = 0.15

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= var_730_2 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				arg_727_1.leftNameTxt_.text = arg_727_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_4 = arg_727_1:GetWordFromCfg(924041173)
				local var_730_5 = arg_727_1:FormatText(var_730_4.content)

				arg_727_1.text_.text = var_730_5

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_7 = 6 <= 0 and var_730_3 or var_730_3 * (utf8.len(var_730_5) / 6)

				if (6 <= 0 and var_730_3 or var_730_3 * (utf8.len(var_730_5) / 6)) > 0 and var_730_3 < var_730_7 then
					arg_727_1.talkMaxDuration = var_730_7

					if var_730_7 + var_730_2 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_7 + var_730_2
					end
				end

				arg_727_1.text_.text = var_730_5
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb") ~= 0 then
					local var_730_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb") / 1000

					if var_730_8 + var_730_2 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_8 + var_730_2
					end

					if var_730_4.prefab_name ~= "" and arg_727_1.actors_[var_730_4.prefab_name] ~= nil then
						local var_730_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_727_1.actors_[var_730_4.prefab_name].transform, "story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb")

						arg_727_1:RecordAudio("924041173", var_730_9)
						arg_727_1:RecordAudio("924041173", var_730_9)
					else
						arg_727_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb")
					end

					arg_727_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041173", "story_v_side_old_924041.awb")
				end

				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_10 = math.max(var_730_3, arg_727_1.talkMaxDuration)

			if var_730_2 <= arg_727_1.time_ and arg_727_1.time_ < var_730_2 + var_730_10 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - var_730_2) / var_730_10

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= var_730_2 + var_730_10 and arg_727_1.time_ < var_730_2 + var_730_10 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play924041174 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 924041174
		arg_731_1.duration_ = 5

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play924041175(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 and not isNil(arg_731_1.actors_["102003ui_story"]) and arg_731_1.var_.characterEffect102003ui_story == nil then
				arg_731_1.var_.characterEffect102003ui_story = arg_731_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_734_0 = 0.200000002980232

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_0 and not isNil(arg_731_1.actors_["102003ui_story"]) then
				if arg_731_1.var_.characterEffect102003ui_story and not isNil(arg_731_1.actors_["102003ui_story"]) then
					arg_731_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_731_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_731_1.time_ - 0) / var_734_0)
				end
			end

			if arg_731_1.time_ >= 0 + var_734_0 and arg_731_1.time_ < 0 + var_734_0 + arg_734_0 and not isNil(arg_731_1.actors_["102003ui_story"]) and arg_731_1.var_.characterEffect102003ui_story then
				arg_731_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_731_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_734_1 = 0
			local var_734_2 = 0.175

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_1 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				arg_731_1.leftNameTxt_.text = arg_731_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, true)
				arg_731_1.iconController_:SetSelectedState("hero")

				arg_731_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_731_1.callingController_:SetSelectedState("normal")

				arg_731_1.keyicon_.color = Color.New(1, 1, 1)
				arg_731_1.icon_.color = Color.New(1, 1, 1)

				local var_734_3 = arg_731_1:FormatText(arg_731_1:GetWordFromCfg(924041174).content)

				arg_731_1.text_.text = var_734_3

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_5 = 7 <= 0 and var_734_2 or var_734_2 * (utf8.len(var_734_3) / 7)

				if (7 <= 0 and var_734_2 or var_734_2 * (utf8.len(var_734_3) / 7)) > 0 and var_734_2 < var_734_5 then
					arg_731_1.talkMaxDuration = var_734_5

					if var_734_5 + var_734_1 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_5 + var_734_1
					end
				end

				arg_731_1.text_.text = var_734_3
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)
				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_6 = math.max(var_734_2, arg_731_1.talkMaxDuration)

			if var_734_1 <= arg_731_1.time_ and arg_731_1.time_ < var_734_1 + var_734_6 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_1) / var_734_6

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_1 + var_734_6 and arg_731_1.time_ < var_734_1 + var_734_6 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play924041175 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 924041175
		arg_735_1.duration_ = 5.83

		local var_735_0 = {
			zh = 5.7,
			ja = 5.833
		}
		local var_735_1 = manager.audio:GetLocalizationFlag()

		if var_735_0[var_735_1] ~= nil then
			arg_735_1.duration_ = var_735_0[var_735_1]
		end

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play924041176(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 and not isNil(arg_735_1.actors_["102003ui_story"]) and arg_735_1.var_.characterEffect102003ui_story == nil then
				arg_735_1.var_.characterEffect102003ui_story = arg_735_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_738_0 = 0.200000002980232

			if 0 <= arg_735_1.time_ and arg_735_1.time_ < 0 + var_738_0 and not isNil(arg_735_1.actors_["102003ui_story"]) then
				if arg_735_1.var_.characterEffect102003ui_story and not isNil(arg_735_1.actors_["102003ui_story"]) then
					arg_735_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_735_1.time_ >= 0 + var_738_0 and arg_735_1.time_ < 0 + var_738_0 + arg_738_0 and not isNil(arg_735_1.actors_["102003ui_story"]) and arg_735_1.var_.characterEffect102003ui_story then
				arg_735_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_738_2 = 0
			local var_738_3 = 0.425

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= var_738_2 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				arg_735_1.leftNameTxt_.text = arg_735_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_4 = arg_735_1:GetWordFromCfg(924041175)
				local var_738_5 = arg_735_1:FormatText(var_738_4.content)

				arg_735_1.text_.text = var_738_5

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_7 = 17 <= 0 and var_738_3 or var_738_3 * (utf8.len(var_738_5) / 17)

				if (17 <= 0 and var_738_3 or var_738_3 * (utf8.len(var_738_5) / 17)) > 0 and var_738_3 < var_738_7 then
					arg_735_1.talkMaxDuration = var_738_7

					if var_738_7 + var_738_2 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_7 + var_738_2
					end
				end

				arg_735_1.text_.text = var_738_5
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb") ~= 0 then
					local var_738_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb") / 1000

					if var_738_8 + var_738_2 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_8 + var_738_2
					end

					if var_738_4.prefab_name ~= "" and arg_735_1.actors_[var_738_4.prefab_name] ~= nil then
						local var_738_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_735_1.actors_[var_738_4.prefab_name].transform, "story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb")

						arg_735_1:RecordAudio("924041175", var_738_9)
						arg_735_1:RecordAudio("924041175", var_738_9)
					else
						arg_735_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb")
					end

					arg_735_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041175", "story_v_side_old_924041.awb")
				end

				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_10 = math.max(var_738_3, arg_735_1.talkMaxDuration)

			if var_738_2 <= arg_735_1.time_ and arg_735_1.time_ < var_738_2 + var_738_10 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - var_738_2) / var_738_10

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= var_738_2 + var_738_10 and arg_735_1.time_ < var_738_2 + var_738_10 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play924041176 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 924041176
		arg_739_1.duration_ = 5

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play924041177(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 and not isNil(arg_739_1.actors_["102003ui_story"]) and arg_739_1.var_.characterEffect102003ui_story == nil then
				arg_739_1.var_.characterEffect102003ui_story = arg_739_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_742_0 = 0.200000002980232

			if 0 <= arg_739_1.time_ and arg_739_1.time_ < 0 + var_742_0 and not isNil(arg_739_1.actors_["102003ui_story"]) then
				if arg_739_1.var_.characterEffect102003ui_story and not isNil(arg_739_1.actors_["102003ui_story"]) then
					arg_739_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_739_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_739_1.time_ - 0) / var_742_0)
				end
			end

			if arg_739_1.time_ >= 0 + var_742_0 and arg_739_1.time_ < 0 + var_742_0 + arg_742_0 and not isNil(arg_739_1.actors_["102003ui_story"]) and arg_739_1.var_.characterEffect102003ui_story then
				arg_739_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_739_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_742_1 = 0
			local var_742_2 = 0.175

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= var_742_1 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				arg_739_1.leftNameTxt_.text = arg_739_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, true)
				arg_739_1.iconController_:SetSelectedState("hero")

				arg_739_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_739_1.callingController_:SetSelectedState("normal")

				arg_739_1.keyicon_.color = Color.New(1, 1, 1)
				arg_739_1.icon_.color = Color.New(1, 1, 1)

				local var_742_3 = arg_739_1:FormatText(arg_739_1:GetWordFromCfg(924041176).content)

				arg_739_1.text_.text = var_742_3

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_5 = 7 <= 0 and var_742_2 or var_742_2 * (utf8.len(var_742_3) / 7)

				if (7 <= 0 and var_742_2 or var_742_2 * (utf8.len(var_742_3) / 7)) > 0 and var_742_2 < var_742_5 then
					arg_739_1.talkMaxDuration = var_742_5

					if var_742_5 + var_742_1 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_5 + var_742_1
					end
				end

				arg_739_1.text_.text = var_742_3
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)
				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_6 = math.max(var_742_2, arg_739_1.talkMaxDuration)

			if var_742_1 <= arg_739_1.time_ and arg_739_1.time_ < var_742_1 + var_742_6 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - var_742_1) / var_742_6

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= var_742_1 + var_742_6 and arg_739_1.time_ < var_742_1 + var_742_6 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {}

		arg_739_1:InitPlayNodeList()
	end,
	Play924041177 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 924041177
		arg_743_1.duration_ = 5.27

		local var_743_0 = {
			zh = 4.533,
			ja = 5.266
		}
		local var_743_1 = manager.audio:GetLocalizationFlag()

		if var_743_0[var_743_1] ~= nil then
			arg_743_1.duration_ = var_743_0[var_743_1]
		end

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
		end

		function arg_743_1.playNext_(arg_745_0)
			if arg_745_0 == 1 then
				arg_743_0:Play924041178(arg_743_1)
			end
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 and not isNil(arg_743_1.actors_["102003ui_story"]) and arg_743_1.var_.characterEffect102003ui_story == nil then
				arg_743_1.var_.characterEffect102003ui_story = arg_743_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_746_0 = 0.200000002980232

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_0 and not isNil(arg_743_1.actors_["102003ui_story"]) then
				if arg_743_1.var_.characterEffect102003ui_story and not isNil(arg_743_1.actors_["102003ui_story"]) then
					arg_743_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_743_1.time_ >= 0 + var_746_0 and arg_743_1.time_ < 0 + var_746_0 + arg_746_0 and not isNil(arg_743_1.actors_["102003ui_story"]) and arg_743_1.var_.characterEffect102003ui_story then
				arg_743_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_746_2 = 0
			local var_746_3 = 0.425

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= var_746_2 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				arg_743_1.leftNameTxt_.text = arg_743_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_4 = arg_743_1:GetWordFromCfg(924041177)
				local var_746_5 = arg_743_1:FormatText(var_746_4.content)

				arg_743_1.text_.text = var_746_5

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_7 = 17 <= 0 and var_746_3 or var_746_3 * (utf8.len(var_746_5) / 17)

				if (17 <= 0 and var_746_3 or var_746_3 * (utf8.len(var_746_5) / 17)) > 0 and var_746_3 < var_746_7 then
					arg_743_1.talkMaxDuration = var_746_7

					if var_746_7 + var_746_2 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_7 + var_746_2
					end
				end

				arg_743_1.text_.text = var_746_5
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb") ~= 0 then
					local var_746_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb") / 1000

					if var_746_8 + var_746_2 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_8 + var_746_2
					end

					if var_746_4.prefab_name ~= "" and arg_743_1.actors_[var_746_4.prefab_name] ~= nil then
						local var_746_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_743_1.actors_[var_746_4.prefab_name].transform, "story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb")

						arg_743_1:RecordAudio("924041177", var_746_9)
						arg_743_1:RecordAudio("924041177", var_746_9)
					else
						arg_743_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb")
					end

					arg_743_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041177", "story_v_side_old_924041.awb")
				end

				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_10 = math.max(var_746_3, arg_743_1.talkMaxDuration)

			if var_746_2 <= arg_743_1.time_ and arg_743_1.time_ < var_746_2 + var_746_10 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - var_746_2) / var_746_10

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= var_746_2 + var_746_10 and arg_743_1.time_ < var_746_2 + var_746_10 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	Play924041178 = function(arg_747_0, arg_747_1)
		arg_747_1.time_ = 0
		arg_747_1.frameCnt_ = 0
		arg_747_1.state_ = "playing"
		arg_747_1.curTalkId_ = 924041178
		arg_747_1.duration_ = 5

		SetActive(arg_747_1.tipsGo_, false)

		function arg_747_1.onSingleLineFinish_()
			arg_747_1.onSingleLineUpdate_ = nil
			arg_747_1.onSingleLineFinish_ = nil
			arg_747_1.state_ = "waiting"
		end

		function arg_747_1.playNext_(arg_749_0)
			if arg_749_0 == 1 then
				arg_747_0:Play924041179(arg_747_1)
			end
		end

		function arg_747_1.onSingleLineUpdate_(arg_750_0)
			if 0 < arg_747_1.time_ and arg_747_1.time_ <= 0 + arg_750_0 and not isNil(arg_747_1.actors_["102003ui_story"]) and arg_747_1.var_.characterEffect102003ui_story == nil then
				arg_747_1.var_.characterEffect102003ui_story = arg_747_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_750_0 = 0.200000002980232

			if 0 <= arg_747_1.time_ and arg_747_1.time_ < 0 + var_750_0 and not isNil(arg_747_1.actors_["102003ui_story"]) then
				if arg_747_1.var_.characterEffect102003ui_story and not isNil(arg_747_1.actors_["102003ui_story"]) then
					arg_747_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_747_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_747_1.time_ - 0) / var_750_0)
				end
			end

			if arg_747_1.time_ >= 0 + var_750_0 and arg_747_1.time_ < 0 + var_750_0 + arg_750_0 and not isNil(arg_747_1.actors_["102003ui_story"]) and arg_747_1.var_.characterEffect102003ui_story then
				arg_747_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_747_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_750_1 = 0
			local var_750_2 = 0.175

			if 0 < arg_747_1.time_ and arg_747_1.time_ <= var_750_1 + arg_750_0 then
				arg_747_1.talkMaxDuration = 0
				arg_747_1.dialogCg_.alpha = 1

				arg_747_1.dialog_:SetActive(true)
				SetActive(arg_747_1.leftNameGo_, true)

				arg_747_1.leftNameTxt_.text = arg_747_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_747_1.leftNameTxt_.transform)

				arg_747_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_747_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_747_1:RecordName(arg_747_1.leftNameTxt_.text)
				SetActive(arg_747_1.iconTrs_.gameObject, true)
				arg_747_1.iconController_:SetSelectedState("hero")

				arg_747_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_747_1.callingController_:SetSelectedState("normal")

				arg_747_1.keyicon_.color = Color.New(1, 1, 1)
				arg_747_1.icon_.color = Color.New(1, 1, 1)

				local var_750_3 = arg_747_1:FormatText(arg_747_1:GetWordFromCfg(924041178).content)

				arg_747_1.text_.text = var_750_3

				LuaForUtil.ClearLinePrefixSymbol(arg_747_1.text_)

				local var_750_5 = 7 <= 0 and var_750_2 or var_750_2 * (utf8.len(var_750_3) / 7)

				if (7 <= 0 and var_750_2 or var_750_2 * (utf8.len(var_750_3) / 7)) > 0 and var_750_2 < var_750_5 then
					arg_747_1.talkMaxDuration = var_750_5

					if var_750_5 + var_750_1 > arg_747_1.duration_ then
						arg_747_1.duration_ = var_750_5 + var_750_1
					end
				end

				arg_747_1.text_.text = var_750_3
				arg_747_1.typewritter.percent = 0

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(false)
				arg_747_1:RecordContent(arg_747_1.text_.text)
			end

			local var_750_6 = math.max(var_750_2, arg_747_1.talkMaxDuration)

			if var_750_1 <= arg_747_1.time_ and arg_747_1.time_ < var_750_1 + var_750_6 then
				arg_747_1.typewritter.percent = (arg_747_1.time_ - var_750_1) / var_750_6

				arg_747_1.typewritter:SetDirty()
			end

			if arg_747_1.time_ >= var_750_1 + var_750_6 and arg_747_1.time_ < var_750_1 + var_750_6 + arg_750_0 then
				arg_747_1.typewritter.percent = 1

				arg_747_1.typewritter:SetDirty()
				arg_747_1:ShowNextGo(true)
			end
		end

		arg_747_1.nodeConfigList_ = {}

		arg_747_1:InitPlayNodeList()
	end,
	Play924041179 = function(arg_751_0, arg_751_1)
		arg_751_1.time_ = 0
		arg_751_1.frameCnt_ = 0
		arg_751_1.state_ = "playing"
		arg_751_1.curTalkId_ = 924041179
		arg_751_1.duration_ = 3

		local var_751_0 = {
			zh = 2,
			ja = 3
		}
		local var_751_1 = manager.audio:GetLocalizationFlag()

		if var_751_0[var_751_1] ~= nil then
			arg_751_1.duration_ = var_751_0[var_751_1]
		end

		SetActive(arg_751_1.tipsGo_, false)

		function arg_751_1.onSingleLineFinish_()
			arg_751_1.onSingleLineUpdate_ = nil
			arg_751_1.onSingleLineFinish_ = nil
			arg_751_1.state_ = "waiting"
		end

		function arg_751_1.playNext_(arg_753_0)
			if arg_753_0 == 1 then
				arg_751_0:Play924041180(arg_751_1)
			end
		end

		function arg_751_1.onSingleLineUpdate_(arg_754_0)
			if 0 < arg_751_1.time_ and arg_751_1.time_ <= 0 + arg_754_0 and not isNil(arg_751_1.actors_["102003ui_story"]) and arg_751_1.var_.characterEffect102003ui_story == nil then
				arg_751_1.var_.characterEffect102003ui_story = arg_751_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_754_0 = 0.200000002980232

			if 0 <= arg_751_1.time_ and arg_751_1.time_ < 0 + var_754_0 and not isNil(arg_751_1.actors_["102003ui_story"]) then
				if arg_751_1.var_.characterEffect102003ui_story and not isNil(arg_751_1.actors_["102003ui_story"]) then
					arg_751_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_751_1.time_ >= 0 + var_754_0 and arg_751_1.time_ < 0 + var_754_0 + arg_754_0 and not isNil(arg_751_1.actors_["102003ui_story"]) and arg_751_1.var_.characterEffect102003ui_story then
				arg_751_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			local var_754_2 = 0
			local var_754_3 = 0.175

			if 0 < arg_751_1.time_ and arg_751_1.time_ <= var_754_2 + arg_754_0 then
				arg_751_1.talkMaxDuration = 0
				arg_751_1.dialogCg_.alpha = 1

				arg_751_1.dialog_:SetActive(true)
				SetActive(arg_751_1.leftNameGo_, true)

				arg_751_1.leftNameTxt_.text = arg_751_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_751_1.leftNameTxt_.transform)

				arg_751_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_751_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_751_1:RecordName(arg_751_1.leftNameTxt_.text)
				SetActive(arg_751_1.iconTrs_.gameObject, false)
				arg_751_1.callingController_:SetSelectedState("normal")

				local var_754_4 = arg_751_1:GetWordFromCfg(924041179)
				local var_754_5 = arg_751_1:FormatText(var_754_4.content)

				arg_751_1.text_.text = var_754_5

				LuaForUtil.ClearLinePrefixSymbol(arg_751_1.text_)

				local var_754_7 = 7 <= 0 and var_754_3 or var_754_3 * (utf8.len(var_754_5) / 7)

				if (7 <= 0 and var_754_3 or var_754_3 * (utf8.len(var_754_5) / 7)) > 0 and var_754_3 < var_754_7 then
					arg_751_1.talkMaxDuration = var_754_7

					if var_754_7 + var_754_2 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_7 + var_754_2
					end
				end

				arg_751_1.text_.text = var_754_5
				arg_751_1.typewritter.percent = 0

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb") ~= 0 then
					local var_754_8 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb") / 1000

					if var_754_8 + var_754_2 > arg_751_1.duration_ then
						arg_751_1.duration_ = var_754_8 + var_754_2
					end

					if var_754_4.prefab_name ~= "" and arg_751_1.actors_[var_754_4.prefab_name] ~= nil then
						local var_754_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_751_1.actors_[var_754_4.prefab_name].transform, "story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb")

						arg_751_1:RecordAudio("924041179", var_754_9)
						arg_751_1:RecordAudio("924041179", var_754_9)
					else
						arg_751_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb")
					end

					arg_751_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041179", "story_v_side_old_924041.awb")
				end

				arg_751_1:RecordContent(arg_751_1.text_.text)
			end

			local var_754_10 = math.max(var_754_3, arg_751_1.talkMaxDuration)

			if var_754_2 <= arg_751_1.time_ and arg_751_1.time_ < var_754_2 + var_754_10 then
				arg_751_1.typewritter.percent = (arg_751_1.time_ - var_754_2) / var_754_10

				arg_751_1.typewritter:SetDirty()
			end

			if arg_751_1.time_ >= var_754_2 + var_754_10 and arg_751_1.time_ < var_754_2 + var_754_10 + arg_754_0 then
				arg_751_1.typewritter.percent = 1

				arg_751_1.typewritter:SetDirty()
				arg_751_1:ShowNextGo(true)
			end
		end

		arg_751_1.nodeConfigList_ = {}

		arg_751_1:InitPlayNodeList()
	end,
	Play924041180 = function(arg_755_0, arg_755_1)
		arg_755_1.time_ = 0
		arg_755_1.frameCnt_ = 0
		arg_755_1.state_ = "playing"
		arg_755_1.curTalkId_ = 924041180
		arg_755_1.duration_ = 5

		SetActive(arg_755_1.tipsGo_, false)

		function arg_755_1.onSingleLineFinish_()
			arg_755_1.onSingleLineUpdate_ = nil
			arg_755_1.onSingleLineFinish_ = nil
			arg_755_1.state_ = "waiting"
		end

		function arg_755_1.playNext_(arg_757_0)
			if arg_757_0 == 1 then
				arg_755_0:Play924041181(arg_755_1)
			end
		end

		function arg_755_1.onSingleLineUpdate_(arg_758_0)
			if 0 < arg_755_1.time_ and arg_755_1.time_ <= 0 + arg_758_0 and not isNil(arg_755_1.actors_["102003ui_story"]) and arg_755_1.var_.characterEffect102003ui_story == nil then
				arg_755_1.var_.characterEffect102003ui_story = arg_755_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_758_0 = 0.200000002980232

			if 0 <= arg_755_1.time_ and arg_755_1.time_ < 0 + var_758_0 and not isNil(arg_755_1.actors_["102003ui_story"]) then
				if arg_755_1.var_.characterEffect102003ui_story and not isNil(arg_755_1.actors_["102003ui_story"]) then
					arg_755_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_755_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_755_1.time_ - 0) / var_758_0)
				end
			end

			if arg_755_1.time_ >= 0 + var_758_0 and arg_755_1.time_ < 0 + var_758_0 + arg_758_0 and not isNil(arg_755_1.actors_["102003ui_story"]) and arg_755_1.var_.characterEffect102003ui_story then
				arg_755_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_755_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_758_1 = 0
			local var_758_2 = 0.875

			if 0 < arg_755_1.time_ and arg_755_1.time_ <= var_758_1 + arg_758_0 then
				arg_755_1.talkMaxDuration = 0
				arg_755_1.dialogCg_.alpha = 1

				arg_755_1.dialog_:SetActive(true)
				SetActive(arg_755_1.leftNameGo_, true)

				arg_755_1.leftNameTxt_.text = arg_755_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_755_1.leftNameTxt_.transform)

				arg_755_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_755_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_755_1:RecordName(arg_755_1.leftNameTxt_.text)
				SetActive(arg_755_1.iconTrs_.gameObject, true)
				arg_755_1.iconController_:SetSelectedState("hero")

				arg_755_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_755_1.callingController_:SetSelectedState("normal")

				arg_755_1.keyicon_.color = Color.New(1, 1, 1)
				arg_755_1.icon_.color = Color.New(1, 1, 1)

				local var_758_3 = arg_755_1:FormatText(arg_755_1:GetWordFromCfg(924041180).content)

				arg_755_1.text_.text = var_758_3

				LuaForUtil.ClearLinePrefixSymbol(arg_755_1.text_)

				local var_758_5 = 35 <= 0 and var_758_2 or var_758_2 * (utf8.len(var_758_3) / 35)

				if (35 <= 0 and var_758_2 or var_758_2 * (utf8.len(var_758_3) / 35)) > 0 and var_758_2 < var_758_5 then
					arg_755_1.talkMaxDuration = var_758_5

					if var_758_5 + var_758_1 > arg_755_1.duration_ then
						arg_755_1.duration_ = var_758_5 + var_758_1
					end
				end

				arg_755_1.text_.text = var_758_3
				arg_755_1.typewritter.percent = 0

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(false)
				arg_755_1:RecordContent(arg_755_1.text_.text)
			end

			local var_758_6 = math.max(var_758_2, arg_755_1.talkMaxDuration)

			if var_758_1 <= arg_755_1.time_ and arg_755_1.time_ < var_758_1 + var_758_6 then
				arg_755_1.typewritter.percent = (arg_755_1.time_ - var_758_1) / var_758_6

				arg_755_1.typewritter:SetDirty()
			end

			if arg_755_1.time_ >= var_758_1 + var_758_6 and arg_755_1.time_ < var_758_1 + var_758_6 + arg_758_0 then
				arg_755_1.typewritter.percent = 1

				arg_755_1.typewritter:SetDirty()
				arg_755_1:ShowNextGo(true)
			end
		end

		arg_755_1.nodeConfigList_ = {}

		arg_755_1:InitPlayNodeList()
	end,
	Play924041181 = function(arg_759_0, arg_759_1)
		arg_759_1.time_ = 0
		arg_759_1.frameCnt_ = 0
		arg_759_1.state_ = "playing"
		arg_759_1.curTalkId_ = 924041181
		arg_759_1.duration_ = 5

		SetActive(arg_759_1.tipsGo_, false)

		function arg_759_1.onSingleLineFinish_()
			arg_759_1.onSingleLineUpdate_ = nil
			arg_759_1.onSingleLineFinish_ = nil
			arg_759_1.state_ = "waiting"
		end

		function arg_759_1.playNext_(arg_761_0)
			if arg_761_0 == 1 then
				arg_759_0:Play924041182(arg_759_1)
			end
		end

		function arg_759_1.onSingleLineUpdate_(arg_762_0)
			local var_762_0 = 0.775

			if 0 < arg_759_1.time_ and arg_759_1.time_ <= 0 + arg_762_0 then
				arg_759_1.talkMaxDuration = 0
				arg_759_1.dialogCg_.alpha = 1

				arg_759_1.dialog_:SetActive(true)
				SetActive(arg_759_1.leftNameGo_, true)

				arg_759_1.leftNameTxt_.text = arg_759_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_759_1.leftNameTxt_.transform)

				arg_759_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_759_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_759_1:RecordName(arg_759_1.leftNameTxt_.text)
				SetActive(arg_759_1.iconTrs_.gameObject, true)
				arg_759_1.iconController_:SetSelectedState("hero")

				arg_759_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_759_1.callingController_:SetSelectedState("normal")

				arg_759_1.keyicon_.color = Color.New(1, 1, 1)
				arg_759_1.icon_.color = Color.New(1, 1, 1)

				local var_762_1 = arg_759_1:FormatText(arg_759_1:GetWordFromCfg(924041181).content)

				arg_759_1.text_.text = var_762_1

				LuaForUtil.ClearLinePrefixSymbol(arg_759_1.text_)

				local var_762_3 = 31 <= 0 and var_762_0 or var_762_0 * (utf8.len(var_762_1) / 31)

				if (31 <= 0 and var_762_0 or var_762_0 * (utf8.len(var_762_1) / 31)) > 0 and var_762_0 < var_762_3 then
					arg_759_1.talkMaxDuration = var_762_3

					if var_762_3 + 0 > arg_759_1.duration_ then
						arg_759_1.duration_ = var_762_3 + 0
					end
				end

				arg_759_1.text_.text = var_762_1
				arg_759_1.typewritter.percent = 0

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(false)
				arg_759_1:RecordContent(arg_759_1.text_.text)
			end

			local var_762_4 = math.max(var_762_0, arg_759_1.talkMaxDuration)

			if 0 <= arg_759_1.time_ and arg_759_1.time_ < 0 + var_762_4 then
				arg_759_1.typewritter.percent = (arg_759_1.time_ - 0) / var_762_4

				arg_759_1.typewritter:SetDirty()
			end

			if arg_759_1.time_ >= 0 + var_762_4 and arg_759_1.time_ < 0 + var_762_4 + arg_762_0 then
				arg_759_1.typewritter.percent = 1

				arg_759_1.typewritter:SetDirty()
				arg_759_1:ShowNextGo(true)
			end
		end

		arg_759_1.nodeConfigList_ = {}

		arg_759_1:InitPlayNodeList()
	end,
	Play924041182 = function(arg_763_0, arg_763_1)
		arg_763_1.time_ = 0
		arg_763_1.frameCnt_ = 0
		arg_763_1.state_ = "playing"
		arg_763_1.curTalkId_ = 924041182
		arg_763_1.duration_ = 6.73

		local var_763_0 = {
			zh = 6.733,
			ja = 4.566
		}
		local var_763_1 = manager.audio:GetLocalizationFlag()

		if var_763_0[var_763_1] ~= nil then
			arg_763_1.duration_ = var_763_0[var_763_1]
		end

		SetActive(arg_763_1.tipsGo_, false)

		function arg_763_1.onSingleLineFinish_()
			arg_763_1.onSingleLineUpdate_ = nil
			arg_763_1.onSingleLineFinish_ = nil
			arg_763_1.state_ = "waiting"
		end

		function arg_763_1.playNext_(arg_765_0)
			if arg_765_0 == 1 then
				arg_763_0:Play924041183(arg_763_1)
			end
		end

		function arg_763_1.onSingleLineUpdate_(arg_766_0)
			local var_766_0 = 0.5

			if 0 < arg_763_1.time_ and arg_763_1.time_ <= 0 + arg_766_0 then
				arg_763_1.talkMaxDuration = 0
				arg_763_1.dialogCg_.alpha = 1

				arg_763_1.dialog_:SetActive(true)
				SetActive(arg_763_1.leftNameGo_, true)

				arg_763_1.leftNameTxt_.text = arg_763_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_763_1.leftNameTxt_.transform)

				arg_763_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_763_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_763_1:RecordName(arg_763_1.leftNameTxt_.text)
				SetActive(arg_763_1.iconTrs_.gameObject, false)
				arg_763_1.callingController_:SetSelectedState("normal")

				local var_766_1 = arg_763_1:GetWordFromCfg(924041182)
				local var_766_2 = arg_763_1:FormatText(var_766_1.content)

				arg_763_1.text_.text = var_766_2

				LuaForUtil.ClearLinePrefixSymbol(arg_763_1.text_)

				local var_766_4 = 20 <= 0 and var_766_0 or var_766_0 * (utf8.len(var_766_2) / 20)

				if (20 <= 0 and var_766_0 or var_766_0 * (utf8.len(var_766_2) / 20)) > 0 and var_766_0 < var_766_4 then
					arg_763_1.talkMaxDuration = var_766_4

					if var_766_4 + 0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_4 + 0
					end
				end

				arg_763_1.text_.text = var_766_2
				arg_763_1.typewritter.percent = 0

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb") ~= 0 then
					local var_766_5 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb") / 1000

					if var_766_5 + 0 > arg_763_1.duration_ then
						arg_763_1.duration_ = var_766_5 + 0
					end

					if var_766_1.prefab_name ~= "" and arg_763_1.actors_[var_766_1.prefab_name] ~= nil then
						local var_766_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_763_1.actors_[var_766_1.prefab_name].transform, "story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb")

						arg_763_1:RecordAudio("924041182", var_766_6)
						arg_763_1:RecordAudio("924041182", var_766_6)
					else
						arg_763_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb")
					end

					arg_763_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041182", "story_v_side_old_924041.awb")
				end

				arg_763_1:RecordContent(arg_763_1.text_.text)
			end

			local var_766_7 = math.max(var_766_0, arg_763_1.talkMaxDuration)

			if 0 <= arg_763_1.time_ and arg_763_1.time_ < 0 + var_766_7 then
				arg_763_1.typewritter.percent = (arg_763_1.time_ - 0) / var_766_7

				arg_763_1.typewritter:SetDirty()
			end

			if arg_763_1.time_ >= 0 + var_766_7 and arg_763_1.time_ < 0 + var_766_7 + arg_766_0 then
				arg_763_1.typewritter.percent = 1

				arg_763_1.typewritter:SetDirty()
				arg_763_1:ShowNextGo(true)
			end
		end

		arg_763_1.nodeConfigList_ = {}

		arg_763_1:InitPlayNodeList()
	end,
	Play924041183 = function(arg_767_0, arg_767_1)
		arg_767_1.time_ = 0
		arg_767_1.frameCnt_ = 0
		arg_767_1.state_ = "playing"
		arg_767_1.curTalkId_ = 924041183
		arg_767_1.duration_ = 5

		SetActive(arg_767_1.tipsGo_, false)

		function arg_767_1.onSingleLineFinish_()
			arg_767_1.onSingleLineUpdate_ = nil
			arg_767_1.onSingleLineFinish_ = nil
			arg_767_1.state_ = "waiting"
		end

		function arg_767_1.playNext_(arg_769_0)
			if arg_769_0 == 1 then
				arg_767_0:Play924041184(arg_767_1)
			end
		end

		function arg_767_1.onSingleLineUpdate_(arg_770_0)
			if 0 < arg_767_1.time_ and arg_767_1.time_ <= 0 + arg_770_0 and not isNil(arg_767_1.actors_["102003ui_story"]) and arg_767_1.var_.characterEffect102003ui_story == nil then
				arg_767_1.var_.characterEffect102003ui_story = arg_767_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_770_0 = 0.200000002980232

			if 0 <= arg_767_1.time_ and arg_767_1.time_ < 0 + var_770_0 and not isNil(arg_767_1.actors_["102003ui_story"]) then
				if arg_767_1.var_.characterEffect102003ui_story and not isNil(arg_767_1.actors_["102003ui_story"]) then
					arg_767_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_767_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_767_1.time_ - 0) / var_770_0)
				end
			end

			if arg_767_1.time_ >= 0 + var_770_0 and arg_767_1.time_ < 0 + var_770_0 + arg_770_0 and not isNil(arg_767_1.actors_["102003ui_story"]) and arg_767_1.var_.characterEffect102003ui_story then
				arg_767_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_767_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_770_1 = 0
			local var_770_2 = 0.1

			if 0 < arg_767_1.time_ and arg_767_1.time_ <= var_770_1 + arg_770_0 then
				arg_767_1.talkMaxDuration = 0
				arg_767_1.dialogCg_.alpha = 1

				arg_767_1.dialog_:SetActive(true)
				SetActive(arg_767_1.leftNameGo_, true)

				arg_767_1.leftNameTxt_.text = arg_767_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_767_1.leftNameTxt_.transform)

				arg_767_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_767_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_767_1:RecordName(arg_767_1.leftNameTxt_.text)
				SetActive(arg_767_1.iconTrs_.gameObject, true)
				arg_767_1.iconController_:SetSelectedState("hero")

				arg_767_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_767_1.callingController_:SetSelectedState("normal")

				arg_767_1.keyicon_.color = Color.New(1, 1, 1)
				arg_767_1.icon_.color = Color.New(1, 1, 1)

				local var_770_3 = arg_767_1:FormatText(arg_767_1:GetWordFromCfg(924041183).content)

				arg_767_1.text_.text = var_770_3

				LuaForUtil.ClearLinePrefixSymbol(arg_767_1.text_)

				local var_770_5 = 4 <= 0 and var_770_2 or var_770_2 * (utf8.len(var_770_3) / 4)

				if (4 <= 0 and var_770_2 or var_770_2 * (utf8.len(var_770_3) / 4)) > 0 and var_770_2 < var_770_5 then
					arg_767_1.talkMaxDuration = var_770_5

					if var_770_5 + var_770_1 > arg_767_1.duration_ then
						arg_767_1.duration_ = var_770_5 + var_770_1
					end
				end

				arg_767_1.text_.text = var_770_3
				arg_767_1.typewritter.percent = 0

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(false)
				arg_767_1:RecordContent(arg_767_1.text_.text)
			end

			local var_770_6 = math.max(var_770_2, arg_767_1.talkMaxDuration)

			if var_770_1 <= arg_767_1.time_ and arg_767_1.time_ < var_770_1 + var_770_6 then
				arg_767_1.typewritter.percent = (arg_767_1.time_ - var_770_1) / var_770_6

				arg_767_1.typewritter:SetDirty()
			end

			if arg_767_1.time_ >= var_770_1 + var_770_6 and arg_767_1.time_ < var_770_1 + var_770_6 + arg_770_0 then
				arg_767_1.typewritter.percent = 1

				arg_767_1.typewritter:SetDirty()
				arg_767_1:ShowNextGo(true)
			end
		end

		arg_767_1.nodeConfigList_ = {}

		arg_767_1:InitPlayNodeList()
	end,
	Play924041184 = function(arg_771_0, arg_771_1)
		arg_771_1.time_ = 0
		arg_771_1.frameCnt_ = 0
		arg_771_1.state_ = "playing"
		arg_771_1.curTalkId_ = 924041184
		arg_771_1.duration_ = 7.53

		SetActive(arg_771_1.tipsGo_, false)

		function arg_771_1.onSingleLineFinish_()
			arg_771_1.onSingleLineUpdate_ = nil
			arg_771_1.onSingleLineFinish_ = nil
			arg_771_1.state_ = "waiting"
		end

		function arg_771_1.playNext_(arg_773_0)
			if arg_773_0 == 1 then
				arg_771_0:Play924041185(arg_771_1)
			end
		end

		function arg_771_1.onSingleLineUpdate_(arg_774_0)
			if 0.533333333333333 < arg_771_1.time_ and arg_771_1.time_ <= 0.533333333333333 + arg_774_0 then
				local var_774_0 = arg_771_1.bgs_.STblack

				arg_771_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_774_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_774_1 = var_774_0:GetComponent("SpriteRenderer")

				if var_774_1 and var_774_1.sprite then
					local var_774_2 = 2 * (var_774_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_774_0.transform.localScale = Vector3.New(var_774_2 / var_774_1.sprite.bounds.size.y < var_774_2 * manager.ui.mainCameraCom_.aspect / var_774_1.sprite.bounds.size.x and var_774_2 * manager.ui.mainCameraCom_.aspect / var_774_1.sprite.bounds.size.x or var_774_2 / var_774_1.sprite.bounds.size.y, var_774_2 / var_774_1.sprite.bounds.size.y < var_774_2 * manager.ui.mainCameraCom_.aspect / var_774_1.sprite.bounds.size.x and var_774_2 * manager.ui.mainCameraCom_.aspect / var_774_1.sprite.bounds.size.x or var_774_2 / var_774_1.sprite.bounds.size.y, 0)
				end

				for iter_774_0, iter_774_1 in pairs(arg_771_1.bgs_) do
					if iter_774_0 ~= "STblack" then
						iter_774_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_774_3 = 2.53333333333333

			if 2.53333333333333 < arg_771_1.time_ and arg_771_1.time_ <= var_774_3 + arg_774_0 then
				arg_771_1.allBtn_.enabled = false
			end

			if arg_771_1.time_ >= var_774_3 + 0.3 and arg_771_1.time_ < var_774_3 + 0.3 + arg_774_0 then
				arg_771_1.allBtn_.enabled = true
			end

			local var_774_4 = 0.533333333333333

			if 0.533333333333333 < arg_771_1.time_ and arg_771_1.time_ <= var_774_4 + arg_774_0 then
				arg_771_1.mask_.enabled = true
				arg_771_1.mask_.raycastTarget = true

				arg_771_1:SetGaussion(false)
			end

			local var_774_5 = 2

			if var_774_4 <= arg_771_1.time_ and arg_771_1.time_ < var_774_4 + var_774_5 then
				local var_774_6 = Color.New(1, 1, 1)

				var_774_6.a = Mathf.Lerp(1, 0, (arg_771_1.time_ - var_774_4) / var_774_5)
				arg_771_1.mask_.color = var_774_6
			end

			if arg_771_1.time_ >= var_774_4 + var_774_5 and arg_771_1.time_ < var_774_4 + var_774_5 + arg_774_0 then
				local var_774_7 = Color.New(1, 1, 1)

				arg_771_1.mask_.enabled = false
				var_774_7.a = 0
				arg_771_1.mask_.color = var_774_7
			end

			if 2.7 < arg_771_1.time_ and arg_771_1.time_ <= 2.7 + arg_774_0 then
				arg_771_1:AudioAction("play", "effect", "se_story_side_1050", "se_story_side_1050_fall", "")
			end

			if 0.533333333333333 < arg_771_1.time_ and arg_771_1.time_ <= 0.533333333333333 + arg_774_0 then
				arg_771_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_drum02", "")
			end

			if arg_771_1.frameCnt_ <= 1 then
				arg_771_1.dialog_:SetActive(false)
			end

			local var_774_10 = 2.53333333333333
			local var_774_11 = 0.925

			if 2.53333333333333 < arg_771_1.time_ and arg_771_1.time_ <= var_774_10 + arg_774_0 then
				arg_771_1.talkMaxDuration = 0

				arg_771_1.dialog_:SetActive(true)

				arg_771_1.dialogCg_.alpha = 0

				local var_774_12 = LeanTween.value(arg_771_1.dialog_, 0, 1, 0.3)

				var_774_12:setOnUpdate(LuaHelper.FloatAction(function(arg_775_0)
					arg_771_1.dialogCg_.alpha = arg_775_0
				end))
				var_774_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_771_1.dialog_)
					var_774_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_771_1.duration_ = arg_771_1.duration_ + 0.3

				SetActive(arg_771_1.leftNameGo_, false)

				arg_771_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_771_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_771_1:RecordName(arg_771_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_771_1.iconTrs_.gameObject, false)
				arg_771_1.callingController_:SetSelectedState("normal")

				local var_774_13 = arg_771_1:FormatText(arg_771_1:GetWordFromCfg(924041184).content)

				arg_771_1.text_.text = var_774_13

				LuaForUtil.ClearLinePrefixSymbol(arg_771_1.text_)

				local var_774_15 = 37 <= 0 and var_774_11 or var_774_11 * (utf8.len(var_774_13) / 37)

				if (37 <= 0 and var_774_11 or var_774_11 * (utf8.len(var_774_13) / 37)) > 0 and var_774_11 < var_774_15 then
					arg_771_1.talkMaxDuration = var_774_15
					var_774_10 = var_774_10 + 0.3

					if var_774_15 + var_774_10 > arg_771_1.duration_ then
						arg_771_1.duration_ = var_774_15 + var_774_10
					end
				end

				arg_771_1.text_.text = var_774_13
				arg_771_1.typewritter.percent = 0

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(false)
				arg_771_1:RecordContent(arg_771_1.text_.text)
			end

			local var_774_16 = var_774_10 + 0.3
			local var_774_17 = math.max(var_774_11, arg_771_1.talkMaxDuration)

			if var_774_10 + 0.3 <= arg_771_1.time_ and arg_771_1.time_ < var_774_16 + var_774_17 then
				arg_771_1.typewritter.percent = (arg_771_1.time_ - var_774_16) / var_774_17

				arg_771_1.typewritter:SetDirty()
			end

			if arg_771_1.time_ >= var_774_16 + var_774_17 and arg_771_1.time_ < var_774_16 + var_774_17 + arg_774_0 then
				arg_771_1.typewritter.percent = 1

				arg_771_1.typewritter:SetDirty()
				arg_771_1:ShowNextGo(true)
			end
		end

		arg_771_1.nodeConfigList_ = {}

		arg_771_1:InitPlayNodeList()
	end,
	Play924041185 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 924041185
		arg_777_1.duration_ = 5.67

		local var_777_0 = {
			zh = 4.966,
			ja = 5.666
		}
		local var_777_1 = manager.audio:GetLocalizationFlag()

		if var_777_0[var_777_1] ~= nil then
			arg_777_1.duration_ = var_777_0[var_777_1]
		end

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play924041186(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = 0.25

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				arg_777_1.leftNameTxt_.text = arg_777_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_102003")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_1 = arg_777_1:GetWordFromCfg(924041185)
				local var_780_2 = arg_777_1:FormatText(var_780_1.content)

				arg_777_1.text_.text = var_780_2

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_4 = 10 <= 0 and var_780_0 or var_780_0 * (utf8.len(var_780_2) / 10)

				if (10 <= 0 and var_780_0 or var_780_0 * (utf8.len(var_780_2) / 10)) > 0 and var_780_0 < var_780_4 then
					arg_777_1.talkMaxDuration = var_780_4

					if var_780_4 + 0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_4 + 0
					end
				end

				arg_777_1.text_.text = var_780_2
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb") ~= 0 then
					local var_780_5 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb") / 1000

					if var_780_5 + 0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_5 + 0
					end

					if var_780_1.prefab_name ~= "" and arg_777_1.actors_[var_780_1.prefab_name] ~= nil then
						local var_780_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_777_1.actors_[var_780_1.prefab_name].transform, "story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb")

						arg_777_1:RecordAudio("924041185", var_780_6)
						arg_777_1:RecordAudio("924041185", var_780_6)
					else
						arg_777_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb")
					end

					arg_777_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041185", "story_v_side_old_924041.awb")
				end

				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_7 = math.max(var_780_0, arg_777_1.talkMaxDuration)

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_7 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - 0) / var_780_7

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= 0 + var_780_7 and arg_777_1.time_ < 0 + var_780_7 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play924041186 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 924041186
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play924041187(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = 0.825

			if 0 < arg_781_1.time_ and arg_781_1.time_ <= 0 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, false)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_781_1.iconTrs_.gameObject, false)
				arg_781_1.callingController_:SetSelectedState("normal")

				local var_784_1 = arg_781_1:FormatText(arg_781_1:GetWordFromCfg(924041186).content)

				arg_781_1.text_.text = var_784_1

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_3 = 33 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 33)

				if (33 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 33)) > 0 and var_784_0 < var_784_3 then
					arg_781_1.talkMaxDuration = var_784_3

					if var_784_3 + 0 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_3 + 0
					end
				end

				arg_781_1.text_.text = var_784_1
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)
				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_4 = math.max(var_784_0, arg_781_1.talkMaxDuration)

			if 0 <= arg_781_1.time_ and arg_781_1.time_ < 0 + var_784_4 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - 0) / var_784_4

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= 0 + var_784_4 and arg_781_1.time_ < 0 + var_784_4 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {}

		arg_781_1:InitPlayNodeList()
	end,
	Play924041187 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 924041187
		arg_785_1.duration_ = 7

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play924041188(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			if arg_785_1.bgs_.X204_h == nil then
				local var_788_0 = Object.Instantiate(arg_785_1.paintGo_)

				var_788_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "X204_h")
				var_788_0.name = "X204_h"
				var_788_0.transform.parent = arg_785_1.stage_.transform
				var_788_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_785_1.bgs_.X204_h = var_788_0
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				local var_788_1 = arg_785_1.bgs_.X204_h

				arg_785_1.bgs_.X204_h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_788_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_788_2 = var_788_1:GetComponent("SpriteRenderer")

				if var_788_2 and var_788_2.sprite then
					local var_788_3 = 2 * (var_788_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_788_1.transform.localScale = Vector3.New(var_788_3 / var_788_2.sprite.bounds.size.y < var_788_3 * manager.ui.mainCameraCom_.aspect / var_788_2.sprite.bounds.size.x and var_788_3 * manager.ui.mainCameraCom_.aspect / var_788_2.sprite.bounds.size.x or var_788_3 / var_788_2.sprite.bounds.size.y, var_788_3 / var_788_2.sprite.bounds.size.y < var_788_3 * manager.ui.mainCameraCom_.aspect / var_788_2.sprite.bounds.size.x and var_788_3 * manager.ui.mainCameraCom_.aspect / var_788_2.sprite.bounds.size.x or var_788_3 / var_788_2.sprite.bounds.size.y, 0)
				end

				for iter_788_0, iter_788_1 in pairs(arg_785_1.bgs_) do
					if iter_788_0 ~= "X204_h" then
						iter_788_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_788_4 = 2

			if 2 < arg_785_1.time_ and arg_785_1.time_ <= var_788_4 + arg_788_0 then
				arg_785_1.allBtn_.enabled = false
			end

			if arg_785_1.time_ >= var_788_4 + 0.3 and arg_785_1.time_ < var_788_4 + 0.3 + arg_788_0 then
				arg_785_1.allBtn_.enabled = true
			end

			local var_788_5 = 0

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= var_788_5 + arg_788_0 then
				arg_785_1.mask_.enabled = true
				arg_785_1.mask_.raycastTarget = true

				arg_785_1:SetGaussion(false)
			end

			local var_788_6 = 2

			if var_788_5 <= arg_785_1.time_ and arg_785_1.time_ < var_788_5 + var_788_6 then
				local var_788_7 = Color.New(0, 0, 0)

				var_788_7.a = Mathf.Lerp(1, 0, (arg_785_1.time_ - var_788_5) / var_788_6)
				arg_785_1.mask_.color = var_788_7
			end

			if arg_785_1.time_ >= var_788_5 + var_788_6 and arg_785_1.time_ < var_788_5 + var_788_6 + arg_788_0 then
				local var_788_8 = Color.New(0, 0, 0)

				arg_785_1.mask_.enabled = false
				var_788_8.a = 0
				arg_785_1.mask_.color = var_788_8
			end

			if 5.55111512312578e-17 < arg_785_1.time_ and arg_785_1.time_ <= 5.55111512312578e-17 + arg_788_0 then
				arg_785_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_room", "")
			end

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night", "")
			end

			if arg_785_1.frameCnt_ <= 1 then
				arg_785_1.dialog_:SetActive(false)
			end

			local var_788_11 = 2
			local var_788_12 = 0.475

			if 2 < arg_785_1.time_ and arg_785_1.time_ <= var_788_11 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0

				arg_785_1.dialog_:SetActive(true)

				arg_785_1.dialogCg_.alpha = 0

				local var_788_13 = LeanTween.value(arg_785_1.dialog_, 0, 1, 0.3)

				var_788_13:setOnUpdate(LuaHelper.FloatAction(function(arg_789_0)
					arg_785_1.dialogCg_.alpha = arg_789_0
				end))
				var_788_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_785_1.dialog_)
					var_788_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_785_1.duration_ = arg_785_1.duration_ + 0.3

				SetActive(arg_785_1.leftNameGo_, false)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_14 = arg_785_1:FormatText(arg_785_1:GetWordFromCfg(924041187).content)

				arg_785_1.text_.text = var_788_14

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_16 = 19 <= 0 and var_788_12 or var_788_12 * (utf8.len(var_788_14) / 19)

				if (19 <= 0 and var_788_12 or var_788_12 * (utf8.len(var_788_14) / 19)) > 0 and var_788_12 < var_788_16 then
					arg_785_1.talkMaxDuration = var_788_16
					var_788_11 = var_788_11 + 0.3

					if var_788_16 + var_788_11 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_16 + var_788_11
					end
				end

				arg_785_1.text_.text = var_788_14
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)
				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_17 = var_788_11 + 0.3
			local var_788_18 = math.max(var_788_12, arg_785_1.talkMaxDuration)

			if var_788_11 + 0.3 <= arg_785_1.time_ and arg_785_1.time_ < var_788_17 + var_788_18 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_17) / var_788_18

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_17 + var_788_18 and arg_785_1.time_ < var_788_17 + var_788_18 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play924041188 = function(arg_791_0, arg_791_1)
		arg_791_1.time_ = 0
		arg_791_1.frameCnt_ = 0
		arg_791_1.state_ = "playing"
		arg_791_1.curTalkId_ = 924041188
		arg_791_1.duration_ = 5

		SetActive(arg_791_1.tipsGo_, false)

		function arg_791_1.onSingleLineFinish_()
			arg_791_1.onSingleLineUpdate_ = nil
			arg_791_1.onSingleLineFinish_ = nil
			arg_791_1.state_ = "waiting"
		end

		function arg_791_1.playNext_(arg_793_0)
			if arg_793_0 == 1 then
				arg_791_0:Play924041189(arg_791_1)
			end
		end

		function arg_791_1.onSingleLineUpdate_(arg_794_0)
			local var_794_0 = 0.275

			if 0 < arg_791_1.time_ and arg_791_1.time_ <= 0 + arg_794_0 then
				arg_791_1.talkMaxDuration = 0
				arg_791_1.dialogCg_.alpha = 1

				arg_791_1.dialog_:SetActive(true)
				SetActive(arg_791_1.leftNameGo_, true)

				arg_791_1.leftNameTxt_.text = arg_791_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_791_1.leftNameTxt_.transform)

				arg_791_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_791_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_791_1:RecordName(arg_791_1.leftNameTxt_.text)
				SetActive(arg_791_1.iconTrs_.gameObject, true)
				arg_791_1.iconController_:SetSelectedState("hero")

				arg_791_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_791_1.callingController_:SetSelectedState("normal")

				arg_791_1.keyicon_.color = Color.New(1, 1, 1)
				arg_791_1.icon_.color = Color.New(1, 1, 1)

				local var_794_1 = arg_791_1:FormatText(arg_791_1:GetWordFromCfg(924041188).content)

				arg_791_1.text_.text = var_794_1

				LuaForUtil.ClearLinePrefixSymbol(arg_791_1.text_)

				local var_794_3 = 11 <= 0 and var_794_0 or var_794_0 * (utf8.len(var_794_1) / 11)

				if (11 <= 0 and var_794_0 or var_794_0 * (utf8.len(var_794_1) / 11)) > 0 and var_794_0 < var_794_3 then
					arg_791_1.talkMaxDuration = var_794_3

					if var_794_3 + 0 > arg_791_1.duration_ then
						arg_791_1.duration_ = var_794_3 + 0
					end
				end

				arg_791_1.text_.text = var_794_1
				arg_791_1.typewritter.percent = 0

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(false)
				arg_791_1:RecordContent(arg_791_1.text_.text)
			end

			local var_794_4 = math.max(var_794_0, arg_791_1.talkMaxDuration)

			if 0 <= arg_791_1.time_ and arg_791_1.time_ < 0 + var_794_4 then
				arg_791_1.typewritter.percent = (arg_791_1.time_ - 0) / var_794_4

				arg_791_1.typewritter:SetDirty()
			end

			if arg_791_1.time_ >= 0 + var_794_4 and arg_791_1.time_ < 0 + var_794_4 + arg_794_0 then
				arg_791_1.typewritter.percent = 1

				arg_791_1.typewritter:SetDirty()
				arg_791_1:ShowNextGo(true)
			end
		end

		arg_791_1.nodeConfigList_ = {}

		arg_791_1:InitPlayNodeList()
	end,
	Play924041189 = function(arg_795_0, arg_795_1)
		arg_795_1.time_ = 0
		arg_795_1.frameCnt_ = 0
		arg_795_1.state_ = "playing"
		arg_795_1.curTalkId_ = 924041189
		arg_795_1.duration_ = 5

		SetActive(arg_795_1.tipsGo_, false)

		function arg_795_1.onSingleLineFinish_()
			arg_795_1.onSingleLineUpdate_ = nil
			arg_795_1.onSingleLineFinish_ = nil
			arg_795_1.state_ = "waiting"
		end

		function arg_795_1.playNext_(arg_797_0)
			if arg_797_0 == 1 then
				arg_795_0:Play924041190(arg_795_1)
			end
		end

		function arg_795_1.onSingleLineUpdate_(arg_798_0)
			local var_798_0 = 0.925

			if 0 < arg_795_1.time_ and arg_795_1.time_ <= 0 + arg_798_0 then
				arg_795_1.talkMaxDuration = 0
				arg_795_1.dialogCg_.alpha = 1

				arg_795_1.dialog_:SetActive(true)
				SetActive(arg_795_1.leftNameGo_, false)

				arg_795_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_795_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_795_1:RecordName(arg_795_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_795_1.iconTrs_.gameObject, false)
				arg_795_1.callingController_:SetSelectedState("normal")

				local var_798_1 = arg_795_1:FormatText(arg_795_1:GetWordFromCfg(924041189).content)

				arg_795_1.text_.text = var_798_1

				LuaForUtil.ClearLinePrefixSymbol(arg_795_1.text_)

				local var_798_3 = 37 <= 0 and var_798_0 or var_798_0 * (utf8.len(var_798_1) / 37)

				if (37 <= 0 and var_798_0 or var_798_0 * (utf8.len(var_798_1) / 37)) > 0 and var_798_0 < var_798_3 then
					arg_795_1.talkMaxDuration = var_798_3

					if var_798_3 + 0 > arg_795_1.duration_ then
						arg_795_1.duration_ = var_798_3 + 0
					end
				end

				arg_795_1.text_.text = var_798_1
				arg_795_1.typewritter.percent = 0

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(false)
				arg_795_1:RecordContent(arg_795_1.text_.text)
			end

			local var_798_4 = math.max(var_798_0, arg_795_1.talkMaxDuration)

			if 0 <= arg_795_1.time_ and arg_795_1.time_ < 0 + var_798_4 then
				arg_795_1.typewritter.percent = (arg_795_1.time_ - 0) / var_798_4

				arg_795_1.typewritter:SetDirty()
			end

			if arg_795_1.time_ >= 0 + var_798_4 and arg_795_1.time_ < 0 + var_798_4 + arg_798_0 then
				arg_795_1.typewritter.percent = 1

				arg_795_1.typewritter:SetDirty()
				arg_795_1:ShowNextGo(true)
			end
		end

		arg_795_1.nodeConfigList_ = {}

		arg_795_1:InitPlayNodeList()
	end,
	Play924041190 = function(arg_799_0, arg_799_1)
		arg_799_1.time_ = 0
		arg_799_1.frameCnt_ = 0
		arg_799_1.state_ = "playing"
		arg_799_1.curTalkId_ = 924041190
		arg_799_1.duration_ = 3.4

		local var_799_0 = {
			zh = 3.3,
			ja = 3.4
		}
		local var_799_1 = manager.audio:GetLocalizationFlag()

		if var_799_0[var_799_1] ~= nil then
			arg_799_1.duration_ = var_799_0[var_799_1]
		end

		SetActive(arg_799_1.tipsGo_, false)

		function arg_799_1.onSingleLineFinish_()
			arg_799_1.onSingleLineUpdate_ = nil
			arg_799_1.onSingleLineFinish_ = nil
			arg_799_1.state_ = "waiting"
		end

		function arg_799_1.playNext_(arg_801_0)
			if arg_801_0 == 1 then
				arg_799_0:Play924041191(arg_799_1)
			end
		end

		function arg_799_1.onSingleLineUpdate_(arg_802_0)
			if 0 < arg_799_1.time_ and arg_799_1.time_ <= 0 + arg_802_0 then
				arg_799_1.var_.moveOldPos102003ui_story = arg_799_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_802_0 = 0.001

			if 0 <= arg_799_1.time_ and arg_799_1.time_ < 0 + var_802_0 then
				arg_799_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_799_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_799_1.time_ - 0) / var_802_0)
				arg_799_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_799_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_799_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_799_1.actors_["102003ui_story"].transform.position).z)
				arg_799_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_799_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_799_1.actors_["102003ui_story"].transform.localEulerAngles = arg_799_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_799_1.time_ >= 0 + var_802_0 and arg_799_1.time_ < 0 + var_802_0 + arg_802_0 then
				arg_799_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_799_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_799_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_799_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_799_1.actors_["102003ui_story"].transform.position).z)
				arg_799_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_799_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_799_1.actors_["102003ui_story"].transform.localEulerAngles = arg_799_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_802_1 = arg_799_1.actors_["102003ui_story"]

			if 0 < arg_799_1.time_ and arg_799_1.time_ <= 0 + arg_802_0 and not isNil(var_802_1) and arg_799_1.var_.characterEffect102003ui_story == nil then
				arg_799_1.var_.characterEffect102003ui_story = var_802_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_802_2 = 0.200000002980232

			if 0 <= arg_799_1.time_ and arg_799_1.time_ < 0 + var_802_2 and not isNil(var_802_1) then
				if arg_799_1.var_.characterEffect102003ui_story and not isNil(var_802_1) then
					arg_799_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_799_1.time_ >= 0 + var_802_2 and arg_799_1.time_ < 0 + var_802_2 + arg_802_0 and not isNil(var_802_1) and arg_799_1.var_.characterEffect102003ui_story then
				arg_799_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_799_1.time_ and arg_799_1.time_ <= 0 + arg_802_0 then
				arg_799_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_1")
			end

			if 0 < arg_799_1.time_ and arg_799_1.time_ <= 0 + arg_802_0 then
				arg_799_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_802_4 = 0
			local var_802_5 = 0.275

			if 0 < arg_799_1.time_ and arg_799_1.time_ <= var_802_4 + arg_802_0 then
				arg_799_1.talkMaxDuration = 0
				arg_799_1.dialogCg_.alpha = 1

				arg_799_1.dialog_:SetActive(true)
				SetActive(arg_799_1.leftNameGo_, true)

				arg_799_1.leftNameTxt_.text = arg_799_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_799_1.leftNameTxt_.transform)

				arg_799_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_799_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_799_1:RecordName(arg_799_1.leftNameTxt_.text)
				SetActive(arg_799_1.iconTrs_.gameObject, false)
				arg_799_1.callingController_:SetSelectedState("normal")

				local var_802_6 = arg_799_1:GetWordFromCfg(924041190)
				local var_802_7 = arg_799_1:FormatText(var_802_6.content)

				arg_799_1.text_.text = var_802_7

				LuaForUtil.ClearLinePrefixSymbol(arg_799_1.text_)

				local var_802_9 = 11 <= 0 and var_802_5 or var_802_5 * (utf8.len(var_802_7) / 11)

				if (11 <= 0 and var_802_5 or var_802_5 * (utf8.len(var_802_7) / 11)) > 0 and var_802_5 < var_802_9 then
					arg_799_1.talkMaxDuration = var_802_9

					if var_802_9 + var_802_4 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_9 + var_802_4
					end
				end

				arg_799_1.text_.text = var_802_7
				arg_799_1.typewritter.percent = 0

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb") ~= 0 then
					local var_802_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb") / 1000

					if var_802_10 + var_802_4 > arg_799_1.duration_ then
						arg_799_1.duration_ = var_802_10 + var_802_4
					end

					if var_802_6.prefab_name ~= "" and arg_799_1.actors_[var_802_6.prefab_name] ~= nil then
						local var_802_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_799_1.actors_[var_802_6.prefab_name].transform, "story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb")

						arg_799_1:RecordAudio("924041190", var_802_11)
						arg_799_1:RecordAudio("924041190", var_802_11)
					else
						arg_799_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb")
					end

					arg_799_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041190", "story_v_side_old_924041.awb")
				end

				arg_799_1:RecordContent(arg_799_1.text_.text)
			end

			local var_802_12 = math.max(var_802_5, arg_799_1.talkMaxDuration)

			if var_802_4 <= arg_799_1.time_ and arg_799_1.time_ < var_802_4 + var_802_12 then
				arg_799_1.typewritter.percent = (arg_799_1.time_ - var_802_4) / var_802_12

				arg_799_1.typewritter:SetDirty()
			end

			if arg_799_1.time_ >= var_802_4 + var_802_12 and arg_799_1.time_ < var_802_4 + var_802_12 + arg_802_0 then
				arg_799_1.typewritter.percent = 1

				arg_799_1.typewritter:SetDirty()
				arg_799_1:ShowNextGo(true)
			end
		end

		arg_799_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_799_1:InitPlayNodeList()
	end,
	Play924041191 = function(arg_803_0, arg_803_1)
		arg_803_1.time_ = 0
		arg_803_1.frameCnt_ = 0
		arg_803_1.state_ = "playing"
		arg_803_1.curTalkId_ = 924041191
		arg_803_1.duration_ = 5

		SetActive(arg_803_1.tipsGo_, false)

		function arg_803_1.onSingleLineFinish_()
			arg_803_1.onSingleLineUpdate_ = nil
			arg_803_1.onSingleLineFinish_ = nil
			arg_803_1.state_ = "waiting"
		end

		function arg_803_1.playNext_(arg_805_0)
			if arg_805_0 == 1 then
				arg_803_0:Play924041192(arg_803_1)
			end
		end

		function arg_803_1.onSingleLineUpdate_(arg_806_0)
			if 0 < arg_803_1.time_ and arg_803_1.time_ <= 0 + arg_806_0 then
				arg_803_1.var_.moveOldPos102003ui_story = arg_803_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_806_0 = 0.001

			if 0 <= arg_803_1.time_ and arg_803_1.time_ < 0 + var_806_0 then
				arg_803_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_803_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_803_1.time_ - 0) / var_806_0)
				arg_803_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_803_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_803_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_803_1.actors_["102003ui_story"].transform.position).z)
				arg_803_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_803_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_803_1.actors_["102003ui_story"].transform.localEulerAngles = arg_803_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_803_1.time_ >= 0 + var_806_0 and arg_803_1.time_ < 0 + var_806_0 + arg_806_0 then
				arg_803_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_803_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_803_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_803_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_803_1.actors_["102003ui_story"].transform.position).z)
				arg_803_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_803_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_803_1.actors_["102003ui_story"].transform.localEulerAngles = arg_803_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_806_1 = arg_803_1.actors_["102003ui_story"]

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= 0 + arg_806_0 and not isNil(var_806_1) and arg_803_1.var_.characterEffect102003ui_story == nil then
				arg_803_1.var_.characterEffect102003ui_story = var_806_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_806_2 = 0.200000002980232

			if 0 <= arg_803_1.time_ and arg_803_1.time_ < 0 + var_806_2 and not isNil(var_806_1) then
				if arg_803_1.var_.characterEffect102003ui_story and not isNil(var_806_1) then
					arg_803_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_803_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_803_1.time_ - 0) / var_806_2)
				end
			end

			if arg_803_1.time_ >= 0 + var_806_2 and arg_803_1.time_ < 0 + var_806_2 + arg_806_0 and not isNil(var_806_1) and arg_803_1.var_.characterEffect102003ui_story then
				arg_803_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_803_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_806_3 = 0
			local var_806_4 = 0.85

			if 0 < arg_803_1.time_ and arg_803_1.time_ <= var_806_3 + arg_806_0 then
				arg_803_1.talkMaxDuration = 0
				arg_803_1.dialogCg_.alpha = 1

				arg_803_1.dialog_:SetActive(true)
				SetActive(arg_803_1.leftNameGo_, false)

				arg_803_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_803_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_803_1:RecordName(arg_803_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_803_1.iconTrs_.gameObject, false)
				arg_803_1.callingController_:SetSelectedState("normal")

				local var_806_5 = arg_803_1:FormatText(arg_803_1:GetWordFromCfg(924041191).content)

				arg_803_1.text_.text = var_806_5

				LuaForUtil.ClearLinePrefixSymbol(arg_803_1.text_)

				local var_806_7 = 34 <= 0 and var_806_4 or var_806_4 * (utf8.len(var_806_5) / 34)

				if (34 <= 0 and var_806_4 or var_806_4 * (utf8.len(var_806_5) / 34)) > 0 and var_806_4 < var_806_7 then
					arg_803_1.talkMaxDuration = var_806_7

					if var_806_7 + var_806_3 > arg_803_1.duration_ then
						arg_803_1.duration_ = var_806_7 + var_806_3
					end
				end

				arg_803_1.text_.text = var_806_5
				arg_803_1.typewritter.percent = 0

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(false)
				arg_803_1:RecordContent(arg_803_1.text_.text)
			end

			local var_806_8 = math.max(var_806_4, arg_803_1.talkMaxDuration)

			if var_806_3 <= arg_803_1.time_ and arg_803_1.time_ < var_806_3 + var_806_8 then
				arg_803_1.typewritter.percent = (arg_803_1.time_ - var_806_3) / var_806_8

				arg_803_1.typewritter:SetDirty()
			end

			if arg_803_1.time_ >= var_806_3 + var_806_8 and arg_803_1.time_ < var_806_3 + var_806_8 + arg_806_0 then
				arg_803_1.typewritter.percent = 1

				arg_803_1.typewritter:SetDirty()
				arg_803_1:ShowNextGo(true)
			end
		end

		arg_803_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_803_1:InitPlayNodeList()
	end,
	Play924041192 = function(arg_807_0, arg_807_1)
		arg_807_1.time_ = 0
		arg_807_1.frameCnt_ = 0
		arg_807_1.state_ = "playing"
		arg_807_1.curTalkId_ = 924041192
		arg_807_1.duration_ = 5

		SetActive(arg_807_1.tipsGo_, false)

		function arg_807_1.onSingleLineFinish_()
			arg_807_1.onSingleLineUpdate_ = nil
			arg_807_1.onSingleLineFinish_ = nil
			arg_807_1.state_ = "waiting"
		end

		function arg_807_1.playNext_(arg_809_0)
			if arg_809_0 == 1 then
				arg_807_0:Play924041193(arg_807_1)
			end
		end

		function arg_807_1.onSingleLineUpdate_(arg_810_0)
			local var_810_0 = 0.25

			if 0 < arg_807_1.time_ and arg_807_1.time_ <= 0 + arg_810_0 then
				arg_807_1.talkMaxDuration = 0
				arg_807_1.dialogCg_.alpha = 1

				arg_807_1.dialog_:SetActive(true)
				SetActive(arg_807_1.leftNameGo_, true)

				arg_807_1.leftNameTxt_.text = arg_807_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_807_1.leftNameTxt_.transform)

				arg_807_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_807_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_807_1:RecordName(arg_807_1.leftNameTxt_.text)
				SetActive(arg_807_1.iconTrs_.gameObject, true)
				arg_807_1.iconController_:SetSelectedState("hero")

				arg_807_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_807_1.callingController_:SetSelectedState("normal")

				arg_807_1.keyicon_.color = Color.New(1, 1, 1)
				arg_807_1.icon_.color = Color.New(1, 1, 1)

				local var_810_1 = arg_807_1:FormatText(arg_807_1:GetWordFromCfg(924041192).content)

				arg_807_1.text_.text = var_810_1

				LuaForUtil.ClearLinePrefixSymbol(arg_807_1.text_)

				local var_810_3 = 10 <= 0 and var_810_0 or var_810_0 * (utf8.len(var_810_1) / 10)

				if (10 <= 0 and var_810_0 or var_810_0 * (utf8.len(var_810_1) / 10)) > 0 and var_810_0 < var_810_3 then
					arg_807_1.talkMaxDuration = var_810_3

					if var_810_3 + 0 > arg_807_1.duration_ then
						arg_807_1.duration_ = var_810_3 + 0
					end
				end

				arg_807_1.text_.text = var_810_1
				arg_807_1.typewritter.percent = 0

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(false)
				arg_807_1:RecordContent(arg_807_1.text_.text)
			end

			local var_810_4 = math.max(var_810_0, arg_807_1.talkMaxDuration)

			if 0 <= arg_807_1.time_ and arg_807_1.time_ < 0 + var_810_4 then
				arg_807_1.typewritter.percent = (arg_807_1.time_ - 0) / var_810_4

				arg_807_1.typewritter:SetDirty()
			end

			if arg_807_1.time_ >= 0 + var_810_4 and arg_807_1.time_ < 0 + var_810_4 + arg_810_0 then
				arg_807_1.typewritter.percent = 1

				arg_807_1.typewritter:SetDirty()
				arg_807_1:ShowNextGo(true)
			end
		end

		arg_807_1.nodeConfigList_ = {}

		arg_807_1:InitPlayNodeList()
	end,
	Play924041193 = function(arg_811_0, arg_811_1)
		arg_811_1.time_ = 0
		arg_811_1.frameCnt_ = 0
		arg_811_1.state_ = "playing"
		arg_811_1.curTalkId_ = 924041193
		arg_811_1.duration_ = 8.5

		local var_811_0 = {
			zh = 8.5,
			ja = 8.1
		}
		local var_811_1 = manager.audio:GetLocalizationFlag()

		if var_811_0[var_811_1] ~= nil then
			arg_811_1.duration_ = var_811_0[var_811_1]
		end

		SetActive(arg_811_1.tipsGo_, false)

		function arg_811_1.onSingleLineFinish_()
			arg_811_1.onSingleLineUpdate_ = nil
			arg_811_1.onSingleLineFinish_ = nil
			arg_811_1.state_ = "waiting"
		end

		function arg_811_1.playNext_(arg_813_0)
			if arg_813_0 == 1 then
				arg_811_0:Play924041194(arg_811_1)
			end
		end

		function arg_811_1.onSingleLineUpdate_(arg_814_0)
			if 0 < arg_811_1.time_ and arg_811_1.time_ <= 0 + arg_814_0 then
				arg_811_1.var_.moveOldPos102003ui_story = arg_811_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_814_0 = 0.001

			if 0 <= arg_811_1.time_ and arg_811_1.time_ < 0 + var_814_0 then
				arg_811_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_811_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_811_1.time_ - 0) / var_814_0)
				arg_811_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_811_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_811_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_811_1.actors_["102003ui_story"].transform.position).z)
				arg_811_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_811_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_811_1.actors_["102003ui_story"].transform.localEulerAngles = arg_811_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_811_1.time_ >= 0 + var_814_0 and arg_811_1.time_ < 0 + var_814_0 + arg_814_0 then
				arg_811_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_811_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_811_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_811_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_811_1.actors_["102003ui_story"].transform.position).z)
				arg_811_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_811_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_811_1.actors_["102003ui_story"].transform.localEulerAngles = arg_811_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_814_1 = arg_811_1.actors_["102003ui_story"]

			if 0 < arg_811_1.time_ and arg_811_1.time_ <= 0 + arg_814_0 and not isNil(var_814_1) and arg_811_1.var_.characterEffect102003ui_story == nil then
				arg_811_1.var_.characterEffect102003ui_story = var_814_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_814_2 = 0.200000002980232

			if 0 <= arg_811_1.time_ and arg_811_1.time_ < 0 + var_814_2 and not isNil(var_814_1) then
				if arg_811_1.var_.characterEffect102003ui_story and not isNil(var_814_1) then
					arg_811_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_811_1.time_ >= 0 + var_814_2 and arg_811_1.time_ < 0 + var_814_2 + arg_814_0 and not isNil(var_814_1) and arg_811_1.var_.characterEffect102003ui_story then
				arg_811_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_811_1.time_ and arg_811_1.time_ <= 0 + arg_814_0 then
				arg_811_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action8_2")
			end

			local var_814_4 = 0
			local var_814_5 = 0.875

			if 0 < arg_811_1.time_ and arg_811_1.time_ <= var_814_4 + arg_814_0 then
				arg_811_1.talkMaxDuration = 0
				arg_811_1.dialogCg_.alpha = 1

				arg_811_1.dialog_:SetActive(true)
				SetActive(arg_811_1.leftNameGo_, true)

				arg_811_1.leftNameTxt_.text = arg_811_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_811_1.leftNameTxt_.transform)

				arg_811_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_811_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_811_1:RecordName(arg_811_1.leftNameTxt_.text)
				SetActive(arg_811_1.iconTrs_.gameObject, false)
				arg_811_1.callingController_:SetSelectedState("normal")

				local var_814_6 = arg_811_1:GetWordFromCfg(924041193)
				local var_814_7 = arg_811_1:FormatText(var_814_6.content)

				arg_811_1.text_.text = var_814_7

				LuaForUtil.ClearLinePrefixSymbol(arg_811_1.text_)

				local var_814_9 = 35 <= 0 and var_814_5 or var_814_5 * (utf8.len(var_814_7) / 35)

				if (35 <= 0 and var_814_5 or var_814_5 * (utf8.len(var_814_7) / 35)) > 0 and var_814_5 < var_814_9 then
					arg_811_1.talkMaxDuration = var_814_9

					if var_814_9 + var_814_4 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_9 + var_814_4
					end
				end

				arg_811_1.text_.text = var_814_7
				arg_811_1.typewritter.percent = 0

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb") ~= 0 then
					local var_814_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb") / 1000

					if var_814_10 + var_814_4 > arg_811_1.duration_ then
						arg_811_1.duration_ = var_814_10 + var_814_4
					end

					if var_814_6.prefab_name ~= "" and arg_811_1.actors_[var_814_6.prefab_name] ~= nil then
						local var_814_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_811_1.actors_[var_814_6.prefab_name].transform, "story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb")

						arg_811_1:RecordAudio("924041193", var_814_11)
						arg_811_1:RecordAudio("924041193", var_814_11)
					else
						arg_811_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb")
					end

					arg_811_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041193", "story_v_side_old_924041.awb")
				end

				arg_811_1:RecordContent(arg_811_1.text_.text)
			end

			local var_814_12 = math.max(var_814_5, arg_811_1.talkMaxDuration)

			if var_814_4 <= arg_811_1.time_ and arg_811_1.time_ < var_814_4 + var_814_12 then
				arg_811_1.typewritter.percent = (arg_811_1.time_ - var_814_4) / var_814_12

				arg_811_1.typewritter:SetDirty()
			end

			if arg_811_1.time_ >= var_814_4 + var_814_12 and arg_811_1.time_ < var_814_4 + var_814_12 + arg_814_0 then
				arg_811_1.typewritter.percent = 1

				arg_811_1.typewritter:SetDirty()
				arg_811_1:ShowNextGo(true)
			end
		end

		arg_811_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_811_1:InitPlayNodeList()
	end,
	Play924041194 = function(arg_815_0, arg_815_1)
		arg_815_1.time_ = 0
		arg_815_1.frameCnt_ = 0
		arg_815_1.state_ = "playing"
		arg_815_1.curTalkId_ = 924041194
		arg_815_1.duration_ = 5

		SetActive(arg_815_1.tipsGo_, false)

		function arg_815_1.onSingleLineFinish_()
			arg_815_1.onSingleLineUpdate_ = nil
			arg_815_1.onSingleLineFinish_ = nil
			arg_815_1.state_ = "waiting"
		end

		function arg_815_1.playNext_(arg_817_0)
			if arg_817_0 == 1 then
				arg_815_0:Play924041195(arg_815_1)
			end
		end

		function arg_815_1.onSingleLineUpdate_(arg_818_0)
			if 0 < arg_815_1.time_ and arg_815_1.time_ <= 0 + arg_818_0 and not isNil(arg_815_1.actors_["102003ui_story"]) and arg_815_1.var_.characterEffect102003ui_story == nil then
				arg_815_1.var_.characterEffect102003ui_story = arg_815_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_818_0 = 0.200000002980232

			if 0 <= arg_815_1.time_ and arg_815_1.time_ < 0 + var_818_0 and not isNil(arg_815_1.actors_["102003ui_story"]) then
				if arg_815_1.var_.characterEffect102003ui_story and not isNil(arg_815_1.actors_["102003ui_story"]) then
					arg_815_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_815_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_815_1.time_ - 0) / var_818_0)
				end
			end

			if arg_815_1.time_ >= 0 + var_818_0 and arg_815_1.time_ < 0 + var_818_0 + arg_818_0 and not isNil(arg_815_1.actors_["102003ui_story"]) and arg_815_1.var_.characterEffect102003ui_story then
				arg_815_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_815_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_818_1 = 0
			local var_818_2 = 0.45

			if 0 < arg_815_1.time_ and arg_815_1.time_ <= var_818_1 + arg_818_0 then
				arg_815_1.talkMaxDuration = 0
				arg_815_1.dialogCg_.alpha = 1

				arg_815_1.dialog_:SetActive(true)
				SetActive(arg_815_1.leftNameGo_, true)

				arg_815_1.leftNameTxt_.text = arg_815_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_815_1.leftNameTxt_.transform)

				arg_815_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_815_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_815_1:RecordName(arg_815_1.leftNameTxt_.text)
				SetActive(arg_815_1.iconTrs_.gameObject, true)
				arg_815_1.iconController_:SetSelectedState("hero")

				arg_815_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_815_1.callingController_:SetSelectedState("normal")

				arg_815_1.keyicon_.color = Color.New(1, 1, 1)
				arg_815_1.icon_.color = Color.New(1, 1, 1)

				local var_818_3 = arg_815_1:FormatText(arg_815_1:GetWordFromCfg(924041194).content)

				arg_815_1.text_.text = var_818_3

				LuaForUtil.ClearLinePrefixSymbol(arg_815_1.text_)

				local var_818_5 = 18 <= 0 and var_818_2 or var_818_2 * (utf8.len(var_818_3) / 18)

				if (18 <= 0 and var_818_2 or var_818_2 * (utf8.len(var_818_3) / 18)) > 0 and var_818_2 < var_818_5 then
					arg_815_1.talkMaxDuration = var_818_5

					if var_818_5 + var_818_1 > arg_815_1.duration_ then
						arg_815_1.duration_ = var_818_5 + var_818_1
					end
				end

				arg_815_1.text_.text = var_818_3
				arg_815_1.typewritter.percent = 0

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(false)
				arg_815_1:RecordContent(arg_815_1.text_.text)
			end

			local var_818_6 = math.max(var_818_2, arg_815_1.talkMaxDuration)

			if var_818_1 <= arg_815_1.time_ and arg_815_1.time_ < var_818_1 + var_818_6 then
				arg_815_1.typewritter.percent = (arg_815_1.time_ - var_818_1) / var_818_6

				arg_815_1.typewritter:SetDirty()
			end

			if arg_815_1.time_ >= var_818_1 + var_818_6 and arg_815_1.time_ < var_818_1 + var_818_6 + arg_818_0 then
				arg_815_1.typewritter.percent = 1

				arg_815_1.typewritter:SetDirty()
				arg_815_1:ShowNextGo(true)
			end
		end

		arg_815_1.nodeConfigList_ = {}

		arg_815_1:InitPlayNodeList()
	end,
	Play924041195 = function(arg_819_0, arg_819_1)
		arg_819_1.time_ = 0
		arg_819_1.frameCnt_ = 0
		arg_819_1.state_ = "playing"
		arg_819_1.curTalkId_ = 924041195
		arg_819_1.duration_ = 3.23

		local var_819_0 = {
			zh = 1.366,
			ja = 3.233
		}
		local var_819_1 = manager.audio:GetLocalizationFlag()

		if var_819_0[var_819_1] ~= nil then
			arg_819_1.duration_ = var_819_0[var_819_1]
		end

		SetActive(arg_819_1.tipsGo_, false)

		function arg_819_1.onSingleLineFinish_()
			arg_819_1.onSingleLineUpdate_ = nil
			arg_819_1.onSingleLineFinish_ = nil
			arg_819_1.state_ = "waiting"
		end

		function arg_819_1.playNext_(arg_821_0)
			if arg_821_0 == 1 then
				arg_819_0:Play924041196(arg_819_1)
			end
		end

		function arg_819_1.onSingleLineUpdate_(arg_822_0)
			if 0 < arg_819_1.time_ and arg_819_1.time_ <= 0 + arg_822_0 then
				arg_819_1.var_.moveOldPos102003ui_story = arg_819_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_822_0 = 0.001

			if 0 <= arg_819_1.time_ and arg_819_1.time_ < 0 + var_822_0 then
				arg_819_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_819_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_819_1.time_ - 0) / var_822_0)
				arg_819_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_819_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_819_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_819_1.actors_["102003ui_story"].transform.position).z)
				arg_819_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_819_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_819_1.actors_["102003ui_story"].transform.localEulerAngles = arg_819_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_819_1.time_ >= 0 + var_822_0 and arg_819_1.time_ < 0 + var_822_0 + arg_822_0 then
				arg_819_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_819_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_819_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_819_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_819_1.actors_["102003ui_story"].transform.position).z)
				arg_819_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_819_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_819_1.actors_["102003ui_story"].transform.localEulerAngles = arg_819_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_822_1 = arg_819_1.actors_["102003ui_story"]

			if 0 < arg_819_1.time_ and arg_819_1.time_ <= 0 + arg_822_0 and not isNil(var_822_1) and arg_819_1.var_.characterEffect102003ui_story == nil then
				arg_819_1.var_.characterEffect102003ui_story = var_822_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_822_2 = 0.200000002980232

			if 0 <= arg_819_1.time_ and arg_819_1.time_ < 0 + var_822_2 and not isNil(var_822_1) then
				if arg_819_1.var_.characterEffect102003ui_story and not isNil(var_822_1) then
					arg_819_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_819_1.time_ >= 0 + var_822_2 and arg_819_1.time_ < 0 + var_822_2 + arg_822_0 and not isNil(var_822_1) and arg_819_1.var_.characterEffect102003ui_story then
				arg_819_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_819_1.time_ and arg_819_1.time_ <= 0 + arg_822_0 then
				arg_819_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action12_1")
			end

			if 0 < arg_819_1.time_ and arg_819_1.time_ <= 0 + arg_822_0 then
				arg_819_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_822_4 = 0
			local var_822_5 = 0.175

			if 0 < arg_819_1.time_ and arg_819_1.time_ <= var_822_4 + arg_822_0 then
				arg_819_1.talkMaxDuration = 0
				arg_819_1.dialogCg_.alpha = 1

				arg_819_1.dialog_:SetActive(true)
				SetActive(arg_819_1.leftNameGo_, true)

				arg_819_1.leftNameTxt_.text = arg_819_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_819_1.leftNameTxt_.transform)

				arg_819_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_819_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_819_1:RecordName(arg_819_1.leftNameTxt_.text)
				SetActive(arg_819_1.iconTrs_.gameObject, false)
				arg_819_1.callingController_:SetSelectedState("normal")

				local var_822_6 = arg_819_1:GetWordFromCfg(924041195)
				local var_822_7 = arg_819_1:FormatText(var_822_6.content)

				arg_819_1.text_.text = var_822_7

				LuaForUtil.ClearLinePrefixSymbol(arg_819_1.text_)

				local var_822_9 = 7 <= 0 and var_822_5 or var_822_5 * (utf8.len(var_822_7) / 7)

				if (7 <= 0 and var_822_5 or var_822_5 * (utf8.len(var_822_7) / 7)) > 0 and var_822_5 < var_822_9 then
					arg_819_1.talkMaxDuration = var_822_9

					if var_822_9 + var_822_4 > arg_819_1.duration_ then
						arg_819_1.duration_ = var_822_9 + var_822_4
					end
				end

				arg_819_1.text_.text = var_822_7
				arg_819_1.typewritter.percent = 0

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb") ~= 0 then
					local var_822_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb") / 1000

					if var_822_10 + var_822_4 > arg_819_1.duration_ then
						arg_819_1.duration_ = var_822_10 + var_822_4
					end

					if var_822_6.prefab_name ~= "" and arg_819_1.actors_[var_822_6.prefab_name] ~= nil then
						local var_822_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_819_1.actors_[var_822_6.prefab_name].transform, "story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb")

						arg_819_1:RecordAudio("924041195", var_822_11)
						arg_819_1:RecordAudio("924041195", var_822_11)
					else
						arg_819_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb")
					end

					arg_819_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041195", "story_v_side_old_924041.awb")
				end

				arg_819_1:RecordContent(arg_819_1.text_.text)
			end

			local var_822_12 = math.max(var_822_5, arg_819_1.talkMaxDuration)

			if var_822_4 <= arg_819_1.time_ and arg_819_1.time_ < var_822_4 + var_822_12 then
				arg_819_1.typewritter.percent = (arg_819_1.time_ - var_822_4) / var_822_12

				arg_819_1.typewritter:SetDirty()
			end

			if arg_819_1.time_ >= var_822_4 + var_822_12 and arg_819_1.time_ < var_822_4 + var_822_12 + arg_822_0 then
				arg_819_1.typewritter.percent = 1

				arg_819_1.typewritter:SetDirty()
				arg_819_1:ShowNextGo(true)
			end
		end

		arg_819_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_819_1:InitPlayNodeList()
	end,
	Play924041196 = function(arg_823_0, arg_823_1)
		arg_823_1.time_ = 0
		arg_823_1.frameCnt_ = 0
		arg_823_1.state_ = "playing"
		arg_823_1.curTalkId_ = 924041196
		arg_823_1.duration_ = 5

		SetActive(arg_823_1.tipsGo_, false)

		function arg_823_1.onSingleLineFinish_()
			arg_823_1.onSingleLineUpdate_ = nil
			arg_823_1.onSingleLineFinish_ = nil
			arg_823_1.state_ = "waiting"
		end

		function arg_823_1.playNext_(arg_825_0)
			if arg_825_0 == 1 then
				arg_823_0:Play924041197(arg_823_1)
			end
		end

		function arg_823_1.onSingleLineUpdate_(arg_826_0)
			if 0 < arg_823_1.time_ and arg_823_1.time_ <= 0 + arg_826_0 then
				arg_823_1.var_.moveOldPos102003ui_story = arg_823_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_826_0 = 0.001

			if 0 <= arg_823_1.time_ and arg_823_1.time_ < 0 + var_826_0 then
				arg_823_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_823_1.var_.moveOldPos102003ui_story, Vector3.New(0, 100, 0), (arg_823_1.time_ - 0) / var_826_0)
				arg_823_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_823_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_823_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_823_1.actors_["102003ui_story"].transform.position).z)
				arg_823_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_823_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_823_1.actors_["102003ui_story"].transform.localEulerAngles = arg_823_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_823_1.time_ >= 0 + var_826_0 and arg_823_1.time_ < 0 + var_826_0 + arg_826_0 then
				arg_823_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_823_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_823_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_823_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_823_1.actors_["102003ui_story"].transform.position).z)
				arg_823_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_823_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_823_1.actors_["102003ui_story"].transform.localEulerAngles = arg_823_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_826_1 = arg_823_1.actors_["102003ui_story"]

			if 0 < arg_823_1.time_ and arg_823_1.time_ <= 0 + arg_826_0 and not isNil(var_826_1) and arg_823_1.var_.characterEffect102003ui_story == nil then
				arg_823_1.var_.characterEffect102003ui_story = var_826_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_826_2 = 0.200000002980232

			if 0 <= arg_823_1.time_ and arg_823_1.time_ < 0 + var_826_2 and not isNil(var_826_1) then
				if arg_823_1.var_.characterEffect102003ui_story and not isNil(var_826_1) then
					arg_823_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_823_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_823_1.time_ - 0) / var_826_2)
				end
			end

			if arg_823_1.time_ >= 0 + var_826_2 and arg_823_1.time_ < 0 + var_826_2 + arg_826_0 and not isNil(var_826_1) and arg_823_1.var_.characterEffect102003ui_story then
				arg_823_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_823_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			if 0.566666666666667 < arg_823_1.time_ and arg_823_1.time_ <= 0.566666666666667 + arg_826_0 then
				arg_823_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hug", "")
			end

			local var_826_4 = 0
			local var_826_5 = 0.725

			if 0 < arg_823_1.time_ and arg_823_1.time_ <= var_826_4 + arg_826_0 then
				arg_823_1.talkMaxDuration = 0
				arg_823_1.dialogCg_.alpha = 1

				arg_823_1.dialog_:SetActive(true)
				SetActive(arg_823_1.leftNameGo_, false)

				arg_823_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_823_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_823_1:RecordName(arg_823_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_823_1.iconTrs_.gameObject, false)
				arg_823_1.callingController_:SetSelectedState("normal")

				local var_826_6 = arg_823_1:FormatText(arg_823_1:GetWordFromCfg(924041196).content)

				arg_823_1.text_.text = var_826_6

				LuaForUtil.ClearLinePrefixSymbol(arg_823_1.text_)

				local var_826_8 = 29 <= 0 and var_826_5 or var_826_5 * (utf8.len(var_826_6) / 29)

				if (29 <= 0 and var_826_5 or var_826_5 * (utf8.len(var_826_6) / 29)) > 0 and var_826_5 < var_826_8 then
					arg_823_1.talkMaxDuration = var_826_8

					if var_826_8 + var_826_4 > arg_823_1.duration_ then
						arg_823_1.duration_ = var_826_8 + var_826_4
					end
				end

				arg_823_1.text_.text = var_826_6
				arg_823_1.typewritter.percent = 0

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(false)
				arg_823_1:RecordContent(arg_823_1.text_.text)
			end

			local var_826_9 = math.max(var_826_5, arg_823_1.talkMaxDuration)

			if var_826_4 <= arg_823_1.time_ and arg_823_1.time_ < var_826_4 + var_826_9 then
				arg_823_1.typewritter.percent = (arg_823_1.time_ - var_826_4) / var_826_9

				arg_823_1.typewritter:SetDirty()
			end

			if arg_823_1.time_ >= var_826_4 + var_826_9 and arg_823_1.time_ < var_826_4 + var_826_9 + arg_826_0 then
				arg_823_1.typewritter.percent = 1

				arg_823_1.typewritter:SetDirty()
				arg_823_1:ShowNextGo(true)
			end
		end

		arg_823_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_823_1:InitPlayNodeList()
	end,
	Play924041197 = function(arg_827_0, arg_827_1)
		arg_827_1.time_ = 0
		arg_827_1.frameCnt_ = 0
		arg_827_1.state_ = "playing"
		arg_827_1.curTalkId_ = 924041197
		arg_827_1.duration_ = 5

		SetActive(arg_827_1.tipsGo_, false)

		function arg_827_1.onSingleLineFinish_()
			arg_827_1.onSingleLineUpdate_ = nil
			arg_827_1.onSingleLineFinish_ = nil
			arg_827_1.state_ = "waiting"
		end

		function arg_827_1.playNext_(arg_829_0)
			if arg_829_0 == 1 then
				arg_827_0:Play924041198(arg_827_1)
			end
		end

		function arg_827_1.onSingleLineUpdate_(arg_830_0)
			local var_830_0 = 0.4

			if 0 < arg_827_1.time_ and arg_827_1.time_ <= 0 + arg_830_0 then
				arg_827_1.talkMaxDuration = 0
				arg_827_1.dialogCg_.alpha = 1

				arg_827_1.dialog_:SetActive(true)
				SetActive(arg_827_1.leftNameGo_, true)

				arg_827_1.leftNameTxt_.text = arg_827_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_827_1.leftNameTxt_.transform)

				arg_827_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_827_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_827_1:RecordName(arg_827_1.leftNameTxt_.text)
				SetActive(arg_827_1.iconTrs_.gameObject, true)
				arg_827_1.iconController_:SetSelectedState("hero")

				arg_827_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_827_1.callingController_:SetSelectedState("normal")

				arg_827_1.keyicon_.color = Color.New(1, 1, 1)
				arg_827_1.icon_.color = Color.New(1, 1, 1)

				local var_830_1 = arg_827_1:FormatText(arg_827_1:GetWordFromCfg(924041197).content)

				arg_827_1.text_.text = var_830_1

				LuaForUtil.ClearLinePrefixSymbol(arg_827_1.text_)

				local var_830_3 = 16 <= 0 and var_830_0 or var_830_0 * (utf8.len(var_830_1) / 16)

				if (16 <= 0 and var_830_0 or var_830_0 * (utf8.len(var_830_1) / 16)) > 0 and var_830_0 < var_830_3 then
					arg_827_1.talkMaxDuration = var_830_3

					if var_830_3 + 0 > arg_827_1.duration_ then
						arg_827_1.duration_ = var_830_3 + 0
					end
				end

				arg_827_1.text_.text = var_830_1
				arg_827_1.typewritter.percent = 0

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(false)
				arg_827_1:RecordContent(arg_827_1.text_.text)
			end

			local var_830_4 = math.max(var_830_0, arg_827_1.talkMaxDuration)

			if 0 <= arg_827_1.time_ and arg_827_1.time_ < 0 + var_830_4 then
				arg_827_1.typewritter.percent = (arg_827_1.time_ - 0) / var_830_4

				arg_827_1.typewritter:SetDirty()
			end

			if arg_827_1.time_ >= 0 + var_830_4 and arg_827_1.time_ < 0 + var_830_4 + arg_830_0 then
				arg_827_1.typewritter.percent = 1

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(true)
			end
		end

		arg_827_1.nodeConfigList_ = {}

		arg_827_1:InitPlayNodeList()
	end,
	Play924041198 = function(arg_831_0, arg_831_1)
		arg_831_1.time_ = 0
		arg_831_1.frameCnt_ = 0
		arg_831_1.state_ = "playing"
		arg_831_1.curTalkId_ = 924041198
		arg_831_1.duration_ = 5.4

		local var_831_0 = {
			zh = 5.4,
			ja = 4.5
		}
		local var_831_1 = manager.audio:GetLocalizationFlag()

		if var_831_0[var_831_1] ~= nil then
			arg_831_1.duration_ = var_831_0[var_831_1]
		end

		SetActive(arg_831_1.tipsGo_, false)

		function arg_831_1.onSingleLineFinish_()
			arg_831_1.onSingleLineUpdate_ = nil
			arg_831_1.onSingleLineFinish_ = nil
			arg_831_1.state_ = "waiting"
		end

		function arg_831_1.playNext_(arg_833_0)
			if arg_833_0 == 1 then
				arg_831_0:Play924041199(arg_831_1)
			end
		end

		function arg_831_1.onSingleLineUpdate_(arg_834_0)
			if 0 < arg_831_1.time_ and arg_831_1.time_ <= 0 + arg_834_0 then
				arg_831_1.var_.moveOldPos102003ui_story = arg_831_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_834_0 = 0.001

			if 0 <= arg_831_1.time_ and arg_831_1.time_ < 0 + var_834_0 then
				arg_831_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_831_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_831_1.time_ - 0) / var_834_0)
				arg_831_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_831_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_831_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_831_1.actors_["102003ui_story"].transform.position).z)
				arg_831_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_831_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_831_1.actors_["102003ui_story"].transform.localEulerAngles = arg_831_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_831_1.time_ >= 0 + var_834_0 and arg_831_1.time_ < 0 + var_834_0 + arg_834_0 then
				arg_831_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_831_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_831_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_831_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_831_1.actors_["102003ui_story"].transform.position).z)
				arg_831_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_831_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_831_1.actors_["102003ui_story"].transform.localEulerAngles = arg_831_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_834_1 = arg_831_1.actors_["102003ui_story"]

			if 0 < arg_831_1.time_ and arg_831_1.time_ <= 0 + arg_834_0 and not isNil(var_834_1) and arg_831_1.var_.characterEffect102003ui_story == nil then
				arg_831_1.var_.characterEffect102003ui_story = var_834_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_834_2 = 0.200000002980232

			if 0 <= arg_831_1.time_ and arg_831_1.time_ < 0 + var_834_2 and not isNil(var_834_1) then
				if arg_831_1.var_.characterEffect102003ui_story and not isNil(var_834_1) then
					arg_831_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_831_1.time_ >= 0 + var_834_2 and arg_831_1.time_ < 0 + var_834_2 + arg_834_0 and not isNil(var_834_1) and arg_831_1.var_.characterEffect102003ui_story then
				arg_831_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_831_1.time_ and arg_831_1.time_ <= 0 + arg_834_0 then
				arg_831_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003action/102003action3_1")
			end

			if 0 < arg_831_1.time_ and arg_831_1.time_ <= 0 + arg_834_0 then
				arg_831_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_834_4 = 0
			local var_834_5 = 0.475

			if 0 < arg_831_1.time_ and arg_831_1.time_ <= var_834_4 + arg_834_0 then
				arg_831_1.talkMaxDuration = 0
				arg_831_1.dialogCg_.alpha = 1

				arg_831_1.dialog_:SetActive(true)
				SetActive(arg_831_1.leftNameGo_, true)

				arg_831_1.leftNameTxt_.text = arg_831_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_831_1.leftNameTxt_.transform)

				arg_831_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_831_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_831_1:RecordName(arg_831_1.leftNameTxt_.text)
				SetActive(arg_831_1.iconTrs_.gameObject, false)
				arg_831_1.callingController_:SetSelectedState("normal")

				local var_834_6 = arg_831_1:GetWordFromCfg(924041198)
				local var_834_7 = arg_831_1:FormatText(var_834_6.content)

				arg_831_1.text_.text = var_834_7

				LuaForUtil.ClearLinePrefixSymbol(arg_831_1.text_)

				local var_834_9 = 19 <= 0 and var_834_5 or var_834_5 * (utf8.len(var_834_7) / 19)

				if (19 <= 0 and var_834_5 or var_834_5 * (utf8.len(var_834_7) / 19)) > 0 and var_834_5 < var_834_9 then
					arg_831_1.talkMaxDuration = var_834_9

					if var_834_9 + var_834_4 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_9 + var_834_4
					end
				end

				arg_831_1.text_.text = var_834_7
				arg_831_1.typewritter.percent = 0

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb") ~= 0 then
					local var_834_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb") / 1000

					if var_834_10 + var_834_4 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_10 + var_834_4
					end

					if var_834_6.prefab_name ~= "" and arg_831_1.actors_[var_834_6.prefab_name] ~= nil then
						local var_834_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_831_1.actors_[var_834_6.prefab_name].transform, "story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb")

						arg_831_1:RecordAudio("924041198", var_834_11)
						arg_831_1:RecordAudio("924041198", var_834_11)
					else
						arg_831_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb")
					end

					arg_831_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041198", "story_v_side_old_924041.awb")
				end

				arg_831_1:RecordContent(arg_831_1.text_.text)
			end

			local var_834_12 = math.max(var_834_5, arg_831_1.talkMaxDuration)

			if var_834_4 <= arg_831_1.time_ and arg_831_1.time_ < var_834_4 + var_834_12 then
				arg_831_1.typewritter.percent = (arg_831_1.time_ - var_834_4) / var_834_12

				arg_831_1.typewritter:SetDirty()
			end

			if arg_831_1.time_ >= var_834_4 + var_834_12 and arg_831_1.time_ < var_834_4 + var_834_12 + arg_834_0 then
				arg_831_1.typewritter.percent = 1

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(true)
			end
		end

		arg_831_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_831_1:InitPlayNodeList()
	end,
	Play924041199 = function(arg_835_0, arg_835_1)
		arg_835_1.time_ = 0
		arg_835_1.frameCnt_ = 0
		arg_835_1.state_ = "playing"
		arg_835_1.curTalkId_ = 924041199
		arg_835_1.duration_ = 5

		SetActive(arg_835_1.tipsGo_, false)

		function arg_835_1.onSingleLineFinish_()
			arg_835_1.onSingleLineUpdate_ = nil
			arg_835_1.onSingleLineFinish_ = nil
			arg_835_1.state_ = "waiting"
		end

		function arg_835_1.playNext_(arg_837_0)
			if arg_837_0 == 1 then
				arg_835_0:Play924041200(arg_835_1)
			end
		end

		function arg_835_1.onSingleLineUpdate_(arg_838_0)
			if 0 < arg_835_1.time_ and arg_835_1.time_ <= 0 + arg_838_0 and not isNil(arg_835_1.actors_["102003ui_story"]) and arg_835_1.var_.characterEffect102003ui_story == nil then
				arg_835_1.var_.characterEffect102003ui_story = arg_835_1.actors_["102003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_838_0 = 0.200000002980232

			if 0 <= arg_835_1.time_ and arg_835_1.time_ < 0 + var_838_0 and not isNil(arg_835_1.actors_["102003ui_story"]) then
				if arg_835_1.var_.characterEffect102003ui_story and not isNil(arg_835_1.actors_["102003ui_story"]) then
					arg_835_1.var_.characterEffect102003ui_story.fillFlat = true
					arg_835_1.var_.characterEffect102003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_835_1.time_ - 0) / var_838_0)
				end
			end

			if arg_835_1.time_ >= 0 + var_838_0 and arg_835_1.time_ < 0 + var_838_0 + arg_838_0 and not isNil(arg_835_1.actors_["102003ui_story"]) and arg_835_1.var_.characterEffect102003ui_story then
				arg_835_1.var_.characterEffect102003ui_story.fillFlat = true
				arg_835_1.var_.characterEffect102003ui_story.fillRatio = 0.5
			end

			local var_838_1 = 0
			local var_838_2 = 0.425

			if 0 < arg_835_1.time_ and arg_835_1.time_ <= var_838_1 + arg_838_0 then
				arg_835_1.talkMaxDuration = 0
				arg_835_1.dialogCg_.alpha = 1

				arg_835_1.dialog_:SetActive(true)
				SetActive(arg_835_1.leftNameGo_, true)

				arg_835_1.leftNameTxt_.text = arg_835_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_835_1.leftNameTxt_.transform)

				arg_835_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_835_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_835_1:RecordName(arg_835_1.leftNameTxt_.text)
				SetActive(arg_835_1.iconTrs_.gameObject, true)
				arg_835_1.iconController_:SetSelectedState("hero")

				arg_835_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_835_1.callingController_:SetSelectedState("normal")

				arg_835_1.keyicon_.color = Color.New(1, 1, 1)
				arg_835_1.icon_.color = Color.New(1, 1, 1)

				local var_838_3 = arg_835_1:FormatText(arg_835_1:GetWordFromCfg(924041199).content)

				arg_835_1.text_.text = var_838_3

				LuaForUtil.ClearLinePrefixSymbol(arg_835_1.text_)

				local var_838_5 = 17 <= 0 and var_838_2 or var_838_2 * (utf8.len(var_838_3) / 17)

				if (17 <= 0 and var_838_2 or var_838_2 * (utf8.len(var_838_3) / 17)) > 0 and var_838_2 < var_838_5 then
					arg_835_1.talkMaxDuration = var_838_5

					if var_838_5 + var_838_1 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_5 + var_838_1
					end
				end

				arg_835_1.text_.text = var_838_3
				arg_835_1.typewritter.percent = 0

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(false)
				arg_835_1:RecordContent(arg_835_1.text_.text)
			end

			local var_838_6 = math.max(var_838_2, arg_835_1.talkMaxDuration)

			if var_838_1 <= arg_835_1.time_ and arg_835_1.time_ < var_838_1 + var_838_6 then
				arg_835_1.typewritter.percent = (arg_835_1.time_ - var_838_1) / var_838_6

				arg_835_1.typewritter:SetDirty()
			end

			if arg_835_1.time_ >= var_838_1 + var_838_6 and arg_835_1.time_ < var_838_1 + var_838_6 + arg_838_0 then
				arg_835_1.typewritter.percent = 1

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(true)
			end
		end

		arg_835_1.nodeConfigList_ = {}

		arg_835_1:InitPlayNodeList()
	end,
	Play924041200 = function(arg_839_0, arg_839_1)
		arg_839_1.time_ = 0
		arg_839_1.frameCnt_ = 0
		arg_839_1.state_ = "playing"
		arg_839_1.curTalkId_ = 924041200
		arg_839_1.duration_ = 8.7

		local var_839_0 = {
			zh = 6.933,
			ja = 8.7
		}
		local var_839_1 = manager.audio:GetLocalizationFlag()

		if var_839_0[var_839_1] ~= nil then
			arg_839_1.duration_ = var_839_0[var_839_1]
		end

		SetActive(arg_839_1.tipsGo_, false)

		function arg_839_1.onSingleLineFinish_()
			arg_839_1.onSingleLineUpdate_ = nil
			arg_839_1.onSingleLineFinish_ = nil
			arg_839_1.state_ = "waiting"
			arg_839_1.auto_ = false
		end

		function arg_839_1.playNext_(arg_841_0)
			arg_839_1.onStoryFinished_()
		end

		function arg_839_1.onSingleLineUpdate_(arg_842_0)
			if 0 < arg_839_1.time_ and arg_839_1.time_ <= 0 + arg_842_0 then
				arg_839_1.var_.moveOldPos102003ui_story = arg_839_1.actors_["102003ui_story"].transform.localPosition
			end

			local var_842_0 = 0.001

			if 0 <= arg_839_1.time_ and arg_839_1.time_ < 0 + var_842_0 then
				arg_839_1.actors_["102003ui_story"].transform.localPosition = Vector3.Lerp(arg_839_1.var_.moveOldPos102003ui_story, Vector3.New(0, -0.85, -6.21), (arg_839_1.time_ - 0) / var_842_0)
				arg_839_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_839_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_839_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_839_1.actors_["102003ui_story"].transform.position).z)
				arg_839_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_839_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_839_1.actors_["102003ui_story"].transform.localEulerAngles = arg_839_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			if arg_839_1.time_ >= 0 + var_842_0 and arg_839_1.time_ < 0 + var_842_0 + arg_842_0 then
				arg_839_1.actors_["102003ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.21)
				arg_839_1.actors_["102003ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_839_1.actors_["102003ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_839_1.actors_["102003ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_839_1.actors_["102003ui_story"].transform.position).z)
				arg_839_1.actors_["102003ui_story"].transform.localEulerAngles.z = 0
				arg_839_1.actors_["102003ui_story"].transform.localEulerAngles.x = 0
				arg_839_1.actors_["102003ui_story"].transform.localEulerAngles = arg_839_1.actors_["102003ui_story"].transform.localEulerAngles
			end

			local var_842_1 = arg_839_1.actors_["102003ui_story"]

			if 0 < arg_839_1.time_ and arg_839_1.time_ <= 0 + arg_842_0 and not isNil(var_842_1) and arg_839_1.var_.characterEffect102003ui_story == nil then
				arg_839_1.var_.characterEffect102003ui_story = var_842_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_842_2 = 0.200000002980232

			if 0 <= arg_839_1.time_ and arg_839_1.time_ < 0 + var_842_2 and not isNil(var_842_1) then
				if arg_839_1.var_.characterEffect102003ui_story and not isNil(var_842_1) then
					arg_839_1.var_.characterEffect102003ui_story.fillFlat = false
				end
			end

			if arg_839_1.time_ >= 0 + var_842_2 and arg_839_1.time_ < 0 + var_842_2 + arg_842_0 and not isNil(var_842_1) and arg_839_1.var_.characterEffect102003ui_story then
				arg_839_1.var_.characterEffect102003ui_story.fillFlat = false
			end

			if 0 < arg_839_1.time_ and arg_839_1.time_ <= 0 + arg_842_0 then
				arg_839_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/story102003/story102003actionlink/102003action439")
			end

			if 0 < arg_839_1.time_ and arg_839_1.time_ <= 0 + arg_842_0 then
				arg_839_1:PlayTimeline("102003ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_842_4 = 0
			local var_842_5 = 0.55

			if 0 < arg_839_1.time_ and arg_839_1.time_ <= var_842_4 + arg_842_0 then
				arg_839_1.talkMaxDuration = 0
				arg_839_1.dialogCg_.alpha = 1

				arg_839_1.dialog_:SetActive(true)
				SetActive(arg_839_1.leftNameGo_, true)

				arg_839_1.leftNameTxt_.text = arg_839_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_839_1.leftNameTxt_.transform)

				arg_839_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_839_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_839_1:RecordName(arg_839_1.leftNameTxt_.text)
				SetActive(arg_839_1.iconTrs_.gameObject, false)
				arg_839_1.callingController_:SetSelectedState("normal")

				local var_842_6 = arg_839_1:GetWordFromCfg(924041200)
				local var_842_7 = arg_839_1:FormatText(var_842_6.content)

				arg_839_1.text_.text = var_842_7

				LuaForUtil.ClearLinePrefixSymbol(arg_839_1.text_)

				local var_842_9 = 22 <= 0 and var_842_5 or var_842_5 * (utf8.len(var_842_7) / 22)

				if (22 <= 0 and var_842_5 or var_842_5 * (utf8.len(var_842_7) / 22)) > 0 and var_842_5 < var_842_9 then
					arg_839_1.talkMaxDuration = var_842_9

					if var_842_9 + var_842_4 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_9 + var_842_4
					end
				end

				arg_839_1.text_.text = var_842_7
				arg_839_1.typewritter.percent = 0

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb") ~= 0 then
					local var_842_10 = manager.audio:GetVoiceLength("story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb") / 1000

					if var_842_10 + var_842_4 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_10 + var_842_4
					end

					if var_842_6.prefab_name ~= "" and arg_839_1.actors_[var_842_6.prefab_name] ~= nil then
						local var_842_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_839_1.actors_[var_842_6.prefab_name].transform, "story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb")

						arg_839_1:RecordAudio("924041200", var_842_11)
						arg_839_1:RecordAudio("924041200", var_842_11)
					else
						arg_839_1:AudioAction("play", "voice", "story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb")
					end

					arg_839_1:RecordHistoryTalkVoice("story_v_side_old_924041", "924041200", "story_v_side_old_924041.awb")
				end

				arg_839_1:RecordContent(arg_839_1.text_.text)
			end

			local var_842_12 = math.max(var_842_5, arg_839_1.talkMaxDuration)

			if var_842_4 <= arg_839_1.time_ and arg_839_1.time_ < var_842_4 + var_842_12 then
				arg_839_1.typewritter.percent = (arg_839_1.time_ - var_842_4) / var_842_12

				arg_839_1.typewritter:SetDirty()
			end

			if arg_839_1.time_ >= var_842_4 + var_842_12 and arg_839_1.time_ < var_842_4 + var_842_12 + arg_842_0 then
				arg_839_1.typewritter.percent = 1

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(true)
			end
		end

		arg_839_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "102003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_839_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/X204_g",
		"TextureConfig/Background/ST0107",
		"TextureConfig/Background/SP92401",
		"TextureConfig/Background/SP92401b",
		"TextureConfig/Background/X204_f",
		"TextureConfig/Background/X204_h"
	},
	voices = {
		"story_v_side_old_924041.awb"
	}
}
