return {
	Play106132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C01b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C01b")
				var_4_0.name = "C01b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C01b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C01b

				arg_1_1.bgs_.C01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C01b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C01b:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC01b = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC01b = var_4_4
				end

				arg_1_1.var_.alphaOldValueC01b = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC01b then
					arg_1_1.var_.alphaMatValueC01b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC01b, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC01b.color = arg_1_1.var_.alphaMatValueC01b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC01b then
				arg_1_1.var_.alphaMatValueC01b.color.a = 1
				arg_1_1.var_.alphaMatValueC01b.color = arg_1_1.var_.alphaMatValueC01b.color
			end

			local var_4_6 = manager.ui.mainCamera.transform

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_6.localPosition
			end

			local var_4_7 = 0.6

			if 1 <= arg_1_1.time_ and arg_1_1.time_ < 1 + var_4_7 then
				local var_4_8, var_4_9 = math.modf((arg_1_1.time_ - 1) / 0.066)

				var_4_6.localPosition = Vector3.New(var_4_9 * 0.13, var_4_9 * 0.13, var_4_9 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1 + var_4_7 and arg_1_1.time_ < 1 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_10 = manager.ui.mainCamera.transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_10.localPosition
			end

			local var_4_11 = 0.6

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_11 then
				local var_4_12, var_4_13 = math.modf((arg_1_1.time_ - 2) / 0.099)

				var_4_10.localPosition = Vector3.New(var_4_13 * 0.13, var_4_13 * 0.13, var_4_13 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 2 + var_4_11 and arg_1_1.time_ < 2 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = arg_1_1.var_.shakeOldPos
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			local var_4_17 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_17 + 2 and arg_1_1.time_ < var_4_17 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_6", "se_story_6_giant_sword", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.65

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

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(106132001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 26 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 26)

				if (26 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 26)) > 0 and var_4_20 < var_4_24 then
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
	Play106132002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106132002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play106132003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.275

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(106132002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 51 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 51)

				if (51 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 51)) > 0 and var_11_0 < var_11_3 then
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
	Play106132003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106132003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play106132004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(106132003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 40 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 40)

				if (40 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 40)) > 0 and var_15_0 < var_15_3 then
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
	Play106132004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106132004
		arg_16_1.duration_ = 3.7

		local var_16_0 = {
			ja = 2.866,
			ko = 3.4,
			zh = 3.7,
			en = 1.999999999999
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
				arg_16_0:Play106132005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["3004_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3004_tpose"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_16_1.stage_.transform)

				var_19_0.name = "3004_tpose"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["3004_tpose"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["3004_tpose" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["3004_tpose" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["3004_tpose" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["3004_tpose"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect3004_tpose == nil then
				arg_16_1.var_.characterEffect3004_tpose = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect3004_tpose and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect3004_tpose then
				arg_16_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["3004_tpose"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos3004_tpose = var_19_6.localPosition

				local var_19_7 = GameObjectTools.GetOrAddComponent(var_19_6.gameObject, typeof(DynamicBoneHelper))

				if var_19_7 then
					var_19_7:EnableDynamicBone(false)
				end
			end

			local var_19_8 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 then
				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_16_1.time_ - 0) / var_19_8)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(0, -2.22, -3.1)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles

				local var_19_9 = GameObjectTools.GetOrAddComponent(var_19_6.gameObject, typeof(DynamicBoneHelper))

				if var_19_9 then
					var_19_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_19_10 = 0
			local var_19_11 = 0.125

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(106132004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 5 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 5)

				if (5 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 5)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132004", "story_v_out_106132.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_106132", "106132004", "story_v_out_106132.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_106132", "106132004", "story_v_out_106132.awb")

						arg_16_1:RecordAudio("106132004", var_19_17)
						arg_16_1:RecordAudio("106132004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106132", "106132004", "story_v_out_106132.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106132", "106132004", "story_v_out_106132.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play106132005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106132005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play106132006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["3004_tpose"]) and arg_20_1.var_.characterEffect3004_tpose == nil then
				arg_20_1.var_.characterEffect3004_tpose = arg_20_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["3004_tpose"]) then
				if arg_20_1.var_.characterEffect3004_tpose and not isNil(arg_20_1.actors_["3004_tpose"]) then
					arg_20_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_20_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["3004_tpose"]) and arg_20_1.var_.characterEffect3004_tpose then
				arg_20_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_20_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_23_1 = arg_20_1.actors_["3004_tpose"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos3004_tpose = var_23_1.localPosition

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_1.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end
			end

			local var_23_3 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 then
				var_23_1.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_3)
				var_23_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_1.position).x, (manager.ui.mainCamera.transform.position - var_23_1.position).y, (manager.ui.mainCamera.transform.position - var_23_1.position).z)
				var_23_1.localEulerAngles.z = 0
				var_23_1.localEulerAngles.x = 0
				var_23_1.localEulerAngles = var_23_1.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 then
				var_23_1.localPosition = Vector3.New(0, 100, 0)
				var_23_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_1.position).x, (manager.ui.mainCamera.transform.position - var_23_1.position).y, (manager.ui.mainCamera.transform.position - var_23_1.position).z)
				var_23_1.localEulerAngles.z = 0
				var_23_1.localEulerAngles.x = 0
				var_23_1.localEulerAngles = var_23_1.localEulerAngles

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_1.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(true)
				end
			end

			local var_23_5 = 0
			local var_23_6 = 1.025

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_7 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(106132005).content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 41 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 41)

				if (41 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 41)) > 0 and var_23_6 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_6, arg_20_1.talkMaxDuration)

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_5) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_5 + var_23_10 and arg_20_1.time_ < var_23_5 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play106132006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106132006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play106132007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0.4 < arg_24_1.time_ and arg_24_1.time_ <= 0.4 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_6", "se_story_6_tearing", "")
			end

			local var_27_1 = 0
			local var_27_2 = 0.7

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

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(106132006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 28 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 28)

				if (28 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 28)) > 0 and var_27_2 < var_27_5 then
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

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106132007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106132007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106132008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_0 = 0.5

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				local var_31_1 = Color.New(1, 1, 1)

				var_31_1.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.mask_.color = var_31_1
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				local var_31_2 = Color.New(1, 1, 1)

				arg_28_1.mask_.enabled = false
				var_31_2.a = 0
				arg_28_1.mask_.color = var_31_2
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_6", "se_story_6_burning", "")
			end

			local var_31_4 = 0
			local var_31_5 = 1.15

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(106132007).content)

				arg_28_1.text_.text = var_31_6

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_8 = 46 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_6) / 46)

				if (46 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_6) / 46)) > 0 and var_31_5 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8

					if var_31_8 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_6
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_9 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_9

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_9 and arg_28_1.time_ < var_31_4 + var_31_9 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play106132008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106132008
		arg_32_1.duration_ = 5.17

		local var_32_0 = {
			ja = 2.266,
			ko = 3.1,
			zh = 5.166,
			en = 3.533
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
				arg_32_0:Play106132009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["3004_tpose"]) and arg_32_1.var_.characterEffect3004_tpose == nil then
				arg_32_1.var_.characterEffect3004_tpose = arg_32_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["3004_tpose"]) then
				if arg_32_1.var_.characterEffect3004_tpose and not isNil(arg_32_1.actors_["3004_tpose"]) then
					arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["3004_tpose"]) and arg_32_1.var_.characterEffect3004_tpose then
				arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["3004_tpose"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos3004_tpose = var_35_2.localPosition

				local var_35_3 = GameObjectTools.GetOrAddComponent(var_35_2.gameObject, typeof(DynamicBoneHelper))

				if var_35_3 then
					var_35_3:EnableDynamicBone(false)
				end
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_2.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_32_1.time_ - 0) / var_35_4)
				var_35_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_2.position).x, (manager.ui.mainCamera.transform.position - var_35_2.position).y, (manager.ui.mainCamera.transform.position - var_35_2.position).z)
				var_35_2.localEulerAngles.z = 0
				var_35_2.localEulerAngles.x = 0
				var_35_2.localEulerAngles = var_35_2.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_2.localPosition = Vector3.New(0, -2.22, -3.1)
				var_35_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_2.position).x, (manager.ui.mainCamera.transform.position - var_35_2.position).y, (manager.ui.mainCamera.transform.position - var_35_2.position).z)
				var_35_2.localEulerAngles.z = 0
				var_35_2.localEulerAngles.x = 0
				var_35_2.localEulerAngles = var_35_2.localEulerAngles

				local var_35_5 = GameObjectTools.GetOrAddComponent(var_35_2.gameObject, typeof(DynamicBoneHelper))

				if var_35_5 then
					var_35_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_35_6 = 0
			local var_35_7 = 0.35

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_8 = arg_32_1:GetWordFromCfg(106132008)
				local var_35_9 = arg_32_1:FormatText(var_35_8.content)

				arg_32_1.text_.text = var_35_9

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 12 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 12)

				if (12 <= 0 and var_35_7 or var_35_7 * (utf8.len(var_35_9) / 12)) > 0 and var_35_7 < var_35_11 then
					arg_32_1.talkMaxDuration = var_35_11

					if var_35_11 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_11 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_9
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132008", "story_v_out_106132.awb") ~= 0 then
					local var_35_12 = manager.audio:GetVoiceLength("story_v_out_106132", "106132008", "story_v_out_106132.awb") / 1000

					if var_35_12 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_6
					end

					if var_35_8.prefab_name ~= "" and arg_32_1.actors_[var_35_8.prefab_name] ~= nil then
						local var_35_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_8.prefab_name].transform, "story_v_out_106132", "106132008", "story_v_out_106132.awb")

						arg_32_1:RecordAudio("106132008", var_35_13)
						arg_32_1:RecordAudio("106132008", var_35_13)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106132", "106132008", "story_v_out_106132.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106132", "106132008", "story_v_out_106132.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play106132009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106132009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play106132010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["3004_tpose"]) and arg_36_1.var_.characterEffect3004_tpose == nil then
				arg_36_1.var_.characterEffect3004_tpose = arg_36_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["3004_tpose"]) then
				if arg_36_1.var_.characterEffect3004_tpose and not isNil(arg_36_1.actors_["3004_tpose"]) then
					arg_36_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_36_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["3004_tpose"]) and arg_36_1.var_.characterEffect3004_tpose then
				arg_36_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_36_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_39_1 = arg_36_1.actors_["3004_tpose"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos3004_tpose = var_39_1.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_1.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 then
				var_39_1.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_3)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 then
				var_39_1.localPosition = Vector3.New(0, 100, 0)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_1.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(true)
				end
			end

			local var_39_5 = 0
			local var_39_6 = 0.775

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_7 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(106132009).content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 31 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_7) / 31)

				if (31 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_7) / 31)) > 0 and var_39_6 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_10 and arg_36_1.time_ < var_39_5 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play106132010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106132010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play106132011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_43_0 = 0.6

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				local var_43_1, var_43_2 = math.modf((arg_40_1.time_ - 0) / 0.099)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_43_2 * 0.13, var_43_2 * 0.13, var_43_2 * 0.13) + arg_40_1.var_.shakeOldPos
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				manager.ui.mainCamera.transform.localPosition = arg_40_1.var_.shakeOldPos
			end

			local var_43_3 = 0
			local var_43_4 = 1.3

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_5 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(106132010).content)

				arg_40_1.text_.text = var_43_5

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_7 = 52 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_5) / 52)

				if (52 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_5) / 52)) > 0 and var_43_4 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_3
					end
				end

				arg_40_1.text_.text = var_43_5
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_4, arg_40_1.talkMaxDuration)

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_3) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_3 + var_43_8 and arg_40_1.time_ < var_43_3 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play106132011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106132011
		arg_44_1.duration_ = 3.13

		local var_44_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			zh = 2.333,
			en = 2.766
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
				arg_44_0:Play106132012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["3004_tpose"]) and arg_44_1.var_.characterEffect3004_tpose == nil then
				arg_44_1.var_.characterEffect3004_tpose = arg_44_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["3004_tpose"]) then
				if arg_44_1.var_.characterEffect3004_tpose and not isNil(arg_44_1.actors_["3004_tpose"]) then
					arg_44_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["3004_tpose"]) and arg_44_1.var_.characterEffect3004_tpose then
				arg_44_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["3004_tpose"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos3004_tpose = var_47_2.localPosition

				local var_47_3 = GameObjectTools.GetOrAddComponent(var_47_2.gameObject, typeof(DynamicBoneHelper))

				if var_47_3 then
					var_47_3:EnableDynamicBone(false)
				end
			end

			local var_47_4 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				var_47_2.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_44_1.time_ - 0) / var_47_4)
				var_47_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_2.position).x, (manager.ui.mainCamera.transform.position - var_47_2.position).y, (manager.ui.mainCamera.transform.position - var_47_2.position).z)
				var_47_2.localEulerAngles.z = 0
				var_47_2.localEulerAngles.x = 0
				var_47_2.localEulerAngles = var_47_2.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				var_47_2.localPosition = Vector3.New(0, -2.22, -3.1)
				var_47_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_2.position).x, (manager.ui.mainCamera.transform.position - var_47_2.position).y, (manager.ui.mainCamera.transform.position - var_47_2.position).z)
				var_47_2.localEulerAngles.z = 0
				var_47_2.localEulerAngles.x = 0
				var_47_2.localEulerAngles = var_47_2.localEulerAngles

				local var_47_5 = GameObjectTools.GetOrAddComponent(var_47_2.gameObject, typeof(DynamicBoneHelper))

				if var_47_5 then
					var_47_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_47_6 = manager.ui.mainCamera.transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.shakeOldPos = var_47_6.localPosition
			end

			local var_47_7 = 0.6

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				local var_47_8, var_47_9 = math.modf((arg_44_1.time_ - 0) / 0.066)

				var_47_6.localPosition = Vector3.New(var_47_9 * 0.13, var_47_9 * 0.13, var_47_9 * 0.13) + arg_44_1.var_.shakeOldPos
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				var_47_6.localPosition = arg_44_1.var_.shakeOldPos
			end

			local var_47_10 = 0
			local var_47_11 = 0.125

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_12 = arg_44_1:GetWordFromCfg(106132011)
				local var_47_13 = arg_44_1:FormatText(var_47_12.content)

				arg_44_1.text_.text = var_47_13

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_15 = 5 <= 0 and var_47_11 or var_47_11 * (utf8.len(var_47_13) / 5)

				if (5 <= 0 and var_47_11 or var_47_11 * (utf8.len(var_47_13) / 5)) > 0 and var_47_11 < var_47_15 then
					arg_44_1.talkMaxDuration = var_47_15

					if var_47_15 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_15 + var_47_10
					end
				end

				arg_44_1.text_.text = var_47_13
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132011", "story_v_out_106132.awb") ~= 0 then
					local var_47_16 = manager.audio:GetVoiceLength("story_v_out_106132", "106132011", "story_v_out_106132.awb") / 1000

					if var_47_16 + var_47_10 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_16 + var_47_10
					end

					if var_47_12.prefab_name ~= "" and arg_44_1.actors_[var_47_12.prefab_name] ~= nil then
						local var_47_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_12.prefab_name].transform, "story_v_out_106132", "106132011", "story_v_out_106132.awb")

						arg_44_1:RecordAudio("106132011", var_47_17)
						arg_44_1:RecordAudio("106132011", var_47_17)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106132", "106132011", "story_v_out_106132.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106132", "106132011", "story_v_out_106132.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_18 = math.max(var_47_11, arg_44_1.talkMaxDuration)

			if var_47_10 <= arg_44_1.time_ and arg_44_1.time_ < var_47_10 + var_47_18 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_10) / var_47_18

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_10 + var_47_18 and arg_44_1.time_ < var_47_10 + var_47_18 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play106132012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 106132012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play106132013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["3004_tpose"]) and arg_48_1.var_.characterEffect3004_tpose == nil then
				arg_48_1.var_.characterEffect3004_tpose = arg_48_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["3004_tpose"]) then
				if arg_48_1.var_.characterEffect3004_tpose and not isNil(arg_48_1.actors_["3004_tpose"]) then
					arg_48_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_48_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["3004_tpose"]) and arg_48_1.var_.characterEffect3004_tpose then
				arg_48_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_48_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_51_1 = arg_48_1.actors_["3004_tpose"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos3004_tpose = var_51_1.localPosition

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_1.gameObject, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end
			end

			local var_51_3 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 then
				var_51_1.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_3)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 then
				var_51_1.localPosition = Vector3.New(0, 100, 0)
				var_51_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_1.position).x, (manager.ui.mainCamera.transform.position - var_51_1.position).y, (manager.ui.mainCamera.transform.position - var_51_1.position).z)
				var_51_1.localEulerAngles.z = 0
				var_51_1.localEulerAngles.x = 0
				var_51_1.localEulerAngles = var_51_1.localEulerAngles

				local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_1.gameObject, typeof(DynamicBoneHelper))

				if var_51_4 then
					var_51_4:EnableDynamicBone(true)
				end
			end

			local var_51_5 = 0
			local var_51_6 = 0.975

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(106132012).content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 39 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 39)

				if (39 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_7) / 39)) > 0 and var_51_6 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_10 and arg_48_1.time_ < var_51_5 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play106132013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106132013
		arg_52_1.duration_ = 4.33

		local var_52_0 = {
			ja = 2.766,
			ko = 4.333,
			zh = 3.1,
			en = 3.266
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
				arg_52_0:Play106132014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["3004_tpose"]) and arg_52_1.var_.characterEffect3004_tpose == nil then
				arg_52_1.var_.characterEffect3004_tpose = arg_52_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["3004_tpose"]) then
				if arg_52_1.var_.characterEffect3004_tpose and not isNil(arg_52_1.actors_["3004_tpose"]) then
					arg_52_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["3004_tpose"]) and arg_52_1.var_.characterEffect3004_tpose then
				arg_52_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["3004_tpose"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos3004_tpose = var_55_2.localPosition

				local var_55_3 = GameObjectTools.GetOrAddComponent(var_55_2.gameObject, typeof(DynamicBoneHelper))

				if var_55_3 then
					var_55_3:EnableDynamicBone(false)
				end
			end

			local var_55_4 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				var_55_2.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_52_1.time_ - 0) / var_55_4)
				var_55_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_2.position).x, (manager.ui.mainCamera.transform.position - var_55_2.position).y, (manager.ui.mainCamera.transform.position - var_55_2.position).z)
				var_55_2.localEulerAngles.z = 0
				var_55_2.localEulerAngles.x = 0
				var_55_2.localEulerAngles = var_55_2.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				var_55_2.localPosition = Vector3.New(0, -2.22, -3.1)
				var_55_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_2.position).x, (manager.ui.mainCamera.transform.position - var_55_2.position).y, (manager.ui.mainCamera.transform.position - var_55_2.position).z)
				var_55_2.localEulerAngles.z = 0
				var_55_2.localEulerAngles.x = 0
				var_55_2.localEulerAngles = var_55_2.localEulerAngles

				local var_55_5 = GameObjectTools.GetOrAddComponent(var_55_2.gameObject, typeof(DynamicBoneHelper))

				if var_55_5 then
					var_55_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_55_6 = 0
			local var_55_7 = 0.225

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_8 = arg_52_1:GetWordFromCfg(106132013)
				local var_55_9 = arg_52_1:FormatText(var_55_8.content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 9 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 9)

				if (9 <= 0 and var_55_7 or var_55_7 * (utf8.len(var_55_9) / 9)) > 0 and var_55_7 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132013", "story_v_out_106132.awb") ~= 0 then
					local var_55_12 = manager.audio:GetVoiceLength("story_v_out_106132", "106132013", "story_v_out_106132.awb") / 1000

					if var_55_12 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_6
					end

					if var_55_8.prefab_name ~= "" and arg_52_1.actors_[var_55_8.prefab_name] ~= nil then
						local var_55_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_8.prefab_name].transform, "story_v_out_106132", "106132013", "story_v_out_106132.awb")

						arg_52_1:RecordAudio("106132013", var_55_13)
						arg_52_1:RecordAudio("106132013", var_55_13)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_106132", "106132013", "story_v_out_106132.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_106132", "106132013", "story_v_out_106132.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play106132014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 106132014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play106132015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["3004_tpose"]) and arg_56_1.var_.characterEffect3004_tpose == nil then
				arg_56_1.var_.characterEffect3004_tpose = arg_56_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["3004_tpose"]) then
				if arg_56_1.var_.characterEffect3004_tpose and not isNil(arg_56_1.actors_["3004_tpose"]) then
					arg_56_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_56_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["3004_tpose"]) and arg_56_1.var_.characterEffect3004_tpose then
				arg_56_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_56_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_59_1 = arg_56_1.actors_["3004_tpose"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos3004_tpose = var_59_1.localPosition

				local var_59_2 = GameObjectTools.GetOrAddComponent(var_59_1.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(false)
				end
			end

			local var_59_3 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_3)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(0, 100, 0)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles

				local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_1.gameObject, typeof(DynamicBoneHelper))

				if var_59_4 then
					var_59_4:EnableDynamicBone(true)
				end
			end

			if 0.366666666666667 < arg_56_1.time_ and arg_56_1.time_ <= 0.366666666666667 + arg_59_0 then
				arg_56_1:AudioAction("play", "effect", "se_story_6", "se_story_6_snake02", "")
			end

			local var_59_6 = 0
			local var_59_7 = 1.025

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(106132014).content)

				arg_56_1.text_.text = var_59_8

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_10 = 41 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_8) / 41)

				if (41 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_8) / 41)) > 0 and var_59_7 < var_59_10 then
					arg_56_1.talkMaxDuration = var_59_10

					if var_59_10 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_8
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_11 and arg_56_1.time_ < var_59_6 + var_59_11 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play106132015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 106132015
		arg_60_1.duration_ = 9.97

		local var_60_0 = {
			ja = 3.4,
			ko = 6.9,
			zh = 9.966,
			en = 5.733
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
				arg_60_0:Play106132016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.675

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_2 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_2:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(106132015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 27 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_4) / 27)

				if (27 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_4) / 27)) > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6
					var_63_0 = var_63_0 + 0.3

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132015", "story_v_out_106132.awb") ~= 0 then
					local var_63_7 = manager.audio:GetVoiceLength("story_v_out_106132", "106132015", "story_v_out_106132.awb") / 1000

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_106132", "106132015", "story_v_out_106132.awb")

						arg_60_1:RecordAudio("106132015", var_63_8)
						arg_60_1:RecordAudio("106132015", var_63_8)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_106132", "106132015", "story_v_out_106132.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_106132", "106132015", "story_v_out_106132.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_9 = var_63_0 + 0.3
			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_9) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play106132016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 106132016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play106132017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["3004_tpose"]) and arg_66_1.var_.characterEffect3004_tpose == nil then
				arg_66_1.var_.characterEffect3004_tpose = arg_66_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["3004_tpose"]) then
				if arg_66_1.var_.characterEffect3004_tpose and not isNil(arg_66_1.actors_["3004_tpose"]) then
					arg_66_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_66_1.var_.characterEffect3004_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["3004_tpose"]) and arg_66_1.var_.characterEffect3004_tpose then
				arg_66_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_66_1.var_.characterEffect3004_tpose.fillRatio = 0.5
			end

			local var_69_1 = arg_66_1.actors_["3004_tpose"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos3004_tpose = var_69_1.localPosition

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_1.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end
			end

			local var_69_3 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 then
				var_69_1.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_66_1.time_ - 0) / var_69_3)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 then
				var_69_1.localPosition = Vector3.New(0, 100, 0)
				var_69_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_1.position).x, (manager.ui.mainCamera.transform.position - var_69_1.position).y, (manager.ui.mainCamera.transform.position - var_69_1.position).z)
				var_69_1.localEulerAngles.z = 0
				var_69_1.localEulerAngles.x = 0
				var_69_1.localEulerAngles = var_69_1.localEulerAngles

				local var_69_4 = GameObjectTools.GetOrAddComponent(var_69_1.gameObject, typeof(DynamicBoneHelper))

				if var_69_4 then
					var_69_4:EnableDynamicBone(true)
				end
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog", "")
			end

			local var_69_6 = 0
			local var_69_7 = 1.1

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_8 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(106132016).content)

				arg_66_1.text_.text = var_69_8

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_10 = 44 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_8) / 44)

				if (44 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_8) / 44)) > 0 and var_69_7 < var_69_10 then
					arg_66_1.talkMaxDuration = var_69_10

					if var_69_10 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_8
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_11 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_11 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_11

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_11 and arg_66_1.time_ < var_69_6 + var_69_11 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
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
	Play106132017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 106132017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play106132018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.actors_["1099ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1099ui_story"))) then
				local var_73_0 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_70_1.stage_.transform)

				var_73_0.name = "1099ui_story"
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1099ui_story"] = var_73_0

				local var_73_1 = var_73_0:GetComponentInChildren(typeof(CharacterEffect))

				var_73_1.enabled = true

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end

				arg_70_1:ShowWeapon(var_73_1.transform, false)

				arg_70_1.var_["1099ui_story" .. "Animator"] = var_73_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_70_1.var_["1099ui_story" .. "Animator"].applyRootMotion = true
				arg_70_1.var_["1099ui_story" .. "LipSync"] = var_73_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_73_3 = arg_70_1.actors_["1099ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect1099ui_story == nil then
				arg_70_1.var_.characterEffect1099ui_story = var_73_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_4 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 and not isNil(var_73_3) then
				if arg_70_1.var_.characterEffect1099ui_story and not isNil(var_73_3) then
					arg_70_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect1099ui_story then
				arg_70_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_73_6 = arg_70_1.actors_["1099ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1099ui_story = var_73_6.localPosition
			end

			local var_73_7 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				var_73_6.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_70_1.time_ - 0) / var_73_7)
				var_73_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_6.position).x, (manager.ui.mainCamera.transform.position - var_73_6.position).y, (manager.ui.mainCamera.transform.position - var_73_6.position).z)
				var_73_6.localEulerAngles.z = 0
				var_73_6.localEulerAngles.x = 0
				var_73_6.localEulerAngles = var_73_6.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				var_73_6.localPosition = Vector3.New(0, -1.08, -5.9)
				var_73_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_6.position).x, (manager.ui.mainCamera.transform.position - var_73_6.position).y, (manager.ui.mainCamera.transform.position - var_73_6.position).z)
				var_73_6.localEulerAngles.z = 0
				var_73_6.localEulerAngles.x = 0
				var_73_6.localEulerAngles = var_73_6.localEulerAngles
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_73_8 = 0
			local var_73_9 = 0.125

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_10 = arg_70_1:GetWordFromCfg(106132017)
				local var_73_11 = arg_70_1:FormatText(var_73_10.content)

				arg_70_1.text_.text = var_73_11

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_13 = 5 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_11) / 5)

				if (5 <= 0 and var_73_9 or var_73_9 * (utf8.len(var_73_11) / 5)) > 0 and var_73_9 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_8
					end
				end

				arg_70_1.text_.text = var_73_11
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132017", "story_v_out_106132.awb") ~= 0 then
					local var_73_14 = manager.audio:GetVoiceLength("story_v_out_106132", "106132017", "story_v_out_106132.awb") / 1000

					if var_73_14 + var_73_8 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_14 + var_73_8
					end

					if var_73_10.prefab_name ~= "" and arg_70_1.actors_[var_73_10.prefab_name] ~= nil then
						local var_73_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_10.prefab_name].transform, "story_v_out_106132", "106132017", "story_v_out_106132.awb")

						arg_70_1:RecordAudio("106132017", var_73_15)
						arg_70_1:RecordAudio("106132017", var_73_15)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_106132", "106132017", "story_v_out_106132.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_106132", "106132017", "story_v_out_106132.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_9, arg_70_1.talkMaxDuration)

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_8) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_8 + var_73_16 and arg_70_1.time_ < var_73_8 + var_73_16 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play106132018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 106132018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play106132019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1099ui_story"]) and arg_74_1.var_.characterEffect1099ui_story == nil then
				arg_74_1.var_.characterEffect1099ui_story = arg_74_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1099ui_story"]) then
				if arg_74_1.var_.characterEffect1099ui_story and not isNil(arg_74_1.actors_["1099ui_story"]) then
					arg_74_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_0)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1099ui_story"]) and arg_74_1.var_.characterEffect1099ui_story then
				arg_74_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_77_1 = arg_74_1.actors_["1099ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1099ui_story = var_77_1.localPosition
			end

			local var_77_2 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 then
				var_77_1.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_2)
				var_77_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_1.position).x, (manager.ui.mainCamera.transform.position - var_77_1.position).y, (manager.ui.mainCamera.transform.position - var_77_1.position).z)
				var_77_1.localEulerAngles.z = 0
				var_77_1.localEulerAngles.x = 0
				var_77_1.localEulerAngles = var_77_1.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 then
				var_77_1.localPosition = Vector3.New(0, 100, 0)
				var_77_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_1.position).x, (manager.ui.mainCamera.transform.position - var_77_1.position).y, (manager.ui.mainCamera.transform.position - var_77_1.position).z)
				var_77_1.localEulerAngles.z = 0
				var_77_1.localEulerAngles.x = 0
				var_77_1.localEulerAngles = var_77_1.localEulerAngles
			end

			local var_77_3 = 0
			local var_77_4 = 0.525

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_3 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_5 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(106132018).content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 21 <= 0 and var_77_4 or var_77_4 * (utf8.len(var_77_5) / 21)

				if (21 <= 0 and var_77_4 or var_77_4 * (utf8.len(var_77_5) / 21)) > 0 and var_77_4 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_3 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_3
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_4, arg_74_1.talkMaxDuration)

			if var_77_3 <= arg_74_1.time_ and arg_74_1.time_ < var_77_3 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_3) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_3 + var_77_8 and arg_74_1.time_ < var_77_3 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play106132019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 106132019
		arg_78_1.duration_ = 4

		local var_78_0 = {
			ja = 1.999999999999,
			ko = 2.233,
			zh = 2.8,
			en = 4
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play106132020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1099ui_story"]) and arg_78_1.var_.characterEffect1099ui_story == nil then
				arg_78_1.var_.characterEffect1099ui_story = arg_78_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1099ui_story"]) then
				if arg_78_1.var_.characterEffect1099ui_story and not isNil(arg_78_1.actors_["1099ui_story"]) then
					arg_78_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1099ui_story"]) and arg_78_1.var_.characterEffect1099ui_story then
				arg_78_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["1099ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1099ui_story = var_81_2.localPosition
			end

			local var_81_3 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 then
				var_81_2.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_78_1.time_ - 0) / var_81_3)
				var_81_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_2.position).x, (manager.ui.mainCamera.transform.position - var_81_2.position).y, (manager.ui.mainCamera.transform.position - var_81_2.position).z)
				var_81_2.localEulerAngles.z = 0
				var_81_2.localEulerAngles.x = 0
				var_81_2.localEulerAngles = var_81_2.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 then
				var_81_2.localPosition = Vector3.New(0, -1.08, -5.9)
				var_81_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_2.position).x, (manager.ui.mainCamera.transform.position - var_81_2.position).y, (manager.ui.mainCamera.transform.position - var_81_2.position).z)
				var_81_2.localEulerAngles.z = 0
				var_81_2.localEulerAngles.x = 0
				var_81_2.localEulerAngles = var_81_2.localEulerAngles
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_81_4 = 0
			local var_81_5 = 0.3

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(106132019)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 12 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 12)

				if (12 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 12)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132019", "story_v_out_106132.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_106132", "106132019", "story_v_out_106132.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_106132", "106132019", "story_v_out_106132.awb")

						arg_78_1:RecordAudio("106132019", var_81_11)
						arg_78_1:RecordAudio("106132019", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_106132", "106132019", "story_v_out_106132.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_106132", "106132019", "story_v_out_106132.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play106132020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 106132020
		arg_82_1.duration_ = 9.6

		local var_82_0 = {
			ja = 6.666,
			ko = 6.066,
			zh = 8.666,
			en = 9.6
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play106132021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if arg_82_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_85_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_82_1.stage_.transform)

				var_85_0.name = "1093ui_story"
				var_85_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.actors_["1093ui_story"] = var_85_0

				local var_85_1 = var_85_0:GetComponentInChildren(typeof(CharacterEffect))

				var_85_1.enabled = true

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end

				arg_82_1:ShowWeapon(var_85_1.transform, false)

				arg_82_1.var_["1093ui_story" .. "Animator"] = var_85_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_82_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_82_1.var_["1093ui_story" .. "LipSync"] = var_85_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_85_3 = arg_82_1.actors_["1093ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1093ui_story == nil then
				arg_82_1.var_.characterEffect1093ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect1093ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect1093ui_story then
				arg_82_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_85_6 = arg_82_1.actors_["1099ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect1099ui_story == nil then
				arg_82_1.var_.characterEffect1099ui_story = var_85_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_7 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 and not isNil(var_85_6) then
				if arg_82_1.var_.characterEffect1099ui_story and not isNil(var_85_6) then
					arg_82_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_7)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 and not isNil(var_85_6) and arg_82_1.var_.characterEffect1099ui_story then
				arg_82_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			local var_85_8 = arg_82_1.actors_["1099ui_story"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1099ui_story = var_85_8.localPosition
			end

			local var_85_9 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_9 then
				var_85_8.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (arg_82_1.time_ - 0) / var_85_9)
				var_85_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_8.position).x, (manager.ui.mainCamera.transform.position - var_85_8.position).y, (manager.ui.mainCamera.transform.position - var_85_8.position).z)
				var_85_8.localEulerAngles.z = 0
				var_85_8.localEulerAngles.x = 0
				var_85_8.localEulerAngles = var_85_8.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_9 and arg_82_1.time_ < 0 + var_85_9 + arg_85_0 then
				var_85_8.localPosition = Vector3.New(0, -1.08, -5.9)
				var_85_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_8.position).x, (manager.ui.mainCamera.transform.position - var_85_8.position).y, (manager.ui.mainCamera.transform.position - var_85_8.position).z)
				var_85_8.localEulerAngles.z = 0
				var_85_8.localEulerAngles.x = 0
				var_85_8.localEulerAngles = var_85_8.localEulerAngles
			end

			local var_85_10 = arg_82_1.actors_["1099ui_story"].transform

			if 0.033 < arg_82_1.time_ and arg_82_1.time_ <= 0.033 + arg_85_0 then
				arg_82_1.var_.moveOldPos1099ui_story = var_85_10.localPosition
			end

			local var_85_11 = 0.5

			if 0.033 <= arg_82_1.time_ and arg_82_1.time_ < 0.033 + var_85_11 then
				var_85_10.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1099ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_82_1.time_ - 0.033) / var_85_11)
				var_85_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_10.position).x, (manager.ui.mainCamera.transform.position - var_85_10.position).y, (manager.ui.mainCamera.transform.position - var_85_10.position).z)
				var_85_10.localEulerAngles.z = 0
				var_85_10.localEulerAngles.x = 0
				var_85_10.localEulerAngles = var_85_10.localEulerAngles
			end

			if arg_82_1.time_ >= 0.033 + var_85_11 and arg_82_1.time_ < 0.033 + var_85_11 + arg_85_0 then
				var_85_10.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_85_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_10.position).x, (manager.ui.mainCamera.transform.position - var_85_10.position).y, (manager.ui.mainCamera.transform.position - var_85_10.position).z)
				var_85_10.localEulerAngles.z = 0
				var_85_10.localEulerAngles.x = 0
				var_85_10.localEulerAngles = var_85_10.localEulerAngles
			end

			local var_85_12 = arg_82_1.actors_["1093ui_story"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1093ui_story = var_85_12.localPosition

				arg_82_1:ShowWeapon(arg_82_1.var_["1093ui_story" .. "Animator"].transform, true)
			end

			local var_85_13 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_13 then
				var_85_12.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_82_1.time_ - 0) / var_85_13)
				var_85_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_12.position).x, (manager.ui.mainCamera.transform.position - var_85_12.position).y, (manager.ui.mainCamera.transform.position - var_85_12.position).z)
				var_85_12.localEulerAngles.z = 0
				var_85_12.localEulerAngles.x = 0
				var_85_12.localEulerAngles = var_85_12.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_13 and arg_82_1.time_ < 0 + var_85_13 + arg_85_0 then
				var_85_12.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_85_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_12.position).x, (manager.ui.mainCamera.transform.position - var_85_12.position).y, (manager.ui.mainCamera.transform.position - var_85_12.position).z)
				var_85_12.localEulerAngles.z = 0
				var_85_12.localEulerAngles.x = 0
				var_85_12.localEulerAngles = var_85_12.localEulerAngles
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_85_14 = 0
			local var_85_15 = 0.8

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_16 = arg_82_1:GetWordFromCfg(106132020)
				local var_85_17 = arg_82_1:FormatText(var_85_16.content)

				arg_82_1.text_.text = var_85_17

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_19 = 32 <= 0 and var_85_15 or var_85_15 * (utf8.len(var_85_17) / 32)

				if (32 <= 0 and var_85_15 or var_85_15 * (utf8.len(var_85_17) / 32)) > 0 and var_85_15 < var_85_19 then
					arg_82_1.talkMaxDuration = var_85_19

					if var_85_19 + var_85_14 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_14
					end
				end

				arg_82_1.text_.text = var_85_17
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132020", "story_v_out_106132.awb") ~= 0 then
					local var_85_20 = manager.audio:GetVoiceLength("story_v_out_106132", "106132020", "story_v_out_106132.awb") / 1000

					if var_85_20 + var_85_14 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_20 + var_85_14
					end

					if var_85_16.prefab_name ~= "" and arg_82_1.actors_[var_85_16.prefab_name] ~= nil then
						local var_85_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_16.prefab_name].transform, "story_v_out_106132", "106132020", "story_v_out_106132.awb")

						arg_82_1:RecordAudio("106132020", var_85_21)
						arg_82_1:RecordAudio("106132020", var_85_21)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_106132", "106132020", "story_v_out_106132.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_106132", "106132020", "story_v_out_106132.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_22 = math.max(var_85_15, arg_82_1.talkMaxDuration)

			if var_85_14 <= arg_82_1.time_ and arg_82_1.time_ < var_85_14 + var_85_22 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_14) / var_85_22

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_14 + var_85_22 and arg_82_1.time_ < var_85_14 + var_85_22 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play106132021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 106132021
		arg_86_1.duration_ = 5.33

		local var_86_0 = {
			ja = 3.033,
			ko = 2.766,
			zh = 3,
			en = 5.333
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play106132022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1099ui_story"]) and arg_86_1.var_.characterEffect1099ui_story == nil then
				arg_86_1.var_.characterEffect1099ui_story = arg_86_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1099ui_story"]) then
				if arg_86_1.var_.characterEffect1099ui_story and not isNil(arg_86_1.actors_["1099ui_story"]) then
					arg_86_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1099ui_story"]) and arg_86_1.var_.characterEffect1099ui_story then
				arg_86_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_89_2 = arg_86_1.actors_["1093ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1093ui_story == nil then
				arg_86_1.var_.characterEffect1093ui_story = var_89_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_3 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 and not isNil(var_89_2) then
				if arg_86_1.var_.characterEffect1093ui_story and not isNil(var_89_2) then
					arg_86_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_3)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1093ui_story then
				arg_86_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action456")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_89_4 = 0
			local var_89_5 = 0.4

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(106132021)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 16 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 16)

				if (16 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 16)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132021", "story_v_out_106132.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_out_106132", "106132021", "story_v_out_106132.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_out_106132", "106132021", "story_v_out_106132.awb")

						arg_86_1:RecordAudio("106132021", var_89_11)
						arg_86_1:RecordAudio("106132021", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_106132", "106132021", "story_v_out_106132.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_106132", "106132021", "story_v_out_106132.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play106132022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 106132022
		arg_90_1.duration_ = 8.13

		local var_90_0 = {
			ja = 8.066,
			ko = 5.433,
			zh = 8.133,
			en = 6.666
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play106132023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1093ui_story"]) and arg_90_1.var_.characterEffect1093ui_story == nil then
				arg_90_1.var_.characterEffect1093ui_story = arg_90_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1093ui_story"]) then
				if arg_90_1.var_.characterEffect1093ui_story and not isNil(arg_90_1.actors_["1093ui_story"]) then
					arg_90_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1093ui_story"]) and arg_90_1.var_.characterEffect1093ui_story then
				arg_90_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_93_2 = arg_90_1.actors_["1099ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1099ui_story == nil then
				arg_90_1.var_.characterEffect1099ui_story = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect1099ui_story and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1099ui_story then
				arg_90_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_93_4 = 0
			local var_93_5 = 0.55

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(106132022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 22 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 22)

				if (22 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 22)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132022", "story_v_out_106132.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_106132", "106132022", "story_v_out_106132.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_out_106132", "106132022", "story_v_out_106132.awb")

						arg_90_1:RecordAudio("106132022", var_93_11)
						arg_90_1:RecordAudio("106132022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_106132", "106132022", "story_v_out_106132.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_106132", "106132022", "story_v_out_106132.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play106132023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 106132023
		arg_94_1.duration_ = 2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play106132024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1099ui_story"]) and arg_94_1.var_.characterEffect1099ui_story == nil then
				arg_94_1.var_.characterEffect1099ui_story = arg_94_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1099ui_story"]) then
				if arg_94_1.var_.characterEffect1099ui_story and not isNil(arg_94_1.actors_["1099ui_story"]) then
					arg_94_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1099ui_story"]) and arg_94_1.var_.characterEffect1099ui_story then
				arg_94_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["1093ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1093ui_story == nil then
				arg_94_1.var_.characterEffect1093ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect1093ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect1093ui_story then
				arg_94_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_2")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_97_4 = 0
			local var_97_5 = 0.15

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(106132023)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 6 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 6)

				if (6 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 6)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132023", "story_v_out_106132.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_106132", "106132023", "story_v_out_106132.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_out_106132", "106132023", "story_v_out_106132.awb")

						arg_94_1:RecordAudio("106132023", var_97_11)
						arg_94_1:RecordAudio("106132023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_106132", "106132023", "story_v_out_106132.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_106132", "106132023", "story_v_out_106132.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_12 and arg_94_1.time_ < var_97_4 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play106132024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 106132024
		arg_98_1.duration_ = 9.83

		local var_98_0 = {
			ja = 9.833,
			ko = 6.6,
			zh = 8.733,
			en = 6.033
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
				arg_98_0:Play106132025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1093ui_story"]) and arg_98_1.var_.characterEffect1093ui_story == nil then
				arg_98_1.var_.characterEffect1093ui_story = arg_98_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1093ui_story"]) then
				if arg_98_1.var_.characterEffect1093ui_story and not isNil(arg_98_1.actors_["1093ui_story"]) then
					arg_98_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1093ui_story"]) and arg_98_1.var_.characterEffect1093ui_story then
				arg_98_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["1099ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1099ui_story == nil then
				arg_98_1.var_.characterEffect1099ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect1099ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1099ui_story then
				arg_98_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_101_4 = 0
			local var_101_5 = 0.8

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(106132024)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 33 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 33)

				if (33 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 33)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132024", "story_v_out_106132.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_106132", "106132024", "story_v_out_106132.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_106132", "106132024", "story_v_out_106132.awb")

						arg_98_1:RecordAudio("106132024", var_101_11)
						arg_98_1:RecordAudio("106132024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_106132", "106132024", "story_v_out_106132.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_106132", "106132024", "story_v_out_106132.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play106132025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 106132025
		arg_102_1.duration_ = 12.13

		local var_102_0 = {
			ja = 12.133,
			ko = 8.366,
			zh = 7.066,
			en = 7.7
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
				arg_102_0:Play106132026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_105_0 = 0
			local var_105_1 = 0.725

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(106132025)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 29 <= 0 and var_105_1 or var_105_1 * (utf8.len(var_105_3) / 29)

				if (29 <= 0 and var_105_1 or var_105_1 * (utf8.len(var_105_3) / 29)) > 0 and var_105_1 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132025", "story_v_out_106132.awb") ~= 0 then
					local var_105_6 = manager.audio:GetVoiceLength("story_v_out_106132", "106132025", "story_v_out_106132.awb") / 1000

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end

					if var_105_2.prefab_name ~= "" and arg_102_1.actors_[var_105_2.prefab_name] ~= nil then
						local var_105_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_2.prefab_name].transform, "story_v_out_106132", "106132025", "story_v_out_106132.awb")

						arg_102_1:RecordAudio("106132025", var_105_7)
						arg_102_1:RecordAudio("106132025", var_105_7)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_106132", "106132025", "story_v_out_106132.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_106132", "106132025", "story_v_out_106132.awb")
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
	Play106132026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 106132026
		arg_106_1.duration_ = 7.03

		local var_106_0 = {
			ja = 7.033,
			ko = 4.4,
			zh = 5.066,
			en = 4.8
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
				arg_106_0:Play106132027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1099ui_story"]) and arg_106_1.var_.characterEffect1099ui_story == nil then
				arg_106_1.var_.characterEffect1099ui_story = arg_106_1.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1099ui_story"]) then
				if arg_106_1.var_.characterEffect1099ui_story and not isNil(arg_106_1.actors_["1099ui_story"]) then
					arg_106_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1099ui_story"]) and arg_106_1.var_.characterEffect1099ui_story then
				arg_106_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["1093ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect1093ui_story == nil then
				arg_106_1.var_.characterEffect1093ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect1093ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_3)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect1093ui_story then
				arg_106_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action465")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_109_4 = 0
			local var_109_5 = 0.575

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(106132026)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 23 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 23)

				if (23 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 23)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132026", "story_v_out_106132.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_106132", "106132026", "story_v_out_106132.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_106132", "106132026", "story_v_out_106132.awb")

						arg_106_1:RecordAudio("106132026", var_109_11)
						arg_106_1:RecordAudio("106132026", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_106132", "106132026", "story_v_out_106132.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_106132", "106132026", "story_v_out_106132.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_12 and arg_106_1.time_ < var_109_4 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play106132027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 106132027
		arg_110_1.duration_ = 7.77

		local var_110_0 = {
			ja = 7.766,
			ko = 4.533,
			zh = 5.7,
			en = 6.566
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
				arg_110_0:Play106132028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1093ui_story"]) and arg_110_1.var_.characterEffect1093ui_story == nil then
				arg_110_1.var_.characterEffect1093ui_story = arg_110_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1093ui_story"]) then
				if arg_110_1.var_.characterEffect1093ui_story and not isNil(arg_110_1.actors_["1093ui_story"]) then
					arg_110_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1093ui_story"]) and arg_110_1.var_.characterEffect1093ui_story then
				arg_110_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["1099ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1099ui_story == nil then
				arg_110_1.var_.characterEffect1099ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect1099ui_story and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1099ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect1099ui_story then
				arg_110_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1099ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_113_4 = 0
			local var_113_5 = 0.475

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(106132027)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 17 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 17)

				if (17 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 17)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132027", "story_v_out_106132.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_106132", "106132027", "story_v_out_106132.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_106132", "106132027", "story_v_out_106132.awb")

						arg_110_1:RecordAudio("106132027", var_113_11)
						arg_110_1:RecordAudio("106132027", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_106132", "106132027", "story_v_out_106132.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_106132", "106132027", "story_v_out_106132.awb")
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
	Play106132028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 106132028
		arg_114_1.duration_ = 8

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play106132029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1093ui_story"]) and arg_114_1.var_.characterEffect1093ui_story == nil then
				arg_114_1.var_.characterEffect1093ui_story = arg_114_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1093ui_story"]) then
				if arg_114_1.var_.characterEffect1093ui_story and not isNil(arg_114_1.actors_["1093ui_story"]) then
					arg_114_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1093ui_story"]) and arg_114_1.var_.characterEffect1093ui_story then
				arg_114_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_117_1 = arg_114_1.bgs_.C01b.transform

			if 1.5 < arg_114_1.time_ and arg_114_1.time_ <= 1.5 + arg_117_0 then
				arg_114_1.var_.moveOldPosC01b = var_117_1.localPosition
			end

			local var_117_2 = 0.001

			if 1.5 <= arg_114_1.time_ and arg_114_1.time_ < 1.5 + var_117_2 then
				var_117_1.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPosC01b, Vector3.New(0, -100, 10), (arg_114_1.time_ - 1.5) / var_117_2)
			end

			if arg_114_1.time_ >= 1.5 + var_117_2 and arg_114_1.time_ < 1.5 + var_117_2 + arg_117_0 then
				var_117_1.localPosition = Vector3.New(0, -100, 10)
			end

			local var_117_3 = "C07_1"

			if arg_114_1.bgs_.C07_1 == nil then
				local var_117_4 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_117_3)
				var_117_4.name = var_117_3
				var_117_4.transform.parent = arg_114_1.stage_.transform
				var_117_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_[var_117_3] = var_117_4
			end

			if 1.5 < arg_114_1.time_ and arg_114_1.time_ <= 1.5 + arg_117_0 then
				local var_117_5 = arg_114_1.bgs_.C07_1

				arg_114_1.bgs_.C07_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_117_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_6 = var_117_5:GetComponent("SpriteRenderer")

				if var_117_6 and var_117_6.sprite then
					local var_117_7 = 2 * (var_117_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_117_5.transform.localScale = Vector3.New(var_117_7 / var_117_6.sprite.bounds.size.y < var_117_7 * manager.ui.mainCameraCom_.aspect / var_117_6.sprite.bounds.size.x and var_117_7 * manager.ui.mainCameraCom_.aspect / var_117_6.sprite.bounds.size.x or var_117_7 / var_117_6.sprite.bounds.size.y, var_117_7 / var_117_6.sprite.bounds.size.y < var_117_7 * manager.ui.mainCameraCom_.aspect / var_117_6.sprite.bounds.size.x and var_117_7 * manager.ui.mainCameraCom_.aspect / var_117_6.sprite.bounds.size.x or var_117_7 / var_117_6.sprite.bounds.size.y, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "C07_1" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_8 = arg_114_1.actors_["1099ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1099ui_story = var_117_8.localPosition
			end

			local var_117_9 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_9 then
				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1099ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_9)
				var_117_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_8.position).x, (manager.ui.mainCamera.transform.position - var_117_8.position).y, (manager.ui.mainCamera.transform.position - var_117_8.position).z)
				var_117_8.localEulerAngles.z = 0
				var_117_8.localEulerAngles.x = 0
				var_117_8.localEulerAngles = var_117_8.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_9 and arg_114_1.time_ < 0 + var_117_9 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(0, 100, 0)
				var_117_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_8.position).x, (manager.ui.mainCamera.transform.position - var_117_8.position).y, (manager.ui.mainCamera.transform.position - var_117_8.position).z)
				var_117_8.localEulerAngles.z = 0
				var_117_8.localEulerAngles.x = 0
				var_117_8.localEulerAngles = var_117_8.localEulerAngles
			end

			local var_117_10 = arg_114_1.actors_["1093ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1093ui_story = var_117_10.localPosition
			end

			local var_117_11 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_11 then
				var_117_10.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_11)
				var_117_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_10.position).x, (manager.ui.mainCamera.transform.position - var_117_10.position).y, (manager.ui.mainCamera.transform.position - var_117_10.position).z)
				var_117_10.localEulerAngles.z = 0
				var_117_10.localEulerAngles.x = 0
				var_117_10.localEulerAngles = var_117_10.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_11 and arg_114_1.time_ < 0 + var_117_11 + arg_117_0 then
				var_117_10.localPosition = Vector3.New(0, 100, 0)
				var_117_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_10.position).x, (manager.ui.mainCamera.transform.position - var_117_10.position).y, (manager.ui.mainCamera.transform.position - var_117_10.position).z)
				var_117_10.localEulerAngles.z = 0
				var_117_10.localEulerAngles.x = 0
				var_117_10.localEulerAngles = var_117_10.localEulerAngles
			end

			if 1.5 < arg_114_1.time_ and arg_114_1.time_ <= 1.5 + arg_117_0 then
				local var_117_12 = arg_114_1.bgs_.C07_1:GetComponent("SpriteRenderer")

				if var_117_12 then
					arg_114_1.var_.alphaOldValueC07_1 = var_117_12.color.a
					arg_114_1.var_.alphaMatValueC07_1 = var_117_12
				end

				arg_114_1.var_.alphaOldValueC07_1 = 0
			end

			local var_117_13 = 1.5

			if 1.5 <= arg_114_1.time_ and arg_114_1.time_ < 1.5 + var_117_13 then
				if arg_114_1.var_.alphaMatValueC07_1 then
					arg_114_1.var_.alphaMatValueC07_1.color.a = Mathf.Lerp(arg_114_1.var_.alphaOldValueC07_1, 1, (arg_114_1.time_ - 1.5) / var_117_13)
					arg_114_1.var_.alphaMatValueC07_1.color = arg_114_1.var_.alphaMatValueC07_1.color
				end
			end

			if arg_114_1.time_ >= 1.5 + var_117_13 and arg_114_1.time_ < 1.5 + var_117_13 + arg_117_0 and arg_114_1.var_.alphaMatValueC07_1 then
				arg_114_1.var_.alphaMatValueC07_1.color.a = 1
				arg_114_1.var_.alphaMatValueC07_1.color = arg_114_1.var_.alphaMatValueC07_1.color
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				local var_117_14 = arg_114_1.bgs_.C01b:GetComponent("SpriteRenderer")

				if var_117_14 then
					arg_114_1.var_.alphaOldValueC01b = var_117_14.color.a
					arg_114_1.var_.alphaMatValueC01b = var_117_14
				end

				arg_114_1.var_.alphaOldValueC01b = 1
			end

			local var_117_15 = 1.5

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_15 then
				if arg_114_1.var_.alphaMatValueC01b then
					arg_114_1.var_.alphaMatValueC01b.color.a = Mathf.Lerp(arg_114_1.var_.alphaOldValueC01b, 0, (arg_114_1.time_ - 0) / var_117_15)
					arg_114_1.var_.alphaMatValueC01b.color = arg_114_1.var_.alphaMatValueC01b.color
				end
			end

			if arg_114_1.time_ >= 0 + var_117_15 and arg_114_1.time_ < 0 + var_117_15 + arg_117_0 and arg_114_1.var_.alphaMatValueC01b then
				arg_114_1.var_.alphaMatValueC01b.color.a = 0
				arg_114_1.var_.alphaMatValueC01b.color = arg_114_1.var_.alphaMatValueC01b.color
			end

			local var_117_16 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			if arg_114_1.time_ >= var_117_16 + 3 and arg_114_1.time_ < var_117_16 + 3 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_17 = 3
			local var_117_18 = 0.125

			if 3 < arg_114_1.time_ and arg_114_1.time_ <= var_117_17 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_19 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_19:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_20 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(106132028).content)

				arg_114_1.text_.text = var_117_20

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_22 = 5 <= 0 and var_117_18 or var_117_18 * (utf8.len(var_117_20) / 5)

				if (5 <= 0 and var_117_18 or var_117_18 * (utf8.len(var_117_20) / 5)) > 0 and var_117_18 < var_117_22 then
					arg_114_1.talkMaxDuration = var_117_22
					var_117_17 = var_117_17 + 0.3

					if var_117_22 + var_117_17 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_17
					end
				end

				arg_114_1.text_.text = var_117_20
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_23 = var_117_17 + 0.3
			local var_117_24 = math.max(var_117_18, arg_114_1.talkMaxDuration)

			if var_117_17 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_23 + var_117_24 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_23) / var_117_24

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_23 + var_117_24 and arg_114_1.time_ < var_117_23 + var_117_24 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "C01b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play106132029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 106132029
		arg_120_1.duration_ = 4.97

		local var_120_0 = {
			ja = 1.999999999999,
			ko = 2.366,
			zh = 3.9,
			en = 4.966
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
				arg_120_0:Play106132030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if arg_120_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_123_0 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_120_1.stage_.transform)

				var_123_0.name = "4014_tpose"
				var_123_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.actors_["4014_tpose"] = var_123_0

				local var_123_1 = var_123_0:GetComponentInChildren(typeof(CharacterEffect))

				var_123_1.enabled = true

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end

				arg_120_1:ShowWeapon(var_123_1.transform, false)

				arg_120_1.var_["4014_tpose" .. "Animator"] = var_123_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_120_1.var_["4014_tpose" .. "Animator"].applyRootMotion = true
				arg_120_1.var_["4014_tpose" .. "LipSync"] = var_123_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_123_3 = arg_120_1.actors_["4014_tpose"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect4014_tpose == nil then
				arg_120_1.var_.characterEffect4014_tpose = var_123_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_4 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 and not isNil(var_123_3) then
				if arg_120_1.var_.characterEffect4014_tpose and not isNil(var_123_3) then
					arg_120_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 and not isNil(var_123_3) and arg_120_1.var_.characterEffect4014_tpose then
				arg_120_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_123_6 = arg_120_1.actors_["4014_tpose"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos4014_tpose = var_123_6.localPosition

				local var_123_7 = GameObjectTools.GetOrAddComponent(var_123_6.gameObject, typeof(DynamicBoneHelper))

				if var_123_7 then
					var_123_7:EnableDynamicBone(false)
				end
			end

			local var_123_8 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_8 then
				var_123_6.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_120_1.time_ - 0) / var_123_8)
				var_123_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_6.position).x, (manager.ui.mainCamera.transform.position - var_123_6.position).y, (manager.ui.mainCamera.transform.position - var_123_6.position).z)
				var_123_6.localEulerAngles.z = 0
				var_123_6.localEulerAngles.x = 0
				var_123_6.localEulerAngles = var_123_6.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_8 and arg_120_1.time_ < 0 + var_123_8 + arg_123_0 then
				var_123_6.localPosition = Vector3.New(0, -1.95, -4.2)
				var_123_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_6.position).x, (manager.ui.mainCamera.transform.position - var_123_6.position).y, (manager.ui.mainCamera.transform.position - var_123_6.position).z)
				var_123_6.localEulerAngles.z = 0
				var_123_6.localEulerAngles.x = 0
				var_123_6.localEulerAngles = var_123_6.localEulerAngles

				local var_123_9 = GameObjectTools.GetOrAddComponent(var_123_6.gameObject, typeof(DynamicBoneHelper))

				if var_123_9 then
					var_123_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_123_10 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_11 = 0.5

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 then
				local var_123_12 = Color.New(1, 1, 1)

				var_123_12.a = Mathf.Lerp(1, 0, (arg_120_1.time_ - var_123_10) / var_123_11)
				arg_120_1.mask_.color = var_123_12
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 then
				local var_123_13 = Color.New(1, 1, 1)

				arg_120_1.mask_.enabled = false
				var_123_13.a = 0
				arg_120_1.mask_.color = var_123_13
			end

			local var_123_14 = 0.5
			local var_123_15 = 0.225

			if 0.5 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_16 = arg_120_1:GetWordFromCfg(106132029)
				local var_123_17 = arg_120_1:FormatText(var_123_16.content)

				arg_120_1.text_.text = var_123_17

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_19 = 9 <= 0 and var_123_15 or var_123_15 * (utf8.len(var_123_17) / 9)

				if (9 <= 0 and var_123_15 or var_123_15 * (utf8.len(var_123_17) / 9)) > 0 and var_123_15 < var_123_19 then
					arg_120_1.talkMaxDuration = var_123_19

					if var_123_19 + var_123_14 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_14
					end
				end

				arg_120_1.text_.text = var_123_17
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132029", "story_v_out_106132.awb") ~= 0 then
					local var_123_20 = manager.audio:GetVoiceLength("story_v_out_106132", "106132029", "story_v_out_106132.awb") / 1000

					if var_123_20 + var_123_14 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_20 + var_123_14
					end

					if var_123_16.prefab_name ~= "" and arg_120_1.actors_[var_123_16.prefab_name] ~= nil then
						local var_123_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_16.prefab_name].transform, "story_v_out_106132", "106132029", "story_v_out_106132.awb")

						arg_120_1:RecordAudio("106132029", var_123_21)
						arg_120_1:RecordAudio("106132029", var_123_21)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_106132", "106132029", "story_v_out_106132.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_106132", "106132029", "story_v_out_106132.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_22 = math.max(var_123_15, arg_120_1.talkMaxDuration)

			if var_123_14 <= arg_120_1.time_ and arg_120_1.time_ < var_123_14 + var_123_22 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_14) / var_123_22

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_14 + var_123_22 and arg_120_1.time_ < var_123_14 + var_123_22 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play106132030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 106132030
		arg_124_1.duration_ = 2.57

		local var_124_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.566,
			en = 1.999999999999
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
				arg_124_0:Play106132031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["4014_tpose"]) and arg_124_1.var_.characterEffect4014_tpose == nil then
				arg_124_1.var_.characterEffect4014_tpose = arg_124_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["4014_tpose"]) then
				if arg_124_1.var_.characterEffect4014_tpose and not isNil(arg_124_1.actors_["4014_tpose"]) then
					arg_124_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_124_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["4014_tpose"]) and arg_124_1.var_.characterEffect4014_tpose then
				arg_124_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_124_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_127_1 = "10004ui_story"

			if arg_124_1.actors_["10004ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10004ui_story"))) then
				local var_127_2 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_124_1.stage_.transform)

				var_127_2.name = var_127_1
				var_127_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.actors_[var_127_1] = var_127_2

				local var_127_3 = var_127_2:GetComponentInChildren(typeof(CharacterEffect))

				var_127_3.enabled = true

				local var_127_4 = GameObjectTools.GetOrAddComponent(var_127_2, typeof(DynamicBoneHelper))

				if var_127_4 then
					var_127_4:EnableDynamicBone(false)
				end

				arg_124_1:ShowWeapon(var_127_3.transform, false)

				arg_124_1.var_[var_127_1 .. "Animator"] = var_127_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_124_1.var_[var_127_1 .. "Animator"].applyRootMotion = true
				arg_124_1.var_[var_127_1 .. "LipSync"] = var_127_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_127_5 = arg_124_1.actors_["10004ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_5) and arg_124_1.var_.characterEffect10004ui_story == nil then
				arg_124_1.var_.characterEffect10004ui_story = var_127_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_6 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_6 and not isNil(var_127_5) then
				if arg_124_1.var_.characterEffect10004ui_story and not isNil(var_127_5) then
					arg_124_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_6 and arg_124_1.time_ < 0 + var_127_6 + arg_127_0 and not isNil(var_127_5) and arg_124_1.var_.characterEffect10004ui_story then
				arg_124_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_127_8 = arg_124_1.actors_["4014_tpose"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos4014_tpose = var_127_8.localPosition

				local var_127_9 = GameObjectTools.GetOrAddComponent(var_127_8.gameObject, typeof(DynamicBoneHelper))

				if var_127_9 then
					var_127_9:EnableDynamicBone(false)
				end
			end

			local var_127_10 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_10 then
				var_127_8.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_10)
				var_127_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_8.position).x, (manager.ui.mainCamera.transform.position - var_127_8.position).y, (manager.ui.mainCamera.transform.position - var_127_8.position).z)
				var_127_8.localEulerAngles.z = 0
				var_127_8.localEulerAngles.x = 0
				var_127_8.localEulerAngles = var_127_8.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_10 and arg_124_1.time_ < 0 + var_127_10 + arg_127_0 then
				var_127_8.localPosition = Vector3.New(0, 100, 0)
				var_127_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_8.position).x, (manager.ui.mainCamera.transform.position - var_127_8.position).y, (manager.ui.mainCamera.transform.position - var_127_8.position).z)
				var_127_8.localEulerAngles.z = 0
				var_127_8.localEulerAngles.x = 0
				var_127_8.localEulerAngles = var_127_8.localEulerAngles

				local var_127_11 = GameObjectTools.GetOrAddComponent(var_127_8.gameObject, typeof(DynamicBoneHelper))

				if var_127_11 then
					var_127_11:EnableDynamicBone(true)
				end
			end

			local var_127_12 = arg_124_1.actors_["10004ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10004ui_story = var_127_12.localPosition
			end

			local var_127_13 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_13 then
				var_127_12.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10004ui_story, Vector3.New(0, -1.1, -5.6), (arg_124_1.time_ - 0) / var_127_13)
				var_127_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_12.position).x, (manager.ui.mainCamera.transform.position - var_127_12.position).y, (manager.ui.mainCamera.transform.position - var_127_12.position).z)
				var_127_12.localEulerAngles.z = 0
				var_127_12.localEulerAngles.x = 0
				var_127_12.localEulerAngles = var_127_12.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_13 and arg_124_1.time_ < 0 + var_127_13 + arg_127_0 then
				var_127_12.localPosition = Vector3.New(0, -1.1, -5.6)
				var_127_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_12.position).x, (manager.ui.mainCamera.transform.position - var_127_12.position).y, (manager.ui.mainCamera.transform.position - var_127_12.position).z)
				var_127_12.localEulerAngles.z = 0
				var_127_12.localEulerAngles.x = 0
				var_127_12.localEulerAngles = var_127_12.localEulerAngles
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_127_14 = 0
			local var_127_15 = 0.2

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_14 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_16 = arg_124_1:GetWordFromCfg(106132030)
				local var_127_17 = arg_124_1:FormatText(var_127_16.content)

				arg_124_1.text_.text = var_127_17

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_19 = 8 <= 0 and var_127_15 or var_127_15 * (utf8.len(var_127_17) / 8)

				if (8 <= 0 and var_127_15 or var_127_15 * (utf8.len(var_127_17) / 8)) > 0 and var_127_15 < var_127_19 then
					arg_124_1.talkMaxDuration = var_127_19

					if var_127_19 + var_127_14 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_19 + var_127_14
					end
				end

				arg_124_1.text_.text = var_127_17
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132030", "story_v_out_106132.awb") ~= 0 then
					local var_127_20 = manager.audio:GetVoiceLength("story_v_out_106132", "106132030", "story_v_out_106132.awb") / 1000

					if var_127_20 + var_127_14 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_20 + var_127_14
					end

					if var_127_16.prefab_name ~= "" and arg_124_1.actors_[var_127_16.prefab_name] ~= nil then
						local var_127_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_16.prefab_name].transform, "story_v_out_106132", "106132030", "story_v_out_106132.awb")

						arg_124_1:RecordAudio("106132030", var_127_21)
						arg_124_1:RecordAudio("106132030", var_127_21)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_106132", "106132030", "story_v_out_106132.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_106132", "106132030", "story_v_out_106132.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_22 = math.max(var_127_15, arg_124_1.talkMaxDuration)

			if var_127_14 <= arg_124_1.time_ and arg_124_1.time_ < var_127_14 + var_127_22 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_14) / var_127_22

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_14 + var_127_22 and arg_124_1.time_ < var_127_14 + var_127_22 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play106132031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 106132031
		arg_128_1.duration_ = 3.73

		local var_128_0 = {
			ja = 3.333,
			ko = 2.8,
			zh = 3.733,
			en = 3.3
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
				arg_128_0:Play106132032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["4014_tpose"]) and arg_128_1.var_.characterEffect4014_tpose == nil then
				arg_128_1.var_.characterEffect4014_tpose = arg_128_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.1

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["4014_tpose"]) then
				if arg_128_1.var_.characterEffect4014_tpose and not isNil(arg_128_1.actors_["4014_tpose"]) then
					arg_128_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["4014_tpose"]) and arg_128_1.var_.characterEffect4014_tpose then
				arg_128_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["10004ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect10004ui_story == nil then
				arg_128_1.var_.characterEffect10004ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.1

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect10004ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect10004ui_story then
				arg_128_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_131_4 = arg_128_1.actors_["4014_tpose"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos4014_tpose = var_131_4.localPosition

				local var_131_5 = GameObjectTools.GetOrAddComponent(var_131_4.gameObject, typeof(DynamicBoneHelper))

				if var_131_5 then
					var_131_5:EnableDynamicBone(false)
				end
			end

			local var_131_6 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_6 then
				var_131_4.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_128_1.time_ - 0) / var_131_6)
				var_131_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_4.position).x, (manager.ui.mainCamera.transform.position - var_131_4.position).y, (manager.ui.mainCamera.transform.position - var_131_4.position).z)
				var_131_4.localEulerAngles.z = 0
				var_131_4.localEulerAngles.x = 0
				var_131_4.localEulerAngles = var_131_4.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_6 and arg_128_1.time_ < 0 + var_131_6 + arg_131_0 then
				var_131_4.localPosition = Vector3.New(0, -1.95, -4.2)
				var_131_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_4.position).x, (manager.ui.mainCamera.transform.position - var_131_4.position).y, (manager.ui.mainCamera.transform.position - var_131_4.position).z)
				var_131_4.localEulerAngles.z = 0
				var_131_4.localEulerAngles.x = 0
				var_131_4.localEulerAngles = var_131_4.localEulerAngles

				local var_131_7 = GameObjectTools.GetOrAddComponent(var_131_4.gameObject, typeof(DynamicBoneHelper))

				if var_131_7 then
					var_131_7:EnableDynamicBone(true)
				end
			end

			local var_131_8 = arg_128_1.actors_["10004ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10004ui_story = var_131_8.localPosition
			end

			local var_131_9 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_9 then
				var_131_8.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_9)
				var_131_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_8.position).x, (manager.ui.mainCamera.transform.position - var_131_8.position).y, (manager.ui.mainCamera.transform.position - var_131_8.position).z)
				var_131_8.localEulerAngles.z = 0
				var_131_8.localEulerAngles.x = 0
				var_131_8.localEulerAngles = var_131_8.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_9 and arg_128_1.time_ < 0 + var_131_9 + arg_131_0 then
				var_131_8.localPosition = Vector3.New(0, 100, 0)
				var_131_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_8.position).x, (manager.ui.mainCamera.transform.position - var_131_8.position).y, (manager.ui.mainCamera.transform.position - var_131_8.position).z)
				var_131_8.localEulerAngles.z = 0
				var_131_8.localEulerAngles.x = 0
				var_131_8.localEulerAngles = var_131_8.localEulerAngles
			end

			local var_131_10 = 0
			local var_131_11 = 0.3

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_12 = arg_128_1:GetWordFromCfg(106132031)
				local var_131_13 = arg_128_1:FormatText(var_131_12.content)

				arg_128_1.text_.text = var_131_13

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_15 = 12 <= 0 and var_131_11 or var_131_11 * (utf8.len(var_131_13) / 12)

				if (12 <= 0 and var_131_11 or var_131_11 * (utf8.len(var_131_13) / 12)) > 0 and var_131_11 < var_131_15 then
					arg_128_1.talkMaxDuration = var_131_15

					if var_131_15 + var_131_10 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_15 + var_131_10
					end
				end

				arg_128_1.text_.text = var_131_13
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132031", "story_v_out_106132.awb") ~= 0 then
					local var_131_16 = manager.audio:GetVoiceLength("story_v_out_106132", "106132031", "story_v_out_106132.awb") / 1000

					if var_131_16 + var_131_10 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_16 + var_131_10
					end

					if var_131_12.prefab_name ~= "" and arg_128_1.actors_[var_131_12.prefab_name] ~= nil then
						local var_131_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_12.prefab_name].transform, "story_v_out_106132", "106132031", "story_v_out_106132.awb")

						arg_128_1:RecordAudio("106132031", var_131_17)
						arg_128_1:RecordAudio("106132031", var_131_17)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_106132", "106132031", "story_v_out_106132.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_106132", "106132031", "story_v_out_106132.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_18 = math.max(var_131_11, arg_128_1.talkMaxDuration)

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_18 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_10) / var_131_18

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_10 + var_131_18 and arg_128_1.time_ < var_131_10 + var_131_18 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play106132032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 106132032
		arg_132_1.duration_ = 3.47

		local var_132_0 = {
			ja = 3.466,
			ko = 2.866,
			zh = 3.2,
			en = 2.033
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
				arg_132_0:Play106132033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["4014_tpose"]) and arg_132_1.var_.characterEffect4014_tpose == nil then
				arg_132_1.var_.characterEffect4014_tpose = arg_132_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["4014_tpose"]) then
				if arg_132_1.var_.characterEffect4014_tpose and not isNil(arg_132_1.actors_["4014_tpose"]) then
					arg_132_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_132_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["4014_tpose"]) and arg_132_1.var_.characterEffect4014_tpose then
				arg_132_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_132_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_135_1 = arg_132_1.actors_["10004ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect10004ui_story == nil then
				arg_132_1.var_.characterEffect10004ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect10004ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect10004ui_story then
				arg_132_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_135_4 = arg_132_1.actors_["4014_tpose"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos4014_tpose = var_135_4.localPosition

				local var_135_5 = GameObjectTools.GetOrAddComponent(var_135_4.gameObject, typeof(DynamicBoneHelper))

				if var_135_5 then
					var_135_5:EnableDynamicBone(false)
				end
			end

			local var_135_6 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_6 then
				var_135_4.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_6)
				var_135_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_4.position).x, (manager.ui.mainCamera.transform.position - var_135_4.position).y, (manager.ui.mainCamera.transform.position - var_135_4.position).z)
				var_135_4.localEulerAngles.z = 0
				var_135_4.localEulerAngles.x = 0
				var_135_4.localEulerAngles = var_135_4.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_6 and arg_132_1.time_ < 0 + var_135_6 + arg_135_0 then
				var_135_4.localPosition = Vector3.New(0, 100, 0)
				var_135_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_4.position).x, (manager.ui.mainCamera.transform.position - var_135_4.position).y, (manager.ui.mainCamera.transform.position - var_135_4.position).z)
				var_135_4.localEulerAngles.z = 0
				var_135_4.localEulerAngles.x = 0
				var_135_4.localEulerAngles = var_135_4.localEulerAngles

				local var_135_7 = GameObjectTools.GetOrAddComponent(var_135_4.gameObject, typeof(DynamicBoneHelper))

				if var_135_7 then
					var_135_7:EnableDynamicBone(true)
				end
			end

			local var_135_8 = arg_132_1.actors_["10004ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10004ui_story = var_135_8.localPosition
			end

			local var_135_9 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_9 then
				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10004ui_story, Vector3.New(0, -1.1, -5.6), (arg_132_1.time_ - 0) / var_135_9)
				var_135_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_8.position).x, (manager.ui.mainCamera.transform.position - var_135_8.position).y, (manager.ui.mainCamera.transform.position - var_135_8.position).z)
				var_135_8.localEulerAngles.z = 0
				var_135_8.localEulerAngles.x = 0
				var_135_8.localEulerAngles = var_135_8.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_9 and arg_132_1.time_ < 0 + var_135_9 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(0, -1.1, -5.6)
				var_135_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_8.position).x, (manager.ui.mainCamera.transform.position - var_135_8.position).y, (manager.ui.mainCamera.transform.position - var_135_8.position).z)
				var_135_8.localEulerAngles.z = 0
				var_135_8.localEulerAngles.x = 0
				var_135_8.localEulerAngles = var_135_8.localEulerAngles
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_135_10 = 0
			local var_135_11 = 0.375

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_12 = arg_132_1:GetWordFromCfg(106132032)
				local var_135_13 = arg_132_1:FormatText(var_135_12.content)

				arg_132_1.text_.text = var_135_13

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_15 = 15 <= 0 and var_135_11 or var_135_11 * (utf8.len(var_135_13) / 15)

				if (15 <= 0 and var_135_11 or var_135_11 * (utf8.len(var_135_13) / 15)) > 0 and var_135_11 < var_135_15 then
					arg_132_1.talkMaxDuration = var_135_15

					if var_135_15 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_15 + var_135_10
					end
				end

				arg_132_1.text_.text = var_135_13
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132032", "story_v_out_106132.awb") ~= 0 then
					local var_135_16 = manager.audio:GetVoiceLength("story_v_out_106132", "106132032", "story_v_out_106132.awb") / 1000

					if var_135_16 + var_135_10 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_16 + var_135_10
					end

					if var_135_12.prefab_name ~= "" and arg_132_1.actors_[var_135_12.prefab_name] ~= nil then
						local var_135_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_12.prefab_name].transform, "story_v_out_106132", "106132032", "story_v_out_106132.awb")

						arg_132_1:RecordAudio("106132032", var_135_17)
						arg_132_1:RecordAudio("106132032", var_135_17)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_106132", "106132032", "story_v_out_106132.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_106132", "106132032", "story_v_out_106132.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_18 = math.max(var_135_11, arg_132_1.talkMaxDuration)

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_18 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_10) / var_135_18

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_10 + var_135_18 and arg_132_1.time_ < var_135_10 + var_135_18 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play106132033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 106132033
		arg_136_1.duration_ = 5.47

		local var_136_0 = {
			ja = 5.466,
			ko = 4.1,
			zh = 4.2,
			en = 4.866
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
				arg_136_0:Play106132034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["4014_tpose"]) and arg_136_1.var_.characterEffect4014_tpose == nil then
				arg_136_1.var_.characterEffect4014_tpose = arg_136_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["4014_tpose"]) then
				if arg_136_1.var_.characterEffect4014_tpose and not isNil(arg_136_1.actors_["4014_tpose"]) then
					arg_136_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["4014_tpose"]) and arg_136_1.var_.characterEffect4014_tpose then
				arg_136_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["10004ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect10004ui_story == nil then
				arg_136_1.var_.characterEffect10004ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect10004ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect10004ui_story then
				arg_136_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_139_4 = arg_136_1.actors_["4014_tpose"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos4014_tpose = var_139_4.localPosition

				local var_139_5 = GameObjectTools.GetOrAddComponent(var_139_4.gameObject, typeof(DynamicBoneHelper))

				if var_139_5 then
					var_139_5:EnableDynamicBone(false)
				end
			end

			local var_139_6 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_6 then
				var_139_4.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_136_1.time_ - 0) / var_139_6)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_6 and arg_136_1.time_ < 0 + var_139_6 + arg_139_0 then
				var_139_4.localPosition = Vector3.New(0, -1.95, -4.2)
				var_139_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_4.position).x, (manager.ui.mainCamera.transform.position - var_139_4.position).y, (manager.ui.mainCamera.transform.position - var_139_4.position).z)
				var_139_4.localEulerAngles.z = 0
				var_139_4.localEulerAngles.x = 0
				var_139_4.localEulerAngles = var_139_4.localEulerAngles

				local var_139_7 = GameObjectTools.GetOrAddComponent(var_139_4.gameObject, typeof(DynamicBoneHelper))

				if var_139_7 then
					var_139_7:EnableDynamicBone(true)
				end
			end

			local var_139_8 = arg_136_1.actors_["10004ui_story"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos10004ui_story = var_139_8.localPosition
			end

			local var_139_9 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_9 then
				var_139_8.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_9)
				var_139_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_8.position).x, (manager.ui.mainCamera.transform.position - var_139_8.position).y, (manager.ui.mainCamera.transform.position - var_139_8.position).z)
				var_139_8.localEulerAngles.z = 0
				var_139_8.localEulerAngles.x = 0
				var_139_8.localEulerAngles = var_139_8.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_9 and arg_136_1.time_ < 0 + var_139_9 + arg_139_0 then
				var_139_8.localPosition = Vector3.New(0, 100, 0)
				var_139_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_8.position).x, (manager.ui.mainCamera.transform.position - var_139_8.position).y, (manager.ui.mainCamera.transform.position - var_139_8.position).z)
				var_139_8.localEulerAngles.z = 0
				var_139_8.localEulerAngles.x = 0
				var_139_8.localEulerAngles = var_139_8.localEulerAngles
			end

			local var_139_10 = 0
			local var_139_11 = 0.35

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_12 = arg_136_1:GetWordFromCfg(106132033)
				local var_139_13 = arg_136_1:FormatText(var_139_12.content)

				arg_136_1.text_.text = var_139_13

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_15 = 14 <= 0 and var_139_11 or var_139_11 * (utf8.len(var_139_13) / 14)

				if (14 <= 0 and var_139_11 or var_139_11 * (utf8.len(var_139_13) / 14)) > 0 and var_139_11 < var_139_15 then
					arg_136_1.talkMaxDuration = var_139_15

					if var_139_15 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_10
					end
				end

				arg_136_1.text_.text = var_139_13
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132033", "story_v_out_106132.awb") ~= 0 then
					local var_139_16 = manager.audio:GetVoiceLength("story_v_out_106132", "106132033", "story_v_out_106132.awb") / 1000

					if var_139_16 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_16 + var_139_10
					end

					if var_139_12.prefab_name ~= "" and arg_136_1.actors_[var_139_12.prefab_name] ~= nil then
						local var_139_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_12.prefab_name].transform, "story_v_out_106132", "106132033", "story_v_out_106132.awb")

						arg_136_1:RecordAudio("106132033", var_139_17)
						arg_136_1:RecordAudio("106132033", var_139_17)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_106132", "106132033", "story_v_out_106132.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_106132", "106132033", "story_v_out_106132.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_18 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_18 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_10) / var_139_18

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_10 + var_139_18 and arg_136_1.time_ < var_139_10 + var_139_18 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play106132034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 106132034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play106132035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["4014_tpose"]) and arg_140_1.var_.characterEffect4014_tpose == nil then
				arg_140_1.var_.characterEffect4014_tpose = arg_140_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["4014_tpose"]) then
				if arg_140_1.var_.characterEffect4014_tpose and not isNil(arg_140_1.actors_["4014_tpose"]) then
					arg_140_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_140_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["4014_tpose"]) and arg_140_1.var_.characterEffect4014_tpose then
				arg_140_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_140_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.75

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(106132034).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 30 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 30)

				if (30 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 30)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play106132035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 106132035
		arg_144_1.duration_ = 7.63

		local var_144_0 = {
			ja = 5.9,
			ko = 6.433,
			zh = 6.066,
			en = 7.633
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
			arg_144_1.auto_ = false
		end

		function arg_144_1.playNext_(arg_146_0)
			arg_144_1.onStoryFinished_()
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["4014_tpose"]) and arg_144_1.var_.characterEffect4014_tpose == nil then
				arg_144_1.var_.characterEffect4014_tpose = arg_144_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["4014_tpose"]) then
				if arg_144_1.var_.characterEffect4014_tpose and not isNil(arg_144_1.actors_["4014_tpose"]) then
					arg_144_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["4014_tpose"]) and arg_144_1.var_.characterEffect4014_tpose then
				arg_144_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_147_2 = 0
			local var_147_3 = 0.525

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(106132035)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 21 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 21)

				if (21 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 21)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132035", "story_v_out_106132.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_106132", "106132035", "story_v_out_106132.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_106132", "106132035", "story_v_out_106132.awb")

						arg_144_1:RecordAudio("106132035", var_147_9)
						arg_144_1:RecordAudio("106132035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_106132", "106132035", "story_v_out_106132.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_106132", "106132035", "story_v_out_106132.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C01b",
		"TextureConfig/Background/C07_1"
	},
	voices = {
		"story_v_out_106132.awb"
	}
}
