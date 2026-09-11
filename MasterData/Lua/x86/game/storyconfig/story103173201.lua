return {
	Play317321001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317321001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317321002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K09f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K09f")
				var_4_0.name = "K09f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K09f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K09f

				arg_1_1.bgs_.K09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K09f" then
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 2
			local var_4_12 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
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

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317321001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 32 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 32)

				if (32 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 32)) > 0 and var_4_12 < var_4_16 then
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
	Play317321002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 317321002
		arg_8_1.duration_ = 7

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play317321003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.bgs_.K11g == nil then
				local var_11_0 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11g")
				var_11_0.name = "K11g"
				var_11_0.transform.parent = arg_8_1.stage_.transform
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_.K11g = var_11_0
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				local var_11_1 = arg_8_1.bgs_.K11g

				arg_8_1.bgs_.K11g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_11_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_2 = var_11_1:GetComponent("SpriteRenderer")

				if var_11_2 and var_11_2.sprite then
					local var_11_3 = 2 * (var_11_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_11_1.transform.localScale = Vector3.New(var_11_3 / var_11_2.sprite.bounds.size.y < var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x and var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x or var_11_3 / var_11_2.sprite.bounds.size.y, var_11_3 / var_11_2.sprite.bounds.size.y < var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x and var_11_3 * manager.ui.mainCameraCom_.aspect / var_11_2.sprite.bounds.size.x or var_11_3 / var_11_2.sprite.bounds.size.y, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "K11g" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_11_4 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_5 = 2

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_5 then
				local var_11_6 = Color.New(0, 0, 0)

				var_11_6.a = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_4) / var_11_5)
				arg_8_1.mask_.color = var_11_6
			end

			if arg_8_1.time_ >= var_11_4 + var_11_5 and arg_8_1.time_ < var_11_4 + var_11_5 + arg_11_0 then
				local var_11_7 = Color.New(0, 0, 0)

				arg_8_1.mask_.enabled = false
				var_11_7.a = 0
				arg_8_1.mask_.color = var_11_7
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_11_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_10 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_10

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_10
						arg_8_1.bgmTxt2_.text = var_11_10
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

			if 0.733333333333333 < arg_8_1.time_ and arg_8_1.time_ <= 0.733333333333333 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_11_13 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_13 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_13

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_13
						arg_8_1.bgmTxt2_.text = var_11_13
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

			local var_11_14 = 2
			local var_11_15 = 0.775

			if 2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_16 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_16:setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
					arg_8_1.dialogCg_.alpha = arg_14_0
				end))
				var_11_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_17 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(317321002).content)

				arg_8_1.text_.text = var_11_17

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 31 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 31)

				if (31 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 31)) > 0 and var_11_15 < var_11_19 then
					arg_8_1.talkMaxDuration = var_11_19
					var_11_14 = var_11_14 + 0.3

					if var_11_19 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_19 + var_11_14
					end
				end

				arg_8_1.text_.text = var_11_17
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_20 = var_11_14 + 0.3
			local var_11_21 = math.max(var_11_15, arg_8_1.talkMaxDuration)

			if var_11_14 + 0.3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_21 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_20) / var_11_21

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_20 + var_11_21 and arg_8_1.time_ < var_11_20 + var_11_21 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play317321003 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 317321003
		arg_16_1.duration_ = 4.37

		local var_16_0 = {
			zh = 2.733,
			ja = 4.366
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
				arg_16_0:Play317321004(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1093ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1093ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1093ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1093ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1093ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1093ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = arg_16_1.actors_["1093ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1093ui_story == nil then
				arg_16_1.var_.characterEffect1093ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect1093ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1093ui_story then
				arg_16_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_19_8 = 0
			local var_19_9 = 0.275

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(317321003)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 11 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 11)

				if (11 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 11)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321003", "story_v_out_317321.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321003", "story_v_out_317321.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_317321", "317321003", "story_v_out_317321.awb")

						arg_16_1:RecordAudio("317321003", var_19_15)
						arg_16_1:RecordAudio("317321003", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_317321", "317321003", "story_v_out_317321.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_317321", "317321003", "story_v_out_317321.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play317321004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 317321004
		arg_20_1.duration_ = 5.67

		local var_20_0 = {
			zh = 1.999999999999,
			ja = 5.666
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play317321005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1058ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1058ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1058ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1058ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1058ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1058ui_story = var_23_3.localPosition
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_20_1.time_ - 0) / var_23_4)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0.7, -0.95, -5.88)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			local var_23_5 = arg_20_1.actors_["1058ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1058ui_story == nil then
				arg_20_1.var_.characterEffect1058ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.characterEffect1058ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1058ui_story then
				arg_20_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_8 = arg_20_1.actors_["1093ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.characterEffect1093ui_story == nil then
				arg_20_1.var_.characterEffect1093ui_story = var_23_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_9 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_9 and not isNil(var_23_8) then
				if arg_20_1.var_.characterEffect1093ui_story and not isNil(var_23_8) then
					arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_9)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_9 and arg_20_1.time_ < 0 + var_23_9 + arg_23_0 and not isNil(var_23_8) and arg_20_1.var_.characterEffect1093ui_story then
				arg_20_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_23_10 = 0
			local var_23_11 = 0.15

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(317321004)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 6 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 6)

				if (6 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 6)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321004", "story_v_out_317321.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_317321", "317321004", "story_v_out_317321.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_317321", "317321004", "story_v_out_317321.awb")

						arg_20_1:RecordAudio("317321004", var_23_17)
						arg_20_1:RecordAudio("317321004", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_317321", "317321004", "story_v_out_317321.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_317321", "317321004", "story_v_out_317321.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play317321005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 317321005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play317321006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) and arg_24_1.var_.characterEffect1058ui_story == nil then
				arg_24_1.var_.characterEffect1058ui_story = arg_24_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) then
				if arg_24_1.var_.characterEffect1058ui_story and not isNil(arg_24_1.actors_["1058ui_story"]) then
					arg_24_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) and arg_24_1.var_.characterEffect1058ui_story then
				arg_24_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.85

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

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(317321005).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 34 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 34)

				if (34 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 34)) > 0 and var_27_2 < var_27_5 then
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
	Play317321006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 317321006
		arg_28_1.duration_ = 5.17

		local var_28_0 = {
			zh = 5.166,
			ja = 4.7
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
				arg_28_0:Play317321007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1058ui_story = arg_28_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1058ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).z)
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles = arg_28_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -5.88)
				arg_28_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).z)
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles = arg_28_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1058ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1058ui_story == nil then
				arg_28_1.var_.characterEffect1058ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect1058ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1058ui_story then
				arg_28_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_2")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_4 = 0
			local var_31_5 = 0.625

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(317321006)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 25 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 25)

				if (25 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 25)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321006", "story_v_out_317321.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321006", "story_v_out_317321.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_317321", "317321006", "story_v_out_317321.awb")

						arg_28_1:RecordAudio("317321006", var_31_11)
						arg_28_1:RecordAudio("317321006", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_317321", "317321006", "story_v_out_317321.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_317321", "317321006", "story_v_out_317321.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play317321007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 317321007
		arg_32_1.duration_ = 6.43

		local var_32_0 = {
			zh = 6.3,
			ja = 6.433
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
				arg_32_0:Play317321008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "1199ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1199ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["1199ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["1199ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["1199ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1199ui_story = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_32_1.time_ - 0) / var_35_4)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			local var_35_5 = arg_32_1.actors_["1199ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1199ui_story == nil then
				arg_32_1.var_.characterEffect1199ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect1199ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1199ui_story then
				arg_32_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_8 = arg_32_1.actors_["1093ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1093ui_story = var_35_8.localPosition
			end

			local var_35_9 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0, 100, 0)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			local var_35_10 = arg_32_1.actors_["1093ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1093ui_story == nil then
				arg_32_1.var_.characterEffect1093ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 and not isNil(var_35_10) then
				if arg_32_1.var_.characterEffect1093ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_11)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1093ui_story then
				arg_32_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_35_12 = arg_32_1.actors_["1058ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1058ui_story = var_35_12.localPosition
			end

			local var_35_13 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_13 then
				var_35_12.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_13)
				var_35_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_12.position).x, (manager.ui.mainCamera.transform.position - var_35_12.position).y, (manager.ui.mainCamera.transform.position - var_35_12.position).z)
				var_35_12.localEulerAngles.z = 0
				var_35_12.localEulerAngles.x = 0
				var_35_12.localEulerAngles = var_35_12.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_13 and arg_32_1.time_ < 0 + var_35_13 + arg_35_0 then
				var_35_12.localPosition = Vector3.New(0, 100, 0)
				var_35_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_12.position).x, (manager.ui.mainCamera.transform.position - var_35_12.position).y, (manager.ui.mainCamera.transform.position - var_35_12.position).z)
				var_35_12.localEulerAngles.z = 0
				var_35_12.localEulerAngles.x = 0
				var_35_12.localEulerAngles = var_35_12.localEulerAngles
			end

			local var_35_14 = arg_32_1.actors_["1058ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1058ui_story == nil then
				arg_32_1.var_.characterEffect1058ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_15 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_15 and not isNil(var_35_14) then
				if arg_32_1.var_.characterEffect1058ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_15)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_15 and arg_32_1.time_ < 0 + var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1058ui_story then
				arg_32_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_35_16 = 0
			local var_35_17 = 0.775

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(317321007)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_21 = 31 <= 0 and var_35_17 or var_35_17 * (utf8.len(var_35_19) / 31)

				if (31 <= 0 and var_35_17 or var_35_17 * (utf8.len(var_35_19) / 31)) > 0 and var_35_17 < var_35_21 then
					arg_32_1.talkMaxDuration = var_35_21

					if var_35_21 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_21 + var_35_16
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321007", "story_v_out_317321.awb") ~= 0 then
					local var_35_22 = manager.audio:GetVoiceLength("story_v_out_317321", "317321007", "story_v_out_317321.awb") / 1000

					if var_35_22 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_16
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_out_317321", "317321007", "story_v_out_317321.awb")

						arg_32_1:RecordAudio("317321007", var_35_23)
						arg_32_1:RecordAudio("317321007", var_35_23)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_317321", "317321007", "story_v_out_317321.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_317321", "317321007", "story_v_out_317321.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_24 = math.max(var_35_17, arg_32_1.talkMaxDuration)

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_24 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_16) / var_35_24

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_16 + var_35_24 and arg_32_1.time_ < var_35_16 + var_35_24 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play317321008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 317321008
		arg_36_1.duration_ = 8.07

		local var_36_0 = {
			zh = 5.466,
			ja = 8.066
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
				arg_36_0:Play317321009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1199ui_story = arg_36_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1199ui_story"].transform.position).z)
				arg_36_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1199ui_story"].transform.localEulerAngles = arg_36_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1199ui_story"].transform.position).z)
				arg_36_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1199ui_story"].transform.localEulerAngles = arg_36_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1199ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1199ui_story == nil then
				arg_36_1.var_.characterEffect1199ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 and not isNil(var_39_1) then
				if arg_36_1.var_.characterEffect1199ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_2)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1199ui_story then
				arg_36_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_39_3 = arg_36_1.actors_["1093ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1093ui_story = var_39_3.localPosition
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_36_1.time_ - 0) / var_39_4)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			local var_39_5 = arg_36_1.actors_["1093ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1093ui_story == nil then
				arg_36_1.var_.characterEffect1093ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 and not isNil(var_39_5) then
				if arg_36_1.var_.characterEffect1093ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1093ui_story then
				arg_36_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_39_8 = 0
			local var_39_9 = 0.6

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(317321008)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 24 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 24)

				if (24 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 24)) > 0 and var_39_9 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321008", "story_v_out_317321.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321008", "story_v_out_317321.awb") / 1000

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end

					if var_39_10.prefab_name ~= "" and arg_36_1.actors_[var_39_10.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_10.prefab_name].transform, "story_v_out_317321", "317321008", "story_v_out_317321.awb")

						arg_36_1:RecordAudio("317321008", var_39_15)
						arg_36_1:RecordAudio("317321008", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_317321", "317321008", "story_v_out_317321.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_317321", "317321008", "story_v_out_317321.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_16 and arg_36_1.time_ < var_39_8 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play317321009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 317321009
		arg_40_1.duration_ = 9.77

		local var_40_0 = {
			zh = 5.633,
			ja = 9.766
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
				arg_40_0:Play317321010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1093ui_story = arg_40_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1093ui_story"].transform.position).z)
				arg_40_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1093ui_story"].transform.localEulerAngles = arg_40_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1093ui_story"].transform.position).z)
				arg_40_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1093ui_story"].transform.localEulerAngles = arg_40_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_43_1 = arg_40_1.actors_["1093ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect1093ui_story == nil then
				arg_40_1.var_.characterEffect1093ui_story = var_43_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 and not isNil(var_43_1) then
				if arg_40_1.var_.characterEffect1093ui_story and not isNil(var_43_1) then
					arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_2)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect1093ui_story then
				arg_40_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_43_3 = 0
			local var_43_4 = 0.35

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_5 = arg_40_1:GetWordFromCfg(317321009)
				local var_43_6 = arg_40_1:FormatText(var_43_5.content)

				arg_40_1.text_.text = var_43_6

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_8 = 14 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_6) / 14)

				if (14 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_6) / 14)) > 0 and var_43_4 < var_43_8 then
					arg_40_1.talkMaxDuration = var_43_8

					if var_43_8 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_3
					end
				end

				arg_40_1.text_.text = var_43_6
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321009", "story_v_out_317321.awb") ~= 0 then
					local var_43_9 = manager.audio:GetVoiceLength("story_v_out_317321", "317321009", "story_v_out_317321.awb") / 1000

					if var_43_9 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_3
					end

					if var_43_5.prefab_name ~= "" and arg_40_1.actors_[var_43_5.prefab_name] ~= nil then
						local var_43_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_5.prefab_name].transform, "story_v_out_317321", "317321009", "story_v_out_317321.awb")

						arg_40_1:RecordAudio("317321009", var_43_10)
						arg_40_1:RecordAudio("317321009", var_43_10)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_317321", "317321009", "story_v_out_317321.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_317321", "317321009", "story_v_out_317321.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = math.max(var_43_4, arg_40_1.talkMaxDuration)

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_11 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_3) / var_43_11

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_3 + var_43_11 and arg_40_1.time_ < var_43_3 + var_43_11 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play317321010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 317321010
		arg_44_1.duration_ = 9

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play317321011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.bgs_.YA0207 == nil then
				local var_47_0 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "YA0207")
				var_47_0.name = "YA0207"
				var_47_0.transform.parent = arg_44_1.stage_.transform
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_.YA0207 = var_47_0
			end

			if 2 < arg_44_1.time_ and arg_44_1.time_ <= 2 + arg_47_0 then
				local var_47_1 = arg_44_1.bgs_.YA0207

				arg_44_1.bgs_.YA0207.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_2 = var_47_1:GetComponent("SpriteRenderer")

				if var_47_2 and var_47_2.sprite then
					local var_47_3 = 2 * (var_47_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_1.transform.localScale = Vector3.New(var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "YA0207" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_4 = 0

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_5 = 2

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_5 then
				local var_47_6 = Color.New(0, 0, 0)

				var_47_6.a = Mathf.Lerp(0, 1, (arg_44_1.time_ - var_47_4) / var_47_5)
				arg_44_1.mask_.color = var_47_6
			end

			if arg_44_1.time_ >= var_47_4 + var_47_5 and arg_44_1.time_ < var_47_4 + var_47_5 + arg_47_0 then
				local var_47_7 = Color.New(0, 0, 0)

				var_47_7.a = 1
				arg_44_1.mask_.color = var_47_7
			end

			local var_47_8 = 2

			if 2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_9 = 2

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_9 then
				local var_47_10 = Color.New(0, 0, 0)

				var_47_10.a = Mathf.Lerp(1, 0, (arg_44_1.time_ - var_47_8) / var_47_9)
				arg_44_1.mask_.color = var_47_10
			end

			if arg_44_1.time_ >= var_47_8 + var_47_9 and arg_44_1.time_ < var_47_8 + var_47_9 + arg_47_0 then
				local var_47_11 = Color.New(0, 0, 0)

				arg_44_1.mask_.enabled = false
				var_47_11.a = 0
				arg_44_1.mask_.color = var_47_11
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_12 = 4
			local var_47_13 = 1.1

			if 4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_14 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_14:setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
					arg_44_1.dialogCg_.alpha = arg_48_0
				end))
				var_47_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(317321010).content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 44 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 44)

				if (44 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 44)) > 0 and var_47_13 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17
					var_47_12 = var_47_12 + 0.3

					if var_47_17 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_18 = var_47_12 + 0.3
			local var_47_19 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 + 0.3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_18 + var_47_19 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_18) / var_47_19

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_18 + var_47_19 and arg_44_1.time_ < var_47_18 + var_47_19 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play317321011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 317321011
		arg_50_1.duration_ = 4.23

		local var_50_0 = {
			zh = 2,
			ja = 4.233
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play317321012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.125

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1093")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:GetWordFromCfg(317321011)
				local var_53_2 = arg_50_1:FormatText(var_53_1.content)

				arg_50_1.text_.text = var_53_2

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_4 = 5 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 5)

				if (5 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_2) / 5)) > 0 and var_53_0 < var_53_4 then
					arg_50_1.talkMaxDuration = var_53_4

					if var_53_4 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_4 + 0
					end
				end

				arg_50_1.text_.text = var_53_2
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321011", "story_v_out_317321.awb") ~= 0 then
					local var_53_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321011", "story_v_out_317321.awb") / 1000

					if var_53_5 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_5 + 0
					end

					if var_53_1.prefab_name ~= "" and arg_50_1.actors_[var_53_1.prefab_name] ~= nil then
						local var_53_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_1.prefab_name].transform, "story_v_out_317321", "317321011", "story_v_out_317321.awb")

						arg_50_1:RecordAudio("317321011", var_53_6)
						arg_50_1:RecordAudio("317321011", var_53_6)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_317321", "317321011", "story_v_out_317321.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_317321", "317321011", "story_v_out_317321.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_7 and arg_50_1.time_ < 0 + var_53_7 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play317321012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 317321012
		arg_54_1.duration_ = 8.53

		local var_54_0 = {
			zh = 4.9,
			ja = 8.533
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
				arg_54_0:Play317321013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.525

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1058")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:GetWordFromCfg(317321012)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 21 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 21)

				if (21 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 21)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321012", "story_v_out_317321.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321012", "story_v_out_317321.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_317321", "317321012", "story_v_out_317321.awb")

						arg_54_1:RecordAudio("317321012", var_57_6)
						arg_54_1:RecordAudio("317321012", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_317321", "317321012", "story_v_out_317321.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_317321", "317321012", "story_v_out_317321.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play317321013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 317321013
		arg_58_1.duration_ = 15.2

		local var_58_0 = {
			zh = 15.2,
			ja = 10.1
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play317321014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 1.2

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(317321013)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 48 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 48)

				if (48 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 48)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321013", "story_v_out_317321.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321013", "story_v_out_317321.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_317321", "317321013", "story_v_out_317321.awb")

						arg_58_1:RecordAudio("317321013", var_61_6)
						arg_58_1:RecordAudio("317321013", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_317321", "317321013", "story_v_out_317321.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_317321", "317321013", "story_v_out_317321.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play317321014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 317321014
		arg_62_1.duration_ = 7.77

		local var_62_0 = {
			zh = 5.1,
			ja = 7.766
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
				arg_62_0:Play317321015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.375

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(317321014)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 15 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 15)

				if (15 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 15)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321014", "story_v_out_317321.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321014", "story_v_out_317321.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_317321", "317321014", "story_v_out_317321.awb")

						arg_62_1:RecordAudio("317321014", var_65_6)
						arg_62_1:RecordAudio("317321014", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_317321", "317321014", "story_v_out_317321.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_317321", "317321014", "story_v_out_317321.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play317321015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 317321015
		arg_66_1.duration_ = 2.6

		local var_66_0 = {
			zh = 0.999999999999,
			ja = 2.6
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play317321016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.075

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(317321015)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 3 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 3)

				if (3 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 3)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321015", "story_v_out_317321.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321015", "story_v_out_317321.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_317321", "317321015", "story_v_out_317321.awb")

						arg_66_1:RecordAudio("317321015", var_69_6)
						arg_66_1:RecordAudio("317321015", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_317321", "317321015", "story_v_out_317321.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_317321", "317321015", "story_v_out_317321.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play317321016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 317321016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play317321017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.875

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(317321016).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 35 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 35)

				if (35 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 35)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play317321017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 317321017
		arg_74_1.duration_ = 7.63

		local var_74_0 = {
			zh = 3.9,
			ja = 7.633
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play317321018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.5

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:GetWordFromCfg(317321017)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 20 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 20)

				if (20 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 20)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321017", "story_v_out_317321.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321017", "story_v_out_317321.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_317321", "317321017", "story_v_out_317321.awb")

						arg_74_1:RecordAudio("317321017", var_77_6)
						arg_74_1:RecordAudio("317321017", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_317321", "317321017", "story_v_out_317321.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_317321", "317321017", "story_v_out_317321.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play317321018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 317321018
		arg_78_1.duration_ = 11

		local var_78_0 = {
			zh = 7.833,
			ja = 11
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
				arg_78_0:Play317321019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.65

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(317321018)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 26 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 26)

				if (26 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 26)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321018", "story_v_out_317321.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321018", "story_v_out_317321.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_317321", "317321018", "story_v_out_317321.awb")

						arg_78_1:RecordAudio("317321018", var_81_6)
						arg_78_1:RecordAudio("317321018", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_317321", "317321018", "story_v_out_317321.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_317321", "317321018", "story_v_out_317321.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play317321019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 317321019
		arg_82_1.duration_ = 7.33

		local var_82_0 = {
			zh = 7.333,
			ja = 6.833
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
				arg_82_0:Play317321020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.825

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(317321019)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 33 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 33)

				if (33 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 33)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321019", "story_v_out_317321.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321019", "story_v_out_317321.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_317321", "317321019", "story_v_out_317321.awb")

						arg_82_1:RecordAudio("317321019", var_85_6)
						arg_82_1:RecordAudio("317321019", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_317321", "317321019", "story_v_out_317321.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_317321", "317321019", "story_v_out_317321.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play317321020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 317321020
		arg_86_1.duration_ = 9.07

		local var_86_0 = {
			zh = 6.466,
			ja = 9.066
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
				arg_86_0:Play317321021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.725

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
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

				local var_89_1 = arg_86_1:GetWordFromCfg(317321020)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 29 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 29)

				if (29 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 29)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321020", "story_v_out_317321.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321020", "story_v_out_317321.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_317321", "317321020", "story_v_out_317321.awb")

						arg_86_1:RecordAudio("317321020", var_89_6)
						arg_86_1:RecordAudio("317321020", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_317321", "317321020", "story_v_out_317321.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_317321", "317321020", "story_v_out_317321.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play317321021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 317321021
		arg_90_1.duration_ = 2.2

		local var_90_0 = {
			zh = 1.6,
			ja = 2.2
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
				arg_90_0:Play317321022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.1

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:GetWordFromCfg(317321021)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 4 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 4)

				if (4 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 4)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321021", "story_v_out_317321.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321021", "story_v_out_317321.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_317321", "317321021", "story_v_out_317321.awb")

						arg_90_1:RecordAudio("317321021", var_93_6)
						arg_90_1:RecordAudio("317321021", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_317321", "317321021", "story_v_out_317321.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_317321", "317321021", "story_v_out_317321.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play317321022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 317321022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play317321023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 1.175

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

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(317321022).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 47 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 47)

				if (47 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 47)) > 0 and var_97_0 < var_97_3 then
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
	Play317321023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 317321023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play317321024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 1.05

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(317321023).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 42 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 42)

				if (42 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 42)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play317321024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 317321024
		arg_102_1.duration_ = 7.9

		local var_102_0 = {
			zh = 5.133,
			ja = 7.9
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
				arg_102_0:Play317321025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.425

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[570].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4039")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_1 = arg_102_1:GetWordFromCfg(317321024)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 17 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 17)

				if (17 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 17)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321024", "story_v_out_317321.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321024", "story_v_out_317321.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_317321", "317321024", "story_v_out_317321.awb")

						arg_102_1:RecordAudio("317321024", var_105_6)
						arg_102_1:RecordAudio("317321024", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_317321", "317321024", "story_v_out_317321.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_317321", "317321024", "story_v_out_317321.awb")
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
	Play317321025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 317321025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play317321026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:AudioAction("play", "effect", "se_story_127", "se_story_127_lens", "")
			end

			local var_109_1 = 0
			local var_109_2 = 0.65

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(317321025).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 26 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 26)

				if (26 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 26)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play317321026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 317321026
		arg_110_1.duration_ = 9

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play317321027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 2 < arg_110_1.time_ and arg_110_1.time_ <= 2 + arg_113_0 then
				local var_113_0 = arg_110_1.bgs_.K11g

				arg_110_1.bgs_.K11g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_1 = var_113_0:GetComponent("SpriteRenderer")

				if var_113_1 and var_113_1.sprite then
					local var_113_2 = 2 * (var_113_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_0.transform.localScale = Vector3.New(var_113_2 / var_113_1.sprite.bounds.size.y < var_113_2 * manager.ui.mainCameraCom_.aspect / var_113_1.sprite.bounds.size.x and var_113_2 * manager.ui.mainCameraCom_.aspect / var_113_1.sprite.bounds.size.x or var_113_2 / var_113_1.sprite.bounds.size.y, var_113_2 / var_113_1.sprite.bounds.size.y < var_113_2 * manager.ui.mainCameraCom_.aspect / var_113_1.sprite.bounds.size.x and var_113_2 * manager.ui.mainCameraCom_.aspect / var_113_1.sprite.bounds.size.x or var_113_2 / var_113_1.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "K11g" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_3 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_3 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_4 = 2

			if var_113_3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_3 + var_113_4 then
				local var_113_5 = Color.New(0, 0, 0)

				var_113_5.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_3) / var_113_4)
				arg_110_1.mask_.color = var_113_5
			end

			if arg_110_1.time_ >= var_113_3 + var_113_4 and arg_110_1.time_ < var_113_3 + var_113_4 + arg_113_0 then
				local var_113_6 = Color.New(0, 0, 0)

				var_113_6.a = 1
				arg_110_1.mask_.color = var_113_6
			end

			local var_113_7 = 2

			if 2 < arg_110_1.time_ and arg_110_1.time_ <= var_113_7 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_8 = 2

			if var_113_7 <= arg_110_1.time_ and arg_110_1.time_ < var_113_7 + var_113_8 then
				local var_113_9 = Color.New(0, 0, 0)

				var_113_9.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_7) / var_113_8)
				arg_110_1.mask_.color = var_113_9
			end

			if arg_110_1.time_ >= var_113_7 + var_113_8 and arg_110_1.time_ < var_113_7 + var_113_8 + arg_113_0 then
				local var_113_10 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_10.a = 0
				arg_110_1.mask_.color = var_113_10
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_11 = 4
			local var_113_12 = 1.15

			if 4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_13 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_13:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_110_1.dialogCg_.alpha = arg_114_0
				end))
				var_113_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_14 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(317321026).content)

				arg_110_1.text_.text = var_113_14

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_16 = 46 <= 0 and var_113_12 or var_113_12 * (utf8.len(var_113_14) / 46)

				if (46 <= 0 and var_113_12 or var_113_12 * (utf8.len(var_113_14) / 46)) > 0 and var_113_12 < var_113_16 then
					arg_110_1.talkMaxDuration = var_113_16
					var_113_11 = var_113_11 + 0.3

					if var_113_16 + var_113_11 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_16 + var_113_11
					end
				end

				arg_110_1.text_.text = var_113_14
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_17 = var_113_11 + 0.3
			local var_113_18 = math.max(var_113_12, arg_110_1.talkMaxDuration)

			if var_113_11 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_17 + var_113_18 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_17) / var_113_18

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_17 + var_113_18 and arg_110_1.time_ < var_113_17 + var_113_18 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play317321027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 317321027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play317321028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.75

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(317321027).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 30 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 30)

				if (30 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 30)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play317321028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 317321028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play317321029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.325

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(317321028).content)

				arg_120_1.text_.text = var_123_1

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_3 = 13 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 13)

				if (13 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_1) / 13)) > 0 and var_123_0 < var_123_3 then
					arg_120_1.talkMaxDuration = var_123_3

					if var_123_3 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_3 + 0
					end
				end

				arg_120_1.text_.text = var_123_1
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_4 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_4

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play317321029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 317321029
		arg_124_1.duration_ = 8.9

		local var_124_0 = {
			zh = 5.433,
			ja = 8.9
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
				arg_124_0:Play317321030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if arg_124_1.actors_["10053ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10053ui_story"))) then
				local var_127_0 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_124_1.stage_.transform)

				var_127_0.name = "10053ui_story"
				var_127_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.actors_["10053ui_story"] = var_127_0

				local var_127_1 = var_127_0:GetComponentInChildren(typeof(CharacterEffect))

				var_127_1.enabled = true

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end

				arg_124_1:ShowWeapon(var_127_1.transform, false)

				arg_124_1.var_["10053ui_story" .. "Animator"] = var_127_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_124_1.var_["10053ui_story" .. "Animator"].applyRootMotion = true
				arg_124_1.var_["10053ui_story" .. "LipSync"] = var_127_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_127_3 = arg_124_1.actors_["10053ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos10053ui_story = var_127_3.localPosition
			end

			local var_127_4 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				var_127_3.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_124_1.time_ - 0) / var_127_4)
				var_127_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_3.position).x, (manager.ui.mainCamera.transform.position - var_127_3.position).y, (manager.ui.mainCamera.transform.position - var_127_3.position).z)
				var_127_3.localEulerAngles.z = 0
				var_127_3.localEulerAngles.x = 0
				var_127_3.localEulerAngles = var_127_3.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				var_127_3.localPosition = Vector3.New(0, -1.12, -5.99)
				var_127_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_3.position).x, (manager.ui.mainCamera.transform.position - var_127_3.position).y, (manager.ui.mainCamera.transform.position - var_127_3.position).z)
				var_127_3.localEulerAngles.z = 0
				var_127_3.localEulerAngles.x = 0
				var_127_3.localEulerAngles = var_127_3.localEulerAngles
			end

			local var_127_5 = arg_124_1.actors_["10053ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_5) and arg_124_1.var_.characterEffect10053ui_story == nil then
				arg_124_1.var_.characterEffect10053ui_story = var_127_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_6 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_6 and not isNil(var_127_5) then
				if arg_124_1.var_.characterEffect10053ui_story and not isNil(var_127_5) then
					arg_124_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_6 and arg_124_1.time_ < 0 + var_127_6 + arg_127_0 and not isNil(var_127_5) and arg_124_1.var_.characterEffect10053ui_story then
				arg_124_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_127_8 = 0
			local var_127_9 = 0.375

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:GetWordFromCfg(317321029)
				local var_127_11 = arg_124_1:FormatText(var_127_10.content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 15 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 15)

				if (15 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 15)) > 0 and var_127_9 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321029", "story_v_out_317321.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321029", "story_v_out_317321.awb") / 1000

					if var_127_14 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_8
					end

					if var_127_10.prefab_name ~= "" and arg_124_1.actors_[var_127_10.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_10.prefab_name].transform, "story_v_out_317321", "317321029", "story_v_out_317321.awb")

						arg_124_1:RecordAudio("317321029", var_127_15)
						arg_124_1:RecordAudio("317321029", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_317321", "317321029", "story_v_out_317321.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_317321", "317321029", "story_v_out_317321.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_16 and arg_124_1.time_ < var_127_8 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play317321030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 317321030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play317321031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos10053ui_story = arg_128_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10053ui_story"].transform.position).z)
				arg_128_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10053ui_story"].transform.localEulerAngles = arg_128_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["10053ui_story"].transform.position).z)
				arg_128_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["10053ui_story"].transform.localEulerAngles = arg_128_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["10053ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect10053ui_story == nil then
				arg_128_1.var_.characterEffect10053ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect10053ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_2)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect10053ui_story then
				arg_128_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_131_3 = 0
			local var_131_4 = 1.075

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_3 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_5 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(317321030).content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 43 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_5) / 43)

				if (43 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_5) / 43)) > 0 and var_131_4 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_3 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_3
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_4, arg_128_1.talkMaxDuration)

			if var_131_3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_3 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_3) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_3 + var_131_8 and arg_128_1.time_ < var_131_3 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play317321031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 317321031
		arg_132_1.duration_ = 7.93

		local var_132_0 = {
			zh = 5.466,
			ja = 7.933
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
				arg_132_0:Play317321032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if arg_132_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_135_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_132_1.stage_.transform)

				var_135_0.name = "1015ui_story"
				var_135_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["1015ui_story"] = var_135_0

				local var_135_1 = var_135_0:GetComponentInChildren(typeof(CharacterEffect))

				var_135_1.enabled = true

				local var_135_2 = GameObjectTools.GetOrAddComponent(var_135_0, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(false)
				end

				arg_132_1:ShowWeapon(var_135_1.transform, false)

				arg_132_1.var_["1015ui_story" .. "Animator"] = var_135_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_132_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_132_1.var_["1015ui_story" .. "LipSync"] = var_135_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_135_3 = arg_132_1.actors_["1015ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1015ui_story = var_135_3.localPosition
			end

			local var_135_4 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				var_135_3.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_132_1.time_ - 0) / var_135_4)
				var_135_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_3.position).x, (manager.ui.mainCamera.transform.position - var_135_3.position).y, (manager.ui.mainCamera.transform.position - var_135_3.position).z)
				var_135_3.localEulerAngles.z = 0
				var_135_3.localEulerAngles.x = 0
				var_135_3.localEulerAngles = var_135_3.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				var_135_3.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				var_135_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_3.position).x, (manager.ui.mainCamera.transform.position - var_135_3.position).y, (manager.ui.mainCamera.transform.position - var_135_3.position).z)
				var_135_3.localEulerAngles.z = 0
				var_135_3.localEulerAngles.x = 0
				var_135_3.localEulerAngles = var_135_3.localEulerAngles
			end

			local var_135_5 = arg_132_1.actors_["1015ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_5) and arg_132_1.var_.characterEffect1015ui_story == nil then
				arg_132_1.var_.characterEffect1015ui_story = var_135_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_6 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_6 and not isNil(var_135_5) then
				if arg_132_1.var_.characterEffect1015ui_story and not isNil(var_135_5) then
					arg_132_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_6 and arg_132_1.time_ < 0 + var_135_6 + arg_135_0 and not isNil(var_135_5) and arg_132_1.var_.characterEffect1015ui_story then
				arg_132_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_135_8 = arg_132_1.actors_["10053ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10053ui_story = var_135_8.localPosition
			end

			local var_135_9 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_9 then
				var_135_8.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_132_1.time_ - 0) / var_135_9)
				var_135_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_8.position).x, (manager.ui.mainCamera.transform.position - var_135_8.position).y, (manager.ui.mainCamera.transform.position - var_135_8.position).z)
				var_135_8.localEulerAngles.z = 0
				var_135_8.localEulerAngles.x = 0
				var_135_8.localEulerAngles = var_135_8.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_9 and arg_132_1.time_ < 0 + var_135_9 + arg_135_0 then
				var_135_8.localPosition = Vector3.New(0.7, -1.12, -5.99)
				var_135_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_8.position).x, (manager.ui.mainCamera.transform.position - var_135_8.position).y, (manager.ui.mainCamera.transform.position - var_135_8.position).z)
				var_135_8.localEulerAngles.z = 0
				var_135_8.localEulerAngles.x = 0
				var_135_8.localEulerAngles = var_135_8.localEulerAngles
			end

			local var_135_10 = arg_132_1.actors_["10053ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_10) and arg_132_1.var_.characterEffect10053ui_story == nil then
				arg_132_1.var_.characterEffect10053ui_story = var_135_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_11 and not isNil(var_135_10) then
				if arg_132_1.var_.characterEffect10053ui_story and not isNil(var_135_10) then
					arg_132_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_132_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_11)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_11 and arg_132_1.time_ < 0 + var_135_11 + arg_135_0 and not isNil(var_135_10) and arg_132_1.var_.characterEffect10053ui_story then
				arg_132_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_132_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_135_12 = 0
			local var_135_13 = 0.575

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_12 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_14 = arg_132_1:GetWordFromCfg(317321031)
				local var_135_15 = arg_132_1:FormatText(var_135_14.content)

				arg_132_1.text_.text = var_135_15

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_17 = 23 <= 0 and var_135_13 or var_135_13 * (utf8.len(var_135_15) / 23)

				if (23 <= 0 and var_135_13 or var_135_13 * (utf8.len(var_135_15) / 23)) > 0 and var_135_13 < var_135_17 then
					arg_132_1.talkMaxDuration = var_135_17

					if var_135_17 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_17 + var_135_12
					end
				end

				arg_132_1.text_.text = var_135_15
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321031", "story_v_out_317321.awb") ~= 0 then
					local var_135_18 = manager.audio:GetVoiceLength("story_v_out_317321", "317321031", "story_v_out_317321.awb") / 1000

					if var_135_18 + var_135_12 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_18 + var_135_12
					end

					if var_135_14.prefab_name ~= "" and arg_132_1.actors_[var_135_14.prefab_name] ~= nil then
						local var_135_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_14.prefab_name].transform, "story_v_out_317321", "317321031", "story_v_out_317321.awb")

						arg_132_1:RecordAudio("317321031", var_135_19)
						arg_132_1:RecordAudio("317321031", var_135_19)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_317321", "317321031", "story_v_out_317321.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_317321", "317321031", "story_v_out_317321.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_20 = math.max(var_135_13, arg_132_1.talkMaxDuration)

			if var_135_12 <= arg_132_1.time_ and arg_132_1.time_ < var_135_12 + var_135_20 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_12) / var_135_20

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_12 + var_135_20 and arg_132_1.time_ < var_135_12 + var_135_20 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play317321032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 317321032
		arg_136_1.duration_ = 10.67

		local var_136_0 = {
			zh = 8,
			ja = 10.666
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
				arg_136_0:Play317321033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos10053ui_story = arg_136_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10053ui_story"].transform.position).z)
				arg_136_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10053ui_story"].transform.localEulerAngles = arg_136_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_136_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["10053ui_story"].transform.position).z)
				arg_136_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["10053ui_story"].transform.localEulerAngles = arg_136_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["10053ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect10053ui_story == nil then
				arg_136_1.var_.characterEffect10053ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect10053ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect10053ui_story then
				arg_136_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_139_4 = arg_136_1.actors_["1015ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1015ui_story == nil then
				arg_136_1.var_.characterEffect1015ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_5 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 and not isNil(var_139_4) then
				if arg_136_1.var_.characterEffect1015ui_story and not isNil(var_139_4) then
					arg_136_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_5)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect1015ui_story then
				arg_136_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_139_6 = 0
			local var_139_7 = 0.85

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:GetWordFromCfg(317321032)
				local var_139_9 = arg_136_1:FormatText(var_139_8.content)

				arg_136_1.text_.text = var_139_9

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 34 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 34)

				if (34 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_9) / 34)) > 0 and var_139_7 < var_139_11 then
					arg_136_1.talkMaxDuration = var_139_11

					if var_139_11 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_9
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321032", "story_v_out_317321.awb") ~= 0 then
					local var_139_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321032", "story_v_out_317321.awb") / 1000

					if var_139_12 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_12 + var_139_6
					end

					if var_139_8.prefab_name ~= "" and arg_136_1.actors_[var_139_8.prefab_name] ~= nil then
						local var_139_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_8.prefab_name].transform, "story_v_out_317321", "317321032", "story_v_out_317321.awb")

						arg_136_1:RecordAudio("317321032", var_139_13)
						arg_136_1:RecordAudio("317321032", var_139_13)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_317321", "317321032", "story_v_out_317321.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_317321", "317321032", "story_v_out_317321.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play317321033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 317321033
		arg_140_1.duration_ = 11.63

		local var_140_0 = {
			zh = 6.733,
			ja = 11.633
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
				arg_140_0:Play317321034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.7

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:GetWordFromCfg(317321033)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 28 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 28)

				if (28 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 28)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321033", "story_v_out_317321.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321033", "story_v_out_317321.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_317321", "317321033", "story_v_out_317321.awb")

						arg_140_1:RecordAudio("317321033", var_143_6)
						arg_140_1:RecordAudio("317321033", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_317321", "317321033", "story_v_out_317321.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_317321", "317321033", "story_v_out_317321.awb")
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
	Play317321034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 317321034
		arg_144_1.duration_ = 16.5

		local var_144_0 = {
			zh = 16.5,
			ja = 11.233
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
				arg_144_0:Play317321035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["10053ui_story"]) and arg_144_1.var_.characterEffect10053ui_story == nil then
				arg_144_1.var_.characterEffect10053ui_story = arg_144_1.actors_["10053ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["10053ui_story"]) then
				if arg_144_1.var_.characterEffect10053ui_story and not isNil(arg_144_1.actors_["10053ui_story"]) then
					arg_144_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["10053ui_story"]) and arg_144_1.var_.characterEffect10053ui_story then
				arg_144_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_147_2 = 0
			local var_147_3 = 1.375

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_4 = arg_144_1:GetWordFromCfg(317321034)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 55 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 55)

				if (55 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 55)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321034", "story_v_out_317321.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321034", "story_v_out_317321.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_317321", "317321034", "story_v_out_317321.awb")

						arg_144_1:RecordAudio("317321034", var_147_9)
						arg_144_1:RecordAudio("317321034", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_317321", "317321034", "story_v_out_317321.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_317321", "317321034", "story_v_out_317321.awb")
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
	Play317321035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 317321035
		arg_148_1.duration_ = 6.47

		local var_148_0 = {
			zh = 6.466,
			ja = 4.666
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
				arg_148_0:Play317321036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1015ui_story = arg_148_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1015ui_story"].transform.position).z)
				arg_148_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1015ui_story"].transform.localEulerAngles = arg_148_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_148_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1015ui_story"].transform.position).z)
				arg_148_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1015ui_story"].transform.localEulerAngles = arg_148_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["1015ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1015ui_story == nil then
				arg_148_1.var_.characterEffect1015ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect1015ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1015ui_story then
				arg_148_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_151_4 = arg_148_1.actors_["10053ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect10053ui_story == nil then
				arg_148_1.var_.characterEffect10053ui_story = var_151_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_5 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_5 and not isNil(var_151_4) then
				if arg_148_1.var_.characterEffect10053ui_story and not isNil(var_151_4) then
					arg_148_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_5)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_5 and arg_148_1.time_ < 0 + var_151_5 + arg_151_0 and not isNil(var_151_4) and arg_148_1.var_.characterEffect10053ui_story then
				arg_148_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_151_6 = 0
			local var_151_7 = 0.725

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_8 = arg_148_1:GetWordFromCfg(317321035)
				local var_151_9 = arg_148_1:FormatText(var_151_8.content)

				arg_148_1.text_.text = var_151_9

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 29 <= 0 and var_151_7 or var_151_7 * (utf8.len(var_151_9) / 29)

				if (29 <= 0 and var_151_7 or var_151_7 * (utf8.len(var_151_9) / 29)) > 0 and var_151_7 < var_151_11 then
					arg_148_1.talkMaxDuration = var_151_11

					if var_151_11 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_9
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321035", "story_v_out_317321.awb") ~= 0 then
					local var_151_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321035", "story_v_out_317321.awb") / 1000

					if var_151_12 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_12 + var_151_6
					end

					if var_151_8.prefab_name ~= "" and arg_148_1.actors_[var_151_8.prefab_name] ~= nil then
						local var_151_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_8.prefab_name].transform, "story_v_out_317321", "317321035", "story_v_out_317321.awb")

						arg_148_1:RecordAudio("317321035", var_151_13)
						arg_148_1:RecordAudio("317321035", var_151_13)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_317321", "317321035", "story_v_out_317321.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_317321", "317321035", "story_v_out_317321.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_14 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_14 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_14

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_14 and arg_148_1.time_ < var_151_6 + var_151_14 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play317321036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 317321036
		arg_152_1.duration_ = 5.57

		local var_152_0 = {
			zh = 2.5,
			ja = 5.566
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
				arg_152_0:Play317321037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos10053ui_story = arg_152_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10053ui_story"].transform.position).z)
				arg_152_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["10053ui_story"].transform.localEulerAngles = arg_152_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_152_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["10053ui_story"].transform.position).z)
				arg_152_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["10053ui_story"].transform.localEulerAngles = arg_152_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["10053ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect10053ui_story == nil then
				arg_152_1.var_.characterEffect10053ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect10053ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect10053ui_story then
				arg_152_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_2")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_155_4 = arg_152_1.actors_["1015ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect1015ui_story == nil then
				arg_152_1.var_.characterEffect1015ui_story = var_155_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_5 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_5 and not isNil(var_155_4) then
				if arg_152_1.var_.characterEffect1015ui_story and not isNil(var_155_4) then
					arg_152_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_5)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_5 and arg_152_1.time_ < 0 + var_155_5 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect1015ui_story then
				arg_152_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_155_6 = 0
			local var_155_7 = 0.275

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_8 = arg_152_1:GetWordFromCfg(317321036)
				local var_155_9 = arg_152_1:FormatText(var_155_8.content)

				arg_152_1.text_.text = var_155_9

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 11 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_9) / 11)

				if (11 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_9) / 11)) > 0 and var_155_7 < var_155_11 then
					arg_152_1.talkMaxDuration = var_155_11

					if var_155_11 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_9
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321036", "story_v_out_317321.awb") ~= 0 then
					local var_155_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321036", "story_v_out_317321.awb") / 1000

					if var_155_12 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_12 + var_155_6
					end

					if var_155_8.prefab_name ~= "" and arg_152_1.actors_[var_155_8.prefab_name] ~= nil then
						local var_155_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_8.prefab_name].transform, "story_v_out_317321", "317321036", "story_v_out_317321.awb")

						arg_152_1:RecordAudio("317321036", var_155_13)
						arg_152_1:RecordAudio("317321036", var_155_13)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_317321", "317321036", "story_v_out_317321.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_317321", "317321036", "story_v_out_317321.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play317321037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 317321037
		arg_156_1.duration_ = 6.3

		local var_156_0 = {
			zh = 5.3,
			ja = 6.3
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
				arg_156_0:Play317321038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1015ui_story = arg_156_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1015ui_story"].transform.position).z)
				arg_156_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1015ui_story"].transform.localEulerAngles = arg_156_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_156_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1015ui_story"].transform.position).z)
				arg_156_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1015ui_story"].transform.localEulerAngles = arg_156_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1015ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1015ui_story == nil then
				arg_156_1.var_.characterEffect1015ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1015ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1015ui_story then
				arg_156_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_159_4 = arg_156_1.actors_["10053ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect10053ui_story == nil then
				arg_156_1.var_.characterEffect10053ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_5 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_5 and not isNil(var_159_4) then
				if arg_156_1.var_.characterEffect10053ui_story and not isNil(var_159_4) then
					arg_156_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_5)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_5 and arg_156_1.time_ < 0 + var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect10053ui_story then
				arg_156_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_159_6 = 0
			local var_159_7 = 0.6

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(317321037)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 24 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 24)

				if (24 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 24)) > 0 and var_159_7 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321037", "story_v_out_317321.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321037", "story_v_out_317321.awb") / 1000

					if var_159_12 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_6
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_317321", "317321037", "story_v_out_317321.awb")

						arg_156_1:RecordAudio("317321037", var_159_13)
						arg_156_1:RecordAudio("317321037", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_317321", "317321037", "story_v_out_317321.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_317321", "317321037", "story_v_out_317321.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play317321038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 317321038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play317321039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1015ui_story"]) and arg_160_1.var_.characterEffect1015ui_story == nil then
				arg_160_1.var_.characterEffect1015ui_story = arg_160_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1015ui_story"]) then
				if arg_160_1.var_.characterEffect1015ui_story and not isNil(arg_160_1.actors_["1015ui_story"]) then
					arg_160_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1015ui_story"]) and arg_160_1.var_.characterEffect1015ui_story then
				arg_160_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_163_1 = 0
			local var_163_2 = 0.675

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_3 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(317321038).content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 27 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 27)

				if (27 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 27)) > 0 and var_163_2 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_6 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_6 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_6

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_6 and arg_160_1.time_ < var_163_1 + var_163_6 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play317321039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 317321039
		arg_164_1.duration_ = 19.7

		local var_164_0 = {
			zh = 19.7,
			ja = 17.233
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play317321040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos10053ui_story = arg_164_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_167_0 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 then
				arg_164_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_164_1.time_ - 0) / var_167_0)
				arg_164_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["10053ui_story"].transform.position).z)
				arg_164_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["10053ui_story"].transform.localEulerAngles = arg_164_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 then
				arg_164_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_164_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["10053ui_story"].transform.position).z)
				arg_164_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["10053ui_story"].transform.localEulerAngles = arg_164_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_167_1 = arg_164_1.actors_["10053ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect10053ui_story == nil then
				arg_164_1.var_.characterEffect10053ui_story = var_167_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_2 and not isNil(var_167_1) then
				if arg_164_1.var_.characterEffect10053ui_story and not isNil(var_167_1) then
					arg_164_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_2 and arg_164_1.time_ < 0 + var_167_2 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect10053ui_story then
				arg_164_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_167_4 = 0
			local var_167_5 = 1.35

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_6 = arg_164_1:GetWordFromCfg(317321039)
				local var_167_7 = arg_164_1:FormatText(var_167_6.content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 54 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 54)

				if (54 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 54)) > 0 and var_167_5 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_4
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321039", "story_v_out_317321.awb") ~= 0 then
					local var_167_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321039", "story_v_out_317321.awb") / 1000

					if var_167_10 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_4
					end

					if var_167_6.prefab_name ~= "" and arg_164_1.actors_[var_167_6.prefab_name] ~= nil then
						local var_167_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_6.prefab_name].transform, "story_v_out_317321", "317321039", "story_v_out_317321.awb")

						arg_164_1:RecordAudio("317321039", var_167_11)
						arg_164_1:RecordAudio("317321039", var_167_11)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_317321", "317321039", "story_v_out_317321.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_317321", "317321039", "story_v_out_317321.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_12 = math.max(var_167_5, arg_164_1.talkMaxDuration)

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_12 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_4) / var_167_12

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_4 + var_167_12 and arg_164_1.time_ < var_167_4 + var_167_12 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play317321040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 317321040
		arg_168_1.duration_ = 2

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play317321041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1015ui_story = arg_168_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1015ui_story"].transform.position).z)
				arg_168_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1015ui_story"].transform.localEulerAngles = arg_168_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_168_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1015ui_story"].transform.position).z)
				arg_168_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1015ui_story"].transform.localEulerAngles = arg_168_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_171_1 = arg_168_1.actors_["1015ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1015ui_story == nil then
				arg_168_1.var_.characterEffect1015ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect1015ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1015ui_story then
				arg_168_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_171_4 = arg_168_1.actors_["10053ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_4) and arg_168_1.var_.characterEffect10053ui_story == nil then
				arg_168_1.var_.characterEffect10053ui_story = var_171_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_5 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_5 and not isNil(var_171_4) then
				if arg_168_1.var_.characterEffect10053ui_story and not isNil(var_171_4) then
					arg_168_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_5)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_5 and arg_168_1.time_ < 0 + var_171_5 + arg_171_0 and not isNil(var_171_4) and arg_168_1.var_.characterEffect10053ui_story then
				arg_168_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_171_6 = 0
			local var_171_7 = 0.1

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(317321040)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 4 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 4)

				if (4 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 4)) > 0 and var_171_7 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321040", "story_v_out_317321.awb") ~= 0 then
					local var_171_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321040", "story_v_out_317321.awb") / 1000

					if var_171_12 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_6
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_out_317321", "317321040", "story_v_out_317321.awb")

						arg_168_1:RecordAudio("317321040", var_171_13)
						arg_168_1:RecordAudio("317321040", var_171_13)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_317321", "317321040", "story_v_out_317321.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_317321", "317321040", "story_v_out_317321.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play317321041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 317321041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play317321042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1015ui_story"]) and arg_172_1.var_.characterEffect1015ui_story == nil then
				arg_172_1.var_.characterEffect1015ui_story = arg_172_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1015ui_story"]) then
				if arg_172_1.var_.characterEffect1015ui_story and not isNil(arg_172_1.actors_["1015ui_story"]) then
					arg_172_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1015ui_story"]) and arg_172_1.var_.characterEffect1015ui_story then
				arg_172_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 0.525

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(317321041).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 21 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 21)

				if (21 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 21)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play317321042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 317321042
		arg_176_1.duration_ = 17

		local var_176_0 = {
			zh = 8.5,
			ja = 17
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play317321043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1015ui_story"]) and arg_176_1.var_.characterEffect1015ui_story == nil then
				arg_176_1.var_.characterEffect1015ui_story = arg_176_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1015ui_story"]) then
				if arg_176_1.var_.characterEffect1015ui_story and not isNil(arg_176_1.actors_["1015ui_story"]) then
					arg_176_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1015ui_story"]) and arg_176_1.var_.characterEffect1015ui_story then
				arg_176_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_179_2 = 0
			local var_179_3 = 0.8

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(317321042)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 32 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 32)

				if (32 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 32)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321042", "story_v_out_317321.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_317321", "317321042", "story_v_out_317321.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_out_317321", "317321042", "story_v_out_317321.awb")

						arg_176_1:RecordAudio("317321042", var_179_9)
						arg_176_1:RecordAudio("317321042", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_317321", "317321042", "story_v_out_317321.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_317321", "317321042", "story_v_out_317321.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play317321043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 317321043
		arg_180_1.duration_ = 9.5

		local var_180_0 = {
			zh = 6.633,
			ja = 9.5
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play317321044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.875

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:GetWordFromCfg(317321043)
				local var_183_2 = arg_180_1:FormatText(var_183_1.content)

				arg_180_1.text_.text = var_183_2

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 35 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 35)

				if (35 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 35)) > 0 and var_183_0 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + 0
					end
				end

				arg_180_1.text_.text = var_183_2
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321043", "story_v_out_317321.awb") ~= 0 then
					local var_183_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321043", "story_v_out_317321.awb") / 1000

					if var_183_5 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + 0
					end

					if var_183_1.prefab_name ~= "" and arg_180_1.actors_[var_183_1.prefab_name] ~= nil then
						local var_183_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_1.prefab_name].transform, "story_v_out_317321", "317321043", "story_v_out_317321.awb")

						arg_180_1:RecordAudio("317321043", var_183_6)
						arg_180_1:RecordAudio("317321043", var_183_6)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_317321", "317321043", "story_v_out_317321.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_317321", "317321043", "story_v_out_317321.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play317321044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 317321044
		arg_184_1.duration_ = 10.37

		local var_184_0 = {
			zh = 7.6,
			ja = 10.366
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play317321045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0.925

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_1 = arg_184_1:GetWordFromCfg(317321044)
				local var_187_2 = arg_184_1:FormatText(var_187_1.content)

				arg_184_1.text_.text = var_187_2

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_4 = 37 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 37)

				if (37 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 37)) > 0 and var_187_0 < var_187_4 then
					arg_184_1.talkMaxDuration = var_187_4

					if var_187_4 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_4 + 0
					end
				end

				arg_184_1.text_.text = var_187_2
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321044", "story_v_out_317321.awb") ~= 0 then
					local var_187_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321044", "story_v_out_317321.awb") / 1000

					if var_187_5 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + 0
					end

					if var_187_1.prefab_name ~= "" and arg_184_1.actors_[var_187_1.prefab_name] ~= nil then
						local var_187_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_1.prefab_name].transform, "story_v_out_317321", "317321044", "story_v_out_317321.awb")

						arg_184_1:RecordAudio("317321044", var_187_6)
						arg_184_1:RecordAudio("317321044", var_187_6)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_317321", "317321044", "story_v_out_317321.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_317321", "317321044", "story_v_out_317321.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play317321045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 317321045
		arg_188_1.duration_ = 10.3

		local var_188_0 = {
			zh = 9.5,
			ja = 10.3
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play317321046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10053ui_story = arg_188_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_191_0 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 then
				arg_188_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_188_1.time_ - 0) / var_191_0)
				arg_188_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["10053ui_story"].transform.position).z)
				arg_188_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["10053ui_story"].transform.localEulerAngles = arg_188_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 then
				arg_188_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_188_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["10053ui_story"].transform.position).z)
				arg_188_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["10053ui_story"].transform.localEulerAngles = arg_188_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_191_1 = arg_188_1.actors_["10053ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_1) and arg_188_1.var_.characterEffect10053ui_story == nil then
				arg_188_1.var_.characterEffect10053ui_story = var_191_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_2 and not isNil(var_191_1) then
				if arg_188_1.var_.characterEffect10053ui_story and not isNil(var_191_1) then
					arg_188_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_2 and arg_188_1.time_ < 0 + var_191_2 + arg_191_0 and not isNil(var_191_1) and arg_188_1.var_.characterEffect10053ui_story then
				arg_188_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action12_1")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_191_4 = arg_188_1.actors_["1015ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1015ui_story == nil then
				arg_188_1.var_.characterEffect1015ui_story = var_191_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_5 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_5 and not isNil(var_191_4) then
				if arg_188_1.var_.characterEffect1015ui_story and not isNil(var_191_4) then
					arg_188_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_5)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_5 and arg_188_1.time_ < 0 + var_191_5 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect1015ui_story then
				arg_188_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_191_6 = 0
			local var_191_7 = 0.675

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_8 = arg_188_1:GetWordFromCfg(317321045)
				local var_191_9 = arg_188_1:FormatText(var_191_8.content)

				arg_188_1.text_.text = var_191_9

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 27 <= 0 and var_191_7 or var_191_7 * (utf8.len(var_191_9) / 27)

				if (27 <= 0 and var_191_7 or var_191_7 * (utf8.len(var_191_9) / 27)) > 0 and var_191_7 < var_191_11 then
					arg_188_1.talkMaxDuration = var_191_11

					if var_191_11 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_11 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_9
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321045", "story_v_out_317321.awb") ~= 0 then
					local var_191_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321045", "story_v_out_317321.awb") / 1000

					if var_191_12 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_6
					end

					if var_191_8.prefab_name ~= "" and arg_188_1.actors_[var_191_8.prefab_name] ~= nil then
						local var_191_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_8.prefab_name].transform, "story_v_out_317321", "317321045", "story_v_out_317321.awb")

						arg_188_1:RecordAudio("317321045", var_191_13)
						arg_188_1:RecordAudio("317321045", var_191_13)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_317321", "317321045", "story_v_out_317321.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_317321", "317321045", "story_v_out_317321.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_14 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_14 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_14

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_14 and arg_188_1.time_ < var_191_6 + var_191_14 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play317321046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 317321046
		arg_192_1.duration_ = 9.93

		local var_192_0 = {
			zh = 8.3,
			ja = 9.933
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play317321047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1015ui_story = arg_192_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_195_0 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 then
				arg_192_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_192_1.time_ - 0) / var_195_0)
				arg_192_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1015ui_story"].transform.position).z)
				arg_192_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1015ui_story"].transform.localEulerAngles = arg_192_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 then
				arg_192_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_192_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1015ui_story"].transform.position).z)
				arg_192_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1015ui_story"].transform.localEulerAngles = arg_192_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_195_1 = arg_192_1.actors_["1015ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_1) and arg_192_1.var_.characterEffect1015ui_story == nil then
				arg_192_1.var_.characterEffect1015ui_story = var_195_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_2 and not isNil(var_195_1) then
				if arg_192_1.var_.characterEffect1015ui_story and not isNil(var_195_1) then
					arg_192_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_2 and arg_192_1.time_ < 0 + var_195_2 + arg_195_0 and not isNil(var_195_1) and arg_192_1.var_.characterEffect1015ui_story then
				arg_192_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_195_4 = arg_192_1.actors_["10053ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect10053ui_story == nil then
				arg_192_1.var_.characterEffect10053ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_5 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_5 and not isNil(var_195_4) then
				if arg_192_1.var_.characterEffect10053ui_story and not isNil(var_195_4) then
					arg_192_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_5)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_5 and arg_192_1.time_ < 0 + var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect10053ui_story then
				arg_192_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_195_6 = 0
			local var_195_7 = 1

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_6 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_8 = arg_192_1:GetWordFromCfg(317321046)
				local var_195_9 = arg_192_1:FormatText(var_195_8.content)

				arg_192_1.text_.text = var_195_9

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_11 = 40 <= 0 and var_195_7 or var_195_7 * (utf8.len(var_195_9) / 40)

				if (40 <= 0 and var_195_7 or var_195_7 * (utf8.len(var_195_9) / 40)) > 0 and var_195_7 < var_195_11 then
					arg_192_1.talkMaxDuration = var_195_11

					if var_195_11 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_11 + var_195_6
					end
				end

				arg_192_1.text_.text = var_195_9
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321046", "story_v_out_317321.awb") ~= 0 then
					local var_195_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321046", "story_v_out_317321.awb") / 1000

					if var_195_12 + var_195_6 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_12 + var_195_6
					end

					if var_195_8.prefab_name ~= "" and arg_192_1.actors_[var_195_8.prefab_name] ~= nil then
						local var_195_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_8.prefab_name].transform, "story_v_out_317321", "317321046", "story_v_out_317321.awb")

						arg_192_1:RecordAudio("317321046", var_195_13)
						arg_192_1:RecordAudio("317321046", var_195_13)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_317321", "317321046", "story_v_out_317321.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_317321", "317321046", "story_v_out_317321.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_14 = math.max(var_195_7, arg_192_1.talkMaxDuration)

			if var_195_6 <= arg_192_1.time_ and arg_192_1.time_ < var_195_6 + var_195_14 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_6) / var_195_14

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_6 + var_195_14 and arg_192_1.time_ < var_195_6 + var_195_14 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play317321047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 317321047
		arg_196_1.duration_ = 11.87

		local var_196_0 = {
			zh = 11.866,
			ja = 11.066
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play317321048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos10053ui_story = arg_196_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_199_0 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				arg_196_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10053ui_story"].transform.position).z)
				arg_196_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["10053ui_story"].transform.localEulerAngles = arg_196_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				arg_196_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_196_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["10053ui_story"].transform.position).z)
				arg_196_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["10053ui_story"].transform.localEulerAngles = arg_196_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_199_1 = arg_196_1.actors_["10053ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect10053ui_story == nil then
				arg_196_1.var_.characterEffect10053ui_story = var_199_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_2 and not isNil(var_199_1) then
				if arg_196_1.var_.characterEffect10053ui_story and not isNil(var_199_1) then
					arg_196_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_2 and arg_196_1.time_ < 0 + var_199_2 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect10053ui_story then
				arg_196_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_199_4 = arg_196_1.actors_["1015ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect1015ui_story == nil then
				arg_196_1.var_.characterEffect1015ui_story = var_199_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_5 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_5 and not isNil(var_199_4) then
				if arg_196_1.var_.characterEffect1015ui_story and not isNil(var_199_4) then
					arg_196_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_5)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_5 and arg_196_1.time_ < 0 + var_199_5 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect1015ui_story then
				arg_196_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_199_6 = 0
			local var_199_7 = 1

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_8 = arg_196_1:GetWordFromCfg(317321047)
				local var_199_9 = arg_196_1:FormatText(var_199_8.content)

				arg_196_1.text_.text = var_199_9

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 40 <= 0 and var_199_7 or var_199_7 * (utf8.len(var_199_9) / 40)

				if (40 <= 0 and var_199_7 or var_199_7 * (utf8.len(var_199_9) / 40)) > 0 and var_199_7 < var_199_11 then
					arg_196_1.talkMaxDuration = var_199_11

					if var_199_11 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_9
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321047", "story_v_out_317321.awb") ~= 0 then
					local var_199_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321047", "story_v_out_317321.awb") / 1000

					if var_199_12 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_12 + var_199_6
					end

					if var_199_8.prefab_name ~= "" and arg_196_1.actors_[var_199_8.prefab_name] ~= nil then
						local var_199_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_8.prefab_name].transform, "story_v_out_317321", "317321047", "story_v_out_317321.awb")

						arg_196_1:RecordAudio("317321047", var_199_13)
						arg_196_1:RecordAudio("317321047", var_199_13)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_317321", "317321047", "story_v_out_317321.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_317321", "317321047", "story_v_out_317321.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_14 and arg_196_1.time_ < var_199_6 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play317321048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 317321048
		arg_200_1.duration_ = 3.77

		local var_200_0 = {
			zh = 1.999999999999,
			ja = 3.766
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play317321049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1015ui_story = arg_200_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_203_0 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 then
				arg_200_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_200_1.time_ - 0) / var_203_0)
				arg_200_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1015ui_story"].transform.position).z)
				arg_200_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["1015ui_story"].transform.localEulerAngles = arg_200_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 then
				arg_200_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_200_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1015ui_story"].transform.position).z)
				arg_200_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["1015ui_story"].transform.localEulerAngles = arg_200_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_203_1 = arg_200_1.actors_["1015ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect1015ui_story == nil then
				arg_200_1.var_.characterEffect1015ui_story = var_203_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_2 and not isNil(var_203_1) then
				if arg_200_1.var_.characterEffect1015ui_story and not isNil(var_203_1) then
					arg_200_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_2 and arg_200_1.time_ < 0 + var_203_2 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect1015ui_story then
				arg_200_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_203_4 = arg_200_1.actors_["10053ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect10053ui_story == nil then
				arg_200_1.var_.characterEffect10053ui_story = var_203_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_5 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_5 and not isNil(var_203_4) then
				if arg_200_1.var_.characterEffect10053ui_story and not isNil(var_203_4) then
					arg_200_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_200_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_5)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_5 and arg_200_1.time_ < 0 + var_203_5 + arg_203_0 and not isNil(var_203_4) and arg_200_1.var_.characterEffect10053ui_story then
				arg_200_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_200_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_203_6 = 0
			local var_203_7 = 0.1

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_8 = arg_200_1:GetWordFromCfg(317321048)
				local var_203_9 = arg_200_1:FormatText(var_203_8.content)

				arg_200_1.text_.text = var_203_9

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_11 = 4 <= 0 and var_203_7 or var_203_7 * (utf8.len(var_203_9) / 4)

				if (4 <= 0 and var_203_7 or var_203_7 * (utf8.len(var_203_9) / 4)) > 0 and var_203_7 < var_203_11 then
					arg_200_1.talkMaxDuration = var_203_11

					if var_203_11 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_11 + var_203_6
					end
				end

				arg_200_1.text_.text = var_203_9
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321048", "story_v_out_317321.awb") ~= 0 then
					local var_203_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321048", "story_v_out_317321.awb") / 1000

					if var_203_12 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_12 + var_203_6
					end

					if var_203_8.prefab_name ~= "" and arg_200_1.actors_[var_203_8.prefab_name] ~= nil then
						local var_203_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_8.prefab_name].transform, "story_v_out_317321", "317321048", "story_v_out_317321.awb")

						arg_200_1:RecordAudio("317321048", var_203_13)
						arg_200_1:RecordAudio("317321048", var_203_13)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_317321", "317321048", "story_v_out_317321.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_317321", "317321048", "story_v_out_317321.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_14 = math.max(var_203_7, arg_200_1.talkMaxDuration)

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_14 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_6) / var_203_14

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_6 + var_203_14 and arg_200_1.time_ < var_203_6 + var_203_14 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play317321049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 317321049
		arg_204_1.duration_ = 13.53

		local var_204_0 = {
			zh = 11.633,
			ja = 13.533
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play317321050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10053ui_story = arg_204_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_207_0 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 then
				arg_204_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_204_1.time_ - 0) / var_207_0)
				arg_204_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["10053ui_story"].transform.position).z)
				arg_204_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["10053ui_story"].transform.localEulerAngles = arg_204_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 then
				arg_204_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_204_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_204_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_204_1.actors_["10053ui_story"].transform.position).z)
				arg_204_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_204_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_204_1.actors_["10053ui_story"].transform.localEulerAngles = arg_204_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_207_1 = arg_204_1.actors_["10053ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect10053ui_story == nil then
				arg_204_1.var_.characterEffect10053ui_story = var_207_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_2 and not isNil(var_207_1) then
				if arg_204_1.var_.characterEffect10053ui_story and not isNil(var_207_1) then
					arg_204_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_2 and arg_204_1.time_ < 0 + var_207_2 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.characterEffect10053ui_story then
				arg_204_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action12_2")
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_207_4 = arg_204_1.actors_["1015ui_story"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1015ui_story == nil then
				arg_204_1.var_.characterEffect1015ui_story = var_207_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_5 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_5 and not isNil(var_207_4) then
				if arg_204_1.var_.characterEffect1015ui_story and not isNil(var_207_4) then
					arg_204_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_5)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_5 and arg_204_1.time_ < 0 + var_207_5 + arg_207_0 and not isNil(var_207_4) and arg_204_1.var_.characterEffect1015ui_story then
				arg_204_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_207_6 = 0
			local var_207_7 = 1.125

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_8 = arg_204_1:GetWordFromCfg(317321049)
				local var_207_9 = arg_204_1:FormatText(var_207_8.content)

				arg_204_1.text_.text = var_207_9

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 45 <= 0 and var_207_7 or var_207_7 * (utf8.len(var_207_9) / 45)

				if (45 <= 0 and var_207_7 or var_207_7 * (utf8.len(var_207_9) / 45)) > 0 and var_207_7 < var_207_11 then
					arg_204_1.talkMaxDuration = var_207_11

					if var_207_11 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_11 + var_207_6
					end
				end

				arg_204_1.text_.text = var_207_9
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321049", "story_v_out_317321.awb") ~= 0 then
					local var_207_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321049", "story_v_out_317321.awb") / 1000

					if var_207_12 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_12 + var_207_6
					end

					if var_207_8.prefab_name ~= "" and arg_204_1.actors_[var_207_8.prefab_name] ~= nil then
						local var_207_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_8.prefab_name].transform, "story_v_out_317321", "317321049", "story_v_out_317321.awb")

						arg_204_1:RecordAudio("317321049", var_207_13)
						arg_204_1:RecordAudio("317321049", var_207_13)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_317321", "317321049", "story_v_out_317321.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_317321", "317321049", "story_v_out_317321.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_14 = math.max(var_207_7, arg_204_1.talkMaxDuration)

			if var_207_6 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_14 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_6) / var_207_14

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_6 + var_207_14 and arg_204_1.time_ < var_207_6 + var_207_14 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play317321050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 317321050
		arg_208_1.duration_ = 9.33

		local var_208_0 = {
			zh = 9.333,
			ja = 8.2
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play317321051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.975

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(317321050)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 39 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 39)

				if (39 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 39)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321050", "story_v_out_317321.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321050", "story_v_out_317321.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_317321", "317321050", "story_v_out_317321.awb")

						arg_208_1:RecordAudio("317321050", var_211_6)
						arg_208_1:RecordAudio("317321050", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_317321", "317321050", "story_v_out_317321.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_317321", "317321050", "story_v_out_317321.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play317321051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 317321051
		arg_212_1.duration_ = 8.67

		local var_212_0 = {
			zh = 8.666,
			ja = 8.366
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play317321052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.825

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:GetWordFromCfg(317321051)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 33 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 33)

				if (33 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 33)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321051", "story_v_out_317321.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321051", "story_v_out_317321.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_317321", "317321051", "story_v_out_317321.awb")

						arg_212_1:RecordAudio("317321051", var_215_6)
						arg_212_1:RecordAudio("317321051", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_317321", "317321051", "story_v_out_317321.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_317321", "317321051", "story_v_out_317321.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play317321052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 317321052
		arg_216_1.duration_ = 8.97

		local var_216_0 = {
			zh = 6.766,
			ja = 8.966
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play317321053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1015ui_story = arg_216_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1015ui_story"].transform.position).z)
				arg_216_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1015ui_story"].transform.localEulerAngles = arg_216_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_216_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1015ui_story"].transform.position).z)
				arg_216_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1015ui_story"].transform.localEulerAngles = arg_216_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["1015ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1015ui_story == nil then
				arg_216_1.var_.characterEffect1015ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 and not isNil(var_219_1) then
				if arg_216_1.var_.characterEffect1015ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1015ui_story then
				arg_216_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_219_4 = arg_216_1.actors_["10053ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect10053ui_story == nil then
				arg_216_1.var_.characterEffect10053ui_story = var_219_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_5 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_5 and not isNil(var_219_4) then
				if arg_216_1.var_.characterEffect10053ui_story and not isNil(var_219_4) then
					arg_216_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_5)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_5 and arg_216_1.time_ < 0 + var_219_5 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect10053ui_story then
				arg_216_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_219_6 = 0
			local var_219_7 = 0.6

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_8 = arg_216_1:GetWordFromCfg(317321052)
				local var_219_9 = arg_216_1:FormatText(var_219_8.content)

				arg_216_1.text_.text = var_219_9

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 24 <= 0 and var_219_7 or var_219_7 * (utf8.len(var_219_9) / 24)

				if (24 <= 0 and var_219_7 or var_219_7 * (utf8.len(var_219_9) / 24)) > 0 and var_219_7 < var_219_11 then
					arg_216_1.talkMaxDuration = var_219_11

					if var_219_11 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_11 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_9
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321052", "story_v_out_317321.awb") ~= 0 then
					local var_219_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321052", "story_v_out_317321.awb") / 1000

					if var_219_12 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_12 + var_219_6
					end

					if var_219_8.prefab_name ~= "" and arg_216_1.actors_[var_219_8.prefab_name] ~= nil then
						local var_219_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_8.prefab_name].transform, "story_v_out_317321", "317321052", "story_v_out_317321.awb")

						arg_216_1:RecordAudio("317321052", var_219_13)
						arg_216_1:RecordAudio("317321052", var_219_13)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_317321", "317321052", "story_v_out_317321.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_317321", "317321052", "story_v_out_317321.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_14 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_14 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_14

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_14 and arg_216_1.time_ < var_219_6 + var_219_14 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play317321053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 317321053
		arg_220_1.duration_ = 3.5

		local var_220_0 = {
			zh = 3.5,
			ja = 1.733
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play317321054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.275

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_1 = arg_220_1:GetWordFromCfg(317321053)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 11 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 11)

				if (11 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 11)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321053", "story_v_out_317321.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321053", "story_v_out_317321.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_out_317321", "317321053", "story_v_out_317321.awb")

						arg_220_1:RecordAudio("317321053", var_223_6)
						arg_220_1:RecordAudio("317321053", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_317321", "317321053", "story_v_out_317321.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_317321", "317321053", "story_v_out_317321.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play317321054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 317321054
		arg_224_1.duration_ = 6.83

		local var_224_0 = {
			zh = 2.866,
			ja = 6.833
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play317321055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10053ui_story = arg_224_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_227_0 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 then
				arg_224_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_224_1.time_ - 0) / var_227_0)
				arg_224_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["10053ui_story"].transform.position).z)
				arg_224_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["10053ui_story"].transform.localEulerAngles = arg_224_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 then
				arg_224_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_224_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["10053ui_story"].transform.position).z)
				arg_224_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["10053ui_story"].transform.localEulerAngles = arg_224_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_227_1 = arg_224_1.actors_["10053ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect10053ui_story == nil then
				arg_224_1.var_.characterEffect10053ui_story = var_227_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_2 and not isNil(var_227_1) then
				if arg_224_1.var_.characterEffect10053ui_story and not isNil(var_227_1) then
					arg_224_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_2 and arg_224_1.time_ < 0 + var_227_2 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect10053ui_story then
				arg_224_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_227_4 = arg_224_1.actors_["1015ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect1015ui_story == nil then
				arg_224_1.var_.characterEffect1015ui_story = var_227_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_5 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_5 and not isNil(var_227_4) then
				if arg_224_1.var_.characterEffect1015ui_story and not isNil(var_227_4) then
					arg_224_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_5)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_5 and arg_224_1.time_ < 0 + var_227_5 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect1015ui_story then
				arg_224_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_227_6 = 0
			local var_227_7 = 0.325

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_8 = arg_224_1:GetWordFromCfg(317321054)
				local var_227_9 = arg_224_1:FormatText(var_227_8.content)

				arg_224_1.text_.text = var_227_9

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 13 <= 0 and var_227_7 or var_227_7 * (utf8.len(var_227_9) / 13)

				if (13 <= 0 and var_227_7 or var_227_7 * (utf8.len(var_227_9) / 13)) > 0 and var_227_7 < var_227_11 then
					arg_224_1.talkMaxDuration = var_227_11

					if var_227_11 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_11 + var_227_6
					end
				end

				arg_224_1.text_.text = var_227_9
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321054", "story_v_out_317321.awb") ~= 0 then
					local var_227_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321054", "story_v_out_317321.awb") / 1000

					if var_227_12 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_12 + var_227_6
					end

					if var_227_8.prefab_name ~= "" and arg_224_1.actors_[var_227_8.prefab_name] ~= nil then
						local var_227_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_8.prefab_name].transform, "story_v_out_317321", "317321054", "story_v_out_317321.awb")

						arg_224_1:RecordAudio("317321054", var_227_13)
						arg_224_1:RecordAudio("317321054", var_227_13)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_317321", "317321054", "story_v_out_317321.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_317321", "317321054", "story_v_out_317321.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_14 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_14 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_14

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_14 and arg_224_1.time_ < var_227_6 + var_227_14 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play317321055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 317321055
		arg_228_1.duration_ = 15.13

		local var_228_0 = {
			zh = 12.733,
			ja = 15.133
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play317321056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1015ui_story = arg_228_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1015ui_story"].transform.position).z)
				arg_228_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1015ui_story"].transform.localEulerAngles = arg_228_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_228_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1015ui_story"].transform.position).z)
				arg_228_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1015ui_story"].transform.localEulerAngles = arg_228_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_231_1 = arg_228_1.actors_["1015ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1015ui_story == nil then
				arg_228_1.var_.characterEffect1015ui_story = var_231_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 and not isNil(var_231_1) then
				if arg_228_1.var_.characterEffect1015ui_story and not isNil(var_231_1) then
					arg_228_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1015ui_story then
				arg_228_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action5_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_231_4 = arg_228_1.actors_["10053ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect10053ui_story == nil then
				arg_228_1.var_.characterEffect10053ui_story = var_231_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_5 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_5 and not isNil(var_231_4) then
				if arg_228_1.var_.characterEffect10053ui_story and not isNil(var_231_4) then
					arg_228_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_5)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_5 and arg_228_1.time_ < 0 + var_231_5 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect10053ui_story then
				arg_228_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_231_6 = 0
			local var_231_7 = 1.375

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_8 = arg_228_1:GetWordFromCfg(317321055)
				local var_231_9 = arg_228_1:FormatText(var_231_8.content)

				arg_228_1.text_.text = var_231_9

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 55 <= 0 and var_231_7 or var_231_7 * (utf8.len(var_231_9) / 55)

				if (55 <= 0 and var_231_7 or var_231_7 * (utf8.len(var_231_9) / 55)) > 0 and var_231_7 < var_231_11 then
					arg_228_1.talkMaxDuration = var_231_11

					if var_231_11 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_9
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321055", "story_v_out_317321.awb") ~= 0 then
					local var_231_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321055", "story_v_out_317321.awb") / 1000

					if var_231_12 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_12 + var_231_6
					end

					if var_231_8.prefab_name ~= "" and arg_228_1.actors_[var_231_8.prefab_name] ~= nil then
						local var_231_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_8.prefab_name].transform, "story_v_out_317321", "317321055", "story_v_out_317321.awb")

						arg_228_1:RecordAudio("317321055", var_231_13)
						arg_228_1:RecordAudio("317321055", var_231_13)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_317321", "317321055", "story_v_out_317321.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_317321", "317321055", "story_v_out_317321.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_14 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_14 and arg_228_1.time_ < var_231_6 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play317321056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 317321056
		arg_232_1.duration_ = 17.37

		local var_232_0 = {
			zh = 12.466,
			ja = 17.366
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play317321057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos10053ui_story = arg_232_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10053ui_story"].transform.position).z)
				arg_232_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["10053ui_story"].transform.localEulerAngles = arg_232_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_232_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["10053ui_story"].transform.position).z)
				arg_232_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["10053ui_story"].transform.localEulerAngles = arg_232_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["10053ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect10053ui_story == nil then
				arg_232_1.var_.characterEffect10053ui_story = var_235_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 and not isNil(var_235_1) then
				if arg_232_1.var_.characterEffect10053ui_story and not isNil(var_235_1) then
					arg_232_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect10053ui_story then
				arg_232_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_235_4 = arg_232_1.actors_["1015ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_4) and arg_232_1.var_.characterEffect1015ui_story == nil then
				arg_232_1.var_.characterEffect1015ui_story = var_235_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_5 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_5 and not isNil(var_235_4) then
				if arg_232_1.var_.characterEffect1015ui_story and not isNil(var_235_4) then
					arg_232_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_5)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_5 and arg_232_1.time_ < 0 + var_235_5 + arg_235_0 and not isNil(var_235_4) and arg_232_1.var_.characterEffect1015ui_story then
				arg_232_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_235_6 = 0
			local var_235_7 = 0.925

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_6 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_8 = arg_232_1:GetWordFromCfg(317321056)
				local var_235_9 = arg_232_1:FormatText(var_235_8.content)

				arg_232_1.text_.text = var_235_9

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_11 = 37 <= 0 and var_235_7 or var_235_7 * (utf8.len(var_235_9) / 37)

				if (37 <= 0 and var_235_7 or var_235_7 * (utf8.len(var_235_9) / 37)) > 0 and var_235_7 < var_235_11 then
					arg_232_1.talkMaxDuration = var_235_11

					if var_235_11 + var_235_6 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_11 + var_235_6
					end
				end

				arg_232_1.text_.text = var_235_9
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321056", "story_v_out_317321.awb") ~= 0 then
					local var_235_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321056", "story_v_out_317321.awb") / 1000

					if var_235_12 + var_235_6 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_12 + var_235_6
					end

					if var_235_8.prefab_name ~= "" and arg_232_1.actors_[var_235_8.prefab_name] ~= nil then
						local var_235_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_8.prefab_name].transform, "story_v_out_317321", "317321056", "story_v_out_317321.awb")

						arg_232_1:RecordAudio("317321056", var_235_13)
						arg_232_1:RecordAudio("317321056", var_235_13)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_317321", "317321056", "story_v_out_317321.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_317321", "317321056", "story_v_out_317321.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_14 = math.max(var_235_7, arg_232_1.talkMaxDuration)

			if var_235_6 <= arg_232_1.time_ and arg_232_1.time_ < var_235_6 + var_235_14 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_6) / var_235_14

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_6 + var_235_14 and arg_232_1.time_ < var_235_6 + var_235_14 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play317321057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 317321057
		arg_236_1.duration_ = 4.57

		local var_236_0 = {
			zh = 2.266,
			ja = 4.566
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play317321058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.275

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:GetWordFromCfg(317321057)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 11 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 11)

				if (11 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 11)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321057", "story_v_out_317321.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321057", "story_v_out_317321.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_317321", "317321057", "story_v_out_317321.awb")

						arg_236_1:RecordAudio("317321057", var_239_6)
						arg_236_1:RecordAudio("317321057", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_317321", "317321057", "story_v_out_317321.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_317321", "317321057", "story_v_out_317321.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play317321058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 317321058
		arg_240_1.duration_ = 10.23

		local var_240_0 = {
			zh = 5.433,
			ja = 10.233
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play317321059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1015ui_story = arg_240_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1015ui_story"].transform.position).z)
				arg_240_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1015ui_story"].transform.localEulerAngles = arg_240_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_240_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1015ui_story"].transform.position).z)
				arg_240_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1015ui_story"].transform.localEulerAngles = arg_240_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["1015ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1015ui_story == nil then
				arg_240_1.var_.characterEffect1015ui_story = var_243_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 and not isNil(var_243_1) then
				if arg_240_1.var_.characterEffect1015ui_story and not isNil(var_243_1) then
					arg_240_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1015ui_story then
				arg_240_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015actionlink/1015action452")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_243_4 = arg_240_1.actors_["10053ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_4) and arg_240_1.var_.characterEffect10053ui_story == nil then
				arg_240_1.var_.characterEffect10053ui_story = var_243_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_5 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_5 and not isNil(var_243_4) then
				if arg_240_1.var_.characterEffect10053ui_story and not isNil(var_243_4) then
					arg_240_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_5)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_5 and arg_240_1.time_ < 0 + var_243_5 + arg_243_0 and not isNil(var_243_4) and arg_240_1.var_.characterEffect10053ui_story then
				arg_240_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_243_6 = 0
			local var_243_7 = 0.6

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_8 = arg_240_1:GetWordFromCfg(317321058)
				local var_243_9 = arg_240_1:FormatText(var_243_8.content)

				arg_240_1.text_.text = var_243_9

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 24 <= 0 and var_243_7 or var_243_7 * (utf8.len(var_243_9) / 24)

				if (24 <= 0 and var_243_7 or var_243_7 * (utf8.len(var_243_9) / 24)) > 0 and var_243_7 < var_243_11 then
					arg_240_1.talkMaxDuration = var_243_11

					if var_243_11 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_11 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_9
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321058", "story_v_out_317321.awb") ~= 0 then
					local var_243_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321058", "story_v_out_317321.awb") / 1000

					if var_243_12 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_12 + var_243_6
					end

					if var_243_8.prefab_name ~= "" and arg_240_1.actors_[var_243_8.prefab_name] ~= nil then
						local var_243_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_8.prefab_name].transform, "story_v_out_317321", "317321058", "story_v_out_317321.awb")

						arg_240_1:RecordAudio("317321058", var_243_13)
						arg_240_1:RecordAudio("317321058", var_243_13)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_317321", "317321058", "story_v_out_317321.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_317321", "317321058", "story_v_out_317321.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_14 and arg_240_1.time_ < var_243_6 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play317321059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 317321059
		arg_244_1.duration_ = 18.67

		local var_244_0 = {
			zh = 14.2,
			ja = 18.666
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
				arg_244_0:Play317321060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 1.5

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:GetWordFromCfg(317321059)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 60 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 60)

				if (60 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 60)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321059", "story_v_out_317321.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321059", "story_v_out_317321.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_317321", "317321059", "story_v_out_317321.awb")

						arg_244_1:RecordAudio("317321059", var_247_6)
						arg_244_1:RecordAudio("317321059", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_317321", "317321059", "story_v_out_317321.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_317321", "317321059", "story_v_out_317321.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play317321060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 317321060
		arg_248_1.duration_ = 12.6

		local var_248_0 = {
			zh = 10.6,
			ja = 12.6
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play317321061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 1.125

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:GetWordFromCfg(317321060)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 45 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 45)

				if (45 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 45)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321060", "story_v_out_317321.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321060", "story_v_out_317321.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_317321", "317321060", "story_v_out_317321.awb")

						arg_248_1:RecordAudio("317321060", var_251_6)
						arg_248_1:RecordAudio("317321060", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_317321", "317321060", "story_v_out_317321.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_317321", "317321060", "story_v_out_317321.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play317321061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 317321061
		arg_252_1.duration_ = 4

		local var_252_0 = {
			zh = 4,
			ja = 1.999999999999
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play317321062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10053ui_story = arg_252_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10053ui_story, Vector3.New(0.7, -1.12, -5.99), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10053ui_story"].transform.position).z)
				arg_252_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10053ui_story"].transform.localEulerAngles = arg_252_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0.7, -1.12, -5.99)
				arg_252_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["10053ui_story"].transform.position).z)
				arg_252_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["10053ui_story"].transform.localEulerAngles = arg_252_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_255_1 = arg_252_1.actors_["10053ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_1) and arg_252_1.var_.characterEffect10053ui_story == nil then
				arg_252_1.var_.characterEffect10053ui_story = var_255_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_2 and not isNil(var_255_1) then
				if arg_252_1.var_.characterEffect10053ui_story and not isNil(var_255_1) then
					arg_252_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_2 and arg_252_1.time_ < 0 + var_255_2 + arg_255_0 and not isNil(var_255_1) and arg_252_1.var_.characterEffect10053ui_story then
				arg_252_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_255_4 = arg_252_1.actors_["1015ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_4) and arg_252_1.var_.characterEffect1015ui_story == nil then
				arg_252_1.var_.characterEffect1015ui_story = var_255_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_5 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_5 and not isNil(var_255_4) then
				if arg_252_1.var_.characterEffect1015ui_story and not isNil(var_255_4) then
					arg_252_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_5)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_5 and arg_252_1.time_ < 0 + var_255_5 + arg_255_0 and not isNil(var_255_4) and arg_252_1.var_.characterEffect1015ui_story then
				arg_252_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_255_6 = 0
			local var_255_7 = 0.2

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_8 = arg_252_1:GetWordFromCfg(317321061)
				local var_255_9 = arg_252_1:FormatText(var_255_8.content)

				arg_252_1.text_.text = var_255_9

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 8 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 8)

				if (8 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_9) / 8)) > 0 and var_255_7 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_9
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321061", "story_v_out_317321.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321061", "story_v_out_317321.awb") / 1000

					if var_255_12 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_6
					end

					if var_255_8.prefab_name ~= "" and arg_252_1.actors_[var_255_8.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_8.prefab_name].transform, "story_v_out_317321", "317321061", "story_v_out_317321.awb")

						arg_252_1:RecordAudio("317321061", var_255_13)
						arg_252_1:RecordAudio("317321061", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_317321", "317321061", "story_v_out_317321.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_317321", "317321061", "story_v_out_317321.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play317321062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 317321062
		arg_256_1.duration_ = 10.23

		local var_256_0 = {
			zh = 9.966,
			ja = 10.233
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play317321063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 1.05

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:GetWordFromCfg(317321062)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 42 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 42)

				if (42 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 42)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321062", "story_v_out_317321.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321062", "story_v_out_317321.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_317321", "317321062", "story_v_out_317321.awb")

						arg_256_1:RecordAudio("317321062", var_259_6)
						arg_256_1:RecordAudio("317321062", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_317321", "317321062", "story_v_out_317321.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_317321", "317321062", "story_v_out_317321.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play317321063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 317321063
		arg_260_1.duration_ = 9.97

		local var_260_0 = {
			zh = 7.5,
			ja = 9.966
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
				arg_260_0:Play317321064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.775

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(317321063)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 31 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 31)

				if (31 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 31)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321063", "story_v_out_317321.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321063", "story_v_out_317321.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_317321", "317321063", "story_v_out_317321.awb")

						arg_260_1:RecordAudio("317321063", var_263_6)
						arg_260_1:RecordAudio("317321063", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_317321", "317321063", "story_v_out_317321.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_317321", "317321063", "story_v_out_317321.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play317321064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 317321064
		arg_264_1.duration_ = 8.47

		local var_264_0 = {
			zh = 7.233,
			ja = 8.466
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
				arg_264_0:Play317321065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.5

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_1 = arg_264_1:GetWordFromCfg(317321064)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 20 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 20)

				if (20 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 20)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321064", "story_v_out_317321.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321064", "story_v_out_317321.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_317321", "317321064", "story_v_out_317321.awb")

						arg_264_1:RecordAudio("317321064", var_267_6)
						arg_264_1:RecordAudio("317321064", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_317321", "317321064", "story_v_out_317321.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_317321", "317321064", "story_v_out_317321.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play317321065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 317321065
		arg_268_1.duration_ = 7

		local var_268_0 = {
			zh = 7,
			ja = 2.666
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
				arg_268_0:Play317321066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1015ui_story = arg_268_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_271_0 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 then
				arg_268_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1015ui_story, Vector3.New(-0.7, -1.15, -6.2), (arg_268_1.time_ - 0) / var_271_0)
				arg_268_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1015ui_story"].transform.position).z)
				arg_268_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1015ui_story"].transform.localEulerAngles = arg_268_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 then
				arg_268_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(-0.7, -1.15, -6.2)
				arg_268_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1015ui_story"].transform.position).z)
				arg_268_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1015ui_story"].transform.localEulerAngles = arg_268_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_271_1 = arg_268_1.actors_["1015ui_story"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_1) and arg_268_1.var_.characterEffect1015ui_story == nil then
				arg_268_1.var_.characterEffect1015ui_story = var_271_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_2 and not isNil(var_271_1) then
				if arg_268_1.var_.characterEffect1015ui_story and not isNil(var_271_1) then
					arg_268_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_2 and arg_268_1.time_ < 0 + var_271_2 + arg_271_0 and not isNil(var_271_1) and arg_268_1.var_.characterEffect1015ui_story then
				arg_268_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action2_2")
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_271_4 = 0
			local var_271_5 = 0.65

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_4 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_6 = arg_268_1:GetWordFromCfg(317321065)
				local var_271_7 = arg_268_1:FormatText(var_271_6.content)

				arg_268_1.text_.text = var_271_7

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_9 = 26 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 26)

				if (26 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 26)) > 0 and var_271_5 < var_271_9 then
					arg_268_1.talkMaxDuration = var_271_9

					if var_271_9 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_9 + var_271_4
					end
				end

				arg_268_1.text_.text = var_271_7
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321065", "story_v_out_317321.awb") ~= 0 then
					local var_271_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321065", "story_v_out_317321.awb") / 1000

					if var_271_10 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_10 + var_271_4
					end

					if var_271_6.prefab_name ~= "" and arg_268_1.actors_[var_271_6.prefab_name] ~= nil then
						local var_271_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_6.prefab_name].transform, "story_v_out_317321", "317321065", "story_v_out_317321.awb")

						arg_268_1:RecordAudio("317321065", var_271_11)
						arg_268_1:RecordAudio("317321065", var_271_11)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_317321", "317321065", "story_v_out_317321.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_317321", "317321065", "story_v_out_317321.awb")
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

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play317321066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 317321066
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play317321067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1015ui_story = arg_272_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1015ui_story"].transform.position).z)
				arg_272_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1015ui_story"].transform.localEulerAngles = arg_272_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_272_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1015ui_story"].transform.position).z)
				arg_272_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1015ui_story"].transform.localEulerAngles = arg_272_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_275_1 = arg_272_1.actors_["10053ui_story"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos10053ui_story = var_275_1.localPosition
			end

			local var_275_2 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_2 then
				var_275_1.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_272_1.time_ - 0) / var_275_2)
				var_275_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_1.position).x, (manager.ui.mainCamera.transform.position - var_275_1.position).y, (manager.ui.mainCamera.transform.position - var_275_1.position).z)
				var_275_1.localEulerAngles.z = 0
				var_275_1.localEulerAngles.x = 0
				var_275_1.localEulerAngles = var_275_1.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_2 and arg_272_1.time_ < 0 + var_275_2 + arg_275_0 then
				var_275_1.localPosition = Vector3.New(0, 100, 0)
				var_275_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_1.position).x, (manager.ui.mainCamera.transform.position - var_275_1.position).y, (manager.ui.mainCamera.transform.position - var_275_1.position).z)
				var_275_1.localEulerAngles.z = 0
				var_275_1.localEulerAngles.x = 0
				var_275_1.localEulerAngles = var_275_1.localEulerAngles
			end

			local var_275_3 = 0
			local var_275_4 = 1.05

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_3 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_5 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(317321066).content)

				arg_272_1.text_.text = var_275_5

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_7 = 42 <= 0 and var_275_4 or var_275_4 * (utf8.len(var_275_5) / 42)

				if (42 <= 0 and var_275_4 or var_275_4 * (utf8.len(var_275_5) / 42)) > 0 and var_275_4 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_3 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_3
					end
				end

				arg_272_1.text_.text = var_275_5
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_8 = math.max(var_275_4, arg_272_1.talkMaxDuration)

			if var_275_3 <= arg_272_1.time_ and arg_272_1.time_ < var_275_3 + var_275_8 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_3) / var_275_8

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_3 + var_275_8 and arg_272_1.time_ < var_275_3 + var_275_8 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play317321067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 317321067
		arg_276_1.duration_ = 7.83

		local var_276_0 = {
			zh = 7.833,
			ja = 7.266
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
				arg_276_0:Play317321068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos10053ui_story = arg_276_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_279_0 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 then
				arg_276_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_276_1.time_ - 0) / var_279_0)
				arg_276_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["10053ui_story"].transform.position).z)
				arg_276_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["10053ui_story"].transform.localEulerAngles = arg_276_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 then
				arg_276_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, -1.12, -5.99)
				arg_276_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["10053ui_story"].transform.position).z)
				arg_276_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["10053ui_story"].transform.localEulerAngles = arg_276_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_279_1 = arg_276_1.actors_["10053ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_1) and arg_276_1.var_.characterEffect10053ui_story == nil then
				arg_276_1.var_.characterEffect10053ui_story = var_279_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_2 and not isNil(var_279_1) then
				if arg_276_1.var_.characterEffect10053ui_story and not isNil(var_279_1) then
					arg_276_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_2 and arg_276_1.time_ < 0 + var_279_2 + arg_279_0 and not isNil(var_279_1) and arg_276_1.var_.characterEffect10053ui_story then
				arg_276_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action19_1")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_279_4 = 0
			local var_279_5 = 0.525

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_6 = arg_276_1:GetWordFromCfg(317321067)
				local var_279_7 = arg_276_1:FormatText(var_279_6.content)

				arg_276_1.text_.text = var_279_7

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_9 = 21 <= 0 and var_279_5 or var_279_5 * (utf8.len(var_279_7) / 21)

				if (21 <= 0 and var_279_5 or var_279_5 * (utf8.len(var_279_7) / 21)) > 0 and var_279_5 < var_279_9 then
					arg_276_1.talkMaxDuration = var_279_9

					if var_279_9 + var_279_4 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_9 + var_279_4
					end
				end

				arg_276_1.text_.text = var_279_7
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321067", "story_v_out_317321.awb") ~= 0 then
					local var_279_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321067", "story_v_out_317321.awb") / 1000

					if var_279_10 + var_279_4 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_4
					end

					if var_279_6.prefab_name ~= "" and arg_276_1.actors_[var_279_6.prefab_name] ~= nil then
						local var_279_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_6.prefab_name].transform, "story_v_out_317321", "317321067", "story_v_out_317321.awb")

						arg_276_1:RecordAudio("317321067", var_279_11)
						arg_276_1:RecordAudio("317321067", var_279_11)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_317321", "317321067", "story_v_out_317321.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_317321", "317321067", "story_v_out_317321.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_12 = math.max(var_279_5, arg_276_1.talkMaxDuration)

			if var_279_4 <= arg_276_1.time_ and arg_276_1.time_ < var_279_4 + var_279_12 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_4) / var_279_12

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_4 + var_279_12 and arg_276_1.time_ < var_279_4 + var_279_12 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play317321068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 317321068
		arg_280_1.duration_ = 6.13

		local var_280_0 = {
			zh = 3.8,
			ja = 6.133
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
				arg_280_0:Play317321069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10053ui_story = arg_280_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_283_0 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 then
				arg_280_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_280_1.time_ - 0) / var_283_0)
				arg_280_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10053ui_story"].transform.position).z)
				arg_280_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10053ui_story"].transform.localEulerAngles = arg_280_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 then
				arg_280_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_280_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["10053ui_story"].transform.position).z)
				arg_280_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["10053ui_story"].transform.localEulerAngles = arg_280_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_283_1 = arg_280_1.actors_["10053ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect10053ui_story == nil then
				arg_280_1.var_.characterEffect10053ui_story = var_283_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_2 and not isNil(var_283_1) then
				if arg_280_1.var_.characterEffect10053ui_story and not isNil(var_283_1) then
					arg_280_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_280_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_2)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_2 and arg_280_1.time_ < 0 + var_283_2 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect10053ui_story then
				arg_280_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_280_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_283_3 = arg_280_1.actors_["1015ui_story"].transform

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos1015ui_story = var_283_3.localPosition
			end

			local var_283_4 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				var_283_3.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_280_1.time_ - 0) / var_283_4)
				var_283_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_3.position).x, (manager.ui.mainCamera.transform.position - var_283_3.position).y, (manager.ui.mainCamera.transform.position - var_283_3.position).z)
				var_283_3.localEulerAngles.z = 0
				var_283_3.localEulerAngles.x = 0
				var_283_3.localEulerAngles = var_283_3.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				var_283_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_283_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_3.position).x, (manager.ui.mainCamera.transform.position - var_283_3.position).y, (manager.ui.mainCamera.transform.position - var_283_3.position).z)
				var_283_3.localEulerAngles.z = 0
				var_283_3.localEulerAngles.x = 0
				var_283_3.localEulerAngles = var_283_3.localEulerAngles
			end

			local var_283_5 = arg_280_1.actors_["1015ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_5) and arg_280_1.var_.characterEffect1015ui_story == nil then
				arg_280_1.var_.characterEffect1015ui_story = var_283_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_6 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_6 and not isNil(var_283_5) then
				if arg_280_1.var_.characterEffect1015ui_story and not isNil(var_283_5) then
					arg_280_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_6 and arg_280_1.time_ < 0 + var_283_6 + arg_283_0 and not isNil(var_283_5) and arg_280_1.var_.characterEffect1015ui_story then
				arg_280_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_283_8 = 0
			local var_283_9 = 0.2

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_10 = arg_280_1:GetWordFromCfg(317321068)
				local var_283_11 = arg_280_1:FormatText(var_283_10.content)

				arg_280_1.text_.text = var_283_11

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_13 = 8 <= 0 and var_283_9 or var_283_9 * (utf8.len(var_283_11) / 8)

				if (8 <= 0 and var_283_9 or var_283_9 * (utf8.len(var_283_11) / 8)) > 0 and var_283_9 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_8
					end
				end

				arg_280_1.text_.text = var_283_11
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321068", "story_v_out_317321.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321068", "story_v_out_317321.awb") / 1000

					if var_283_14 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_8
					end

					if var_283_10.prefab_name ~= "" and arg_280_1.actors_[var_283_10.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_10.prefab_name].transform, "story_v_out_317321", "317321068", "story_v_out_317321.awb")

						arg_280_1:RecordAudio("317321068", var_283_15)
						arg_280_1:RecordAudio("317321068", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_317321", "317321068", "story_v_out_317321.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_317321", "317321068", "story_v_out_317321.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_9, arg_280_1.talkMaxDuration)

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_8) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_8 + var_283_16 and arg_280_1.time_ < var_283_8 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play317321069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 317321069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play317321070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_127", "se_story_127_stone", "")
			end

			local var_287_1 = arg_284_1.actors_["1015ui_story"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1015ui_story = var_287_1.localPosition
			end

			local var_287_2 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_2 then
				var_287_1.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_284_1.time_ - 0) / var_287_2)
				var_287_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_1.position).x, (manager.ui.mainCamera.transform.position - var_287_1.position).y, (manager.ui.mainCamera.transform.position - var_287_1.position).z)
				var_287_1.localEulerAngles.z = 0
				var_287_1.localEulerAngles.x = 0
				var_287_1.localEulerAngles = var_287_1.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_2 and arg_284_1.time_ < 0 + var_287_2 + arg_287_0 then
				var_287_1.localPosition = Vector3.New(0, 100, 0)
				var_287_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_1.position).x, (manager.ui.mainCamera.transform.position - var_287_1.position).y, (manager.ui.mainCamera.transform.position - var_287_1.position).z)
				var_287_1.localEulerAngles.z = 0
				var_287_1.localEulerAngles.x = 0
				var_287_1.localEulerAngles = var_287_1.localEulerAngles
			end

			local var_287_3 = manager.ui.mainCamera.transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = var_287_3.localPosition
			end

			local var_287_4 = 1

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				local var_287_5, var_287_6 = math.modf((arg_284_1.time_ - 0) / 0.066)

				var_287_3.localPosition = Vector3.New(var_287_6 * 0.13, var_287_6 * 0.13, var_287_6 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				var_287_3.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_7 = 0
			local var_287_8 = 1.925

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_7 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_9 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(317321069).content)

				arg_284_1.text_.text = var_287_9

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 77 <= 0 and var_287_8 or var_287_8 * (utf8.len(var_287_9) / 77)

				if (77 <= 0 and var_287_8 or var_287_8 * (utf8.len(var_287_9) / 77)) > 0 and var_287_8 < var_287_11 then
					arg_284_1.talkMaxDuration = var_287_11

					if var_287_11 + var_287_7 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_7
					end
				end

				arg_284_1.text_.text = var_287_9
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_8, arg_284_1.talkMaxDuration)

			if var_287_7 <= arg_284_1.time_ and arg_284_1.time_ < var_287_7 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_7) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_7 + var_287_12 and arg_284_1.time_ < var_287_7 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play317321070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 317321070
		arg_288_1.duration_ = 3.3

		local var_288_0 = {
			zh = 3.3,
			ja = 3.2
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
				arg_288_0:Play317321071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1015ui_story = arg_288_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_291_0 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				arg_288_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_288_1.time_ - 0) / var_291_0)
				arg_288_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).z)
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles = arg_288_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				arg_288_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_288_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1015ui_story"].transform.position).z)
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1015ui_story"].transform.localEulerAngles = arg_288_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_291_1 = arg_288_1.actors_["1015ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1015ui_story == nil then
				arg_288_1.var_.characterEffect1015ui_story = var_291_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_2 and not isNil(var_291_1) then
				if arg_288_1.var_.characterEffect1015ui_story and not isNil(var_291_1) then
					arg_288_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_2 and arg_288_1.time_ < 0 + var_291_2 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1015ui_story then
				arg_288_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_291_4 = 0
			local var_291_5 = 0.325

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_6 = arg_288_1:GetWordFromCfg(317321070)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 13 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 13)

				if (13 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 13)) > 0 and var_291_5 < var_291_9 then
					arg_288_1.talkMaxDuration = var_291_9

					if var_291_9 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_9 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321070", "story_v_out_317321.awb") ~= 0 then
					local var_291_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321070", "story_v_out_317321.awb") / 1000

					if var_291_10 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_4
					end

					if var_291_6.prefab_name ~= "" and arg_288_1.actors_[var_291_6.prefab_name] ~= nil then
						local var_291_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_6.prefab_name].transform, "story_v_out_317321", "317321070", "story_v_out_317321.awb")

						arg_288_1:RecordAudio("317321070", var_291_11)
						arg_288_1:RecordAudio("317321070", var_291_11)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_317321", "317321070", "story_v_out_317321.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_317321", "317321070", "story_v_out_317321.awb")
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

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play317321071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 317321071
		arg_292_1.duration_ = 4.97

		local var_292_0 = {
			zh = 2.6,
			ja = 4.966
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
				arg_292_0:Play317321072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = 0.225

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_1 = arg_292_1:GetWordFromCfg(317321071)
				local var_295_2 = arg_292_1:FormatText(var_295_1.content)

				arg_292_1.text_.text = var_295_2

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_4 = 9 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 9)

				if (9 <= 0 and var_295_0 or var_295_0 * (utf8.len(var_295_2) / 9)) > 0 and var_295_0 < var_295_4 then
					arg_292_1.talkMaxDuration = var_295_4

					if var_295_4 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_4 + 0
					end
				end

				arg_292_1.text_.text = var_295_2
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321071", "story_v_out_317321.awb") ~= 0 then
					local var_295_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321071", "story_v_out_317321.awb") / 1000

					if var_295_5 + 0 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_5 + 0
					end

					if var_295_1.prefab_name ~= "" and arg_292_1.actors_[var_295_1.prefab_name] ~= nil then
						local var_295_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_1.prefab_name].transform, "story_v_out_317321", "317321071", "story_v_out_317321.awb")

						arg_292_1:RecordAudio("317321071", var_295_6)
						arg_292_1:RecordAudio("317321071", var_295_6)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_317321", "317321071", "story_v_out_317321.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_317321", "317321071", "story_v_out_317321.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_7 = math.max(var_295_0, arg_292_1.talkMaxDuration)

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_7 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - 0) / var_295_7

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= 0 + var_295_7 and arg_292_1.time_ < 0 + var_295_7 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play317321072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 317321072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play317321073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1015ui_story"]) and arg_296_1.var_.characterEffect1015ui_story == nil then
				arg_296_1.var_.characterEffect1015ui_story = arg_296_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1015ui_story"]) then
				if arg_296_1.var_.characterEffect1015ui_story and not isNil(arg_296_1.actors_["1015ui_story"]) then
					arg_296_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_0)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1015ui_story"]) and arg_296_1.var_.characterEffect1015ui_story then
				arg_296_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_299_1 = 0
			local var_299_2 = 0.725

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_3 = arg_296_1:FormatText(arg_296_1:GetWordFromCfg(317321072).content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_5 = 29 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 29)

				if (29 <= 0 and var_299_2 or var_299_2 * (utf8.len(var_299_3) / 29)) > 0 and var_299_2 < var_299_5 then
					arg_296_1.talkMaxDuration = var_299_5

					if var_299_5 + var_299_1 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_5 + var_299_1
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_6 = math.max(var_299_2, arg_296_1.talkMaxDuration)

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_6 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_1) / var_299_6

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_1 + var_299_6 and arg_296_1.time_ < var_299_1 + var_299_6 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play317321073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 317321073
		arg_300_1.duration_ = 8.07

		local var_300_0 = {
			zh = 8.066,
			ja = 6.1
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play317321074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1015ui_story = arg_300_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_303_0 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 then
				arg_300_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_300_1.time_ - 0) / var_303_0)
				arg_300_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1015ui_story"].transform.position).z)
				arg_300_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1015ui_story"].transform.localEulerAngles = arg_300_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 then
				arg_300_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_300_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["1015ui_story"].transform.position).z)
				arg_300_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["1015ui_story"].transform.localEulerAngles = arg_300_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_303_1 = arg_300_1.actors_["1015ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect1015ui_story == nil then
				arg_300_1.var_.characterEffect1015ui_story = var_303_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_2 and not isNil(var_303_1) then
				if arg_300_1.var_.characterEffect1015ui_story and not isNil(var_303_1) then
					arg_300_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_2 and arg_300_1.time_ < 0 + var_303_2 + arg_303_0 and not isNil(var_303_1) and arg_300_1.var_.characterEffect1015ui_story then
				arg_300_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_303_4 = 0
			local var_303_5 = 0.5

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_6 = arg_300_1:GetWordFromCfg(317321073)
				local var_303_7 = arg_300_1:FormatText(var_303_6.content)

				arg_300_1.text_.text = var_303_7

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_9 = 20 <= 0 and var_303_5 or var_303_5 * (utf8.len(var_303_7) / 20)

				if (20 <= 0 and var_303_5 or var_303_5 * (utf8.len(var_303_7) / 20)) > 0 and var_303_5 < var_303_9 then
					arg_300_1.talkMaxDuration = var_303_9

					if var_303_9 + var_303_4 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_9 + var_303_4
					end
				end

				arg_300_1.text_.text = var_303_7
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321073", "story_v_out_317321.awb") ~= 0 then
					local var_303_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321073", "story_v_out_317321.awb") / 1000

					if var_303_10 + var_303_4 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_10 + var_303_4
					end

					if var_303_6.prefab_name ~= "" and arg_300_1.actors_[var_303_6.prefab_name] ~= nil then
						local var_303_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_6.prefab_name].transform, "story_v_out_317321", "317321073", "story_v_out_317321.awb")

						arg_300_1:RecordAudio("317321073", var_303_11)
						arg_300_1:RecordAudio("317321073", var_303_11)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_317321", "317321073", "story_v_out_317321.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_317321", "317321073", "story_v_out_317321.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_12 = math.max(var_303_5, arg_300_1.talkMaxDuration)

			if var_303_4 <= arg_300_1.time_ and arg_300_1.time_ < var_303_4 + var_303_12 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_4) / var_303_12

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_4 + var_303_12 and arg_300_1.time_ < var_303_4 + var_303_12 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
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
	Play317321074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 317321074
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play317321075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(arg_304_1.actors_["1015ui_story"]) and arg_304_1.var_.characterEffect1015ui_story == nil then
				arg_304_1.var_.characterEffect1015ui_story = arg_304_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_0 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 and not isNil(arg_304_1.actors_["1015ui_story"]) then
				if arg_304_1.var_.characterEffect1015ui_story and not isNil(arg_304_1.actors_["1015ui_story"]) then
					arg_304_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_304_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_304_1.time_ - 0) / var_307_0)
				end
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 and not isNil(arg_304_1.actors_["1015ui_story"]) and arg_304_1.var_.characterEffect1015ui_story then
				arg_304_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_304_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_307_1 = 0
			local var_307_2 = 0.525

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

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(317321074).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 21 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 21)

				if (21 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 21)) > 0 and var_307_2 < var_307_5 then
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
	Play317321075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 317321075
		arg_308_1.duration_ = 4.23

		local var_308_0 = {
			zh = 4.233,
			ja = 0.999999999999
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play317321076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1015ui_story = arg_308_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1015ui_story"].transform.position).z)
				arg_308_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1015ui_story"].transform.localEulerAngles = arg_308_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1015ui_story"].transform.position).z)
				arg_308_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1015ui_story"].transform.localEulerAngles = arg_308_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_311_1 = arg_308_1.actors_["1015ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1015ui_story == nil then
				arg_308_1.var_.characterEffect1015ui_story = var_311_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_2 and not isNil(var_311_1) then
				if arg_308_1.var_.characterEffect1015ui_story and not isNil(var_311_1) then
					arg_308_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_2)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_2 and arg_308_1.time_ < 0 + var_311_2 + arg_311_0 and not isNil(var_311_1) and arg_308_1.var_.characterEffect1015ui_story then
				arg_308_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_311_3 = arg_308_1.actors_["10053ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10053ui_story = var_311_3.localPosition
			end

			local var_311_4 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				var_311_3.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10053ui_story, Vector3.New(0, -1.12, -5.99), (arg_308_1.time_ - 0) / var_311_4)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				var_311_3.localPosition = Vector3.New(0, -1.12, -5.99)
				var_311_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_3.position).x, (manager.ui.mainCamera.transform.position - var_311_3.position).y, (manager.ui.mainCamera.transform.position - var_311_3.position).z)
				var_311_3.localEulerAngles.z = 0
				var_311_3.localEulerAngles.x = 0
				var_311_3.localEulerAngles = var_311_3.localEulerAngles
			end

			local var_311_5 = arg_308_1.actors_["10053ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect10053ui_story == nil then
				arg_308_1.var_.characterEffect10053ui_story = var_311_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_6 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_6 and not isNil(var_311_5) then
				if arg_308_1.var_.characterEffect10053ui_story and not isNil(var_311_5) then
					arg_308_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_6 and arg_308_1.time_ < 0 + var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect10053ui_story then
				arg_308_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_311_8 = 0
			local var_311_9 = 0.1

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_8 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[477].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_10 = arg_308_1:GetWordFromCfg(317321075)
				local var_311_11 = arg_308_1:FormatText(var_311_10.content)

				arg_308_1.text_.text = var_311_11

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_13 = 4 <= 0 and var_311_9 or var_311_9 * (utf8.len(var_311_11) / 4)

				if (4 <= 0 and var_311_9 or var_311_9 * (utf8.len(var_311_11) / 4)) > 0 and var_311_9 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_8
					end
				end

				arg_308_1.text_.text = var_311_11
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321075", "story_v_out_317321.awb") ~= 0 then
					local var_311_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321075", "story_v_out_317321.awb") / 1000

					if var_311_14 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_14 + var_311_8
					end

					if var_311_10.prefab_name ~= "" and arg_308_1.actors_[var_311_10.prefab_name] ~= nil then
						local var_311_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_10.prefab_name].transform, "story_v_out_317321", "317321075", "story_v_out_317321.awb")

						arg_308_1:RecordAudio("317321075", var_311_15)
						arg_308_1:RecordAudio("317321075", var_311_15)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_317321", "317321075", "story_v_out_317321.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_317321", "317321075", "story_v_out_317321.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_9, arg_308_1.talkMaxDuration)

			if var_311_8 <= arg_308_1.time_ and arg_308_1.time_ < var_311_8 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_8) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_8 + var_311_16 and arg_308_1.time_ < var_311_8 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play317321076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 317321076
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play317321077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10053ui_story = arg_312_1.actors_["10053ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["10053ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10053ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10053ui_story"].transform.position).z)
				arg_312_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["10053ui_story"].transform.localEulerAngles = arg_312_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["10053ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_312_1.actors_["10053ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["10053ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10053ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10053ui_story"].transform.position).z)
				arg_312_1.actors_["10053ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["10053ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["10053ui_story"].transform.localEulerAngles = arg_312_1.actors_["10053ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["10053ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect10053ui_story == nil then
				arg_312_1.var_.characterEffect10053ui_story = var_315_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 and not isNil(var_315_1) then
				if arg_312_1.var_.characterEffect10053ui_story and not isNil(var_315_1) then
					arg_312_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10053ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_312_1.time_ - 0) / var_315_2)
				end
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect10053ui_story then
				arg_312_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10053ui_story.fillRatio = 0.5
			end

			local var_315_3 = 0
			local var_315_4 = 1.625

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_5 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(317321076).content)

				arg_312_1.text_.text = var_315_5

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_7 = 65 <= 0 and var_315_4 or var_315_4 * (utf8.len(var_315_5) / 65)

				if (65 <= 0 and var_315_4 or var_315_4 * (utf8.len(var_315_5) / 65)) > 0 and var_315_4 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_3 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_3
					end
				end

				arg_312_1.text_.text = var_315_5
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_8 = math.max(var_315_4, arg_312_1.talkMaxDuration)

			if var_315_3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_3 + var_315_8 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_3) / var_315_8

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_3 + var_315_8 and arg_312_1.time_ < var_315_3 + var_315_8 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play317321077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 317321077
		arg_316_1.duration_ = 7

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play317321078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if arg_316_1.bgs_.S0012 == nil then
				local var_319_0 = Object.Instantiate(arg_316_1.paintGo_)

				var_319_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0012")
				var_319_0.name = "S0012"
				var_319_0.transform.parent = arg_316_1.stage_.transform
				var_319_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_316_1.bgs_.S0012 = var_319_0
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				local var_319_1 = arg_316_1.bgs_.S0012

				arg_316_1.bgs_.S0012.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_319_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_319_2 = var_319_1:GetComponent("SpriteRenderer")

				if var_319_2 and var_319_2.sprite then
					local var_319_3 = 2 * (var_319_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_319_1.transform.localScale = Vector3.New(var_319_3 / var_319_2.sprite.bounds.size.y < var_319_3 * manager.ui.mainCameraCom_.aspect / var_319_2.sprite.bounds.size.x and var_319_3 * manager.ui.mainCameraCom_.aspect / var_319_2.sprite.bounds.size.x or var_319_3 / var_319_2.sprite.bounds.size.y, var_319_3 / var_319_2.sprite.bounds.size.y < var_319_3 * manager.ui.mainCameraCom_.aspect / var_319_2.sprite.bounds.size.x and var_319_3 * manager.ui.mainCameraCom_.aspect / var_319_2.sprite.bounds.size.x or var_319_3 / var_319_2.sprite.bounds.size.y, 0)
				end

				for iter_319_0, iter_319_1 in pairs(arg_316_1.bgs_) do
					if iter_319_0 ~= "S0012" then
						iter_319_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_319_4 = 0

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_4 + arg_319_0 then
				arg_316_1.mask_.enabled = true
				arg_316_1.mask_.raycastTarget = true

				arg_316_1:SetGaussion(false)
			end

			local var_319_5 = 2

			if var_319_4 <= arg_316_1.time_ and arg_316_1.time_ < var_319_4 + var_319_5 then
				local var_319_6 = Color.New(0, 0, 0)

				var_319_6.a = Mathf.Lerp(1, 0, (arg_316_1.time_ - var_319_4) / var_319_5)
				arg_316_1.mask_.color = var_319_6
			end

			if arg_316_1.time_ >= var_319_4 + var_319_5 and arg_316_1.time_ < var_319_4 + var_319_5 + arg_319_0 then
				local var_319_7 = Color.New(0, 0, 0)

				arg_316_1.mask_.enabled = false
				var_319_7.a = 0
				arg_316_1.mask_.color = var_319_7
			end

			if arg_316_1.frameCnt_ <= 1 then
				arg_316_1.dialog_:SetActive(false)
			end

			local var_319_8 = 2
			local var_319_9 = 0.9

			if 2 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0

				arg_316_1.dialog_:SetActive(true)

				arg_316_1.dialogCg_.alpha = 0

				local var_319_10 = LeanTween.value(arg_316_1.dialog_, 0, 1, 0.3)

				var_319_10:setOnUpdate(LuaHelper.FloatAction(function(arg_320_0)
					arg_316_1.dialogCg_.alpha = arg_320_0
				end))
				var_319_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_316_1.dialog_)
					var_319_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_316_1.duration_ = arg_316_1.duration_ + 0.3

				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_11 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(317321077).content)

				arg_316_1.text_.text = var_319_11

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_13 = 36 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 36)

				if (36 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 36)) > 0 and var_319_9 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13
					var_319_8 = var_319_8 + 0.3

					if var_319_13 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_8
					end
				end

				arg_316_1.text_.text = var_319_11
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_14 = var_319_8 + 0.3
			local var_319_15 = math.max(var_319_9, arg_316_1.talkMaxDuration)

			if var_319_8 + 0.3 <= arg_316_1.time_ and arg_316_1.time_ < var_319_14 + var_319_15 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_14) / var_319_15

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_14 + var_319_15 and arg_316_1.time_ < var_319_14 + var_319_15 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play317321078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 317321078
		arg_322_1.duration_ = 4.8

		local var_322_0 = {
			zh = 4.8,
			ja = 3.533
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play317321079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0.6

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_1 = arg_322_1:GetWordFromCfg(317321078)
				local var_325_2 = arg_322_1:FormatText(var_325_1.content)

				arg_322_1.text_.text = var_325_2

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_4 = 24 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 24)

				if (24 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_2) / 24)) > 0 and var_325_0 < var_325_4 then
					arg_322_1.talkMaxDuration = var_325_4

					if var_325_4 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_4 + 0
					end
				end

				arg_322_1.text_.text = var_325_2
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321078", "story_v_out_317321.awb") ~= 0 then
					local var_325_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321078", "story_v_out_317321.awb") / 1000

					if var_325_5 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_5 + 0
					end

					if var_325_1.prefab_name ~= "" and arg_322_1.actors_[var_325_1.prefab_name] ~= nil then
						local var_325_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_1.prefab_name].transform, "story_v_out_317321", "317321078", "story_v_out_317321.awb")

						arg_322_1:RecordAudio("317321078", var_325_6)
						arg_322_1:RecordAudio("317321078", var_325_6)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_317321", "317321078", "story_v_out_317321.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_317321", "317321078", "story_v_out_317321.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_7 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_7

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play317321079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 317321079
		arg_326_1.duration_ = 2.47

		local var_326_0 = {
			zh = 1.7,
			ja = 2.466
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play317321080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.2

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_1 = arg_326_1:GetWordFromCfg(317321079)
				local var_329_2 = arg_326_1:FormatText(var_329_1.content)

				arg_326_1.text_.text = var_329_2

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_4 = 8 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 8)

				if (8 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_2) / 8)) > 0 and var_329_0 < var_329_4 then
					arg_326_1.talkMaxDuration = var_329_4

					if var_329_4 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_4 + 0
					end
				end

				arg_326_1.text_.text = var_329_2
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321079", "story_v_out_317321.awb") ~= 0 then
					local var_329_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321079", "story_v_out_317321.awb") / 1000

					if var_329_5 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + 0
					end

					if var_329_1.prefab_name ~= "" and arg_326_1.actors_[var_329_1.prefab_name] ~= nil then
						local var_329_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_1.prefab_name].transform, "story_v_out_317321", "317321079", "story_v_out_317321.awb")

						arg_326_1:RecordAudio("317321079", var_329_6)
						arg_326_1:RecordAudio("317321079", var_329_6)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_317321", "317321079", "story_v_out_317321.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_317321", "317321079", "story_v_out_317321.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_7 and arg_326_1.time_ < 0 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play317321080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 317321080
		arg_330_1.duration_ = 8.3

		local var_330_0 = {
			zh = 6.5,
			ja = 8.3
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play317321081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.6

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, true)
				arg_330_1.iconController_:SetSelectedState("hero")

				arg_330_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_330_1.callingController_:SetSelectedState("normal")

				arg_330_1.keyicon_.color = Color.New(1, 1, 1)
				arg_330_1.icon_.color = Color.New(1, 1, 1)

				local var_333_1 = arg_330_1:GetWordFromCfg(317321080)
				local var_333_2 = arg_330_1:FormatText(var_333_1.content)

				arg_330_1.text_.text = var_333_2

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 24 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 24)

				if (24 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_2) / 24)) > 0 and var_333_0 < var_333_4 then
					arg_330_1.talkMaxDuration = var_333_4

					if var_333_4 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_4 + 0
					end
				end

				arg_330_1.text_.text = var_333_2
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321080", "story_v_out_317321.awb") ~= 0 then
					local var_333_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321080", "story_v_out_317321.awb") / 1000

					if var_333_5 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + 0
					end

					if var_333_1.prefab_name ~= "" and arg_330_1.actors_[var_333_1.prefab_name] ~= nil then
						local var_333_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_1.prefab_name].transform, "story_v_out_317321", "317321080", "story_v_out_317321.awb")

						arg_330_1:RecordAudio("317321080", var_333_6)
						arg_330_1:RecordAudio("317321080", var_333_6)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_317321", "317321080", "story_v_out_317321.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_317321", "317321080", "story_v_out_317321.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_7 and arg_330_1.time_ < 0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play317321081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 317321081
		arg_334_1.duration_ = 11.23

		local var_334_0 = {
			zh = 11.233,
			ja = 11.066
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play317321082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = 1.075

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_1 = arg_334_1:GetWordFromCfg(317321081)
				local var_337_2 = arg_334_1:FormatText(var_337_1.content)

				arg_334_1.text_.text = var_337_2

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_4 = 43 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 43)

				if (43 <= 0 and var_337_0 or var_337_0 * (utf8.len(var_337_2) / 43)) > 0 and var_337_0 < var_337_4 then
					arg_334_1.talkMaxDuration = var_337_4

					if var_337_4 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_4 + 0
					end
				end

				arg_334_1.text_.text = var_337_2
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321081", "story_v_out_317321.awb") ~= 0 then
					local var_337_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321081", "story_v_out_317321.awb") / 1000

					if var_337_5 + 0 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_5 + 0
					end

					if var_337_1.prefab_name ~= "" and arg_334_1.actors_[var_337_1.prefab_name] ~= nil then
						local var_337_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_1.prefab_name].transform, "story_v_out_317321", "317321081", "story_v_out_317321.awb")

						arg_334_1:RecordAudio("317321081", var_337_6)
						arg_334_1:RecordAudio("317321081", var_337_6)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_317321", "317321081", "story_v_out_317321.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_317321", "317321081", "story_v_out_317321.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_0, arg_334_1.talkMaxDuration)

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - 0) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= 0 + var_337_7 and arg_334_1.time_ < 0 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play317321082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 317321082
		arg_338_1.duration_ = 9.43

		local var_338_0 = {
			zh = 6.533,
			ja = 9.433
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play317321083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_341_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_338_1.bgmTxt_.text ~= var_341_2 and arg_338_1.bgmTxt_.text ~= "" then
						if arg_338_1.bgmTxt2_.text ~= "" then
							arg_338_1.bgmTxt_.text = arg_338_1.bgmTxt2_.text
						end

						arg_338_1.bgmTxt2_.text = var_341_2

						arg_338_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_338_1.bgmTxt_.text = var_341_2
						arg_338_1.bgmTxt2_.text = var_341_2
					end

					if arg_338_1.bgmTimer then
						arg_338_1.bgmTimer:Stop()

						arg_338_1.bgmTimer = nil
					end

					if arg_338_1.settingData.show_music_name == 1 then
						arg_338_1.musicController:SetSelectedState("show")
						arg_338_1.musicAnimator_:Play("open", 0, 0)

						if arg_338_1.settingData.music_time ~= 0 then
							arg_338_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_338_1.settingData.music_time), function()
								if arg_338_1 == nil or isNil(arg_338_1.bgmTxt_) then
									return
								end

								arg_338_1.musicController:SetSelectedState("hide")
								arg_338_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_341_3 = 0
			local var_341_4 = 0.5

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_3 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, true)
				arg_338_1.iconController_:SetSelectedState("hero")

				arg_338_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1015")

				arg_338_1.callingController_:SetSelectedState("normal")

				arg_338_1.keyicon_.color = Color.New(1, 1, 1)
				arg_338_1.icon_.color = Color.New(1, 1, 1)

				local var_341_5 = arg_338_1:GetWordFromCfg(317321082)
				local var_341_6 = arg_338_1:FormatText(var_341_5.content)

				arg_338_1.text_.text = var_341_6

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_8 = 20 <= 0 and var_341_4 or var_341_4 * (utf8.len(var_341_6) / 20)

				if (20 <= 0 and var_341_4 or var_341_4 * (utf8.len(var_341_6) / 20)) > 0 and var_341_4 < var_341_8 then
					arg_338_1.talkMaxDuration = var_341_8

					if var_341_8 + var_341_3 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_3
					end
				end

				arg_338_1.text_.text = var_341_6
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321082", "story_v_out_317321.awb") ~= 0 then
					local var_341_9 = manager.audio:GetVoiceLength("story_v_out_317321", "317321082", "story_v_out_317321.awb") / 1000

					if var_341_9 + var_341_3 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_3
					end

					if var_341_5.prefab_name ~= "" and arg_338_1.actors_[var_341_5.prefab_name] ~= nil then
						local var_341_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_5.prefab_name].transform, "story_v_out_317321", "317321082", "story_v_out_317321.awb")

						arg_338_1:RecordAudio("317321082", var_341_10)
						arg_338_1:RecordAudio("317321082", var_341_10)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_317321", "317321082", "story_v_out_317321.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_317321", "317321082", "story_v_out_317321.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_11 = math.max(var_341_4, arg_338_1.talkMaxDuration)

			if var_341_3 <= arg_338_1.time_ and arg_338_1.time_ < var_341_3 + var_341_11 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_3) / var_341_11

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_3 + var_341_11 and arg_338_1.time_ < var_341_3 + var_341_11 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play317321083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 317321083
		arg_343_1.duration_ = 7

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play317321084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if arg_343_1.bgs_.ST12 == nil then
				local var_346_0 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_346_0.name = "ST12"
				var_346_0.transform.parent = arg_343_1.stage_.transform
				var_346_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_.ST12 = var_346_0
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				local var_346_1 = arg_343_1.bgs_.ST12

				arg_343_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_346_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_2 = var_346_1:GetComponent("SpriteRenderer")

				if var_346_2 and var_346_2.sprite then
					local var_346_3 = 2 * (var_346_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_346_1.transform.localScale = Vector3.New(var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "ST12" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_4 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_5 = 2

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_5 then
				local var_346_6 = Color.New(0, 0, 0)

				var_346_6.a = Mathf.Lerp(1, 0, (arg_343_1.time_ - var_346_4) / var_346_5)
				arg_343_1.mask_.color = var_346_6
			end

			if arg_343_1.time_ >= var_346_4 + var_346_5 and arg_343_1.time_ < var_346_4 + var_346_5 + arg_346_0 then
				local var_346_7 = Color.New(0, 0, 0)

				arg_343_1.mask_.enabled = false
				var_346_7.a = 0
				arg_343_1.mask_.color = var_346_7
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_346_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_10 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_10

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_10
						arg_343_1.bgmTxt2_.text = var_346_10
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.733333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 0.733333333333333 + arg_346_0 then
				arg_343_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office.awb")

				local var_346_13 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_13 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_13

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_13
						arg_343_1.bgmTxt2_.text = var_346_13
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_14 = 2
			local var_346_15 = 1.125

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_14 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_16 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_16:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_343_1.dialogCg_.alpha = arg_349_0
				end))
				var_346_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_17 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(317321083).content)

				arg_343_1.text_.text = var_346_17

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_19 = 45 <= 0 and var_346_15 or var_346_15 * (utf8.len(var_346_17) / 45)

				if (45 <= 0 and var_346_15 or var_346_15 * (utf8.len(var_346_17) / 45)) > 0 and var_346_15 < var_346_19 then
					arg_343_1.talkMaxDuration = var_346_19
					var_346_14 = var_346_14 + 0.3

					if var_346_19 + var_346_14 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_19 + var_346_14
					end
				end

				arg_343_1.text_.text = var_346_17
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_20 = var_346_14 + 0.3
			local var_346_21 = math.max(var_346_15, arg_343_1.talkMaxDuration)

			if var_346_14 + 0.3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_20 + var_346_21 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_20) / var_346_21

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_20 + var_346_21 and arg_343_1.time_ < var_346_20 + var_346_21 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play317321084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 317321084
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play317321085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 1.2

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(317321084).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 48 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 48)

				if (48 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 48)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play317321085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 317321085
		arg_355_1.duration_ = 6.13

		local var_355_0 = {
			zh = 6.133,
			ja = 4.166
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play317321086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if arg_355_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_358_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_355_1.stage_.transform)

				var_358_0.name = "1029ui_story"
				var_358_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_355_1.actors_["1029ui_story"] = var_358_0

				local var_358_1 = var_358_0:GetComponentInChildren(typeof(CharacterEffect))

				var_358_1.enabled = true

				local var_358_2 = GameObjectTools.GetOrAddComponent(var_358_0, typeof(DynamicBoneHelper))

				if var_358_2 then
					var_358_2:EnableDynamicBone(false)
				end

				arg_355_1:ShowWeapon(var_358_1.transform, false)

				arg_355_1.var_["1029ui_story" .. "Animator"] = var_358_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_355_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_355_1.var_["1029ui_story" .. "LipSync"] = var_358_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_358_3 = arg_355_1.actors_["1029ui_story"].transform

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1029ui_story = var_358_3.localPosition
			end

			local var_358_4 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				var_358_3.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_355_1.time_ - 0) / var_358_4)
				var_358_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_3.position).x, (manager.ui.mainCamera.transform.position - var_358_3.position).y, (manager.ui.mainCamera.transform.position - var_358_3.position).z)
				var_358_3.localEulerAngles.z = 0
				var_358_3.localEulerAngles.x = 0
				var_358_3.localEulerAngles = var_358_3.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				var_358_3.localPosition = Vector3.New(0, -1.09, -6.2)
				var_358_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_3.position).x, (manager.ui.mainCamera.transform.position - var_358_3.position).y, (manager.ui.mainCamera.transform.position - var_358_3.position).z)
				var_358_3.localEulerAngles.z = 0
				var_358_3.localEulerAngles.x = 0
				var_358_3.localEulerAngles = var_358_3.localEulerAngles
			end

			local var_358_5 = arg_355_1.actors_["1029ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.characterEffect1029ui_story == nil then
				arg_355_1.var_.characterEffect1029ui_story = var_358_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_6 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_6 and not isNil(var_358_5) then
				if arg_355_1.var_.characterEffect1029ui_story and not isNil(var_358_5) then
					arg_355_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_6 and arg_355_1.time_ < 0 + var_358_6 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.characterEffect1029ui_story then
				arg_355_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_358_8 = 0
			local var_358_9 = 0.45

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_10 = arg_355_1:GetWordFromCfg(317321085)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_13 = 18 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 18)

				if (18 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 18)) > 0 and var_358_9 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321085", "story_v_out_317321.awb") ~= 0 then
					local var_358_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321085", "story_v_out_317321.awb") / 1000

					if var_358_14 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_8
					end

					if var_358_10.prefab_name ~= "" and arg_355_1.actors_[var_358_10.prefab_name] ~= nil then
						local var_358_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_10.prefab_name].transform, "story_v_out_317321", "317321085", "story_v_out_317321.awb")

						arg_355_1:RecordAudio("317321085", var_358_15)
						arg_355_1:RecordAudio("317321085", var_358_15)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_317321", "317321085", "story_v_out_317321.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_317321", "317321085", "story_v_out_317321.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_16 = math.max(var_358_9, arg_355_1.talkMaxDuration)

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_16 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_8) / var_358_16

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_8 + var_358_16 and arg_355_1.time_ < var_358_8 + var_358_16 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play317321086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 317321086
		arg_359_1.duration_ = 7.2

		local var_359_0 = {
			zh = 3.1,
			ja = 7.2
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play317321087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_362_0 = 0
			local var_362_1 = 0.375

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_2 = arg_359_1:GetWordFromCfg(317321086)
				local var_362_3 = arg_359_1:FormatText(var_362_2.content)

				arg_359_1.text_.text = var_362_3

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 15 <= 0 and var_362_1 or var_362_1 * (utf8.len(var_362_3) / 15)

				if (15 <= 0 and var_362_1 or var_362_1 * (utf8.len(var_362_3) / 15)) > 0 and var_362_1 < var_362_5 then
					arg_359_1.talkMaxDuration = var_362_5

					if var_362_5 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_3
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321086", "story_v_out_317321.awb") ~= 0 then
					local var_362_6 = manager.audio:GetVoiceLength("story_v_out_317321", "317321086", "story_v_out_317321.awb") / 1000

					if var_362_6 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_6 + var_362_0
					end

					if var_362_2.prefab_name ~= "" and arg_359_1.actors_[var_362_2.prefab_name] ~= nil then
						local var_362_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_2.prefab_name].transform, "story_v_out_317321", "317321086", "story_v_out_317321.awb")

						arg_359_1:RecordAudio("317321086", var_362_7)
						arg_359_1:RecordAudio("317321086", var_362_7)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_317321", "317321086", "story_v_out_317321.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_317321", "317321086", "story_v_out_317321.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_8 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_8 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_8

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_8 and arg_359_1.time_ < var_362_0 + var_362_8 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play317321087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 317321087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play317321088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1029ui_story = arg_363_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_366_0 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 then
				arg_363_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_363_1.time_ - 0) / var_366_0)
				arg_363_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1029ui_story"].transform.position).z)
				arg_363_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1029ui_story"].transform.localEulerAngles = arg_363_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 then
				arg_363_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_363_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_363_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_363_1.actors_["1029ui_story"].transform.position).z)
				arg_363_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_363_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_363_1.actors_["1029ui_story"].transform.localEulerAngles = arg_363_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_366_1 = 0
			local var_366_2 = 0.95

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_3 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(317321087).content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 38 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 38)

				if (38 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 38)) > 0 and var_366_2 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_6 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_6 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_6

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_6 and arg_363_1.time_ < var_366_1 + var_366_6 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play317321088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 317321088
		arg_367_1.duration_ = 6.13

		local var_367_0 = {
			zh = 3.7,
			ja = 6.133
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
				arg_367_0:Play317321089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if arg_367_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_370_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_367_1.stage_.transform)

				var_370_0.name = "1019ui_story"
				var_370_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.actors_["1019ui_story"] = var_370_0

				local var_370_1 = var_370_0:GetComponentInChildren(typeof(CharacterEffect))

				var_370_1.enabled = true

				local var_370_2 = GameObjectTools.GetOrAddComponent(var_370_0, typeof(DynamicBoneHelper))

				if var_370_2 then
					var_370_2:EnableDynamicBone(false)
				end

				arg_367_1:ShowWeapon(var_370_1.transform, false)

				arg_367_1.var_["1019ui_story" .. "Animator"] = var_370_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_367_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_367_1.var_["1019ui_story" .. "LipSync"] = var_370_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_370_3 = arg_367_1.actors_["1019ui_story"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1019ui_story = var_370_3.localPosition
			end

			local var_370_4 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				var_370_3.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_367_1.time_ - 0) / var_370_4)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				var_370_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_370_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_370_3.position).x, (manager.ui.mainCamera.transform.position - var_370_3.position).y, (manager.ui.mainCamera.transform.position - var_370_3.position).z)
				var_370_3.localEulerAngles.z = 0
				var_370_3.localEulerAngles.x = 0
				var_370_3.localEulerAngles = var_370_3.localEulerAngles
			end

			local var_370_5 = arg_367_1.actors_["1019ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.characterEffect1019ui_story == nil then
				arg_367_1.var_.characterEffect1019ui_story = var_370_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_6 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_6 and not isNil(var_370_5) then
				if arg_367_1.var_.characterEffect1019ui_story and not isNil(var_370_5) then
					arg_367_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_6 and arg_367_1.time_ < 0 + var_370_6 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.characterEffect1019ui_story then
				arg_367_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_370_8 = 0
			local var_370_9 = 0.525

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_10 = arg_367_1:GetWordFromCfg(317321088)
				local var_370_11 = arg_367_1:FormatText(var_370_10.content)

				arg_367_1.text_.text = var_370_11

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 21 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 21)

				if (21 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 21)) > 0 and var_370_9 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_8
					end
				end

				arg_367_1.text_.text = var_370_11
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321088", "story_v_out_317321.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321088", "story_v_out_317321.awb") / 1000

					if var_370_14 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_8
					end

					if var_370_10.prefab_name ~= "" and arg_367_1.actors_[var_370_10.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_10.prefab_name].transform, "story_v_out_317321", "317321088", "story_v_out_317321.awb")

						arg_367_1:RecordAudio("317321088", var_370_15)
						arg_367_1:RecordAudio("317321088", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_317321", "317321088", "story_v_out_317321.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_317321", "317321088", "story_v_out_317321.awb")
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play317321089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 317321089
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play317321090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1019ui_story = arg_371_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1019ui_story"].transform.position).z)
				arg_371_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1019ui_story"].transform.localEulerAngles = arg_371_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_371_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1019ui_story"].transform.position).z)
				arg_371_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1019ui_story"].transform.localEulerAngles = arg_371_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_374_1 = 0
			local var_374_2 = 0.825

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_3 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(317321089).content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 33 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 33)

				if (33 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 33)) > 0 and var_374_2 < var_374_5 then
					arg_371_1.talkMaxDuration = var_374_5

					if var_374_5 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_6 = math.max(var_374_2, arg_371_1.talkMaxDuration)

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_6 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_1) / var_374_6

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_1 + var_374_6 and arg_371_1.time_ < var_374_1 + var_374_6 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play317321090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 317321090
		arg_375_1.duration_ = 6.4

		local var_375_0 = {
			zh = 6.4,
			ja = 5.633
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play317321091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1019ui_story = arg_375_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1019ui_story"].transform.position).z)
				arg_375_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1019ui_story"].transform.localEulerAngles = arg_375_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_375_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1019ui_story"].transform.position).z)
				arg_375_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1019ui_story"].transform.localEulerAngles = arg_375_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1019ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1019ui_story == nil then
				arg_375_1.var_.characterEffect1019ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1019ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1019ui_story then
				arg_375_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_378_4 = arg_375_1.actors_["1029ui_story"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1029ui_story = var_378_4.localPosition
			end

			local var_378_5 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_5 then
				var_378_4.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_375_1.time_ - 0) / var_378_5)
				var_378_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_4.position).x, (manager.ui.mainCamera.transform.position - var_378_4.position).y, (manager.ui.mainCamera.transform.position - var_378_4.position).z)
				var_378_4.localEulerAngles.z = 0
				var_378_4.localEulerAngles.x = 0
				var_378_4.localEulerAngles = var_378_4.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_5 and arg_375_1.time_ < 0 + var_378_5 + arg_378_0 then
				var_378_4.localPosition = Vector3.New(0.7, -1.09, -6.2)
				var_378_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_4.position).x, (manager.ui.mainCamera.transform.position - var_378_4.position).y, (manager.ui.mainCamera.transform.position - var_378_4.position).z)
				var_378_4.localEulerAngles.z = 0
				var_378_4.localEulerAngles.x = 0
				var_378_4.localEulerAngles = var_378_4.localEulerAngles
			end

			local var_378_6 = arg_375_1.actors_["1029ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect1029ui_story == nil then
				arg_375_1.var_.characterEffect1029ui_story = var_378_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_7 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 and not isNil(var_378_6) then
				if arg_375_1.var_.characterEffect1029ui_story and not isNil(var_378_6) then
					arg_375_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_7)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect1029ui_story then
				arg_375_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_378_8 = 0
			local var_378_9 = 0.625

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_10 = arg_375_1:GetWordFromCfg(317321090)
				local var_378_11 = arg_375_1:FormatText(var_378_10.content)

				arg_375_1.text_.text = var_378_11

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_13 = 25 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 25)

				if (25 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 25)) > 0 and var_378_9 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_8
					end
				end

				arg_375_1.text_.text = var_378_11
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321090", "story_v_out_317321.awb") ~= 0 then
					local var_378_14 = manager.audio:GetVoiceLength("story_v_out_317321", "317321090", "story_v_out_317321.awb") / 1000

					if var_378_14 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_14 + var_378_8
					end

					if var_378_10.prefab_name ~= "" and arg_375_1.actors_[var_378_10.prefab_name] ~= nil then
						local var_378_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_10.prefab_name].transform, "story_v_out_317321", "317321090", "story_v_out_317321.awb")

						arg_375_1:RecordAudio("317321090", var_378_15)
						arg_375_1:RecordAudio("317321090", var_378_15)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_317321", "317321090", "story_v_out_317321.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_317321", "317321090", "story_v_out_317321.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_16 = math.max(var_378_9, arg_375_1.talkMaxDuration)

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_16 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_8) / var_378_16

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_8 + var_378_16 and arg_375_1.time_ < var_378_8 + var_378_16 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play317321091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 317321091
		arg_379_1.duration_ = 8.27

		local var_379_0 = {
			zh = 3.066,
			ja = 8.266
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play317321092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1029ui_story = arg_379_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1029ui_story"].transform.position).z)
				arg_379_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1029ui_story"].transform.localEulerAngles = arg_379_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_379_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1029ui_story"].transform.position).z)
				arg_379_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1029ui_story"].transform.localEulerAngles = arg_379_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1029ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1029ui_story == nil then
				arg_379_1.var_.characterEffect1029ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1029ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1029ui_story then
				arg_379_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_4 = arg_379_1.actors_["1019ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect1019ui_story == nil then
				arg_379_1.var_.characterEffect1019ui_story = var_382_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_5 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_5 and not isNil(var_382_4) then
				if arg_379_1.var_.characterEffect1019ui_story and not isNil(var_382_4) then
					arg_379_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_5)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_5 and arg_379_1.time_ < 0 + var_382_5 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect1019ui_story then
				arg_379_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_382_6 = 0
			local var_382_7 = 0.375

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:GetWordFromCfg(317321091)
				local var_382_9 = arg_379_1:FormatText(var_382_8.content)

				arg_379_1.text_.text = var_382_9

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 15 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_9) / 15)

				if (15 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_9) / 15)) > 0 and var_382_7 < var_382_11 then
					arg_379_1.talkMaxDuration = var_382_11

					if var_382_11 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_11 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_9
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321091", "story_v_out_317321.awb") ~= 0 then
					local var_382_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321091", "story_v_out_317321.awb") / 1000

					if var_382_12 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_12 + var_382_6
					end

					if var_382_8.prefab_name ~= "" and arg_379_1.actors_[var_382_8.prefab_name] ~= nil then
						local var_382_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_8.prefab_name].transform, "story_v_out_317321", "317321091", "story_v_out_317321.awb")

						arg_379_1:RecordAudio("317321091", var_382_13)
						arg_379_1:RecordAudio("317321091", var_382_13)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_317321", "317321091", "story_v_out_317321.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_317321", "317321091", "story_v_out_317321.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_14 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_14 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_14

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_14 and arg_379_1.time_ < var_382_6 + var_382_14 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play317321092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 317321092
		arg_383_1.duration_ = 1.83

		local var_383_0 = {
			zh = 1.833,
			ja = 1.433
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play317321093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1029ui_story"]) and arg_383_1.var_.characterEffect1029ui_story == nil then
				arg_383_1.var_.characterEffect1029ui_story = arg_383_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1029ui_story"]) then
				if arg_383_1.var_.characterEffect1029ui_story and not isNil(arg_383_1.actors_["1029ui_story"]) then
					arg_383_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1029ui_story"]) and arg_383_1.var_.characterEffect1029ui_story then
				arg_383_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_386_1 = arg_383_1.actors_["1019ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1019ui_story == nil then
				arg_383_1.var_.characterEffect1019ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1019ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1019ui_story then
				arg_383_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_386_4 = 0
			local var_386_5 = 0.15

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_6 = arg_383_1:GetWordFromCfg(317321092)
				local var_386_7 = arg_383_1:FormatText(var_386_6.content)

				arg_383_1.text_.text = var_386_7

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_9 = 6 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 6)

				if (6 <= 0 and var_386_5 or var_386_5 * (utf8.len(var_386_7) / 6)) > 0 and var_386_5 < var_386_9 then
					arg_383_1.talkMaxDuration = var_386_9

					if var_386_9 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_9 + var_386_4
					end
				end

				arg_383_1.text_.text = var_386_7
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321092", "story_v_out_317321.awb") ~= 0 then
					local var_386_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321092", "story_v_out_317321.awb") / 1000

					if var_386_10 + var_386_4 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_10 + var_386_4
					end

					if var_386_6.prefab_name ~= "" and arg_383_1.actors_[var_386_6.prefab_name] ~= nil then
						local var_386_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_6.prefab_name].transform, "story_v_out_317321", "317321092", "story_v_out_317321.awb")

						arg_383_1:RecordAudio("317321092", var_386_11)
						arg_383_1:RecordAudio("317321092", var_386_11)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_317321", "317321092", "story_v_out_317321.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_317321", "317321092", "story_v_out_317321.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_12 = math.max(var_386_5, arg_383_1.talkMaxDuration)

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_12 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_4) / var_386_12

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_4 + var_386_12 and arg_383_1.time_ < var_386_4 + var_386_12 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play317321093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 317321093
		arg_387_1.duration_ = 10.53

		local var_387_0 = {
			zh = 7.866,
			ja = 10.533
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play317321094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1019ui_story = arg_387_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1019ui_story"].transform.position).z)
				arg_387_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1019ui_story"].transform.localEulerAngles = arg_387_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_387_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1019ui_story"].transform.position).z)
				arg_387_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1019ui_story"].transform.localEulerAngles = arg_387_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_390_1 = arg_387_1.actors_["1019ui_story"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1019ui_story == nil then
				arg_387_1.var_.characterEffect1019ui_story = var_390_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_2 and not isNil(var_390_1) then
				if arg_387_1.var_.characterEffect1019ui_story and not isNil(var_390_1) then
					arg_387_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_2 and arg_387_1.time_ < 0 + var_390_2 + arg_390_0 and not isNil(var_390_1) and arg_387_1.var_.characterEffect1019ui_story then
				arg_387_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_2")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_390_4 = 0
			local var_390_5 = 0.9

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_4 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_6 = arg_387_1:GetWordFromCfg(317321093)
				local var_390_7 = arg_387_1:FormatText(var_390_6.content)

				arg_387_1.text_.text = var_390_7

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_9 = 36 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 36)

				if (36 <= 0 and var_390_5 or var_390_5 * (utf8.len(var_390_7) / 36)) > 0 and var_390_5 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_4
					end
				end

				arg_387_1.text_.text = var_390_7
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321093", "story_v_out_317321.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321093", "story_v_out_317321.awb") / 1000

					if var_390_10 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_4
					end

					if var_390_6.prefab_name ~= "" and arg_387_1.actors_[var_390_6.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_6.prefab_name].transform, "story_v_out_317321", "317321093", "story_v_out_317321.awb")

						arg_387_1:RecordAudio("317321093", var_390_11)
						arg_387_1:RecordAudio("317321093", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_317321", "317321093", "story_v_out_317321.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_317321", "317321093", "story_v_out_317321.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_12 = math.max(var_390_5, arg_387_1.talkMaxDuration)

			if var_390_4 <= arg_387_1.time_ and arg_387_1.time_ < var_390_4 + var_390_12 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_4) / var_390_12

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_4 + var_390_12 and arg_387_1.time_ < var_390_4 + var_390_12 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play317321094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 317321094
		arg_391_1.duration_ = 6.87

		local var_391_0 = {
			zh = 6.666,
			ja = 6.866
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play317321095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1029ui_story = arg_391_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1029ui_story"].transform.position).z)
				arg_391_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1029ui_story"].transform.localEulerAngles = arg_391_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_391_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1029ui_story"].transform.position).z)
				arg_391_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1029ui_story"].transform.localEulerAngles = arg_391_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_394_1 = arg_391_1.actors_["1029ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1029ui_story == nil then
				arg_391_1.var_.characterEffect1029ui_story = var_394_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 and not isNil(var_394_1) then
				if arg_391_1.var_.characterEffect1029ui_story and not isNil(var_394_1) then
					arg_391_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1029ui_story then
				arg_391_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action4_1")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_394_4 = arg_391_1.actors_["1019ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_4) and arg_391_1.var_.characterEffect1019ui_story == nil then
				arg_391_1.var_.characterEffect1019ui_story = var_394_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_5 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_5 and not isNil(var_394_4) then
				if arg_391_1.var_.characterEffect1019ui_story and not isNil(var_394_4) then
					arg_391_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_5)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_5 and arg_391_1.time_ < 0 + var_394_5 + arg_394_0 and not isNil(var_394_4) and arg_391_1.var_.characterEffect1019ui_story then
				arg_391_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_394_6 = 0
			local var_394_7 = 0.775

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_8 = arg_391_1:GetWordFromCfg(317321094)
				local var_394_9 = arg_391_1:FormatText(var_394_8.content)

				arg_391_1.text_.text = var_394_9

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 31 <= 0 and var_394_7 or var_394_7 * (utf8.len(var_394_9) / 31)

				if (31 <= 0 and var_394_7 or var_394_7 * (utf8.len(var_394_9) / 31)) > 0 and var_394_7 < var_394_11 then
					arg_391_1.talkMaxDuration = var_394_11

					if var_394_11 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_11 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_9
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321094", "story_v_out_317321.awb") ~= 0 then
					local var_394_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321094", "story_v_out_317321.awb") / 1000

					if var_394_12 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_12 + var_394_6
					end

					if var_394_8.prefab_name ~= "" and arg_391_1.actors_[var_394_8.prefab_name] ~= nil then
						local var_394_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_8.prefab_name].transform, "story_v_out_317321", "317321094", "story_v_out_317321.awb")

						arg_391_1:RecordAudio("317321094", var_394_13)
						arg_391_1:RecordAudio("317321094", var_394_13)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_317321", "317321094", "story_v_out_317321.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_317321", "317321094", "story_v_out_317321.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_14 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 <= arg_391_1.time_ and arg_391_1.time_ < var_394_6 + var_394_14 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_6) / var_394_14

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_6 + var_394_14 and arg_391_1.time_ < var_394_6 + var_394_14 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play317321095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 317321095
		arg_395_1.duration_ = 6.4

		local var_395_0 = {
			zh = 4.1,
			ja = 6.4
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play317321096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.35

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:GetWordFromCfg(317321095)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 15 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 15)

				if (15 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 15)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321095", "story_v_out_317321.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321095", "story_v_out_317321.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_out_317321", "317321095", "story_v_out_317321.awb")

						arg_395_1:RecordAudio("317321095", var_398_6)
						arg_395_1:RecordAudio("317321095", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_317321", "317321095", "story_v_out_317321.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_317321", "317321095", "story_v_out_317321.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play317321096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 317321096
		arg_399_1.duration_ = 2

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play317321097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1019ui_story = arg_399_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1019ui_story"].transform.position).z)
				arg_399_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1019ui_story"].transform.localEulerAngles = arg_399_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_399_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1019ui_story"].transform.position).z)
				arg_399_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1019ui_story"].transform.localEulerAngles = arg_399_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_402_1 = arg_399_1.actors_["1019ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1019ui_story == nil then
				arg_399_1.var_.characterEffect1019ui_story = var_402_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_2 and not isNil(var_402_1) then
				if arg_399_1.var_.characterEffect1019ui_story and not isNil(var_402_1) then
					arg_399_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_2 and arg_399_1.time_ < 0 + var_402_2 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1019ui_story then
				arg_399_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_402_4 = 0
			local var_402_5 = 0.075

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_4 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_6 = arg_399_1:GetWordFromCfg(317321096)
				local var_402_7 = arg_399_1:FormatText(var_402_6.content)

				arg_399_1.text_.text = var_402_7

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_9 = 3 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 3)

				if (3 <= 0 and var_402_5 or var_402_5 * (utf8.len(var_402_7) / 3)) > 0 and var_402_5 < var_402_9 then
					arg_399_1.talkMaxDuration = var_402_9

					if var_402_9 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_9 + var_402_4
					end
				end

				arg_399_1.text_.text = var_402_7
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321096", "story_v_out_317321.awb") ~= 0 then
					local var_402_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321096", "story_v_out_317321.awb") / 1000

					if var_402_10 + var_402_4 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_4
					end

					if var_402_6.prefab_name ~= "" and arg_399_1.actors_[var_402_6.prefab_name] ~= nil then
						local var_402_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_6.prefab_name].transform, "story_v_out_317321", "317321096", "story_v_out_317321.awb")

						arg_399_1:RecordAudio("317321096", var_402_11)
						arg_399_1:RecordAudio("317321096", var_402_11)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_317321", "317321096", "story_v_out_317321.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_317321", "317321096", "story_v_out_317321.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_12 = math.max(var_402_5, arg_399_1.talkMaxDuration)

			if var_402_4 <= arg_399_1.time_ and arg_399_1.time_ < var_402_4 + var_402_12 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_4) / var_402_12

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_4 + var_402_12 and arg_399_1.time_ < var_402_4 + var_402_12 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_399_1:InitPlayNodeList()
	end,
	Play317321097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 317321097
		arg_403_1.duration_ = 6.17

		local var_403_0 = {
			zh = 4.233,
			ja = 6.166
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play317321098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1029ui_story = arg_403_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1029ui_story"].transform.position).z)
				arg_403_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1029ui_story"].transform.localEulerAngles = arg_403_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_403_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1029ui_story"].transform.position).z)
				arg_403_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1029ui_story"].transform.localEulerAngles = arg_403_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1029ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1029ui_story == nil then
				arg_403_1.var_.characterEffect1029ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1029ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1029ui_story then
				arg_403_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029actionlink/1029action447")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_4 = arg_403_1.actors_["1019ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_4) and arg_403_1.var_.characterEffect1019ui_story == nil then
				arg_403_1.var_.characterEffect1019ui_story = var_406_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_5 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_5 and not isNil(var_406_4) then
				if arg_403_1.var_.characterEffect1019ui_story and not isNil(var_406_4) then
					arg_403_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_5)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_5 and arg_403_1.time_ < 0 + var_406_5 + arg_406_0 and not isNil(var_406_4) and arg_403_1.var_.characterEffect1019ui_story then
				arg_403_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_406_6 = 0
			local var_406_7 = 0.275

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_6 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_8 = arg_403_1:GetWordFromCfg(317321097)
				local var_406_9 = arg_403_1:FormatText(var_406_8.content)

				arg_403_1.text_.text = var_406_9

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_11 = 11 <= 0 and var_406_7 or var_406_7 * (utf8.len(var_406_9) / 11)

				if (11 <= 0 and var_406_7 or var_406_7 * (utf8.len(var_406_9) / 11)) > 0 and var_406_7 < var_406_11 then
					arg_403_1.talkMaxDuration = var_406_11

					if var_406_11 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_11 + var_406_6
					end
				end

				arg_403_1.text_.text = var_406_9
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321097", "story_v_out_317321.awb") ~= 0 then
					local var_406_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321097", "story_v_out_317321.awb") / 1000

					if var_406_12 + var_406_6 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_12 + var_406_6
					end

					if var_406_8.prefab_name ~= "" and arg_403_1.actors_[var_406_8.prefab_name] ~= nil then
						local var_406_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_8.prefab_name].transform, "story_v_out_317321", "317321097", "story_v_out_317321.awb")

						arg_403_1:RecordAudio("317321097", var_406_13)
						arg_403_1:RecordAudio("317321097", var_406_13)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_317321", "317321097", "story_v_out_317321.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_317321", "317321097", "story_v_out_317321.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_14 = math.max(var_406_7, arg_403_1.talkMaxDuration)

			if var_406_6 <= arg_403_1.time_ and arg_403_1.time_ < var_406_6 + var_406_14 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_6) / var_406_14

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_6 + var_406_14 and arg_403_1.time_ < var_406_6 + var_406_14 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play317321098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 317321098
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play317321099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1029ui_story"]) and arg_407_1.var_.characterEffect1029ui_story == nil then
				arg_407_1.var_.characterEffect1029ui_story = arg_407_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1029ui_story"]) then
				if arg_407_1.var_.characterEffect1029ui_story and not isNil(arg_407_1.actors_["1029ui_story"]) then
					arg_407_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_0)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1029ui_story"]) and arg_407_1.var_.characterEffect1029ui_story then
				arg_407_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_410_1 = 0
			local var_410_2 = 1

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_3 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(317321098).content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 40 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 40)

				if (40 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 40)) > 0 and var_410_2 < var_410_5 then
					arg_407_1.talkMaxDuration = var_410_5

					if var_410_5 + var_410_1 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + var_410_1
					end
				end

				arg_407_1.text_.text = var_410_3
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_6 = math.max(var_410_2, arg_407_1.talkMaxDuration)

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_6 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_1) / var_410_6

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_1 + var_410_6 and arg_407_1.time_ < var_410_1 + var_410_6 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play317321099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 317321099
		arg_411_1.duration_ = 11

		local var_411_0 = {
			zh = 8.633,
			ja = 11
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play317321100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1029ui_story = arg_411_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_414_0 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 then
				arg_411_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_411_1.time_ - 0) / var_414_0)
				arg_411_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1029ui_story"].transform.position).z)
				arg_411_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1029ui_story"].transform.localEulerAngles = arg_411_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 then
				arg_411_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_411_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_411_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_411_1.actors_["1029ui_story"].transform.position).z)
				arg_411_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_411_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_411_1.actors_["1029ui_story"].transform.localEulerAngles = arg_411_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_414_1 = arg_411_1.actors_["1029ui_story"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1029ui_story == nil then
				arg_411_1.var_.characterEffect1029ui_story = var_414_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_2 and not isNil(var_414_1) then
				if arg_411_1.var_.characterEffect1029ui_story and not isNil(var_414_1) then
					arg_411_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= 0 + var_414_2 and arg_411_1.time_ < 0 + var_414_2 + arg_414_0 and not isNil(var_414_1) and arg_411_1.var_.characterEffect1029ui_story then
				arg_411_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action7_2")
			end

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_414_4 = 0
			local var_414_5 = 1.15

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_6 = arg_411_1:GetWordFromCfg(317321099)
				local var_414_7 = arg_411_1:FormatText(var_414_6.content)

				arg_411_1.text_.text = var_414_7

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_9 = 46 <= 0 and var_414_5 or var_414_5 * (utf8.len(var_414_7) / 46)

				if (46 <= 0 and var_414_5 or var_414_5 * (utf8.len(var_414_7) / 46)) > 0 and var_414_5 < var_414_9 then
					arg_411_1.talkMaxDuration = var_414_9

					if var_414_9 + var_414_4 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_9 + var_414_4
					end
				end

				arg_411_1.text_.text = var_414_7
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321099", "story_v_out_317321.awb") ~= 0 then
					local var_414_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321099", "story_v_out_317321.awb") / 1000

					if var_414_10 + var_414_4 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_10 + var_414_4
					end

					if var_414_6.prefab_name ~= "" and arg_411_1.actors_[var_414_6.prefab_name] ~= nil then
						local var_414_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_6.prefab_name].transform, "story_v_out_317321", "317321099", "story_v_out_317321.awb")

						arg_411_1:RecordAudio("317321099", var_414_11)
						arg_411_1:RecordAudio("317321099", var_414_11)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_317321", "317321099", "story_v_out_317321.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_317321", "317321099", "story_v_out_317321.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_12 = math.max(var_414_5, arg_411_1.talkMaxDuration)

			if var_414_4 <= arg_411_1.time_ and arg_411_1.time_ < var_414_4 + var_414_12 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_4) / var_414_12

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_4 + var_414_12 and arg_411_1.time_ < var_414_4 + var_414_12 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play317321100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 317321100
		arg_415_1.duration_ = 9.9

		local var_415_0 = {
			zh = 5.6,
			ja = 9.9
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play317321101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.725

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:GetWordFromCfg(317321100)
				local var_418_2 = arg_415_1:FormatText(var_418_1.content)

				arg_415_1.text_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 29 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 29)

				if (29 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 29)) > 0 and var_418_0 < var_418_4 then
					arg_415_1.talkMaxDuration = var_418_4

					if var_418_4 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_4 + 0
					end
				end

				arg_415_1.text_.text = var_418_2
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321100", "story_v_out_317321.awb") ~= 0 then
					local var_418_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321100", "story_v_out_317321.awb") / 1000

					if var_418_5 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + 0
					end

					if var_418_1.prefab_name ~= "" and arg_415_1.actors_[var_418_1.prefab_name] ~= nil then
						local var_418_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_1.prefab_name].transform, "story_v_out_317321", "317321100", "story_v_out_317321.awb")

						arg_415_1:RecordAudio("317321100", var_418_6)
						arg_415_1:RecordAudio("317321100", var_418_6)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_317321", "317321100", "story_v_out_317321.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_317321", "317321100", "story_v_out_317321.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play317321101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 317321101
		arg_419_1.duration_ = 6.2

		local var_419_0 = {
			zh = 1.999999999999,
			ja = 6.2
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play317321102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1019ui_story = arg_419_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1019ui_story"].transform.position).z)
				arg_419_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1019ui_story"].transform.localEulerAngles = arg_419_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_419_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1019ui_story"].transform.position).z)
				arg_419_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1019ui_story"].transform.localEulerAngles = arg_419_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["1019ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1019ui_story == nil then
				arg_419_1.var_.characterEffect1019ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect1019ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1019ui_story then
				arg_419_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_2")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_422_4 = arg_419_1.actors_["1029ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_4) and arg_419_1.var_.characterEffect1029ui_story == nil then
				arg_419_1.var_.characterEffect1029ui_story = var_422_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_5 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_5 and not isNil(var_422_4) then
				if arg_419_1.var_.characterEffect1029ui_story and not isNil(var_422_4) then
					arg_419_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_5)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_5 and arg_419_1.time_ < 0 + var_422_5 + arg_422_0 and not isNil(var_422_4) and arg_419_1.var_.characterEffect1029ui_story then
				arg_419_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_422_6 = 0
			local var_422_7 = 0.125

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_6 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_8 = arg_419_1:GetWordFromCfg(317321101)
				local var_422_9 = arg_419_1:FormatText(var_422_8.content)

				arg_419_1.text_.text = var_422_9

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_11 = 5 <= 0 and var_422_7 or var_422_7 * (utf8.len(var_422_9) / 5)

				if (5 <= 0 and var_422_7 or var_422_7 * (utf8.len(var_422_9) / 5)) > 0 and var_422_7 < var_422_11 then
					arg_419_1.talkMaxDuration = var_422_11

					if var_422_11 + var_422_6 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_11 + var_422_6
					end
				end

				arg_419_1.text_.text = var_422_9
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321101", "story_v_out_317321.awb") ~= 0 then
					local var_422_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321101", "story_v_out_317321.awb") / 1000

					if var_422_12 + var_422_6 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_12 + var_422_6
					end

					if var_422_8.prefab_name ~= "" and arg_419_1.actors_[var_422_8.prefab_name] ~= nil then
						local var_422_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_8.prefab_name].transform, "story_v_out_317321", "317321101", "story_v_out_317321.awb")

						arg_419_1:RecordAudio("317321101", var_422_13)
						arg_419_1:RecordAudio("317321101", var_422_13)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_317321", "317321101", "story_v_out_317321.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_317321", "317321101", "story_v_out_317321.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_14 = math.max(var_422_7, arg_419_1.talkMaxDuration)

			if var_422_6 <= arg_419_1.time_ and arg_419_1.time_ < var_422_6 + var_422_14 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_6) / var_422_14

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_6 + var_422_14 and arg_419_1.time_ < var_422_6 + var_422_14 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play317321102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 317321102
		arg_423_1.duration_ = 9.7

		local var_423_0 = {
			zh = 3.7,
			ja = 9.7
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play317321103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1029ui_story = arg_423_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1029ui_story"].transform.position).z)
				arg_423_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1029ui_story"].transform.localEulerAngles = arg_423_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_423_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1029ui_story"].transform.position).z)
				arg_423_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1029ui_story"].transform.localEulerAngles = arg_423_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1029ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1029ui_story == nil then
				arg_423_1.var_.characterEffect1029ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1029ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1029ui_story then
				arg_423_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_426_4 = arg_423_1.actors_["1019ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_4) and arg_423_1.var_.characterEffect1019ui_story == nil then
				arg_423_1.var_.characterEffect1019ui_story = var_426_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_5 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_5 and not isNil(var_426_4) then
				if arg_423_1.var_.characterEffect1019ui_story and not isNil(var_426_4) then
					arg_423_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_5)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_5 and arg_423_1.time_ < 0 + var_426_5 + arg_426_0 and not isNil(var_426_4) and arg_423_1.var_.characterEffect1019ui_story then
				arg_423_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_426_6 = 0
			local var_426_7 = 0.475

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_8 = arg_423_1:GetWordFromCfg(317321102)
				local var_426_9 = arg_423_1:FormatText(var_426_8.content)

				arg_423_1.text_.text = var_426_9

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_11 = 19 <= 0 and var_426_7 or var_426_7 * (utf8.len(var_426_9) / 19)

				if (19 <= 0 and var_426_7 or var_426_7 * (utf8.len(var_426_9) / 19)) > 0 and var_426_7 < var_426_11 then
					arg_423_1.talkMaxDuration = var_426_11

					if var_426_11 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_11 + var_426_6
					end
				end

				arg_423_1.text_.text = var_426_9
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321102", "story_v_out_317321.awb") ~= 0 then
					local var_426_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321102", "story_v_out_317321.awb") / 1000

					if var_426_12 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_12 + var_426_6
					end

					if var_426_8.prefab_name ~= "" and arg_423_1.actors_[var_426_8.prefab_name] ~= nil then
						local var_426_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_8.prefab_name].transform, "story_v_out_317321", "317321102", "story_v_out_317321.awb")

						arg_423_1:RecordAudio("317321102", var_426_13)
						arg_423_1:RecordAudio("317321102", var_426_13)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_317321", "317321102", "story_v_out_317321.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_317321", "317321102", "story_v_out_317321.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_14 = math.max(var_426_7, arg_423_1.talkMaxDuration)

			if var_426_6 <= arg_423_1.time_ and arg_423_1.time_ < var_426_6 + var_426_14 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_6) / var_426_14

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_6 + var_426_14 and arg_423_1.time_ < var_426_6 + var_426_14 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play317321103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 317321103
		arg_427_1.duration_ = 2

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play317321104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1019ui_story = arg_427_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1019ui_story"].transform.position).z)
				arg_427_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1019ui_story"].transform.localEulerAngles = arg_427_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				arg_427_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1019ui_story"].transform.position).z)
				arg_427_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1019ui_story"].transform.localEulerAngles = arg_427_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_430_1 = arg_427_1.actors_["1019ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1019ui_story == nil then
				arg_427_1.var_.characterEffect1019ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_2 and not isNil(var_430_1) then
				if arg_427_1.var_.characterEffect1019ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_2 and arg_427_1.time_ < 0 + var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1019ui_story then
				arg_427_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_430_4 = arg_427_1.actors_["1029ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_4) and arg_427_1.var_.characterEffect1029ui_story == nil then
				arg_427_1.var_.characterEffect1029ui_story = var_430_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_5 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_5 and not isNil(var_430_4) then
				if arg_427_1.var_.characterEffect1029ui_story and not isNil(var_430_4) then
					arg_427_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_5)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_5 and arg_427_1.time_ < 0 + var_430_5 + arg_430_0 and not isNil(var_430_4) and arg_427_1.var_.characterEffect1029ui_story then
				arg_427_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_430_6 = 0
			local var_430_7 = 0.1

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_8 = arg_427_1:GetWordFromCfg(317321103)
				local var_430_9 = arg_427_1:FormatText(var_430_8.content)

				arg_427_1.text_.text = var_430_9

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_11 = 4 <= 0 and var_430_7 or var_430_7 * (utf8.len(var_430_9) / 4)

				if (4 <= 0 and var_430_7 or var_430_7 * (utf8.len(var_430_9) / 4)) > 0 and var_430_7 < var_430_11 then
					arg_427_1.talkMaxDuration = var_430_11

					if var_430_11 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_11 + var_430_6
					end
				end

				arg_427_1.text_.text = var_430_9
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321103", "story_v_out_317321.awb") ~= 0 then
					local var_430_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321103", "story_v_out_317321.awb") / 1000

					if var_430_12 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_12 + var_430_6
					end

					if var_430_8.prefab_name ~= "" and arg_427_1.actors_[var_430_8.prefab_name] ~= nil then
						local var_430_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_8.prefab_name].transform, "story_v_out_317321", "317321103", "story_v_out_317321.awb")

						arg_427_1:RecordAudio("317321103", var_430_13)
						arg_427_1:RecordAudio("317321103", var_430_13)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_317321", "317321103", "story_v_out_317321.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_317321", "317321103", "story_v_out_317321.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_14 = math.max(var_430_7, arg_427_1.talkMaxDuration)

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_14 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_6) / var_430_14

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_6 + var_430_14 and arg_427_1.time_ < var_430_6 + var_430_14 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play317321104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 317321104
		arg_431_1.duration_ = 4.83

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play317321105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.var_.moveOldPos1029ui_story = arg_431_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_434_0 = 0.001

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				arg_431_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1029ui_story"].transform.position).z)
				arg_431_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1029ui_story"].transform.localEulerAngles = arg_431_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				arg_431_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0.7, -1.09, -6.2)
				arg_431_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_431_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_431_1.actors_["1029ui_story"].transform.position).z)
				arg_431_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_431_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_431_1.actors_["1029ui_story"].transform.localEulerAngles = arg_431_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_434_1 = arg_431_1.actors_["1029ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_1) and arg_431_1.var_.characterEffect1029ui_story == nil then
				arg_431_1.var_.characterEffect1029ui_story = var_434_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_2 and not isNil(var_434_1) then
				if arg_431_1.var_.characterEffect1029ui_story and not isNil(var_434_1) then
					arg_431_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_2 and arg_431_1.time_ < 0 + var_434_2 + arg_434_0 and not isNil(var_434_1) and arg_431_1.var_.characterEffect1029ui_story then
				arg_431_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action6_1")
			end

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_434_4 = arg_431_1.actors_["1019ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_4) and arg_431_1.var_.characterEffect1019ui_story == nil then
				arg_431_1.var_.characterEffect1019ui_story = var_434_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_5 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_5 and not isNil(var_434_4) then
				if arg_431_1.var_.characterEffect1019ui_story and not isNil(var_434_4) then
					arg_431_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_5)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_5 and arg_431_1.time_ < 0 + var_434_5 + arg_434_0 and not isNil(var_434_4) and arg_431_1.var_.characterEffect1019ui_story then
				arg_431_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_434_6 = 0
			local var_434_7 = 0.55

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_8 = arg_431_1:GetWordFromCfg(317321104)
				local var_434_9 = arg_431_1:FormatText(var_434_8.content)

				arg_431_1.text_.text = var_434_9

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 22 <= 0 and var_434_7 or var_434_7 * (utf8.len(var_434_9) / 22)

				if (22 <= 0 and var_434_7 or var_434_7 * (utf8.len(var_434_9) / 22)) > 0 and var_434_7 < var_434_11 then
					arg_431_1.talkMaxDuration = var_434_11

					if var_434_11 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_11 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_9
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321104", "story_v_out_317321.awb") ~= 0 then
					local var_434_12 = manager.audio:GetVoiceLength("story_v_out_317321", "317321104", "story_v_out_317321.awb") / 1000

					if var_434_12 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_12 + var_434_6
					end

					if var_434_8.prefab_name ~= "" and arg_431_1.actors_[var_434_8.prefab_name] ~= nil then
						local var_434_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_8.prefab_name].transform, "story_v_out_317321", "317321104", "story_v_out_317321.awb")

						arg_431_1:RecordAudio("317321104", var_434_13)
						arg_431_1:RecordAudio("317321104", var_434_13)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_317321", "317321104", "story_v_out_317321.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_317321", "317321104", "story_v_out_317321.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_14 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_14 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_14

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_14 and arg_431_1.time_ < var_434_6 + var_434_14 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play317321105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 317321105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play317321106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1019ui_story = arg_435_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_438_0 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 then
				arg_435_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_435_1.time_ - 0) / var_438_0)
				arg_435_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1019ui_story"].transform.position).z)
				arg_435_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1019ui_story"].transform.localEulerAngles = arg_435_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 then
				arg_435_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_435_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_435_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_435_1.actors_["1019ui_story"].transform.position).z)
				arg_435_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_435_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_435_1.actors_["1019ui_story"].transform.localEulerAngles = arg_435_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_438_1 = arg_435_1.actors_["1029ui_story"].transform

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1029ui_story = var_438_1.localPosition
			end

			local var_438_2 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_2 then
				var_438_1.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_435_1.time_ - 0) / var_438_2)
				var_438_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_1.position).x, (manager.ui.mainCamera.transform.position - var_438_1.position).y, (manager.ui.mainCamera.transform.position - var_438_1.position).z)
				var_438_1.localEulerAngles.z = 0
				var_438_1.localEulerAngles.x = 0
				var_438_1.localEulerAngles = var_438_1.localEulerAngles
			end

			if arg_435_1.time_ >= 0 + var_438_2 and arg_435_1.time_ < 0 + var_438_2 + arg_438_0 then
				var_438_1.localPosition = Vector3.New(0, 100, 0)
				var_438_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_438_1.position).x, (manager.ui.mainCamera.transform.position - var_438_1.position).y, (manager.ui.mainCamera.transform.position - var_438_1.position).z)
				var_438_1.localEulerAngles.z = 0
				var_438_1.localEulerAngles.x = 0
				var_438_1.localEulerAngles = var_438_1.localEulerAngles
			end

			local var_438_3 = 0
			local var_438_4 = 0.925

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_3 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_5 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(317321105).content)

				arg_435_1.text_.text = var_438_5

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_7 = 37 <= 0 and var_438_4 or var_438_4 * (utf8.len(var_438_5) / 37)

				if (37 <= 0 and var_438_4 or var_438_4 * (utf8.len(var_438_5) / 37)) > 0 and var_438_4 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_3 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_3
					end
				end

				arg_435_1.text_.text = var_438_5
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_8 = math.max(var_438_4, arg_435_1.talkMaxDuration)

			if var_438_3 <= arg_435_1.time_ and arg_435_1.time_ < var_438_3 + var_438_8 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_3) / var_438_8

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_3 + var_438_8 and arg_435_1.time_ < var_438_3 + var_438_8 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play317321106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 317321106
		arg_439_1.duration_ = 6.87

		local var_439_0 = {
			zh = 4.3,
			ja = 6.866
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play317321107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.475

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_1 = arg_439_1:GetWordFromCfg(317321106)
				local var_442_2 = arg_439_1:FormatText(var_442_1.content)

				arg_439_1.text_.text = var_442_2

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 17 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 17)

				if (17 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 17)) > 0 and var_442_0 < var_442_4 then
					arg_439_1.talkMaxDuration = var_442_4

					if var_442_4 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_4 + 0
					end
				end

				arg_439_1.text_.text = var_442_2
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321106", "story_v_out_317321.awb") ~= 0 then
					local var_442_5 = manager.audio:GetVoiceLength("story_v_out_317321", "317321106", "story_v_out_317321.awb") / 1000

					if var_442_5 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + 0
					end

					if var_442_1.prefab_name ~= "" and arg_439_1.actors_[var_442_1.prefab_name] ~= nil then
						local var_442_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_1.prefab_name].transform, "story_v_out_317321", "317321106", "story_v_out_317321.awb")

						arg_439_1:RecordAudio("317321106", var_442_6)
						arg_439_1:RecordAudio("317321106", var_442_6)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_317321", "317321106", "story_v_out_317321.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_317321", "317321106", "story_v_out_317321.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_7 and arg_439_1.time_ < 0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play317321107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 317321107
		arg_443_1.duration_ = 4.67

		local var_443_0 = {
			zh = 1.999999999999,
			ja = 4.666
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play317321108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.var_.moveOldPos1019ui_story = arg_443_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_446_0 = 0.001

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 then
				arg_443_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_443_1.time_ - 0) / var_446_0)
				arg_443_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).z)
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles = arg_443_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 then
				arg_443_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_443_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_443_1.actors_["1019ui_story"].transform.position).z)
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_443_1.actors_["1019ui_story"].transform.localEulerAngles = arg_443_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_446_1 = arg_443_1.actors_["1019ui_story"]

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1019ui_story == nil then
				arg_443_1.var_.characterEffect1019ui_story = var_446_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_2 and not isNil(var_446_1) then
				if arg_443_1.var_.characterEffect1019ui_story and not isNil(var_446_1) then
					arg_443_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= 0 + var_446_2 and arg_443_1.time_ < 0 + var_446_2 + arg_446_0 and not isNil(var_446_1) and arg_443_1.var_.characterEffect1019ui_story then
				arg_443_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_446_4 = 0
			local var_446_5 = 0.2

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_4 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_6 = arg_443_1:GetWordFromCfg(317321107)
				local var_446_7 = arg_443_1:FormatText(var_446_6.content)

				arg_443_1.text_.text = var_446_7

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_9 = 8 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 8)

				if (8 <= 0 and var_446_5 or var_446_5 * (utf8.len(var_446_7) / 8)) > 0 and var_446_5 < var_446_9 then
					arg_443_1.talkMaxDuration = var_446_9

					if var_446_9 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_9 + var_446_4
					end
				end

				arg_443_1.text_.text = var_446_7
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321107", "story_v_out_317321.awb") ~= 0 then
					local var_446_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321107", "story_v_out_317321.awb") / 1000

					if var_446_10 + var_446_4 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_10 + var_446_4
					end

					if var_446_6.prefab_name ~= "" and arg_443_1.actors_[var_446_6.prefab_name] ~= nil then
						local var_446_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_6.prefab_name].transform, "story_v_out_317321", "317321107", "story_v_out_317321.awb")

						arg_443_1:RecordAudio("317321107", var_446_11)
						arg_443_1:RecordAudio("317321107", var_446_11)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_317321", "317321107", "story_v_out_317321.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_317321", "317321107", "story_v_out_317321.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_12 = math.max(var_446_5, arg_443_1.talkMaxDuration)

			if var_446_4 <= arg_443_1.time_ and arg_443_1.time_ < var_446_4 + var_446_12 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_4) / var_446_12

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_4 + var_446_12 and arg_443_1.time_ < var_446_4 + var_446_12 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play317321108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 317321108
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play317321109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.var_.moveOldPos1019ui_story = arg_447_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_450_0 = 0.001

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 then
				arg_447_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_447_1.time_ - 0) / var_450_0)
				arg_447_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1019ui_story"].transform.position).z)
				arg_447_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1019ui_story"].transform.localEulerAngles = arg_447_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 then
				arg_447_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_447_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_447_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_447_1.actors_["1019ui_story"].transform.position).z)
				arg_447_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_447_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_447_1.actors_["1019ui_story"].transform.localEulerAngles = arg_447_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_450_1 = 0
			local var_450_2 = 0.6

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(317321108).content)

				arg_447_1.text_.text = var_450_3

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 24 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 24)

				if (24 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 24)) > 0 and var_450_2 < var_450_5 then
					arg_447_1.talkMaxDuration = var_450_5

					if var_450_5 + var_450_1 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + var_450_1
					end
				end

				arg_447_1.text_.text = var_450_3
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_6 = math.max(var_450_2, arg_447_1.talkMaxDuration)

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_6 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_1) / var_450_6

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_1 + var_450_6 and arg_447_1.time_ < var_450_1 + var_450_6 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play317321109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 317321109
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play317321110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 1.075

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, false)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(317321109).content)

				arg_451_1.text_.text = var_454_1

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_3 = 43 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 43)

				if (43 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 43)) > 0 and var_454_0 < var_454_3 then
					arg_451_1.talkMaxDuration = var_454_3

					if var_454_3 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_3 + 0
					end
				end

				arg_451_1.text_.text = var_454_1
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_4 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_4

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play317321110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 317321110
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play317321111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = 0.475

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, false)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_1 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(317321110).content)

				arg_455_1.text_.text = var_458_1

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_3 = 19 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 19)

				if (19 <= 0 and var_458_0 or var_458_0 * (utf8.len(var_458_1) / 19)) > 0 and var_458_0 < var_458_3 then
					arg_455_1.talkMaxDuration = var_458_3

					if var_458_3 + 0 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_3 + 0
					end
				end

				arg_455_1.text_.text = var_458_1
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_4 = math.max(var_458_0, arg_455_1.talkMaxDuration)

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_4 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - 0) / var_458_4

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= 0 + var_458_4 and arg_455_1.time_ < 0 + var_458_4 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play317321111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 317321111
		arg_459_1.duration_ = 3.03

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play317321112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.fswbg_:SetActive(true)
				arg_459_1.dialog_:SetActive(false)

				arg_459_1.fswtw_.percent = 0
				arg_459_1.fswt_.text = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(317321111).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.fswt_)

				arg_459_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_459_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_459_1.fswtw_:SetDirty()

				arg_459_1.typewritterCharCountI18N = 0

				SetActive(arg_459_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_459_1:ShowNextGo(false)
			end

			local var_462_0 = 0.033

			if 0.033 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.var_.oldValueTypewriter = arg_459_1.fswtw_.percent

				SetActive(arg_459_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_459_1:ShowNextGo(false)
			end

			local var_462_1 = 13
			local var_462_2 = 3
			local var_462_3, var_462_4 = arg_459_1:GetPercentByPara(arg_459_1:FormatText(arg_459_1:GetWordFromCfg(317321111).content), 1)

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0

				local var_462_5 = var_462_1 <= 0 and var_462_2 or var_462_2 * ((var_462_4 - arg_459_1.typewritterCharCountI18N) / var_462_1)

				if (var_462_1 <= 0 and var_462_2 or var_462_2 * ((var_462_4 - arg_459_1.typewritterCharCountI18N) / var_462_1)) > 0 and var_462_2 < var_462_5 then
					arg_459_1.talkMaxDuration = var_462_5

					if var_462_5 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + var_462_0
					end
				end
			end

			local var_462_6 = math.max(3, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_6 then
				arg_459_1.fswtw_.percent = Mathf.Lerp(arg_459_1.var_.oldValueTypewriter, var_462_3, (arg_459_1.time_ - var_462_0) / var_462_6)
				arg_459_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_459_1.fswtw_:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_6 and arg_459_1.time_ < var_462_0 + var_462_6 + arg_462_0 then
				arg_459_1.fswtw_.percent = var_462_3

				arg_459_1.fswtw_:SetDirty()
				arg_459_1:ShowNextGo(true)

				arg_459_1.typewritterCharCountI18N = var_462_4
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play317321112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 317321112
		arg_463_1.duration_ = 3

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play317321113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.var_.oldValueTypewriter = arg_463_1.fswtw_.percent

				SetActive(arg_463_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_463_1:ShowNextGo(false)
			end

			local var_466_0 = 41
			local var_466_1 = 3
			local var_466_2, var_466_3 = arg_463_1:GetPercentByPara(arg_463_1:FormatText(arg_463_1:GetWordFromCfg(317321111).content), 2)

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0

				local var_466_4 = var_466_0 <= 0 and var_466_1 or var_466_1 * ((var_466_3 - arg_463_1.typewritterCharCountI18N) / var_466_0)

				if (var_466_0 <= 0 and var_466_1 or var_466_1 * ((var_466_3 - arg_463_1.typewritterCharCountI18N) / var_466_0)) > 0 and var_466_1 < var_466_4 then
					arg_463_1.talkMaxDuration = var_466_4

					if var_466_4 + 0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_4 + 0
					end
				end
			end

			local var_466_5 = math.max(3, arg_463_1.talkMaxDuration)

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_5 then
				arg_463_1.fswtw_.percent = Mathf.Lerp(arg_463_1.var_.oldValueTypewriter, var_466_2, (arg_463_1.time_ - 0) / var_466_5)
				arg_463_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_463_1.fswtw_:SetDirty()
			end

			if arg_463_1.time_ >= 0 + var_466_5 and arg_463_1.time_ < 0 + var_466_5 + arg_466_0 then
				arg_463_1.fswtw_.percent = var_466_2

				arg_463_1.fswtw_:SetDirty()
				arg_463_1:ShowNextGo(true)

				arg_463_1.typewritterCharCountI18N = var_466_3
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play317321113 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 317321113
		arg_467_1.duration_ = 3

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play317321114(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.var_.oldValueTypewriter = arg_467_1.fswtw_.percent

				SetActive(arg_467_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_467_1:ShowNextGo(false)
			end

			local var_470_0 = 20
			local var_470_1 = 3
			local var_470_2, var_470_3 = arg_467_1:GetPercentByPara(arg_467_1:FormatText(arg_467_1:GetWordFromCfg(317321111).content), 3)

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0

				local var_470_4 = var_470_0 <= 0 and var_470_1 or var_470_1 * ((var_470_3 - arg_467_1.typewritterCharCountI18N) / var_470_0)

				if (var_470_0 <= 0 and var_470_1 or var_470_1 * ((var_470_3 - arg_467_1.typewritterCharCountI18N) / var_470_0)) > 0 and var_470_1 < var_470_4 then
					arg_467_1.talkMaxDuration = var_470_4

					if var_470_4 + 0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_4 + 0
					end
				end
			end

			local var_470_5 = math.max(3, arg_467_1.talkMaxDuration)

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_5 then
				arg_467_1.fswtw_.percent = Mathf.Lerp(arg_467_1.var_.oldValueTypewriter, var_470_2, (arg_467_1.time_ - 0) / var_470_5)
				arg_467_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_467_1.fswtw_:SetDirty()
			end

			if arg_467_1.time_ >= 0 + var_470_5 and arg_467_1.time_ < 0 + var_470_5 + arg_470_0 then
				arg_467_1.fswtw_.percent = var_470_2

				arg_467_1.fswtw_:SetDirty()
				arg_467_1:ShowNextGo(true)

				arg_467_1.typewritterCharCountI18N = var_470_3
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play317321114 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 317321114
		arg_471_1.duration_ = 5

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play317321115(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 then
				arg_471_1.fswbg_:SetActive(false)
				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_471_1:ShowNextGo(false)
			end

			local var_474_0 = 0
			local var_474_1 = 1

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_0 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, false)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_2 = arg_471_1:FormatText(arg_471_1:GetWordFromCfg(317321114).content)

				arg_471_1.text_.text = var_474_2

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_4 = 40 <= 0 and var_474_1 or var_474_1 * (utf8.len(var_474_2) / 40)

				if (40 <= 0 and var_474_1 or var_474_1 * (utf8.len(var_474_2) / 40)) > 0 and var_474_1 < var_474_4 then
					arg_471_1.talkMaxDuration = var_474_4

					if var_474_4 + var_474_0 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_4 + var_474_0
					end
				end

				arg_471_1.text_.text = var_474_2
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)
				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_5 = math.max(var_474_1, arg_471_1.talkMaxDuration)

			if var_474_0 <= arg_471_1.time_ and arg_471_1.time_ < var_474_0 + var_474_5 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_0) / var_474_5

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_0 + var_474_5 and arg_471_1.time_ < var_474_0 + var_474_5 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play317321115 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 317321115
		arg_475_1.duration_ = 5

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play317321116(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 1.35

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, false)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_1 = arg_475_1:FormatText(arg_475_1:GetWordFromCfg(317321115).content)

				arg_475_1.text_.text = var_478_1

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_3 = 54 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 54)

				if (54 <= 0 and var_478_0 or var_478_0 * (utf8.len(var_478_1) / 54)) > 0 and var_478_0 < var_478_3 then
					arg_475_1.talkMaxDuration = var_478_3

					if var_478_3 + 0 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_3 + 0
					end
				end

				arg_475_1.text_.text = var_478_1
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)
				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_4 = math.max(var_478_0, arg_475_1.talkMaxDuration)

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - 0) / var_478_4

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play317321116 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 317321116
		arg_479_1.duration_ = 3.87

		local var_479_0 = {
			zh = 3.866,
			ja = 3.233
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play317321117(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos1019ui_story = arg_479_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_482_0 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 then
				arg_479_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_479_1.time_ - 0) / var_482_0)
				arg_479_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1019ui_story"].transform.position).z)
				arg_479_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1019ui_story"].transform.localEulerAngles = arg_479_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 then
				arg_479_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_479_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_479_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_479_1.actors_["1019ui_story"].transform.position).z)
				arg_479_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_479_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_479_1.actors_["1019ui_story"].transform.localEulerAngles = arg_479_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_482_1 = arg_479_1.actors_["1019ui_story"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1019ui_story == nil then
				arg_479_1.var_.characterEffect1019ui_story = var_482_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_482_2 = 0.200000002980232

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_2 and not isNil(var_482_1) then
				if arg_479_1.var_.characterEffect1019ui_story and not isNil(var_482_1) then
					arg_479_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_479_1.time_ >= 0 + var_482_2 and arg_479_1.time_ < 0 + var_482_2 + arg_482_0 and not isNil(var_482_1) and arg_479_1.var_.characterEffect1019ui_story then
				arg_479_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_482_4 = 0
			local var_482_5 = 0.4

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_4 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_6 = arg_479_1:GetWordFromCfg(317321116)
				local var_482_7 = arg_479_1:FormatText(var_482_6.content)

				arg_479_1.text_.text = var_482_7

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_9 = 16 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 16)

				if (16 <= 0 and var_482_5 or var_482_5 * (utf8.len(var_482_7) / 16)) > 0 and var_482_5 < var_482_9 then
					arg_479_1.talkMaxDuration = var_482_9

					if var_482_9 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_9 + var_482_4
					end
				end

				arg_479_1.text_.text = var_482_7
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317321", "317321116", "story_v_out_317321.awb") ~= 0 then
					local var_482_10 = manager.audio:GetVoiceLength("story_v_out_317321", "317321116", "story_v_out_317321.awb") / 1000

					if var_482_10 + var_482_4 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_4
					end

					if var_482_6.prefab_name ~= "" and arg_479_1.actors_[var_482_6.prefab_name] ~= nil then
						local var_482_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_6.prefab_name].transform, "story_v_out_317321", "317321116", "story_v_out_317321.awb")

						arg_479_1:RecordAudio("317321116", var_482_11)
						arg_479_1:RecordAudio("317321116", var_482_11)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_317321", "317321116", "story_v_out_317321.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_317321", "317321116", "story_v_out_317321.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_12 = math.max(var_482_5, arg_479_1.talkMaxDuration)

			if var_482_4 <= arg_479_1.time_ and arg_479_1.time_ < var_482_4 + var_482_12 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_4) / var_482_12

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_4 + var_482_12 and arg_479_1.time_ < var_482_4 + var_482_12 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play317321117 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 317321117
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play317321118(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos1019ui_story = arg_483_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_486_0 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 then
				arg_483_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_483_1.time_ - 0) / var_486_0)
				arg_483_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1019ui_story"].transform.position).z)
				arg_483_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["1019ui_story"].transform.localEulerAngles = arg_483_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 then
				arg_483_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_483_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_483_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_483_1.actors_["1019ui_story"].transform.position).z)
				arg_483_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_483_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_483_1.actors_["1019ui_story"].transform.localEulerAngles = arg_483_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1:AudioAction("play", "effect", "se_story_127", "se_story_127_message", "")
			end

			local var_486_2 = 0
			local var_486_3 = 1.425

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_2 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_4 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(317321117).content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_6 = 57 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_4) / 57)

				if (57 <= 0 and var_486_3 or var_486_3 * (utf8.len(var_486_4) / 57)) > 0 and var_486_3 < var_486_6 then
					arg_483_1.talkMaxDuration = var_486_6

					if var_486_6 + var_486_2 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_6 + var_486_2
					end
				end

				arg_483_1.text_.text = var_486_4
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_7 = math.max(var_486_3, arg_483_1.talkMaxDuration)

			if var_486_2 <= arg_483_1.time_ and arg_483_1.time_ < var_486_2 + var_486_7 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_2) / var_486_7

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_2 + var_486_7 and arg_483_1.time_ < var_486_2 + var_486_7 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play317321118 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 317321118
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play317321119(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.5

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:FormatText(arg_487_1:GetWordFromCfg(317321118).content)

				arg_487_1.text_.text = var_490_1

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_3 = 20 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 20)

				if (20 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_1) / 20)) > 0 and var_490_0 < var_490_3 then
					arg_487_1.talkMaxDuration = var_490_3

					if var_490_3 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_3 + 0
					end
				end

				arg_487_1.text_.text = var_490_1
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_4 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_4

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play317321119 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 317321119
		arg_491_1.duration_ = 5.88

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
			arg_491_1.auto_ = false
		end

		function arg_491_1.playNext_(arg_493_0)
			arg_491_1.onStoryFinished_()
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if arg_491_1.bgs_.STblack == nil then
				local var_494_0 = Object.Instantiate(arg_491_1.paintGo_)

				var_494_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_494_0.name = "STblack"
				var_494_0.transform.parent = arg_491_1.stage_.transform
				var_494_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_491_1.bgs_.STblack = var_494_0
			end

			if 2 < arg_491_1.time_ and arg_491_1.time_ <= 2 + arg_494_0 then
				local var_494_1 = arg_491_1.bgs_.STblack

				arg_491_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_494_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_494_2 = var_494_1:GetComponent("SpriteRenderer")

				if var_494_2 and var_494_2.sprite then
					local var_494_3 = 2 * (var_494_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_494_1.transform.localScale = Vector3.New(var_494_3 / var_494_2.sprite.bounds.size.y < var_494_3 * manager.ui.mainCameraCom_.aspect / var_494_2.sprite.bounds.size.x and var_494_3 * manager.ui.mainCameraCom_.aspect / var_494_2.sprite.bounds.size.x or var_494_3 / var_494_2.sprite.bounds.size.y, var_494_3 / var_494_2.sprite.bounds.size.y < var_494_3 * manager.ui.mainCameraCom_.aspect / var_494_2.sprite.bounds.size.x and var_494_3 * manager.ui.mainCameraCom_.aspect / var_494_2.sprite.bounds.size.x or var_494_3 / var_494_2.sprite.bounds.size.y, 0)
				end

				for iter_494_0, iter_494_1 in pairs(arg_491_1.bgs_) do
					if iter_494_0 ~= "STblack" then
						iter_494_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_494_4 = 0

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_4 + arg_494_0 then
				arg_491_1.mask_.enabled = true
				arg_491_1.mask_.raycastTarget = true

				arg_491_1:SetGaussion(false)
			end

			local var_494_5 = 2

			if var_494_4 <= arg_491_1.time_ and arg_491_1.time_ < var_494_4 + var_494_5 then
				local var_494_6 = Color.New(0, 0, 0)

				var_494_6.a = Mathf.Lerp(0, 1, (arg_491_1.time_ - var_494_4) / var_494_5)
				arg_491_1.mask_.color = var_494_6
			end

			if arg_491_1.time_ >= var_494_4 + var_494_5 and arg_491_1.time_ < var_494_4 + var_494_5 + arg_494_0 then
				local var_494_7 = Color.New(0, 0, 0)

				var_494_7.a = 1
				arg_491_1.mask_.color = var_494_7
			end

			local var_494_8 = 2

			if 2 < arg_491_1.time_ and arg_491_1.time_ <= var_494_8 + arg_494_0 then
				arg_491_1.mask_.enabled = true
				arg_491_1.mask_.raycastTarget = true

				arg_491_1:SetGaussion(false)
			end

			local var_494_9 = 2

			if var_494_8 <= arg_491_1.time_ and arg_491_1.time_ < var_494_8 + var_494_9 then
				local var_494_10 = Color.New(0, 0, 0)

				var_494_10.a = Mathf.Lerp(1, 0, (arg_491_1.time_ - var_494_8) / var_494_9)
				arg_491_1.mask_.color = var_494_10
			end

			if arg_491_1.time_ >= var_494_8 + var_494_9 and arg_491_1.time_ < var_494_8 + var_494_9 + arg_494_0 then
				local var_494_11 = Color.New(0, 0, 0)

				arg_491_1.mask_.enabled = false
				var_494_11.a = 0
				arg_491_1.mask_.color = var_494_11
			end

			if 4 < arg_491_1.time_ and arg_491_1.time_ <= 4 + arg_494_0 then
				arg_491_1.fswbg_:SetActive(true)
				arg_491_1.dialog_:SetActive(false)

				arg_491_1.fswtw_.percent = 0
				arg_491_1.fswt_.text = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(317321119).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.fswt_)

				arg_491_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_491_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_491_1.fswtw_:SetDirty()

				arg_491_1.typewritterCharCountI18N = 0

				SetActive(arg_491_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_491_1:ShowNextGo(false)
			end

			local var_494_12 = 4.01666666666667

			if 4.01666666666667 < arg_491_1.time_ and arg_491_1.time_ <= var_494_12 + arg_494_0 then
				arg_491_1.var_.oldValueTypewriter = arg_491_1.fswtw_.percent

				SetActive(arg_491_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_491_1:ShowNextGo(false)
			end

			local var_494_13 = 28
			local var_494_14 = 1.86666666666667
			local var_494_15, var_494_16 = arg_491_1:GetPercentByPara(arg_491_1:FormatText(arg_491_1:GetWordFromCfg(317321119).content), 1)

			if var_494_12 < arg_491_1.time_ and arg_491_1.time_ <= var_494_12 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0

				local var_494_17 = var_494_13 <= 0 and var_494_14 or var_494_14 * ((var_494_16 - arg_491_1.typewritterCharCountI18N) / var_494_13)

				if (var_494_13 <= 0 and var_494_14 or var_494_14 * ((var_494_16 - arg_491_1.typewritterCharCountI18N) / var_494_13)) > 0 and var_494_14 < var_494_17 then
					arg_491_1.talkMaxDuration = var_494_17

					if var_494_17 + var_494_12 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_17 + var_494_12
					end
				end
			end

			local var_494_18 = math.max(1.86666666666667, arg_491_1.talkMaxDuration)

			if var_494_12 <= arg_491_1.time_ and arg_491_1.time_ < var_494_12 + var_494_18 then
				arg_491_1.fswtw_.percent = Mathf.Lerp(arg_491_1.var_.oldValueTypewriter, var_494_15, (arg_491_1.time_ - var_494_12) / var_494_18)
				arg_491_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_491_1.fswtw_:SetDirty()
			end

			if arg_491_1.time_ >= var_494_12 + var_494_18 and arg_491_1.time_ < var_494_12 + var_494_18 + arg_494_0 then
				arg_491_1.fswtw_.percent = var_494_15

				arg_491_1.fswtw_:SetDirty()
				arg_491_1:ShowNextGo(true)

				arg_491_1.typewritterCharCountI18N = var_494_16
			end

			if 4 < arg_491_1.time_ and arg_491_1.time_ <= 4 + arg_494_0 then
				local var_494_19 = arg_491_1.fswbg_.transform:Find("textbox/adapt/content") or arg_491_1.fswbg_.transform:Find("textbox/content")
				local var_494_20 = arg_491_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_494_21 = var_494_19:GetComponent("RectTransform")

				var_494_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_494_21.offsetMin = Vector2.New(0, 0)
				var_494_21.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K09f",
		"TextureConfig/Background/K11g",
		"TextureConfig/Background/YA0207",
		"TextureConfig/Background/S0012",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_317321.awb"
	}
}
