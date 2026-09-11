return {
	Play104111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_4", "se_story_4_collapse", "")
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

			local var_4_9 = "S0404"

			if arg_1_1.bgs_.S0404 == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.S0404

				arg_1_1.bgs_.S0404.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0404" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_14 = manager.ui.mainCamera.transform

			if 1.6 < arg_1_1.time_ and arg_1_1.time_ <= 1.6 + arg_4_0 then
				arg_1_1.var_.shakeOldPosMainCamera = var_4_14.localPosition
			end

			local var_4_15 = 1

			if 1.6 <= arg_1_1.time_ and arg_1_1.time_ < 1.6 + var_4_15 then
				local var_4_16, var_4_17 = math.modf((arg_1_1.time_ - 1.6) / 0.066)

				var_4_14.localPosition = Vector3.New(var_4_17 * 0.13, var_4_17 * 0.13, var_4_17 * 0.13) + arg_1_1.var_.shakeOldPosMainCamera
			end

			if arg_1_1.time_ >= 1.6 + var_4_15 and arg_1_1.time_ < 1.6 + var_4_15 + arg_4_0 then
				var_4_14.localPosition = arg_1_1.var_.shakeOldPosMainCamera
			end

			local var_4_18 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_18 + 0.6 and arg_1_1.time_ < var_4_18 + 0.6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.15

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(104111001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 6 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 6)

				if (6 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 6)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play104111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104111002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.425

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(104111002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 57 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 57)

				if (57 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 57)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play104111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104111003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.4

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(104111003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 16 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 16)

				if (16 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 16)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play104111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104111004
		arg_16_1.duration_ = 9.8

		local var_16_0 = {
			ja = 8.833,
			ko = 8.333,
			zh = 9.133,
			en = 9.8
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
				arg_16_0:Play104111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1037ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1037ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1037ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1037ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1037ui_story"]

			if 3.8 < arg_16_1.time_ and arg_16_1.time_ <= 3.8 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1037ui_story == nil then
				arg_16_1.var_.characterEffect1037ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 3.8 <= arg_16_1.time_ and arg_16_1.time_ < 3.8 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1037ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 3.8 + var_19_4 and arg_16_1.time_ < 3.8 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1037ui_story then
				arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_19_6 = 0

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_7 = 2

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = Color.New(0, 0, 0)

				var_19_8.a = Mathf.Lerp(0, 1, (arg_16_1.time_ - var_19_6) / var_19_7)
				arg_16_1.mask_.color = var_19_8
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				local var_19_9 = Color.New(0, 0, 0)

				var_19_9.a = 1
				arg_16_1.mask_.color = var_19_9
			end

			local var_19_10 = 2

			if 2 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_11 = 2

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 then
				local var_19_12 = Color.New(0, 0, 0)

				var_19_12.a = Mathf.Lerp(1, 0, (arg_16_1.time_ - var_19_10) / var_19_11)
				arg_16_1.mask_.color = var_19_12
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 then
				local var_19_13 = Color.New(0, 0, 0)

				arg_16_1.mask_.enabled = false
				var_19_13.a = 0
				arg_16_1.mask_.color = var_19_13
			end

			local var_19_14 = "A00"

			if arg_16_1.bgs_.A00 == nil then
				local var_19_15 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_14)
				var_19_15.name = var_19_14
				var_19_15.transform.parent = arg_16_1.stage_.transform
				var_19_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_14] = var_19_15
			end

			if 2 < arg_16_1.time_ and arg_16_1.time_ <= 2 + arg_19_0 then
				local var_19_16 = arg_16_1.bgs_.A00

				arg_16_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_19_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_17 = var_19_16:GetComponent("SpriteRenderer")

				if var_19_17 and var_19_17.sprite then
					local var_19_18 = 2 * (var_19_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_19_16.transform.localScale = Vector3.New(var_19_18 / var_19_17.sprite.bounds.size.y < var_19_18 * manager.ui.mainCameraCom_.aspect / var_19_17.sprite.bounds.size.x and var_19_18 * manager.ui.mainCameraCom_.aspect / var_19_17.sprite.bounds.size.x or var_19_18 / var_19_17.sprite.bounds.size.y, var_19_18 / var_19_17.sprite.bounds.size.y < var_19_18 * manager.ui.mainCameraCom_.aspect / var_19_17.sprite.bounds.size.x and var_19_18 * manager.ui.mainCameraCom_.aspect / var_19_17.sprite.bounds.size.x or var_19_18 / var_19_17.sprite.bounds.size.y, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "A00" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 3.8 < arg_16_1.time_ and arg_16_1.time_ <= 3.8 + arg_19_0 then
				arg_16_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_19_19 = arg_16_1.actors_["1037ui_story"].transform

			if 3.8 < arg_16_1.time_ and arg_16_1.time_ <= 3.8 + arg_19_0 then
				arg_16_1.var_.moveOldPos1037ui_story = var_19_19.localPosition
			end

			local var_19_20 = 0.001

			if 3.8 <= arg_16_1.time_ and arg_16_1.time_ < 3.8 + var_19_20 then
				var_19_19.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_16_1.time_ - 3.8) / var_19_20)
				var_19_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_19.position).x, (manager.ui.mainCamera.transform.position - var_19_19.position).y, (manager.ui.mainCamera.transform.position - var_19_19.position).z)
				var_19_19.localEulerAngles.z = 0
				var_19_19.localEulerAngles.x = 0
				var_19_19.localEulerAngles = var_19_19.localEulerAngles
			end

			if arg_16_1.time_ >= 3.8 + var_19_20 and arg_16_1.time_ < 3.8 + var_19_20 + arg_19_0 then
				var_19_19.localPosition = Vector3.New(0, -1.09, -5.81)
				var_19_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_19.position).x, (manager.ui.mainCamera.transform.position - var_19_19.position).y, (manager.ui.mainCamera.transform.position - var_19_19.position).z)
				var_19_19.localEulerAngles.z = 0
				var_19_19.localEulerAngles.x = 0
				var_19_19.localEulerAngles = var_19_19.localEulerAngles
			end

			if 3.8 < arg_16_1.time_ and arg_16_1.time_ <= 3.8 + arg_19_0 then
				arg_16_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_21 = 4
			local var_19_22 = 0.4

			if 4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_23 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_23:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_24 = arg_16_1:GetWordFromCfg(104111004)
				local var_19_25 = arg_16_1:FormatText(var_19_24.content)

				arg_16_1.text_.text = var_19_25

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_27 = 16 <= 0 and var_19_22 or var_19_22 * (utf8.len(var_19_25) / 16)

				if (16 <= 0 and var_19_22 or var_19_22 * (utf8.len(var_19_25) / 16)) > 0 and var_19_22 < var_19_27 then
					arg_16_1.talkMaxDuration = var_19_27
					var_19_21 = var_19_21 + 0.3

					if var_19_27 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_21
					end
				end

				arg_16_1.text_.text = var_19_25
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111004", "story_v_out_104111.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_out_104111", "104111004", "story_v_out_104111.awb") / 1000

					if var_19_28 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_21
					end

					if var_19_24.prefab_name ~= "" and arg_16_1.actors_[var_19_24.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_24.prefab_name].transform, "story_v_out_104111", "104111004", "story_v_out_104111.awb")

						arg_16_1:RecordAudio("104111004", var_19_29)
						arg_16_1:RecordAudio("104111004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104111", "104111004", "story_v_out_104111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104111", "104111004", "story_v_out_104111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_30 = var_19_21 + 0.3
			local var_19_31 = math.max(var_19_22, arg_16_1.talkMaxDuration)

			if var_19_21 + 0.3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_30 + var_19_31 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_30) / var_19_31

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_30 + var_19_31 and arg_16_1.time_ < var_19_30 + var_19_31 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104111005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 104111005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play104111006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["1037ui_story"]) and arg_22_1.var_.characterEffect1037ui_story == nil then
				arg_22_1.var_.characterEffect1037ui_story = arg_22_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_0 = 0.1

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["1037ui_story"]) then
				if arg_22_1.var_.characterEffect1037ui_story and not isNil(arg_22_1.actors_["1037ui_story"]) then
					arg_22_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_22_1.time_ - 0) / var_25_0)
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["1037ui_story"]) and arg_22_1.var_.characterEffect1037ui_story then
				arg_22_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_25_1 = arg_22_1.actors_["1037ui_story"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1037ui_story = var_25_1.localPosition
			end

			local var_25_2 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_2 then
				var_25_1.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_22_1.time_ - 0) / var_25_2)
				var_25_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_1.position).x, (manager.ui.mainCamera.transform.position - var_25_1.position).y, (manager.ui.mainCamera.transform.position - var_25_1.position).z)
				var_25_1.localEulerAngles.z = 0
				var_25_1.localEulerAngles.x = 0
				var_25_1.localEulerAngles = var_25_1.localEulerAngles
			end

			if arg_22_1.time_ >= 0 + var_25_2 and arg_22_1.time_ < 0 + var_25_2 + arg_25_0 then
				var_25_1.localPosition = Vector3.New(0, 100, 0)
				var_25_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_1.position).x, (manager.ui.mainCamera.transform.position - var_25_1.position).y, (manager.ui.mainCamera.transform.position - var_25_1.position).z)
				var_25_1.localEulerAngles.z = 0
				var_25_1.localEulerAngles.x = 0
				var_25_1.localEulerAngles = var_25_1.localEulerAngles
			end

			local var_25_3 = 0
			local var_25_4 = 0.375

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_3 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_5 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(104111005).content)

				arg_22_1.text_.text = var_25_5

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_7 = 15 <= 0 and var_25_4 or var_25_4 * (utf8.len(var_25_5) / 15)

				if (15 <= 0 and var_25_4 or var_25_4 * (utf8.len(var_25_5) / 15)) > 0 and var_25_4 < var_25_7 then
					arg_22_1.talkMaxDuration = var_25_7

					if var_25_7 + var_25_3 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_7 + var_25_3
					end
				end

				arg_22_1.text_.text = var_25_5
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_8 = math.max(var_25_4, arg_22_1.talkMaxDuration)

			if var_25_3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_3 + var_25_8 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_3) / var_25_8

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_3 + var_25_8 and arg_22_1.time_ < var_25_3 + var_25_8 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play104111006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 104111006
		arg_26_1.duration_ = 5.77

		local var_26_0 = {
			ja = 5.766,
			ko = 4.366,
			zh = 4.2,
			en = 5
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play104111007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.525

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(104111006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 21 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 21)

				if (21 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 21)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111006", "story_v_out_104111.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_104111", "104111006", "story_v_out_104111.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_104111", "104111006", "story_v_out_104111.awb")

						arg_26_1:RecordAudio("104111006", var_29_6)
						arg_26_1:RecordAudio("104111006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_104111", "104111006", "story_v_out_104111.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_104111", "104111006", "story_v_out_104111.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play104111007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 104111007
		arg_30_1.duration_ = 5.03

		local var_30_0 = {
			ja = 3.3,
			ko = 5.033,
			zh = 4.5,
			en = 2.566
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
				arg_30_0:Play104111008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1037ui_story"]) and arg_30_1.var_.characterEffect1037ui_story == nil then
				arg_30_1.var_.characterEffect1037ui_story = arg_30_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.1

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1037ui_story"]) then
				if arg_30_1.var_.characterEffect1037ui_story and not isNil(arg_30_1.actors_["1037ui_story"]) then
					arg_30_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1037ui_story"]) and arg_30_1.var_.characterEffect1037ui_story then
				arg_30_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_33_2 = arg_30_1.actors_["1037ui_story"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos1037ui_story = var_33_2.localPosition
			end

			local var_33_3 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_3 then
				var_33_2.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_30_1.time_ - 0) / var_33_3)
				var_33_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_33_2.position).x, (manager.ui.mainCamera.transform.position - var_33_2.position).y, (manager.ui.mainCamera.transform.position - var_33_2.position).z)
				var_33_2.localEulerAngles.z = 0
				var_33_2.localEulerAngles.x = 0
				var_33_2.localEulerAngles = var_33_2.localEulerAngles
			end

			if arg_30_1.time_ >= 0 + var_33_3 and arg_30_1.time_ < 0 + var_33_3 + arg_33_0 then
				var_33_2.localPosition = Vector3.New(0, -1.09, -5.81)
				var_33_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_33_2.position).x, (manager.ui.mainCamera.transform.position - var_33_2.position).y, (manager.ui.mainCamera.transform.position - var_33_2.position).z)
				var_33_2.localEulerAngles.z = 0
				var_33_2.localEulerAngles.x = 0
				var_33_2.localEulerAngles = var_33_2.localEulerAngles
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action7_1")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_33_4 = 0
			local var_33_5 = 0.425

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(104111007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 16 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 16)

				if (16 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 16)) > 0 and var_33_5 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111007", "story_v_out_104111.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_out_104111", "104111007", "story_v_out_104111.awb") / 1000

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end

					if var_33_6.prefab_name ~= "" and arg_30_1.actors_[var_33_6.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_6.prefab_name].transform, "story_v_out_104111", "104111007", "story_v_out_104111.awb")

						arg_30_1:RecordAudio("104111007", var_33_11)
						arg_30_1:RecordAudio("104111007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_104111", "104111007", "story_v_out_104111.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_104111", "104111007", "story_v_out_104111.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_12 and arg_30_1.time_ < var_33_4 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play104111008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 104111008
		arg_34_1.duration_ = 6.83

		local var_34_0 = {
			ja = 5.233,
			ko = 5.933,
			zh = 5.8,
			en = 6.833
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play104111009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1037ui_story"]) and arg_34_1.var_.characterEffect1037ui_story == nil then
				arg_34_1.var_.characterEffect1037ui_story = arg_34_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.1

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1037ui_story"]) then
				if arg_34_1.var_.characterEffect1037ui_story and not isNil(arg_34_1.actors_["1037ui_story"]) then
					arg_34_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_0)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1037ui_story"]) and arg_34_1.var_.characterEffect1037ui_story then
				arg_34_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_37_1 = arg_34_1.actors_["1037ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1037ui_story = var_37_1.localPosition
			end

			local var_37_2 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_2 then
				var_37_1.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_2)
				var_37_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_1.position).x, (manager.ui.mainCamera.transform.position - var_37_1.position).y, (manager.ui.mainCamera.transform.position - var_37_1.position).z)
				var_37_1.localEulerAngles.z = 0
				var_37_1.localEulerAngles.x = 0
				var_37_1.localEulerAngles = var_37_1.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_2 and arg_34_1.time_ < 0 + var_37_2 + arg_37_0 then
				var_37_1.localPosition = Vector3.New(0, 100, 0)
				var_37_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_1.position).x, (manager.ui.mainCamera.transform.position - var_37_1.position).y, (manager.ui.mainCamera.transform.position - var_37_1.position).z)
				var_37_1.localEulerAngles.z = 0
				var_37_1.localEulerAngles.x = 0
				var_37_1.localEulerAngles = var_37_1.localEulerAngles
			end

			local var_37_3 = 0
			local var_37_4 = 0.775

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_3 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_5 = arg_34_1:GetWordFromCfg(104111008)
				local var_37_6 = arg_34_1:FormatText(var_37_5.content)

				arg_34_1.text_.text = var_37_6

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_8 = 31 <= 0 and var_37_4 or var_37_4 * (utf8.len(var_37_6) / 31)

				if (31 <= 0 and var_37_4 or var_37_4 * (utf8.len(var_37_6) / 31)) > 0 and var_37_4 < var_37_8 then
					arg_34_1.talkMaxDuration = var_37_8

					if var_37_8 + var_37_3 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_3
					end
				end

				arg_34_1.text_.text = var_37_6
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111008", "story_v_out_104111.awb") ~= 0 then
					local var_37_9 = manager.audio:GetVoiceLength("story_v_out_104111", "104111008", "story_v_out_104111.awb") / 1000

					if var_37_9 + var_37_3 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_3
					end

					if var_37_5.prefab_name ~= "" and arg_34_1.actors_[var_37_5.prefab_name] ~= nil then
						local var_37_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_5.prefab_name].transform, "story_v_out_104111", "104111008", "story_v_out_104111.awb")

						arg_34_1:RecordAudio("104111008", var_37_10)
						arg_34_1:RecordAudio("104111008", var_37_10)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_104111", "104111008", "story_v_out_104111.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_104111", "104111008", "story_v_out_104111.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_11 = math.max(var_37_4, arg_34_1.talkMaxDuration)

			if var_37_3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_3 + var_37_11 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_3) / var_37_11

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_3 + var_37_11 and arg_34_1.time_ < var_37_3 + var_37_11 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play104111009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 104111009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play104111010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.15

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_1 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(104111009).content)

				arg_38_1.text_.text = var_41_1

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_3 = 6 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 6)

				if (6 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_1) / 6)) > 0 and var_41_0 < var_41_3 then
					arg_38_1.talkMaxDuration = var_41_3

					if var_41_3 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_3 + 0
					end
				end

				arg_38_1.text_.text = var_41_1
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_4 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_4

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play104111010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 104111010
		arg_42_1.duration_ = 8.97

		local var_42_0 = {
			ja = 8.966,
			ko = 6.4,
			zh = 5.333,
			en = 6.333
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play104111011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if arg_42_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_45_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_42_1.stage_.transform)

				var_45_0.name = "1080ui_story"
				var_45_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.actors_["1080ui_story"] = var_45_0

				local var_45_1 = var_45_0:GetComponentInChildren(typeof(CharacterEffect))

				var_45_1.enabled = true

				local var_45_2 = GameObjectTools.GetOrAddComponent(var_45_0, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(false)
				end

				arg_42_1:ShowWeapon(var_45_1.transform, false)

				arg_42_1.var_["1080ui_story" .. "Animator"] = var_45_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_42_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_42_1.var_["1080ui_story" .. "LipSync"] = var_45_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_45_3 = arg_42_1.actors_["1080ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect1080ui_story == nil then
				arg_42_1.var_.characterEffect1080ui_story = var_45_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.1

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 and not isNil(var_45_3) then
				if arg_42_1.var_.characterEffect1080ui_story and not isNil(var_45_3) then
					arg_42_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect1080ui_story then
				arg_42_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_45_6 = 0
			local var_45_7 = 0.75

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_8 = arg_42_1:GetWordFromCfg(104111010)
				local var_45_9 = arg_42_1:FormatText(var_45_8.content)

				arg_42_1.text_.text = var_45_9

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 30 <= 0 and var_45_7 or var_45_7 * (utf8.len(var_45_9) / 30)

				if (30 <= 0 and var_45_7 or var_45_7 * (utf8.len(var_45_9) / 30)) > 0 and var_45_7 < var_45_11 then
					arg_42_1.talkMaxDuration = var_45_11

					if var_45_11 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_9
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111010", "story_v_out_104111.awb") ~= 0 then
					local var_45_12 = manager.audio:GetVoiceLength("story_v_out_104111", "104111010", "story_v_out_104111.awb") / 1000

					if var_45_12 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_12 + var_45_6
					end

					if var_45_8.prefab_name ~= "" and arg_42_1.actors_[var_45_8.prefab_name] ~= nil then
						local var_45_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_8.prefab_name].transform, "story_v_out_104111", "104111010", "story_v_out_104111.awb")

						arg_42_1:RecordAudio("104111010", var_45_13)
						arg_42_1:RecordAudio("104111010", var_45_13)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_104111", "104111010", "story_v_out_104111.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_104111", "104111010", "story_v_out_104111.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_14 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_14 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_14

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_14 and arg_42_1.time_ < var_45_6 + var_45_14 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play104111011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 104111011
		arg_46_1.duration_ = 7.2

		local var_46_0 = {
			ja = 7.2,
			ko = 4.666,
			zh = 7.1,
			en = 6.5
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play104111012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if arg_46_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_49_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_46_1.stage_.transform)

				var_49_0.name = "1027ui_story"
				var_49_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["1027ui_story"] = var_49_0

				local var_49_1 = var_49_0:GetComponentInChildren(typeof(CharacterEffect))

				var_49_1.enabled = true

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end

				arg_46_1:ShowWeapon(var_49_1.transform, false)

				arg_46_1.var_["1027ui_story" .. "Animator"] = var_49_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_46_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_46_1.var_["1027ui_story" .. "LipSync"] = var_49_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_49_3 = arg_46_1.actors_["1027ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_3) and arg_46_1.var_.characterEffect1027ui_story == nil then
				arg_46_1.var_.characterEffect1027ui_story = var_49_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_4 = 0.1

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 and not isNil(var_49_3) then
				if arg_46_1.var_.characterEffect1027ui_story and not isNil(var_49_3) then
					arg_46_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 and not isNil(var_49_3) and arg_46_1.var_.characterEffect1027ui_story then
				arg_46_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_49_6 = arg_46_1.actors_["1080ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_6) and arg_46_1.var_.characterEffect1080ui_story == nil then
				arg_46_1.var_.characterEffect1080ui_story = var_49_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_7 = 0.1

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 and not isNil(var_49_6) then
				if arg_46_1.var_.characterEffect1080ui_story and not isNil(var_49_6) then
					arg_46_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_7)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 and not isNil(var_49_6) and arg_46_1.var_.characterEffect1080ui_story then
				arg_46_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_49_8 = 0
			local var_49_9 = 0.775

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_10 = arg_46_1:GetWordFromCfg(104111011)
				local var_49_11 = arg_46_1:FormatText(var_49_10.content)

				arg_46_1.text_.text = var_49_11

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_13 = 31 <= 0 and var_49_9 or var_49_9 * (utf8.len(var_49_11) / 31)

				if (31 <= 0 and var_49_9 or var_49_9 * (utf8.len(var_49_11) / 31)) > 0 and var_49_9 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13

					if var_49_13 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_8
					end
				end

				arg_46_1.text_.text = var_49_11
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111011", "story_v_out_104111.awb") ~= 0 then
					local var_49_14 = manager.audio:GetVoiceLength("story_v_out_104111", "104111011", "story_v_out_104111.awb") / 1000

					if var_49_14 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_14 + var_49_8
					end

					if var_49_10.prefab_name ~= "" and arg_46_1.actors_[var_49_10.prefab_name] ~= nil then
						local var_49_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_10.prefab_name].transform, "story_v_out_104111", "104111011", "story_v_out_104111.awb")

						arg_46_1:RecordAudio("104111011", var_49_15)
						arg_46_1:RecordAudio("104111011", var_49_15)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_104111", "104111011", "story_v_out_104111.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_104111", "104111011", "story_v_out_104111.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_16 = math.max(var_49_9, arg_46_1.talkMaxDuration)

			if var_49_8 <= arg_46_1.time_ and arg_46_1.time_ < var_49_8 + var_49_16 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_8) / var_49_16

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_8 + var_49_16 and arg_46_1.time_ < var_49_8 + var_49_16 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play104111012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 104111012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play104111013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1027ui_story"]) and arg_50_1.var_.characterEffect1027ui_story == nil then
				arg_50_1.var_.characterEffect1027ui_story = arg_50_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1027ui_story"]) then
				if arg_50_1.var_.characterEffect1027ui_story and not isNil(arg_50_1.actors_["1027ui_story"]) then
					arg_50_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1027ui_story"]) and arg_50_1.var_.characterEffect1027ui_story then
				arg_50_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action7_1")
			end

			local var_53_1 = 0
			local var_53_2 = 1.075

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(104111012).content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 43 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 43)

				if (43 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 43)) > 0 and var_53_2 < var_53_5 then
					arg_50_1.talkMaxDuration = var_53_5

					if var_53_5 + var_53_1 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + var_53_1
					end
				end

				arg_50_1.text_.text = var_53_3
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_6 = math.max(var_53_2, arg_50_1.talkMaxDuration)

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_6 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_1) / var_53_6

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_1 + var_53_6 and arg_50_1.time_ < var_53_1 + var_53_6 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play104111013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 104111013
		arg_54_1.duration_ = 2.17

		local var_54_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.166,
			en = 1.999999999999
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play104111014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1037ui_story"]) and arg_54_1.var_.characterEffect1037ui_story == nil then
				arg_54_1.var_.characterEffect1037ui_story = arg_54_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1037ui_story"]) then
				if arg_54_1.var_.characterEffect1037ui_story and not isNil(arg_54_1.actors_["1037ui_story"]) then
					arg_54_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1037ui_story"]) and arg_54_1.var_.characterEffect1037ui_story then
				arg_54_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_57_2 = arg_54_1.actors_["1037ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1037ui_story = var_57_2.localPosition
			end

			local var_57_3 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 then
				var_57_2.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_54_1.time_ - 0) / var_57_3)
				var_57_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_2.position).x, (manager.ui.mainCamera.transform.position - var_57_2.position).y, (manager.ui.mainCamera.transform.position - var_57_2.position).z)
				var_57_2.localEulerAngles.z = 0
				var_57_2.localEulerAngles.x = 0
				var_57_2.localEulerAngles = var_57_2.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 then
				var_57_2.localPosition = Vector3.New(0, -1.09, -5.81)
				var_57_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_2.position).x, (manager.ui.mainCamera.transform.position - var_57_2.position).y, (manager.ui.mainCamera.transform.position - var_57_2.position).z)
				var_57_2.localEulerAngles.z = 0
				var_57_2.localEulerAngles.x = 0
				var_57_2.localEulerAngles = var_57_2.localEulerAngles
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_57_4 = 0
			local var_57_5 = 0.05

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(104111013)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 2 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 2)

				if (2 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 2)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111013", "story_v_out_104111.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_104111", "104111013", "story_v_out_104111.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_out_104111", "104111013", "story_v_out_104111.awb")

						arg_54_1:RecordAudio("104111013", var_57_11)
						arg_54_1:RecordAudio("104111013", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_104111", "104111013", "story_v_out_104111.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_104111", "104111013", "story_v_out_104111.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play104111014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 104111014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play104111015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1037ui_story"]) and arg_58_1.var_.characterEffect1037ui_story == nil then
				arg_58_1.var_.characterEffect1037ui_story = arg_58_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.1

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1037ui_story"]) then
				if arg_58_1.var_.characterEffect1037ui_story and not isNil(arg_58_1.actors_["1037ui_story"]) then
					arg_58_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1037ui_story"]) and arg_58_1.var_.characterEffect1037ui_story then
				arg_58_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_61_1 = 0
			local var_61_2 = 0.1

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_3 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(104111014).content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 4 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 4)

				if (4 <= 0 and var_61_2 or var_61_2 * (utf8.len(var_61_3) / 4)) > 0 and var_61_2 < var_61_5 then
					arg_58_1.talkMaxDuration = var_61_5

					if var_61_5 + var_61_1 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + var_61_1
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_6 = math.max(var_61_2, arg_58_1.talkMaxDuration)

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_6 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_1) / var_61_6

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_1 + var_61_6 and arg_58_1.time_ < var_61_1 + var_61_6 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play104111015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104111015
		arg_62_1.duration_ = 4.73

		local var_62_0 = {
			ja = 4.2,
			ko = 4.733,
			zh = 3.7,
			en = 3.933
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play104111016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1037ui_story"]) and arg_62_1.var_.characterEffect1037ui_story == nil then
				arg_62_1.var_.characterEffect1037ui_story = arg_62_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1037ui_story"]) then
				if arg_62_1.var_.characterEffect1037ui_story and not isNil(arg_62_1.actors_["1037ui_story"]) then
					arg_62_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1037ui_story"]) and arg_62_1.var_.characterEffect1037ui_story then
				arg_62_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action472")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_65_2 = 0
			local var_65_3 = 0.45

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(104111015)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 18 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 18)

				if (18 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 18)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111015", "story_v_out_104111.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_104111", "104111015", "story_v_out_104111.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_104111", "104111015", "story_v_out_104111.awb")

						arg_62_1:RecordAudio("104111015", var_65_9)
						arg_62_1:RecordAudio("104111015", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104111", "104111015", "story_v_out_104111.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104111", "104111015", "story_v_out_104111.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_10 and arg_62_1.time_ < var_65_2 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play104111016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104111016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
			arg_66_1.auto_ = false
		end

		function arg_66_1.playNext_(arg_68_0)
			arg_66_1.onStoryFinished_()
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1037ui_story"]) and arg_66_1.var_.characterEffect1037ui_story == nil then
				arg_66_1.var_.characterEffect1037ui_story = arg_66_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1037ui_story"]) then
				if arg_66_1.var_.characterEffect1037ui_story and not isNil(arg_66_1.actors_["1037ui_story"]) then
					arg_66_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1037ui_story"]) and arg_66_1.var_.characterEffect1037ui_story then
				arg_66_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_69_1 = arg_66_1.actors_["1037ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1037ui_story = var_69_1.localPosition
			end

			local var_69_2 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_2 then
				var_69_1.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_2)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_2 and arg_66_1.time_ < 0 + var_69_2 + arg_69_0 then
				var_69_1.localPosition = Vector3.New(0, 100, 0)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			local var_69_3 = 0
			local var_69_4 = 0.05

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_5 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(104111016).content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 2 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_5) / 2)

				if (2 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_5) / 2)) > 0 and var_69_4 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_3
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_4, arg_66_1.talkMaxDuration)

			if var_69_3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_3 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_3) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_3 + var_69_8 and arg_66_1.time_ < var_69_3 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0404",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_104111.awb"
	}
}
