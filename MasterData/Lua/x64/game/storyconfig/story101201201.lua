return {
	Play120121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120121001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST31 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_4_0.name = "ST31"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST31 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
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

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

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

			local var_4_14 = 2
			local var_4_15 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(120121001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 10)

				if (10 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 10)) > 0 and var_4_15 < var_4_19 then
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
	Play120121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 120121002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play120121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.825

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(120121002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 33 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 33)

				if (33 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 33)) > 0 and var_12_0 < var_12_3 then
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
	Play120121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 120121003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play120121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1071ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1071ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1071ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1071ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_16_3 = 0
			local var_16_4 = 0.725

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_5 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(120121003).content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 29 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 29)

				if (29 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 29)) > 0 and var_16_4 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_3) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_3 + var_16_8 and arg_13_1.time_ < var_16_3 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play120121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 120121004
		arg_17_1.duration_ = 8.2

		local var_17_0 = {
			zh = 6.266,
			ja = 8.2
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play120121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1071ui_story = arg_17_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).z)
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles = arg_17_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_17_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1071ui_story"].transform.position).z)
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1071ui_story"].transform.localEulerAngles = arg_17_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_20_1 = "10042ui_story"

			if arg_17_1.actors_["10042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10042ui_story"))) then
				local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "10042ui_story"), arg_17_1.stage_.transform)

				var_20_2.name = var_20_1
				var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_1] = var_20_2

				local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

				var_20_3.enabled = true

				local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

				if var_20_4 then
					var_20_4:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_3.transform, false)

				arg_17_1.var_[var_20_1 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_1 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_1 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_5 = arg_17_1.actors_["10042ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10042ui_story = var_20_5.localPosition
			end

			local var_20_6 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10042ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_17_1.time_ - 0) / var_20_6)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_20_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_5.position).x, (manager.ui.mainCamera.transform.position - var_20_5.position).y, (manager.ui.mainCamera.transform.position - var_20_5.position).z)
				var_20_5.localEulerAngles.z = 0
				var_20_5.localEulerAngles.x = 0
				var_20_5.localEulerAngles = var_20_5.localEulerAngles
			end

			local var_20_7 = arg_17_1.actors_["1071ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1071ui_story == nil then
				arg_17_1.var_.characterEffect1071ui_story = var_20_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_8 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 and not isNil(var_20_7) then
				if arg_17_1.var_.characterEffect1071ui_story and not isNil(var_20_7) then
					arg_17_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 and not isNil(var_20_7) and arg_17_1.var_.characterEffect1071ui_story then
				arg_17_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_20_10 = arg_17_1.actors_["10042ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect10042ui_story == nil then
				arg_17_1.var_.characterEffect10042ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_11 and not isNil(var_20_10) then
				if arg_17_1.var_.characterEffect10042ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_11)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_11 and arg_17_1.time_ < 0 + var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect10042ui_story then
				arg_17_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			local var_20_12 = 0
			local var_20_13 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(120121004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 25 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 25)

				if (25 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 25)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121004", "story_v_out_120121.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_120121", "120121004", "story_v_out_120121.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_120121", "120121004", "story_v_out_120121.awb")

						arg_17_1:RecordAudio("120121004", var_20_19)
						arg_17_1:RecordAudio("120121004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_120121", "120121004", "story_v_out_120121.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_120121", "120121004", "story_v_out_120121.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play120121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 120121005
		arg_21_1.duration_ = 6.13

		local var_21_0 = {
			zh = 3.833,
			ja = 6.133
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
				arg_21_0:Play120121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1071ui_story = arg_21_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1071ui_story"].transform.position).z)
				arg_21_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1071ui_story"].transform.localEulerAngles = arg_21_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_21_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1071ui_story"].transform.position).z)
				arg_21_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1071ui_story"].transform.localEulerAngles = arg_21_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["10042ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10042ui_story = var_24_1.localPosition
			end

			local var_24_2 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 then
				var_24_1.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10042ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_21_1.time_ - 0) / var_24_2)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 then
				var_24_1.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			local var_24_3 = arg_21_1.actors_["1071ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1071ui_story == nil then
				arg_21_1.var_.characterEffect1071ui_story = var_24_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 and not isNil(var_24_3) then
				if arg_21_1.var_.characterEffect1071ui_story and not isNil(var_24_3) then
					arg_21_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_4)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1071ui_story then
				arg_21_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_24_5 = arg_21_1.actors_["10042ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect10042ui_story == nil then
				arg_21_1.var_.characterEffect10042ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect10042ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect10042ui_story then
				arg_21_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10042ui_story", "StoryTimeline/CharAction/story10042/story10042action/10042action2_1")
			end

			local var_24_8 = 0
			local var_24_9 = 0.525

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(120121005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 21 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 21)

				if (21 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 21)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121005", "story_v_out_120121.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121005", "story_v_out_120121.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_120121", "120121005", "story_v_out_120121.awb")

						arg_21_1:RecordAudio("120121005", var_24_15)
						arg_21_1:RecordAudio("120121005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_120121", "120121005", "story_v_out_120121.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_120121", "120121005", "story_v_out_120121.awb")
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
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
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
	Play120121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 120121006
		arg_25_1.duration_ = 8.7

		local var_25_0 = {
			zh = 8.7,
			ja = 6.2
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play120121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1071ui_story = arg_25_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1071ui_story"].transform.position).z)
				arg_25_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1071ui_story"].transform.localEulerAngles = arg_25_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_25_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1071ui_story"].transform.position).z)
				arg_25_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1071ui_story"].transform.localEulerAngles = arg_25_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["10042ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10042ui_story = var_28_1.localPosition
			end

			local var_28_2 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 then
				var_28_1.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10042ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_25_1.time_ - 0) / var_28_2)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 then
				var_28_1.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			local var_28_3 = arg_25_1.actors_["1071ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect1071ui_story == nil then
				arg_25_1.var_.characterEffect1071ui_story = var_28_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_4 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 and not isNil(var_28_3) then
				if arg_25_1.var_.characterEffect1071ui_story and not isNil(var_28_3) then
					arg_25_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect1071ui_story then
				arg_25_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_28_6 = arg_25_1.actors_["10042ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10042ui_story == nil then
				arg_25_1.var_.characterEffect10042ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 and not isNil(var_28_6) then
				if arg_25_1.var_.characterEffect10042ui_story and not isNil(var_28_6) then
					arg_25_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_7)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10042ui_story then
				arg_25_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_28_8 = 0
			local var_28_9 = 1.075

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(120121006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 43 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 43)

				if (43 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 43)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121006", "story_v_out_120121.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121006", "story_v_out_120121.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_120121", "120121006", "story_v_out_120121.awb")

						arg_25_1:RecordAudio("120121006", var_28_15)
						arg_25_1:RecordAudio("120121006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_120121", "120121006", "story_v_out_120121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_120121", "120121006", "story_v_out_120121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
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
	Play120121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 120121007
		arg_29_1.duration_ = 5

		local var_29_0 = {
			zh = 4.366,
			ja = 5
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
				arg_29_0:Play120121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1071ui_story = arg_29_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1071ui_story"].transform.position).z)
				arg_29_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1071ui_story"].transform.localEulerAngles = arg_29_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_29_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1071ui_story"].transform.position).z)
				arg_29_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1071ui_story"].transform.localEulerAngles = arg_29_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10042ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10042ui_story = var_32_1.localPosition
			end

			local var_32_2 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 then
				var_32_1.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10042ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_29_1.time_ - 0) / var_32_2)
				var_32_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_1.position).x, (manager.ui.mainCamera.transform.position - var_32_1.position).y, (manager.ui.mainCamera.transform.position - var_32_1.position).z)
				var_32_1.localEulerAngles.z = 0
				var_32_1.localEulerAngles.x = 0
				var_32_1.localEulerAngles = var_32_1.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 then
				var_32_1.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_32_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_1.position).x, (manager.ui.mainCamera.transform.position - var_32_1.position).y, (manager.ui.mainCamera.transform.position - var_32_1.position).z)
				var_32_1.localEulerAngles.z = 0
				var_32_1.localEulerAngles.x = 0
				var_32_1.localEulerAngles = var_32_1.localEulerAngles
			end

			local var_32_3 = arg_29_1.actors_["1071ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect1071ui_story == nil then
				arg_29_1.var_.characterEffect1071ui_story = var_32_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_4 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 and not isNil(var_32_3) then
				if arg_29_1.var_.characterEffect1071ui_story and not isNil(var_32_3) then
					arg_29_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_4)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.characterEffect1071ui_story then
				arg_29_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_32_5 = arg_29_1.actors_["10042ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10042ui_story == nil then
				arg_29_1.var_.characterEffect10042ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect10042ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect10042ui_story then
				arg_29_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_32_8 = 0
			local var_32_9 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:GetWordFromCfg(120121007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 20 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 20)

				if (20 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 20)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121007", "story_v_out_120121.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121007", "story_v_out_120121.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_120121", "120121007", "story_v_out_120121.awb")

						arg_29_1:RecordAudio("120121007", var_32_15)
						arg_29_1:RecordAudio("120121007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_120121", "120121007", "story_v_out_120121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_120121", "120121007", "story_v_out_120121.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
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
	Play120121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 120121008
		arg_33_1.duration_ = 7.5

		local var_33_0 = {
			zh = 6.066,
			ja = 7.5
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
				arg_33_0:Play120121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1071ui_story = arg_33_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).z)
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles = arg_33_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_33_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1071ui_story"].transform.position).z)
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1071ui_story"].transform.localEulerAngles = arg_33_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["10042ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10042ui_story = var_36_1.localPosition
			end

			local var_36_2 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 then
				var_36_1.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10042ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_33_1.time_ - 0) / var_36_2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 then
				var_36_1.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_36_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_1.position).x, (manager.ui.mainCamera.transform.position - var_36_1.position).y, (manager.ui.mainCamera.transform.position - var_36_1.position).z)
				var_36_1.localEulerAngles.z = 0
				var_36_1.localEulerAngles.x = 0
				var_36_1.localEulerAngles = var_36_1.localEulerAngles
			end

			local var_36_3 = arg_33_1.actors_["1071ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1071ui_story == nil then
				arg_33_1.var_.characterEffect1071ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect1071ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1071ui_story then
				arg_33_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_36_6 = arg_33_1.actors_["10042ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect10042ui_story == nil then
				arg_33_1.var_.characterEffect10042ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_7 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 and not isNil(var_36_6) then
				if arg_33_1.var_.characterEffect10042ui_story and not isNil(var_36_6) then
					arg_33_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_7)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect10042ui_story then
				arg_33_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action435")
			end

			local var_36_8 = 0
			local var_36_9 = 0.8

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(120121008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_13 = 32 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 32)

				if (32 <= 0 and var_36_9 or var_36_9 * (utf8.len(var_36_11) / 32)) > 0 and var_36_9 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_8
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121008", "story_v_out_120121.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121008", "story_v_out_120121.awb") / 1000

					if var_36_14 + var_36_8 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_8
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_120121", "120121008", "story_v_out_120121.awb")

						arg_33_1:RecordAudio("120121008", var_36_15)
						arg_33_1:RecordAudio("120121008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_120121", "120121008", "story_v_out_120121.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_120121", "120121008", "story_v_out_120121.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_9, arg_33_1.talkMaxDuration)

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_8) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_8 + var_36_16 and arg_33_1.time_ < var_36_8 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play120121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 120121009
		arg_37_1.duration_ = 7.2

		local var_37_0 = {
			zh = 5.333,
			ja = 7.2
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play120121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.725

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(120121009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 29)

				if (29 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 29)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121009", "story_v_out_120121.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_120121", "120121009", "story_v_out_120121.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_120121", "120121009", "story_v_out_120121.awb")

						arg_37_1:RecordAudio("120121009", var_40_6)
						arg_37_1:RecordAudio("120121009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_120121", "120121009", "story_v_out_120121.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_120121", "120121009", "story_v_out_120121.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play120121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 120121010
		arg_41_1.duration_ = 10.7

		local var_41_0 = {
			zh = 3.966,
			ja = 10.7
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
				arg_41_0:Play120121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1071ui_story = arg_41_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1071ui_story"].transform.position).z)
				arg_41_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1071ui_story"].transform.localEulerAngles = arg_41_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_41_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1071ui_story"].transform.position).z)
				arg_41_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1071ui_story"].transform.localEulerAngles = arg_41_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["10042ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10042ui_story = var_44_1.localPosition
			end

			local var_44_2 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 then
				var_44_1.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10042ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_41_1.time_ - 0) / var_44_2)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 then
				var_44_1.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			local var_44_3 = arg_41_1.actors_["1071ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect1071ui_story == nil then
				arg_41_1.var_.characterEffect1071ui_story = var_44_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_4 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 and not isNil(var_44_3) then
				if arg_41_1.var_.characterEffect1071ui_story and not isNil(var_44_3) then
					arg_41_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_4)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 and not isNil(var_44_3) and arg_41_1.var_.characterEffect1071ui_story then
				arg_41_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_44_5 = arg_41_1.actors_["10042ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect10042ui_story == nil then
				arg_41_1.var_.characterEffect10042ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.characterEffect10042ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect10042ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect10042ui_story then
				arg_41_1.var_.characterEffect10042ui_story.fillFlat = false
			end

			local var_44_8 = 0
			local var_44_9 = 0.6

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[388].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:GetWordFromCfg(120121010)
				local var_44_11 = arg_41_1:FormatText(var_44_10.content)

				arg_41_1.text_.text = var_44_11

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_13 = 24 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 24)

				if (24 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_11) / 24)) > 0 and var_44_9 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_11
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121010", "story_v_out_120121.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121010", "story_v_out_120121.awb") / 1000

					if var_44_14 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_8
					end

					if var_44_10.prefab_name ~= "" and arg_41_1.actors_[var_44_10.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_10.prefab_name].transform, "story_v_out_120121", "120121010", "story_v_out_120121.awb")

						arg_41_1:RecordAudio("120121010", var_44_15)
						arg_41_1:RecordAudio("120121010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_120121", "120121010", "story_v_out_120121.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_120121", "120121010", "story_v_out_120121.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_16 and arg_41_1.time_ < var_44_8 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play120121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 120121011
		arg_45_1.duration_ = 3

		local var_45_0 = {
			zh = 3,
			ja = 2.2
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play120121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1071ui_story = arg_45_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).z)
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles = arg_45_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_45_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1071ui_story"].transform.position).z)
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1071ui_story"].transform.localEulerAngles = arg_45_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["10042ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10042ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10042ui_story, Vector3.New(0.7, -1.12, -6.2), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(0.7, -1.12, -6.2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = arg_45_1.actors_["1071ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect1071ui_story == nil then
				arg_45_1.var_.characterEffect1071ui_story = var_48_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_4 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 and not isNil(var_48_3) then
				if arg_45_1.var_.characterEffect1071ui_story and not isNil(var_48_3) then
					arg_45_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect1071ui_story then
				arg_45_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_48_6 = arg_45_1.actors_["10042ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect10042ui_story == nil then
				arg_45_1.var_.characterEffect10042ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_7 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 and not isNil(var_48_6) then
				if arg_45_1.var_.characterEffect10042ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect10042ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_7)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect10042ui_story then
				arg_45_1.var_.characterEffect10042ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10042ui_story.fillRatio = 0.5
			end

			local var_48_8 = 0
			local var_48_9 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(120121011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 8 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 8)

				if (8 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 8)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121011", "story_v_out_120121.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121011", "story_v_out_120121.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_120121", "120121011", "story_v_out_120121.awb")

						arg_45_1:RecordAudio("120121011", var_48_15)
						arg_45_1:RecordAudio("120121011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_120121", "120121011", "story_v_out_120121.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_120121", "120121011", "story_v_out_120121.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
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
	Play120121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 120121012
		arg_49_1.duration_ = 7.1

		local var_49_0 = {
			zh = 3.7,
			ja = 7.1
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
				arg_49_0:Play120121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1071ui_story = arg_49_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1071ui_story"].transform.position).z)
				arg_49_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1071ui_story"].transform.localEulerAngles = arg_49_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1071ui_story"].transform.position).z)
				arg_49_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1071ui_story"].transform.localEulerAngles = arg_49_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10042ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10042ui_story = var_52_1.localPosition
			end

			local var_52_2 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 then
				var_52_1.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10042ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_2)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 then
				var_52_1.localPosition = Vector3.New(0, 100, 0)
				var_52_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_1.position).x, (manager.ui.mainCamera.transform.position - var_52_1.position).y, (manager.ui.mainCamera.transform.position - var_52_1.position).z)
				var_52_1.localEulerAngles.z = 0
				var_52_1.localEulerAngles.x = 0
				var_52_1.localEulerAngles = var_52_1.localEulerAngles
			end

			local var_52_3 = 0
			local var_52_4 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_5 = arg_49_1:GetWordFromCfg(120121012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 20 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 20)

				if (20 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 20)) > 0 and var_52_4 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121012", "story_v_out_120121.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_out_120121", "120121012", "story_v_out_120121.awb") / 1000

					if var_52_9 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_3
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_120121", "120121012", "story_v_out_120121.awb")

						arg_49_1:RecordAudio("120121012", var_52_10)
						arg_49_1:RecordAudio("120121012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_120121", "120121012", "story_v_out_120121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_120121", "120121012", "story_v_out_120121.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_4, arg_49_1.talkMaxDuration)

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_3) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_3 + var_52_11 and arg_49_1.time_ < var_52_3 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10042ui_story",
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
	Play120121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 120121013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play120121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(120121013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 40 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 40)

				if (40 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 40)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play120121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 120121014
		arg_57_1.duration_ = 10.97

		local var_57_0 = {
			zh = 9.566,
			ja = 10.966
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
				arg_57_0:Play120121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1071ui_story"]) and arg_57_1.var_.characterEffect1071ui_story == nil then
				arg_57_1.var_.characterEffect1071ui_story = arg_57_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1071ui_story"]) then
				if arg_57_1.var_.characterEffect1071ui_story and not isNil(arg_57_1.actors_["1071ui_story"]) then
					arg_57_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1071ui_story"]) and arg_57_1.var_.characterEffect1071ui_story then
				arg_57_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["1071ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1071ui_story = var_60_2.localPosition
			end

			local var_60_3 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_57_1.time_ - 0) / var_60_3)
				var_60_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_2.position).x, (manager.ui.mainCamera.transform.position - var_60_2.position).y, (manager.ui.mainCamera.transform.position - var_60_2.position).z)
				var_60_2.localEulerAngles.z = 0
				var_60_2.localEulerAngles.x = 0
				var_60_2.localEulerAngles = var_60_2.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(0, -1.05, -6.2)
				var_60_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_2.position).x, (manager.ui.mainCamera.transform.position - var_60_2.position).y, (manager.ui.mainCamera.transform.position - var_60_2.position).z)
				var_60_2.localEulerAngles.z = 0
				var_60_2.localEulerAngles.x = 0
				var_60_2.localEulerAngles = var_60_2.localEulerAngles
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.9

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(120121014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 36 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 36)

				if (36 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 36)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121014", "story_v_out_120121.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121014", "story_v_out_120121.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_120121", "120121014", "story_v_out_120121.awb")

						arg_57_1:RecordAudio("120121014", var_60_11)
						arg_57_1:RecordAudio("120121014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_120121", "120121014", "story_v_out_120121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_120121", "120121014", "story_v_out_120121.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play120121015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 120121015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play120121016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1071ui_story"]) and arg_61_1.var_.characterEffect1071ui_story == nil then
				arg_61_1.var_.characterEffect1071ui_story = arg_61_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1071ui_story"]) then
				if arg_61_1.var_.characterEffect1071ui_story and not isNil(arg_61_1.actors_["1071ui_story"]) then
					arg_61_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1071ui_story"]) and arg_61_1.var_.characterEffect1071ui_story then
				arg_61_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_64_1 = arg_61_1.actors_["1071ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1071ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_61_1.time_ - 0) / var_64_2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0, -1.05, -6.2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			local var_64_3 = 0
			local var_64_4 = 0.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(120121015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 16 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 16)

				if (16 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 16)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play120121016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 120121016
		arg_65_1.duration_ = 7.97

		local var_65_0 = {
			zh = 5.333,
			ja = 7.966
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play120121017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1071ui_story"]) and arg_65_1.var_.characterEffect1071ui_story == nil then
				arg_65_1.var_.characterEffect1071ui_story = arg_65_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1071ui_story"]) then
				if arg_65_1.var_.characterEffect1071ui_story and not isNil(arg_65_1.actors_["1071ui_story"]) then
					arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1071ui_story"]) and arg_65_1.var_.characterEffect1071ui_story then
				arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1071ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1071ui_story = var_68_2.localPosition
			end

			local var_68_3 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1071ui_story, Vector3.New(0, -1.05, -6.2), (arg_65_1.time_ - 0) / var_68_3)
				var_68_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_2.position).x, (manager.ui.mainCamera.transform.position - var_68_2.position).y, (manager.ui.mainCamera.transform.position - var_68_2.position).z)
				var_68_2.localEulerAngles.z = 0
				var_68_2.localEulerAngles.x = 0
				var_68_2.localEulerAngles = var_68_2.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(0, -1.05, -6.2)
				var_68_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_2.position).x, (manager.ui.mainCamera.transform.position - var_68_2.position).y, (manager.ui.mainCamera.transform.position - var_68_2.position).z)
				var_68_2.localEulerAngles.z = 0
				var_68_2.localEulerAngles.x = 0
				var_68_2.localEulerAngles = var_68_2.localEulerAngles
			end

			local var_68_4 = 0
			local var_68_5 = 0.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(120121016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 24 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 24)

				if (24 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 24)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121016", "story_v_out_120121.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121016", "story_v_out_120121.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_120121", "120121016", "story_v_out_120121.awb")

						arg_65_1:RecordAudio("120121016", var_68_11)
						arg_65_1:RecordAudio("120121016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_120121", "120121016", "story_v_out_120121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_120121", "120121016", "story_v_out_120121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play120121017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 120121017
		arg_69_1.duration_ = 5.33

		local var_69_0 = {
			zh = 3.5,
			ja = 5.333
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play120121018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.375

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(120121017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 15 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 15)

				if (15 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 15)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121017", "story_v_out_120121.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_120121", "120121017", "story_v_out_120121.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_120121", "120121017", "story_v_out_120121.awb")

						arg_69_1:RecordAudio("120121017", var_72_6)
						arg_69_1:RecordAudio("120121017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_120121", "120121017", "story_v_out_120121.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_120121", "120121017", "story_v_out_120121.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play120121018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 120121018
		arg_73_1.duration_ = 4.67

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play120121019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if arg_73_1.bgs_.STblack == nil then
				local var_76_0 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_76_0.name = "STblack"
				var_76_0.transform.parent = arg_73_1.stage_.transform
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_.STblack = var_76_0
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				local var_76_1 = arg_73_1.bgs_.STblack

				arg_73_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_76_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_2 = var_76_1:GetComponent("SpriteRenderer")

				if var_76_2 and var_76_2.sprite then
					local var_76_3 = 2 * (var_76_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_76_1.transform.localScale = Vector3.New(var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, var_76_3 / var_76_2.sprite.bounds.size.y < var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x and var_76_3 * manager.ui.mainCameraCom_.aspect / var_76_2.sprite.bounds.size.x or var_76_3 / var_76_2.sprite.bounds.size.y, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "STblack" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_4 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_5 = 2

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_5 then
				local var_76_6 = Color.New(0, 0, 0)

				var_76_6.a = Mathf.Lerp(0, 1, (arg_73_1.time_ - var_76_4) / var_76_5)
				arg_73_1.mask_.color = var_76_6
			end

			if arg_73_1.time_ >= var_76_4 + var_76_5 and arg_73_1.time_ < var_76_4 + var_76_5 + arg_76_0 then
				local var_76_7 = Color.New(0, 0, 0)

				var_76_7.a = 1
				arg_73_1.mask_.color = var_76_7
			end

			local var_76_8 = 2

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_9 = 2

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_9 then
				local var_76_10 = Color.New(0, 0, 0)

				var_76_10.a = Mathf.Lerp(1, 0, (arg_73_1.time_ - var_76_8) / var_76_9)
				arg_73_1.mask_.color = var_76_10
			end

			if arg_73_1.time_ >= var_76_8 + var_76_9 and arg_73_1.time_ < var_76_8 + var_76_9 + arg_76_0 then
				local var_76_11 = Color.New(0, 0, 0)

				arg_73_1.mask_.enabled = false
				var_76_11.a = 0
				arg_73_1.mask_.color = var_76_11
			end

			local var_76_12 = arg_73_1.actors_["1071ui_story"].transform

			if 1.966 < arg_73_1.time_ and arg_73_1.time_ <= 1.966 + arg_76_0 then
				arg_73_1.var_.moveOldPos1071ui_story = var_76_12.localPosition
			end

			local var_76_13 = 0.001

			if 1.966 <= arg_73_1.time_ and arg_73_1.time_ < 1.966 + var_76_13 then
				var_76_12.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 1.966) / var_76_13)
				var_76_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_12.position).x, (manager.ui.mainCamera.transform.position - var_76_12.position).y, (manager.ui.mainCamera.transform.position - var_76_12.position).z)
				var_76_12.localEulerAngles.z = 0
				var_76_12.localEulerAngles.x = 0
				var_76_12.localEulerAngles = var_76_12.localEulerAngles
			end

			if arg_73_1.time_ >= 1.966 + var_76_13 and arg_73_1.time_ < 1.966 + var_76_13 + arg_76_0 then
				var_76_12.localPosition = Vector3.New(0, 100, 0)
				var_76_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_12.position).x, (manager.ui.mainCamera.transform.position - var_76_12.position).y, (manager.ui.mainCamera.transform.position - var_76_12.position).z)
				var_76_12.localEulerAngles.z = 0
				var_76_12.localEulerAngles.x = 0
				var_76_12.localEulerAngles = var_76_12.localEulerAngles
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				arg_73_1.fswbg_:SetActive(true)
				arg_73_1.dialog_:SetActive(false)

				arg_73_1.fswtw_.percent = 0
				arg_73_1.fswt_.text = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(120121018).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.fswt_)

				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_73_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_73_1.fswtw_:SetDirty()

				arg_73_1.typewritterCharCountI18N = 0

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_14 = 2.01666666666667

			if 2.01666666666667 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1.var_.oldValueTypewriter = arg_73_1.fswtw_.percent

				SetActive(arg_73_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_73_1:ShowNextGo(false)
			end

			local var_76_15 = 27
			local var_76_16 = 1.8
			local var_76_17, var_76_18 = arg_73_1:GetPercentByPara(arg_73_1:FormatText(arg_73_1:GetWordFromCfg(120121018).content), 1)

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				local var_76_19 = var_76_15 <= 0 and var_76_16 or var_76_16 * ((var_76_18 - arg_73_1.typewritterCharCountI18N) / var_76_15)

				if (var_76_15 <= 0 and var_76_16 or var_76_16 * ((var_76_18 - arg_73_1.typewritterCharCountI18N) / var_76_15)) > 0 and var_76_16 < var_76_19 then
					arg_73_1.talkMaxDuration = var_76_19

					if var_76_19 + var_76_14 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_19 + var_76_14
					end
				end
			end

			local var_76_20 = math.max(1.8, arg_73_1.talkMaxDuration)

			if var_76_14 <= arg_73_1.time_ and arg_73_1.time_ < var_76_14 + var_76_20 then
				arg_73_1.fswtw_.percent = Mathf.Lerp(arg_73_1.var_.oldValueTypewriter, var_76_17, (arg_73_1.time_ - var_76_14) / var_76_20)
				arg_73_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_73_1.fswtw_:SetDirty()
			end

			if arg_73_1.time_ >= var_76_14 + var_76_20 and arg_73_1.time_ < var_76_14 + var_76_20 + arg_76_0 then
				arg_73_1.fswtw_.percent = var_76_17

				arg_73_1.fswtw_:SetDirty()
				arg_73_1:ShowNextGo(true)

				arg_73_1.typewritterCharCountI18N = var_76_18
			end

			if 2 < arg_73_1.time_ and arg_73_1.time_ <= 2 + arg_76_0 then
				local var_76_21 = arg_73_1.fswbg_.transform:Find("textbox/adapt/content") or arg_73_1.fswbg_.transform:Find("textbox/content")
				local var_76_22 = arg_73_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_76_23 = var_76_21:GetComponent("RectTransform")

				var_76_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_76_23.offsetMin = Vector2.New(0, 0)
				var_76_23.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play120121019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120121019
		arg_77_1.duration_ = 2.08

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play120121020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.fswbg_:SetActive(true)
				arg_77_1.dialog_:SetActive(false)

				arg_77_1.fswtw_.percent = 0
				arg_77_1.fswt_.text = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(120121019).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.fswt_)

				arg_77_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_77_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_77_1.fswtw_:SetDirty()

				arg_77_1.typewritterCharCountI18N = 0

				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.var_.oldValueTypewriter = arg_77_1.fswtw_.percent

				SetActive(arg_77_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_77_1:ShowNextGo(false)
			end

			local var_80_1 = 31
			local var_80_2 = 2.06666666666667
			local var_80_3, var_80_4 = arg_77_1:GetPercentByPara(arg_77_1:FormatText(arg_77_1:GetWordFromCfg(120121019).content), 1)

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				local var_80_5 = var_80_1 <= 0 and var_80_2 or var_80_2 * ((var_80_4 - arg_77_1.typewritterCharCountI18N) / var_80_1)

				if (var_80_1 <= 0 and var_80_2 or var_80_2 * ((var_80_4 - arg_77_1.typewritterCharCountI18N) / var_80_1)) > 0 and var_80_2 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_0
					end
				end
			end

			local var_80_6 = math.max(2.06666666666667, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_6 then
				arg_77_1.fswtw_.percent = Mathf.Lerp(arg_77_1.var_.oldValueTypewriter, var_80_3, (arg_77_1.time_ - var_80_0) / var_80_6)
				arg_77_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_77_1.fswtw_:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_6 and arg_77_1.time_ < var_80_0 + var_80_6 + arg_80_0 then
				arg_77_1.fswtw_.percent = var_80_3

				arg_77_1.fswtw_:SetDirty()
				arg_77_1:ShowNextGo(true)

				arg_77_1.typewritterCharCountI18N = var_80_4
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play120121020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120121020
		arg_81_1.duration_ = 4.08

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play120121021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.fswbg_:SetActive(true)
				arg_81_1.dialog_:SetActive(false)

				arg_81_1.fswtw_.percent = 0
				arg_81_1.fswt_.text = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(120121020).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.fswt_)

				arg_81_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_81_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_81_1.fswtw_:SetDirty()

				arg_81_1.typewritterCharCountI18N = 0

				SetActive(arg_81_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_81_1:ShowNextGo(false)
			end

			local var_84_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.var_.oldValueTypewriter = arg_81_1.fswtw_.percent

				SetActive(arg_81_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_81_1:ShowNextGo(false)
			end

			local var_84_1 = 62
			local var_84_2 = 4.06666666666667
			local var_84_3, var_84_4 = arg_81_1:GetPercentByPara(arg_81_1:FormatText(arg_81_1:GetWordFromCfg(120121020).content), 1)

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				local var_84_5 = var_84_1 <= 0 and var_84_2 or var_84_2 * ((var_84_4 - arg_81_1.typewritterCharCountI18N) / var_84_1)

				if (var_84_1 <= 0 and var_84_2 or var_84_2 * ((var_84_4 - arg_81_1.typewritterCharCountI18N) / var_84_1)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_0
					end
				end
			end

			local var_84_6 = math.max(4.06666666666667, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_6 then
				arg_81_1.fswtw_.percent = Mathf.Lerp(arg_81_1.var_.oldValueTypewriter, var_84_3, (arg_81_1.time_ - var_84_0) / var_84_6)
				arg_81_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_81_1.fswtw_:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_6 and arg_81_1.time_ < var_84_0 + var_84_6 + arg_84_0 then
				arg_81_1.fswtw_.percent = var_84_3

				arg_81_1.fswtw_:SetDirty()
				arg_81_1:ShowNextGo(true)

				arg_81_1.typewritterCharCountI18N = var_84_4
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play120121021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120121021
		arg_85_1.duration_ = 9

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play120121022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if arg_85_1.bgs_.J13f == nil then
				local var_88_0 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J13f")
				var_88_0.name = "J13f"
				var_88_0.transform.parent = arg_85_1.stage_.transform
				var_88_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_.J13f = var_88_0
			end

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				local var_88_1 = arg_85_1.bgs_.J13f

				arg_85_1.bgs_.J13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_2 = var_88_1:GetComponent("SpriteRenderer")

				if var_88_2 and var_88_2.sprite then
					local var_88_3 = 2 * (var_88_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_1.transform.localScale = Vector3.New(var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, var_88_3 / var_88_2.sprite.bounds.size.y < var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x and var_88_3 * manager.ui.mainCameraCom_.aspect / var_88_2.sprite.bounds.size.x or var_88_3 / var_88_2.sprite.bounds.size.y, 0)
				end

				for iter_88_0, iter_88_1 in pairs(arg_85_1.bgs_) do
					if iter_88_0 ~= "J13f" then
						iter_88_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_4 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_5 = 2

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_5 then
				local var_88_6 = Color.New(0, 0, 0)

				var_88_6.a = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_4) / var_88_5)
				arg_85_1.mask_.color = var_88_6
			end

			if arg_85_1.time_ >= var_88_4 + var_88_5 and arg_85_1.time_ < var_88_4 + var_88_5 + arg_88_0 then
				local var_88_7 = Color.New(0, 0, 0)

				var_88_7.a = 1
				arg_85_1.mask_.color = var_88_7
			end

			local var_88_8 = 2

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_9 = 2

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 then
				local var_88_10 = Color.New(0, 0, 0)

				var_88_10.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_8) / var_88_9)
				arg_85_1.mask_.color = var_88_10
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 then
				local var_88_11 = Color.New(0, 0, 0)

				arg_85_1.mask_.enabled = false
				var_88_11.a = 0
				arg_85_1.mask_.color = var_88_11
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_88_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_85_1.bgmTxt_.text ~= var_88_14 and arg_85_1.bgmTxt_.text ~= "" then
						if arg_85_1.bgmTxt2_.text ~= "" then
							arg_85_1.bgmTxt_.text = arg_85_1.bgmTxt2_.text
						end

						arg_85_1.bgmTxt2_.text = var_88_14

						arg_85_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_85_1.bgmTxt_.text = var_88_14
						arg_85_1.bgmTxt2_.text = var_88_14
					end

					if arg_85_1.bgmTimer then
						arg_85_1.bgmTimer:Stop()

						arg_85_1.bgmTimer = nil
					end

					if arg_85_1.settingData.show_music_name == 1 then
						arg_85_1.musicController:SetSelectedState("show")
						arg_85_1.musicAnimator_:Play("open", 0, 0)

						if arg_85_1.settingData.music_time ~= 0 then
							arg_85_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_85_1.settingData.music_time), function()
								if arg_85_1 == nil or isNil(arg_85_1.bgmTxt_) then
									return
								end

								arg_85_1.musicController:SetSelectedState("hide")
								arg_85_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				arg_85_1.fswbg_:SetActive(false)
				arg_85_1.dialog_:SetActive(false)
				SetActive(arg_85_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_85_1:ShowNextGo(false)
			end

			local var_88_15 = "J13f_blur"

			if arg_85_1.bgs_.J13f_blur == nil then
				local var_88_16 = Object.Instantiate(arg_85_1.blurPaintGo_)

				var_88_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_15)
				var_88_16.name = var_88_15
				var_88_16.transform.parent = arg_85_1.stage_.transform
				var_88_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_15] = var_88_16
			end

			local var_88_17 = 2
			local var_88_18 = arg_85_1.bgs_[var_88_15]

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				var_88_18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_19 = var_88_18:GetComponent("SpriteRenderer")

				if var_88_19 and var_88_19.sprite then
					local var_88_20 = 2 * (var_88_18.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_18.transform.localScale = Vector3.New(var_88_20 / var_88_19.sprite.bounds.size.y < var_88_20 * manager.ui.mainCameraCom_.aspect / var_88_19.sprite.bounds.size.x and var_88_20 * manager.ui.mainCameraCom_.aspect / var_88_19.sprite.bounds.size.x or var_88_20 / var_88_19.sprite.bounds.size.y, var_88_20 / var_88_19.sprite.bounds.size.y < var_88_20 * manager.ui.mainCameraCom_.aspect / var_88_19.sprite.bounds.size.x and var_88_20 * manager.ui.mainCameraCom_.aspect / var_88_19.sprite.bounds.size.x or var_88_20 / var_88_19.sprite.bounds.size.y, 0)
				end
			end

			local var_88_21 = 2

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_21 then
				local var_88_22 = Color.New(1, 1, 1)

				var_88_22.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_17) / var_88_21)

				var_88_18:GetComponent("SpriteRenderer").material:SetColor("_Color", var_88_22)
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_23 = 4
			local var_88_24 = 0.825

			if 4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_25 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_25:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_85_1.dialogCg_.alpha = arg_90_0
				end))
				var_88_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(120121021).content)

				arg_85_1.text_.text = var_88_26

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 33 <= 0 and var_88_24 or var_88_24 * (utf8.len(var_88_26) / 33)

				if (33 <= 0 and var_88_24 or var_88_24 * (utf8.len(var_88_26) / 33)) > 0 and var_88_24 < var_88_28 then
					arg_85_1.talkMaxDuration = var_88_28
					var_88_23 = var_88_23 + 0.3

					if var_88_28 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_28 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_26
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_29 = var_88_23 + 0.3
			local var_88_30 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_29 + var_88_30 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_29) / var_88_30

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_29 + var_88_30 and arg_85_1.time_ < var_88_29 + var_88_30 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play120121022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 120121022
		arg_92_1.duration_ = 8.53

		local var_92_0 = {
			zh = 4.333,
			ja = 8.533
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
				arg_92_0:Play120121023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.5

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(120121022)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 20 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 20)

				if (20 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 20)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121022", "story_v_out_120121.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_120121", "120121022", "story_v_out_120121.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_120121", "120121022", "story_v_out_120121.awb")

						arg_92_1:RecordAudio("120121022", var_95_6)
						arg_92_1:RecordAudio("120121022", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_120121", "120121022", "story_v_out_120121.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_120121", "120121022", "story_v_out_120121.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play120121023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 120121023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play120121024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.4

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(120121023).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 16 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 16)

				if (16 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 16)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play120121024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 120121024
		arg_100_1.duration_ = 2.4

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play120121025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if arg_100_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_103_0 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_100_1.stage_.transform)

				var_103_0.name = "1075ui_story"
				var_103_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["1075ui_story"] = var_103_0

				local var_103_1 = var_103_0:GetComponentInChildren(typeof(CharacterEffect))

				var_103_1.enabled = true

				local var_103_2 = GameObjectTools.GetOrAddComponent(var_103_0, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(false)
				end

				arg_100_1:ShowWeapon(var_103_1.transform, false)

				arg_100_1.var_["1075ui_story" .. "Animator"] = var_103_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_100_1.var_["1075ui_story" .. "Animator"].applyRootMotion = true
				arg_100_1.var_["1075ui_story" .. "LipSync"] = var_103_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_103_3 = arg_100_1.actors_["1075ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1075ui_story = var_103_3.localPosition
			end

			local var_103_4 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_3.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1075ui_story, Vector3.New(0, -1.055, -6.16), (arg_100_1.time_ - 0) / var_103_4)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_3.localPosition = Vector3.New(0, -1.055, -6.16)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_103_5 = 0
			local var_103_6 = 0.15

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:GetWordFromCfg(120121024)
				local var_103_8 = arg_100_1:FormatText(var_103_7.content)

				arg_100_1.text_.text = var_103_8

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_10 = 6 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 6)

				if (6 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 6)) > 0 and var_103_6 < var_103_10 then
					arg_100_1.talkMaxDuration = var_103_10

					if var_103_10 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_5
					end
				end

				arg_100_1.text_.text = var_103_8
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121024", "story_v_out_120121.awb") ~= 0 then
					local var_103_11 = manager.audio:GetVoiceLength("story_v_out_120121", "120121024", "story_v_out_120121.awb") / 1000

					if var_103_11 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_11 + var_103_5
					end

					if var_103_7.prefab_name ~= "" and arg_100_1.actors_[var_103_7.prefab_name] ~= nil then
						local var_103_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_7.prefab_name].transform, "story_v_out_120121", "120121024", "story_v_out_120121.awb")

						arg_100_1:RecordAudio("120121024", var_103_12)
						arg_100_1:RecordAudio("120121024", var_103_12)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_120121", "120121024", "story_v_out_120121.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_120121", "120121024", "story_v_out_120121.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_6, arg_100_1.talkMaxDuration)

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_5) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_5 + var_103_13 and arg_100_1.time_ < var_103_5 + var_103_13 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play120121025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 120121025
		arg_104_1.duration_ = 5.27

		local var_104_0 = {
			zh = 4.1,
			ja = 5.266
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play120121026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.525

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:GetWordFromCfg(120121025)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 21 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 21)

				if (21 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 21)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121025", "story_v_out_120121.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_120121", "120121025", "story_v_out_120121.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_120121", "120121025", "story_v_out_120121.awb")

						arg_104_1:RecordAudio("120121025", var_107_6)
						arg_104_1:RecordAudio("120121025", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_120121", "120121025", "story_v_out_120121.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_120121", "120121025", "story_v_out_120121.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play120121026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 120121026
		arg_108_1.duration_ = 2

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play120121027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_111_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_108_1.bgmTxt_.text ~= var_111_2 and arg_108_1.bgmTxt_.text ~= "" then
						if arg_108_1.bgmTxt2_.text ~= "" then
							arg_108_1.bgmTxt_.text = arg_108_1.bgmTxt2_.text
						end

						arg_108_1.bgmTxt2_.text = var_111_2

						arg_108_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_108_1.bgmTxt_.text = var_111_2
						arg_108_1.bgmTxt2_.text = var_111_2
					end

					if arg_108_1.bgmTimer then
						arg_108_1.bgmTimer:Stop()

						arg_108_1.bgmTimer = nil
					end

					if arg_108_1.settingData.show_music_name == 1 then
						arg_108_1.musicController:SetSelectedState("show")
						arg_108_1.musicAnimator_:Play("open", 0, 0)

						if arg_108_1.settingData.music_time ~= 0 then
							arg_108_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_108_1.settingData.music_time), function()
								if arg_108_1 == nil or isNil(arg_108_1.bgmTxt_) then
									return
								end

								arg_108_1.musicController:SetSelectedState("hide")
								arg_108_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_108_1.time_ and arg_108_1.time_ <= 0.233333333333333 + arg_111_0 then
				arg_108_1:AudioAction("play", "music", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_111_5 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if "" ~= "" then
					if arg_108_1.bgmTxt_.text ~= var_111_5 and arg_108_1.bgmTxt_.text ~= "" then
						if arg_108_1.bgmTxt2_.text ~= "" then
							arg_108_1.bgmTxt_.text = arg_108_1.bgmTxt2_.text
						end

						arg_108_1.bgmTxt2_.text = var_111_5

						arg_108_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_108_1.bgmTxt_.text = var_111_5
						arg_108_1.bgmTxt2_.text = var_111_5
					end

					if arg_108_1.bgmTimer then
						arg_108_1.bgmTimer:Stop()

						arg_108_1.bgmTimer = nil
					end

					if arg_108_1.settingData.show_music_name == 1 then
						arg_108_1.musicController:SetSelectedState("show")
						arg_108_1.musicAnimator_:Play("open", 0, 0)

						if arg_108_1.settingData.music_time ~= 0 then
							arg_108_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_108_1.settingData.music_time), function()
								if arg_108_1 == nil or isNil(arg_108_1.bgmTxt_) then
									return
								end

								arg_108_1.musicController:SetSelectedState("hide")
								arg_108_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_111_6 = arg_108_1.actors_["1075ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_6) and arg_108_1.var_.characterEffect1075ui_story == nil then
				arg_108_1.var_.characterEffect1075ui_story = var_111_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_7 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 and not isNil(var_111_6) then
				if arg_108_1.var_.characterEffect1075ui_story and not isNil(var_111_6) then
					arg_108_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_7)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 and not isNil(var_111_6) and arg_108_1.var_.characterEffect1075ui_story then
				arg_108_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_111_8 = 0
			local var_111_9 = 0.05

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_10 = arg_108_1:GetWordFromCfg(120121026)
				local var_111_11 = arg_108_1:FormatText(var_111_10.content)

				arg_108_1.text_.text = var_111_11

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 2 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 2)

				if (2 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 2)) > 0 and var_111_9 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_11
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121026", "story_v_out_120121.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121026", "story_v_out_120121.awb") / 1000

					if var_111_14 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_8
					end

					if var_111_10.prefab_name ~= "" and arg_108_1.actors_[var_111_10.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_10.prefab_name].transform, "story_v_out_120121", "120121026", "story_v_out_120121.awb")

						arg_108_1:RecordAudio("120121026", var_111_15)
						arg_108_1:RecordAudio("120121026", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_120121", "120121026", "story_v_out_120121.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_120121", "120121026", "story_v_out_120121.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_16 and arg_108_1.time_ < var_111_8 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play120121027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 120121027
		arg_114_1.duration_ = 11.6

		local var_114_0 = {
			zh = 11.6,
			ja = 7.433
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
				arg_114_0:Play120121028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 3.8 < arg_114_1.time_ and arg_114_1.time_ <= 3.8 + arg_117_0 then
				arg_114_1.var_.moveOldPos1071ui_story = arg_114_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_117_0 = 0.001

			if 3.8 <= arg_114_1.time_ and arg_114_1.time_ < 3.8 + var_117_0 then
				arg_114_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_114_1.time_ - 3.8) / var_117_0)
				arg_114_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1071ui_story"].transform.position).z)
				arg_114_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1071ui_story"].transform.localEulerAngles = arg_114_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 3.8 + var_117_0 and arg_114_1.time_ < 3.8 + var_117_0 + arg_117_0 then
				arg_114_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_114_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1071ui_story"].transform.position).z)
				arg_114_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1071ui_story"].transform.localEulerAngles = arg_114_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_117_1 = arg_114_1.actors_["1075ui_story"].transform

			if 3.8 < arg_114_1.time_ and arg_114_1.time_ <= 3.8 + arg_117_0 then
				arg_114_1.var_.moveOldPos1075ui_story = var_117_1.localPosition
			end

			local var_117_2 = 0.001

			if 3.8 <= arg_114_1.time_ and arg_114_1.time_ < 3.8 + var_117_2 then
				var_117_1.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_114_1.time_ - 3.8) / var_117_2)
				var_117_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_1.position).x, (manager.ui.mainCamera.transform.position - var_117_1.position).y, (manager.ui.mainCamera.transform.position - var_117_1.position).z)
				var_117_1.localEulerAngles.z = 0
				var_117_1.localEulerAngles.x = 0
				var_117_1.localEulerAngles = var_117_1.localEulerAngles
			end

			if arg_114_1.time_ >= 3.8 + var_117_2 and arg_114_1.time_ < 3.8 + var_117_2 + arg_117_0 then
				var_117_1.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_117_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_1.position).x, (manager.ui.mainCamera.transform.position - var_117_1.position).y, (manager.ui.mainCamera.transform.position - var_117_1.position).z)
				var_117_1.localEulerAngles.z = 0
				var_117_1.localEulerAngles.x = 0
				var_117_1.localEulerAngles = var_117_1.localEulerAngles
			end

			local var_117_3 = arg_114_1.actors_["1071ui_story"]

			if 3.8 < arg_114_1.time_ and arg_114_1.time_ <= 3.8 + arg_117_0 and not isNil(var_117_3) and arg_114_1.var_.characterEffect1071ui_story == nil then
				arg_114_1.var_.characterEffect1071ui_story = var_117_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_4 = 0.2

			if 3.8 <= arg_114_1.time_ and arg_114_1.time_ < 3.8 + var_117_4 and not isNil(var_117_3) then
				if arg_114_1.var_.characterEffect1071ui_story and not isNil(var_117_3) then
					arg_114_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 3.8 + var_117_4 and arg_114_1.time_ < 3.8 + var_117_4 + arg_117_0 and not isNil(var_117_3) and arg_114_1.var_.characterEffect1071ui_story then
				arg_114_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_117_6 = arg_114_1.actors_["1075ui_story"]

			if 3.8 < arg_114_1.time_ and arg_114_1.time_ <= 3.8 + arg_117_0 and not isNil(var_117_6) and arg_114_1.var_.characterEffect1075ui_story == nil then
				arg_114_1.var_.characterEffect1075ui_story = var_117_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_7 = 0.034

			if 3.8 <= arg_114_1.time_ and arg_114_1.time_ < 3.8 + var_117_7 and not isNil(var_117_6) then
				if arg_114_1.var_.characterEffect1075ui_story and not isNil(var_117_6) then
					arg_114_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 3.8) / var_117_7)
				end
			end

			if arg_114_1.time_ >= 3.8 + var_117_7 and arg_114_1.time_ < 3.8 + var_117_7 + arg_117_0 and not isNil(var_117_6) and arg_114_1.var_.characterEffect1075ui_story then
				arg_114_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 3.8 < arg_114_1.time_ and arg_114_1.time_ <= 3.8 + arg_117_0 then
				arg_114_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action7_1")
			end

			if 3.8 < arg_114_1.time_ and arg_114_1.time_ <= 3.8 + arg_117_0 then
				arg_114_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_117_8 = 0

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_9 = 2

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_9 then
				local var_117_10 = Color.New(0, 0, 0)

				var_117_10.a = Mathf.Lerp(0, 1, (arg_114_1.time_ - var_117_8) / var_117_9)
				arg_114_1.mask_.color = var_117_10
			end

			if arg_114_1.time_ >= var_117_8 + var_117_9 and arg_114_1.time_ < var_117_8 + var_117_9 + arg_117_0 then
				local var_117_11 = Color.New(0, 0, 0)

				var_117_11.a = 1
				arg_114_1.mask_.color = var_117_11
			end

			local var_117_12 = 2

			if 2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_13 = 2

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_13 then
				local var_117_14 = Color.New(0, 0, 0)

				var_117_14.a = Mathf.Lerp(1, 0, (arg_114_1.time_ - var_117_12) / var_117_13)
				arg_114_1.mask_.color = var_117_14
			end

			if arg_114_1.time_ >= var_117_12 + var_117_13 and arg_114_1.time_ < var_117_12 + var_117_13 + arg_117_0 then
				local var_117_15 = Color.New(0, 0, 0)

				arg_114_1.mask_.enabled = false
				var_117_15.a = 0
				arg_114_1.mask_.color = var_117_15
			end

			local var_117_16 = arg_114_1.actors_["1075ui_story"].transform

			if 1.966 < arg_114_1.time_ and arg_114_1.time_ <= 1.966 + arg_117_0 then
				arg_114_1.var_.moveOldPos1075ui_story = var_117_16.localPosition
			end

			local var_117_17 = 0.001

			if 1.966 <= arg_114_1.time_ and arg_114_1.time_ < 1.966 + var_117_17 then
				var_117_16.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 1.966) / var_117_17)
				var_117_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_16.position).x, (manager.ui.mainCamera.transform.position - var_117_16.position).y, (manager.ui.mainCamera.transform.position - var_117_16.position).z)
				var_117_16.localEulerAngles.z = 0
				var_117_16.localEulerAngles.x = 0
				var_117_16.localEulerAngles = var_117_16.localEulerAngles
			end

			if arg_114_1.time_ >= 1.966 + var_117_17 and arg_114_1.time_ < 1.966 + var_117_17 + arg_117_0 then
				var_117_16.localPosition = Vector3.New(0, 100, 0)
				var_117_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_16.position).x, (manager.ui.mainCamera.transform.position - var_117_16.position).y, (manager.ui.mainCamera.transform.position - var_117_16.position).z)
				var_117_16.localEulerAngles.z = 0
				var_117_16.localEulerAngles.x = 0
				var_117_16.localEulerAngles = var_117_16.localEulerAngles
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_18 = 4
			local var_117_19 = 0.625

			if 4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_20 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_20:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_21 = arg_114_1:GetWordFromCfg(120121027)
				local var_117_22 = arg_114_1:FormatText(var_117_21.content)

				arg_114_1.text_.text = var_117_22

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_24 = 25 <= 0 and var_117_19 or var_117_19 * (utf8.len(var_117_22) / 25)

				if (25 <= 0 and var_117_19 or var_117_19 * (utf8.len(var_117_22) / 25)) > 0 and var_117_19 < var_117_24 then
					arg_114_1.talkMaxDuration = var_117_24
					var_117_18 = var_117_18 + 0.3

					if var_117_24 + var_117_18 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_24 + var_117_18
					end
				end

				arg_114_1.text_.text = var_117_22
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121027", "story_v_out_120121.awb") ~= 0 then
					local var_117_25 = manager.audio:GetVoiceLength("story_v_out_120121", "120121027", "story_v_out_120121.awb") / 1000

					if var_117_25 + var_117_18 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_25 + var_117_18
					end

					if var_117_21.prefab_name ~= "" and arg_114_1.actors_[var_117_21.prefab_name] ~= nil then
						local var_117_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_21.prefab_name].transform, "story_v_out_120121", "120121027", "story_v_out_120121.awb")

						arg_114_1:RecordAudio("120121027", var_117_26)
						arg_114_1:RecordAudio("120121027", var_117_26)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_120121", "120121027", "story_v_out_120121.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_120121", "120121027", "story_v_out_120121.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_27 = var_117_18 + 0.3
			local var_117_28 = math.max(var_117_19, arg_114_1.talkMaxDuration)

			if var_117_18 + 0.3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_27 + var_117_28 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_27) / var_117_28

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_27 + var_117_28 and arg_114_1.time_ < var_117_27 + var_117_28 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play120121028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 120121028
		arg_120_1.duration_ = 5.9

		local var_120_0 = {
			zh = 5.566,
			ja = 5.9
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
				arg_120_0:Play120121029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1071ui_story"]) and arg_120_1.var_.characterEffect1071ui_story == nil then
				arg_120_1.var_.characterEffect1071ui_story = arg_120_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1071ui_story"]) then
				if arg_120_1.var_.characterEffect1071ui_story and not isNil(arg_120_1.actors_["1071ui_story"]) then
					arg_120_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1071ui_story"]) and arg_120_1.var_.characterEffect1071ui_story then
				arg_120_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_123_1 = arg_120_1.actors_["1075ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1075ui_story == nil then
				arg_120_1.var_.characterEffect1075ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect1075ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1075ui_story then
				arg_120_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_123_4 = 0
			local var_123_5 = 0.7

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(120121028)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 28 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 28)

				if (28 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 28)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121028", "story_v_out_120121.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121028", "story_v_out_120121.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_120121", "120121028", "story_v_out_120121.awb")

						arg_120_1:RecordAudio("120121028", var_123_11)
						arg_120_1:RecordAudio("120121028", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_120121", "120121028", "story_v_out_120121.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_120121", "120121028", "story_v_out_120121.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_12 and arg_120_1.time_ < var_123_4 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play120121029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 120121029
		arg_124_1.duration_ = 6.93

		local var_124_0 = {
			zh = 3.533,
			ja = 6.933
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
				arg_124_0:Play120121030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1071ui_story"]) and arg_124_1.var_.characterEffect1071ui_story == nil then
				arg_124_1.var_.characterEffect1071ui_story = arg_124_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1071ui_story"]) then
				if arg_124_1.var_.characterEffect1071ui_story and not isNil(arg_124_1.actors_["1071ui_story"]) then
					arg_124_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1071ui_story"]) and arg_124_1.var_.characterEffect1071ui_story then
				arg_124_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_127_2 = arg_124_1.actors_["1075ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect1075ui_story == nil then
				arg_124_1.var_.characterEffect1075ui_story = var_127_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_3 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.characterEffect1075ui_story and not isNil(var_127_2) then
					arg_124_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_3)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect1075ui_story then
				arg_124_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action7_2")
			end

			local var_127_4 = 0
			local var_127_5 = 0.4

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(120121029)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 16 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 16)

				if (16 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 16)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121029", "story_v_out_120121.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121029", "story_v_out_120121.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_out_120121", "120121029", "story_v_out_120121.awb")

						arg_124_1:RecordAudio("120121029", var_127_11)
						arg_124_1:RecordAudio("120121029", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_120121", "120121029", "story_v_out_120121.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_120121", "120121029", "story_v_out_120121.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_12 and arg_124_1.time_ < var_127_4 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play120121030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 120121030
		arg_128_1.duration_ = 4.53

		local var_128_0 = {
			zh = 2.133,
			ja = 4.533
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
				arg_128_0:Play120121031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1071ui_story = arg_128_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1071ui_story"].transform.position).z)
				arg_128_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1071ui_story"].transform.localEulerAngles = arg_128_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_128_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1071ui_story"].transform.position).z)
				arg_128_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1071ui_story"].transform.localEulerAngles = arg_128_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["1075ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1075ui_story = var_131_1.localPosition
			end

			local var_131_2 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 then
				var_131_1.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_128_1.time_ - 0) / var_131_2)
				var_131_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_1.position).x, (manager.ui.mainCamera.transform.position - var_131_1.position).y, (manager.ui.mainCamera.transform.position - var_131_1.position).z)
				var_131_1.localEulerAngles.z = 0
				var_131_1.localEulerAngles.x = 0
				var_131_1.localEulerAngles = var_131_1.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 then
				var_131_1.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_131_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_1.position).x, (manager.ui.mainCamera.transform.position - var_131_1.position).y, (manager.ui.mainCamera.transform.position - var_131_1.position).z)
				var_131_1.localEulerAngles.z = 0
				var_131_1.localEulerAngles.x = 0
				var_131_1.localEulerAngles = var_131_1.localEulerAngles
			end

			local var_131_3 = arg_128_1.actors_["1071ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1071ui_story == nil then
				arg_128_1.var_.characterEffect1071ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect1071ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_4)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1071ui_story then
				arg_128_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_131_5 = arg_128_1.actors_["1075ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_5) and arg_128_1.var_.characterEffect1075ui_story == nil then
				arg_128_1.var_.characterEffect1075ui_story = var_131_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_6 and not isNil(var_131_5) then
				if arg_128_1.var_.characterEffect1075ui_story and not isNil(var_131_5) then
					arg_128_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_6 and arg_128_1.time_ < 0 + var_131_6 + arg_131_0 and not isNil(var_131_5) and arg_128_1.var_.characterEffect1075ui_story then
				arg_128_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_131_8 = 0
			local var_131_9 = 0.25

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_10 = arg_128_1:GetWordFromCfg(120121030)
				local var_131_11 = arg_128_1:FormatText(var_131_10.content)

				arg_128_1.text_.text = var_131_11

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_13 = 10 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_11) / 10)

				if (10 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_11) / 10)) > 0 and var_131_9 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_8
					end
				end

				arg_128_1.text_.text = var_131_11
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121030", "story_v_out_120121.awb") ~= 0 then
					local var_131_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121030", "story_v_out_120121.awb") / 1000

					if var_131_14 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_8
					end

					if var_131_10.prefab_name ~= "" and arg_128_1.actors_[var_131_10.prefab_name] ~= nil then
						local var_131_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_10.prefab_name].transform, "story_v_out_120121", "120121030", "story_v_out_120121.awb")

						arg_128_1:RecordAudio("120121030", var_131_15)
						arg_128_1:RecordAudio("120121030", var_131_15)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_120121", "120121030", "story_v_out_120121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_120121", "120121030", "story_v_out_120121.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_9, arg_128_1.talkMaxDuration)

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_8) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_8 + var_131_16 and arg_128_1.time_ < var_131_8 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_128_1:InitPlayNodeList()
	end,
	Play120121031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 120121031
		arg_132_1.duration_ = 3.3

		local var_132_0 = {
			zh = 3.3,
			ja = 3.2
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
				arg_132_0:Play120121032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1071ui_story = arg_132_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1071ui_story"].transform.position).z)
				arg_132_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1071ui_story"].transform.localEulerAngles = arg_132_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_132_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1071ui_story"].transform.position).z)
				arg_132_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1071ui_story"].transform.localEulerAngles = arg_132_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["1075ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1075ui_story = var_135_1.localPosition
			end

			local var_135_2 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 then
				var_135_1.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_132_1.time_ - 0) / var_135_2)
				var_135_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_1.position).x, (manager.ui.mainCamera.transform.position - var_135_1.position).y, (manager.ui.mainCamera.transform.position - var_135_1.position).z)
				var_135_1.localEulerAngles.z = 0
				var_135_1.localEulerAngles.x = 0
				var_135_1.localEulerAngles = var_135_1.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 then
				var_135_1.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_135_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_1.position).x, (manager.ui.mainCamera.transform.position - var_135_1.position).y, (manager.ui.mainCamera.transform.position - var_135_1.position).z)
				var_135_1.localEulerAngles.z = 0
				var_135_1.localEulerAngles.x = 0
				var_135_1.localEulerAngles = var_135_1.localEulerAngles
			end

			local var_135_3 = arg_132_1.actors_["1071ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect1071ui_story == nil then
				arg_132_1.var_.characterEffect1071ui_story = var_135_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_4 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 and not isNil(var_135_3) then
				if arg_132_1.var_.characterEffect1071ui_story and not isNil(var_135_3) then
					arg_132_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect1071ui_story then
				arg_132_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_135_6 = arg_132_1.actors_["1075ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1075ui_story == nil then
				arg_132_1.var_.characterEffect1075ui_story = var_135_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_7 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 and not isNil(var_135_6) then
				if arg_132_1.var_.characterEffect1075ui_story and not isNil(var_135_6) then
					arg_132_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_7)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect1075ui_story then
				arg_132_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_135_8 = 0
			local var_135_9 = 0.35

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_8 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_10 = arg_132_1:GetWordFromCfg(120121031)
				local var_135_11 = arg_132_1:FormatText(var_135_10.content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 14 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 14)

				if (14 <= 0 and var_135_9 or var_135_9 * (utf8.len(var_135_11) / 14)) > 0 and var_135_9 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_8
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121031", "story_v_out_120121.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121031", "story_v_out_120121.awb") / 1000

					if var_135_14 + var_135_8 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_8
					end

					if var_135_10.prefab_name ~= "" and arg_132_1.actors_[var_135_10.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_10.prefab_name].transform, "story_v_out_120121", "120121031", "story_v_out_120121.awb")

						arg_132_1:RecordAudio("120121031", var_135_15)
						arg_132_1:RecordAudio("120121031", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_120121", "120121031", "story_v_out_120121.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_120121", "120121031", "story_v_out_120121.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_9, arg_132_1.talkMaxDuration)

			if var_135_8 <= arg_132_1.time_ and arg_132_1.time_ < var_135_8 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_8) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_8 + var_135_16 and arg_132_1.time_ < var_135_8 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_132_1:InitPlayNodeList()
	end,
	Play120121032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 120121032
		arg_136_1.duration_ = 8.37

		local var_136_0 = {
			zh = 5.7,
			ja = 8.366
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
				arg_136_0:Play120121033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.675

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:GetWordFromCfg(120121032)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 27 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 27)

				if (27 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 27)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121032", "story_v_out_120121.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_120121", "120121032", "story_v_out_120121.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_120121", "120121032", "story_v_out_120121.awb")

						arg_136_1:RecordAudio("120121032", var_139_6)
						arg_136_1:RecordAudio("120121032", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_120121", "120121032", "story_v_out_120121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_120121", "120121032", "story_v_out_120121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play120121033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 120121033
		arg_140_1.duration_ = 6.13

		local var_140_0 = {
			zh = 4.933,
			ja = 6.133
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
				arg_140_0:Play120121034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1071ui_story = arg_140_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1071ui_story"].transform.position).z)
				arg_140_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1071ui_story"].transform.localEulerAngles = arg_140_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_140_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1071ui_story"].transform.position).z)
				arg_140_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1071ui_story"].transform.localEulerAngles = arg_140_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_143_1 = arg_140_1.actors_["1075ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1075ui_story = var_143_1.localPosition
			end

			local var_143_2 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 then
				var_143_1.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_140_1.time_ - 0) / var_143_2)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 then
				var_143_1.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			local var_143_3 = arg_140_1.actors_["1071ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1071ui_story == nil then
				arg_140_1.var_.characterEffect1071ui_story = var_143_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_4 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 and not isNil(var_143_3) then
				if arg_140_1.var_.characterEffect1071ui_story and not isNil(var_143_3) then
					arg_140_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_4)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1071ui_story then
				arg_140_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_143_5 = arg_140_1.actors_["1075ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_5) and arg_140_1.var_.characterEffect1075ui_story == nil then
				arg_140_1.var_.characterEffect1075ui_story = var_143_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_6 and not isNil(var_143_5) then
				if arg_140_1.var_.characterEffect1075ui_story and not isNil(var_143_5) then
					arg_140_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_6 and arg_140_1.time_ < 0 + var_143_6 + arg_143_0 and not isNil(var_143_5) and arg_140_1.var_.characterEffect1075ui_story then
				arg_140_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_143_8 = 0
			local var_143_9 = 0.625

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:GetWordFromCfg(120121033)
				local var_143_11 = arg_140_1:FormatText(var_143_10.content)

				arg_140_1.text_.text = var_143_11

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 25 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 25)

				if (25 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 25)) > 0 and var_143_9 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_11
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121033", "story_v_out_120121.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121033", "story_v_out_120121.awb") / 1000

					if var_143_14 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_8
					end

					if var_143_10.prefab_name ~= "" and arg_140_1.actors_[var_143_10.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_10.prefab_name].transform, "story_v_out_120121", "120121033", "story_v_out_120121.awb")

						arg_140_1:RecordAudio("120121033", var_143_15)
						arg_140_1:RecordAudio("120121033", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_120121", "120121033", "story_v_out_120121.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_120121", "120121033", "story_v_out_120121.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_16 and arg_140_1.time_ < var_143_8 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_140_1:InitPlayNodeList()
	end,
	Play120121034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 120121034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play120121035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1071ui_story = arg_144_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_147_0 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				arg_144_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_0)
				arg_144_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1071ui_story"].transform.position).z)
				arg_144_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1071ui_story"].transform.localEulerAngles = arg_144_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				arg_144_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1071ui_story"].transform.position).z)
				arg_144_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1071ui_story"].transform.localEulerAngles = arg_144_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_147_1 = arg_144_1.actors_["1075ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1075ui_story = var_147_1.localPosition
			end

			local var_147_2 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 then
				var_147_1.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_2)
				var_147_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_1.position).x, (manager.ui.mainCamera.transform.position - var_147_1.position).y, (manager.ui.mainCamera.transform.position - var_147_1.position).z)
				var_147_1.localEulerAngles.z = 0
				var_147_1.localEulerAngles.x = 0
				var_147_1.localEulerAngles = var_147_1.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 then
				var_147_1.localPosition = Vector3.New(0, 100, 0)
				var_147_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_1.position).x, (manager.ui.mainCamera.transform.position - var_147_1.position).y, (manager.ui.mainCamera.transform.position - var_147_1.position).z)
				var_147_1.localEulerAngles.z = 0
				var_147_1.localEulerAngles.x = 0
				var_147_1.localEulerAngles = var_147_1.localEulerAngles
			end

			local var_147_3 = 0
			local var_147_4 = 1.25

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_3 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_5 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(120121034).content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 50 <= 0 and var_147_4 or var_147_4 * (utf8.len(var_147_5) / 50)

				if (50 <= 0 and var_147_4 or var_147_4 * (utf8.len(var_147_5) / 50)) > 0 and var_147_4 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_3 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_3
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_4, arg_144_1.talkMaxDuration)

			if var_147_3 <= arg_144_1.time_ and arg_144_1.time_ < var_147_3 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_3) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_3 + var_147_8 and arg_144_1.time_ < var_147_3 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_144_1:InitPlayNodeList()
	end,
	Play120121035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 120121035
		arg_148_1.duration_ = 4.73

		local var_148_0 = {
			zh = 2.066,
			ja = 4.733
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
				arg_148_0:Play120121036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1071ui_story"]) and arg_148_1.var_.characterEffect1071ui_story == nil then
				arg_148_1.var_.characterEffect1071ui_story = arg_148_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1071ui_story"]) then
				if arg_148_1.var_.characterEffect1071ui_story and not isNil(arg_148_1.actors_["1071ui_story"]) then
					arg_148_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1071ui_story"]) and arg_148_1.var_.characterEffect1071ui_story then
				arg_148_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_151_2 = arg_148_1.actors_["1075ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect1075ui_story == nil then
				arg_148_1.var_.characterEffect1075ui_story = var_151_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_3 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 and not isNil(var_151_2) then
				if arg_148_1.var_.characterEffect1075ui_story and not isNil(var_151_2) then
					arg_148_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_3)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect1075ui_story then
				arg_148_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_151_4 = arg_148_1.actors_["1071ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1071ui_story = var_151_4.localPosition
			end

			local var_151_5 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_5 then
				var_151_4.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_148_1.time_ - 0) / var_151_5)
				var_151_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_4.position).x, (manager.ui.mainCamera.transform.position - var_151_4.position).y, (manager.ui.mainCamera.transform.position - var_151_4.position).z)
				var_151_4.localEulerAngles.z = 0
				var_151_4.localEulerAngles.x = 0
				var_151_4.localEulerAngles = var_151_4.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_5 and arg_148_1.time_ < 0 + var_151_5 + arg_151_0 then
				var_151_4.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				var_151_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_4.position).x, (manager.ui.mainCamera.transform.position - var_151_4.position).y, (manager.ui.mainCamera.transform.position - var_151_4.position).z)
				var_151_4.localEulerAngles.z = 0
				var_151_4.localEulerAngles.x = 0
				var_151_4.localEulerAngles = var_151_4.localEulerAngles
			end

			local var_151_6 = arg_148_1.actors_["1075ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1075ui_story = var_151_6.localPosition
			end

			local var_151_7 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				var_151_6.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_148_1.time_ - 0) / var_151_7)
				var_151_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_6.position).x, (manager.ui.mainCamera.transform.position - var_151_6.position).y, (manager.ui.mainCamera.transform.position - var_151_6.position).z)
				var_151_6.localEulerAngles.z = 0
				var_151_6.localEulerAngles.x = 0
				var_151_6.localEulerAngles = var_151_6.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				var_151_6.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_151_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_6.position).x, (manager.ui.mainCamera.transform.position - var_151_6.position).y, (manager.ui.mainCamera.transform.position - var_151_6.position).z)
				var_151_6.localEulerAngles.z = 0
				var_151_6.localEulerAngles.x = 0
				var_151_6.localEulerAngles = var_151_6.localEulerAngles
			end

			local var_151_8 = 0
			local var_151_9 = 0.225

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_8 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_10 = arg_148_1:GetWordFromCfg(120121035)
				local var_151_11 = arg_148_1:FormatText(var_151_10.content)

				arg_148_1.text_.text = var_151_11

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 9 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 9)

				if (9 <= 0 and var_151_9 or var_151_9 * (utf8.len(var_151_11) / 9)) > 0 and var_151_9 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_8
					end
				end

				arg_148_1.text_.text = var_151_11
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121035", "story_v_out_120121.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_120121", "120121035", "story_v_out_120121.awb") / 1000

					if var_151_14 + var_151_8 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_8
					end

					if var_151_10.prefab_name ~= "" and arg_148_1.actors_[var_151_10.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_10.prefab_name].transform, "story_v_out_120121", "120121035", "story_v_out_120121.awb")

						arg_148_1:RecordAudio("120121035", var_151_15)
						arg_148_1:RecordAudio("120121035", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_120121", "120121035", "story_v_out_120121.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_120121", "120121035", "story_v_out_120121.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_9, arg_148_1.talkMaxDuration)

			if var_151_8 <= arg_148_1.time_ and arg_148_1.time_ < var_151_8 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_8) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_8 + var_151_16 and arg_148_1.time_ < var_151_8 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_148_1:InitPlayNodeList()
	end,
	Play120121036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 120121036
		arg_152_1.duration_ = 7.4

		local var_152_0 = {
			zh = 7.4,
			ja = 6.8
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
				arg_152_0:Play120121037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1071ui_story"]) and arg_152_1.var_.characterEffect1071ui_story == nil then
				arg_152_1.var_.characterEffect1071ui_story = arg_152_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1071ui_story"]) then
				if arg_152_1.var_.characterEffect1071ui_story and not isNil(arg_152_1.actors_["1071ui_story"]) then
					arg_152_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_0)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1071ui_story"]) and arg_152_1.var_.characterEffect1071ui_story then
				arg_152_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_155_1 = arg_152_1.actors_["1075ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1075ui_story == nil then
				arg_152_1.var_.characterEffect1075ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect1075ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1075ui_story then
				arg_152_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_155_4 = 0
			local var_155_5 = 1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(120121036)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 42 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 42)

				if (42 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 42)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121036", "story_v_out_120121.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121036", "story_v_out_120121.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_120121", "120121036", "story_v_out_120121.awb")

						arg_152_1:RecordAudio("120121036", var_155_11)
						arg_152_1:RecordAudio("120121036", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_120121", "120121036", "story_v_out_120121.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_120121", "120121036", "story_v_out_120121.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play120121037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 120121037
		arg_156_1.duration_ = 5.77

		local var_156_0 = {
			zh = 4.066,
			ja = 5.766
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
				arg_156_0:Play120121038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1071ui_story"]) and arg_156_1.var_.characterEffect1071ui_story == nil then
				arg_156_1.var_.characterEffect1071ui_story = arg_156_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1071ui_story"]) then
				if arg_156_1.var_.characterEffect1071ui_story and not isNil(arg_156_1.actors_["1071ui_story"]) then
					arg_156_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1071ui_story"]) and arg_156_1.var_.characterEffect1071ui_story then
				arg_156_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_159_2 = arg_156_1.actors_["1075ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.characterEffect1075ui_story == nil then
				arg_156_1.var_.characterEffect1075ui_story = var_159_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_3 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_3 and not isNil(var_159_2) then
				if arg_156_1.var_.characterEffect1075ui_story and not isNil(var_159_2) then
					arg_156_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_3)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_3 and arg_156_1.time_ < 0 + var_159_3 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.characterEffect1075ui_story then
				arg_156_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action3_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_159_4 = 0
			local var_159_5 = 0.45

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(120121037)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 18 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 18)

				if (18 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 18)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121037", "story_v_out_120121.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121037", "story_v_out_120121.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_out_120121", "120121037", "story_v_out_120121.awb")

						arg_156_1:RecordAudio("120121037", var_159_11)
						arg_156_1:RecordAudio("120121037", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_120121", "120121037", "story_v_out_120121.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_120121", "120121037", "story_v_out_120121.awb")
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
	Play120121038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 120121038
		arg_160_1.duration_ = 4.6

		local var_160_0 = {
			zh = 4.6,
			ja = 3
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play120121039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action435")
			end

			local var_163_0 = 0
			local var_163_1 = 0.5

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_2 = arg_160_1:GetWordFromCfg(120121038)
				local var_163_3 = arg_160_1:FormatText(var_163_2.content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 20 <= 0 and var_163_1 or var_163_1 * (utf8.len(var_163_3) / 20)

				if (20 <= 0 and var_163_1 or var_163_1 * (utf8.len(var_163_3) / 20)) > 0 and var_163_1 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121038", "story_v_out_120121.awb") ~= 0 then
					local var_163_6 = manager.audio:GetVoiceLength("story_v_out_120121", "120121038", "story_v_out_120121.awb") / 1000

					if var_163_6 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_0
					end

					if var_163_2.prefab_name ~= "" and arg_160_1.actors_[var_163_2.prefab_name] ~= nil then
						local var_163_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_2.prefab_name].transform, "story_v_out_120121", "120121038", "story_v_out_120121.awb")

						arg_160_1:RecordAudio("120121038", var_163_7)
						arg_160_1:RecordAudio("120121038", var_163_7)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_120121", "120121038", "story_v_out_120121.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_120121", "120121038", "story_v_out_120121.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_8 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_8 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_8

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_8 and arg_160_1.time_ < var_163_0 + var_163_8 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play120121039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 120121039
		arg_164_1.duration_ = 5.5

		local var_164_0 = {
			zh = 5.5,
			ja = 4.766
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
				arg_164_0:Play120121040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_167_0 = 0
			local var_167_1 = 0.425

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_2 = arg_164_1:GetWordFromCfg(120121039)
				local var_167_3 = arg_164_1:FormatText(var_167_2.content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 17 <= 0 and var_167_1 or var_167_1 * (utf8.len(var_167_3) / 17)

				if (17 <= 0 and var_167_1 or var_167_1 * (utf8.len(var_167_3) / 17)) > 0 and var_167_1 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121039", "story_v_out_120121.awb") ~= 0 then
					local var_167_6 = manager.audio:GetVoiceLength("story_v_out_120121", "120121039", "story_v_out_120121.awb") / 1000

					if var_167_6 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_0
					end

					if var_167_2.prefab_name ~= "" and arg_164_1.actors_[var_167_2.prefab_name] ~= nil then
						local var_167_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_2.prefab_name].transform, "story_v_out_120121", "120121039", "story_v_out_120121.awb")

						arg_164_1:RecordAudio("120121039", var_167_7)
						arg_164_1:RecordAudio("120121039", var_167_7)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_120121", "120121039", "story_v_out_120121.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_120121", "120121039", "story_v_out_120121.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_8 and arg_164_1.time_ < var_167_0 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play120121040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 120121040
		arg_168_1.duration_ = 4.77

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play120121041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1071ui_story"]) and arg_168_1.var_.characterEffect1071ui_story == nil then
				arg_168_1.var_.characterEffect1071ui_story = arg_168_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1071ui_story"]) then
				if arg_168_1.var_.characterEffect1071ui_story and not isNil(arg_168_1.actors_["1071ui_story"]) then
					arg_168_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_0)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1071ui_story"]) and arg_168_1.var_.characterEffect1071ui_story then
				arg_168_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_171_1 = arg_168_1.actors_["1075ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1075ui_story == nil then
				arg_168_1.var_.characterEffect1075ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect1075ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1075ui_story then
				arg_168_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_171_4 = 0
			local var_171_5 = 0.575

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(120121040)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 23 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 23)

				if (23 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 23)) > 0 and var_171_5 < var_171_9 then
					arg_168_1.talkMaxDuration = var_171_9

					if var_171_9 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121040", "story_v_out_120121.awb") ~= 0 then
					local var_171_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121040", "story_v_out_120121.awb") / 1000

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end

					if var_171_6.prefab_name ~= "" and arg_168_1.actors_[var_171_6.prefab_name] ~= nil then
						local var_171_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_6.prefab_name].transform, "story_v_out_120121", "120121040", "story_v_out_120121.awb")

						arg_168_1:RecordAudio("120121040", var_171_11)
						arg_168_1:RecordAudio("120121040", var_171_11)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_120121", "120121040", "story_v_out_120121.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_120121", "120121040", "story_v_out_120121.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_12 and arg_168_1.time_ < var_171_4 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play120121041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 120121041
		arg_172_1.duration_ = 3.4

		local var_172_0 = {
			zh = 3.1,
			ja = 3.4
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play120121042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1071ui_story"]) and arg_172_1.var_.characterEffect1071ui_story == nil then
				arg_172_1.var_.characterEffect1071ui_story = arg_172_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1071ui_story"]) then
				if arg_172_1.var_.characterEffect1071ui_story and not isNil(arg_172_1.actors_["1071ui_story"]) then
					arg_172_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1071ui_story"]) and arg_172_1.var_.characterEffect1071ui_story then
				arg_172_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_175_2 = arg_172_1.actors_["1075ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect1075ui_story == nil then
				arg_172_1.var_.characterEffect1075ui_story = var_175_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_3 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 and not isNil(var_175_2) then
				if arg_172_1.var_.characterEffect1075ui_story and not isNil(var_175_2) then
					arg_172_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_3)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect1075ui_story then
				arg_172_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action6_1")
			end

			local var_175_4 = 0
			local var_175_5 = 0.275

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:GetWordFromCfg(120121041)
				local var_175_7 = arg_172_1:FormatText(var_175_6.content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 11 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 11)

				if (11 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 11)) > 0 and var_175_5 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121041", "story_v_out_120121.awb") ~= 0 then
					local var_175_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121041", "story_v_out_120121.awb") / 1000

					if var_175_10 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_4
					end

					if var_175_6.prefab_name ~= "" and arg_172_1.actors_[var_175_6.prefab_name] ~= nil then
						local var_175_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_6.prefab_name].transform, "story_v_out_120121", "120121041", "story_v_out_120121.awb")

						arg_172_1:RecordAudio("120121041", var_175_11)
						arg_172_1:RecordAudio("120121041", var_175_11)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_120121", "120121041", "story_v_out_120121.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_120121", "120121041", "story_v_out_120121.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_12 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_12 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_12

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_12 and arg_172_1.time_ < var_175_4 + var_175_12 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play120121042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 120121042
		arg_176_1.duration_ = 9.57

		local var_176_0 = {
			zh = 5.1,
			ja = 9.566
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
				arg_176_0:Play120121043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1071ui_story"]) and arg_176_1.var_.characterEffect1071ui_story == nil then
				arg_176_1.var_.characterEffect1071ui_story = arg_176_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1071ui_story"]) then
				if arg_176_1.var_.characterEffect1071ui_story and not isNil(arg_176_1.actors_["1071ui_story"]) then
					arg_176_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_0)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1071ui_story"]) and arg_176_1.var_.characterEffect1071ui_story then
				arg_176_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_179_1 = arg_176_1.actors_["1075ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1075ui_story == nil then
				arg_176_1.var_.characterEffect1075ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect1075ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1075ui_story then
				arg_176_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_179_4 = 0
			local var_179_5 = 0.525

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_6 = arg_176_1:GetWordFromCfg(120121042)
				local var_179_7 = arg_176_1:FormatText(var_179_6.content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 21 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 21)

				if (21 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 21)) > 0 and var_179_5 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121042", "story_v_out_120121.awb") ~= 0 then
					local var_179_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121042", "story_v_out_120121.awb") / 1000

					if var_179_10 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_4
					end

					if var_179_6.prefab_name ~= "" and arg_176_1.actors_[var_179_6.prefab_name] ~= nil then
						local var_179_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_6.prefab_name].transform, "story_v_out_120121", "120121042", "story_v_out_120121.awb")

						arg_176_1:RecordAudio("120121042", var_179_11)
						arg_176_1:RecordAudio("120121042", var_179_11)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_120121", "120121042", "story_v_out_120121.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_120121", "120121042", "story_v_out_120121.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_12 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_12 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_12

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_12 and arg_176_1.time_ < var_179_4 + var_179_12 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play120121043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 120121043
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play120121044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1071ui_story = arg_180_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1071ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1071ui_story"].transform.position).z)
				arg_180_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1071ui_story"].transform.localEulerAngles = arg_180_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_180_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1071ui_story"].transform.position).z)
				arg_180_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1071ui_story"].transform.localEulerAngles = arg_180_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["1075ui_story"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1075ui_story = var_183_1.localPosition
			end

			local var_183_2 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 then
				var_183_1.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_2)
				var_183_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_1.position).x, (manager.ui.mainCamera.transform.position - var_183_1.position).y, (manager.ui.mainCamera.transform.position - var_183_1.position).z)
				var_183_1.localEulerAngles.z = 0
				var_183_1.localEulerAngles.x = 0
				var_183_1.localEulerAngles = var_183_1.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 then
				var_183_1.localPosition = Vector3.New(0, 100, 0)
				var_183_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_1.position).x, (manager.ui.mainCamera.transform.position - var_183_1.position).y, (manager.ui.mainCamera.transform.position - var_183_1.position).z)
				var_183_1.localEulerAngles.z = 0
				var_183_1.localEulerAngles.x = 0
				var_183_1.localEulerAngles = var_183_1.localEulerAngles
			end

			local var_183_3 = 0
			local var_183_4 = 0.55

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_3 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_5 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(120121043).content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 22 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_5) / 22)

				if (22 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_5) / 22)) > 0 and var_183_4 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_3
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_4, arg_180_1.talkMaxDuration)

			if var_183_3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_3 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_3) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_3 + var_183_8 and arg_180_1.time_ < var_183_3 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_180_1:InitPlayNodeList()
	end,
	Play120121044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 120121044
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play120121045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0.925

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_1 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(120121044).content)

				arg_184_1.text_.text = var_187_1

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_3 = 37 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_1) / 37)

				if (37 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_1) / 37)) > 0 and var_187_0 < var_187_3 then
					arg_184_1.talkMaxDuration = var_187_3

					if var_187_3 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_3 + 0
					end
				end

				arg_184_1.text_.text = var_187_1
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_4 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_4

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play120121045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 120121045
		arg_188_1.duration_ = 10.57

		local var_188_0 = {
			zh = 5.666,
			ja = 10.566
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
				arg_188_0:Play120121046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1071ui_story = arg_188_1.actors_["1071ui_story"].transform.localPosition
			end

			local var_191_0 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 then
				arg_188_1.actors_["1071ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1071ui_story, Vector3.New(-0.7, -1.05, -6.2), (arg_188_1.time_ - 0) / var_191_0)
				arg_188_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1071ui_story"].transform.position).z)
				arg_188_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1071ui_story"].transform.localEulerAngles = arg_188_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 then
				arg_188_1.actors_["1071ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.2)
				arg_188_1.actors_["1071ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1071ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1071ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1071ui_story"].transform.position).z)
				arg_188_1.actors_["1071ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1071ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1071ui_story"].transform.localEulerAngles = arg_188_1.actors_["1071ui_story"].transform.localEulerAngles
			end

			local var_191_1 = arg_188_1.actors_["1075ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1075ui_story = var_191_1.localPosition
			end

			local var_191_2 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_2 then
				var_191_1.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_188_1.time_ - 0) / var_191_2)
				var_191_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_1.position).x, (manager.ui.mainCamera.transform.position - var_191_1.position).y, (manager.ui.mainCamera.transform.position - var_191_1.position).z)
				var_191_1.localEulerAngles.z = 0
				var_191_1.localEulerAngles.x = 0
				var_191_1.localEulerAngles = var_191_1.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_2 and arg_188_1.time_ < 0 + var_191_2 + arg_191_0 then
				var_191_1.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_191_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_1.position).x, (manager.ui.mainCamera.transform.position - var_191_1.position).y, (manager.ui.mainCamera.transform.position - var_191_1.position).z)
				var_191_1.localEulerAngles.z = 0
				var_191_1.localEulerAngles.x = 0
				var_191_1.localEulerAngles = var_191_1.localEulerAngles
			end

			local var_191_3 = arg_188_1.actors_["1071ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_3) and arg_188_1.var_.characterEffect1071ui_story == nil then
				arg_188_1.var_.characterEffect1071ui_story = var_191_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_4 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 and not isNil(var_191_3) then
				if arg_188_1.var_.characterEffect1071ui_story and not isNil(var_191_3) then
					arg_188_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 and not isNil(var_191_3) and arg_188_1.var_.characterEffect1071ui_story then
				arg_188_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_191_6 = arg_188_1.actors_["1075ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_6) and arg_188_1.var_.characterEffect1075ui_story == nil then
				arg_188_1.var_.characterEffect1075ui_story = var_191_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_7 = 0.034

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 and not isNil(var_191_6) then
				if arg_188_1.var_.characterEffect1075ui_story and not isNil(var_191_6) then
					arg_188_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 and not isNil(var_191_6) and arg_188_1.var_.characterEffect1075ui_story then
				arg_188_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_191_9 = arg_188_1.actors_["1075ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect1075ui_story == nil then
				arg_188_1.var_.characterEffect1075ui_story = var_191_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_10 = 0.034

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_10 and not isNil(var_191_9) then
				if arg_188_1.var_.characterEffect1075ui_story and not isNil(var_191_9) then
					arg_188_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_10)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_10 and arg_188_1.time_ < 0 + var_191_10 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect1075ui_story then
				arg_188_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_191_11 = 0
			local var_191_12 = 0.675

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_13 = arg_188_1:GetWordFromCfg(120121045)
				local var_191_14 = arg_188_1:FormatText(var_191_13.content)

				arg_188_1.text_.text = var_191_14

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_16 = 27 <= 0 and var_191_12 or var_191_12 * (utf8.len(var_191_14) / 27)

				if (27 <= 0 and var_191_12 or var_191_12 * (utf8.len(var_191_14) / 27)) > 0 and var_191_12 < var_191_16 then
					arg_188_1.talkMaxDuration = var_191_16

					if var_191_16 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_16 + var_191_11
					end
				end

				arg_188_1.text_.text = var_191_14
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121045", "story_v_out_120121.awb") ~= 0 then
					local var_191_17 = manager.audio:GetVoiceLength("story_v_out_120121", "120121045", "story_v_out_120121.awb") / 1000

					if var_191_17 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_17 + var_191_11
					end

					if var_191_13.prefab_name ~= "" and arg_188_1.actors_[var_191_13.prefab_name] ~= nil then
						local var_191_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_13.prefab_name].transform, "story_v_out_120121", "120121045", "story_v_out_120121.awb")

						arg_188_1:RecordAudio("120121045", var_191_18)
						arg_188_1:RecordAudio("120121045", var_191_18)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_120121", "120121045", "story_v_out_120121.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_120121", "120121045", "story_v_out_120121.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_19 = math.max(var_191_12, arg_188_1.talkMaxDuration)

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_19 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_11) / var_191_19

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_11 + var_191_19 and arg_188_1.time_ < var_191_11 + var_191_19 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
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

		arg_188_1:InitPlayNodeList()
	end,
	Play120121046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 120121046
		arg_192_1.duration_ = 5.23

		local var_192_0 = {
			zh = 1.999999999999,
			ja = 5.233
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
				arg_192_0:Play120121047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(arg_192_1.actors_["1071ui_story"]) and arg_192_1.var_.characterEffect1071ui_story == nil then
				arg_192_1.var_.characterEffect1071ui_story = arg_192_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_0 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_0 and not isNil(arg_192_1.actors_["1071ui_story"]) then
				if arg_192_1.var_.characterEffect1071ui_story and not isNil(arg_192_1.actors_["1071ui_story"]) then
					arg_192_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_0)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_0 and arg_192_1.time_ < 0 + var_195_0 + arg_195_0 and not isNil(arg_192_1.actors_["1071ui_story"]) and arg_192_1.var_.characterEffect1071ui_story then
				arg_192_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_195_1 = arg_192_1.actors_["1075ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_1) and arg_192_1.var_.characterEffect1075ui_story == nil then
				arg_192_1.var_.characterEffect1075ui_story = var_195_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.2

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_2 and not isNil(var_195_1) then
				if arg_192_1.var_.characterEffect1075ui_story and not isNil(var_195_1) then
					arg_192_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_2 and arg_192_1.time_ < 0 + var_195_2 + arg_195_0 and not isNil(var_195_1) and arg_192_1.var_.characterEffect1075ui_story then
				arg_192_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_195_4 = 0
			local var_195_5 = 0.225

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_6 = arg_192_1:GetWordFromCfg(120121046)
				local var_195_7 = arg_192_1:FormatText(var_195_6.content)

				arg_192_1.text_.text = var_195_7

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_9 = 9 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 9)

				if (9 <= 0 and var_195_5 or var_195_5 * (utf8.len(var_195_7) / 9)) > 0 and var_195_5 < var_195_9 then
					arg_192_1.talkMaxDuration = var_195_9

					if var_195_9 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_9 + var_195_4
					end
				end

				arg_192_1.text_.text = var_195_7
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121046", "story_v_out_120121.awb") ~= 0 then
					local var_195_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121046", "story_v_out_120121.awb") / 1000

					if var_195_10 + var_195_4 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_4
					end

					if var_195_6.prefab_name ~= "" and arg_192_1.actors_[var_195_6.prefab_name] ~= nil then
						local var_195_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_6.prefab_name].transform, "story_v_out_120121", "120121046", "story_v_out_120121.awb")

						arg_192_1:RecordAudio("120121046", var_195_11)
						arg_192_1:RecordAudio("120121046", var_195_11)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_120121", "120121046", "story_v_out_120121.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_120121", "120121046", "story_v_out_120121.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_12 = math.max(var_195_5, arg_192_1.talkMaxDuration)

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_12 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_4) / var_195_12

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_4 + var_195_12 and arg_192_1.time_ < var_195_4 + var_195_12 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play120121047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 120121047
		arg_196_1.duration_ = 5.13

		local var_196_0 = {
			zh = 4.033,
			ja = 5.133
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
				arg_196_0:Play120121048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1071ui_story"]) and arg_196_1.var_.characterEffect1071ui_story == nil then
				arg_196_1.var_.characterEffect1071ui_story = arg_196_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1071ui_story"]) then
				if arg_196_1.var_.characterEffect1071ui_story and not isNil(arg_196_1.actors_["1071ui_story"]) then
					arg_196_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1071ui_story"]) and arg_196_1.var_.characterEffect1071ui_story then
				arg_196_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_199_2 = arg_196_1.actors_["1075ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect1075ui_story == nil then
				arg_196_1.var_.characterEffect1075ui_story = var_199_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_3 = 0.2

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.characterEffect1075ui_story and not isNil(var_199_2) then
					arg_196_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_3)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect1075ui_story then
				arg_196_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_199_4 = 0
			local var_199_5 = 0.4

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_6 = arg_196_1:GetWordFromCfg(120121047)
				local var_199_7 = arg_196_1:FormatText(var_199_6.content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 16 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 16)

				if (16 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 16)) > 0 and var_199_5 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121047", "story_v_out_120121.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_120121", "120121047", "story_v_out_120121.awb") / 1000

					if var_199_10 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_4
					end

					if var_199_6.prefab_name ~= "" and arg_196_1.actors_[var_199_6.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_6.prefab_name].transform, "story_v_out_120121", "120121047", "story_v_out_120121.awb")

						arg_196_1:RecordAudio("120121047", var_199_11)
						arg_196_1:RecordAudio("120121047", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_120121", "120121047", "story_v_out_120121.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_120121", "120121047", "story_v_out_120121.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_12 and arg_196_1.time_ < var_199_4 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play120121048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 120121048
		arg_200_1.duration_ = 12.13

		local var_200_0 = {
			zh = 11.866,
			ja = 12.133
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
				arg_200_0:Play120121049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 1.375

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:GetWordFromCfg(120121048)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 55 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 55)

				if (55 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 55)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121048", "story_v_out_120121.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_120121", "120121048", "story_v_out_120121.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_120121", "120121048", "story_v_out_120121.awb")

						arg_200_1:RecordAudio("120121048", var_203_6)
						arg_200_1:RecordAudio("120121048", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_120121", "120121048", "story_v_out_120121.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_120121", "120121048", "story_v_out_120121.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play120121049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 120121049
		arg_204_1.duration_ = 11.77

		local var_204_0 = {
			zh = 7.5,
			ja = 11.766
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
				arg_204_0:Play120121050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.9

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:GetWordFromCfg(120121049)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 36 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 36)

				if (36 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 36)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121049", "story_v_out_120121.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_120121", "120121049", "story_v_out_120121.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_120121", "120121049", "story_v_out_120121.awb")

						arg_204_1:RecordAudio("120121049", var_207_6)
						arg_204_1:RecordAudio("120121049", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_120121", "120121049", "story_v_out_120121.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_120121", "120121049", "story_v_out_120121.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play120121050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 120121050
		arg_208_1.duration_ = 7.9

		local var_208_0 = {
			zh = 6.5,
			ja = 7.9
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
			arg_208_1.auto_ = false
		end

		function arg_208_1.playNext_(arg_210_0)
			arg_208_1.onStoryFinished_()
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071actionlink/1071action423")
			end

			local var_211_0 = 0
			local var_211_1 = 0.75

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_2 = arg_208_1:GetWordFromCfg(120121050)
				local var_211_3 = arg_208_1:FormatText(var_211_2.content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 30 <= 0 and var_211_1 or var_211_1 * (utf8.len(var_211_3) / 30)

				if (30 <= 0 and var_211_1 or var_211_1 * (utf8.len(var_211_3) / 30)) > 0 and var_211_1 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120121", "120121050", "story_v_out_120121.awb") ~= 0 then
					local var_211_6 = manager.audio:GetVoiceLength("story_v_out_120121", "120121050", "story_v_out_120121.awb") / 1000

					if var_211_6 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_0
					end

					if var_211_2.prefab_name ~= "" and arg_208_1.actors_[var_211_2.prefab_name] ~= nil then
						local var_211_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_2.prefab_name].transform, "story_v_out_120121", "120121050", "story_v_out_120121.awb")

						arg_208_1:RecordAudio("120121050", var_211_7)
						arg_208_1:RecordAudio("120121050", var_211_7)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_120121", "120121050", "story_v_out_120121.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_120121", "120121050", "story_v_out_120121.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_8 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_8 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_8

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_8 and arg_208_1.time_ < var_211_0 + var_211_8 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J13f"
	},
	voices = {
		"story_v_out_120121.awb"
	}
}
