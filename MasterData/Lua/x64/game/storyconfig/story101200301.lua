return {
	Play120031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_0 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_0 then
				local var_4_1 = Color.New(0, 0, 0)

				var_4_1.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - 0) / var_4_0)
				arg_1_1.mask_.color = var_4_1
			end

			if arg_1_1.time_ >= 0 + var_4_0 and arg_1_1.time_ < 0 + var_4_0 + arg_4_0 then
				local var_4_2 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_2.a = 0
				arg_1_1.mask_.color = var_4_2
			end

			local var_4_3 = "STblack"

			if arg_1_1.bgs_.STblack == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 1.999999999999
			local var_4_12 = 0.75

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(120031001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 30 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 30)

				if (30 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 30)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play120031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 120031002
		arg_8_1.duration_ = 7

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play120031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door", "")
			end

			local var_11_1 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_2 = 2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 then
				local var_11_3 = Color.New(0, 0, 0)

				var_11_3.a = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_1) / var_11_2)
				arg_8_1.mask_.color = var_11_3
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 then
				local var_11_4 = Color.New(0, 0, 0)

				arg_8_1.mask_.enabled = false
				var_11_4.a = 0
				arg_8_1.mask_.color = var_11_4
			end

			local var_11_5 = "J02f"

			if arg_8_1.bgs_.J02f == nil then
				local var_11_6 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_5)
				var_11_6.name = var_11_5
				var_11_6.transform.parent = arg_8_1.stage_.transform
				var_11_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_5] = var_11_6
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				local var_11_7 = arg_8_1.bgs_.J02f

				arg_8_1.bgs_.J02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_11_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_8 = var_11_7:GetComponent("SpriteRenderer")

				if var_11_8 and var_11_8.sprite then
					local var_11_9 = 2 * (var_11_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_11_7.transform.localScale = Vector3.New(var_11_9 / var_11_8.sprite.bounds.size.y < var_11_9 * manager.ui.mainCameraCom_.aspect / var_11_8.sprite.bounds.size.x and var_11_9 * manager.ui.mainCameraCom_.aspect / var_11_8.sprite.bounds.size.x or var_11_9 / var_11_8.sprite.bounds.size.y, var_11_9 / var_11_8.sprite.bounds.size.y < var_11_9 * manager.ui.mainCameraCom_.aspect / var_11_8.sprite.bounds.size.x and var_11_9 * manager.ui.mainCameraCom_.aspect / var_11_8.sprite.bounds.size.x or var_11_9 / var_11_8.sprite.bounds.size.y, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "J02f" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_10 = 2
			local var_11_11 = 0.8

			if 2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_12 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_12:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_8_1.dialogCg_.alpha = arg_12_0
				end))
				var_11_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_13 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(120031002).content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 32 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 32)

				if (32 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 32)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15
					var_11_10 = var_11_10 + 0.3

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = var_11_10 + 0.3
			local var_11_17 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 + 0.3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_16) / var_11_17

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play120031003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 120031003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play120031004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.1

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_1 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(120031003).content)

				arg_14_1.text_.text = var_17_1

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_3 = 4 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 4)

				if (4 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_1) / 4)) > 0 and var_17_0 < var_17_3 then
					arg_14_1.talkMaxDuration = var_17_3

					if var_17_3 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_3 + 0
					end
				end

				arg_14_1.text_.text = var_17_1
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_4 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_4 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_4

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_4 and arg_14_1.time_ < 0 + var_17_4 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play120031004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 120031004
		arg_18_1.duration_ = 11.57

		local var_18_0 = {
			zh = 9.233,
			ja = 11.566
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play120031005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if arg_18_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_21_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_18_1.stage_.transform)

				var_21_0.name = "1075ui_story"
				var_21_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.actors_["1075ui_story"] = var_21_0

				local var_21_1 = var_21_0:GetComponentInChildren(typeof(CharacterEffect))

				var_21_1.enabled = true

				local var_21_2 = GameObjectTools.GetOrAddComponent(var_21_0, typeof(DynamicBoneHelper))

				if var_21_2 then
					var_21_2:EnableDynamicBone(false)
				end

				arg_18_1:ShowWeapon(var_21_1.transform, false)

				arg_18_1.var_["1075ui_story" .. "Animator"] = var_21_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_18_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_18_1.var_["1075ui_story" .. "LipSync"] = var_21_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_21_3 = arg_18_1.actors_["1075ui_story"].transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPos1075ui_story = var_21_3.localPosition
			end

			local var_21_4 = 0.001

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_4 then
				var_21_3.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_18_1.time_ - 0) / var_21_4)
				var_21_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_3.position).x, (manager.ui.mainCamera.transform.position - var_21_3.position).y, (manager.ui.mainCamera.transform.position - var_21_3.position).z)
				var_21_3.localEulerAngles.z = 0
				var_21_3.localEulerAngles.x = 0
				var_21_3.localEulerAngles = var_21_3.localEulerAngles
			end

			if arg_18_1.time_ >= 0 + var_21_4 and arg_18_1.time_ < 0 + var_21_4 + arg_21_0 then
				var_21_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_21_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_21_3.position).x, (manager.ui.mainCamera.transform.position - var_21_3.position).y, (manager.ui.mainCamera.transform.position - var_21_3.position).z)
				var_21_3.localEulerAngles.z = 0
				var_21_3.localEulerAngles.x = 0
				var_21_3.localEulerAngles = var_21_3.localEulerAngles
			end

			local var_21_5 = arg_18_1.actors_["1075ui_story"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_5) and arg_18_1.var_.characterEffect1075ui_story == nil then
				arg_18_1.var_.characterEffect1075ui_story = var_21_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_6 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_6 and not isNil(var_21_5) then
				if arg_18_1.var_.characterEffect1075ui_story and not isNil(var_21_5) then
					arg_18_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_6 and arg_18_1.time_ < 0 + var_21_6 + arg_21_0 and not isNil(var_21_5) and arg_18_1.var_.characterEffect1075ui_story then
				arg_18_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_21_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_10 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_10

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_10
						arg_18_1.bgmTxt2_.text = var_21_10
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_18_1.time_ and arg_18_1.time_ <= 0.3 + arg_21_0 then
				arg_18_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_21_13 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if "" ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_13 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_13

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_13
						arg_18_1.bgmTxt2_.text = var_21_13
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_21_14 = 0
			local var_21_15 = 0.85

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_14 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_16 = arg_18_1:GetWordFromCfg(120031004)
				local var_21_17 = arg_18_1:FormatText(var_21_16.content)

				arg_18_1.text_.text = var_21_17

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_19 = 34 <= 0 and var_21_15 or var_21_15 * (utf8.len(var_21_17) / 34)

				if (34 <= 0 and var_21_15 or var_21_15 * (utf8.len(var_21_17) / 34)) > 0 and var_21_15 < var_21_19 then
					arg_18_1.talkMaxDuration = var_21_19

					if var_21_19 + var_21_14 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_19 + var_21_14
					end
				end

				arg_18_1.text_.text = var_21_17
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031004", "story_v_out_120031.awb") ~= 0 then
					local var_21_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031004", "story_v_out_120031.awb") / 1000

					if var_21_20 + var_21_14 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_20 + var_21_14
					end

					if var_21_16.prefab_name ~= "" and arg_18_1.actors_[var_21_16.prefab_name] ~= nil then
						local var_21_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_16.prefab_name].transform, "story_v_out_120031", "120031004", "story_v_out_120031.awb")

						arg_18_1:RecordAudio("120031004", var_21_21)
						arg_18_1:RecordAudio("120031004", var_21_21)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_120031", "120031004", "story_v_out_120031.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_120031", "120031004", "story_v_out_120031.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_22 = math.max(var_21_15, arg_18_1.talkMaxDuration)

			if var_21_14 <= arg_18_1.time_ and arg_18_1.time_ < var_21_14 + var_21_22 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_14) / var_21_22

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_14 + var_21_22 and arg_18_1.time_ < var_21_14 + var_21_22 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play120031005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 120031005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play120031006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1075ui_story = arg_24_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_27_0 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				arg_24_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1075ui_story"].transform.position).z)
				arg_24_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1075ui_story"].transform.localEulerAngles = arg_24_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				arg_24_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1075ui_story"].transform.position).z)
				arg_24_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1075ui_story"].transform.localEulerAngles = arg_24_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_27_1 = 0
			local var_27_2 = 0.75

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(120031005).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 30 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 30)

				if (30 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 30)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play120031006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 120031006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play120031007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 1.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(120031006).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 55 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 55)

				if (55 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 55)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play120031007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 120031007
		arg_32_1.duration_ = 4.03

		local var_32_0 = {
			zh = 1.999999999999,
			ja = 4.033
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
				arg_32_0:Play120031008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "1084ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1084ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["1084ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["1084ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["1084ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_32_1.time_ - 0) / var_35_4)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			local var_35_5 = arg_32_1.actors_["1084ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.2

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_35_8 = arg_32_1.actors_["1075ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1075ui_story = var_35_8.localPosition
			end

			local var_35_9 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_32_1.time_ - 0) / var_35_9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			local var_35_10 = arg_32_1.actors_["1075ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1075ui_story == nil then
				arg_32_1.var_.characterEffect1075ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.0166666666666667

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 and not isNil(var_35_10) then
				if arg_32_1.var_.characterEffect1075ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_11)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1075ui_story then
				arg_32_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_12 = 0
			local var_35_13 = 0.15

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:GetWordFromCfg(120031007)
				local var_35_15 = arg_32_1:FormatText(var_35_14.content)

				arg_32_1.text_.text = var_35_15

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_17 = 6 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 6)

				if (6 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_15) / 6)) > 0 and var_35_13 < var_35_17 then
					arg_32_1.talkMaxDuration = var_35_17

					if var_35_17 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_17 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_15
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031007", "story_v_out_120031.awb") ~= 0 then
					local var_35_18 = manager.audio:GetVoiceLength("story_v_out_120031", "120031007", "story_v_out_120031.awb") / 1000

					if var_35_18 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_18 + var_35_12
					end

					if var_35_14.prefab_name ~= "" and arg_32_1.actors_[var_35_14.prefab_name] ~= nil then
						local var_35_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_14.prefab_name].transform, "story_v_out_120031", "120031007", "story_v_out_120031.awb")

						arg_32_1:RecordAudio("120031007", var_35_19)
						arg_32_1:RecordAudio("120031007", var_35_19)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_120031", "120031007", "story_v_out_120031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_120031", "120031007", "story_v_out_120031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_20 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_20 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_20

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_20 and arg_32_1.time_ < var_35_12 + var_35_20 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play120031008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 120031008
		arg_36_1.duration_ = 10.1

		local var_36_0 = {
			zh = 10.1,
			ja = 9.933
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
				arg_36_0:Play120031009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1075ui_story"]) and arg_36_1.var_.characterEffect1075ui_story == nil then
				arg_36_1.var_.characterEffect1075ui_story = arg_36_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1075ui_story"]) then
				if arg_36_1.var_.characterEffect1075ui_story and not isNil(arg_36_1.actors_["1075ui_story"]) then
					arg_36_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1075ui_story"]) and arg_36_1.var_.characterEffect1075ui_story then
				arg_36_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1084ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_39_4 = 0
			local var_39_5 = 1.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(120031008)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 44 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 44)

				if (44 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 44)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031008", "story_v_out_120031.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031008", "story_v_out_120031.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_120031", "120031008", "story_v_out_120031.awb")

						arg_36_1:RecordAudio("120031008", var_39_11)
						arg_36_1:RecordAudio("120031008", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_120031", "120031008", "story_v_out_120031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_120031", "120031008", "story_v_out_120031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play120031009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 120031009
		arg_40_1.duration_ = 3.5

		local var_40_0 = {
			zh = 1.999999999999,
			ja = 3.5
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
				arg_40_0:Play120031010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = arg_40_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(arg_40_1.actors_["1084ui_story"]) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1075ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1075ui_story == nil then
				arg_40_1.var_.characterEffect1075ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1075ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1075ui_story then
				arg_40_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_43_4 = 0
			local var_43_5 = 0.2

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(120031009)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 8 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 8)

				if (8 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 8)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031009", "story_v_out_120031.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031009", "story_v_out_120031.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_120031", "120031009", "story_v_out_120031.awb")

						arg_40_1:RecordAudio("120031009", var_43_11)
						arg_40_1:RecordAudio("120031009", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_120031", "120031009", "story_v_out_120031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_120031", "120031009", "story_v_out_120031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play120031010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 120031010
		arg_44_1.duration_ = 9.7

		local var_44_0 = {
			zh = 9.7,
			ja = 6.466
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
				arg_44_0:Play120031011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1075ui_story"]) and arg_44_1.var_.characterEffect1075ui_story == nil then
				arg_44_1.var_.characterEffect1075ui_story = arg_44_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1075ui_story"]) then
				if arg_44_1.var_.characterEffect1075ui_story and not isNil(arg_44_1.actors_["1075ui_story"]) then
					arg_44_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1075ui_story"]) and arg_44_1.var_.characterEffect1075ui_story then
				arg_44_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1084ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_47_4 = 0
			local var_47_5 = 0.975

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(120031010)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 39 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 39)

				if (39 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 39)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031010", "story_v_out_120031.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031010", "story_v_out_120031.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_120031", "120031010", "story_v_out_120031.awb")

						arg_44_1:RecordAudio("120031010", var_47_11)
						arg_44_1:RecordAudio("120031010", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_120031", "120031010", "story_v_out_120031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_120031", "120031010", "story_v_out_120031.awb")
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
	Play120031011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 120031011
		arg_48_1.duration_ = 8.13

		local var_48_0 = {
			zh = 7.266,
			ja = 8.133
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
				arg_48_0:Play120031012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = arg_48_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_51_0 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 then
				arg_48_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_0)
				arg_48_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).z)
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles = arg_48_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 then
				arg_48_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_48_1.actors_["1084ui_story"].transform.position).z)
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_48_1.actors_["1084ui_story"].transform.localEulerAngles = arg_48_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_51_1 = "1069ui_story"

			if arg_48_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_51_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_48_1.stage_.transform)

				var_51_2.name = var_51_1
				var_51_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_[var_51_1] = var_51_2

				local var_51_3 = var_51_2:GetComponentInChildren(typeof(CharacterEffect))

				var_51_3.enabled = true

				local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_2, typeof(DynamicBoneHelper))

				if var_51_4 then
					var_51_4:EnableDynamicBone(false)
				end

				arg_48_1:ShowWeapon(var_51_3.transform, false)

				arg_48_1.var_[var_51_1 .. "Animator"] = var_51_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_48_1.var_[var_51_1 .. "Animator"].applyRootMotion = true
				arg_48_1.var_[var_51_1 .. "LipSync"] = var_51_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_51_5 = arg_48_1.actors_["1069ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1069ui_story = var_51_5.localPosition
			end

			local var_51_6 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_6 then
				var_51_5.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_48_1.time_ - 0) / var_51_6)
				var_51_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_5.position).x, (manager.ui.mainCamera.transform.position - var_51_5.position).y, (manager.ui.mainCamera.transform.position - var_51_5.position).z)
				var_51_5.localEulerAngles.z = 0
				var_51_5.localEulerAngles.x = 0
				var_51_5.localEulerAngles = var_51_5.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_6 and arg_48_1.time_ < 0 + var_51_6 + arg_51_0 then
				var_51_5.localPosition = Vector3.New(-0.7, -1, -6)
				var_51_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_5.position).x, (manager.ui.mainCamera.transform.position - var_51_5.position).y, (manager.ui.mainCamera.transform.position - var_51_5.position).z)
				var_51_5.localEulerAngles.z = 0
				var_51_5.localEulerAngles.x = 0
				var_51_5.localEulerAngles = var_51_5.localEulerAngles
			end

			local var_51_7 = arg_48_1.actors_["1069ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_7) and arg_48_1.var_.characterEffect1069ui_story == nil then
				arg_48_1.var_.characterEffect1069ui_story = var_51_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_8 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_8 and not isNil(var_51_7) then
				if arg_48_1.var_.characterEffect1069ui_story and not isNil(var_51_7) then
					arg_48_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_8 and arg_48_1.time_ < 0 + var_51_8 + arg_51_0 and not isNil(var_51_7) and arg_48_1.var_.characterEffect1069ui_story then
				arg_48_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_51_10 = arg_48_1.actors_["1075ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_10) and arg_48_1.var_.characterEffect1075ui_story == nil then
				arg_48_1.var_.characterEffect1075ui_story = var_51_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_11 and not isNil(var_51_10) then
				if arg_48_1.var_.characterEffect1075ui_story and not isNil(var_51_10) then
					arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_11)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_11 and arg_48_1.time_ < 0 + var_51_11 + arg_51_0 and not isNil(var_51_10) and arg_48_1.var_.characterEffect1075ui_story then
				arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_51_12 = 0
			local var_51_13 = 0.725

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_14 = arg_48_1:GetWordFromCfg(120031011)
				local var_51_15 = arg_48_1:FormatText(var_51_14.content)

				arg_48_1.text_.text = var_51_15

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 29 <= 0 and var_51_13 or var_51_13 * (utf8.len(var_51_15) / 29)

				if (29 <= 0 and var_51_13 or var_51_13 * (utf8.len(var_51_15) / 29)) > 0 and var_51_13 < var_51_17 then
					arg_48_1.talkMaxDuration = var_51_17

					if var_51_17 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_17 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_15
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031011", "story_v_out_120031.awb") ~= 0 then
					local var_51_18 = manager.audio:GetVoiceLength("story_v_out_120031", "120031011", "story_v_out_120031.awb") / 1000

					if var_51_18 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_12
					end

					if var_51_14.prefab_name ~= "" and arg_48_1.actors_[var_51_14.prefab_name] ~= nil then
						local var_51_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_14.prefab_name].transform, "story_v_out_120031", "120031011", "story_v_out_120031.awb")

						arg_48_1:RecordAudio("120031011", var_51_19)
						arg_48_1:RecordAudio("120031011", var_51_19)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_120031", "120031011", "story_v_out_120031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_120031", "120031011", "story_v_out_120031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_20 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_20 and arg_48_1.time_ < var_51_12 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play120031012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 120031012
		arg_52_1.duration_ = 3.6

		local var_52_0 = {
			zh = 1.999999999999,
			ja = 3.6
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
				arg_52_0:Play120031013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1075ui_story = arg_52_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1075ui_story"].transform.position).z)
				arg_52_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1075ui_story"].transform.localEulerAngles = arg_52_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1075ui_story"].transform.position).z)
				arg_52_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1075ui_story"].transform.localEulerAngles = arg_52_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_55_1 = "10044ui_story"

			if arg_52_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_55_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_52_1.stage_.transform)

				var_55_2.name = var_55_1
				var_55_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_[var_55_1] = var_55_2

				local var_55_3 = var_55_2:GetComponentInChildren(typeof(CharacterEffect))

				var_55_3.enabled = true

				local var_55_4 = GameObjectTools.GetOrAddComponent(var_55_2, typeof(DynamicBoneHelper))

				if var_55_4 then
					var_55_4:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_3.transform, false)

				arg_52_1.var_[var_55_1 .. "Animator"] = var_55_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_[var_55_1 .. "Animator"].applyRootMotion = true
				arg_52_1.var_[var_55_1 .. "LipSync"] = var_55_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_5 = arg_52_1.actors_["10044ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10044ui_story = var_55_5.localPosition
			end

			local var_55_6 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_6 then
				var_55_5.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_52_1.time_ - 0) / var_55_6)
				var_55_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_5.position).x, (manager.ui.mainCamera.transform.position - var_55_5.position).y, (manager.ui.mainCamera.transform.position - var_55_5.position).z)
				var_55_5.localEulerAngles.z = 0
				var_55_5.localEulerAngles.x = 0
				var_55_5.localEulerAngles = var_55_5.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_6 and arg_52_1.time_ < 0 + var_55_6 + arg_55_0 then
				var_55_5.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_55_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_5.position).x, (manager.ui.mainCamera.transform.position - var_55_5.position).y, (manager.ui.mainCamera.transform.position - var_55_5.position).z)
				var_55_5.localEulerAngles.z = 0
				var_55_5.localEulerAngles.x = 0
				var_55_5.localEulerAngles = var_55_5.localEulerAngles
			end

			local var_55_7 = arg_52_1.actors_["10044ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_7) and arg_52_1.var_.characterEffect10044ui_story == nil then
				arg_52_1.var_.characterEffect10044ui_story = var_55_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_8 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_8 and not isNil(var_55_7) then
				if arg_52_1.var_.characterEffect10044ui_story and not isNil(var_55_7) then
					arg_52_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_8 and arg_52_1.time_ < 0 + var_55_8 + arg_55_0 and not isNil(var_55_7) and arg_52_1.var_.characterEffect10044ui_story then
				arg_52_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_55_10 = arg_52_1.actors_["1069ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_10) and arg_52_1.var_.characterEffect1069ui_story == nil then
				arg_52_1.var_.characterEffect1069ui_story = var_55_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_11 and not isNil(var_55_10) then
				if arg_52_1.var_.characterEffect1069ui_story and not isNil(var_55_10) then
					arg_52_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_11)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_11 and arg_52_1.time_ < 0 + var_55_11 + arg_55_0 and not isNil(var_55_10) and arg_52_1.var_.characterEffect1069ui_story then
				arg_52_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_12 = 0
			local var_55_13 = 0.125

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_12 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_14 = arg_52_1:GetWordFromCfg(120031012)
				local var_55_15 = arg_52_1:FormatText(var_55_14.content)

				arg_52_1.text_.text = var_55_15

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_17 = 5 <= 0 and var_55_13 or var_55_13 * (utf8.len(var_55_15) / 5)

				if (5 <= 0 and var_55_13 or var_55_13 * (utf8.len(var_55_15) / 5)) > 0 and var_55_13 < var_55_17 then
					arg_52_1.talkMaxDuration = var_55_17

					if var_55_17 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_17 + var_55_12
					end
				end

				arg_52_1.text_.text = var_55_15
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031012", "story_v_out_120031.awb") ~= 0 then
					local var_55_18 = manager.audio:GetVoiceLength("story_v_out_120031", "120031012", "story_v_out_120031.awb") / 1000

					if var_55_18 + var_55_12 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_18 + var_55_12
					end

					if var_55_14.prefab_name ~= "" and arg_52_1.actors_[var_55_14.prefab_name] ~= nil then
						local var_55_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_14.prefab_name].transform, "story_v_out_120031", "120031012", "story_v_out_120031.awb")

						arg_52_1:RecordAudio("120031012", var_55_19)
						arg_52_1:RecordAudio("120031012", var_55_19)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_120031", "120031012", "story_v_out_120031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_120031", "120031012", "story_v_out_120031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_20 = math.max(var_55_13, arg_52_1.talkMaxDuration)

			if var_55_12 <= arg_52_1.time_ and arg_52_1.time_ < var_55_12 + var_55_20 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_12) / var_55_20

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_12 + var_55_20 and arg_52_1.time_ < var_55_12 + var_55_20 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play120031013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 120031013
		arg_56_1.duration_ = 4

		local var_56_0 = {
			zh = 4,
			ja = 3.266
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
				arg_56_0:Play120031014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1069ui_story"]) and arg_56_1.var_.characterEffect1069ui_story == nil then
				arg_56_1.var_.characterEffect1069ui_story = arg_56_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1069ui_story"]) then
				if arg_56_1.var_.characterEffect1069ui_story and not isNil(arg_56_1.actors_["1069ui_story"]) then
					arg_56_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1069ui_story"]) and arg_56_1.var_.characterEffect1069ui_story then
				arg_56_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["10044ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect10044ui_story == nil then
				arg_56_1.var_.characterEffect10044ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect10044ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect10044ui_story then
				arg_56_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action445")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_59_4 = 0
			local var_59_5 = 0.375

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(120031013)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 15 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 15)

				if (15 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 15)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031013", "story_v_out_120031.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031013", "story_v_out_120031.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_120031", "120031013", "story_v_out_120031.awb")

						arg_56_1:RecordAudio("120031013", var_59_11)
						arg_56_1:RecordAudio("120031013", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_120031", "120031013", "story_v_out_120031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_120031", "120031013", "story_v_out_120031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play120031014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 120031014
		arg_60_1.duration_ = 3.57

		local var_60_0 = {
			zh = 1.999999999999,
			ja = 3.566
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
				arg_60_0:Play120031015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10044ui_story"]) and arg_60_1.var_.characterEffect10044ui_story == nil then
				arg_60_1.var_.characterEffect10044ui_story = arg_60_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10044ui_story"]) then
				if arg_60_1.var_.characterEffect10044ui_story and not isNil(arg_60_1.actors_["10044ui_story"]) then
					arg_60_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10044ui_story"]) and arg_60_1.var_.characterEffect10044ui_story then
				arg_60_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1069ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1069ui_story == nil then
				arg_60_1.var_.characterEffect1069ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.2

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1069ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1069ui_story then
				arg_60_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action452")
			end

			local var_63_4 = 0
			local var_63_5 = 0.225

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(120031014)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 9 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 9)

				if (9 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 9)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031014", "story_v_out_120031.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031014", "story_v_out_120031.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_120031", "120031014", "story_v_out_120031.awb")

						arg_60_1:RecordAudio("120031014", var_63_11)
						arg_60_1:RecordAudio("120031014", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_120031", "120031014", "story_v_out_120031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_120031", "120031014", "story_v_out_120031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play120031015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 120031015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play120031016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1069ui_story = arg_64_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1069ui_story"].transform.position).z)
				arg_64_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1069ui_story"].transform.localEulerAngles = arg_64_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1069ui_story"].transform.position).z)
				arg_64_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1069ui_story"].transform.localEulerAngles = arg_64_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["10044ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10044ui_story = var_67_1.localPosition
			end

			local var_67_2 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 then
				var_67_1.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_2)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 then
				var_67_1.localPosition = Vector3.New(0, 100, 0)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			local var_67_3 = 0
			local var_67_4 = 0.95

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_5 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(120031015).content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 38 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 38)

				if (38 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 38)) > 0 and var_67_4 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_3
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_4, arg_64_1.talkMaxDuration)

			if var_67_3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_3 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_3) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_3 + var_67_8 and arg_64_1.time_ < var_67_3 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play120031016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 120031016
		arg_68_1.duration_ = 2.57

		local var_68_0 = {
			zh = 2.566,
			ja = 2
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
				arg_68_0:Play120031017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = arg_68_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).z)
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles = arg_68_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_68_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1084ui_story"].transform.position).z)
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1084ui_story"].transform.localEulerAngles = arg_68_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_71_1 = arg_68_1.actors_["1084ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 and not isNil(var_71_1) then
				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_1) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_71_4 = 0
			local var_71_5 = 0.275

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(120031016)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 11 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 11)

				if (11 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 11)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031016", "story_v_out_120031.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031016", "story_v_out_120031.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_120031", "120031016", "story_v_out_120031.awb")

						arg_68_1:RecordAudio("120031016", var_71_11)
						arg_68_1:RecordAudio("120031016", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_120031", "120031016", "story_v_out_120031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_120031", "120031016", "story_v_out_120031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play120031017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 120031017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play120031018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = arg_72_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(arg_72_1.actors_["1084ui_story"]) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.4

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(120031017).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 16 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 16)

				if (16 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 16)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play120031018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 120031018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play120031019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.125

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(120031018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 45 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 45)

				if (45 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 45)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play120031019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 120031019
		arg_80_1.duration_ = 4.7

		local var_80_0 = {
			zh = 3.633,
			ja = 4.7
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
				arg_80_0:Play120031020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1069ui_story = arg_80_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1069ui_story, Vector3.New(0.7, -1, -6), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1069ui_story"].transform.position).z)
				arg_80_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1069ui_story"].transform.localEulerAngles = arg_80_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0.7, -1, -6)
				arg_80_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1069ui_story"].transform.position).z)
				arg_80_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1069ui_story"].transform.localEulerAngles = arg_80_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1069ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1069ui_story == nil then
				arg_80_1.var_.characterEffect1069ui_story = var_83_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 and not isNil(var_83_1) then
				if arg_80_1.var_.characterEffect1069ui_story and not isNil(var_83_1) then
					arg_80_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 and not isNil(var_83_1) and arg_80_1.var_.characterEffect1069ui_story then
				arg_80_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_83_4 = arg_80_1.actors_["1084ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_4.localPosition
			end

			local var_83_5 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_5 then
				var_83_4.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_80_1.time_ - 0) / var_83_5)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_5 and arg_80_1.time_ < 0 + var_83_5 + arg_83_0 then
				var_83_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_83_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_4.position).x, (manager.ui.mainCamera.transform.position - var_83_4.position).y, (manager.ui.mainCamera.transform.position - var_83_4.position).z)
				var_83_4.localEulerAngles.z = 0
				var_83_4.localEulerAngles.x = 0
				var_83_4.localEulerAngles = var_83_4.localEulerAngles
			end

			local var_83_6 = arg_80_1.actors_["1084ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_7 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 and not isNil(var_83_6) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_6) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_7)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_83_8 = 0
			local var_83_9 = 0.45

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_10 = arg_80_1:GetWordFromCfg(120031019)
				local var_83_11 = arg_80_1:FormatText(var_83_10.content)

				arg_80_1.text_.text = var_83_11

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 18 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 18)

				if (18 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 18)) > 0 and var_83_9 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_11
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031019", "story_v_out_120031.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031019", "story_v_out_120031.awb") / 1000

					if var_83_14 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_8
					end

					if var_83_10.prefab_name ~= "" and arg_80_1.actors_[var_83_10.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_10.prefab_name].transform, "story_v_out_120031", "120031019", "story_v_out_120031.awb")

						arg_80_1:RecordAudio("120031019", var_83_15)
						arg_80_1:RecordAudio("120031019", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_120031", "120031019", "story_v_out_120031.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_120031", "120031019", "story_v_out_120031.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_8) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_8 + var_83_16 and arg_80_1.time_ < var_83_8 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play120031020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 120031020
		arg_84_1.duration_ = 6.1

		local var_84_0 = {
			zh = 4.8,
			ja = 6.1
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
				arg_84_0:Play120031021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1069ui_story"]) and arg_84_1.var_.characterEffect1069ui_story == nil then
				arg_84_1.var_.characterEffect1069ui_story = arg_84_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1069ui_story"]) then
				if arg_84_1.var_.characterEffect1069ui_story and not isNil(arg_84_1.actors_["1069ui_story"]) then
					arg_84_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1069ui_story"]) and arg_84_1.var_.characterEffect1069ui_story then
				arg_84_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_87_2 = 0
			local var_87_3 = 0.7

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(120031020)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 28 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 28)

				if (28 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 28)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031020", "story_v_out_120031.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031020", "story_v_out_120031.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_120031", "120031020", "story_v_out_120031.awb")

						arg_84_1:RecordAudio("120031020", var_87_9)
						arg_84_1:RecordAudio("120031020", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_120031", "120031020", "story_v_out_120031.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_120031", "120031020", "story_v_out_120031.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play120031021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 120031021
		arg_88_1.duration_ = 9

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play120031022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if arg_88_1.bgs_.J02h == nil then
				local var_91_0 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J02h")
				var_91_0.name = "J02h"
				var_91_0.transform.parent = arg_88_1.stage_.transform
				var_91_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_.J02h = var_91_0
			end

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= 2 + arg_91_0 then
				local var_91_1 = arg_88_1.bgs_.J02h

				arg_88_1.bgs_.J02h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_2 = var_91_1:GetComponent("SpriteRenderer")

				if var_91_2 and var_91_2.sprite then
					local var_91_3 = 2 * (var_91_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_1.transform.localScale = Vector3.New(var_91_3 / var_91_2.sprite.bounds.size.y < var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x and var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x or var_91_3 / var_91_2.sprite.bounds.size.y, var_91_3 / var_91_2.sprite.bounds.size.y < var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x and var_91_3 * manager.ui.mainCameraCom_.aspect / var_91_2.sprite.bounds.size.x or var_91_3 / var_91_2.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "J02h" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_4 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_5 = 2

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_5 then
				local var_91_6 = Color.New(0, 0, 0)

				var_91_6.a = Mathf.Lerp(0, 1, (arg_88_1.time_ - var_91_4) / var_91_5)
				arg_88_1.mask_.color = var_91_6
			end

			if arg_88_1.time_ >= var_91_4 + var_91_5 and arg_88_1.time_ < var_91_4 + var_91_5 + arg_91_0 then
				local var_91_7 = Color.New(0, 0, 0)

				var_91_7.a = 1
				arg_88_1.mask_.color = var_91_7
			end

			local var_91_8 = 2

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_9 = 2

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_9 then
				local var_91_10 = Color.New(0, 0, 0)

				var_91_10.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_8) / var_91_9)
				arg_88_1.mask_.color = var_91_10
			end

			if arg_88_1.time_ >= var_91_8 + var_91_9 and arg_88_1.time_ < var_91_8 + var_91_9 + arg_91_0 then
				local var_91_11 = Color.New(0, 0, 0)

				arg_88_1.mask_.enabled = false
				var_91_11.a = 0
				arg_88_1.mask_.color = var_91_11
			end

			local var_91_12 = arg_88_1.actors_["1084ui_story"].transform

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= 2 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_12.localPosition
			end

			local var_91_13 = 0.001

			if 2 <= arg_88_1.time_ and arg_88_1.time_ < 2 + var_91_13 then
				var_91_12.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 2) / var_91_13)
				var_91_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_12.position).x, (manager.ui.mainCamera.transform.position - var_91_12.position).y, (manager.ui.mainCamera.transform.position - var_91_12.position).z)
				var_91_12.localEulerAngles.z = 0
				var_91_12.localEulerAngles.x = 0
				var_91_12.localEulerAngles = var_91_12.localEulerAngles
			end

			if arg_88_1.time_ >= 2 + var_91_13 and arg_88_1.time_ < 2 + var_91_13 + arg_91_0 then
				var_91_12.localPosition = Vector3.New(0, 100, 0)
				var_91_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_12.position).x, (manager.ui.mainCamera.transform.position - var_91_12.position).y, (manager.ui.mainCamera.transform.position - var_91_12.position).z)
				var_91_12.localEulerAngles.z = 0
				var_91_12.localEulerAngles.x = 0
				var_91_12.localEulerAngles = var_91_12.localEulerAngles
			end

			local var_91_14 = arg_88_1.actors_["1069ui_story"].transform

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= 2 + arg_91_0 then
				arg_88_1.var_.moveOldPos1069ui_story = var_91_14.localPosition
			end

			local var_91_15 = 0.001

			if 2 <= arg_88_1.time_ and arg_88_1.time_ < 2 + var_91_15 then
				var_91_14.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 2) / var_91_15)
				var_91_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_14.position).x, (manager.ui.mainCamera.transform.position - var_91_14.position).y, (manager.ui.mainCamera.transform.position - var_91_14.position).z)
				var_91_14.localEulerAngles.z = 0
				var_91_14.localEulerAngles.x = 0
				var_91_14.localEulerAngles = var_91_14.localEulerAngles
			end

			if arg_88_1.time_ >= 2 + var_91_15 and arg_88_1.time_ < 2 + var_91_15 + arg_91_0 then
				var_91_14.localPosition = Vector3.New(0, 100, 0)
				var_91_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_14.position).x, (manager.ui.mainCamera.transform.position - var_91_14.position).y, (manager.ui.mainCamera.transform.position - var_91_14.position).z)
				var_91_14.localEulerAngles.z = 0
				var_91_14.localEulerAngles.x = 0
				var_91_14.localEulerAngles = var_91_14.localEulerAngles
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_16 = 4
			local var_91_17 = 0.8

			if 4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_18 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_18:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_19 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(120031021).content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_21 = 32 <= 0 and var_91_17 or var_91_17 * (utf8.len(var_91_19) / 32)

				if (32 <= 0 and var_91_17 or var_91_17 * (utf8.len(var_91_19) / 32)) > 0 and var_91_17 < var_91_21 then
					arg_88_1.talkMaxDuration = var_91_21
					var_91_16 = var_91_16 + 0.3

					if var_91_21 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_21 + var_91_16
					end
				end

				arg_88_1.text_.text = var_91_19
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = var_91_16 + 0.3
			local var_91_23 = math.max(var_91_17, arg_88_1.talkMaxDuration)

			if var_91_16 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_22 + var_91_23 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_22) / var_91_23

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_22 + var_91_23 and arg_88_1.time_ < var_91_22 + var_91_23 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play120031022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 120031022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play120031023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.925

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(120031022).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 37 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 37)

				if (37 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 37)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play120031023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 120031023
		arg_98_1.duration_ = 11.73

		local var_98_0 = {
			zh = 7.766,
			ja = 11.733
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play120031024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1069ui_story = arg_98_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1069ui_story"].transform.position).z)
				arg_98_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1069ui_story"].transform.localEulerAngles = arg_98_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -6)
				arg_98_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1069ui_story"].transform.position).z)
				arg_98_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1069ui_story"].transform.localEulerAngles = arg_98_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_101_1 = arg_98_1.actors_["1069ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect1069ui_story == nil then
				arg_98_1.var_.characterEffect1069ui_story = var_101_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 and not isNil(var_101_1) then
				if arg_98_1.var_.characterEffect1069ui_story and not isNil(var_101_1) then
					arg_98_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect1069ui_story then
				arg_98_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1084ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1084ui_story = var_101_4.localPosition
			end

			local var_101_5 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_5 then
				var_101_4.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_98_1.time_ - 0) / var_101_5)
				var_101_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_4.position).x, (manager.ui.mainCamera.transform.position - var_101_4.position).y, (manager.ui.mainCamera.transform.position - var_101_4.position).z)
				var_101_4.localEulerAngles.z = 0
				var_101_4.localEulerAngles.x = 0
				var_101_4.localEulerAngles = var_101_4.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_5 and arg_98_1.time_ < 0 + var_101_5 + arg_101_0 then
				var_101_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_101_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_4.position).x, (manager.ui.mainCamera.transform.position - var_101_4.position).y, (manager.ui.mainCamera.transform.position - var_101_4.position).z)
				var_101_4.localEulerAngles.z = 0
				var_101_4.localEulerAngles.x = 0
				var_101_4.localEulerAngles = var_101_4.localEulerAngles
			end

			local var_101_6 = arg_98_1.actors_["1084ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_6) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_7 = 0.0166666666666667

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 and not isNil(var_101_6) then
				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_6) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_7)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 and not isNil(var_101_6) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_101_8 = 0
			local var_101_9 = 1.025

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_10 = arg_98_1:GetWordFromCfg(120031023)
				local var_101_11 = arg_98_1:FormatText(var_101_10.content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 41 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 41)

				if (41 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 41)) > 0 and var_101_9 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031023", "story_v_out_120031.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031023", "story_v_out_120031.awb") / 1000

					if var_101_14 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_8
					end

					if var_101_10.prefab_name ~= "" and arg_98_1.actors_[var_101_10.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_10.prefab_name].transform, "story_v_out_120031", "120031023", "story_v_out_120031.awb")

						arg_98_1:RecordAudio("120031023", var_101_15)
						arg_98_1:RecordAudio("120031023", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_120031", "120031023", "story_v_out_120031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_120031", "120031023", "story_v_out_120031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_16 and arg_98_1.time_ < var_101_8 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play120031024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 120031024
		arg_102_1.duration_ = 10.5

		local var_102_0 = {
			zh = 8.2,
			ja = 10.5
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
				arg_102_0:Play120031025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_105_0 = 0
			local var_105_1 = 1.075

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(120031024)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 43 <= 0 and var_105_1 or var_105_1 * (utf8.len(var_105_3) / 43)

				if (43 <= 0 and var_105_1 or var_105_1 * (utf8.len(var_105_3) / 43)) > 0 and var_105_1 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031024", "story_v_out_120031.awb") ~= 0 then
					local var_105_6 = manager.audio:GetVoiceLength("story_v_out_120031", "120031024", "story_v_out_120031.awb") / 1000

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end

					if var_105_2.prefab_name ~= "" and arg_102_1.actors_[var_105_2.prefab_name] ~= nil then
						local var_105_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_2.prefab_name].transform, "story_v_out_120031", "120031024", "story_v_out_120031.awb")

						arg_102_1:RecordAudio("120031024", var_105_7)
						arg_102_1:RecordAudio("120031024", var_105_7)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_120031", "120031024", "story_v_out_120031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_120031", "120031024", "story_v_out_120031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_8 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_8 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_8

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_8 and arg_102_1.time_ < var_105_0 + var_105_8 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play120031025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 120031025
		arg_106_1.duration_ = 6.1

		local var_106_0 = {
			zh = 3.9,
			ja = 6.1
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play120031026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.575

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:GetWordFromCfg(120031025)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 23 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 23)

				if (23 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 23)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031025", "story_v_out_120031.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_120031", "120031025", "story_v_out_120031.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_120031", "120031025", "story_v_out_120031.awb")

						arg_106_1:RecordAudio("120031025", var_109_6)
						arg_106_1:RecordAudio("120031025", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_120031", "120031025", "story_v_out_120031.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_120031", "120031025", "story_v_out_120031.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play120031026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 120031026
		arg_110_1.duration_ = 3.4

		local var_110_0 = {
			zh = 3.4,
			ja = 2.3
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
				arg_110_0:Play120031027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1069ui_story"]) and arg_110_1.var_.characterEffect1069ui_story == nil then
				arg_110_1.var_.characterEffect1069ui_story = arg_110_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1069ui_story"]) then
				if arg_110_1.var_.characterEffect1069ui_story and not isNil(arg_110_1.actors_["1069ui_story"]) then
					arg_110_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1069ui_story"]) and arg_110_1.var_.characterEffect1069ui_story then
				arg_110_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_113_1 = arg_110_1.actors_["1084ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1084ui_story == nil then
				arg_110_1.var_.characterEffect1084ui_story = var_113_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_2 and not isNil(var_113_1) then
				if arg_110_1.var_.characterEffect1084ui_story and not isNil(var_113_1) then
					arg_110_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_2 and arg_110_1.time_ < 0 + var_113_2 + arg_113_0 and not isNil(var_113_1) and arg_110_1.var_.characterEffect1084ui_story then
				arg_110_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_113_4 = 0
			local var_113_5 = 0.35

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(120031026)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 14 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 14)

				if (14 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 14)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031026", "story_v_out_120031.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031026", "story_v_out_120031.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_120031", "120031026", "story_v_out_120031.awb")

						arg_110_1:RecordAudio("120031026", var_113_11)
						arg_110_1:RecordAudio("120031026", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_120031", "120031026", "story_v_out_120031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_120031", "120031026", "story_v_out_120031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play120031027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 120031027
		arg_114_1.duration_ = 7.27

		local var_114_0 = {
			zh = 7.266,
			ja = 5.4
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
				arg_114_0:Play120031028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1069ui_story"]) and arg_114_1.var_.characterEffect1069ui_story == nil then
				arg_114_1.var_.characterEffect1069ui_story = arg_114_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1069ui_story"]) then
				if arg_114_1.var_.characterEffect1069ui_story and not isNil(arg_114_1.actors_["1069ui_story"]) then
					arg_114_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1069ui_story"]) and arg_114_1.var_.characterEffect1069ui_story then
				arg_114_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["1084ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1084ui_story then
				arg_114_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action424")
			end

			local var_117_4 = 0
			local var_117_5 = 0.85

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(120031027)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 34 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 34)

				if (34 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 34)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031027", "story_v_out_120031.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031027", "story_v_out_120031.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_120031", "120031027", "story_v_out_120031.awb")

						arg_114_1:RecordAudio("120031027", var_117_11)
						arg_114_1:RecordAudio("120031027", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_120031", "120031027", "story_v_out_120031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_120031", "120031027", "story_v_out_120031.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_5, arg_114_1.talkMaxDuration)

			if var_117_4 <= arg_114_1.time_ and arg_114_1.time_ < var_117_4 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_4) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_4 + var_117_12 and arg_114_1.time_ < var_117_4 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play120031028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 120031028
		arg_118_1.duration_ = 6.3

		local var_118_0 = {
			zh = 5.366,
			ja = 6.3
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
				arg_118_0:Play120031029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = arg_118_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) then
				if arg_118_1.var_.characterEffect1084ui_story and not isNil(arg_118_1.actors_["1084ui_story"]) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1084ui_story"]) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["1069ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1069ui_story == nil then
				arg_118_1.var_.characterEffect1069ui_story = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_3 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.characterEffect1069ui_story and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_3)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1069ui_story then
				arg_118_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_121_4 = 0
			local var_121_5 = 0.6

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(120031028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 24 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 24)

				if (24 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 24)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031028", "story_v_out_120031.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031028", "story_v_out_120031.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_120031", "120031028", "story_v_out_120031.awb")

						arg_118_1:RecordAudio("120031028", var_121_11)
						arg_118_1:RecordAudio("120031028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_120031", "120031028", "story_v_out_120031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_120031", "120031028", "story_v_out_120031.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play120031029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 120031029
		arg_122_1.duration_ = 4.2

		local var_122_0 = {
			zh = 1.933,
			ja = 4.2
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
				arg_122_0:Play120031030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1069ui_story"]) and arg_122_1.var_.characterEffect1069ui_story == nil then
				arg_122_1.var_.characterEffect1069ui_story = arg_122_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1069ui_story"]) then
				if arg_122_1.var_.characterEffect1069ui_story and not isNil(arg_122_1.actors_["1069ui_story"]) then
					arg_122_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1069ui_story"]) and arg_122_1.var_.characterEffect1069ui_story then
				arg_122_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["1084ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_125_4 = 0
			local var_125_5 = 0.225

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(120031029)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 9 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 9)

				if (9 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 9)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031029", "story_v_out_120031.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031029", "story_v_out_120031.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_out_120031", "120031029", "story_v_out_120031.awb")

						arg_122_1:RecordAudio("120031029", var_125_11)
						arg_122_1:RecordAudio("120031029", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_120031", "120031029", "story_v_out_120031.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_120031", "120031029", "story_v_out_120031.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play120031030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 120031030
		arg_126_1.duration_ = 10.87

		local var_126_0 = {
			zh = 10.866,
			ja = 9.8
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play120031031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 1.15

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(120031030)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 46 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 46)

				if (46 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 46)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031030", "story_v_out_120031.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_120031", "120031030", "story_v_out_120031.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_120031", "120031030", "story_v_out_120031.awb")

						arg_126_1:RecordAudio("120031030", var_129_6)
						arg_126_1:RecordAudio("120031030", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_120031", "120031030", "story_v_out_120031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_120031", "120031030", "story_v_out_120031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play120031031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 120031031
		arg_130_1.duration_ = 3.5

		local var_130_0 = {
			zh = 3.5,
			ja = 2.866
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
				arg_130_0:Play120031032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["1084ui_story"]) and arg_130_1.var_.characterEffect1084ui_story == nil then
				arg_130_1.var_.characterEffect1084ui_story = arg_130_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["1084ui_story"]) then
				if arg_130_1.var_.characterEffect1084ui_story and not isNil(arg_130_1.actors_["1084ui_story"]) then
					arg_130_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["1084ui_story"]) and arg_130_1.var_.characterEffect1084ui_story then
				arg_130_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_133_2 = arg_130_1.actors_["1069ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1069ui_story == nil then
				arg_130_1.var_.characterEffect1069ui_story = var_133_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_3 = 0.2

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_3 and not isNil(var_133_2) then
				if arg_130_1.var_.characterEffect1069ui_story and not isNil(var_133_2) then
					arg_130_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_3)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_3 and arg_130_1.time_ < 0 + var_133_3 + arg_133_0 and not isNil(var_133_2) and arg_130_1.var_.characterEffect1069ui_story then
				arg_130_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4713")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_133_4 = 0
			local var_133_5 = 0.25

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_6 = arg_130_1:GetWordFromCfg(120031031)
				local var_133_7 = arg_130_1:FormatText(var_133_6.content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 10 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 10)

				if (10 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 10)) > 0 and var_133_5 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031031", "story_v_out_120031.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031031", "story_v_out_120031.awb") / 1000

					if var_133_10 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_4
					end

					if var_133_6.prefab_name ~= "" and arg_130_1.actors_[var_133_6.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_6.prefab_name].transform, "story_v_out_120031", "120031031", "story_v_out_120031.awb")

						arg_130_1:RecordAudio("120031031", var_133_11)
						arg_130_1:RecordAudio("120031031", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_120031", "120031031", "story_v_out_120031.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_120031", "120031031", "story_v_out_120031.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_12 and arg_130_1.time_ < var_133_4 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play120031032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 120031032
		arg_134_1.duration_ = 1.87

		local var_134_0 = {
			zh = 1.3,
			ja = 1.866
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play120031033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1069ui_story"]) and arg_134_1.var_.characterEffect1069ui_story == nil then
				arg_134_1.var_.characterEffect1069ui_story = arg_134_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1069ui_story"]) then
				if arg_134_1.var_.characterEffect1069ui_story and not isNil(arg_134_1.actors_["1069ui_story"]) then
					arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1069ui_story"]) and arg_134_1.var_.characterEffect1069ui_story then
				arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_137_2 = arg_134_1.actors_["1084ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = var_137_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_3 = 0.2

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.characterEffect1084ui_story and not isNil(var_137_2) then
					arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_3)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1084ui_story then
				arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_137_4 = 0
			local var_137_5 = 0.125

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_6 = arg_134_1:GetWordFromCfg(120031032)
				local var_137_7 = arg_134_1:FormatText(var_137_6.content)

				arg_134_1.text_.text = var_137_7

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_9 = 5 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 5)

				if (5 <= 0 and var_137_5 or var_137_5 * (utf8.len(var_137_7) / 5)) > 0 and var_137_5 < var_137_9 then
					arg_134_1.talkMaxDuration = var_137_9

					if var_137_9 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_9 + var_137_4
					end
				end

				arg_134_1.text_.text = var_137_7
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031032", "story_v_out_120031.awb") ~= 0 then
					local var_137_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031032", "story_v_out_120031.awb") / 1000

					if var_137_10 + var_137_4 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_10 + var_137_4
					end

					if var_137_6.prefab_name ~= "" and arg_134_1.actors_[var_137_6.prefab_name] ~= nil then
						local var_137_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_6.prefab_name].transform, "story_v_out_120031", "120031032", "story_v_out_120031.awb")

						arg_134_1:RecordAudio("120031032", var_137_11)
						arg_134_1:RecordAudio("120031032", var_137_11)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_120031", "120031032", "story_v_out_120031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_120031", "120031032", "story_v_out_120031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_12 = math.max(var_137_5, arg_134_1.talkMaxDuration)

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_12 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_4) / var_137_12

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_4 + var_137_12 and arg_134_1.time_ < var_137_4 + var_137_12 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play120031033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 120031033
		arg_138_1.duration_ = 10.13

		local var_138_0 = {
			zh = 10.1,
			ja = 10.133
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play120031034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1075ui_story = arg_138_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).z)
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles = arg_138_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_138_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1075ui_story"].transform.position).z)
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1075ui_story"].transform.localEulerAngles = arg_138_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["1075ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1075ui_story == nil then
				arg_138_1.var_.characterEffect1075ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 and not isNil(var_141_1) then
				if arg_138_1.var_.characterEffect1075ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1075ui_story then
				arg_138_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["1069ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1069ui_story = var_141_4.localPosition
			end

			local var_141_5 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_5 then
				var_141_4.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_5)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_5 and arg_138_1.time_ < 0 + var_141_5 + arg_141_0 then
				var_141_4.localPosition = Vector3.New(0, 100, 0)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_141_6 = 0
			local var_141_7 = 1.15

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(120031033)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 46 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 46)

				if (46 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 46)) > 0 and var_141_7 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031033", "story_v_out_120031.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_120031", "120031033", "story_v_out_120031.awb") / 1000

					if var_141_12 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_6
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_120031", "120031033", "story_v_out_120031.awb")

						arg_138_1:RecordAudio("120031033", var_141_13)
						arg_138_1:RecordAudio("120031033", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_120031", "120031033", "story_v_out_120031.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_120031", "120031033", "story_v_out_120031.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play120031034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 120031034
		arg_142_1.duration_ = 4.3

		local var_142_0 = {
			zh = 4,
			ja = 4.3
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play120031035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1084ui_story"]) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = arg_142_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1084ui_story"]) then
				if arg_142_1.var_.characterEffect1084ui_story and not isNil(arg_142_1.actors_["1084ui_story"]) then
					arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1084ui_story"]) and arg_142_1.var_.characterEffect1084ui_story then
				arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_145_2 = arg_142_1.actors_["1075ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1075ui_story == nil then
				arg_142_1.var_.characterEffect1075ui_story = var_145_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_3 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.characterEffect1075ui_story and not isNil(var_145_2) then
					arg_142_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_3)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.characterEffect1075ui_story then
				arg_142_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_145_4 = 0
			local var_145_5 = 0.425

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(120031034)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 17 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 17)

				if (17 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 17)) > 0 and var_145_5 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031034", "story_v_out_120031.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031034", "story_v_out_120031.awb") / 1000

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_out_120031", "120031034", "story_v_out_120031.awb")

						arg_142_1:RecordAudio("120031034", var_145_11)
						arg_142_1:RecordAudio("120031034", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_120031", "120031034", "story_v_out_120031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_120031", "120031034", "story_v_out_120031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_12 and arg_142_1.time_ < var_145_4 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play120031035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 120031035
		arg_146_1.duration_ = 7.77

		local var_146_0 = {
			zh = 5.9,
			ja = 7.766
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play120031036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1075ui_story = arg_146_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1075ui_story"].transform.position).z)
				arg_146_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1075ui_story"].transform.localEulerAngles = arg_146_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1075ui_story"].transform.position).z)
				arg_146_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1075ui_story"].transform.localEulerAngles = arg_146_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1069ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1069ui_story = var_149_1.localPosition
			end

			local var_149_2 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 then
				var_149_1.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_146_1.time_ - 0) / var_149_2)
				var_149_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_1.position).x, (manager.ui.mainCamera.transform.position - var_149_1.position).y, (manager.ui.mainCamera.transform.position - var_149_1.position).z)
				var_149_1.localEulerAngles.z = 0
				var_149_1.localEulerAngles.x = 0
				var_149_1.localEulerAngles = var_149_1.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 then
				var_149_1.localPosition = Vector3.New(-0.7, -1, -6)
				var_149_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_1.position).x, (manager.ui.mainCamera.transform.position - var_149_1.position).y, (manager.ui.mainCamera.transform.position - var_149_1.position).z)
				var_149_1.localEulerAngles.z = 0
				var_149_1.localEulerAngles.x = 0
				var_149_1.localEulerAngles = var_149_1.localEulerAngles
			end

			local var_149_3 = arg_146_1.actors_["1069ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_3) and arg_146_1.var_.characterEffect1069ui_story == nil then
				arg_146_1.var_.characterEffect1069ui_story = var_149_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_4 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 and not isNil(var_149_3) then
				if arg_146_1.var_.characterEffect1069ui_story and not isNil(var_149_3) then
					arg_146_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 and not isNil(var_149_3) and arg_146_1.var_.characterEffect1069ui_story then
				arg_146_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_149_6 = arg_146_1.actors_["1084ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = var_149_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_7 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 and not isNil(var_149_6) then
				if arg_146_1.var_.characterEffect1084ui_story and not isNil(var_149_6) then
					arg_146_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_7)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect1084ui_story then
				arg_146_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_149_8 = 0
			local var_149_9 = 0.825

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_10 = arg_146_1:GetWordFromCfg(120031035)
				local var_149_11 = arg_146_1:FormatText(var_149_10.content)

				arg_146_1.text_.text = var_149_11

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_13 = 33 <= 0 and var_149_9 or var_149_9 * (utf8.len(var_149_11) / 33)

				if (33 <= 0 and var_149_9 or var_149_9 * (utf8.len(var_149_11) / 33)) > 0 and var_149_9 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_8
					end
				end

				arg_146_1.text_.text = var_149_11
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031035", "story_v_out_120031.awb") ~= 0 then
					local var_149_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031035", "story_v_out_120031.awb") / 1000

					if var_149_14 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_14 + var_149_8
					end

					if var_149_10.prefab_name ~= "" and arg_146_1.actors_[var_149_10.prefab_name] ~= nil then
						local var_149_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_10.prefab_name].transform, "story_v_out_120031", "120031035", "story_v_out_120031.awb")

						arg_146_1:RecordAudio("120031035", var_149_15)
						arg_146_1:RecordAudio("120031035", var_149_15)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_120031", "120031035", "story_v_out_120031.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_120031", "120031035", "story_v_out_120031.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_16 = math.max(var_149_9, arg_146_1.talkMaxDuration)

			if var_149_8 <= arg_146_1.time_ and arg_146_1.time_ < var_149_8 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_8) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_8 + var_149_16 and arg_146_1.time_ < var_149_8 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play120031036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 120031036
		arg_150_1.duration_ = 10

		local var_150_0 = {
			zh = 7.2,
			ja = 10
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play120031037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.975

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(120031036)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 39 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 39)

				if (39 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 39)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031036", "story_v_out_120031.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_120031", "120031036", "story_v_out_120031.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_120031", "120031036", "story_v_out_120031.awb")

						arg_150_1:RecordAudio("120031036", var_153_6)
						arg_150_1:RecordAudio("120031036", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_120031", "120031036", "story_v_out_120031.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_120031", "120031036", "story_v_out_120031.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play120031037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 120031037
		arg_154_1.duration_ = 12.03

		local var_154_0 = {
			zh = 7.533,
			ja = 12.033
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play120031038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["1084ui_story"]) and arg_154_1.var_.characterEffect1084ui_story == nil then
				arg_154_1.var_.characterEffect1084ui_story = arg_154_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["1084ui_story"]) then
				if arg_154_1.var_.characterEffect1084ui_story and not isNil(arg_154_1.actors_["1084ui_story"]) then
					arg_154_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["1084ui_story"]) and arg_154_1.var_.characterEffect1084ui_story then
				arg_154_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_157_2 = arg_154_1.actors_["1069ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1069ui_story == nil then
				arg_154_1.var_.characterEffect1069ui_story = var_157_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_3 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.characterEffect1069ui_story and not isNil(var_157_2) then
					arg_154_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_3)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect1069ui_story then
				arg_154_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_157_4 = 0
			local var_157_5 = 0.725

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(120031037)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 29 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 29)

				if (29 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 29)) > 0 and var_157_5 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031037", "story_v_out_120031.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031037", "story_v_out_120031.awb") / 1000

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end

					if var_157_6.prefab_name ~= "" and arg_154_1.actors_[var_157_6.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_6.prefab_name].transform, "story_v_out_120031", "120031037", "story_v_out_120031.awb")

						arg_154_1:RecordAudio("120031037", var_157_11)
						arg_154_1:RecordAudio("120031037", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_120031", "120031037", "story_v_out_120031.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_120031", "120031037", "story_v_out_120031.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_12 and arg_154_1.time_ < var_157_4 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play120031038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 120031038
		arg_158_1.duration_ = 12.63

		local var_158_0 = {
			zh = 12.633,
			ja = 11.433
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play120031039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1069ui_story = arg_158_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).z)
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles = arg_158_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_158_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1069ui_story"].transform.position).z)
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1069ui_story"].transform.localEulerAngles = arg_158_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["1075ui_story"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1075ui_story = var_161_1.localPosition
			end

			local var_161_2 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 then
				var_161_1.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_158_1.time_ - 0) / var_161_2)
				var_161_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_1.position).x, (manager.ui.mainCamera.transform.position - var_161_1.position).y, (manager.ui.mainCamera.transform.position - var_161_1.position).z)
				var_161_1.localEulerAngles.z = 0
				var_161_1.localEulerAngles.x = 0
				var_161_1.localEulerAngles = var_161_1.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 then
				var_161_1.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				var_161_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_1.position).x, (manager.ui.mainCamera.transform.position - var_161_1.position).y, (manager.ui.mainCamera.transform.position - var_161_1.position).z)
				var_161_1.localEulerAngles.z = 0
				var_161_1.localEulerAngles.x = 0
				var_161_1.localEulerAngles = var_161_1.localEulerAngles
			end

			local var_161_3 = arg_158_1.actors_["1075ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_3) and arg_158_1.var_.characterEffect1075ui_story == nil then
				arg_158_1.var_.characterEffect1075ui_story = var_161_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_4 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 and not isNil(var_161_3) then
				if arg_158_1.var_.characterEffect1075ui_story and not isNil(var_161_3) then
					arg_158_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 and not isNil(var_161_3) and arg_158_1.var_.characterEffect1075ui_story then
				arg_158_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_161_6 = arg_158_1.actors_["1084ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_6) and arg_158_1.var_.characterEffect1084ui_story == nil then
				arg_158_1.var_.characterEffect1084ui_story = var_161_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_7 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 and not isNil(var_161_6) then
				if arg_158_1.var_.characterEffect1084ui_story and not isNil(var_161_6) then
					arg_158_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_7)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 and not isNil(var_161_6) and arg_158_1.var_.characterEffect1084ui_story then
				arg_158_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_161_8 = 0
			local var_161_9 = 1.375

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_10 = arg_158_1:GetWordFromCfg(120031038)
				local var_161_11 = arg_158_1:FormatText(var_161_10.content)

				arg_158_1.text_.text = var_161_11

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_13 = 55 <= 0 and var_161_9 or var_161_9 * (utf8.len(var_161_11) / 55)

				if (55 <= 0 and var_161_9 or var_161_9 * (utf8.len(var_161_11) / 55)) > 0 and var_161_9 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_11
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031038", "story_v_out_120031.awb") ~= 0 then
					local var_161_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031038", "story_v_out_120031.awb") / 1000

					if var_161_14 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_8
					end

					if var_161_10.prefab_name ~= "" and arg_158_1.actors_[var_161_10.prefab_name] ~= nil then
						local var_161_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_10.prefab_name].transform, "story_v_out_120031", "120031038", "story_v_out_120031.awb")

						arg_158_1:RecordAudio("120031038", var_161_15)
						arg_158_1:RecordAudio("120031038", var_161_15)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_120031", "120031038", "story_v_out_120031.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_120031", "120031038", "story_v_out_120031.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_16 and arg_158_1.time_ < var_161_8 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play120031039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 120031039
		arg_162_1.duration_ = 13.8

		local var_162_0 = {
			zh = 13.8,
			ja = 9.6
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play120031040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.2

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:GetWordFromCfg(120031039)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 48 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 48)

				if (48 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 48)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031039", "story_v_out_120031.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_120031", "120031039", "story_v_out_120031.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_120031", "120031039", "story_v_out_120031.awb")

						arg_162_1:RecordAudio("120031039", var_165_6)
						arg_162_1:RecordAudio("120031039", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_120031", "120031039", "story_v_out_120031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_120031", "120031039", "story_v_out_120031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play120031040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 120031040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play120031041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1084ui_story = arg_166_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).z)
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles = arg_166_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1084ui_story"].transform.position).z)
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1084ui_story"].transform.localEulerAngles = arg_166_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_169_1 = arg_166_1.actors_["1075ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1075ui_story = var_169_1.localPosition
			end

			local var_169_2 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_2 then
				var_169_1.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_2)
				var_169_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_1.position).x, (manager.ui.mainCamera.transform.position - var_169_1.position).y, (manager.ui.mainCamera.transform.position - var_169_1.position).z)
				var_169_1.localEulerAngles.z = 0
				var_169_1.localEulerAngles.x = 0
				var_169_1.localEulerAngles = var_169_1.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_2 and arg_166_1.time_ < 0 + var_169_2 + arg_169_0 then
				var_169_1.localPosition = Vector3.New(0, 100, 0)
				var_169_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_1.position).x, (manager.ui.mainCamera.transform.position - var_169_1.position).y, (manager.ui.mainCamera.transform.position - var_169_1.position).z)
				var_169_1.localEulerAngles.z = 0
				var_169_1.localEulerAngles.x = 0
				var_169_1.localEulerAngles = var_169_1.localEulerAngles
			end

			local var_169_3 = 0
			local var_169_4 = 0.975

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_3 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_5 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(120031040).content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 39 <= 0 and var_169_4 or var_169_4 * (utf8.len(var_169_5) / 39)

				if (39 <= 0 and var_169_4 or var_169_4 * (utf8.len(var_169_5) / 39)) > 0 and var_169_4 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_3 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_3
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_8 = math.max(var_169_4, arg_166_1.talkMaxDuration)

			if var_169_3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_3 + var_169_8 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_3) / var_169_8

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_3 + var_169_8 and arg_166_1.time_ < var_169_3 + var_169_8 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play120031041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 120031041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play120031042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.9

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(120031041).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 36 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 36)

				if (36 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 36)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play120031042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 120031042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play120031043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.575

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(120031042).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 23 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 23)

				if (23 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 23)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play120031043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 120031043
		arg_178_1.duration_ = 9

		local var_178_0 = {
			zh = 9,
			ja = 6.833
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play120031044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1075ui_story = arg_178_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1075ui_story"].transform.position).z)
				arg_178_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1075ui_story"].transform.localEulerAngles = arg_178_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.16)
				arg_178_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1075ui_story"].transform.position).z)
				arg_178_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1075ui_story"].transform.localEulerAngles = arg_178_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1075ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1075ui_story == nil then
				arg_178_1.var_.characterEffect1075ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.2

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1075ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1075ui_story then
				arg_178_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_181_4 = 0
			local var_181_5 = 0.875

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(120031043)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 35 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 35)

				if (35 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 35)) > 0 and var_181_5 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031043", "story_v_out_120031.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031043", "story_v_out_120031.awb") / 1000

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end

					if var_181_6.prefab_name ~= "" and arg_178_1.actors_[var_181_6.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_6.prefab_name].transform, "story_v_out_120031", "120031043", "story_v_out_120031.awb")

						arg_178_1:RecordAudio("120031043", var_181_11)
						arg_178_1:RecordAudio("120031043", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_120031", "120031043", "story_v_out_120031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_120031", "120031043", "story_v_out_120031.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_12 and arg_178_1.time_ < var_181_4 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play120031044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 120031044
		arg_182_1.duration_ = 13

		local var_182_0 = {
			zh = 11.4,
			ja = 13
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play120031045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_185_0 = 0
			local var_185_1 = 1.175

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_2 = arg_182_1:GetWordFromCfg(120031044)
				local var_185_3 = arg_182_1:FormatText(var_185_2.content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 47 <= 0 and var_185_1 or var_185_1 * (utf8.len(var_185_3) / 47)

				if (47 <= 0 and var_185_1 or var_185_1 * (utf8.len(var_185_3) / 47)) > 0 and var_185_1 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031044", "story_v_out_120031.awb") ~= 0 then
					local var_185_6 = manager.audio:GetVoiceLength("story_v_out_120031", "120031044", "story_v_out_120031.awb") / 1000

					if var_185_6 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_0
					end

					if var_185_2.prefab_name ~= "" and arg_182_1.actors_[var_185_2.prefab_name] ~= nil then
						local var_185_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_2.prefab_name].transform, "story_v_out_120031", "120031044", "story_v_out_120031.awb")

						arg_182_1:RecordAudio("120031044", var_185_7)
						arg_182_1:RecordAudio("120031044", var_185_7)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_120031", "120031044", "story_v_out_120031.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_120031", "120031044", "story_v_out_120031.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_8 and arg_182_1.time_ < var_185_0 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play120031045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 120031045
		arg_186_1.duration_ = 6.5

		local var_186_0 = {
			zh = 4.966,
			ja = 6.5
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
				arg_186_0:Play120031046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10044ui_story = arg_186_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10044ui_story"].transform.position).z)
				arg_186_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10044ui_story"].transform.localEulerAngles = arg_186_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0.7, -0.72, -6.3)
				arg_186_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["10044ui_story"].transform.position).z)
				arg_186_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["10044ui_story"].transform.localEulerAngles = arg_186_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["1075ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1075ui_story = var_189_1.localPosition
			end

			local var_189_2 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 then
				var_189_1.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_186_1.time_ - 0) / var_189_2)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 then
				var_189_1.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			local var_189_3 = arg_186_1.actors_["10044ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_3) and arg_186_1.var_.characterEffect10044ui_story == nil then
				arg_186_1.var_.characterEffect10044ui_story = var_189_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_4 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 and not isNil(var_189_3) then
				if arg_186_1.var_.characterEffect10044ui_story and not isNil(var_189_3) then
					arg_186_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 and not isNil(var_189_3) and arg_186_1.var_.characterEffect10044ui_story then
				arg_186_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_189_6 = arg_186_1.actors_["1075ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect1075ui_story == nil then
				arg_186_1.var_.characterEffect1075ui_story = var_189_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_7 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 and not isNil(var_189_6) then
				if arg_186_1.var_.characterEffect1075ui_story and not isNil(var_189_6) then
					arg_186_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_7)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect1075ui_story then
				arg_186_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_189_8 = 0
			local var_189_9 = 0.525

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_10 = arg_186_1:GetWordFromCfg(120031045)
				local var_189_11 = arg_186_1:FormatText(var_189_10.content)

				arg_186_1.text_.text = var_189_11

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 21 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 21)

				if (21 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_11) / 21)) > 0 and var_189_9 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_11
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031045", "story_v_out_120031.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031045", "story_v_out_120031.awb") / 1000

					if var_189_14 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_8
					end

					if var_189_10.prefab_name ~= "" and arg_186_1.actors_[var_189_10.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_10.prefab_name].transform, "story_v_out_120031", "120031045", "story_v_out_120031.awb")

						arg_186_1:RecordAudio("120031045", var_189_15)
						arg_186_1:RecordAudio("120031045", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_120031", "120031045", "story_v_out_120031.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_120031", "120031045", "story_v_out_120031.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_16 and arg_186_1.time_ < var_189_8 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play120031046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 120031046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play120031047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["10044ui_story"]) and arg_190_1.var_.characterEffect10044ui_story == nil then
				arg_190_1.var_.characterEffect10044ui_story = arg_190_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.2

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["10044ui_story"]) then
				if arg_190_1.var_.characterEffect10044ui_story and not isNil(arg_190_1.actors_["10044ui_story"]) then
					arg_190_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["10044ui_story"]) and arg_190_1.var_.characterEffect10044ui_story then
				arg_190_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.15

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(120031046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 6 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 6)

				if (6 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 6)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play120031047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 120031047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play120031048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.4

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(120031047).content)

				arg_194_1.text_.text = var_197_1

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_3 = 16 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 16)

				if (16 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 16)) > 0 and var_197_0 < var_197_3 then
					arg_194_1.talkMaxDuration = var_197_3

					if var_197_3 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_3 + 0
					end
				end

				arg_194_1.text_.text = var_197_1
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_4 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_4

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play120031048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 120031048
		arg_198_1.duration_ = 6.37

		local var_198_0 = {
			zh = 2.9,
			ja = 6.366
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
				arg_198_0:Play120031049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1075ui_story"]) and arg_198_1.var_.characterEffect1075ui_story == nil then
				arg_198_1.var_.characterEffect1075ui_story = arg_198_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 1

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1075ui_story"]) then
				if arg_198_1.var_.characterEffect1075ui_story and not isNil(arg_198_1.actors_["1075ui_story"]) then
					arg_198_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1075ui_story"]) and arg_198_1.var_.characterEffect1075ui_story then
				arg_198_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_201_2 = 0
			local var_201_3 = 0.375

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_4 = arg_198_1:GetWordFromCfg(120031048)
				local var_201_5 = arg_198_1:FormatText(var_201_4.content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_7 = 15 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 15)

				if (15 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 15)) > 0 and var_201_3 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031048", "story_v_out_120031.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031048", "story_v_out_120031.awb") / 1000

					if var_201_8 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_2
					end

					if var_201_4.prefab_name ~= "" and arg_198_1.actors_[var_201_4.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_4.prefab_name].transform, "story_v_out_120031", "120031048", "story_v_out_120031.awb")

						arg_198_1:RecordAudio("120031048", var_201_9)
						arg_198_1:RecordAudio("120031048", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_120031", "120031048", "story_v_out_120031.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_120031", "120031048", "story_v_out_120031.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 <= arg_198_1.time_ and arg_198_1.time_ < var_201_2 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_2) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_2 + var_201_10 and arg_198_1.time_ < var_201_2 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play120031049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 120031049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play120031050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1075ui_story"]) and arg_202_1.var_.characterEffect1075ui_story == nil then
				arg_202_1.var_.characterEffect1075ui_story = arg_202_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1075ui_story"]) then
				if arg_202_1.var_.characterEffect1075ui_story and not isNil(arg_202_1.actors_["1075ui_story"]) then
					arg_202_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1075ui_story"]) and arg_202_1.var_.characterEffect1075ui_story then
				arg_202_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 0.75

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(120031049).content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 30 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 30)

				if (30 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 30)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_6 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_6 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_6

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_6 and arg_202_1.time_ < var_205_1 + var_205_6 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play120031050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 120031050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play120031051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.9

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(120031050).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 36 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 36)

				if (36 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 36)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play120031051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 120031051
		arg_210_1.duration_ = 14.77

		local var_210_0 = {
			zh = 8.2,
			ja = 14.766
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
				arg_210_0:Play120031052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1075ui_story"]) and arg_210_1.var_.characterEffect1075ui_story == nil then
				arg_210_1.var_.characterEffect1075ui_story = arg_210_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1075ui_story"]) then
				if arg_210_1.var_.characterEffect1075ui_story and not isNil(arg_210_1.actors_["1075ui_story"]) then
					arg_210_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1075ui_story"]) and arg_210_1.var_.characterEffect1075ui_story then
				arg_210_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_213_2 = 0
			local var_213_3 = 0.9

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_2 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_4 = arg_210_1:GetWordFromCfg(120031051)
				local var_213_5 = arg_210_1:FormatText(var_213_4.content)

				arg_210_1.text_.text = var_213_5

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_7 = 36 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 36)

				if (36 <= 0 and var_213_3 or var_213_3 * (utf8.len(var_213_5) / 36)) > 0 and var_213_3 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_2
					end
				end

				arg_210_1.text_.text = var_213_5
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031051", "story_v_out_120031.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031051", "story_v_out_120031.awb") / 1000

					if var_213_8 + var_213_2 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_2
					end

					if var_213_4.prefab_name ~= "" and arg_210_1.actors_[var_213_4.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_4.prefab_name].transform, "story_v_out_120031", "120031051", "story_v_out_120031.awb")

						arg_210_1:RecordAudio("120031051", var_213_9)
						arg_210_1:RecordAudio("120031051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_120031", "120031051", "story_v_out_120031.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_120031", "120031051", "story_v_out_120031.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_3, arg_210_1.talkMaxDuration)

			if var_213_2 <= arg_210_1.time_ and arg_210_1.time_ < var_213_2 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_2) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_2 + var_213_10 and arg_210_1.time_ < var_213_2 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play120031052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 120031052
		arg_214_1.duration_ = 11.5

		local var_214_0 = {
			zh = 11.5,
			ja = 9.066
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play120031053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.975

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:GetWordFromCfg(120031052)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 39)

				if (39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 39)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031052", "story_v_out_120031.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_120031", "120031052", "story_v_out_120031.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_120031", "120031052", "story_v_out_120031.awb")

						arg_214_1:RecordAudio("120031052", var_217_6)
						arg_214_1:RecordAudio("120031052", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_120031", "120031052", "story_v_out_120031.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_120031", "120031052", "story_v_out_120031.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play120031053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 120031053
		arg_218_1.duration_ = 2

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play120031054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["10044ui_story"]) and arg_218_1.var_.characterEffect10044ui_story == nil then
				arg_218_1.var_.characterEffect10044ui_story = arg_218_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_0 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["10044ui_story"]) then
				if arg_218_1.var_.characterEffect10044ui_story and not isNil(arg_218_1.actors_["10044ui_story"]) then
					arg_218_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["10044ui_story"]) and arg_218_1.var_.characterEffect10044ui_story then
				arg_218_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_221_2 = arg_218_1.actors_["1075ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1075ui_story == nil then
				arg_218_1.var_.characterEffect1075ui_story = var_221_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_3 = 0.2

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.characterEffect1075ui_story and not isNil(var_221_2) then
					arg_218_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_3)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect1075ui_story then
				arg_218_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_221_4 = 0
			local var_221_5 = 0.15

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_4 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_6 = arg_218_1:GetWordFromCfg(120031053)
				local var_221_7 = arg_218_1:FormatText(var_221_6.content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 6 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 6)

				if (6 <= 0 and var_221_5 or var_221_5 * (utf8.len(var_221_7) / 6)) > 0 and var_221_5 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_4
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031053", "story_v_out_120031.awb") ~= 0 then
					local var_221_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031053", "story_v_out_120031.awb") / 1000

					if var_221_10 + var_221_4 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_10 + var_221_4
					end

					if var_221_6.prefab_name ~= "" and arg_218_1.actors_[var_221_6.prefab_name] ~= nil then
						local var_221_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_6.prefab_name].transform, "story_v_out_120031", "120031053", "story_v_out_120031.awb")

						arg_218_1:RecordAudio("120031053", var_221_11)
						arg_218_1:RecordAudio("120031053", var_221_11)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_120031", "120031053", "story_v_out_120031.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_120031", "120031053", "story_v_out_120031.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_5, arg_218_1.talkMaxDuration)

			if var_221_4 <= arg_218_1.time_ and arg_218_1.time_ < var_221_4 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_4) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_4 + var_221_12 and arg_218_1.time_ < var_221_4 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play120031054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 120031054
		arg_222_1.duration_ = 10.5

		local var_222_0 = {
			zh = 10.5,
			ja = 9.366
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
				arg_222_0:Play120031055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1075ui_story"]) and arg_222_1.var_.characterEffect1075ui_story == nil then
				arg_222_1.var_.characterEffect1075ui_story = arg_222_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1075ui_story"]) then
				if arg_222_1.var_.characterEffect1075ui_story and not isNil(arg_222_1.actors_["1075ui_story"]) then
					arg_222_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1075ui_story"]) and arg_222_1.var_.characterEffect1075ui_story then
				arg_222_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_225_2 = arg_222_1.actors_["10044ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect10044ui_story == nil then
				arg_222_1.var_.characterEffect10044ui_story = var_225_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_3 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.characterEffect10044ui_story and not isNil(var_225_2) then
					arg_222_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_222_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_222_1.time_ - 0) / var_225_3)
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.characterEffect10044ui_story then
				arg_222_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_222_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_225_4 = 0
			local var_225_5 = 0.925

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(120031054)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 37 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 37)

				if (37 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 37)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031054", "story_v_out_120031.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031054", "story_v_out_120031.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_out_120031", "120031054", "story_v_out_120031.awb")

						arg_222_1:RecordAudio("120031054", var_225_11)
						arg_222_1:RecordAudio("120031054", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_120031", "120031054", "story_v_out_120031.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_120031", "120031054", "story_v_out_120031.awb")
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

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play120031055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 120031055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play120031056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1075ui_story"]) and arg_226_1.var_.characterEffect1075ui_story == nil then
				arg_226_1.var_.characterEffect1075ui_story = arg_226_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1075ui_story"]) then
				if arg_226_1.var_.characterEffect1075ui_story and not isNil(arg_226_1.actors_["1075ui_story"]) then
					arg_226_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1075ui_story"]) and arg_226_1.var_.characterEffect1075ui_story then
				arg_226_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.225

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(120031055).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 9 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 9)

				if (9 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 9)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play120031056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 120031056
		arg_230_1.duration_ = 9.1

		local var_230_0 = {
			zh = 9.1,
			ja = 7.733
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play120031057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1075ui_story = arg_230_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1075ui_story"].transform.position).z)
				arg_230_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1075ui_story"].transform.localEulerAngles = arg_230_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1075ui_story"].transform.position).z)
				arg_230_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1075ui_story"].transform.localEulerAngles = arg_230_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["10044ui_story"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos10044ui_story = var_233_1.localPosition
			end

			local var_233_2 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 then
				var_233_1.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_2)
				var_233_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_1.position).x, (manager.ui.mainCamera.transform.position - var_233_1.position).y, (manager.ui.mainCamera.transform.position - var_233_1.position).z)
				var_233_1.localEulerAngles.z = 0
				var_233_1.localEulerAngles.x = 0
				var_233_1.localEulerAngles = var_233_1.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 then
				var_233_1.localPosition = Vector3.New(0, 100, 0)
				var_233_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_233_1.position).x, (manager.ui.mainCamera.transform.position - var_233_1.position).y, (manager.ui.mainCamera.transform.position - var_233_1.position).z)
				var_233_1.localEulerAngles.z = 0
				var_233_1.localEulerAngles.x = 0
				var_233_1.localEulerAngles = var_233_1.localEulerAngles
			end

			local var_233_3 = 0
			local var_233_4 = 0.825

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_3 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_5 = arg_230_1:GetWordFromCfg(120031056)
				local var_233_6 = arg_230_1:FormatText(var_233_5.content)

				arg_230_1.text_.text = var_233_6

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_8 = 33 <= 0 and var_233_4 or var_233_4 * (utf8.len(var_233_6) / 33)

				if (33 <= 0 and var_233_4 or var_233_4 * (utf8.len(var_233_6) / 33)) > 0 and var_233_4 < var_233_8 then
					arg_230_1.talkMaxDuration = var_233_8

					if var_233_8 + var_233_3 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_3
					end
				end

				arg_230_1.text_.text = var_233_6
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031056", "story_v_out_120031.awb") ~= 0 then
					local var_233_9 = manager.audio:GetVoiceLength("story_v_out_120031", "120031056", "story_v_out_120031.awb") / 1000

					if var_233_9 + var_233_3 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_3
					end

					if var_233_5.prefab_name ~= "" and arg_230_1.actors_[var_233_5.prefab_name] ~= nil then
						local var_233_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_5.prefab_name].transform, "story_v_out_120031", "120031056", "story_v_out_120031.awb")

						arg_230_1:RecordAudio("120031056", var_233_10)
						arg_230_1:RecordAudio("120031056", var_233_10)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_120031", "120031056", "story_v_out_120031.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_120031", "120031056", "story_v_out_120031.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_11 = math.max(var_233_4, arg_230_1.talkMaxDuration)

			if var_233_3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_3 + var_233_11 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_3) / var_233_11

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_3 + var_233_11 and arg_230_1.time_ < var_233_3 + var_233_11 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play120031057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 120031057
		arg_234_1.duration_ = 2.23

		local var_234_0 = {
			zh = 2.233,
			ja = 2
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
				arg_234_0:Play120031058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10044ui_story = arg_234_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10044ui_story"].transform.position).z)
				arg_234_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10044ui_story"].transform.localEulerAngles = arg_234_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, -0.72, -6.3)
				arg_234_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10044ui_story"].transform.position).z)
				arg_234_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10044ui_story"].transform.localEulerAngles = arg_234_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["10044ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect10044ui_story == nil then
				arg_234_1.var_.characterEffect10044ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect10044ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect10044ui_story then
				arg_234_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_237_4 = 0
			local var_237_5 = 0.2

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_6 = arg_234_1:GetWordFromCfg(120031057)
				local var_237_7 = arg_234_1:FormatText(var_237_6.content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 8 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 8)

				if (8 <= 0 and var_237_5 or var_237_5 * (utf8.len(var_237_7) / 8)) > 0 and var_237_5 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031057", "story_v_out_120031.awb") ~= 0 then
					local var_237_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031057", "story_v_out_120031.awb") / 1000

					if var_237_10 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_4
					end

					if var_237_6.prefab_name ~= "" and arg_234_1.actors_[var_237_6.prefab_name] ~= nil then
						local var_237_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_6.prefab_name].transform, "story_v_out_120031", "120031057", "story_v_out_120031.awb")

						arg_234_1:RecordAudio("120031057", var_237_11)
						arg_234_1:RecordAudio("120031057", var_237_11)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_120031", "120031057", "story_v_out_120031.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_120031", "120031057", "story_v_out_120031.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_12 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_12 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_12

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_12 and arg_234_1.time_ < var_237_4 + var_237_12 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play120031058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 120031058
		arg_238_1.duration_ = 7.53

		local var_238_0 = {
			zh = 4.966,
			ja = 7.533
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play120031059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10044ui_story"]) and arg_238_1.var_.characterEffect10044ui_story == nil then
				arg_238_1.var_.characterEffect10044ui_story = arg_238_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10044ui_story"]) then
				if arg_238_1.var_.characterEffect10044ui_story and not isNil(arg_238_1.actors_["10044ui_story"]) then
					arg_238_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10044ui_story"]) and arg_238_1.var_.characterEffect10044ui_story then
				arg_238_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.45

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:GetWordFromCfg(120031058)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 18 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_4) / 18)

				if (18 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_4) / 18)) > 0 and var_241_2 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031058", "story_v_out_120031.awb") ~= 0 then
					local var_241_7 = manager.audio:GetVoiceLength("story_v_out_120031", "120031058", "story_v_out_120031.awb") / 1000

					if var_241_7 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_1
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_120031", "120031058", "story_v_out_120031.awb")

						arg_238_1:RecordAudio("120031058", var_241_8)
						arg_238_1:RecordAudio("120031058", var_241_8)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_120031", "120031058", "story_v_out_120031.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_120031", "120031058", "story_v_out_120031.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_9 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_9 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_9

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_9 and arg_238_1.time_ < var_241_1 + var_241_9 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play120031059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 120031059
		arg_242_1.duration_ = 2.93

		local var_242_0 = {
			zh = 2.6,
			ja = 2.933
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play120031060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["10044ui_story"]) and arg_242_1.var_.characterEffect10044ui_story == nil then
				arg_242_1.var_.characterEffect10044ui_story = arg_242_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["10044ui_story"]) then
				if arg_242_1.var_.characterEffect10044ui_story and not isNil(arg_242_1.actors_["10044ui_story"]) then
					arg_242_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["10044ui_story"]) and arg_242_1.var_.characterEffect10044ui_story then
				arg_242_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_245_2 = 0
			local var_245_3 = 0.225

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_2 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_4 = arg_242_1:GetWordFromCfg(120031059)
				local var_245_5 = arg_242_1:FormatText(var_245_4.content)

				arg_242_1.text_.text = var_245_5

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_7 = 9 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_5) / 9)

				if (9 <= 0 and var_245_3 or var_245_3 * (utf8.len(var_245_5) / 9)) > 0 and var_245_3 < var_245_7 then
					arg_242_1.talkMaxDuration = var_245_7

					if var_245_7 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_7 + var_245_2
					end
				end

				arg_242_1.text_.text = var_245_5
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031059", "story_v_out_120031.awb") ~= 0 then
					local var_245_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031059", "story_v_out_120031.awb") / 1000

					if var_245_8 + var_245_2 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_2
					end

					if var_245_4.prefab_name ~= "" and arg_242_1.actors_[var_245_4.prefab_name] ~= nil then
						local var_245_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_4.prefab_name].transform, "story_v_out_120031", "120031059", "story_v_out_120031.awb")

						arg_242_1:RecordAudio("120031059", var_245_9)
						arg_242_1:RecordAudio("120031059", var_245_9)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_120031", "120031059", "story_v_out_120031.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_120031", "120031059", "story_v_out_120031.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_3, arg_242_1.talkMaxDuration)

			if var_245_2 <= arg_242_1.time_ and arg_242_1.time_ < var_245_2 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_2) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_2 + var_245_10 and arg_242_1.time_ < var_245_2 + var_245_10 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play120031060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 120031060
		arg_246_1.duration_ = 3.9

		local var_246_0 = {
			zh = 2.266,
			ja = 3.9
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play120031061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos10044ui_story = arg_246_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_249_0 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				arg_246_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_246_1.time_ - 0) / var_249_0)
				arg_246_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10044ui_story"].transform.position).z)
				arg_246_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["10044ui_story"].transform.localEulerAngles = arg_246_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				arg_246_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_246_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["10044ui_story"].transform.position).z)
				arg_246_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["10044ui_story"].transform.localEulerAngles = arg_246_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_249_1 = arg_246_1.actors_["1069ui_story"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1069ui_story = var_249_1.localPosition
			end

			local var_249_2 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_2 then
				var_249_1.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1069ui_story, Vector3.New(-0.7, -1, -6), (arg_246_1.time_ - 0) / var_249_2)
				var_249_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_1.position).x, (manager.ui.mainCamera.transform.position - var_249_1.position).y, (manager.ui.mainCamera.transform.position - var_249_1.position).z)
				var_249_1.localEulerAngles.z = 0
				var_249_1.localEulerAngles.x = 0
				var_249_1.localEulerAngles = var_249_1.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_2 and arg_246_1.time_ < 0 + var_249_2 + arg_249_0 then
				var_249_1.localPosition = Vector3.New(-0.7, -1, -6)
				var_249_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_1.position).x, (manager.ui.mainCamera.transform.position - var_249_1.position).y, (manager.ui.mainCamera.transform.position - var_249_1.position).z)
				var_249_1.localEulerAngles.z = 0
				var_249_1.localEulerAngles.x = 0
				var_249_1.localEulerAngles = var_249_1.localEulerAngles
			end

			local var_249_3 = arg_246_1.actors_["1069ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_3) and arg_246_1.var_.characterEffect1069ui_story == nil then
				arg_246_1.var_.characterEffect1069ui_story = var_249_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_4 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_4 and not isNil(var_249_3) then
				if arg_246_1.var_.characterEffect1069ui_story and not isNil(var_249_3) then
					arg_246_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_4 and arg_246_1.time_ < 0 + var_249_4 + arg_249_0 and not isNil(var_249_3) and arg_246_1.var_.characterEffect1069ui_story then
				arg_246_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_249_6 = arg_246_1.actors_["1084ui_story"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1084ui_story = var_249_6.localPosition
			end

			local var_249_7 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				var_249_6.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_246_1.time_ - 0) / var_249_7)
				var_249_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_6.position).x, (manager.ui.mainCamera.transform.position - var_249_6.position).y, (manager.ui.mainCamera.transform.position - var_249_6.position).z)
				var_249_6.localEulerAngles.z = 0
				var_249_6.localEulerAngles.x = 0
				var_249_6.localEulerAngles = var_249_6.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				var_249_6.localPosition = Vector3.New(0.7, -0.97, -6)
				var_249_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_249_6.position).x, (manager.ui.mainCamera.transform.position - var_249_6.position).y, (manager.ui.mainCamera.transform.position - var_249_6.position).z)
				var_249_6.localEulerAngles.z = 0
				var_249_6.localEulerAngles.x = 0
				var_249_6.localEulerAngles = var_249_6.localEulerAngles
			end

			local var_249_8 = arg_246_1.actors_["1084ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_8) and arg_246_1.var_.characterEffect1084ui_story == nil then
				arg_246_1.var_.characterEffect1084ui_story = var_249_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_9 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_9 and not isNil(var_249_8) then
				if arg_246_1.var_.characterEffect1084ui_story and not isNil(var_249_8) then
					arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_9)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_9 and arg_246_1.time_ < 0 + var_249_9 + arg_249_0 and not isNil(var_249_8) and arg_246_1.var_.characterEffect1084ui_story then
				arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_249_10 = 0
			local var_249_11 = 0.25

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_12 = arg_246_1:GetWordFromCfg(120031060)
				local var_249_13 = arg_246_1:FormatText(var_249_12.content)

				arg_246_1.text_.text = var_249_13

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_15 = 10 <= 0 and var_249_11 or var_249_11 * (utf8.len(var_249_13) / 10)

				if (10 <= 0 and var_249_11 or var_249_11 * (utf8.len(var_249_13) / 10)) > 0 and var_249_11 < var_249_15 then
					arg_246_1.talkMaxDuration = var_249_15

					if var_249_15 + var_249_10 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_15 + var_249_10
					end
				end

				arg_246_1.text_.text = var_249_13
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031060", "story_v_out_120031.awb") ~= 0 then
					local var_249_16 = manager.audio:GetVoiceLength("story_v_out_120031", "120031060", "story_v_out_120031.awb") / 1000

					if var_249_16 + var_249_10 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_16 + var_249_10
					end

					if var_249_12.prefab_name ~= "" and arg_246_1.actors_[var_249_12.prefab_name] ~= nil then
						local var_249_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_12.prefab_name].transform, "story_v_out_120031", "120031060", "story_v_out_120031.awb")

						arg_246_1:RecordAudio("120031060", var_249_17)
						arg_246_1:RecordAudio("120031060", var_249_17)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_120031", "120031060", "story_v_out_120031.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_120031", "120031060", "story_v_out_120031.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_18 = math.max(var_249_11, arg_246_1.talkMaxDuration)

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_18 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_10) / var_249_18

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_10 + var_249_18 and arg_246_1.time_ < var_249_10 + var_249_18 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play120031061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 120031061
		arg_250_1.duration_ = 4.07

		local var_250_0 = {
			zh = 2.966,
			ja = 4.066
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play120031062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["1069ui_story"]) and arg_250_1.var_.characterEffect1069ui_story == nil then
				arg_250_1.var_.characterEffect1069ui_story = arg_250_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["1069ui_story"]) then
				if arg_250_1.var_.characterEffect1069ui_story and not isNil(arg_250_1.actors_["1069ui_story"]) then
					arg_250_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_0)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["1069ui_story"]) and arg_250_1.var_.characterEffect1069ui_story then
				arg_250_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_253_1 = arg_250_1.actors_["1084ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1084ui_story == nil then
				arg_250_1.var_.characterEffect1084ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect1084ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1084ui_story then
				arg_250_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_253_4 = 0
			local var_253_5 = 0.425

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_6 = arg_250_1:GetWordFromCfg(120031061)
				local var_253_7 = arg_250_1:FormatText(var_253_6.content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 17 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 17)

				if (17 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 17)) > 0 and var_253_5 < var_253_9 then
					arg_250_1.talkMaxDuration = var_253_9

					if var_253_9 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_9 + var_253_4
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031061", "story_v_out_120031.awb") ~= 0 then
					local var_253_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031061", "story_v_out_120031.awb") / 1000

					if var_253_10 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_4
					end

					if var_253_6.prefab_name ~= "" and arg_250_1.actors_[var_253_6.prefab_name] ~= nil then
						local var_253_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_6.prefab_name].transform, "story_v_out_120031", "120031061", "story_v_out_120031.awb")

						arg_250_1:RecordAudio("120031061", var_253_11)
						arg_250_1:RecordAudio("120031061", var_253_11)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_120031", "120031061", "story_v_out_120031.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_120031", "120031061", "story_v_out_120031.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_12 = math.max(var_253_5, arg_250_1.talkMaxDuration)

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_12 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_4) / var_253_12

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_4 + var_253_12 and arg_250_1.time_ < var_253_4 + var_253_12 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play120031062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 120031062
		arg_254_1.duration_ = 7.07

		local var_254_0 = {
			zh = 5.266,
			ja = 7.066
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play120031063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1069ui_story"]) and arg_254_1.var_.characterEffect1069ui_story == nil then
				arg_254_1.var_.characterEffect1069ui_story = arg_254_1.actors_["1069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1069ui_story"]) then
				if arg_254_1.var_.characterEffect1069ui_story and not isNil(arg_254_1.actors_["1069ui_story"]) then
					arg_254_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1069ui_story"]) and arg_254_1.var_.characterEffect1069ui_story then
				arg_254_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_257_2 = arg_254_1.actors_["1084ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.characterEffect1084ui_story == nil then
				arg_254_1.var_.characterEffect1084ui_story = var_257_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_3 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_3 and not isNil(var_257_2) then
				if arg_254_1.var_.characterEffect1084ui_story and not isNil(var_257_2) then
					arg_254_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_254_1.time_ - 0) / var_257_3)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_3 and arg_254_1.time_ < 0 + var_257_3 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.characterEffect1084ui_story then
				arg_254_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_257_4 = 0
			local var_257_5 = 0.6

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[378].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(120031062)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 24 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 24)

				if (24 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 24)) > 0 and var_257_5 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031062", "story_v_out_120031.awb") ~= 0 then
					local var_257_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031062", "story_v_out_120031.awb") / 1000

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end

					if var_257_6.prefab_name ~= "" and arg_254_1.actors_[var_257_6.prefab_name] ~= nil then
						local var_257_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_6.prefab_name].transform, "story_v_out_120031", "120031062", "story_v_out_120031.awb")

						arg_254_1:RecordAudio("120031062", var_257_11)
						arg_254_1:RecordAudio("120031062", var_257_11)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_120031", "120031062", "story_v_out_120031.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_120031", "120031062", "story_v_out_120031.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_12 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_12 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_12

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_12 and arg_254_1.time_ < var_257_4 + var_257_12 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play120031063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 120031063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play120031064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1069ui_story = arg_258_1.actors_["1069ui_story"].transform.localPosition
			end

			local var_261_0 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 then
				arg_258_1.actors_["1069ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1069ui_story, Vector3.New(0, 100, 0), (arg_258_1.time_ - 0) / var_261_0)
				arg_258_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1069ui_story"].transform.position).z)
				arg_258_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1069ui_story"].transform.localEulerAngles = arg_258_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 then
				arg_258_1.actors_["1069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.actors_["1069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["1069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["1069ui_story"].transform.position).z)
				arg_258_1.actors_["1069ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["1069ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["1069ui_story"].transform.localEulerAngles = arg_258_1.actors_["1069ui_story"].transform.localEulerAngles
			end

			local var_261_1 = arg_258_1.actors_["1084ui_story"].transform

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos1084ui_story = var_261_1.localPosition
			end

			local var_261_2 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 then
				var_261_1.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_258_1.time_ - 0) / var_261_2)
				var_261_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_1.position).x, (manager.ui.mainCamera.transform.position - var_261_1.position).y, (manager.ui.mainCamera.transform.position - var_261_1.position).z)
				var_261_1.localEulerAngles.z = 0
				var_261_1.localEulerAngles.x = 0
				var_261_1.localEulerAngles = var_261_1.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 then
				var_261_1.localPosition = Vector3.New(0, 100, 0)
				var_261_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_261_1.position).x, (manager.ui.mainCamera.transform.position - var_261_1.position).y, (manager.ui.mainCamera.transform.position - var_261_1.position).z)
				var_261_1.localEulerAngles.z = 0
				var_261_1.localEulerAngles.x = 0
				var_261_1.localEulerAngles = var_261_1.localEulerAngles
			end

			local var_261_3 = 0
			local var_261_4 = 0.8

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_3 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_5 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(120031063).content)

				arg_258_1.text_.text = var_261_5

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_7 = 32 <= 0 and var_261_4 or var_261_4 * (utf8.len(var_261_5) / 32)

				if (32 <= 0 and var_261_4 or var_261_4 * (utf8.len(var_261_5) / 32)) > 0 and var_261_4 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_3 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_3
					end
				end

				arg_258_1.text_.text = var_261_5
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_8 = math.max(var_261_4, arg_258_1.talkMaxDuration)

			if var_261_3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_3 + var_261_8 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_3) / var_261_8

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_3 + var_261_8 and arg_258_1.time_ < var_261_3 + var_261_8 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play120031064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 120031064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play120031065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0.375

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(120031064).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 15 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 15)

				if (15 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 15)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play120031065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 120031065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play120031066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_machinehitch", "")
			end

			local var_269_1 = 0
			local var_269_2 = 0.175

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2088")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(120031065).content)

				arg_266_1.text_.text = var_269_3

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 7 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 7)

				if (7 <= 0 and var_269_2 or var_269_2 * (utf8.len(var_269_3) / 7)) > 0 and var_269_2 < var_269_5 then
					arg_266_1.talkMaxDuration = var_269_5

					if var_269_5 + var_269_1 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + var_269_1
					end
				end

				arg_266_1.text_.text = var_269_3
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_6 = math.max(var_269_2, arg_266_1.talkMaxDuration)

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_6 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_1) / var_269_6

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_1 + var_269_6 and arg_266_1.time_ < var_269_1 + var_269_6 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play120031066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 120031066
		arg_270_1.duration_ = 12.07

		local var_270_0 = {
			zh = 10.266,
			ja = 12.066
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play120031067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos10044ui_story = arg_270_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["10044ui_story"].transform.position).z)
				arg_270_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["10044ui_story"].transform.localEulerAngles = arg_270_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, -0.72, -6.3)
				arg_270_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["10044ui_story"].transform.position).z)
				arg_270_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["10044ui_story"].transform.localEulerAngles = arg_270_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_273_1 = arg_270_1.actors_["10044ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect10044ui_story == nil then
				arg_270_1.var_.characterEffect10044ui_story = var_273_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_2 and not isNil(var_273_1) then
				if arg_270_1.var_.characterEffect10044ui_story and not isNil(var_273_1) then
					arg_270_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_2 and arg_270_1.time_ < 0 + var_273_2 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect10044ui_story then
				arg_270_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_273_4 = 0
			local var_273_5 = 1.35

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(120031066)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 53 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 53)

				if (53 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 53)) > 0 and var_273_5 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031066", "story_v_out_120031.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031066", "story_v_out_120031.awb") / 1000

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end

					if var_273_6.prefab_name ~= "" and arg_270_1.actors_[var_273_6.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_6.prefab_name].transform, "story_v_out_120031", "120031066", "story_v_out_120031.awb")

						arg_270_1:RecordAudio("120031066", var_273_11)
						arg_270_1:RecordAudio("120031066", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_120031", "120031066", "story_v_out_120031.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_120031", "120031066", "story_v_out_120031.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_12 and arg_270_1.time_ < var_273_4 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play120031067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 120031067
		arg_274_1.duration_ = 8.03

		local var_274_0 = {
			zh = 8.033,
			ja = 6
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play120031068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["10044ui_story"]) and arg_274_1.var_.characterEffect10044ui_story == nil then
				arg_274_1.var_.characterEffect10044ui_story = arg_274_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["10044ui_story"]) then
				if arg_274_1.var_.characterEffect10044ui_story and not isNil(arg_274_1.actors_["10044ui_story"]) then
					arg_274_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["10044ui_story"]) and arg_274_1.var_.characterEffect10044ui_story then
				arg_274_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_277_2 = 0
			local var_277_3 = 0.8

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(120031067)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 32 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 32)

				if (32 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 32)) > 0 and var_277_3 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031067", "story_v_out_120031.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031067", "story_v_out_120031.awb") / 1000

					if var_277_8 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_2
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_out_120031", "120031067", "story_v_out_120031.awb")

						arg_274_1:RecordAudio("120031067", var_277_9)
						arg_274_1:RecordAudio("120031067", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_120031", "120031067", "story_v_out_120031.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_120031", "120031067", "story_v_out_120031.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_10 and arg_274_1.time_ < var_277_2 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play120031068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 120031068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play120031069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos10044ui_story = arg_278_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				arg_278_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["10044ui_story"].transform.position).z)
				arg_278_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["10044ui_story"].transform.localEulerAngles = arg_278_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["10044ui_story"].transform.position).z)
				arg_278_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["10044ui_story"].transform.localEulerAngles = arg_278_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_281_1 = 0
			local var_281_2 = 0.25

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(120031068).content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 10 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_3) / 10)

				if (10 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_3) / 10)) > 0 and var_281_2 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_1
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_6 = math.max(var_281_2, arg_278_1.talkMaxDuration)

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_6 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_1) / var_281_6

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_1 + var_281_6 and arg_278_1.time_ < var_281_1 + var_281_6 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play120031069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 120031069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play120031070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:AudioAction("play", "effect", "se_story_side_1037", "se_story_1037_electric", "")
			end

			local var_285_1 = 0
			local var_285_2 = 0.2

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2088")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(120031069).content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 8 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 8)

				if (8 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 8)) > 0 and var_285_2 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_6 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_6 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_6

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_6 and arg_282_1.time_ < var_285_1 + var_285_6 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play120031070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 120031070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
			arg_286_1.auto_ = false
		end

		function arg_286_1.playNext_(arg_288_0)
			arg_286_1.onStoryFinished_()
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_289_0 = 0.6

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 then
				local var_289_1, var_289_2 = math.modf((arg_286_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_289_2 * 0.13, var_289_2 * 0.13, var_289_2 * 0.13) + arg_286_1.var_.shakeOldPos
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 then
				manager.ui.mainCamera.transform.localPosition = arg_286_1.var_.shakeOldPos
			end

			local var_289_3 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_3 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			if arg_286_1.time_ >= var_289_3 + 0.6 and arg_286_1.time_ < var_289_3 + 0.6 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			local var_289_4 = 0
			local var_289_5 = 0.275

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_6 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(120031070).content)

				arg_286_1.text_.text = var_289_6

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_8 = 11 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_6) / 11)

				if (11 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_6) / 11)) > 0 and var_289_5 < var_289_8 then
					arg_286_1.talkMaxDuration = var_289_8

					if var_289_8 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_4
					end
				end

				arg_286_1.text_.text = var_289_6
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_9 = math.max(var_289_5, arg_286_1.talkMaxDuration)

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_9 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_4) / var_289_9

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_4 + var_289_9 and arg_286_1.time_ < var_289_4 + var_289_9 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J02f",
		"TextureConfig/Background/J02h"
	},
	voices = {
		"story_v_out_120031.awb"
	}
}
