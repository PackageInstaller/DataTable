return {
	Play116241001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116241001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116241002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I06 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I06")
				var_4_0.name = "I06"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I06 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I06

				arg_1_1.bgs_.I06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I06" then
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
				local var_4_6 = Color.New(1, 1, 1)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(1, 1, 1)

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

			if 0.266666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.266666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_park_theme", "bgm_activity_1_6_park_theme", "bgm_activity_1_6_park_theme.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_6_park_theme", "bgm_activity_1_6_park_theme")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 1.999999999999
			local var_4_15 = 0.575

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116241001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 23 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 23)

				if (23 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 23)) > 0 and var_4_15 < var_4_19 then
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
	Play116241002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 116241002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play116241003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.925

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(116241002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 38 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 38)

				if (38 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 38)) > 0 and var_12_0 < var_12_3 then
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
	Play116241003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 116241003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play116241004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.625

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(116241003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 25 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 25)

				if (25 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 25)) > 0 and var_16_0 < var_16_3 then
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
	Play116241004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 116241004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play116241005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.425

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(116241004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 17 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 17)

				if (17 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 17)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play116241005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 116241005
		arg_21_1.duration_ = 7.1

		local var_21_0 = {
			zh = 6.866,
			ja = 7.1
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
				arg_21_0:Play116241006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1111ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1111ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1111ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1111ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1111ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1111ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1111ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_24_5 = arg_21_1.actors_["1111ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1111ui_story == nil then
				arg_21_1.var_.characterEffect1111ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1111ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1111ui_story then
				arg_21_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_24_8 = 0
			local var_24_9 = 0.95

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(116241005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 38 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 38)

				if (38 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 38)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116241", "116241005", "story_v_out_116241.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_116241", "116241005", "story_v_out_116241.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_116241", "116241005", "story_v_out_116241.awb")

						arg_21_1:RecordAudio("116241005", var_24_15)
						arg_21_1:RecordAudio("116241005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_116241", "116241005", "story_v_out_116241.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_116241", "116241005", "story_v_out_116241.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play116241006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 116241006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play116241007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1111ui_story = arg_25_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1111ui_story"].transform.position).z)
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1111ui_story"].transform.localEulerAngles = arg_25_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_28_1 = 0
			local var_28_2 = 0.6

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(116241006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 24 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 24)

				if (24 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 24)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play116241007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 116241007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play116241008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.875

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

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(116241007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 35 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 35)

				if (35 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 35)) > 0 and var_32_0 < var_32_3 then
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
	Play116241008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 116241008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play116241009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.3

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(116241008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 12 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 12)

				if (12 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 12)) > 0 and var_36_0 < var_36_3 then
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
	Play116241009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 116241009
		arg_37_1.duration_ = 9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play116241010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.I06c == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I06c")
				var_40_0.name = "I06c"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.I06c = var_40_0
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.I06c

				arg_37_1.bgs_.I06c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "I06c" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_5 = 2

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_5 then
				local var_40_6 = Color.New(0, 0, 0)

				var_40_6.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_4) / var_40_5)
				arg_37_1.mask_.color = var_40_6
			end

			if arg_37_1.time_ >= var_40_4 + var_40_5 and arg_37_1.time_ < var_40_4 + var_40_5 + arg_40_0 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = 1
				arg_37_1.mask_.color = var_40_7
			end

			local var_40_8 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_9 = 2

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 then
				local var_40_10 = Color.New(0, 0, 0)

				var_40_10.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_8) / var_40_9)
				arg_37_1.mask_.color = var_40_10
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 then
				local var_40_11 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_11.a = 0
				arg_37_1.mask_.color = var_40_11
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_12 = 4
			local var_40_13 = 0.625

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_14 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_14:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(116241009).content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 25 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 25)

				if (25 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 25)) > 0 and var_40_13 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17
					var_40_12 = var_40_12 + 0.3

					if var_40_17 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = var_40_12 + 0.3
			local var_40_19 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_18 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_18) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_18 + var_40_19 and arg_37_1.time_ < var_40_18 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play116241010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 116241010
		arg_43_1.duration_ = 3.73

		local var_43_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
				arg_43_0:Play116241011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1111ui_story = arg_43_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1111ui_story"].transform.position).z)
				arg_43_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1111ui_story"].transform.localEulerAngles = arg_43_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_43_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1111ui_story"].transform.position).z)
				arg_43_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1111ui_story"].transform.localEulerAngles = arg_43_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_46_1 = arg_43_1.actors_["1111ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1111ui_story == nil then
				arg_43_1.var_.characterEffect1111ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1111ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1111ui_story then
				arg_43_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_46_4 = 0
			local var_46_5 = 0.125

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(116241010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 5 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 5)

				if (5 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 5)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116241", "116241010", "story_v_out_116241.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_116241", "116241010", "story_v_out_116241.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_116241", "116241010", "story_v_out_116241.awb")

						arg_43_1:RecordAudio("116241010", var_46_11)
						arg_43_1:RecordAudio("116241010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_116241", "116241010", "story_v_out_116241.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_116241", "116241010", "story_v_out_116241.awb")
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
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play116241011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 116241011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play116241012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1111ui_story = arg_47_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1111ui_story"].transform.position).z)
				arg_47_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1111ui_story"].transform.localEulerAngles = arg_47_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1111ui_story"].transform.position).z)
				arg_47_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1111ui_story"].transform.localEulerAngles = arg_47_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_50_1 = 0
			local var_50_2 = 0.975

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(116241011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 39 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 39)

				if (39 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 39)) > 0 and var_50_2 < var_50_5 then
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

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play116241012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 116241012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play116241013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 1.15

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(116241012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 46 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 46)

				if (46 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 46)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play116241013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 116241013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play116241014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.675

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(116241013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 27 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 27)

				if (27 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 27)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play116241014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 116241014
		arg_59_1.duration_ = 1.87

		local var_59_0 = {
			zh = 1.7,
			ja = 1.866
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
				arg_59_0:Play116241015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[320].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:GetWordFromCfg(116241014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 11 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 11)

				if (11 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 11)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116241", "116241014", "story_v_out_116241.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_116241", "116241014", "story_v_out_116241.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_116241", "116241014", "story_v_out_116241.awb")

						arg_59_1:RecordAudio("116241014", var_62_6)
						arg_59_1:RecordAudio("116241014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_116241", "116241014", "story_v_out_116241.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_116241", "116241014", "story_v_out_116241.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play116241015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 116241015
		arg_63_1.duration_ = 6.6

		local var_63_0 = {
			zh = 3.366,
			ja = 6.6
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
				arg_63_0:Play116241016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.425

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[321].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(116241015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 19 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 19)

				if (19 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 19)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116241", "116241015", "story_v_out_116241.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_116241", "116241015", "story_v_out_116241.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_116241", "116241015", "story_v_out_116241.awb")

						arg_63_1:RecordAudio("116241015", var_66_6)
						arg_63_1:RecordAudio("116241015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_116241", "116241015", "story_v_out_116241.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_116241", "116241015", "story_v_out_116241.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play116241016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 116241016
		arg_67_1.duration_ = 4.4

		local var_67_0 = {
			zh = 4.4,
			ja = 3.033
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
				arg_67_0:Play116241017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_70_0 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_67_1.stage_.transform)

				var_70_0.name = "10025ui_story"
				var_70_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["10025ui_story"] = var_70_0

				local var_70_1 = var_70_0:GetComponentInChildren(typeof(CharacterEffect))

				var_70_1.enabled = true

				local var_70_2 = GameObjectTools.GetOrAddComponent(var_70_0, typeof(DynamicBoneHelper))

				if var_70_2 then
					var_70_2:EnableDynamicBone(false)
				end

				arg_67_1:ShowWeapon(var_70_1.transform, false)

				arg_67_1.var_["10025ui_story" .. "Animator"] = var_70_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_67_1.var_["10025ui_story" .. "Animator"].applyRootMotion = true
				arg_67_1.var_["10025ui_story" .. "LipSync"] = var_70_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_70_3 = arg_67_1.actors_["10025ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos10025ui_story = var_70_3.localPosition
			end

			local var_70_4 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_3.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10025ui_story, Vector3.New(-0.7, -1.1, -5.9), (arg_67_1.time_ - 0) / var_70_4)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_3.localPosition = Vector3.New(-0.7, -1.1, -5.9)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			local var_70_5 = arg_67_1.actors_["10025ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect10025ui_story == nil then
				arg_67_1.var_.characterEffect10025ui_story = var_70_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.characterEffect10025ui_story and not isNil(var_70_5) then
					arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect10025ui_story then
				arg_67_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action6_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_70_8 = 0
			local var_70_9 = 0.25

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
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

				local var_70_10 = arg_67_1:GetWordFromCfg(116241016)
				local var_70_11 = arg_67_1:FormatText(var_70_10.content)

				arg_67_1.text_.text = var_70_11

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 10 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 10)

				if (10 <= 0 and var_70_9 or var_70_9 * (utf8.len(var_70_11) / 10)) > 0 and var_70_9 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_8
					end
				end

				arg_67_1.text_.text = var_70_11
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116241", "116241016", "story_v_out_116241.awb") ~= 0 then
					local var_70_14 = manager.audio:GetVoiceLength("story_v_out_116241", "116241016", "story_v_out_116241.awb") / 1000

					if var_70_14 + var_70_8 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_14 + var_70_8
					end

					if var_70_10.prefab_name ~= "" and arg_67_1.actors_[var_70_10.prefab_name] ~= nil then
						local var_70_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_10.prefab_name].transform, "story_v_out_116241", "116241016", "story_v_out_116241.awb")

						arg_67_1:RecordAudio("116241016", var_70_15)
						arg_67_1:RecordAudio("116241016", var_70_15)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_116241", "116241016", "story_v_out_116241.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_116241", "116241016", "story_v_out_116241.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_9, arg_67_1.talkMaxDuration)

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_8) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_8 + var_70_16 and arg_67_1.time_ < var_70_8 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play116241017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 116241017
		arg_71_1.duration_ = 6.83

		local var_71_0 = {
			zh = 3.8,
			ja = 6.833
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
				arg_71_0:Play116241018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_74_0 = arg_71_1.actors_["1111ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1111ui_story == nil then
				arg_71_1.var_.characterEffect1111ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_1 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 and not isNil(var_74_0) then
				if arg_71_1.var_.characterEffect1111ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1111ui_story then
				arg_71_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_74_3 = arg_71_1.actors_["10025ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect10025ui_story == nil then
				arg_71_1.var_.characterEffect10025ui_story = var_74_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_4 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 and not isNil(var_74_3) then
				if arg_71_1.var_.characterEffect10025ui_story and not isNil(var_74_3) then
					arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_71_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_4)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 and not isNil(var_74_3) and arg_71_1.var_.characterEffect10025ui_story then
				arg_71_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_71_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_74_5 = arg_71_1.actors_["1111ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1111ui_story = var_74_5.localPosition
			end

			local var_74_6 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 then
				var_74_5.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_71_1.time_ - 0) / var_74_6)
				var_74_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_5.position).x, (manager.ui.mainCamera.transform.position - var_74_5.position).y, (manager.ui.mainCamera.transform.position - var_74_5.position).z)
				var_74_5.localEulerAngles.z = 0
				var_74_5.localEulerAngles.x = 0
				var_74_5.localEulerAngles = var_74_5.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 then
				var_74_5.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_74_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_5.position).x, (manager.ui.mainCamera.transform.position - var_74_5.position).y, (manager.ui.mainCamera.transform.position - var_74_5.position).z)
				var_74_5.localEulerAngles.z = 0
				var_74_5.localEulerAngles.x = 0
				var_74_5.localEulerAngles = var_74_5.localEulerAngles
			end

			local var_74_7 = 0
			local var_74_8 = 0.525

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_9 = arg_71_1:GetWordFromCfg(116241017)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_12 = 21 <= 0 and var_74_8 or var_74_8 * (utf8.len(var_74_10) / 21)

				if (21 <= 0 and var_74_8 or var_74_8 * (utf8.len(var_74_10) / 21)) > 0 and var_74_8 < var_74_12 then
					arg_71_1.talkMaxDuration = var_74_12

					if var_74_12 + var_74_7 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_7
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116241", "116241017", "story_v_out_116241.awb") ~= 0 then
					local var_74_13 = manager.audio:GetVoiceLength("story_v_out_116241", "116241017", "story_v_out_116241.awb") / 1000

					if var_74_13 + var_74_7 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_7
					end

					if var_74_9.prefab_name ~= "" and arg_71_1.actors_[var_74_9.prefab_name] ~= nil then
						local var_74_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_9.prefab_name].transform, "story_v_out_116241", "116241017", "story_v_out_116241.awb")

						arg_71_1:RecordAudio("116241017", var_74_14)
						arg_71_1:RecordAudio("116241017", var_74_14)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_116241", "116241017", "story_v_out_116241.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_116241", "116241017", "story_v_out_116241.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_15 = math.max(var_74_8, arg_71_1.talkMaxDuration)

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_15 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_7) / var_74_15

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_7 + var_74_15 and arg_71_1.time_ < var_74_7 + var_74_15 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play116241018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 116241018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play116241019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1111ui_story = arg_75_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).z)
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles = arg_75_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1111ui_story"].transform.position).z)
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1111ui_story"].transform.localEulerAngles = arg_75_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["10025ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10025ui_story = var_78_1.localPosition
			end

			local var_78_2 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 then
				var_78_1.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_2)
				var_78_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_1.position).x, (manager.ui.mainCamera.transform.position - var_78_1.position).y, (manager.ui.mainCamera.transform.position - var_78_1.position).z)
				var_78_1.localEulerAngles.z = 0
				var_78_1.localEulerAngles.x = 0
				var_78_1.localEulerAngles = var_78_1.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 then
				var_78_1.localPosition = Vector3.New(0, 100, 0)
				var_78_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_1.position).x, (manager.ui.mainCamera.transform.position - var_78_1.position).y, (manager.ui.mainCamera.transform.position - var_78_1.position).z)
				var_78_1.localEulerAngles.z = 0
				var_78_1.localEulerAngles.x = 0
				var_78_1.localEulerAngles = var_78_1.localEulerAngles
			end

			local var_78_3 = 0
			local var_78_4 = 0.35

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_5 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(116241018).content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 14 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_5) / 14)

				if (14 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_5) / 14)) > 0 and var_78_4 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_3
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_4, arg_75_1.talkMaxDuration)

			if var_78_3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_3 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_3) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_3 + var_78_8 and arg_75_1.time_ < var_78_3 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play116241019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 116241019
		arg_79_1.duration_ = 4.07

		local var_79_0 = {
			zh = 4.066,
			ja = 2.433
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
				arg_79_0:Play116241020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["10025ui_story"]) and arg_79_1.var_.characterEffect10025ui_story == nil then
				arg_79_1.var_.characterEffect10025ui_story = arg_79_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["10025ui_story"]) then
				if arg_79_1.var_.characterEffect10025ui_story and not isNil(arg_79_1.actors_["10025ui_story"]) then
					arg_79_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["10025ui_story"]) and arg_79_1.var_.characterEffect10025ui_story then
				arg_79_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_82_2 = arg_79_1.actors_["10025ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10025ui_story = var_82_2.localPosition
			end

			local var_82_3 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_79_1.time_ - 0) / var_82_3)
				var_82_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_2.position).x, (manager.ui.mainCamera.transform.position - var_82_2.position).y, (manager.ui.mainCamera.transform.position - var_82_2.position).z)
				var_82_2.localEulerAngles.z = 0
				var_82_2.localEulerAngles.x = 0
				var_82_2.localEulerAngles = var_82_2.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(0, -1.1, -5.9)
				var_82_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_2.position).x, (manager.ui.mainCamera.transform.position - var_82_2.position).y, (manager.ui.mainCamera.transform.position - var_82_2.position).z)
				var_82_2.localEulerAngles.z = 0
				var_82_2.localEulerAngles.x = 0
				var_82_2.localEulerAngles = var_82_2.localEulerAngles
			end

			local var_82_4 = 0
			local var_82_5 = 0.35

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
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

				local var_82_6 = arg_79_1:GetWordFromCfg(116241019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 14 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 14)

				if (14 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 14)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116241", "116241019", "story_v_out_116241.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_116241", "116241019", "story_v_out_116241.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_116241", "116241019", "story_v_out_116241.awb")

						arg_79_1:RecordAudio("116241019", var_82_11)
						arg_79_1:RecordAudio("116241019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_116241", "116241019", "story_v_out_116241.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_116241", "116241019", "story_v_out_116241.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play116241020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 116241020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play116241021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) and arg_83_1.var_.characterEffect10025ui_story == nil then
				arg_83_1.var_.characterEffect10025ui_story = arg_83_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) then
				if arg_83_1.var_.characterEffect10025ui_story and not isNil(arg_83_1.actors_["10025ui_story"]) then
					arg_83_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["10025ui_story"]) and arg_83_1.var_.characterEffect10025ui_story then
				arg_83_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.15

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(116241020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 6 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 6)

				if (6 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 6)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play116241021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 116241021
		arg_87_1.duration_ = 4.3

		local var_87_0 = {
			zh = 4.3,
			ja = 3.366
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
			arg_87_1.auto_ = false
		end

		function arg_87_1.playNext_(arg_89_0)
			arg_87_1.onStoryFinished_()
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["10025ui_story"]) and arg_87_1.var_.characterEffect10025ui_story == nil then
				arg_87_1.var_.characterEffect10025ui_story = arg_87_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["10025ui_story"]) then
				if arg_87_1.var_.characterEffect10025ui_story and not isNil(arg_87_1.actors_["10025ui_story"]) then
					arg_87_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["10025ui_story"]) and arg_87_1.var_.characterEffect10025ui_story then
				arg_87_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action448")
			end

			local var_90_2 = 0
			local var_90_3 = 0.35

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_4 = arg_87_1:GetWordFromCfg(116241021)
				local var_90_5 = arg_87_1:FormatText(var_90_4.content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 14 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 14)

				if (14 <= 0 and var_90_3 or var_90_3 * (utf8.len(var_90_5) / 14)) > 0 and var_90_3 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_2
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116241", "116241021", "story_v_out_116241.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_116241", "116241021", "story_v_out_116241.awb") / 1000

					if var_90_8 + var_90_2 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_2
					end

					if var_90_4.prefab_name ~= "" and arg_87_1.actors_[var_90_4.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_4.prefab_name].transform, "story_v_out_116241", "116241021", "story_v_out_116241.awb")

						arg_87_1:RecordAudio("116241021", var_90_9)
						arg_87_1:RecordAudio("116241021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_116241", "116241021", "story_v_out_116241.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_116241", "116241021", "story_v_out_116241.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_3, arg_87_1.talkMaxDuration)

			if var_90_2 <= arg_87_1.time_ and arg_87_1.time_ < var_90_2 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_2) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_2 + var_90_10 and arg_87_1.time_ < var_90_2 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I06",
		"TextureConfig/Background/I06c"
	},
	voices = {
		"story_v_out_116241.awb"
	}
}
