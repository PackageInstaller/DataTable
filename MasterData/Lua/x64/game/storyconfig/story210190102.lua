return {
	Play101902001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 101902001
		arg_1_1.duration_ = 6.08

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play101902002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST02 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_4_0.name = "ST02"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST02 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST02

				arg_1_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 1.075

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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

			local var_4_14 = 1.075
			local var_4_15 = 1.075

			if 1.075 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(101902001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 43 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 43)

				if (43 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 43)) > 0 and var_4_15 < var_4_19 then
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
	Play101902002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 101902002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play101902003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.6

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(101902002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 64 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 64)

				if (64 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 64)) > 0 and var_12_0 < var_12_3 then
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
	Play101902003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 101902003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play101902004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(101902003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 7)

				if (7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 7)) > 0 and var_16_0 < var_16_3 then
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
	Play101902004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 101902004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play101902005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.75

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(101902004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 30 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 30)

				if (30 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 30)) > 0 and var_20_0 < var_20_3 then
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
	Play101902005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 101902005
		arg_21_1.duration_ = 6.17

		local var_21_0 = {
			ja = 6.166,
			ko = 4.666,
			en = 3.833
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
				arg_21_0:Play101902006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1019ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1019ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1019ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1019ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1019ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1019ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_24_5 = 0
			local var_24_6 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(101902005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 18 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 18)

				if (18 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 18)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902005", "story_v_side_old_101902.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902005", "story_v_side_old_101902.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_side_old_101902", "101902005", "story_v_side_old_101902.awb")

						arg_21_1:RecordAudio("101902005", var_24_12)
						arg_21_1:RecordAudio("101902005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902005", "story_v_side_old_101902.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902005", "story_v_side_old_101902.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_13 and arg_21_1.time_ < var_24_5 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play101902006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 101902006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play101902007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(101902006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 10 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 10)

				if (10 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 10)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play101902007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 101902007
		arg_29_1.duration_ = 9.33

		local var_29_0 = {
			ja = 8.633,
			ko = 5.833,
			en = 9.333
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play101902008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_32_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_29_1.stage_.transform)

				var_32_0.name = "1039ui_story"
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["1039ui_story"] = var_32_0

				local var_32_1 = var_32_0:GetComponentInChildren(typeof(CharacterEffect))

				var_32_1.enabled = true

				local var_32_2 = GameObjectTools.GetOrAddComponent(var_32_0, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(false)
				end

				arg_29_1:ShowWeapon(var_32_1.transform, false)

				arg_29_1.var_["1039ui_story" .. "Animator"] = var_32_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_29_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_29_1.var_["1039ui_story" .. "LipSync"] = var_32_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_32_3 = arg_29_1.actors_["1039ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1039ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0.7, -1.01, -5.9)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["1019ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1019ui_story = var_32_5.localPosition
			end

			local var_32_6 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_29_1.time_ - 0) / var_32_6)
				var_32_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_5.position).x, (manager.ui.mainCamera.transform.position - var_32_5.position).y, (manager.ui.mainCamera.transform.position - var_32_5.position).z)
				var_32_5.localEulerAngles.z = 0
				var_32_5.localEulerAngles.x = 0
				var_32_5.localEulerAngles = var_32_5.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_32_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_5.position).x, (manager.ui.mainCamera.transform.position - var_32_5.position).y, (manager.ui.mainCamera.transform.position - var_32_5.position).z)
				var_32_5.localEulerAngles.z = 0
				var_32_5.localEulerAngles.x = 0
				var_32_5.localEulerAngles = var_32_5.localEulerAngles
			end

			local var_32_7 = arg_29_1.actors_["1039ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1039ui_story == nil then
				arg_29_1.var_.characterEffect1039ui_story = var_32_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_8 and not isNil(var_32_7) then
				if arg_29_1.var_.characterEffect1039ui_story and not isNil(var_32_7) then
					arg_29_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_8 and arg_29_1.time_ < 0 + var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.characterEffect1039ui_story then
				arg_29_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_32_10 = arg_29_1.actors_["1019ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1019ui_story == nil then
				arg_29_1.var_.characterEffect1019ui_story = var_32_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_11 and not isNil(var_32_10) then
				if arg_29_1.var_.characterEffect1019ui_story and not isNil(var_32_10) then
					arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_11)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_11 and arg_29_1.time_ < 0 + var_32_11 + arg_32_0 and not isNil(var_32_10) and arg_29_1.var_.characterEffect1019ui_story then
				arg_29_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_32_12 = 0
			local var_32_13 = 0.95

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_14 = arg_29_1:GetWordFromCfg(101902007)
				local var_32_15 = arg_29_1:FormatText(var_32_14.content)

				arg_29_1.text_.text = var_32_15

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_17 = 38 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 38)

				if (38 <= 0 and var_32_13 or var_32_13 * (utf8.len(var_32_15) / 38)) > 0 and var_32_13 < var_32_17 then
					arg_29_1.talkMaxDuration = var_32_17

					if var_32_17 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_12
					end
				end

				arg_29_1.text_.text = var_32_15
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902007", "story_v_side_old_101902.awb") ~= 0 then
					local var_32_18 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902007", "story_v_side_old_101902.awb") / 1000

					if var_32_18 + var_32_12 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_12
					end

					if var_32_14.prefab_name ~= "" and arg_29_1.actors_[var_32_14.prefab_name] ~= nil then
						local var_32_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_14.prefab_name].transform, "story_v_side_old_101902", "101902007", "story_v_side_old_101902.awb")

						arg_29_1:RecordAudio("101902007", var_32_19)
						arg_29_1:RecordAudio("101902007", var_32_19)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902007", "story_v_side_old_101902.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902007", "story_v_side_old_101902.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_20 = math.max(var_32_13, arg_29_1.talkMaxDuration)

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_20 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_12) / var_32_20

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_12 + var_32_20 and arg_29_1.time_ < var_32_12 + var_32_20 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play101902008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 101902008
		arg_33_1.duration_ = 2.27

		local var_33_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			en = 1.999999999999
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
				arg_33_0:Play101902009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_36_0 = arg_33_1.actors_["1019ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1019ui_story == nil then
				arg_33_1.var_.characterEffect1019ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_1 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 and not isNil(var_36_0) then
				if arg_33_1.var_.characterEffect1019ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1019ui_story then
				arg_33_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_36_3 = arg_33_1.actors_["1039ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1039ui_story == nil then
				arg_33_1.var_.characterEffect1039ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.075

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect1039ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_4)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1039ui_story then
				arg_33_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_36_5 = 0
			local var_36_6 = 0.075

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(101902008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 3 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 3)

				if (3 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 3)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902008", "story_v_side_old_101902.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902008", "story_v_side_old_101902.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_side_old_101902", "101902008", "story_v_side_old_101902.awb")

						arg_33_1:RecordAudio("101902008", var_36_12)
						arg_33_1:RecordAudio("101902008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902008", "story_v_side_old_101902.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902008", "story_v_side_old_101902.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_13 and arg_33_1.time_ < var_36_5 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play101902009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 101902009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play101902010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1019ui_story"]) and arg_37_1.var_.characterEffect1019ui_story == nil then
				arg_37_1.var_.characterEffect1019ui_story = arg_37_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1019ui_story"]) then
				if arg_37_1.var_.characterEffect1019ui_story and not isNil(arg_37_1.actors_["1019ui_story"]) then
					arg_37_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1019ui_story"]) and arg_37_1.var_.characterEffect1019ui_story then
				arg_37_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_40_1 = arg_37_1.actors_["1039ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1039ui_story == nil then
				arg_37_1.var_.characterEffect1039ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1039ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1039ui_story then
				arg_37_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_40_3 = 0
			local var_40_4 = 0.575

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(101902009).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 23 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 23)

				if (23 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 23)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play101902010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 101902010
		arg_41_1.duration_ = 4.8

		local var_41_0 = {
			ja = 4.8,
			ko = 4,
			en = 4.466
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
				arg_41_0:Play101902011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) and arg_41_1.var_.characterEffect1019ui_story == nil then
				arg_41_1.var_.characterEffect1019ui_story = arg_41_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) then
				if arg_41_1.var_.characterEffect1019ui_story and not isNil(arg_41_1.actors_["1019ui_story"]) then
					arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1019ui_story"]) and arg_41_1.var_.characterEffect1019ui_story then
				arg_41_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_44_2 = 0
			local var_44_3 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(101902010)
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

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902010", "story_v_side_old_101902.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902010", "story_v_side_old_101902.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_old_101902", "101902010", "story_v_side_old_101902.awb")

						arg_41_1:RecordAudio("101902010", var_44_9)
						arg_41_1:RecordAudio("101902010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902010", "story_v_side_old_101902.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902010", "story_v_side_old_101902.awb")
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
	Play101902011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 101902011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play101902012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1019ui_story = arg_45_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1019ui_story"].transform.position).z)
				arg_45_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1019ui_story"].transform.localEulerAngles = arg_45_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1019ui_story"].transform.position).z)
				arg_45_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1019ui_story"].transform.localEulerAngles = arg_45_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1039ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1039ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(0, 100, 0)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = 0
			local var_48_4 = 0.625

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(101902011).content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 25 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 25)

				if (25 <= 0 and var_48_4 or var_48_4 * (utf8.len(var_48_5) / 25)) > 0 and var_48_4 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_3 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_3
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_4, arg_45_1.talkMaxDuration)

			if var_48_3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_3 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_3) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_3 + var_48_8 and arg_45_1.time_ < var_48_3 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play101902012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 101902012
		arg_49_1.duration_ = 8.9

		local var_49_0 = {
			ja = 8.9,
			ko = 6.333,
			en = 5.6
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
				arg_49_0:Play101902013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1039ui_story = arg_49_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).z)
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles = arg_49_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_49_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1039ui_story"].transform.position).z)
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1039ui_story"].transform.localEulerAngles = arg_49_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1039ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1039ui_story == nil then
				arg_49_1.var_.characterEffect1039ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1039ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1039ui_story then
				arg_49_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 1.94289029309402e-16 < arg_49_1.time_ and arg_49_1.time_ <= 1.94289029309402e-16 + arg_52_0 then
				arg_49_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			local var_52_4 = 0
			local var_52_5 = 0.8

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(101902012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 32 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 32)

				if (32 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 32)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902012", "story_v_side_old_101902.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902012", "story_v_side_old_101902.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_side_old_101902", "101902012", "story_v_side_old_101902.awb")

						arg_49_1:RecordAudio("101902012", var_52_11)
						arg_49_1:RecordAudio("101902012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902012", "story_v_side_old_101902.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902012", "story_v_side_old_101902.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play101902013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 101902013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play101902014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1039ui_story = arg_53_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1039ui_story"].transform.position).z)
				arg_53_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1039ui_story"].transform.localEulerAngles = arg_53_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1039ui_story"].transform.position).z)
				arg_53_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1039ui_story"].transform.localEulerAngles = arg_53_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_56_1 = 0
			local var_56_2 = 0.725

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

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(101902013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 29 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 29)

				if (29 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 29)) > 0 and var_56_2 < var_56_5 then
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

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play101902014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 101902014
		arg_57_1.duration_ = 12.9

		local var_57_0 = {
			ja = 12.9,
			ko = 9.233,
			en = 12
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
				arg_57_0:Play101902015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_2 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_2:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[232].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(101902014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 45 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_4) / 45)

				if (45 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_4) / 45)) > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6
					var_60_0 = var_60_0 + 0.3

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902014", "story_v_side_old_101902.awb") ~= 0 then
					local var_60_7 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902014", "story_v_side_old_101902.awb") / 1000

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_side_old_101902", "101902014", "story_v_side_old_101902.awb")

						arg_57_1:RecordAudio("101902014", var_60_8)
						arg_57_1:RecordAudio("101902014", var_60_8)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902014", "story_v_side_old_101902.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902014", "story_v_side_old_101902.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_9 = var_60_0 + 0.3
			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_9) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play101902015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 101902015
		arg_63_1.duration_ = 12.1

		local var_63_0 = {
			ja = 11.3,
			ko = 9.866,
			en = 12.1
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
				arg_63_0:Play101902016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.075

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[232].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(101902015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 43 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 43)

				if (43 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 43)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902015", "story_v_side_old_101902.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902015", "story_v_side_old_101902.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_side_old_101902", "101902015", "story_v_side_old_101902.awb")

						arg_63_1:RecordAudio("101902015", var_66_6)
						arg_63_1:RecordAudio("101902015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902015", "story_v_side_old_101902.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902015", "story_v_side_old_101902.awb")
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
	Play101902016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 101902016
		arg_67_1.duration_ = 18.1

		local var_67_0 = {
			ja = 14.8,
			ko = 11.2,
			en = 18.1
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
				arg_67_0:Play101902017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.425

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[232].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(101902016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 57 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 57)

				if (57 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 57)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902016", "story_v_side_old_101902.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902016", "story_v_side_old_101902.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_side_old_101902", "101902016", "story_v_side_old_101902.awb")

						arg_67_1:RecordAudio("101902016", var_70_6)
						arg_67_1:RecordAudio("101902016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902016", "story_v_side_old_101902.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902016", "story_v_side_old_101902.awb")
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
	Play101902017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 101902017
		arg_71_1.duration_ = 20.57

		local var_71_0 = {
			ja = 16,
			ko = 13.6,
			en = 20.566
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
				arg_71_0:Play101902018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.45

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[232].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(101902017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 58 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 58)

				if (58 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 58)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902017", "story_v_side_old_101902.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902017", "story_v_side_old_101902.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_side_old_101902", "101902017", "story_v_side_old_101902.awb")

						arg_71_1:RecordAudio("101902017", var_74_6)
						arg_71_1:RecordAudio("101902017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902017", "story_v_side_old_101902.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902017", "story_v_side_old_101902.awb")
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
	Play101902018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 101902018
		arg_75_1.duration_ = 2.2

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play101902019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.05

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_2 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_2:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[232].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_clerkb")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_3 = arg_75_1:GetWordFromCfg(101902018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 2 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_4) / 2)

				if (2 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_4) / 2)) > 0 and var_78_1 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6
					var_78_0 = var_78_0 + 0.3

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902018", "story_v_side_old_101902.awb") ~= 0 then
					local var_78_7 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902018", "story_v_side_old_101902.awb") / 1000

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_side_old_101902", "101902018", "story_v_side_old_101902.awb")

						arg_75_1:RecordAudio("101902018", var_78_8)
						arg_75_1:RecordAudio("101902018", var_78_8)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902018", "story_v_side_old_101902.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902018", "story_v_side_old_101902.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_9 = var_78_0 + 0.3
			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_9) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play101902019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 101902019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play101902020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.15

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(101902019).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 6 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 6)

				if (6 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 6)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play101902020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 101902020
		arg_85_1.duration_ = 17.73

		local var_85_0 = {
			ja = 14.7,
			ko = 13.3,
			en = 17.733
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
				arg_85_0:Play101902021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1019ui_story = arg_85_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1019ui_story"].transform.position).z)
				arg_85_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1019ui_story"].transform.localEulerAngles = arg_85_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_85_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1019ui_story"].transform.position).z)
				arg_85_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1019ui_story"].transform.localEulerAngles = arg_85_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1019ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1019ui_story == nil then
				arg_85_1.var_.characterEffect1019ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1019ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1019ui_story then
				arg_85_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 1.94289029309402e-16 < arg_85_1.time_ and arg_85_1.time_ <= 1.94289029309402e-16 + arg_88_0 then
				arg_85_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_88_4 = 0
			local var_88_5 = 1.45

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(101902020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 58 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 58)

				if (58 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 58)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902020", "story_v_side_old_101902.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902020", "story_v_side_old_101902.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_side_old_101902", "101902020", "story_v_side_old_101902.awb")

						arg_85_1:RecordAudio("101902020", var_88_11)
						arg_85_1:RecordAudio("101902020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902020", "story_v_side_old_101902.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902020", "story_v_side_old_101902.awb")
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

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play101902021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 101902021
		arg_89_1.duration_ = 3.83

		local var_89_0 = {
			ja = 2.633,
			ko = 3.833,
			en = 3.2
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
				arg_89_0:Play101902022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1019ui_story = arg_89_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1019ui_story"].transform.position).z)
				arg_89_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1019ui_story"].transform.localEulerAngles = arg_89_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_89_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1019ui_story"].transform.position).z)
				arg_89_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1019ui_story"].transform.localEulerAngles = arg_89_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1019ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1019ui_story == nil then
				arg_89_1.var_.characterEffect1019ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1019ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_2)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1019ui_story then
				arg_89_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_92_3 = arg_89_1.actors_["1039ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1039ui_story = var_92_3.localPosition
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_3.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_89_1.time_ - 0) / var_92_4)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_3.localPosition = Vector3.New(0.7, -1.01, -5.9)
				var_92_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_3.position).x, (manager.ui.mainCamera.transform.position - var_92_3.position).y, (manager.ui.mainCamera.transform.position - var_92_3.position).z)
				var_92_3.localEulerAngles.z = 0
				var_92_3.localEulerAngles.x = 0
				var_92_3.localEulerAngles = var_92_3.localEulerAngles
			end

			local var_92_5 = arg_89_1.actors_["1039ui_story"]

			if 1.94289029309402e-16 < arg_89_1.time_ and arg_89_1.time_ <= 1.94289029309402e-16 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect1039ui_story == nil then
				arg_89_1.var_.characterEffect1039ui_story = var_92_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_6 = 0.2

			if 1.94289029309402e-16 <= arg_89_1.time_ and arg_89_1.time_ < 1.94289029309402e-16 + var_92_6 and not isNil(var_92_5) then
				if arg_89_1.var_.characterEffect1039ui_story and not isNil(var_92_5) then
					arg_89_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 1.94289029309402e-16 + var_92_6 and arg_89_1.time_ < 1.94289029309402e-16 + var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect1039ui_story then
				arg_89_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 1.94289029309402e-16 < arg_89_1.time_ and arg_89_1.time_ <= 1.94289029309402e-16 + arg_92_0 then
				arg_89_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action7_1")
			end

			local var_92_8 = 0
			local var_92_9 = 0.2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(101902021)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 8 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 8)

				if (8 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 8)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902021", "story_v_side_old_101902.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902021", "story_v_side_old_101902.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_side_old_101902", "101902021", "story_v_side_old_101902.awb")

						arg_89_1:RecordAudio("101902021", var_92_15)
						arg_89_1:RecordAudio("101902021", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902021", "story_v_side_old_101902.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902021", "story_v_side_old_101902.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_9, arg_89_1.talkMaxDuration)

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_8) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_8 + var_92_16 and arg_89_1.time_ < var_92_8 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play101902022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 101902022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play101902023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1039ui_story"]) and arg_93_1.var_.characterEffect1039ui_story == nil then
				arg_93_1.var_.characterEffect1039ui_story = arg_93_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1039ui_story"]) then
				if arg_93_1.var_.characterEffect1039ui_story and not isNil(arg_93_1.actors_["1039ui_story"]) then
					arg_93_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1039ui_story"]) and arg_93_1.var_.characterEffect1039ui_story then
				arg_93_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.725

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(101902022).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 29 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 29)

				if (29 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 29)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play101902023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 101902023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play101902024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1039ui_story = arg_97_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1039ui_story"].transform.position).z)
				arg_97_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1039ui_story"].transform.localEulerAngles = arg_97_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1039ui_story"].transform.position).z)
				arg_97_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1039ui_story"].transform.localEulerAngles = arg_97_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1019ui_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1019ui_story = var_100_1.localPosition
			end

			local var_100_2 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 then
				var_100_1.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_2)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 then
				var_100_1.localPosition = Vector3.New(0, 100, 0)
				var_100_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_1.position).x, (manager.ui.mainCamera.transform.position - var_100_1.position).y, (manager.ui.mainCamera.transform.position - var_100_1.position).z)
				var_100_1.localEulerAngles.z = 0
				var_100_1.localEulerAngles.x = 0
				var_100_1.localEulerAngles = var_100_1.localEulerAngles
			end

			local var_100_3 = 0
			local var_100_4 = 0.475

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_3 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_5 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(101902023).content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 19 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_5) / 19)

				if (19 <= 0 and var_100_4 or var_100_4 * (utf8.len(var_100_5) / 19)) > 0 and var_100_4 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_3
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_4, arg_97_1.talkMaxDuration)

			if var_100_3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_3 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_3) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_3 + var_100_8 and arg_97_1.time_ < var_100_3 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play101902024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 101902024
		arg_101_1.duration_ = 18.93

		local var_101_0 = {
			ja = 18.933,
			ko = 13.266,
			en = 15.933
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
				arg_101_0:Play101902025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1019ui_story = arg_101_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).z)
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles = arg_101_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_101_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1019ui_story"].transform.position).z)
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1019ui_story"].transform.localEulerAngles = arg_101_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1019ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1019ui_story == nil then
				arg_101_1.var_.characterEffect1019ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1019ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1019ui_story then
				arg_101_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_104_4 = 0
			local var_104_5 = 1.425

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(101902024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 57 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 57)

				if (57 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 57)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902024", "story_v_side_old_101902.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902024", "story_v_side_old_101902.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_side_old_101902", "101902024", "story_v_side_old_101902.awb")

						arg_101_1:RecordAudio("101902024", var_104_11)
						arg_101_1:RecordAudio("101902024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902024", "story_v_side_old_101902.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902024", "story_v_side_old_101902.awb")
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

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play101902025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 101902025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play101902026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1019ui_story"]) and arg_105_1.var_.characterEffect1019ui_story == nil then
				arg_105_1.var_.characterEffect1019ui_story = arg_105_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1019ui_story"]) then
				if arg_105_1.var_.characterEffect1019ui_story and not isNil(arg_105_1.actors_["1019ui_story"]) then
					arg_105_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1019ui_story"]) and arg_105_1.var_.characterEffect1019ui_story then
				arg_105_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.55

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(101902025).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 22 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 22)

				if (22 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 22)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play101902026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 101902026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play101902027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1039ui_story"]) and arg_109_1.var_.characterEffect1039ui_story == nil then
				arg_109_1.var_.characterEffect1039ui_story = arg_109_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1039ui_story"]) then
				if arg_109_1.var_.characterEffect1039ui_story and not isNil(arg_109_1.actors_["1039ui_story"]) then
					arg_109_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1039ui_story"]) and arg_109_1.var_.characterEffect1039ui_story then
				arg_109_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.4

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(101902026).content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 16 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_4) / 16)

				if (16 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_4) / 16)) > 0 and var_112_3 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_7 and arg_109_1.time_ < var_112_2 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play101902027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 101902027
		arg_113_1.duration_ = 16.03

		local var_113_0 = {
			ja = 16.033,
			ko = 11.4,
			en = 11.633
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
				arg_113_0:Play101902028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) and arg_113_1.var_.characterEffect1019ui_story == nil then
				arg_113_1.var_.characterEffect1019ui_story = arg_113_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) then
				if arg_113_1.var_.characterEffect1019ui_story and not isNil(arg_113_1.actors_["1019ui_story"]) then
					arg_113_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1019ui_story"]) and arg_113_1.var_.characterEffect1019ui_story then
				arg_113_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_116_2 = 0
			local var_116_3 = 1.35

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_4 = arg_113_1:GetWordFromCfg(101902027)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 54 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 54)

				if (54 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 54)) > 0 and var_116_3 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902027", "story_v_side_old_101902.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902027", "story_v_side_old_101902.awb") / 1000

					if var_116_8 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_2
					end

					if var_116_4.prefab_name ~= "" and arg_113_1.actors_[var_116_4.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_4.prefab_name].transform, "story_v_side_old_101902", "101902027", "story_v_side_old_101902.awb")

						arg_113_1:RecordAudio("101902027", var_116_9)
						arg_113_1:RecordAudio("101902027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902027", "story_v_side_old_101902.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902027", "story_v_side_old_101902.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_10 and arg_113_1.time_ < var_116_2 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play101902028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 101902028
		arg_117_1.duration_ = 11.1

		local var_117_0 = {
			ja = 11.1,
			ko = 9.8,
			en = 11
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
				arg_117_0:Play101902029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) and arg_117_1.var_.characterEffect1019ui_story == nil then
				arg_117_1.var_.characterEffect1019ui_story = arg_117_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) then
				if arg_117_1.var_.characterEffect1019ui_story and not isNil(arg_117_1.actors_["1019ui_story"]) then
					arg_117_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1019ui_story"]) and arg_117_1.var_.characterEffect1019ui_story then
				arg_117_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_120_2 = 0
			local var_120_3 = 1.125

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(101902028)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 45 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 45)

				if (45 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 45)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902028", "story_v_side_old_101902.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902028", "story_v_side_old_101902.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_side_old_101902", "101902028", "story_v_side_old_101902.awb")

						arg_117_1:RecordAudio("101902028", var_120_9)
						arg_117_1:RecordAudio("101902028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902028", "story_v_side_old_101902.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902028", "story_v_side_old_101902.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play101902029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 101902029
		arg_121_1.duration_ = 10.7

		local var_121_0 = {
			ja = 10.7,
			ko = 7.633,
			en = 10.1
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
				arg_121_0:Play101902030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) and arg_121_1.var_.characterEffect1019ui_story == nil then
				arg_121_1.var_.characterEffect1019ui_story = arg_121_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) then
				if arg_121_1.var_.characterEffect1019ui_story and not isNil(arg_121_1.actors_["1019ui_story"]) then
					arg_121_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1019ui_story"]) and arg_121_1.var_.characterEffect1019ui_story then
				arg_121_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_124_2 = 0
			local var_124_3 = 0.975

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:GetWordFromCfg(101902029)
				local var_124_5 = arg_121_1:FormatText(var_124_4.content)

				arg_121_1.text_.text = var_124_5

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 39 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_5) / 39)

				if (39 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_5) / 39)) > 0 and var_124_3 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_5
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902029", "story_v_side_old_101902.awb") ~= 0 then
					local var_124_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902029", "story_v_side_old_101902.awb") / 1000

					if var_124_8 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_2
					end

					if var_124_4.prefab_name ~= "" and arg_121_1.actors_[var_124_4.prefab_name] ~= nil then
						local var_124_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_4.prefab_name].transform, "story_v_side_old_101902", "101902029", "story_v_side_old_101902.awb")

						arg_121_1:RecordAudio("101902029", var_124_9)
						arg_121_1:RecordAudio("101902029", var_124_9)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902029", "story_v_side_old_101902.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902029", "story_v_side_old_101902.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_10 and arg_121_1.time_ < var_124_2 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play101902030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 101902030
		arg_125_1.duration_ = 6.17

		local var_125_0 = {
			ja = 6.166,
			ko = 2.9,
			en = 3.233
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
				arg_125_0:Play101902031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1019ui_story = arg_125_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1019ui_story"].transform.position).z)
				arg_125_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1019ui_story"].transform.localEulerAngles = arg_125_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_125_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1019ui_story"].transform.position).z)
				arg_125_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1019ui_story"].transform.localEulerAngles = arg_125_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1019ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1019ui_story == nil then
				arg_125_1.var_.characterEffect1019ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1019ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_2)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1019ui_story then
				arg_125_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_128_3 = arg_125_1.actors_["1039ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1039ui_story = var_128_3.localPosition
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_3.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_125_1.time_ - 0) / var_128_4)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_3.localPosition = Vector3.New(0.7, -1.01, -5.9)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			local var_128_5 = arg_125_1.actors_["1039ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1039ui_story == nil then
				arg_125_1.var_.characterEffect1039ui_story = var_128_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.characterEffect1039ui_story and not isNil(var_128_5) then
					arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1039ui_story then
				arg_125_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_128_8 = 0
			local var_128_9 = 0.375

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(101902030)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 15 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 15)

				if (15 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 15)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902030", "story_v_side_old_101902.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902030", "story_v_side_old_101902.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_side_old_101902", "101902030", "story_v_side_old_101902.awb")

						arg_125_1:RecordAudio("101902030", var_128_15)
						arg_125_1:RecordAudio("101902030", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902030", "story_v_side_old_101902.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902030", "story_v_side_old_101902.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play101902031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 101902031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play101902032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1039ui_story"]) and arg_129_1.var_.characterEffect1039ui_story == nil then
				arg_129_1.var_.characterEffect1039ui_story = arg_129_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1039ui_story"]) then
				if arg_129_1.var_.characterEffect1039ui_story and not isNil(arg_129_1.actors_["1039ui_story"]) then
					arg_129_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1039ui_story"]) and arg_129_1.var_.characterEffect1039ui_story then
				arg_129_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.775

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(101902031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 31 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 31)

				if (31 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 31)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play101902032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 101902032
		arg_133_1.duration_ = 4

		local var_133_0 = {
			ja = 4,
			ko = 2.9,
			en = 3.733
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
				arg_133_0:Play101902033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1019ui_story = arg_133_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1019ui_story"].transform.position).z)
				arg_133_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1019ui_story"].transform.localEulerAngles = arg_133_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_133_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1019ui_story"].transform.position).z)
				arg_133_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1019ui_story"].transform.localEulerAngles = arg_133_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1039ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1039ui_story = var_136_1.localPosition
			end

			local var_136_2 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_2)
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

			local var_136_3 = arg_133_1.actors_["1019ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1019ui_story == nil then
				arg_133_1.var_.characterEffect1019ui_story = var_136_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_4 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 and not isNil(var_136_3) then
				if arg_133_1.var_.characterEffect1019ui_story and not isNil(var_136_3) then
					arg_133_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1019ui_story then
				arg_133_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_136_6 = 0
			local var_136_7 = 0.175

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(101902032)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 7 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 7)

				if (7 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 7)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902032", "story_v_side_old_101902.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902032", "story_v_side_old_101902.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_side_old_101902", "101902032", "story_v_side_old_101902.awb")

						arg_133_1:RecordAudio("101902032", var_136_13)
						arg_133_1:RecordAudio("101902032", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902032", "story_v_side_old_101902.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902032", "story_v_side_old_101902.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play101902033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 101902033
		arg_137_1.duration_ = 14.2

		local var_137_0 = {
			ja = 14.2,
			ko = 7.166,
			en = 11.4
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
				arg_137_0:Play101902034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_140_0 = 0
			local var_140_1 = 1.175

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(101902033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 47 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 47)

				if (47 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 47)) > 0 and var_140_1 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902033", "story_v_side_old_101902.awb") ~= 0 then
					local var_140_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902033", "story_v_side_old_101902.awb") / 1000

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end

					if var_140_2.prefab_name ~= "" and arg_137_1.actors_[var_140_2.prefab_name] ~= nil then
						local var_140_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_2.prefab_name].transform, "story_v_side_old_101902", "101902033", "story_v_side_old_101902.awb")

						arg_137_1:RecordAudio("101902033", var_140_7)
						arg_137_1:RecordAudio("101902033", var_140_7)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902033", "story_v_side_old_101902.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902033", "story_v_side_old_101902.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play101902034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 101902034
		arg_141_1.duration_ = 13.5

		local var_141_0 = {
			ja = 11.4,
			ko = 8.866,
			en = 13.5
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
				arg_141_0:Play101902035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_144_0 = 0
			local var_144_1 = 1

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_2 = arg_141_1:GetWordFromCfg(101902034)
				local var_144_3 = arg_141_1:FormatText(var_144_2.content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 40 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 40)

				if (40 <= 0 and var_144_1 or var_144_1 * (utf8.len(var_144_3) / 40)) > 0 and var_144_1 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902034", "story_v_side_old_101902.awb") ~= 0 then
					local var_144_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902034", "story_v_side_old_101902.awb") / 1000

					if var_144_6 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_0
					end

					if var_144_2.prefab_name ~= "" and arg_141_1.actors_[var_144_2.prefab_name] ~= nil then
						local var_144_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_2.prefab_name].transform, "story_v_side_old_101902", "101902034", "story_v_side_old_101902.awb")

						arg_141_1:RecordAudio("101902034", var_144_7)
						arg_141_1:RecordAudio("101902034", var_144_7)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902034", "story_v_side_old_101902.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902034", "story_v_side_old_101902.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play101902035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 101902035
		arg_145_1.duration_ = 16.63

		local var_145_0 = {
			ja = 12.866,
			ko = 11.2,
			en = 16.633
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
				arg_145_0:Play101902036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_148_0 = 0
			local var_148_1 = 1.475

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(101902035)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 59 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 59)

				if (59 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 59)) > 0 and var_148_1 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902035", "story_v_side_old_101902.awb") ~= 0 then
					local var_148_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902035", "story_v_side_old_101902.awb") / 1000

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end

					if var_148_2.prefab_name ~= "" and arg_145_1.actors_[var_148_2.prefab_name] ~= nil then
						local var_148_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_2.prefab_name].transform, "story_v_side_old_101902", "101902035", "story_v_side_old_101902.awb")

						arg_145_1:RecordAudio("101902035", var_148_7)
						arg_145_1:RecordAudio("101902035", var_148_7)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902035", "story_v_side_old_101902.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902035", "story_v_side_old_101902.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_8 and arg_145_1.time_ < var_148_0 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play101902036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 101902036
		arg_149_1.duration_ = 12.6

		local var_149_0 = {
			ja = 11.1,
			ko = 9.1,
			en = 12.6
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play101902037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_152_0 = 0
			local var_152_1 = 0.975

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_2 = arg_149_1:GetWordFromCfg(101902036)
				local var_152_3 = arg_149_1:FormatText(var_152_2.content)

				arg_149_1.text_.text = var_152_3

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 39 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 39)

				if (39 <= 0 and var_152_1 or var_152_1 * (utf8.len(var_152_3) / 39)) > 0 and var_152_1 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_3
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902036", "story_v_side_old_101902.awb") ~= 0 then
					local var_152_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902036", "story_v_side_old_101902.awb") / 1000

					if var_152_6 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_0
					end

					if var_152_2.prefab_name ~= "" and arg_149_1.actors_[var_152_2.prefab_name] ~= nil then
						local var_152_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_2.prefab_name].transform, "story_v_side_old_101902", "101902036", "story_v_side_old_101902.awb")

						arg_149_1:RecordAudio("101902036", var_152_7)
						arg_149_1:RecordAudio("101902036", var_152_7)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902036", "story_v_side_old_101902.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902036", "story_v_side_old_101902.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play101902037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 101902037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play101902038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1019ui_story = arg_153_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1019ui_story"].transform.position).z)
				arg_153_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1019ui_story"].transform.localEulerAngles = arg_153_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1019ui_story"].transform.position).z)
				arg_153_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1019ui_story"].transform.localEulerAngles = arg_153_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_156_1 = 0
			local var_156_2 = 0.875

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(101902037).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 35 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 35)

				if (35 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 35)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play101902038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 101902038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play101902039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.675

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(101902038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 27)

				if (27 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 27)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play101902039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 101902039
		arg_161_1.duration_ = 19

		local var_161_0 = {
			ja = 19,
			ko = 11.366,
			en = 17.666
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
				arg_161_0:Play101902040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1019ui_story = arg_161_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1019ui_story"].transform.position).z)
				arg_161_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1019ui_story"].transform.localEulerAngles = arg_161_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_161_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1019ui_story"].transform.position).z)
				arg_161_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1019ui_story"].transform.localEulerAngles = arg_161_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1019ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1019ui_story == nil then
				arg_161_1.var_.characterEffect1019ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1019ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1019ui_story then
				arg_161_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_164_4 = 0
			local var_164_5 = 1.35

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(101902039)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 54 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 54)

				if (54 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 54)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902039", "story_v_side_old_101902.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902039", "story_v_side_old_101902.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_side_old_101902", "101902039", "story_v_side_old_101902.awb")

						arg_161_1:RecordAudio("101902039", var_164_11)
						arg_161_1:RecordAudio("101902039", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902039", "story_v_side_old_101902.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902039", "story_v_side_old_101902.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play101902040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 101902040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play101902041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1019ui_story"]) and arg_165_1.var_.characterEffect1019ui_story == nil then
				arg_165_1.var_.characterEffect1019ui_story = arg_165_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1019ui_story"]) then
				if arg_165_1.var_.characterEffect1019ui_story and not isNil(arg_165_1.actors_["1019ui_story"]) then
					arg_165_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1019ui_story"]) and arg_165_1.var_.characterEffect1019ui_story then
				arg_165_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_168_1 = 0
			local var_168_2 = 0.65

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_3 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(101902040).content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 26 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 26)

				if (26 <= 0 and var_168_2 or var_168_2 * (utf8.len(var_168_3) / 26)) > 0 and var_168_2 < var_168_5 then
					arg_165_1.talkMaxDuration = var_168_5

					if var_168_5 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_6 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_6 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_6

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_6 and arg_165_1.time_ < var_168_1 + var_168_6 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play101902041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 101902041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play101902042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1019ui_story = arg_169_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).z)
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles = arg_169_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1019ui_story"].transform.position).z)
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1019ui_story"].transform.localEulerAngles = arg_169_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_172_1 = 0
			local var_172_2 = 0.9

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(101902041).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 36 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 36)

				if (36 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 36)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play101902042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 101902042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play101902043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.875

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(101902042).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 35 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 35)

				if (35 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 35)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play101902043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 101902043
		arg_177_1.duration_ = 7

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play101902044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				local var_180_0 = arg_177_1.bgs_.ST02

				arg_177_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_180_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_180_1 = var_180_0:GetComponent("SpriteRenderer")

				if var_180_1 and var_180_1.sprite then
					local var_180_2 = 2 * (var_180_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_180_0.transform.localScale = Vector3.New(var_180_2 / var_180_1.sprite.bounds.size.y < var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x and var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x or var_180_2 / var_180_1.sprite.bounds.size.y, var_180_2 / var_180_1.sprite.bounds.size.y < var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x and var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x or var_180_2 / var_180_1.sprite.bounds.size.y, 0)
				end

				for iter_180_0, iter_180_1 in pairs(arg_177_1.bgs_) do
					if iter_180_0 ~= "ST02" then
						iter_180_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_180_3 = "B13a"

			if arg_177_1.bgs_.B13a == nil then
				local var_180_4 = Object.Instantiate(arg_177_1.paintGo_)

				var_180_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_180_3)
				var_180_4.name = var_180_3
				var_180_4.transform.parent = arg_177_1.stage_.transform
				var_180_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.bgs_[var_180_3] = var_180_4
			end

			if 1 < arg_177_1.time_ and arg_177_1.time_ <= 1 + arg_180_0 then
				local var_180_5 = arg_177_1.bgs_.B13a

				arg_177_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_180_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_180_6 = var_180_5:GetComponent("SpriteRenderer")

				if var_180_6 and var_180_6.sprite then
					local var_180_7 = 2 * (var_180_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_180_5.transform.localScale = Vector3.New(var_180_7 / var_180_6.sprite.bounds.size.y < var_180_7 * manager.ui.mainCameraCom_.aspect / var_180_6.sprite.bounds.size.x and var_180_7 * manager.ui.mainCameraCom_.aspect / var_180_6.sprite.bounds.size.x or var_180_7 / var_180_6.sprite.bounds.size.y, var_180_7 / var_180_6.sprite.bounds.size.y < var_180_7 * manager.ui.mainCameraCom_.aspect / var_180_6.sprite.bounds.size.x and var_180_7 * manager.ui.mainCameraCom_.aspect / var_180_6.sprite.bounds.size.x or var_180_7 / var_180_6.sprite.bounds.size.y, 0)
				end

				for iter_180_2, iter_180_3 in pairs(arg_177_1.bgs_) do
					if iter_180_2 ~= "B13a" then
						iter_180_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_180_8 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = false

				arg_177_1:SetGaussion(false)
			end

			local var_180_9 = 1

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_9 then
				local var_180_10 = Color.New(0, 0, 0)

				var_180_10.a = Mathf.Lerp(0, 1, (arg_177_1.time_ - var_180_8) / var_180_9)
				arg_177_1.mask_.color = var_180_10
			end

			if arg_177_1.time_ >= var_180_8 + var_180_9 and arg_177_1.time_ < var_180_8 + var_180_9 + arg_180_0 then
				local var_180_11 = Color.New(0, 0, 0)

				var_180_11.a = 1
				arg_177_1.mask_.color = var_180_11
			end

			local var_180_12 = 1

			if 1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_12 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = false

				arg_177_1:SetGaussion(false)
			end

			local var_180_13 = 1

			if var_180_12 <= arg_177_1.time_ and arg_177_1.time_ < var_180_12 + var_180_13 then
				local var_180_14 = Color.New(0, 0, 0)

				var_180_14.a = Mathf.Lerp(1, 0, (arg_177_1.time_ - var_180_12) / var_180_13)
				arg_177_1.mask_.color = var_180_14
			end

			if arg_177_1.time_ >= var_180_12 + var_180_13 and arg_177_1.time_ < var_180_12 + var_180_13 + arg_180_0 then
				local var_180_15 = Color.New(0, 0, 0)

				arg_177_1.mask_.enabled = false
				var_180_15.a = 0
				arg_177_1.mask_.color = var_180_15
			end

			if arg_177_1.frameCnt_ <= 1 then
				arg_177_1.dialog_:SetActive(false)
			end

			local var_180_16 = 1.999999999999
			local var_180_17 = 0.825

			if 1.999999999999 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				arg_177_1.dialog_:SetActive(true)

				arg_177_1.dialogCg_.alpha = 0

				local var_180_18 = LeanTween.value(arg_177_1.dialog_, 0, 1, 0.3)

				var_180_18:setOnUpdate(LuaHelper.FloatAction(function(arg_181_0)
					arg_177_1.dialogCg_.alpha = arg_181_0
				end))
				var_180_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_177_1.dialog_)
					var_180_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_177_1.duration_ = arg_177_1.duration_ + 0.3

				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_19 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(101902043).content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_21 = 33 <= 0 and var_180_17 or var_180_17 * (utf8.len(var_180_19) / 33)

				if (33 <= 0 and var_180_17 or var_180_17 * (utf8.len(var_180_19) / 33)) > 0 and var_180_17 < var_180_21 then
					arg_177_1.talkMaxDuration = var_180_21
					var_180_16 = var_180_16 + 0.3

					if var_180_21 + var_180_16 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_21 + var_180_16
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_22 = var_180_16 + 0.3
			local var_180_23 = math.max(var_180_17, arg_177_1.talkMaxDuration)

			if var_180_16 + 0.3 <= arg_177_1.time_ and arg_177_1.time_ < var_180_22 + var_180_23 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_22) / var_180_23

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_22 + var_180_23 and arg_177_1.time_ < var_180_22 + var_180_23 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play101902044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 101902044
		arg_183_1.duration_ = 4.5

		local var_183_0 = {
			ja = 4.366,
			ko = 3.8,
			en = 4.5
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play101902045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1039ui_story = arg_183_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1039ui_story"].transform.position).z)
				arg_183_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1039ui_story"].transform.localEulerAngles = arg_183_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_183_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1039ui_story"].transform.position).z)
				arg_183_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1039ui_story"].transform.localEulerAngles = arg_183_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1039ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1039ui_story == nil then
				arg_183_1.var_.characterEffect1039ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1039ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1039ui_story then
				arg_183_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_186_4 = 0
			local var_186_5 = 0.425

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(101902044)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 17 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 17)

				if (17 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 17)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902044", "story_v_side_old_101902.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902044", "story_v_side_old_101902.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_side_old_101902", "101902044", "story_v_side_old_101902.awb")

						arg_183_1:RecordAudio("101902044", var_186_11)
						arg_183_1:RecordAudio("101902044", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902044", "story_v_side_old_101902.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902044", "story_v_side_old_101902.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play101902045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 101902045
		arg_187_1.duration_ = 7.5

		local var_187_0 = {
			ja = 7.3,
			ko = 5.466,
			en = 7.5
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play101902046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1039ui_story = arg_187_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1039ui_story"].transform.position).z)
				arg_187_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1039ui_story"].transform.localEulerAngles = arg_187_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -5.9)
				arg_187_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1039ui_story"].transform.position).z)
				arg_187_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1039ui_story"].transform.localEulerAngles = arg_187_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["1039ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1039ui_story == nil then
				arg_187_1.var_.characterEffect1039ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1039ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_2)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1039ui_story then
				arg_187_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_190_3 = arg_187_1.actors_["1019ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1019ui_story = var_190_3.localPosition
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_3.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_187_1.time_ - 0) / var_190_4)
				var_190_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_3.position).x, (manager.ui.mainCamera.transform.position - var_190_3.position).y, (manager.ui.mainCamera.transform.position - var_190_3.position).z)
				var_190_3.localEulerAngles.z = 0
				var_190_3.localEulerAngles.x = 0
				var_190_3.localEulerAngles = var_190_3.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_3.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_190_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_3.position).x, (manager.ui.mainCamera.transform.position - var_190_3.position).y, (manager.ui.mainCamera.transform.position - var_190_3.position).z)
				var_190_3.localEulerAngles.z = 0
				var_190_3.localEulerAngles.x = 0
				var_190_3.localEulerAngles = var_190_3.localEulerAngles
			end

			local var_190_5 = arg_187_1.actors_["1019ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect1019ui_story == nil then
				arg_187_1.var_.characterEffect1019ui_story = var_190_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 and not isNil(var_190_5) then
				if arg_187_1.var_.characterEffect1019ui_story and not isNil(var_190_5) then
					arg_187_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect1019ui_story then
				arg_187_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_190_8 = 0
			local var_190_9 = 0.675

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(101902045)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 27 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 27)

				if (27 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 27)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902045", "story_v_side_old_101902.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902045", "story_v_side_old_101902.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_side_old_101902", "101902045", "story_v_side_old_101902.awb")

						arg_187_1:RecordAudio("101902045", var_190_15)
						arg_187_1:RecordAudio("101902045", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902045", "story_v_side_old_101902.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902045", "story_v_side_old_101902.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play101902046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 101902046
		arg_191_1.duration_ = 4.97

		local var_191_0 = {
			ja = 4.966,
			ko = 4.066,
			en = 4.566
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play101902047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1019ui_story"]) and arg_191_1.var_.characterEffect1019ui_story == nil then
				arg_191_1.var_.characterEffect1019ui_story = arg_191_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1019ui_story"]) then
				if arg_191_1.var_.characterEffect1019ui_story and not isNil(arg_191_1.actors_["1019ui_story"]) then
					arg_191_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1019ui_story"]) and arg_191_1.var_.characterEffect1019ui_story then
				arg_191_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_194_2 = 0
			local var_194_3 = 0.525

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(101902046)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 21 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 21)

				if (21 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 21)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902046", "story_v_side_old_101902.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902046", "story_v_side_old_101902.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_side_old_101902", "101902046", "story_v_side_old_101902.awb")

						arg_191_1:RecordAudio("101902046", var_194_9)
						arg_191_1:RecordAudio("101902046", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902046", "story_v_side_old_101902.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902046", "story_v_side_old_101902.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play101902047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 101902047
		arg_195_1.duration_ = 6.17

		local var_195_0 = {
			ja = 5.333,
			ko = 5.533,
			en = 6.166
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play101902048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) and arg_195_1.var_.characterEffect1019ui_story == nil then
				arg_195_1.var_.characterEffect1019ui_story = arg_195_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) then
				if arg_195_1.var_.characterEffect1019ui_story and not isNil(arg_195_1.actors_["1019ui_story"]) then
					arg_195_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1019ui_story"]) and arg_195_1.var_.characterEffect1019ui_story then
				arg_195_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_198_1 = arg_195_1.actors_["1039ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1039ui_story == nil then
				arg_195_1.var_.characterEffect1039ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1039ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1039ui_story then
				arg_195_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_198_4 = 0
			local var_198_5 = 0.45

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(101902047)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 18 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 18)

				if (18 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 18)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902047", "story_v_side_old_101902.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902047", "story_v_side_old_101902.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_side_old_101902", "101902047", "story_v_side_old_101902.awb")

						arg_195_1:RecordAudio("101902047", var_198_11)
						arg_195_1:RecordAudio("101902047", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902047", "story_v_side_old_101902.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902047", "story_v_side_old_101902.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play101902048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 101902048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play101902049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1039ui_story"]) and arg_199_1.var_.characterEffect1039ui_story == nil then
				arg_199_1.var_.characterEffect1039ui_story = arg_199_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1039ui_story"]) then
				if arg_199_1.var_.characterEffect1039ui_story and not isNil(arg_199_1.actors_["1039ui_story"]) then
					arg_199_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1039ui_story"]) and arg_199_1.var_.characterEffect1039ui_story then
				arg_199_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_202_1 = 0
			local var_202_2 = 0.525

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
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

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(101902048).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 21 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 21)

				if (21 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 21)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play101902049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 101902049
		arg_203_1.duration_ = 12.4

		local var_203_0 = {
			ja = 12.4,
			ko = 6.033,
			en = 12.133
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
				arg_203_0:Play101902050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1039ui_story"]) and arg_203_1.var_.characterEffect1039ui_story == nil then
				arg_203_1.var_.characterEffect1039ui_story = arg_203_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1039ui_story"]) then
				if arg_203_1.var_.characterEffect1039ui_story and not isNil(arg_203_1.actors_["1039ui_story"]) then
					arg_203_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1039ui_story"]) and arg_203_1.var_.characterEffect1039ui_story then
				arg_203_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_206_2 = 0
			local var_206_3 = 1.125

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:GetWordFromCfg(101902049)
				local var_206_5 = arg_203_1:FormatText(var_206_4.content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 45 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 45)

				if (45 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_5) / 45)) > 0 and var_206_3 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902049", "story_v_side_old_101902.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902049", "story_v_side_old_101902.awb") / 1000

					if var_206_8 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_2
					end

					if var_206_4.prefab_name ~= "" and arg_203_1.actors_[var_206_4.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_4.prefab_name].transform, "story_v_side_old_101902", "101902049", "story_v_side_old_101902.awb")

						arg_203_1:RecordAudio("101902049", var_206_9)
						arg_203_1:RecordAudio("101902049", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902049", "story_v_side_old_101902.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902049", "story_v_side_old_101902.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_10 and arg_203_1.time_ < var_206_2 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play101902050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 101902050
		arg_207_1.duration_ = 6.93

		local var_207_0 = {
			ja = 6.933,
			ko = 2.933,
			en = 3.8
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play101902051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1019ui_story"]) and arg_207_1.var_.characterEffect1019ui_story == nil then
				arg_207_1.var_.characterEffect1019ui_story = arg_207_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1019ui_story"]) then
				if arg_207_1.var_.characterEffect1019ui_story and not isNil(arg_207_1.actors_["1019ui_story"]) then
					arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1019ui_story"]) and arg_207_1.var_.characterEffect1019ui_story then
				arg_207_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_210_2 = arg_207_1.actors_["1039ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect1039ui_story == nil then
				arg_207_1.var_.characterEffect1039ui_story = var_210_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_3 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.characterEffect1039ui_story and not isNil(var_210_2) then
					arg_207_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_3)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect1039ui_story then
				arg_207_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_210_4 = 0
			local var_210_5 = 0.3

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(101902050)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 12 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 12)

				if (12 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 12)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902050", "story_v_side_old_101902.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902050", "story_v_side_old_101902.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_side_old_101902", "101902050", "story_v_side_old_101902.awb")

						arg_207_1:RecordAudio("101902050", var_210_11)
						arg_207_1:RecordAudio("101902050", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902050", "story_v_side_old_101902.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902050", "story_v_side_old_101902.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play101902051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 101902051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play101902052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1019ui_story"]) and arg_211_1.var_.characterEffect1019ui_story == nil then
				arg_211_1.var_.characterEffect1019ui_story = arg_211_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1019ui_story"]) then
				if arg_211_1.var_.characterEffect1019ui_story and not isNil(arg_211_1.actors_["1019ui_story"]) then
					arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_0)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1019ui_story"]) and arg_211_1.var_.characterEffect1019ui_story then
				arg_211_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_214_1 = 0
			local var_214_2 = 1.1

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(101902051).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 44 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 44)

				if (44 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 44)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play101902052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 101902052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play101902053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.35

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
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

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(101902052).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 14 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 14)

				if (14 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 14)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play101902053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 101902053
		arg_219_1.duration_ = 12.93

		local var_219_0 = {
			ja = 12.933,
			ko = 6.466,
			en = 8.266
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
				arg_219_0:Play101902054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1019ui_story"]) and arg_219_1.var_.characterEffect1019ui_story == nil then
				arg_219_1.var_.characterEffect1019ui_story = arg_219_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.2

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1019ui_story"]) then
				if arg_219_1.var_.characterEffect1019ui_story and not isNil(arg_219_1.actors_["1019ui_story"]) then
					arg_219_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1019ui_story"]) and arg_219_1.var_.characterEffect1019ui_story then
				arg_219_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action7_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_222_2 = 0
			local var_222_3 = 0.725

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(101902053)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 29 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 29)

				if (29 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 29)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902053", "story_v_side_old_101902.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902053", "story_v_side_old_101902.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_side_old_101902", "101902053", "story_v_side_old_101902.awb")

						arg_219_1:RecordAudio("101902053", var_222_9)
						arg_219_1:RecordAudio("101902053", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902053", "story_v_side_old_101902.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902053", "story_v_side_old_101902.awb")
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
	Play101902054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 101902054
		arg_223_1.duration_ = 10.83

		local var_223_0 = {
			ja = 10.833,
			ko = 5.266,
			en = 8.8
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play101902055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1039ui_story"]) and arg_223_1.var_.characterEffect1039ui_story == nil then
				arg_223_1.var_.characterEffect1039ui_story = arg_223_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1039ui_story"]) then
				if arg_223_1.var_.characterEffect1039ui_story and not isNil(arg_223_1.actors_["1039ui_story"]) then
					arg_223_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1039ui_story"]) and arg_223_1.var_.characterEffect1039ui_story then
				arg_223_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_226_2 = arg_223_1.actors_["1019ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.characterEffect1019ui_story == nil then
				arg_223_1.var_.characterEffect1019ui_story = var_226_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_3 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.characterEffect1019ui_story and not isNil(var_226_2) then
					arg_223_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_3)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.characterEffect1019ui_story then
				arg_223_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			local var_226_4 = 0
			local var_226_5 = 0.65

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(101902054)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 26 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 26)

				if (26 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 26)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902054", "story_v_side_old_101902.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902054", "story_v_side_old_101902.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_side_old_101902", "101902054", "story_v_side_old_101902.awb")

						arg_223_1:RecordAudio("101902054", var_226_11)
						arg_223_1:RecordAudio("101902054", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902054", "story_v_side_old_101902.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902054", "story_v_side_old_101902.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play101902055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 101902055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play101902056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1019ui_story = arg_227_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).z)
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles = arg_227_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1019ui_story"].transform.position).z)
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1019ui_story"].transform.localEulerAngles = arg_227_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1039ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1039ui_story = var_230_1.localPosition
			end

			local var_230_2 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 then
				var_230_1.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_2)
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
			local var_230_4 = 1.4

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

				local var_230_5 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(101902055).content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 56 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 56)

				if (56 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 56)) > 0 and var_230_4 < var_230_7 then
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play101902056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 101902056
		arg_231_1.duration_ = 1

		SetActive(arg_231_1.tipsGo_, true)

		arg_231_1.tipsText_.text = StoryTipsCfg[101901].name

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"

			SetActive(arg_231_1.choicesGo_, true)

			for iter_232_0, iter_232_1 in ipairs(arg_231_1.choices_) do
				SetActive(iter_232_1.go, iter_232_0 <= 2)
			end

			arg_231_1.choices_[1].txt.text = arg_231_1:FormatText(StoryChoiceCfg[135].name)
			arg_231_1.choices_[2].txt.text = arg_231_1:FormatText(StoryChoiceCfg[136].name)
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				PlayerAction.UseStoryTrigger(1019011, 210190102, 101902056, 1)
				arg_231_0:Play101902057(arg_231_1)
			end

			if arg_233_0 == 2 then
				arg_231_0:Play101902059(arg_231_1)
			end

			arg_231_1:RecordChoiceLog(101902056, 135, 136)
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= 0 + 0.5 and arg_231_1.time_ < 0 + 0.5 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play101902057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 101902057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play101902060(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.375

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				arg_235_1.dialog_:SetActive(true)

				arg_235_1.dialogCg_.alpha = 0

				local var_238_2 = LeanTween.value(arg_235_1.dialog_, 0, 1, 0.3)

				var_238_2:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_235_1.dialogCg_.alpha = arg_239_0
				end))
				var_238_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_235_1.dialog_)
					var_238_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_235_1.duration_ = arg_235_1.duration_ + 0.3

				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(101902057).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 55 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 55)

				if (55 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 55)) > 0 and var_238_1 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5
					var_238_0 = var_238_0 + 0.3

					if var_238_5 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = var_238_0 + 0.3
			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 + 0.3 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_7 and arg_235_1.time_ < var_238_6 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play101902060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 101902060
		arg_241_1.duration_ = 6.83

		local var_241_0 = {
			ja = 6.833,
			ko = 3.366,
			en = 2.9
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
				arg_241_0:Play101902061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1019ui_story = arg_241_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1019ui_story"].transform.position).z)
				arg_241_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1019ui_story"].transform.localEulerAngles = arg_241_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_241_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1019ui_story"].transform.position).z)
				arg_241_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1019ui_story"].transform.localEulerAngles = arg_241_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1019ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1019ui_story == nil then
				arg_241_1.var_.characterEffect1019ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.2

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1019ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1019ui_story then
				arg_241_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.3

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(101902060)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 12 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 12)

				if (12 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 12)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902060", "story_v_side_old_101902.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902060", "story_v_side_old_101902.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_side_old_101902", "101902060", "story_v_side_old_101902.awb")

						arg_241_1:RecordAudio("101902060", var_244_11)
						arg_241_1:RecordAudio("101902060", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902060", "story_v_side_old_101902.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902060", "story_v_side_old_101902.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play101902061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 101902061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play101902062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1019ui_story"]) and arg_245_1.var_.characterEffect1019ui_story == nil then
				arg_245_1.var_.characterEffect1019ui_story = arg_245_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1019ui_story"]) then
				if arg_245_1.var_.characterEffect1019ui_story and not isNil(arg_245_1.actors_["1019ui_story"]) then
					arg_245_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1019ui_story"]) and arg_245_1.var_.characterEffect1019ui_story then
				arg_245_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.775

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(101902061).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 31 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 31)

				if (31 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 31)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play101902062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 101902062
		arg_249_1.duration_ = 14.53

		local var_249_0 = {
			ja = 14.533,
			ko = 5.4,
			en = 6.4
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
				arg_249_0:Play101902063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1019ui_story"]) and arg_249_1.var_.characterEffect1019ui_story == nil then
				arg_249_1.var_.characterEffect1019ui_story = arg_249_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1019ui_story"]) then
				if arg_249_1.var_.characterEffect1019ui_story and not isNil(arg_249_1.actors_["1019ui_story"]) then
					arg_249_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1019ui_story"]) and arg_249_1.var_.characterEffect1019ui_story then
				arg_249_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_252_2 = 0
			local var_252_3 = 0.75

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:GetWordFromCfg(101902062)
				local var_252_5 = arg_249_1:FormatText(var_252_4.content)

				arg_249_1.text_.text = var_252_5

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_7 = 30 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 30)

				if (30 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_5) / 30)) > 0 and var_252_3 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_5
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902062", "story_v_side_old_101902.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902062", "story_v_side_old_101902.awb") / 1000

					if var_252_8 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_2
					end

					if var_252_4.prefab_name ~= "" and arg_249_1.actors_[var_252_4.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_4.prefab_name].transform, "story_v_side_old_101902", "101902062", "story_v_side_old_101902.awb")

						arg_249_1:RecordAudio("101902062", var_252_9)
						arg_249_1:RecordAudio("101902062", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902062", "story_v_side_old_101902.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902062", "story_v_side_old_101902.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_10 and arg_249_1.time_ < var_252_2 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play101902063 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 101902063
		arg_253_1.duration_ = 6

		local var_253_0 = {
			ja = 5.1,
			ko = 5.466,
			en = 6
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
				arg_253_0:Play101902064(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_256_0 = 0
			local var_256_1 = 0.475

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(101902063)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 19 <= 0 and var_256_1 or var_256_1 * (utf8.len(var_256_3) / 19)

				if (19 <= 0 and var_256_1 or var_256_1 * (utf8.len(var_256_3) / 19)) > 0 and var_256_1 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902063", "story_v_side_old_101902.awb") ~= 0 then
					local var_256_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902063", "story_v_side_old_101902.awb") / 1000

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end

					if var_256_2.prefab_name ~= "" and arg_253_1.actors_[var_256_2.prefab_name] ~= nil then
						local var_256_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_2.prefab_name].transform, "story_v_side_old_101902", "101902063", "story_v_side_old_101902.awb")

						arg_253_1:RecordAudio("101902063", var_256_7)
						arg_253_1:RecordAudio("101902063", var_256_7)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902063", "story_v_side_old_101902.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902063", "story_v_side_old_101902.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_8 and arg_253_1.time_ < var_256_0 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play101902064 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 101902064
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play101902065(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1019ui_story = arg_257_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).z)
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles = arg_257_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1019ui_story"].transform.position).z)
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1019ui_story"].transform.localEulerAngles = arg_257_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_260_1 = 0
			local var_260_2 = 0.7

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(101902064).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 28 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 28)

				if (28 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 28)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play101902065 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 101902065
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play101902066(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.15

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
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

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(101902065).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 6 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 6)

				if (6 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 6)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play101902066 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 101902066
		arg_265_1.duration_ = 6.4

		local var_265_0 = {
			ja = 5.966,
			ko = 6.4,
			en = 4.3
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
				arg_265_0:Play101902067(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1019ui_story = arg_265_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1019ui_story"].transform.position).z)
				arg_265_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1019ui_story"].transform.localEulerAngles = arg_265_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_265_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1019ui_story"].transform.position).z)
				arg_265_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1019ui_story"].transform.localEulerAngles = arg_265_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1019ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1019ui_story == nil then
				arg_265_1.var_.characterEffect1019ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1019ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1019ui_story then
				arg_265_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_268_4 = 0
			local var_268_5 = 0.525

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(101902066)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 21 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 21)

				if (21 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 21)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902066", "story_v_side_old_101902.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902066", "story_v_side_old_101902.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_side_old_101902", "101902066", "story_v_side_old_101902.awb")

						arg_265_1:RecordAudio("101902066", var_268_11)
						arg_265_1:RecordAudio("101902066", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902066", "story_v_side_old_101902.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902066", "story_v_side_old_101902.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play101902067 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 101902067
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play101902068(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1019ui_story"]) and arg_269_1.var_.characterEffect1019ui_story == nil then
				arg_269_1.var_.characterEffect1019ui_story = arg_269_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1019ui_story"]) then
				if arg_269_1.var_.characterEffect1019ui_story and not isNil(arg_269_1.actors_["1019ui_story"]) then
					arg_269_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1019ui_story"]) and arg_269_1.var_.characterEffect1019ui_story then
				arg_269_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.15

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(101902067).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 6 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 6)

				if (6 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 6)) > 0 and var_272_2 < var_272_5 then
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

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play101902068 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 101902068
		arg_273_1.duration_ = 12.3

		local var_273_0 = {
			ja = 12.3,
			ko = 9.2,
			en = 11.866
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
				arg_273_0:Play101902069(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1019ui_story"]) and arg_273_1.var_.characterEffect1019ui_story == nil then
				arg_273_1.var_.characterEffect1019ui_story = arg_273_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1019ui_story"]) then
				if arg_273_1.var_.characterEffect1019ui_story and not isNil(arg_273_1.actors_["1019ui_story"]) then
					arg_273_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1019ui_story"]) and arg_273_1.var_.characterEffect1019ui_story then
				arg_273_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_276_2 = 0
			local var_276_3 = 1.075

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_4 = arg_273_1:GetWordFromCfg(101902068)
				local var_276_5 = arg_273_1:FormatText(var_276_4.content)

				arg_273_1.text_.text = var_276_5

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_7 = 43 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 43)

				if (43 <= 0 and var_276_3 or var_276_3 * (utf8.len(var_276_5) / 43)) > 0 and var_276_3 < var_276_7 then
					arg_273_1.talkMaxDuration = var_276_7

					if var_276_7 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_2
					end
				end

				arg_273_1.text_.text = var_276_5
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902068", "story_v_side_old_101902.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902068", "story_v_side_old_101902.awb") / 1000

					if var_276_8 + var_276_2 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_2
					end

					if var_276_4.prefab_name ~= "" and arg_273_1.actors_[var_276_4.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_4.prefab_name].transform, "story_v_side_old_101902", "101902068", "story_v_side_old_101902.awb")

						arg_273_1:RecordAudio("101902068", var_276_9)
						arg_273_1:RecordAudio("101902068", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902068", "story_v_side_old_101902.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902068", "story_v_side_old_101902.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_10 = math.max(var_276_3, arg_273_1.talkMaxDuration)

			if var_276_2 <= arg_273_1.time_ and arg_273_1.time_ < var_276_2 + var_276_10 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_2) / var_276_10

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_2 + var_276_10 and arg_273_1.time_ < var_276_2 + var_276_10 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play101902069 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 101902069
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play101902070(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1019ui_story"]) and arg_277_1.var_.characterEffect1019ui_story == nil then
				arg_277_1.var_.characterEffect1019ui_story = arg_277_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1019ui_story"]) then
				if arg_277_1.var_.characterEffect1019ui_story and not isNil(arg_277_1.actors_["1019ui_story"]) then
					arg_277_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_277_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1019ui_story"]) and arg_277_1.var_.characterEffect1019ui_story then
				arg_277_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_277_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_280_1 = 0
			local var_280_2 = 0.775

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(101902069).content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 31 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 31)

				if (31 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 31)) > 0 and var_280_2 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_6 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_6 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_6

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_6 and arg_277_1.time_ < var_280_1 + var_280_6 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play101902070 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 101902070
		arg_281_1.duration_ = 8.97

		local var_281_0 = {
			ja = 8.033,
			ko = 7.8,
			en = 8.966
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
				arg_281_0:Play101902071(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1019ui_story"]) and arg_281_1.var_.characterEffect1019ui_story == nil then
				arg_281_1.var_.characterEffect1019ui_story = arg_281_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1019ui_story"]) then
				if arg_281_1.var_.characterEffect1019ui_story and not isNil(arg_281_1.actors_["1019ui_story"]) then
					arg_281_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1019ui_story"]) and arg_281_1.var_.characterEffect1019ui_story then
				arg_281_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_284_2 = 0
			local var_284_3 = 0.875

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_4 = arg_281_1:GetWordFromCfg(101902070)
				local var_284_5 = arg_281_1:FormatText(var_284_4.content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 35 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 35)

				if (35 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 35)) > 0 and var_284_3 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902070", "story_v_side_old_101902.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902070", "story_v_side_old_101902.awb") / 1000

					if var_284_8 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_2
					end

					if var_284_4.prefab_name ~= "" and arg_281_1.actors_[var_284_4.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_4.prefab_name].transform, "story_v_side_old_101902", "101902070", "story_v_side_old_101902.awb")

						arg_281_1:RecordAudio("101902070", var_284_9)
						arg_281_1:RecordAudio("101902070", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902070", "story_v_side_old_101902.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902070", "story_v_side_old_101902.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_10 and arg_281_1.time_ < var_284_2 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play101902071 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 101902071
		arg_285_1.duration_ = 5.87

		local var_285_0 = {
			ja = 5.866,
			ko = 3.5,
			en = 3.7
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
				arg_285_0:Play101902072(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1019ui_story = arg_285_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1019ui_story"].transform.position).z)
				arg_285_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1019ui_story"].transform.localEulerAngles = arg_285_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_285_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1019ui_story"].transform.position).z)
				arg_285_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1019ui_story"].transform.localEulerAngles = arg_285_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1039ui_story"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1039ui_story = var_288_1.localPosition
			end

			local var_288_2 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 then
				var_288_1.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_285_1.time_ - 0) / var_288_2)
				var_288_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_1.position).x, (manager.ui.mainCamera.transform.position - var_288_1.position).y, (manager.ui.mainCamera.transform.position - var_288_1.position).z)
				var_288_1.localEulerAngles.z = 0
				var_288_1.localEulerAngles.x = 0
				var_288_1.localEulerAngles = var_288_1.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 then
				var_288_1.localPosition = Vector3.New(0.7, -1.01, -5.9)
				var_288_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_288_1.position).x, (manager.ui.mainCamera.transform.position - var_288_1.position).y, (manager.ui.mainCamera.transform.position - var_288_1.position).z)
				var_288_1.localEulerAngles.z = 0
				var_288_1.localEulerAngles.x = 0
				var_288_1.localEulerAngles = var_288_1.localEulerAngles
			end

			local var_288_3 = arg_285_1.actors_["1019ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_3) and arg_285_1.var_.characterEffect1019ui_story == nil then
				arg_285_1.var_.characterEffect1019ui_story = var_288_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_4 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 and not isNil(var_288_3) then
				if arg_285_1.var_.characterEffect1019ui_story and not isNil(var_288_3) then
					arg_285_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_4)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 and not isNil(var_288_3) and arg_285_1.var_.characterEffect1019ui_story then
				arg_285_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_288_5 = arg_285_1.actors_["1039ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.characterEffect1039ui_story == nil then
				arg_285_1.var_.characterEffect1039ui_story = var_288_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_6 and not isNil(var_288_5) then
				if arg_285_1.var_.characterEffect1039ui_story and not isNil(var_288_5) then
					arg_285_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_6 and arg_285_1.time_ < 0 + var_288_6 + arg_288_0 and not isNil(var_288_5) and arg_285_1.var_.characterEffect1039ui_story then
				arg_285_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_288_8 = 0
			local var_288_9 = 0.425

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_10 = arg_285_1:GetWordFromCfg(101902071)
				local var_288_11 = arg_285_1:FormatText(var_288_10.content)

				arg_285_1.text_.text = var_288_11

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_13 = 17 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 17)

				if (17 <= 0 and var_288_9 or var_288_9 * (utf8.len(var_288_11) / 17)) > 0 and var_288_9 < var_288_13 then
					arg_285_1.talkMaxDuration = var_288_13

					if var_288_13 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_13 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_11
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902071", "story_v_side_old_101902.awb") ~= 0 then
					local var_288_14 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902071", "story_v_side_old_101902.awb") / 1000

					if var_288_14 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_14 + var_288_8
					end

					if var_288_10.prefab_name ~= "" and arg_285_1.actors_[var_288_10.prefab_name] ~= nil then
						local var_288_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_10.prefab_name].transform, "story_v_side_old_101902", "101902071", "story_v_side_old_101902.awb")

						arg_285_1:RecordAudio("101902071", var_288_15)
						arg_285_1:RecordAudio("101902071", var_288_15)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902071", "story_v_side_old_101902.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902071", "story_v_side_old_101902.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_16 = math.max(var_288_9, arg_285_1.talkMaxDuration)

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_16 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_8) / var_288_16

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_8 + var_288_16 and arg_285_1.time_ < var_288_8 + var_288_16 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play101902072 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 101902072
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play101902073(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1039ui_story"]) and arg_289_1.var_.characterEffect1039ui_story == nil then
				arg_289_1.var_.characterEffect1039ui_story = arg_289_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1039ui_story"]) then
				if arg_289_1.var_.characterEffect1039ui_story and not isNil(arg_289_1.actors_["1039ui_story"]) then
					arg_289_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_0)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1039ui_story"]) and arg_289_1.var_.characterEffect1039ui_story then
				arg_289_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_292_1 = 0
			local var_292_2 = 0.05

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(101902072).content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 2 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 2)

				if (2 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 2)) > 0 and var_292_2 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_6 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_6 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_6

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_6 and arg_289_1.time_ < var_292_1 + var_292_6 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play101902073 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 101902073
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play101902074(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1039ui_story = arg_293_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1039ui_story"].transform.position).z)
				arg_293_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1039ui_story"].transform.localEulerAngles = arg_293_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1039ui_story"].transform.position).z)
				arg_293_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1039ui_story"].transform.localEulerAngles = arg_293_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1019ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1019ui_story = var_296_1.localPosition
			end

			local var_296_2 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 then
				var_296_1.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_2)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 then
				var_296_1.localPosition = Vector3.New(0, 100, 0)
				var_296_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_1.position).x, (manager.ui.mainCamera.transform.position - var_296_1.position).y, (manager.ui.mainCamera.transform.position - var_296_1.position).z)
				var_296_1.localEulerAngles.z = 0
				var_296_1.localEulerAngles.x = 0
				var_296_1.localEulerAngles = var_296_1.localEulerAngles
			end

			local var_296_3 = 0
			local var_296_4 = 0.65

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_5 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(101902073).content)

				arg_293_1.text_.text = var_296_5

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 26 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_5) / 26)

				if (26 <= 0 and var_296_4 or var_296_4 * (utf8.len(var_296_5) / 26)) > 0 and var_296_4 < var_296_7 then
					arg_293_1.talkMaxDuration = var_296_7

					if var_296_7 + var_296_3 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_7 + var_296_3
					end
				end

				arg_293_1.text_.text = var_296_5
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_4, arg_293_1.talkMaxDuration)

			if var_296_3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_3 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_3) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_3 + var_296_8 and arg_293_1.time_ < var_296_3 + var_296_8 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play101902074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 101902074
		arg_297_1.duration_ = 9

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play101902075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				local var_300_0 = arg_297_1.bgs_.B13a

				arg_297_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_1 = var_300_0:GetComponent("SpriteRenderer")

				if var_300_1 and var_300_1.sprite then
					local var_300_2 = 2 * (var_300_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_0.transform.localScale = Vector3.New(var_300_2 / var_300_1.sprite.bounds.size.y < var_300_2 * manager.ui.mainCameraCom_.aspect / var_300_1.sprite.bounds.size.x and var_300_2 * manager.ui.mainCameraCom_.aspect / var_300_1.sprite.bounds.size.x or var_300_2 / var_300_1.sprite.bounds.size.y, var_300_2 / var_300_1.sprite.bounds.size.y < var_300_2 * manager.ui.mainCameraCom_.aspect / var_300_1.sprite.bounds.size.x and var_300_2 * manager.ui.mainCameraCom_.aspect / var_300_1.sprite.bounds.size.x or var_300_2 / var_300_1.sprite.bounds.size.y, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "B13a" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_3 = "ST07a"

			if arg_297_1.bgs_.ST07a == nil then
				local var_300_4 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_300_3)
				var_300_4.name = var_300_3
				var_300_4.transform.parent = arg_297_1.stage_.transform
				var_300_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_[var_300_3] = var_300_4
			end

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= 2 + arg_300_0 then
				local var_300_5 = arg_297_1.bgs_.ST07a

				arg_297_1.bgs_.ST07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_6 = var_300_5:GetComponent("SpriteRenderer")

				if var_300_6 and var_300_6.sprite then
					local var_300_7 = 2 * (var_300_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_5.transform.localScale = Vector3.New(var_300_7 / var_300_6.sprite.bounds.size.y < var_300_7 * manager.ui.mainCameraCom_.aspect / var_300_6.sprite.bounds.size.x and var_300_7 * manager.ui.mainCameraCom_.aspect / var_300_6.sprite.bounds.size.x or var_300_7 / var_300_6.sprite.bounds.size.y, var_300_7 / var_300_6.sprite.bounds.size.y < var_300_7 * manager.ui.mainCameraCom_.aspect / var_300_6.sprite.bounds.size.x and var_300_7 * manager.ui.mainCameraCom_.aspect / var_300_6.sprite.bounds.size.x or var_300_7 / var_300_6.sprite.bounds.size.y, 0)
				end

				for iter_300_2, iter_300_3 in pairs(arg_297_1.bgs_) do
					if iter_300_2 ~= "ST07a" then
						iter_300_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_8 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = false

				arg_297_1:SetGaussion(false)
			end

			local var_300_9 = 2

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 then
				local var_300_10 = Color.New(0, 0, 0)

				var_300_10.a = Mathf.Lerp(0, 1, (arg_297_1.time_ - var_300_8) / var_300_9)
				arg_297_1.mask_.color = var_300_10
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 then
				local var_300_11 = Color.New(0, 0, 0)

				var_300_11.a = 1
				arg_297_1.mask_.color = var_300_11
			end

			local var_300_12 = 2

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_12 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = false

				arg_297_1:SetGaussion(false)
			end

			local var_300_13 = 2

			if var_300_12 <= arg_297_1.time_ and arg_297_1.time_ < var_300_12 + var_300_13 then
				local var_300_14 = Color.New(0, 0, 0)

				var_300_14.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_12) / var_300_13)
				arg_297_1.mask_.color = var_300_14
			end

			if arg_297_1.time_ >= var_300_12 + var_300_13 and arg_297_1.time_ < var_300_12 + var_300_13 + arg_300_0 then
				local var_300_15 = Color.New(0, 0, 0)

				arg_297_1.mask_.enabled = false
				var_300_15.a = 0
				arg_297_1.mask_.color = var_300_15
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_16 = 4
			local var_300_17 = 1.525

			if 4 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_18 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_18:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_19 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(101902074).content)

				arg_297_1.text_.text = var_300_19

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_21 = 61 <= 0 and var_300_17 or var_300_17 * (utf8.len(var_300_19) / 61)

				if (61 <= 0 and var_300_17 or var_300_17 * (utf8.len(var_300_19) / 61)) > 0 and var_300_17 < var_300_21 then
					arg_297_1.talkMaxDuration = var_300_21
					var_300_16 = var_300_16 + 0.3

					if var_300_21 + var_300_16 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_21 + var_300_16
					end
				end

				arg_297_1.text_.text = var_300_19
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_22 = var_300_16 + 0.3
			local var_300_23 = math.max(var_300_17, arg_297_1.talkMaxDuration)

			if var_300_16 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_22 + var_300_23 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_22) / var_300_23

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_22 + var_300_23 and arg_297_1.time_ < var_300_22 + var_300_23 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play101902075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 101902075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play101902076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.25

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

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(101902075).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 50 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 50)

				if (50 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 50)) > 0 and var_306_0 < var_306_3 then
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
	Play101902076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 101902076
		arg_307_1.duration_ = 3.97

		local var_307_0 = {
			ja = 2.8,
			ko = 3.666,
			en = 3.966
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
				arg_307_0:Play101902077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0.3

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[228].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_1 = arg_307_1:GetWordFromCfg(101902076)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 12 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 12)

				if (12 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 12)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902076", "story_v_side_old_101902.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902076", "story_v_side_old_101902.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_side_old_101902", "101902076", "story_v_side_old_101902.awb")

						arg_307_1:RecordAudio("101902076", var_310_6)
						arg_307_1:RecordAudio("101902076", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902076", "story_v_side_old_101902.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902076", "story_v_side_old_101902.awb")
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
	Play101902077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 101902077
		arg_311_1.duration_ = 3.03

		local var_311_0 = {
			ja = 3.033,
			ko = 2.333,
			en = 1.999999999999
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
				arg_311_0:Play101902078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1019ui_story = arg_311_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1019ui_story"].transform.position).z)
				arg_311_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1019ui_story"].transform.localEulerAngles = arg_311_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_311_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1019ui_story"].transform.position).z)
				arg_311_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1019ui_story"].transform.localEulerAngles = arg_311_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1019ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1019ui_story == nil then
				arg_311_1.var_.characterEffect1019ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1019ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1019ui_story then
				arg_311_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_314_4 = 0
			local var_314_5 = 0.25

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_6 = arg_311_1:GetWordFromCfg(101902077)
				local var_314_7 = arg_311_1:FormatText(var_314_6.content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 10 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 10)

				if (10 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 10)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902077", "story_v_side_old_101902.awb") ~= 0 then
					local var_314_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902077", "story_v_side_old_101902.awb") / 1000

					if var_314_10 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_4
					end

					if var_314_6.prefab_name ~= "" and arg_311_1.actors_[var_314_6.prefab_name] ~= nil then
						local var_314_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_6.prefab_name].transform, "story_v_side_old_101902", "101902077", "story_v_side_old_101902.awb")

						arg_311_1:RecordAudio("101902077", var_314_11)
						arg_311_1:RecordAudio("101902077", var_314_11)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902077", "story_v_side_old_101902.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902077", "story_v_side_old_101902.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play101902078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 101902078
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play101902079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1019ui_story"]) and arg_315_1.var_.characterEffect1019ui_story == nil then
				arg_315_1.var_.characterEffect1019ui_story = arg_315_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1019ui_story"]) then
				if arg_315_1.var_.characterEffect1019ui_story and not isNil(arg_315_1.actors_["1019ui_story"]) then
					arg_315_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1019ui_story"]) and arg_315_1.var_.characterEffect1019ui_story then
				arg_315_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 0.7

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(101902078).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 28 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 28)

				if (28 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 28)) > 0 and var_318_2 < var_318_5 then
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
	Play101902079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 101902079
		arg_319_1.duration_ = 11.77

		local var_319_0 = {
			ja = 11.766,
			ko = 5.2,
			en = 8.233
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
				arg_319_0:Play101902080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.475

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[227].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:GetWordFromCfg(101902079)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 19 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 19)

				if (19 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 19)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902079", "story_v_side_old_101902.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902079", "story_v_side_old_101902.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_side_old_101902", "101902079", "story_v_side_old_101902.awb")

						arg_319_1:RecordAudio("101902079", var_322_6)
						arg_319_1:RecordAudio("101902079", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902079", "story_v_side_old_101902.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902079", "story_v_side_old_101902.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play101902080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 101902080
		arg_323_1.duration_ = 6.13

		local var_323_0 = {
			ja = 6.133,
			ko = 2.833,
			en = 5.1
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play101902081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1019ui_story"]) and arg_323_1.var_.characterEffect1019ui_story == nil then
				arg_323_1.var_.characterEffect1019ui_story = arg_323_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1019ui_story"]) then
				if arg_323_1.var_.characterEffect1019ui_story and not isNil(arg_323_1.actors_["1019ui_story"]) then
					arg_323_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1019ui_story"]) and arg_323_1.var_.characterEffect1019ui_story then
				arg_323_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_326_2 = 0
			local var_326_3 = 0.45

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_2 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_4 = arg_323_1:GetWordFromCfg(101902080)
				local var_326_5 = arg_323_1:FormatText(var_326_4.content)

				arg_323_1.text_.text = var_326_5

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_7 = 18 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 18)

				if (18 <= 0 and var_326_3 or var_326_3 * (utf8.len(var_326_5) / 18)) > 0 and var_326_3 < var_326_7 then
					arg_323_1.talkMaxDuration = var_326_7

					if var_326_7 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_7 + var_326_2
					end
				end

				arg_323_1.text_.text = var_326_5
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902080", "story_v_side_old_101902.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902080", "story_v_side_old_101902.awb") / 1000

					if var_326_8 + var_326_2 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_2
					end

					if var_326_4.prefab_name ~= "" and arg_323_1.actors_[var_326_4.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_4.prefab_name].transform, "story_v_side_old_101902", "101902080", "story_v_side_old_101902.awb")

						arg_323_1:RecordAudio("101902080", var_326_9)
						arg_323_1:RecordAudio("101902080", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902080", "story_v_side_old_101902.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902080", "story_v_side_old_101902.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_10 = math.max(var_326_3, arg_323_1.talkMaxDuration)

			if var_326_2 <= arg_323_1.time_ and arg_323_1.time_ < var_326_2 + var_326_10 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_2) / var_326_10

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_2 + var_326_10 and arg_323_1.time_ < var_326_2 + var_326_10 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play101902081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 101902081
		arg_327_1.duration_ = 1.63

		local var_327_0 = {
			ko = 1.633,
			en = 1.333
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play101902082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1019ui_story"]) and arg_327_1.var_.characterEffect1019ui_story == nil then
				arg_327_1.var_.characterEffect1019ui_story = arg_327_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1019ui_story"]) then
				if arg_327_1.var_.characterEffect1019ui_story and not isNil(arg_327_1.actors_["1019ui_story"]) then
					arg_327_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1019ui_story"]) and arg_327_1.var_.characterEffect1019ui_story then
				arg_327_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 0.075

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[121].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:GetWordFromCfg(101902081)
				local var_330_4 = arg_327_1:FormatText(var_330_3.content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_6 = 3 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_4) / 3)

				if (3 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_4) / 3)) > 0 and var_330_2 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902081", "story_v_side_old_101902.awb") ~= 0 then
					local var_330_7 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902081", "story_v_side_old_101902.awb") / 1000

					if var_330_7 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_7 + var_330_1
					end

					if var_330_3.prefab_name ~= "" and arg_327_1.actors_[var_330_3.prefab_name] ~= nil then
						local var_330_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_3.prefab_name].transform, "story_v_side_old_101902", "101902081", "story_v_side_old_101902.awb")

						arg_327_1:RecordAudio("101902081", var_330_8)
						arg_327_1:RecordAudio("101902081", var_330_8)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902081", "story_v_side_old_101902.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902081", "story_v_side_old_101902.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_9 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_9 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_9

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_9 and arg_327_1.time_ < var_330_1 + var_330_9 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play101902082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 101902082
		arg_331_1.duration_ = 16.87

		local var_331_0 = {
			ja = 16.866,
			ko = 10.233,
			en = 14.566
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
				arg_331_0:Play101902083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1019ui_story"]) and arg_331_1.var_.characterEffect1019ui_story == nil then
				arg_331_1.var_.characterEffect1019ui_story = arg_331_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1019ui_story"]) then
				if arg_331_1.var_.characterEffect1019ui_story and not isNil(arg_331_1.actors_["1019ui_story"]) then
					arg_331_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1019ui_story"]) and arg_331_1.var_.characterEffect1019ui_story then
				arg_331_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_334_2 = 0
			local var_334_3 = 1.25

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_2 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_4 = arg_331_1:GetWordFromCfg(101902082)
				local var_334_5 = arg_331_1:FormatText(var_334_4.content)

				arg_331_1.text_.text = var_334_5

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_7 = 50 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 50)

				if (50 <= 0 and var_334_3 or var_334_3 * (utf8.len(var_334_5) / 50)) > 0 and var_334_3 < var_334_7 then
					arg_331_1.talkMaxDuration = var_334_7

					if var_334_7 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_7 + var_334_2
					end
				end

				arg_331_1.text_.text = var_334_5
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902082", "story_v_side_old_101902.awb") ~= 0 then
					local var_334_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902082", "story_v_side_old_101902.awb") / 1000

					if var_334_8 + var_334_2 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_8 + var_334_2
					end

					if var_334_4.prefab_name ~= "" and arg_331_1.actors_[var_334_4.prefab_name] ~= nil then
						local var_334_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_4.prefab_name].transform, "story_v_side_old_101902", "101902082", "story_v_side_old_101902.awb")

						arg_331_1:RecordAudio("101902082", var_334_9)
						arg_331_1:RecordAudio("101902082", var_334_9)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902082", "story_v_side_old_101902.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902082", "story_v_side_old_101902.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_3, arg_331_1.talkMaxDuration)

			if var_334_2 <= arg_331_1.time_ and arg_331_1.time_ < var_334_2 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_2) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_2 + var_334_10 and arg_331_1.time_ < var_334_2 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play101902083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 101902083
		arg_335_1.duration_ = 20.83

		local var_335_0 = {
			ja = 20.833,
			ko = 10.566,
			en = 10.266
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play101902084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1019ui_story"]) and arg_335_1.var_.characterEffect1019ui_story == nil then
				arg_335_1.var_.characterEffect1019ui_story = arg_335_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1019ui_story"]) then
				if arg_335_1.var_.characterEffect1019ui_story and not isNil(arg_335_1.actors_["1019ui_story"]) then
					arg_335_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1019ui_story"]) and arg_335_1.var_.characterEffect1019ui_story then
				arg_335_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_338_1 = 0
			local var_338_2 = 0.925

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[227].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(101902083)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_6 = 37 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_4) / 37)

				if (37 <= 0 and var_338_2 or var_338_2 * (utf8.len(var_338_4) / 37)) > 0 and var_338_2 < var_338_6 then
					arg_335_1.talkMaxDuration = var_338_6

					if var_338_6 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_6 + var_338_1
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902083", "story_v_side_old_101902.awb") ~= 0 then
					local var_338_7 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902083", "story_v_side_old_101902.awb") / 1000

					if var_338_7 + var_338_1 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_1
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_side_old_101902", "101902083", "story_v_side_old_101902.awb")

						arg_335_1:RecordAudio("101902083", var_338_8)
						arg_335_1:RecordAudio("101902083", var_338_8)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902083", "story_v_side_old_101902.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902083", "story_v_side_old_101902.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_9 = math.max(var_338_2, arg_335_1.talkMaxDuration)

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_9 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_1) / var_338_9

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_1 + var_338_9 and arg_335_1.time_ < var_338_1 + var_338_9 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play101902084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 101902084
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play101902085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1019ui_story = arg_339_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1019ui_story"].transform.position).z)
				arg_339_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1019ui_story"].transform.localEulerAngles = arg_339_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1019ui_story"].transform.position).z)
				arg_339_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1019ui_story"].transform.localEulerAngles = arg_339_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_342_1 = 0
			local var_342_2 = 1.35

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(101902084).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 54 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 54)

				if (54 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 54)) > 0 and var_342_2 < var_342_5 then
					arg_339_1.talkMaxDuration = var_342_5

					if var_342_5 + var_342_1 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + var_342_1
					end
				end

				arg_339_1.text_.text = var_342_3
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_6 = math.max(var_342_2, arg_339_1.talkMaxDuration)

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_6 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_1) / var_342_6

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_1 + var_342_6 and arg_339_1.time_ < var_342_1 + var_342_6 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play101902085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 101902085
		arg_343_1.duration_ = 9.87

		local var_343_0 = {
			ja = 9.866,
			ko = 4.933,
			en = 4.8
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play101902086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.45

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[227].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_1 = arg_343_1:GetWordFromCfg(101902085)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 18 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 18)

				if (18 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 18)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902085", "story_v_side_old_101902.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902085", "story_v_side_old_101902.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_side_old_101902", "101902085", "story_v_side_old_101902.awb")

						arg_343_1:RecordAudio("101902085", var_346_6)
						arg_343_1:RecordAudio("101902085", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902085", "story_v_side_old_101902.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902085", "story_v_side_old_101902.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play101902086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 101902086
		arg_347_1.duration_ = 11.2

		local var_347_0 = {
			ja = 11.2,
			ko = 7.866,
			en = 9.866
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play101902087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1019ui_story = arg_347_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1019ui_story"].transform.position).z)
				arg_347_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1019ui_story"].transform.localEulerAngles = arg_347_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_347_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1019ui_story"].transform.position).z)
				arg_347_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1019ui_story"].transform.localEulerAngles = arg_347_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_350_1 = arg_347_1.actors_["1019ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect1019ui_story == nil then
				arg_347_1.var_.characterEffect1019ui_story = var_350_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_2 and not isNil(var_350_1) then
				if arg_347_1.var_.characterEffect1019ui_story and not isNil(var_350_1) then
					arg_347_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_2 and arg_347_1.time_ < 0 + var_350_2 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect1019ui_story then
				arg_347_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action452")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_350_4 = 0
			local var_350_5 = 0.9

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_6 = arg_347_1:GetWordFromCfg(101902086)
				local var_350_7 = arg_347_1:FormatText(var_350_6.content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 36 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 36)

				if (36 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 36)) > 0 and var_350_5 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902086", "story_v_side_old_101902.awb") ~= 0 then
					local var_350_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902086", "story_v_side_old_101902.awb") / 1000

					if var_350_10 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_4
					end

					if var_350_6.prefab_name ~= "" and arg_347_1.actors_[var_350_6.prefab_name] ~= nil then
						local var_350_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_6.prefab_name].transform, "story_v_side_old_101902", "101902086", "story_v_side_old_101902.awb")

						arg_347_1:RecordAudio("101902086", var_350_11)
						arg_347_1:RecordAudio("101902086", var_350_11)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902086", "story_v_side_old_101902.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902086", "story_v_side_old_101902.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_12 and arg_347_1.time_ < var_350_4 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play101902087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 101902087
		arg_351_1.duration_ = 16.8

		local var_351_0 = {
			ja = 16.1,
			ko = 13.766,
			en = 16.8
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
				arg_351_0:Play101902088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1019ui_story = arg_351_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1019ui_story"].transform.position).z)
				arg_351_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1019ui_story"].transform.localEulerAngles = arg_351_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1019ui_story"].transform.position).z)
				arg_351_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1019ui_story"].transform.localEulerAngles = arg_351_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_354_1 = 0
			local var_354_2 = 1.225

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[227].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_3 = arg_351_1:GetWordFromCfg(101902087)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_6 = 49 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 49)

				if (49 <= 0 and var_354_2 or var_354_2 * (utf8.len(var_354_4) / 49)) > 0 and var_354_2 < var_354_6 then
					arg_351_1.talkMaxDuration = var_354_6

					if var_354_6 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_6 + var_354_1
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902087", "story_v_side_old_101902.awb") ~= 0 then
					local var_354_7 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902087", "story_v_side_old_101902.awb") / 1000

					if var_354_7 + var_354_1 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_1
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_side_old_101902", "101902087", "story_v_side_old_101902.awb")

						arg_351_1:RecordAudio("101902087", var_354_8)
						arg_351_1:RecordAudio("101902087", var_354_8)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902087", "story_v_side_old_101902.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902087", "story_v_side_old_101902.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_9 = math.max(var_354_2, arg_351_1.talkMaxDuration)

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_9 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_1) / var_354_9

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_1 + var_354_9 and arg_351_1.time_ < var_354_1 + var_354_9 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play101902088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 101902088
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play101902089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 1.45

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(101902088).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 58 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 58)

				if (58 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 58)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play101902089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 101902089
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play101902090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1.525

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(101902089).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 61 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 61)

				if (61 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 61)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play101902090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 101902090
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play101902091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.675

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(101902090).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 27 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 27)

				if (27 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 27)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play101902091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 101902091
		arg_367_1.duration_ = 5.17

		local var_367_0 = {
			ja = 5.066,
			ko = 2.766,
			en = 5.166
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play101902092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if arg_367_1.actors_["1032ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1032ui_story"))) then
				local var_370_0 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_367_1.stage_.transform)

				var_370_0.name = "1032ui_story"
				var_370_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.actors_["1032ui_story"] = var_370_0

				local var_370_1 = var_370_0:GetComponentInChildren(typeof(CharacterEffect))

				var_370_1.enabled = true

				local var_370_2 = GameObjectTools.GetOrAddComponent(var_370_0, typeof(DynamicBoneHelper))

				if var_370_2 then
					var_370_2:EnableDynamicBone(false)
				end

				arg_367_1:ShowWeapon(var_370_1.transform, false)

				arg_367_1.var_["1032ui_story" .. "Animator"] = var_370_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_367_1.var_["1032ui_story" .. "Animator"].applyRootMotion = true
				arg_367_1.var_["1032ui_story" .. "LipSync"] = var_370_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_370_3 = arg_367_1.actors_["1032ui_story"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1032ui_story = var_370_3.localPosition
			end

			local var_370_4 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				var_370_3.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1032ui_story, Vector3.New(0, -1.05, -6.2), (arg_367_1.time_ - 0) / var_370_4)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				var_370_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			local var_370_5 = arg_367_1.actors_["1032ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.characterEffect1032ui_story == nil then
				arg_367_1.var_.characterEffect1032ui_story = var_370_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_6 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_6 and not isNil(var_370_5) then
				if arg_367_1.var_.characterEffect1032ui_story and not isNil(var_370_5) then
					arg_367_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_6 and arg_367_1.time_ < 0 + var_370_6 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.characterEffect1032ui_story then
				arg_367_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action8_1")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_370_8 = 0
			local var_370_9 = 0.35

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_10 = arg_367_1:GetWordFromCfg(101902091)
				local var_370_11 = arg_367_1:FormatText(var_370_10.content)

				arg_367_1.text_.text = var_370_11

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 14 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 14)

				if (14 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 14)) > 0 and var_370_9 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_8
					end
				end

				arg_367_1.text_.text = var_370_11
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902091", "story_v_side_old_101902.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902091", "story_v_side_old_101902.awb") / 1000

					if var_370_14 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_8
					end

					if var_370_10.prefab_name ~= "" and arg_367_1.actors_[var_370_10.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_10.prefab_name].transform, "story_v_side_old_101902", "101902091", "story_v_side_old_101902.awb")

						arg_367_1:RecordAudio("101902091", var_370_15)
						arg_367_1:RecordAudio("101902091", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902091", "story_v_side_old_101902.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902091", "story_v_side_old_101902.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_9, arg_367_1.talkMaxDuration)

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_8) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_8 + var_370_16 and arg_367_1.time_ < var_370_8 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play101902092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 101902092
		arg_371_1.duration_ = 9

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play101902093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				local var_374_0 = arg_371_1.bgs_.ST07a

				arg_371_1.bgs_.ST07a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_374_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_374_1 = var_374_0:GetComponent("SpriteRenderer")

				if var_374_1 and var_374_1.sprite then
					local var_374_2 = 2 * (var_374_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_374_0.transform.localScale = Vector3.New(var_374_2 / var_374_1.sprite.bounds.size.y < var_374_2 * manager.ui.mainCameraCom_.aspect / var_374_1.sprite.bounds.size.x and var_374_2 * manager.ui.mainCameraCom_.aspect / var_374_1.sprite.bounds.size.x or var_374_2 / var_374_1.sprite.bounds.size.y, var_374_2 / var_374_1.sprite.bounds.size.y < var_374_2 * manager.ui.mainCameraCom_.aspect / var_374_1.sprite.bounds.size.x and var_374_2 * manager.ui.mainCameraCom_.aspect / var_374_1.sprite.bounds.size.x or var_374_2 / var_374_1.sprite.bounds.size.y, 0)
				end

				for iter_374_0, iter_374_1 in pairs(arg_371_1.bgs_) do
					if iter_374_0 ~= "ST07a" then
						iter_374_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_371_1.time_ and arg_371_1.time_ <= 2 + arg_374_0 then
				local var_374_3 = arg_371_1.bgs_.B13a

				arg_371_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_374_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_374_4 = var_374_3:GetComponent("SpriteRenderer")

				if var_374_4 and var_374_4.sprite then
					local var_374_5 = 2 * (var_374_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_374_3.transform.localScale = Vector3.New(var_374_5 / var_374_4.sprite.bounds.size.y < var_374_5 * manager.ui.mainCameraCom_.aspect / var_374_4.sprite.bounds.size.x and var_374_5 * manager.ui.mainCameraCom_.aspect / var_374_4.sprite.bounds.size.x or var_374_5 / var_374_4.sprite.bounds.size.y, var_374_5 / var_374_4.sprite.bounds.size.y < var_374_5 * manager.ui.mainCameraCom_.aspect / var_374_4.sprite.bounds.size.x and var_374_5 * manager.ui.mainCameraCom_.aspect / var_374_4.sprite.bounds.size.x or var_374_5 / var_374_4.sprite.bounds.size.y, 0)
				end

				for iter_374_2, iter_374_3 in pairs(arg_371_1.bgs_) do
					if iter_374_2 ~= "B13a" then
						iter_374_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_374_6 = arg_371_1.actors_["1032ui_story"].transform

			if 4 < arg_371_1.time_ and arg_371_1.time_ <= 4 + arg_374_0 then
				arg_371_1.var_.moveOldPos1032ui_story = var_374_6.localPosition
			end

			local var_374_7 = 0.001

			if 4 <= arg_371_1.time_ and arg_371_1.time_ < 4 + var_374_7 then
				var_374_6.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 4) / var_374_7)
				var_374_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_6.position).x, (manager.ui.mainCamera.transform.position - var_374_6.position).y, (manager.ui.mainCamera.transform.position - var_374_6.position).z)
				var_374_6.localEulerAngles.z = 0
				var_374_6.localEulerAngles.x = 0
				var_374_6.localEulerAngles = var_374_6.localEulerAngles
			end

			if arg_371_1.time_ >= 4 + var_374_7 and arg_371_1.time_ < 4 + var_374_7 + arg_374_0 then
				var_374_6.localPosition = Vector3.New(0, 100, 0)
				var_374_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_374_6.position).x, (manager.ui.mainCamera.transform.position - var_374_6.position).y, (manager.ui.mainCamera.transform.position - var_374_6.position).z)
				var_374_6.localEulerAngles.z = 0
				var_374_6.localEulerAngles.x = 0
				var_374_6.localEulerAngles = var_374_6.localEulerAngles
			end

			if arg_371_1.frameCnt_ <= 1 then
				arg_371_1.dialog_:SetActive(false)
			end

			local var_374_8 = 4
			local var_374_9 = 0.9

			if 4 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_10 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_10:setOnUpdate(LuaHelper.FloatAction(function(arg_375_0)
					arg_371_1.dialogCg_.alpha = arg_375_0
				end))
				var_374_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_11 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(101902092).content)

				arg_371_1.text_.text = var_374_11

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_13 = 36 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 36)

				if (36 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 36)) > 0 and var_374_9 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13
					var_374_8 = var_374_8 + 0.3

					if var_374_13 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_8
					end
				end

				arg_371_1.text_.text = var_374_11
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_14 = var_374_8 + 0.3
			local var_374_15 = math.max(var_374_9, arg_371_1.talkMaxDuration)

			if var_374_8 + 0.3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_14 + var_374_15 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_14) / var_374_15

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_14 + var_374_15 and arg_371_1.time_ < var_374_14 + var_374_15 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play101902093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 101902093
		arg_377_1.duration_ = 4.03

		local var_377_0 = {
			ja = 4.033,
			ko = 3.966,
			en = 3.6
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play101902094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos1019ui_story = arg_377_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_380_0 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 then
				arg_377_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_377_1.time_ - 0) / var_380_0)
				arg_377_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1019ui_story"].transform.position).z)
				arg_377_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1019ui_story"].transform.localEulerAngles = arg_377_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 then
				arg_377_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_377_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_377_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_377_1.actors_["1019ui_story"].transform.position).z)
				arg_377_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_377_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_377_1.actors_["1019ui_story"].transform.localEulerAngles = arg_377_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_380_1 = arg_377_1.actors_["1019ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1019ui_story == nil then
				arg_377_1.var_.characterEffect1019ui_story = var_380_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_2 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_2 and not isNil(var_380_1) then
				if arg_377_1.var_.characterEffect1019ui_story and not isNil(var_380_1) then
					arg_377_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_2 and arg_377_1.time_ < 0 + var_380_2 + arg_380_0 and not isNil(var_380_1) and arg_377_1.var_.characterEffect1019ui_story then
				arg_377_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_380_4 = 0
			local var_380_5 = 0.275

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:GetWordFromCfg(101902093)
				local var_380_7 = arg_377_1:FormatText(var_380_6.content)

				arg_377_1.text_.text = var_380_7

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_9 = 11 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 11)

				if (11 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_7) / 11)) > 0 and var_380_5 < var_380_9 then
					arg_377_1.talkMaxDuration = var_380_9

					if var_380_9 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_9 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_7
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902093", "story_v_side_old_101902.awb") ~= 0 then
					local var_380_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902093", "story_v_side_old_101902.awb") / 1000

					if var_380_10 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_4
					end

					if var_380_6.prefab_name ~= "" and arg_377_1.actors_[var_380_6.prefab_name] ~= nil then
						local var_380_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_6.prefab_name].transform, "story_v_side_old_101902", "101902093", "story_v_side_old_101902.awb")

						arg_377_1:RecordAudio("101902093", var_380_11)
						arg_377_1:RecordAudio("101902093", var_380_11)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902093", "story_v_side_old_101902.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902093", "story_v_side_old_101902.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_12 = math.max(var_380_5, arg_377_1.talkMaxDuration)

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_12 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_4) / var_380_12

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_4 + var_380_12 and arg_377_1.time_ < var_380_4 + var_380_12 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play101902094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 101902094
		arg_381_1.duration_ = 12.37

		local var_381_0 = {
			ja = 12.366,
			ko = 6.433,
			en = 10.866
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play101902095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1032ui_story = arg_381_1.actors_["1032ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1032ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1032ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1032ui_story"].transform.position).z)
				arg_381_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1032ui_story"].transform.localEulerAngles = arg_381_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1032ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_381_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1032ui_story"].transform.position).z)
				arg_381_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1032ui_story"].transform.localEulerAngles = arg_381_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1019ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1019ui_story == nil then
				arg_381_1.var_.characterEffect1019ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1019ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_2)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1019ui_story then
				arg_381_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_384_3 = arg_381_1.actors_["1032ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_3) and arg_381_1.var_.characterEffect1032ui_story == nil then
				arg_381_1.var_.characterEffect1032ui_story = var_384_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_4 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 and not isNil(var_384_3) then
				if arg_381_1.var_.characterEffect1032ui_story and not isNil(var_384_3) then
					arg_381_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 and not isNil(var_384_3) and arg_381_1.var_.characterEffect1032ui_story then
				arg_381_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action487")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_384_6 = 0
			local var_384_7 = 0.925

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_8 = arg_381_1:GetWordFromCfg(101902094)
				local var_384_9 = arg_381_1:FormatText(var_384_8.content)

				arg_381_1.text_.text = var_384_9

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_11 = 37 <= 0 and var_384_7 or var_384_7 * (utf8.len(var_384_9) / 37)

				if (37 <= 0 and var_384_7 or var_384_7 * (utf8.len(var_384_9) / 37)) > 0 and var_384_7 < var_384_11 then
					arg_381_1.talkMaxDuration = var_384_11

					if var_384_11 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_11 + var_384_6
					end
				end

				arg_381_1.text_.text = var_384_9
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902094", "story_v_side_old_101902.awb") ~= 0 then
					local var_384_12 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902094", "story_v_side_old_101902.awb") / 1000

					if var_384_12 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_12 + var_384_6
					end

					if var_384_8.prefab_name ~= "" and arg_381_1.actors_[var_384_8.prefab_name] ~= nil then
						local var_384_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_8.prefab_name].transform, "story_v_side_old_101902", "101902094", "story_v_side_old_101902.awb")

						arg_381_1:RecordAudio("101902094", var_384_13)
						arg_381_1:RecordAudio("101902094", var_384_13)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902094", "story_v_side_old_101902.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902094", "story_v_side_old_101902.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_14 = math.max(var_384_7, arg_381_1.talkMaxDuration)

			if var_384_6 <= arg_381_1.time_ and arg_381_1.time_ < var_384_6 + var_384_14 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_6) / var_384_14

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_6 + var_384_14 and arg_381_1.time_ < var_384_6 + var_384_14 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play101902095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 101902095
		arg_385_1.duration_ = 11.2

		local var_385_0 = {
			ja = 11.2,
			ko = 6,
			en = 7.966
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play101902096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1019ui_story"]) and arg_385_1.var_.characterEffect1019ui_story == nil then
				arg_385_1.var_.characterEffect1019ui_story = arg_385_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1019ui_story"]) then
				if arg_385_1.var_.characterEffect1019ui_story and not isNil(arg_385_1.actors_["1019ui_story"]) then
					arg_385_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1019ui_story"]) and arg_385_1.var_.characterEffect1019ui_story then
				arg_385_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_388_2 = arg_385_1.actors_["1032ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.characterEffect1032ui_story == nil then
				arg_385_1.var_.characterEffect1032ui_story = var_388_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_3 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.characterEffect1032ui_story and not isNil(var_388_2) then
					arg_385_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_3)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.characterEffect1032ui_story then
				arg_385_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_388_4 = 0
			local var_388_5 = 0.675

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:GetWordFromCfg(101902095)
				local var_388_7 = arg_385_1:FormatText(var_388_6.content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 27 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 27)

				if (27 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_7) / 27)) > 0 and var_388_5 < var_388_9 then
					arg_385_1.talkMaxDuration = var_388_9

					if var_388_9 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_9 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_7
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902095", "story_v_side_old_101902.awb") ~= 0 then
					local var_388_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902095", "story_v_side_old_101902.awb") / 1000

					if var_388_10 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_4
					end

					if var_388_6.prefab_name ~= "" and arg_385_1.actors_[var_388_6.prefab_name] ~= nil then
						local var_388_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_6.prefab_name].transform, "story_v_side_old_101902", "101902095", "story_v_side_old_101902.awb")

						arg_385_1:RecordAudio("101902095", var_388_11)
						arg_385_1:RecordAudio("101902095", var_388_11)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902095", "story_v_side_old_101902.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902095", "story_v_side_old_101902.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_12 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_12 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_12

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_12 and arg_385_1.time_ < var_388_4 + var_388_12 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play101902096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 101902096
		arg_389_1.duration_ = 2

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play101902097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1019ui_story"]) and arg_389_1.var_.characterEffect1019ui_story == nil then
				arg_389_1.var_.characterEffect1019ui_story = arg_389_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1019ui_story"]) then
				if arg_389_1.var_.characterEffect1019ui_story and not isNil(arg_389_1.actors_["1019ui_story"]) then
					arg_389_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1019ui_story"]) and arg_389_1.var_.characterEffect1019ui_story then
				arg_389_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_392_1 = arg_389_1.actors_["1032ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1032ui_story == nil then
				arg_389_1.var_.characterEffect1032ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1032ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1032ui_story then
				arg_389_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action7_2")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_392_4 = 0
			local var_392_5 = 0.05

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_6 = arg_389_1:GetWordFromCfg(101902096)
				local var_392_7 = arg_389_1:FormatText(var_392_6.content)

				arg_389_1.text_.text = var_392_7

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_9 = 2 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 2)

				if (2 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 2)) > 0 and var_392_5 < var_392_9 then
					arg_389_1.talkMaxDuration = var_392_9

					if var_392_9 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_4
					end
				end

				arg_389_1.text_.text = var_392_7
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902096", "story_v_side_old_101902.awb") ~= 0 then
					local var_392_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902096", "story_v_side_old_101902.awb") / 1000

					if var_392_10 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_4
					end

					if var_392_6.prefab_name ~= "" and arg_389_1.actors_[var_392_6.prefab_name] ~= nil then
						local var_392_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_6.prefab_name].transform, "story_v_side_old_101902", "101902096", "story_v_side_old_101902.awb")

						arg_389_1:RecordAudio("101902096", var_392_11)
						arg_389_1:RecordAudio("101902096", var_392_11)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902096", "story_v_side_old_101902.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902096", "story_v_side_old_101902.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_12 = math.max(var_392_5, arg_389_1.talkMaxDuration)

			if var_392_4 <= arg_389_1.time_ and arg_389_1.time_ < var_392_4 + var_392_12 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_4) / var_392_12

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_4 + var_392_12 and arg_389_1.time_ < var_392_4 + var_392_12 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play101902097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 101902097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play101902098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1032ui_story"]) and arg_393_1.var_.characterEffect1032ui_story == nil then
				arg_393_1.var_.characterEffect1032ui_story = arg_393_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1032ui_story"]) then
				if arg_393_1.var_.characterEffect1032ui_story and not isNil(arg_393_1.actors_["1032ui_story"]) then
					arg_393_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1032ui_story"]) and arg_393_1.var_.characterEffect1032ui_story then
				arg_393_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 1

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

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(101902097).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 40 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 40)

				if (40 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 40)) > 0 and var_396_2 < var_396_5 then
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
	Play101902098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 101902098
		arg_397_1.duration_ = 4.3

		local var_397_0 = {
			ja = 4.3,
			ko = 3.066,
			en = 1.999999999999
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play101902099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1019ui_story"]) and arg_397_1.var_.characterEffect1019ui_story == nil then
				arg_397_1.var_.characterEffect1019ui_story = arg_397_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1019ui_story"]) then
				if arg_397_1.var_.characterEffect1019ui_story and not isNil(arg_397_1.actors_["1019ui_story"]) then
					arg_397_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1019ui_story"]) and arg_397_1.var_.characterEffect1019ui_story then
				arg_397_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_400_2 = 0
			local var_400_3 = 0.325

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:GetWordFromCfg(101902098)
				local var_400_5 = arg_397_1:FormatText(var_400_4.content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 13 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 13)

				if (13 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_5) / 13)) > 0 and var_400_3 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_5
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902098", "story_v_side_old_101902.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902098", "story_v_side_old_101902.awb") / 1000

					if var_400_8 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_2
					end

					if var_400_4.prefab_name ~= "" and arg_397_1.actors_[var_400_4.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_4.prefab_name].transform, "story_v_side_old_101902", "101902098", "story_v_side_old_101902.awb")

						arg_397_1:RecordAudio("101902098", var_400_9)
						arg_397_1:RecordAudio("101902098", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902098", "story_v_side_old_101902.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902098", "story_v_side_old_101902.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_10 and arg_397_1.time_ < var_400_2 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play101902099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 101902099
		arg_401_1.duration_ = 8.27

		local var_401_0 = {
			ja = 6.633,
			ko = 6.033,
			en = 8.266
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play101902100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1019ui_story"]) and arg_401_1.var_.characterEffect1019ui_story == nil then
				arg_401_1.var_.characterEffect1019ui_story = arg_401_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1019ui_story"]) then
				if arg_401_1.var_.characterEffect1019ui_story and not isNil(arg_401_1.actors_["1019ui_story"]) then
					arg_401_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_0)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1019ui_story"]) and arg_401_1.var_.characterEffect1019ui_story then
				arg_401_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_404_1 = arg_401_1.actors_["1032ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1032ui_story == nil then
				arg_401_1.var_.characterEffect1032ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect1032ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1032ui_story then
				arg_401_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action8_1")
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_404_4 = 0
			local var_404_5 = 0.675

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_6 = arg_401_1:GetWordFromCfg(101902099)
				local var_404_7 = arg_401_1:FormatText(var_404_6.content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 27 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 27)

				if (27 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 27)) > 0 and var_404_5 < var_404_9 then
					arg_401_1.talkMaxDuration = var_404_9

					if var_404_9 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902099", "story_v_side_old_101902.awb") ~= 0 then
					local var_404_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902099", "story_v_side_old_101902.awb") / 1000

					if var_404_10 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_4
					end

					if var_404_6.prefab_name ~= "" and arg_401_1.actors_[var_404_6.prefab_name] ~= nil then
						local var_404_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_6.prefab_name].transform, "story_v_side_old_101902", "101902099", "story_v_side_old_101902.awb")

						arg_401_1:RecordAudio("101902099", var_404_11)
						arg_401_1:RecordAudio("101902099", var_404_11)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902099", "story_v_side_old_101902.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902099", "story_v_side_old_101902.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_12 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_12 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_12

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_12 and arg_401_1.time_ < var_404_4 + var_404_12 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play101902100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 101902100
		arg_405_1.duration_ = 9.87

		local var_405_0 = {
			ja = 9.866,
			ko = 4.933,
			en = 5.333
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play101902101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_408_0 = 0
			local var_408_1 = 0.575

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_2 = arg_405_1:GetWordFromCfg(101902100)
				local var_408_3 = arg_405_1:FormatText(var_408_2.content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 23 <= 0 and var_408_1 or var_408_1 * (utf8.len(var_408_3) / 23)

				if (23 <= 0 and var_408_1 or var_408_1 * (utf8.len(var_408_3) / 23)) > 0 and var_408_1 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902100", "story_v_side_old_101902.awb") ~= 0 then
					local var_408_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902100", "story_v_side_old_101902.awb") / 1000

					if var_408_6 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_6 + var_408_0
					end

					if var_408_2.prefab_name ~= "" and arg_405_1.actors_[var_408_2.prefab_name] ~= nil then
						local var_408_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_2.prefab_name].transform, "story_v_side_old_101902", "101902100", "story_v_side_old_101902.awb")

						arg_405_1:RecordAudio("101902100", var_408_7)
						arg_405_1:RecordAudio("101902100", var_408_7)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902100", "story_v_side_old_101902.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902100", "story_v_side_old_101902.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_8 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_8 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_8

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_8 and arg_405_1.time_ < var_408_0 + var_408_8 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play101902101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 101902101
		arg_409_1.duration_ = 2.5

		local var_409_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			en = 2.5
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play101902102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1019ui_story"]) and arg_409_1.var_.characterEffect1019ui_story == nil then
				arg_409_1.var_.characterEffect1019ui_story = arg_409_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1019ui_story"]) then
				if arg_409_1.var_.characterEffect1019ui_story and not isNil(arg_409_1.actors_["1019ui_story"]) then
					arg_409_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1019ui_story"]) and arg_409_1.var_.characterEffect1019ui_story then
				arg_409_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_412_2 = arg_409_1.actors_["1032ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.characterEffect1032ui_story == nil then
				arg_409_1.var_.characterEffect1032ui_story = var_412_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_3 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_3 and not isNil(var_412_2) then
				if arg_409_1.var_.characterEffect1032ui_story and not isNil(var_412_2) then
					arg_409_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_3)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_3 and arg_409_1.time_ < 0 + var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.characterEffect1032ui_story then
				arg_409_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action462")
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_412_4 = 0
			local var_412_5 = 0.175

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_6 = arg_409_1:GetWordFromCfg(101902101)
				local var_412_7 = arg_409_1:FormatText(var_412_6.content)

				arg_409_1.text_.text = var_412_7

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_9 = 7 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 7)

				if (7 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_7) / 7)) > 0 and var_412_5 < var_412_9 then
					arg_409_1.talkMaxDuration = var_412_9

					if var_412_9 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_9 + var_412_4
					end
				end

				arg_409_1.text_.text = var_412_7
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902101", "story_v_side_old_101902.awb") ~= 0 then
					local var_412_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902101", "story_v_side_old_101902.awb") / 1000

					if var_412_10 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_10 + var_412_4
					end

					if var_412_6.prefab_name ~= "" and arg_409_1.actors_[var_412_6.prefab_name] ~= nil then
						local var_412_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_6.prefab_name].transform, "story_v_side_old_101902", "101902101", "story_v_side_old_101902.awb")

						arg_409_1:RecordAudio("101902101", var_412_11)
						arg_409_1:RecordAudio("101902101", var_412_11)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902101", "story_v_side_old_101902.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902101", "story_v_side_old_101902.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_12 = math.max(var_412_5, arg_409_1.talkMaxDuration)

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_12 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_4) / var_412_12

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_4 + var_412_12 and arg_409_1.time_ < var_412_4 + var_412_12 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play101902102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 101902102
		arg_413_1.duration_ = 14.3

		local var_413_0 = {
			ja = 12.5,
			ko = 11.5,
			en = 14.3
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play101902103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1019ui_story"]) and arg_413_1.var_.characterEffect1019ui_story == nil then
				arg_413_1.var_.characterEffect1019ui_story = arg_413_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1019ui_story"]) then
				if arg_413_1.var_.characterEffect1019ui_story and not isNil(arg_413_1.actors_["1019ui_story"]) then
					arg_413_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_0)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1019ui_story"]) and arg_413_1.var_.characterEffect1019ui_story then
				arg_413_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_416_1 = arg_413_1.actors_["1032ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1032ui_story == nil then
				arg_413_1.var_.characterEffect1032ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect1032ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1032ui_story then
				arg_413_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action489")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_416_4 = 0
			local var_416_5 = 1.1

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:GetWordFromCfg(101902102)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 44 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 44)

				if (44 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 44)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902102", "story_v_side_old_101902.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902102", "story_v_side_old_101902.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_side_old_101902", "101902102", "story_v_side_old_101902.awb")

						arg_413_1:RecordAudio("101902102", var_416_11)
						arg_413_1:RecordAudio("101902102", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902102", "story_v_side_old_101902.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902102", "story_v_side_old_101902.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_12 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_12 and arg_413_1.time_ < var_416_4 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play101902103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 101902103
		arg_417_1.duration_ = 11.57

		local var_417_0 = {
			ja = 10.266,
			ko = 11.566,
			en = 11.133
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
				arg_417_0:Play101902104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action497")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_420_0 = 0
			local var_420_1 = 1.275

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_2 = arg_417_1:GetWordFromCfg(101902103)
				local var_420_3 = arg_417_1:FormatText(var_420_2.content)

				arg_417_1.text_.text = var_420_3

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 51 <= 0 and var_420_1 or var_420_1 * (utf8.len(var_420_3) / 51)

				if (51 <= 0 and var_420_1 or var_420_1 * (utf8.len(var_420_3) / 51)) > 0 and var_420_1 < var_420_5 then
					arg_417_1.talkMaxDuration = var_420_5

					if var_420_5 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_3
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902103", "story_v_side_old_101902.awb") ~= 0 then
					local var_420_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902103", "story_v_side_old_101902.awb") / 1000

					if var_420_6 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_6 + var_420_0
					end

					if var_420_2.prefab_name ~= "" and arg_417_1.actors_[var_420_2.prefab_name] ~= nil then
						local var_420_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_2.prefab_name].transform, "story_v_side_old_101902", "101902103", "story_v_side_old_101902.awb")

						arg_417_1:RecordAudio("101902103", var_420_7)
						arg_417_1:RecordAudio("101902103", var_420_7)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902103", "story_v_side_old_101902.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902103", "story_v_side_old_101902.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_8 and arg_417_1.time_ < var_420_0 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play101902104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 101902104
		arg_421_1.duration_ = 19.9

		local var_421_0 = {
			ja = 19.9,
			ko = 11.566,
			en = 15.266
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
				arg_421_0:Play101902105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action7_2")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_424_0 = 0
			local var_424_1 = 1.275

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_2 = arg_421_1:GetWordFromCfg(101902104)
				local var_424_3 = arg_421_1:FormatText(var_424_2.content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 51 <= 0 and var_424_1 or var_424_1 * (utf8.len(var_424_3) / 51)

				if (51 <= 0 and var_424_1 or var_424_1 * (utf8.len(var_424_3) / 51)) > 0 and var_424_1 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902104", "story_v_side_old_101902.awb") ~= 0 then
					local var_424_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902104", "story_v_side_old_101902.awb") / 1000

					if var_424_6 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_6 + var_424_0
					end

					if var_424_2.prefab_name ~= "" and arg_421_1.actors_[var_424_2.prefab_name] ~= nil then
						local var_424_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_2.prefab_name].transform, "story_v_side_old_101902", "101902104", "story_v_side_old_101902.awb")

						arg_421_1:RecordAudio("101902104", var_424_7)
						arg_421_1:RecordAudio("101902104", var_424_7)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902104", "story_v_side_old_101902.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902104", "story_v_side_old_101902.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_8 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_8 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_8

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_8 and arg_421_1.time_ < var_424_0 + var_424_8 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play101902105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 101902105
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play101902106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1032ui_story"]) and arg_425_1.var_.characterEffect1032ui_story == nil then
				arg_425_1.var_.characterEffect1032ui_story = arg_425_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1032ui_story"]) then
				if arg_425_1.var_.characterEffect1032ui_story and not isNil(arg_425_1.actors_["1032ui_story"]) then
					arg_425_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_0)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1032ui_story"]) and arg_425_1.var_.characterEffect1032ui_story then
				arg_425_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			local var_428_1 = 0
			local var_428_2 = 1.4

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_3 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(101902105).content)

				arg_425_1.text_.text = var_428_3

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 56 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 56)

				if (56 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 56)) > 0 and var_428_2 < var_428_5 then
					arg_425_1.talkMaxDuration = var_428_5

					if var_428_5 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + var_428_1
					end
				end

				arg_425_1.text_.text = var_428_3
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_6 = math.max(var_428_2, arg_425_1.talkMaxDuration)

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_6 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_1) / var_428_6

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_1 + var_428_6 and arg_425_1.time_ < var_428_1 + var_428_6 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play101902106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 101902106
		arg_429_1.duration_ = 11.1

		local var_429_0 = {
			ja = 11.1,
			ko = 7.333,
			en = 8.9
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
				arg_429_0:Play101902107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1019ui_story"]) and arg_429_1.var_.characterEffect1019ui_story == nil then
				arg_429_1.var_.characterEffect1019ui_story = arg_429_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1019ui_story"]) then
				if arg_429_1.var_.characterEffect1019ui_story and not isNil(arg_429_1.actors_["1019ui_story"]) then
					arg_429_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1019ui_story"]) and arg_429_1.var_.characterEffect1019ui_story then
				arg_429_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_432_2 = 0
			local var_432_3 = 0.925

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_4 = arg_429_1:GetWordFromCfg(101902106)
				local var_432_5 = arg_429_1:FormatText(var_432_4.content)

				arg_429_1.text_.text = var_432_5

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_7 = 37 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 37)

				if (37 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 37)) > 0 and var_432_3 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_2
					end
				end

				arg_429_1.text_.text = var_432_5
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902106", "story_v_side_old_101902.awb") ~= 0 then
					local var_432_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902106", "story_v_side_old_101902.awb") / 1000

					if var_432_8 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_8 + var_432_2
					end

					if var_432_4.prefab_name ~= "" and arg_429_1.actors_[var_432_4.prefab_name] ~= nil then
						local var_432_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_4.prefab_name].transform, "story_v_side_old_101902", "101902106", "story_v_side_old_101902.awb")

						arg_429_1:RecordAudio("101902106", var_432_9)
						arg_429_1:RecordAudio("101902106", var_432_9)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902106", "story_v_side_old_101902.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902106", "story_v_side_old_101902.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_10 = math.max(var_432_3, arg_429_1.talkMaxDuration)

			if var_432_2 <= arg_429_1.time_ and arg_429_1.time_ < var_432_2 + var_432_10 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_2) / var_432_10

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_2 + var_432_10 and arg_429_1.time_ < var_432_2 + var_432_10 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play101902107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 101902107
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play101902108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1019ui_story"]) and arg_433_1.var_.characterEffect1019ui_story == nil then
				arg_433_1.var_.characterEffect1019ui_story = arg_433_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1019ui_story"]) then
				if arg_433_1.var_.characterEffect1019ui_story and not isNil(arg_433_1.actors_["1019ui_story"]) then
					arg_433_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_0)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1019ui_story"]) and arg_433_1.var_.characterEffect1019ui_story then
				arg_433_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_436_1 = 0
			local var_436_2 = 0.625

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_3 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(101902107).content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 25 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 25)

				if (25 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 25)) > 0 and var_436_2 < var_436_5 then
					arg_433_1.talkMaxDuration = var_436_5

					if var_436_5 + var_436_1 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + var_436_1
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_6 = math.max(var_436_2, arg_433_1.talkMaxDuration)

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_6 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_1) / var_436_6

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_1 + var_436_6 and arg_433_1.time_ < var_436_1 + var_436_6 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play101902108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 101902108
		arg_437_1.duration_ = 13.7

		local var_437_0 = {
			ja = 13.7,
			ko = 8.666,
			en = 8.466
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play101902109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1032ui_story"]) and arg_437_1.var_.characterEffect1032ui_story == nil then
				arg_437_1.var_.characterEffect1032ui_story = arg_437_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1032ui_story"]) then
				if arg_437_1.var_.characterEffect1032ui_story and not isNil(arg_437_1.actors_["1032ui_story"]) then
					arg_437_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1032ui_story"]) and arg_437_1.var_.characterEffect1032ui_story then
				arg_437_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action7_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_440_2 = 0
			local var_440_3 = 0.975

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_4 = arg_437_1:GetWordFromCfg(101902108)
				local var_440_5 = arg_437_1:FormatText(var_440_4.content)

				arg_437_1.text_.text = var_440_5

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_7 = 39 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 39)

				if (39 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_5) / 39)) > 0 and var_440_3 < var_440_7 then
					arg_437_1.talkMaxDuration = var_440_7

					if var_440_7 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_7 + var_440_2
					end
				end

				arg_437_1.text_.text = var_440_5
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902108", "story_v_side_old_101902.awb") ~= 0 then
					local var_440_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902108", "story_v_side_old_101902.awb") / 1000

					if var_440_8 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_8 + var_440_2
					end

					if var_440_4.prefab_name ~= "" and arg_437_1.actors_[var_440_4.prefab_name] ~= nil then
						local var_440_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_4.prefab_name].transform, "story_v_side_old_101902", "101902108", "story_v_side_old_101902.awb")

						arg_437_1:RecordAudio("101902108", var_440_9)
						arg_437_1:RecordAudio("101902108", var_440_9)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902108", "story_v_side_old_101902.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902108", "story_v_side_old_101902.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_10 = math.max(var_440_3, arg_437_1.talkMaxDuration)

			if var_440_2 <= arg_437_1.time_ and arg_437_1.time_ < var_440_2 + var_440_10 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_2) / var_440_10

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_2 + var_440_10 and arg_437_1.time_ < var_440_2 + var_440_10 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play101902109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 101902109
		arg_441_1.duration_ = 18.87

		local var_441_0 = {
			ja = 17.633,
			ko = 12.166,
			en = 18.866
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
				arg_441_0:Play101902110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action479")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_444_0 = 0
			local var_444_1 = 1.3

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_2 = arg_441_1:GetWordFromCfg(101902109)
				local var_444_3 = arg_441_1:FormatText(var_444_2.content)

				arg_441_1.text_.text = var_444_3

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_5 = 52 <= 0 and var_444_1 or var_444_1 * (utf8.len(var_444_3) / 52)

				if (52 <= 0 and var_444_1 or var_444_1 * (utf8.len(var_444_3) / 52)) > 0 and var_444_1 < var_444_5 then
					arg_441_1.talkMaxDuration = var_444_5

					if var_444_5 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_3
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902109", "story_v_side_old_101902.awb") ~= 0 then
					local var_444_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902109", "story_v_side_old_101902.awb") / 1000

					if var_444_6 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_0
					end

					if var_444_2.prefab_name ~= "" and arg_441_1.actors_[var_444_2.prefab_name] ~= nil then
						local var_444_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_2.prefab_name].transform, "story_v_side_old_101902", "101902109", "story_v_side_old_101902.awb")

						arg_441_1:RecordAudio("101902109", var_444_7)
						arg_441_1:RecordAudio("101902109", var_444_7)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902109", "story_v_side_old_101902.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902109", "story_v_side_old_101902.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_8 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_8 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_8

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_8 and arg_441_1.time_ < var_444_0 + var_444_8 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play101902110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 101902110
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play101902111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1032ui_story"]) and arg_445_1.var_.characterEffect1032ui_story == nil then
				arg_445_1.var_.characterEffect1032ui_story = arg_445_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1032ui_story"]) then
				if arg_445_1.var_.characterEffect1032ui_story and not isNil(arg_445_1.actors_["1032ui_story"]) then
					arg_445_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1032ui_story"]) and arg_445_1.var_.characterEffect1032ui_story then
				arg_445_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 0.275

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(101902110).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 11 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 11)

				if (11 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 11)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play101902111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 101902111
		arg_449_1.duration_ = 12.73

		local var_449_0 = {
			ja = 12.333,
			ko = 8.233,
			en = 12.733
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
				arg_449_0:Play101902112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1032ui_story"]) and arg_449_1.var_.characterEffect1032ui_story == nil then
				arg_449_1.var_.characterEffect1032ui_story = arg_449_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1032ui_story"]) then
				if arg_449_1.var_.characterEffect1032ui_story and not isNil(arg_449_1.actors_["1032ui_story"]) then
					arg_449_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1032ui_story"]) and arg_449_1.var_.characterEffect1032ui_story then
				arg_449_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action498")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_452_2 = 0
			local var_452_3 = 1.125

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_2 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_4 = arg_449_1:GetWordFromCfg(101902111)
				local var_452_5 = arg_449_1:FormatText(var_452_4.content)

				arg_449_1.text_.text = var_452_5

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_7 = 45 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 45)

				if (45 <= 0 and var_452_3 or var_452_3 * (utf8.len(var_452_5) / 45)) > 0 and var_452_3 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_2
					end
				end

				arg_449_1.text_.text = var_452_5
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902111", "story_v_side_old_101902.awb") ~= 0 then
					local var_452_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902111", "story_v_side_old_101902.awb") / 1000

					if var_452_8 + var_452_2 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_8 + var_452_2
					end

					if var_452_4.prefab_name ~= "" and arg_449_1.actors_[var_452_4.prefab_name] ~= nil then
						local var_452_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_4.prefab_name].transform, "story_v_side_old_101902", "101902111", "story_v_side_old_101902.awb")

						arg_449_1:RecordAudio("101902111", var_452_9)
						arg_449_1:RecordAudio("101902111", var_452_9)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902111", "story_v_side_old_101902.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902111", "story_v_side_old_101902.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_10 = math.max(var_452_3, arg_449_1.talkMaxDuration)

			if var_452_2 <= arg_449_1.time_ and arg_449_1.time_ < var_452_2 + var_452_10 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_2) / var_452_10

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_2 + var_452_10 and arg_449_1.time_ < var_452_2 + var_452_10 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play101902112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 101902112
		arg_453_1.duration_ = 14.93

		local var_453_0 = {
			ja = 14.933,
			ko = 4.733,
			en = 7.366
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play101902113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_456_0 = 0
			local var_456_1 = 0.475

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(101902112)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 19 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 19)

				if (19 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_3) / 19)) > 0 and var_456_1 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902112", "story_v_side_old_101902.awb") ~= 0 then
					local var_456_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902112", "story_v_side_old_101902.awb") / 1000

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end

					if var_456_2.prefab_name ~= "" and arg_453_1.actors_[var_456_2.prefab_name] ~= nil then
						local var_456_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_2.prefab_name].transform, "story_v_side_old_101902", "101902112", "story_v_side_old_101902.awb")

						arg_453_1:RecordAudio("101902112", var_456_7)
						arg_453_1:RecordAudio("101902112", var_456_7)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902112", "story_v_side_old_101902.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902112", "story_v_side_old_101902.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_8 and arg_453_1.time_ < var_456_0 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play101902113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 101902113
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play101902114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1032ui_story = arg_457_1.actors_["1032ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1032ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1032ui_story"].transform.position).z)
				arg_457_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1032ui_story"].transform.localEulerAngles = arg_457_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_457_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1032ui_story"].transform.position).z)
				arg_457_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1032ui_story"].transform.localEulerAngles = arg_457_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1019ui_story"].transform

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1019ui_story = var_460_1.localPosition
			end

			local var_460_2 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 then
				var_460_1.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 0) / var_460_2)
				var_460_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_1.position).x, (manager.ui.mainCamera.transform.position - var_460_1.position).y, (manager.ui.mainCamera.transform.position - var_460_1.position).z)
				var_460_1.localEulerAngles.z = 0
				var_460_1.localEulerAngles.x = 0
				var_460_1.localEulerAngles = var_460_1.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 then
				var_460_1.localPosition = Vector3.New(0, 100, 0)
				var_460_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_1.position).x, (manager.ui.mainCamera.transform.position - var_460_1.position).y, (manager.ui.mainCamera.transform.position - var_460_1.position).z)
				var_460_1.localEulerAngles.z = 0
				var_460_1.localEulerAngles.x = 0
				var_460_1.localEulerAngles = var_460_1.localEulerAngles
			end

			local var_460_3 = 0
			local var_460_4 = 0.85

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_3 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_5 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(101902113).content)

				arg_457_1.text_.text = var_460_5

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_7 = 34 <= 0 and var_460_4 or var_460_4 * (utf8.len(var_460_5) / 34)

				if (34 <= 0 and var_460_4 or var_460_4 * (utf8.len(var_460_5) / 34)) > 0 and var_460_4 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_3 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_3
					end
				end

				arg_457_1.text_.text = var_460_5
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_8 = math.max(var_460_4, arg_457_1.talkMaxDuration)

			if var_460_3 <= arg_457_1.time_ and arg_457_1.time_ < var_460_3 + var_460_8 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_3) / var_460_8

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_3 + var_460_8 and arg_457_1.time_ < var_460_3 + var_460_8 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play101902114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 101902114
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play101902115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.45

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(101902114).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 18 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 18)

				if (18 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 18)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play101902115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 101902115
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play101902116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 1.15

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(101902115).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 46 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 46)

				if (46 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 46)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play101902116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 101902116
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play101902117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.475

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(101902116).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 19 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 19)

				if (19 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 19)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play101902117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 101902117
		arg_473_1.duration_ = 10.9

		local var_473_0 = {
			ja = 10.9,
			ko = 6.133,
			en = 8.2
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
				arg_473_0:Play101902118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1019ui_story = arg_473_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1019ui_story"].transform.position).z)
				arg_473_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1019ui_story"].transform.localEulerAngles = arg_473_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_473_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1019ui_story"].transform.position).z)
				arg_473_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1019ui_story"].transform.localEulerAngles = arg_473_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_476_1 = arg_473_1.actors_["1019ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1019ui_story == nil then
				arg_473_1.var_.characterEffect1019ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1019ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1019ui_story then
				arg_473_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_476_4 = 0
			local var_476_5 = 0.55

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(101902117)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 22 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 22)

				if (22 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 22)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902117", "story_v_side_old_101902.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902117", "story_v_side_old_101902.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_side_old_101902", "101902117", "story_v_side_old_101902.awb")

						arg_473_1:RecordAudio("101902117", var_476_11)
						arg_473_1:RecordAudio("101902117", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902117", "story_v_side_old_101902.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902117", "story_v_side_old_101902.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play101902118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 101902118
		arg_477_1.duration_ = 12.3

		local var_477_0 = {
			ja = 12.3,
			ko = 8.033,
			en = 7.2
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play101902119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_480_0 = 0
			local var_480_1 = 0.9

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_2 = arg_477_1:GetWordFromCfg(101902118)
				local var_480_3 = arg_477_1:FormatText(var_480_2.content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 36 <= 0 and var_480_1 or var_480_1 * (utf8.len(var_480_3) / 36)

				if (36 <= 0 and var_480_1 or var_480_1 * (utf8.len(var_480_3) / 36)) > 0 and var_480_1 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902118", "story_v_side_old_101902.awb") ~= 0 then
					local var_480_6 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902118", "story_v_side_old_101902.awb") / 1000

					if var_480_6 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_6 + var_480_0
					end

					if var_480_2.prefab_name ~= "" and arg_477_1.actors_[var_480_2.prefab_name] ~= nil then
						local var_480_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_2.prefab_name].transform, "story_v_side_old_101902", "101902118", "story_v_side_old_101902.awb")

						arg_477_1:RecordAudio("101902118", var_480_7)
						arg_477_1:RecordAudio("101902118", var_480_7)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902118", "story_v_side_old_101902.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902118", "story_v_side_old_101902.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play101902119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 101902119
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play101902120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["1019ui_story"]) and arg_481_1.var_.characterEffect1019ui_story == nil then
				arg_481_1.var_.characterEffect1019ui_story = arg_481_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.2

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["1019ui_story"]) then
				if arg_481_1.var_.characterEffect1019ui_story and not isNil(arg_481_1.actors_["1019ui_story"]) then
					arg_481_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_0)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["1019ui_story"]) and arg_481_1.var_.characterEffect1019ui_story then
				arg_481_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_484_1 = 0
			local var_484_2 = 0.375

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_3 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(101902119).content)

				arg_481_1.text_.text = var_484_3

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 15 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 15)

				if (15 <= 0 and var_484_2 or var_484_2 * (utf8.len(var_484_3) / 15)) > 0 and var_484_2 < var_484_5 then
					arg_481_1.talkMaxDuration = var_484_5

					if var_484_5 + var_484_1 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + var_484_1
					end
				end

				arg_481_1.text_.text = var_484_3
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_6 = math.max(var_484_2, arg_481_1.talkMaxDuration)

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_6 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_1) / var_484_6

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_1 + var_484_6 and arg_481_1.time_ < var_484_1 + var_484_6 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play101902120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 101902120
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play101902121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 1.2

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(101902120).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 48 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 48)

				if (48 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 48)) > 0 and var_488_0 < var_488_3 then
					arg_485_1.talkMaxDuration = var_488_3

					if var_488_3 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_3 + 0
					end
				end

				arg_485_1.text_.text = var_488_1
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_4 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_4

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play101902121 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 101902121
		arg_489_1.duration_ = 6.07

		local var_489_0 = {
			ja = 6.066,
			ko = 3.733,
			en = 3.433
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play101902122(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1019ui_story"]) and arg_489_1.var_.characterEffect1019ui_story == nil then
				arg_489_1.var_.characterEffect1019ui_story = arg_489_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.2

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1019ui_story"]) then
				if arg_489_1.var_.characterEffect1019ui_story and not isNil(arg_489_1.actors_["1019ui_story"]) then
					arg_489_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1019ui_story"]) and arg_489_1.var_.characterEffect1019ui_story then
				arg_489_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_492_2 = 0
			local var_492_3 = 0.375

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_2 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_4 = arg_489_1:GetWordFromCfg(101902121)
				local var_492_5 = arg_489_1:FormatText(var_492_4.content)

				arg_489_1.text_.text = var_492_5

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_7 = 15 <= 0 and var_492_3 or var_492_3 * (utf8.len(var_492_5) / 15)

				if (15 <= 0 and var_492_3 or var_492_3 * (utf8.len(var_492_5) / 15)) > 0 and var_492_3 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_2 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_2
					end
				end

				arg_489_1.text_.text = var_492_5
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902121", "story_v_side_old_101902.awb") ~= 0 then
					local var_492_8 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902121", "story_v_side_old_101902.awb") / 1000

					if var_492_8 + var_492_2 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_8 + var_492_2
					end

					if var_492_4.prefab_name ~= "" and arg_489_1.actors_[var_492_4.prefab_name] ~= nil then
						local var_492_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_4.prefab_name].transform, "story_v_side_old_101902", "101902121", "story_v_side_old_101902.awb")

						arg_489_1:RecordAudio("101902121", var_492_9)
						arg_489_1:RecordAudio("101902121", var_492_9)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902121", "story_v_side_old_101902.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902121", "story_v_side_old_101902.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_10 = math.max(var_492_3, arg_489_1.talkMaxDuration)

			if var_492_2 <= arg_489_1.time_ and arg_489_1.time_ < var_492_2 + var_492_10 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_2) / var_492_10

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_2 + var_492_10 and arg_489_1.time_ < var_492_2 + var_492_10 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play101902122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 101902122
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play101902123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1019ui_story = arg_493_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1019ui_story"].transform.position).z)
				arg_493_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1019ui_story"].transform.localEulerAngles = arg_493_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1019ui_story"].transform.position).z)
				arg_493_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1019ui_story"].transform.localEulerAngles = arg_493_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_496_1 = 0
			local var_496_2 = 0.35

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_3 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(101902122).content)

				arg_493_1.text_.text = var_496_3

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_5 = 14 <= 0 and var_496_2 or var_496_2 * (utf8.len(var_496_3) / 14)

				if (14 <= 0 and var_496_2 or var_496_2 * (utf8.len(var_496_3) / 14)) > 0 and var_496_2 < var_496_5 then
					arg_493_1.talkMaxDuration = var_496_5

					if var_496_5 + var_496_1 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_5 + var_496_1
					end
				end

				arg_493_1.text_.text = var_496_3
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_6 = math.max(var_496_2, arg_493_1.talkMaxDuration)

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_6 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_1) / var_496_6

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_1 + var_496_6 and arg_493_1.time_ < var_496_1 + var_496_6 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play101902123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 101902123
		arg_497_1.duration_ = 3.93

		local var_497_0 = {
			ja = 3.933,
			ko = 2.5,
			en = 2.866
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play101902124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1039ui_story = arg_497_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_500_0 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				arg_497_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1039ui_story"].transform.position).z)
				arg_497_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1039ui_story"].transform.localEulerAngles = arg_497_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				arg_497_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -5.9)
				arg_497_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1039ui_story"].transform.position).z)
				arg_497_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1039ui_story"].transform.localEulerAngles = arg_497_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_500_1 = arg_497_1.actors_["1039ui_story"]

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1039ui_story == nil then
				arg_497_1.var_.characterEffect1039ui_story = var_500_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.2

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_2 and not isNil(var_500_1) then
				if arg_497_1.var_.characterEffect1039ui_story and not isNil(var_500_1) then
					arg_497_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_2 and arg_497_1.time_ < 0 + var_500_2 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1039ui_story then
				arg_497_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_500_4 = 0
			local var_500_5 = 0.15

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_4 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_6 = arg_497_1:GetWordFromCfg(101902123)
				local var_500_7 = arg_497_1:FormatText(var_500_6.content)

				arg_497_1.text_.text = var_500_7

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_9 = 6 <= 0 and var_500_5 or var_500_5 * (utf8.len(var_500_7) / 6)

				if (6 <= 0 and var_500_5 or var_500_5 * (utf8.len(var_500_7) / 6)) > 0 and var_500_5 < var_500_9 then
					arg_497_1.talkMaxDuration = var_500_9

					if var_500_9 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_4
					end
				end

				arg_497_1.text_.text = var_500_7
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902123", "story_v_side_old_101902.awb") ~= 0 then
					local var_500_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902123", "story_v_side_old_101902.awb") / 1000

					if var_500_10 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_10 + var_500_4
					end

					if var_500_6.prefab_name ~= "" and arg_497_1.actors_[var_500_6.prefab_name] ~= nil then
						local var_500_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_6.prefab_name].transform, "story_v_side_old_101902", "101902123", "story_v_side_old_101902.awb")

						arg_497_1:RecordAudio("101902123", var_500_11)
						arg_497_1:RecordAudio("101902123", var_500_11)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902123", "story_v_side_old_101902.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902123", "story_v_side_old_101902.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_12 = math.max(var_500_5, arg_497_1.talkMaxDuration)

			if var_500_4 <= arg_497_1.time_ and arg_497_1.time_ < var_500_4 + var_500_12 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_4) / var_500_12

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_4 + var_500_12 and arg_497_1.time_ < var_500_4 + var_500_12 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play101902124 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 101902124
		arg_501_1.duration_ = 2.3

		local var_501_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			en = 1.999999999999
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play101902125(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1019ui_story = arg_501_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_504_0 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 then
				arg_501_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_501_1.time_ - 0) / var_504_0)
				arg_501_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1019ui_story"].transform.position).z)
				arg_501_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1019ui_story"].transform.localEulerAngles = arg_501_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 then
				arg_501_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_501_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1019ui_story"].transform.position).z)
				arg_501_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1019ui_story"].transform.localEulerAngles = arg_501_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_504_1 = arg_501_1.actors_["1019ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1019ui_story == nil then
				arg_501_1.var_.characterEffect1019ui_story = var_504_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.2

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_2 and not isNil(var_504_1) then
				if arg_501_1.var_.characterEffect1019ui_story and not isNil(var_504_1) then
					arg_501_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_2 and arg_501_1.time_ < 0 + var_504_2 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1019ui_story then
				arg_501_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_504_4 = arg_501_1.actors_["1039ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_4) and arg_501_1.var_.characterEffect1039ui_story == nil then
				arg_501_1.var_.characterEffect1039ui_story = var_504_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_5 = 0.2

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_5 and not isNil(var_504_4) then
				if arg_501_1.var_.characterEffect1039ui_story and not isNil(var_504_4) then
					arg_501_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_5)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_5 and arg_501_1.time_ < 0 + var_504_5 + arg_504_0 and not isNil(var_504_4) and arg_501_1.var_.characterEffect1039ui_story then
				arg_501_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_504_6 = 0
			local var_504_7 = 0.125

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_6 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_8 = arg_501_1:GetWordFromCfg(101902124)
				local var_504_9 = arg_501_1:FormatText(var_504_8.content)

				arg_501_1.text_.text = var_504_9

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_11 = 5 <= 0 and var_504_7 or var_504_7 * (utf8.len(var_504_9) / 5)

				if (5 <= 0 and var_504_7 or var_504_7 * (utf8.len(var_504_9) / 5)) > 0 and var_504_7 < var_504_11 then
					arg_501_1.talkMaxDuration = var_504_11

					if var_504_11 + var_504_6 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_11 + var_504_6
					end
				end

				arg_501_1.text_.text = var_504_9
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902124", "story_v_side_old_101902.awb") ~= 0 then
					local var_504_12 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902124", "story_v_side_old_101902.awb") / 1000

					if var_504_12 + var_504_6 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_12 + var_504_6
					end

					if var_504_8.prefab_name ~= "" and arg_501_1.actors_[var_504_8.prefab_name] ~= nil then
						local var_504_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_8.prefab_name].transform, "story_v_side_old_101902", "101902124", "story_v_side_old_101902.awb")

						arg_501_1:RecordAudio("101902124", var_504_13)
						arg_501_1:RecordAudio("101902124", var_504_13)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902124", "story_v_side_old_101902.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902124", "story_v_side_old_101902.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_14 = math.max(var_504_7, arg_501_1.talkMaxDuration)

			if var_504_6 <= arg_501_1.time_ and arg_501_1.time_ < var_504_6 + var_504_14 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_6) / var_504_14

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_6 + var_504_14 and arg_501_1.time_ < var_504_6 + var_504_14 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play101902125 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 101902125
		arg_505_1.duration_ = 3.13

		local var_505_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			en = 1.999999999999
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play101902126(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1019ui_story"]) and arg_505_1.var_.characterEffect1019ui_story == nil then
				arg_505_1.var_.characterEffect1019ui_story = arg_505_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1019ui_story"]) then
				if arg_505_1.var_.characterEffect1019ui_story and not isNil(arg_505_1.actors_["1019ui_story"]) then
					arg_505_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_0)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1019ui_story"]) and arg_505_1.var_.characterEffect1019ui_story then
				arg_505_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_508_1 = arg_505_1.actors_["1039ui_story"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_1) and arg_505_1.var_.characterEffect1039ui_story == nil then
				arg_505_1.var_.characterEffect1039ui_story = var_508_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_2 and not isNil(var_508_1) then
				if arg_505_1.var_.characterEffect1039ui_story and not isNil(var_508_1) then
					arg_505_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_2 and arg_505_1.time_ < 0 + var_508_2 + arg_508_0 and not isNil(var_508_1) and arg_505_1.var_.characterEffect1039ui_story then
				arg_505_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_508_4 = 0
			local var_508_5 = 0.1

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_6 = arg_505_1:GetWordFromCfg(101902125)
				local var_508_7 = arg_505_1:FormatText(var_508_6.content)

				arg_505_1.text_.text = var_508_7

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_9 = 4 <= 0 and var_508_5 or var_508_5 * (utf8.len(var_508_7) / 4)

				if (4 <= 0 and var_508_5 or var_508_5 * (utf8.len(var_508_7) / 4)) > 0 and var_508_5 < var_508_9 then
					arg_505_1.talkMaxDuration = var_508_9

					if var_508_9 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_9 + var_508_4
					end
				end

				arg_505_1.text_.text = var_508_7
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_101902", "101902125", "story_v_side_old_101902.awb") ~= 0 then
					local var_508_10 = manager.audio:GetVoiceLength("story_v_side_old_101902", "101902125", "story_v_side_old_101902.awb") / 1000

					if var_508_10 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_10 + var_508_4
					end

					if var_508_6.prefab_name ~= "" and arg_505_1.actors_[var_508_6.prefab_name] ~= nil then
						local var_508_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_6.prefab_name].transform, "story_v_side_old_101902", "101902125", "story_v_side_old_101902.awb")

						arg_505_1:RecordAudio("101902125", var_508_11)
						arg_505_1:RecordAudio("101902125", var_508_11)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_old_101902", "101902125", "story_v_side_old_101902.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_old_101902", "101902125", "story_v_side_old_101902.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_12 = math.max(var_508_5, arg_505_1.talkMaxDuration)

			if var_508_4 <= arg_505_1.time_ and arg_505_1.time_ < var_508_4 + var_508_12 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_4) / var_508_12

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_4 + var_508_12 and arg_505_1.time_ < var_508_4 + var_508_12 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play101902126 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 101902126
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play101902127(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["1039ui_story"]) and arg_509_1.var_.characterEffect1039ui_story == nil then
				arg_509_1.var_.characterEffect1039ui_story = arg_509_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_0 = 0.2

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["1039ui_story"]) then
				if arg_509_1.var_.characterEffect1039ui_story and not isNil(arg_509_1.actors_["1039ui_story"]) then
					arg_509_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_509_1.time_ - 0) / var_512_0)
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["1039ui_story"]) and arg_509_1.var_.characterEffect1039ui_story then
				arg_509_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_512_1 = 0
			local var_512_2 = 0.675

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_3 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(101902126).content)

				arg_509_1.text_.text = var_512_3

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_5 = 27 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 27)

				if (27 <= 0 and var_512_2 or var_512_2 * (utf8.len(var_512_3) / 27)) > 0 and var_512_2 < var_512_5 then
					arg_509_1.talkMaxDuration = var_512_5

					if var_512_5 + var_512_1 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + var_512_1
					end
				end

				arg_509_1.text_.text = var_512_3
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_6 = math.max(var_512_2, arg_509_1.talkMaxDuration)

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_6 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_1) / var_512_6

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_1 + var_512_6 and arg_509_1.time_ < var_512_1 + var_512_6 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play101902127 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 101902127
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play101902128(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.575

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(101902127).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 23 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 23)

				if (23 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 23)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play101902128 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 101902128
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play101902129(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.var_.moveOldPos1039ui_story = arg_517_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_520_0 = 0.001

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 then
				arg_517_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_517_1.time_ - 0) / var_520_0)
				arg_517_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1039ui_story"].transform.position).z)
				arg_517_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1039ui_story"].transform.localEulerAngles = arg_517_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 then
				arg_517_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_517_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1039ui_story"].transform.position).z)
				arg_517_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1039ui_story"].transform.localEulerAngles = arg_517_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_520_1 = arg_517_1.actors_["1019ui_story"].transform

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.var_.moveOldPos1019ui_story = var_520_1.localPosition
			end

			local var_520_2 = 0.001

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_2 then
				var_520_1.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_517_1.time_ - 0) / var_520_2)
				var_520_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_520_1.position).x, (manager.ui.mainCamera.transform.position - var_520_1.position).y, (manager.ui.mainCamera.transform.position - var_520_1.position).z)
				var_520_1.localEulerAngles.z = 0
				var_520_1.localEulerAngles.x = 0
				var_520_1.localEulerAngles = var_520_1.localEulerAngles
			end

			if arg_517_1.time_ >= 0 + var_520_2 and arg_517_1.time_ < 0 + var_520_2 + arg_520_0 then
				var_520_1.localPosition = Vector3.New(0, 100, 0)
				var_520_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_520_1.position).x, (manager.ui.mainCamera.transform.position - var_520_1.position).y, (manager.ui.mainCamera.transform.position - var_520_1.position).z)
				var_520_1.localEulerAngles.z = 0
				var_520_1.localEulerAngles.x = 0
				var_520_1.localEulerAngles = var_520_1.localEulerAngles
			end

			local var_520_3 = 0
			local var_520_4 = 0.95

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_3 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_5 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(101902128).content)

				arg_517_1.text_.text = var_520_5

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_7 = 38 <= 0 and var_520_4 or var_520_4 * (utf8.len(var_520_5) / 38)

				if (38 <= 0 and var_520_4 or var_520_4 * (utf8.len(var_520_5) / 38)) > 0 and var_520_4 < var_520_7 then
					arg_517_1.talkMaxDuration = var_520_7

					if var_520_7 + var_520_3 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_7 + var_520_3
					end
				end

				arg_517_1.text_.text = var_520_5
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_8 = math.max(var_520_4, arg_517_1.talkMaxDuration)

			if var_520_3 <= arg_517_1.time_ and arg_517_1.time_ < var_520_3 + var_520_8 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_3) / var_520_8

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_3 + var_520_8 and arg_517_1.time_ < var_520_3 + var_520_8 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play101902129 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 101902129
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
			arg_521_1.auto_ = false
		end

		function arg_521_1.playNext_(arg_523_0)
			arg_521_1.onStoryFinished_()
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.875

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(101902129).content)

				arg_521_1.text_.text = var_524_1

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_3 = 35 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 35)

				if (35 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 35)) > 0 and var_524_0 < var_524_3 then
					arg_521_1.talkMaxDuration = var_524_3

					if var_524_3 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_3 + 0
					end
				end

				arg_521_1.text_.text = var_524_1
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_4 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_4 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_4

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_4 and arg_521_1.time_ < 0 + var_524_4 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play101902059 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 101902059
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play101902060(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0
			local var_528_1 = 1.4

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_2 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_2:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, true)
				arg_525_1.iconController_:SetSelectedState("hero")

				arg_525_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_525_1.callingController_:SetSelectedState("normal")

				arg_525_1.keyicon_.color = Color.New(1, 1, 1)
				arg_525_1.icon_.color = Color.New(1, 1, 1)

				local var_528_3 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(101902059).content)

				arg_525_1.text_.text = var_528_3

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_5 = 56 <= 0 and var_528_1 or var_528_1 * (utf8.len(var_528_3) / 56)

				if (56 <= 0 and var_528_1 or var_528_1 * (utf8.len(var_528_3) / 56)) > 0 and var_528_1 < var_528_5 then
					arg_525_1.talkMaxDuration = var_528_5
					var_528_0 = var_528_0 + 0.3

					if var_528_5 + var_528_0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_5 + var_528_0
					end
				end

				arg_525_1.text_.text = var_528_3
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_6 = var_528_0 + 0.3
			local var_528_7 = math.max(var_528_1, arg_525_1.talkMaxDuration)

			if var_528_0 + 0.3 <= arg_525_1.time_ and arg_525_1.time_ < var_528_6 + var_528_7 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_6) / var_528_7

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_6 + var_528_7 and arg_525_1.time_ < var_528_6 + var_528_7 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/ST07a"
	},
	voices = {
		"story_v_side_old_101902.awb"
	}
}
