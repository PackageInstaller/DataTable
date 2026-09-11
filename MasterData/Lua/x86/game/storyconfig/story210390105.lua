return {
	Play1103905001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1103905001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1103905002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B13 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_4_0.name = "B13"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B13 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B13

				arg_1_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13" then
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

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
			local var_4_15 = 1.475

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1103905001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 59 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 59)

				if (59 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 59)) > 0 and var_4_15 < var_4_19 then
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
	Play1103905002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1103905002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1103905003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.625

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(1103905002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 25 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 25)

				if (25 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 25)) > 0 and var_12_0 < var_12_3 then
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
	Play1103905003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1103905003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1103905004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.575

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1103905003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 23 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 23)

				if (23 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 23)) > 0 and var_16_0 < var_16_3 then
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
	Play1103905004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1103905004
		arg_17_1.duration_ = 8.53

		local var_17_0 = {
			zh = 4.5,
			ja = 8.533
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
				arg_17_0:Play1103905005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1039ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1039ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1039ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1039ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1039ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1039ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1039ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.01, -5.9)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1039ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1039ui_story == nil then
				arg_17_1.var_.characterEffect1039ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1039ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1039ui_story then
				arg_17_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_20_8 = 0
			local var_20_9 = 0.525

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(1103905004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 21 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 21)

				if (21 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 21)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905004", "story_v_side_new_1103905.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905004", "story_v_side_new_1103905.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_side_new_1103905", "1103905004", "story_v_side_new_1103905.awb")

						arg_17_1:RecordAudio("1103905004", var_20_15)
						arg_17_1:RecordAudio("1103905004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905004", "story_v_side_new_1103905.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905004", "story_v_side_new_1103905.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play1103905005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1103905005
		arg_21_1.duration_ = 9

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1103905006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.bgs_.ST01 == nil then
				local var_24_0 = Object.Instantiate(arg_21_1.paintGo_)

				var_24_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_24_0.name = "ST01"
				var_24_0.transform.parent = arg_21_1.stage_.transform
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.bgs_.ST01 = var_24_0
			end

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= 2 + arg_24_0 then
				local var_24_1 = arg_21_1.bgs_.ST01

				arg_21_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_2 = var_24_1:GetComponent("SpriteRenderer")

				if var_24_2 and var_24_2.sprite then
					local var_24_3 = 2 * (var_24_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_1.transform.localScale = Vector3.New(var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, var_24_3 / var_24_2.sprite.bounds.size.y < var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x and var_24_3 * manager.ui.mainCameraCom_.aspect / var_24_2.sprite.bounds.size.x or var_24_3 / var_24_2.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "ST01" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_4 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_5 = 2

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_5 then
				local var_24_6 = Color.New(0, 0, 0)

				var_24_6.a = Mathf.Lerp(0, 1, (arg_21_1.time_ - var_24_4) / var_24_5)
				arg_21_1.mask_.color = var_24_6
			end

			if arg_21_1.time_ >= var_24_4 + var_24_5 and arg_21_1.time_ < var_24_4 + var_24_5 + arg_24_0 then
				local var_24_7 = Color.New(0, 0, 0)

				var_24_7.a = 1
				arg_21_1.mask_.color = var_24_7
			end

			local var_24_8 = 2

			if 2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_9 = 2

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 then
				local var_24_10 = Color.New(0, 0, 0)

				var_24_10.a = Mathf.Lerp(1, 0, (arg_21_1.time_ - var_24_8) / var_24_9)
				arg_21_1.mask_.color = var_24_10
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 then
				local var_24_11 = Color.New(0, 0, 0)

				arg_21_1.mask_.enabled = false
				var_24_11.a = 0
				arg_21_1.mask_.color = var_24_11
			end

			local var_24_12 = arg_21_1.actors_["1039ui_story"].transform

			if 1.966 < arg_21_1.time_ and arg_21_1.time_ <= 1.966 + arg_24_0 then
				arg_21_1.var_.moveOldPos1039ui_story = var_24_12.localPosition
			end

			local var_24_13 = 0.001

			if 1.966 <= arg_21_1.time_ and arg_21_1.time_ < 1.966 + var_24_13 then
				var_24_12.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 1.966) / var_24_13)
				var_24_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_12.position).x, (manager.ui.mainCamera.transform.position - var_24_12.position).y, (manager.ui.mainCamera.transform.position - var_24_12.position).z)
				var_24_12.localEulerAngles.z = 0
				var_24_12.localEulerAngles.x = 0
				var_24_12.localEulerAngles = var_24_12.localEulerAngles
			end

			if arg_21_1.time_ >= 1.966 + var_24_13 and arg_21_1.time_ < 1.966 + var_24_13 + arg_24_0 then
				var_24_12.localPosition = Vector3.New(0, 100, 0)
				var_24_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_12.position).x, (manager.ui.mainCamera.transform.position - var_24_12.position).y, (manager.ui.mainCamera.transform.position - var_24_12.position).z)
				var_24_12.localEulerAngles.z = 0
				var_24_12.localEulerAngles.x = 0
				var_24_12.localEulerAngles = var_24_12.localEulerAngles
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_14 = 3.999999999999
			local var_24_15 = 1.525

			if 3.999999999999 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_16 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_16:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_17 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1103905005).content)

				arg_21_1.text_.text = var_24_17

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_19 = 61 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 61)

				if (61 <= 0 and var_24_15 or var_24_15 * (utf8.len(var_24_17) / 61)) > 0 and var_24_15 < var_24_19 then
					arg_21_1.talkMaxDuration = var_24_19
					var_24_14 = var_24_14 + 0.3

					if var_24_19 + var_24_14 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_19 + var_24_14
					end
				end

				arg_21_1.text_.text = var_24_17
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = var_24_14 + 0.3
			local var_24_21 = math.max(var_24_15, arg_21_1.talkMaxDuration)

			if var_24_14 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_21 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_20) / var_24_21

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_20 + var_24_21 and arg_21_1.time_ < var_24_20 + var_24_21 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play1103905006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 1103905006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play1103905007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.25

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
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

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(1103905006).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 10 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 10)

				if (10 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 10)) > 0 and var_30_0 < var_30_3 then
					arg_27_1.talkMaxDuration = var_30_3

					if var_30_3 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_3 + 0
					end
				end

				arg_27_1.text_.text = var_30_1
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_4 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_4

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play1103905007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 1103905007
		arg_31_1.duration_ = 4.17

		local var_31_0 = {
			zh = 3.9,
			ja = 4.166
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play1103905008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1039ui_story = arg_31_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1039ui_story"].transform.position).z)
				arg_31_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1039ui_story"].transform.localEulerAngles = arg_31_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_31_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1039ui_story"].transform.position).z)
				arg_31_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1039ui_story"].transform.localEulerAngles = arg_31_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1039ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1039ui_story == nil then
				arg_31_1.var_.characterEffect1039ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1039ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1039ui_story then
				arg_31_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_4 = 0
			local var_34_5 = 0.5

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(1103905007)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 20 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 20)

				if (20 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 20)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905007", "story_v_side_new_1103905.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905007", "story_v_side_new_1103905.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_side_new_1103905", "1103905007", "story_v_side_new_1103905.awb")

						arg_31_1:RecordAudio("1103905007", var_34_11)
						arg_31_1:RecordAudio("1103905007", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905007", "story_v_side_new_1103905.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905007", "story_v_side_new_1103905.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
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
	Play1103905008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1103905008
		arg_35_1.duration_ = 5.8

		local var_35_0 = {
			zh = 5.8,
			ja = 5.5
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
				arg_35_0:Play1103905009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.675

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(1103905008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 27 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 27)

				if (27 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 27)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905008", "story_v_side_new_1103905.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905008", "story_v_side_new_1103905.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_side_new_1103905", "1103905008", "story_v_side_new_1103905.awb")

						arg_35_1:RecordAudio("1103905008", var_38_6)
						arg_35_1:RecordAudio("1103905008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905008", "story_v_side_new_1103905.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905008", "story_v_side_new_1103905.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play1103905009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1103905009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1103905010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1039ui_story"]) and arg_39_1.var_.characterEffect1039ui_story == nil then
				arg_39_1.var_.characterEffect1039ui_story = arg_39_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1039ui_story"]) then
				if arg_39_1.var_.characterEffect1039ui_story and not isNil(arg_39_1.actors_["1039ui_story"]) then
					arg_39_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1039ui_story"]) and arg_39_1.var_.characterEffect1039ui_story then
				arg_39_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_2")
			end

			local var_42_1 = 0
			local var_42_2 = 0.9

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

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(1103905009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 36 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 36)

				if (36 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 36)) > 0 and var_42_2 < var_42_5 then
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
	Play1103905010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1103905010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1103905011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.15

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(1103905010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 6 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 6)

				if (6 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 6)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play1103905011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1103905011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1103905012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 1.05

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1103905011).content)

				arg_47_1.text_.text = var_50_1

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_3 = 42 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 42)

				if (42 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_1) / 42)) > 0 and var_50_0 < var_50_3 then
					arg_47_1.talkMaxDuration = var_50_3

					if var_50_3 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_3 + 0
					end
				end

				arg_47_1.text_.text = var_50_1
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_4 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_4

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play1103905012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1103905012
		arg_51_1.duration_ = 3.07

		local var_51_0 = {
			zh = 2.766,
			ja = 3.066
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
				arg_51_0:Play1103905013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1039ui_story"]) and arg_51_1.var_.characterEffect1039ui_story == nil then
				arg_51_1.var_.characterEffect1039ui_story = arg_51_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1039ui_story"]) then
				if arg_51_1.var_.characterEffect1039ui_story and not isNil(arg_51_1.actors_["1039ui_story"]) then
					arg_51_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1039ui_story"]) and arg_51_1.var_.characterEffect1039ui_story then
				arg_51_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_54_2 = 0
			local var_54_3 = 0.325

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:GetWordFromCfg(1103905012)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 13 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 13)

				if (13 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 13)) > 0 and var_54_3 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905012", "story_v_side_new_1103905.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905012", "story_v_side_new_1103905.awb") / 1000

					if var_54_8 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_2
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_side_new_1103905", "1103905012", "story_v_side_new_1103905.awb")

						arg_51_1:RecordAudio("1103905012", var_54_9)
						arg_51_1:RecordAudio("1103905012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905012", "story_v_side_new_1103905.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905012", "story_v_side_new_1103905.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_10 and arg_51_1.time_ < var_54_2 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1103905013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1103905013
		arg_55_1.duration_ = 9.27

		local var_55_0 = {
			zh = 7.5,
			ja = 9.266
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1103905014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.7

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(1103905013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 28 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 28)

				if (28 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 28)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905013", "story_v_side_new_1103905.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905013", "story_v_side_new_1103905.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_side_new_1103905", "1103905013", "story_v_side_new_1103905.awb")

						arg_55_1:RecordAudio("1103905013", var_58_6)
						arg_55_1:RecordAudio("1103905013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905013", "story_v_side_new_1103905.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905013", "story_v_side_new_1103905.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1103905014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1103905014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1103905015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1039ui_story"]) and arg_59_1.var_.characterEffect1039ui_story == nil then
				arg_59_1.var_.characterEffect1039ui_story = arg_59_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1039ui_story"]) then
				if arg_59_1.var_.characterEffect1039ui_story and not isNil(arg_59_1.actors_["1039ui_story"]) then
					arg_59_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1039ui_story"]) and arg_59_1.var_.characterEffect1039ui_story then
				arg_59_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.775

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1103905014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 31 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 31)

				if (31 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 31)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1103905015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1103905015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1103905016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.55

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

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(1103905015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 22 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 22)

				if (22 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 22)) > 0 and var_66_0 < var_66_3 then
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
	Play1103905016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1103905016
		arg_67_1.duration_ = 5.37

		local var_67_0 = {
			zh = 4.2,
			ja = 5.366
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
				arg_67_0:Play1103905017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1039ui_story"]) and arg_67_1.var_.characterEffect1039ui_story == nil then
				arg_67_1.var_.characterEffect1039ui_story = arg_67_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1039ui_story"]) then
				if arg_67_1.var_.characterEffect1039ui_story and not isNil(arg_67_1.actors_["1039ui_story"]) then
					arg_67_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1039ui_story"]) and arg_67_1.var_.characterEffect1039ui_story then
				arg_67_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_70_2 = 0
			local var_70_3 = 0.45

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_2 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_4 = arg_67_1:GetWordFromCfg(1103905016)
				local var_70_5 = arg_67_1:FormatText(var_70_4.content)

				arg_67_1.text_.text = var_70_5

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_7 = 18 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 18)

				if (18 <= 0 and var_70_3 or var_70_3 * (utf8.len(var_70_5) / 18)) > 0 and var_70_3 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_2
					end
				end

				arg_67_1.text_.text = var_70_5
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905016", "story_v_side_new_1103905.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905016", "story_v_side_new_1103905.awb") / 1000

					if var_70_8 + var_70_2 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_2
					end

					if var_70_4.prefab_name ~= "" and arg_67_1.actors_[var_70_4.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_4.prefab_name].transform, "story_v_side_new_1103905", "1103905016", "story_v_side_new_1103905.awb")

						arg_67_1:RecordAudio("1103905016", var_70_9)
						arg_67_1:RecordAudio("1103905016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905016", "story_v_side_new_1103905.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905016", "story_v_side_new_1103905.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_3, arg_67_1.talkMaxDuration)

			if var_70_2 <= arg_67_1.time_ and arg_67_1.time_ < var_70_2 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_2) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_2 + var_70_10 and arg_67_1.time_ < var_70_2 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1103905017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1103905017
		arg_71_1.duration_ = 4.73

		local var_71_0 = {
			zh = 4.733,
			ja = 4.066
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
				arg_71_0:Play1103905018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.575

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(1103905017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 23 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 23)

				if (23 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 23)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905017", "story_v_side_new_1103905.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905017", "story_v_side_new_1103905.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_side_new_1103905", "1103905017", "story_v_side_new_1103905.awb")

						arg_71_1:RecordAudio("1103905017", var_74_6)
						arg_71_1:RecordAudio("1103905017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905017", "story_v_side_new_1103905.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905017", "story_v_side_new_1103905.awb")
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
	Play1103905018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1103905018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1103905019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1039ui_story"]) and arg_75_1.var_.characterEffect1039ui_story == nil then
				arg_75_1.var_.characterEffect1039ui_story = arg_75_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1039ui_story"]) then
				if arg_75_1.var_.characterEffect1039ui_story and not isNil(arg_75_1.actors_["1039ui_story"]) then
					arg_75_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1039ui_story"]) and arg_75_1.var_.characterEffect1039ui_story then
				arg_75_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 0.7

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1103905018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 28 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 28)

				if (28 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 28)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1103905019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1103905019
		arg_79_1.duration_ = 2.8

		local var_79_0 = {
			zh = 1.999999999999,
			ja = 2.8
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
				arg_79_0:Play1103905020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1039ui_story"]) and arg_79_1.var_.characterEffect1039ui_story == nil then
				arg_79_1.var_.characterEffect1039ui_story = arg_79_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1039ui_story"]) then
				if arg_79_1.var_.characterEffect1039ui_story and not isNil(arg_79_1.actors_["1039ui_story"]) then
					arg_79_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1039ui_story"]) and arg_79_1.var_.characterEffect1039ui_story then
				arg_79_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_82_2 = 0
			local var_82_3 = 0.175

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(1103905019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 7 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 7)

				if (7 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 7)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905019", "story_v_side_new_1103905.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905019", "story_v_side_new_1103905.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_side_new_1103905", "1103905019", "story_v_side_new_1103905.awb")

						arg_79_1:RecordAudio("1103905019", var_82_9)
						arg_79_1:RecordAudio("1103905019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905019", "story_v_side_new_1103905.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905019", "story_v_side_new_1103905.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play1103905020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1103905020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1103905021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1039ui_story"]) and arg_83_1.var_.characterEffect1039ui_story == nil then
				arg_83_1.var_.characterEffect1039ui_story = arg_83_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1039ui_story"]) then
				if arg_83_1.var_.characterEffect1039ui_story and not isNil(arg_83_1.actors_["1039ui_story"]) then
					arg_83_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1039ui_story"]) and arg_83_1.var_.characterEffect1039ui_story then
				arg_83_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_86_1 = 0
			local var_86_2 = 0.775

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(1103905020).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 31 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 31)

				if (31 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 31)) > 0 and var_86_2 < var_86_5 then
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
	Play1103905021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1103905021
		arg_87_1.duration_ = 6

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1103905022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_0 = 1

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				local var_90_1 = Color.New(1, 1, 1)

				var_90_1.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.mask_.color = var_90_1
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				local var_90_2 = Color.New(1, 1, 1)

				var_90_2.a = 1
				arg_87_1.mask_.color = var_90_2
			end

			local var_90_3 = 1

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_4 = 1

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_4 then
				local var_90_5 = Color.New(1, 1, 1)

				var_90_5.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_3) / var_90_4)
				arg_87_1.mask_.color = var_90_5
			end

			if arg_87_1.time_ >= var_90_3 + var_90_4 and arg_87_1.time_ < var_90_3 + var_90_4 + arg_90_0 then
				local var_90_6 = Color.New(1, 1, 1)

				arg_87_1.mask_.enabled = false
				var_90_6.a = 0
				arg_87_1.mask_.color = var_90_6
			end

			local var_90_7 = arg_87_1.actors_["1039ui_story"].transform

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= 1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1039ui_story = var_90_7.localPosition
			end

			local var_90_8 = 0.001

			if 1 <= arg_87_1.time_ and arg_87_1.time_ < 1 + var_90_8 then
				var_90_7.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 1) / var_90_8)
				var_90_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_7.position).x, (manager.ui.mainCamera.transform.position - var_90_7.position).y, (manager.ui.mainCamera.transform.position - var_90_7.position).z)
				var_90_7.localEulerAngles.z = 0
				var_90_7.localEulerAngles.x = 0
				var_90_7.localEulerAngles = var_90_7.localEulerAngles
			end

			if arg_87_1.time_ >= 1 + var_90_8 and arg_87_1.time_ < 1 + var_90_8 + arg_90_0 then
				var_90_7.localPosition = Vector3.New(0, 100, 0)
				var_90_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_7.position).x, (manager.ui.mainCamera.transform.position - var_90_7.position).y, (manager.ui.mainCamera.transform.position - var_90_7.position).z)
				var_90_7.localEulerAngles.z = 0
				var_90_7.localEulerAngles.x = 0
				var_90_7.localEulerAngles = var_90_7.localEulerAngles
			end

			local var_90_9 = 1
			local var_90_10 = 1.4

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_11 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(1103905021).content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 56 <= 0 and var_90_10 or var_90_10 * (utf8.len(var_90_11) / 56)

				if (56 <= 0 and var_90_10 or var_90_10 * (utf8.len(var_90_11) / 56)) > 0 and var_90_10 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_9 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_9
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = math.max(var_90_10, arg_87_1.talkMaxDuration)

			if var_90_9 <= arg_87_1.time_ and arg_87_1.time_ < var_90_9 + var_90_14 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_9) / var_90_14

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_9 + var_90_14 and arg_87_1.time_ < var_90_9 + var_90_14 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play1103905022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1103905022
		arg_91_1.duration_ = 7.33

		local var_91_0 = {
			zh = 3.8,
			ja = 7.333
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
				arg_91_0:Play1103905023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1039ui_story"]) and arg_91_1.var_.characterEffect1039ui_story == nil then
				arg_91_1.var_.characterEffect1039ui_story = arg_91_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1039ui_story"]) then
				if arg_91_1.var_.characterEffect1039ui_story and not isNil(arg_91_1.actors_["1039ui_story"]) then
					arg_91_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1039ui_story"]) and arg_91_1.var_.characterEffect1039ui_story then
				arg_91_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			local var_94_2 = arg_91_1.actors_["1039ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1039ui_story = var_94_2.localPosition
			end

			local var_94_3 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_91_1.time_ - 0) / var_94_3)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(0, -1.01, -5.9)
				var_94_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_2.position).x, (manager.ui.mainCamera.transform.position - var_94_2.position).y, (manager.ui.mainCamera.transform.position - var_94_2.position).z)
				var_94_2.localEulerAngles.z = 0
				var_94_2.localEulerAngles.x = 0
				var_94_2.localEulerAngles = var_94_2.localEulerAngles
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_94_4 = 0
			local var_94_5 = 0.375

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(1103905022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 15 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 15)

				if (15 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 15)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905022", "story_v_side_new_1103905.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905022", "story_v_side_new_1103905.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_side_new_1103905", "1103905022", "story_v_side_new_1103905.awb")

						arg_91_1:RecordAudio("1103905022", var_94_11)
						arg_91_1:RecordAudio("1103905022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905022", "story_v_side_new_1103905.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905022", "story_v_side_new_1103905.awb")
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play1103905023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1103905023
		arg_95_1.duration_ = 6.8

		local var_95_0 = {
			zh = 6.8,
			ja = 4.833
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
				arg_95_0:Play1103905024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.725

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(1103905023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 29 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 29)

				if (29 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 29)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905023", "story_v_side_new_1103905.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905023", "story_v_side_new_1103905.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_side_new_1103905", "1103905023", "story_v_side_new_1103905.awb")

						arg_95_1:RecordAudio("1103905023", var_98_6)
						arg_95_1:RecordAudio("1103905023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905023", "story_v_side_new_1103905.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905023", "story_v_side_new_1103905.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play1103905024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1103905024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1103905025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1039ui_story"]) and arg_99_1.var_.characterEffect1039ui_story == nil then
				arg_99_1.var_.characterEffect1039ui_story = arg_99_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_0 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1039ui_story"]) then
				if arg_99_1.var_.characterEffect1039ui_story and not isNil(arg_99_1.actors_["1039ui_story"]) then
					arg_99_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_0)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1039ui_story"]) and arg_99_1.var_.characterEffect1039ui_story then
				arg_99_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_102_1 = 0
			local var_102_2 = 0.05

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1103905024).content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 2 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 2)

				if (2 <= 0 and var_102_2 or var_102_2 * (utf8.len(var_102_3) / 2)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_1 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_1
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_6 = math.max(var_102_2, arg_99_1.talkMaxDuration)

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_6 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_1) / var_102_6

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_1 + var_102_6 and arg_99_1.time_ < var_102_1 + var_102_6 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1103905025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1103905025
		arg_103_1.duration_ = 9

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1103905026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if arg_103_1.bgs_.STblack == nil then
				local var_106_0 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_106_0.name = "STblack"
				var_106_0.transform.parent = arg_103_1.stage_.transform
				var_106_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_.STblack = var_106_0
			end

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= 2 + arg_106_0 then
				local var_106_1 = arg_103_1.bgs_.STblack

				arg_103_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_2 = var_106_1:GetComponent("SpriteRenderer")

				if var_106_2 and var_106_2.sprite then
					local var_106_3 = 2 * (var_106_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_1.transform.localScale = Vector3.New(var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "STblack" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_4 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_5 = 2

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_5 then
				local var_106_6 = Color.New(0, 0, 0)

				var_106_6.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_4) / var_106_5)
				arg_103_1.mask_.color = var_106_6
			end

			if arg_103_1.time_ >= var_106_4 + var_106_5 and arg_103_1.time_ < var_106_4 + var_106_5 + arg_106_0 then
				local var_106_7 = Color.New(0, 0, 0)

				var_106_7.a = 1
				arg_103_1.mask_.color = var_106_7
			end

			local var_106_8 = 2

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_8 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_9 = 2

			if var_106_8 <= arg_103_1.time_ and arg_103_1.time_ < var_106_8 + var_106_9 then
				local var_106_10 = Color.New(0, 0, 0)

				var_106_10.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_8) / var_106_9)
				arg_103_1.mask_.color = var_106_10
			end

			if arg_103_1.time_ >= var_106_8 + var_106_9 and arg_103_1.time_ < var_106_8 + var_106_9 + arg_106_0 then
				local var_106_11 = Color.New(0, 0, 0)

				arg_103_1.mask_.enabled = false
				var_106_11.a = 0
				arg_103_1.mask_.color = var_106_11
			end

			local var_106_12 = arg_103_1.actors_["1039ui_story"].transform

			if 1.966 < arg_103_1.time_ and arg_103_1.time_ <= 1.966 + arg_106_0 then
				arg_103_1.var_.moveOldPos1039ui_story = var_106_12.localPosition
			end

			local var_106_13 = 0.001

			if 1.966 <= arg_103_1.time_ and arg_103_1.time_ < 1.966 + var_106_13 then
				var_106_12.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 1.966) / var_106_13)
				var_106_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_12.position).x, (manager.ui.mainCamera.transform.position - var_106_12.position).y, (manager.ui.mainCamera.transform.position - var_106_12.position).z)
				var_106_12.localEulerAngles.z = 0
				var_106_12.localEulerAngles.x = 0
				var_106_12.localEulerAngles = var_106_12.localEulerAngles
			end

			if arg_103_1.time_ >= 1.966 + var_106_13 and arg_103_1.time_ < 1.966 + var_106_13 + arg_106_0 then
				var_106_12.localPosition = Vector3.New(0, 100, 0)
				var_106_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_12.position).x, (manager.ui.mainCamera.transform.position - var_106_12.position).y, (manager.ui.mainCamera.transform.position - var_106_12.position).z)
				var_106_12.localEulerAngles.z = 0
				var_106_12.localEulerAngles.x = 0
				var_106_12.localEulerAngles = var_106_12.localEulerAngles
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_14 = 4
			local var_106_15 = 0.875

			if 4 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_16 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_16:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_17 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(1103905025).content)

				arg_103_1.text_.text = var_106_17

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_19 = 35 <= 0 and var_106_15 or var_106_15 * (utf8.len(var_106_17) / 35)

				if (35 <= 0 and var_106_15 or var_106_15 * (utf8.len(var_106_17) / 35)) > 0 and var_106_15 < var_106_19 then
					arg_103_1.talkMaxDuration = var_106_19
					var_106_14 = var_106_14 + 0.3

					if var_106_19 + var_106_14 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_19 + var_106_14
					end
				end

				arg_103_1.text_.text = var_106_17
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_20 = var_106_14 + 0.3
			local var_106_21 = math.max(var_106_15, arg_103_1.talkMaxDuration)

			if var_106_14 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_20 + var_106_21 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_20) / var_106_21

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_20 + var_106_21 and arg_103_1.time_ < var_106_20 + var_106_21 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play1103905026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1103905026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1103905027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.175

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1103905026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 47 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 47)

				if (47 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 47)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play1103905027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1103905027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1103905028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.35

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1103905027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 14 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 14)

				if (14 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 14)) > 0 and var_116_0 < var_116_3 then
					arg_113_1.talkMaxDuration = var_116_3

					if var_116_3 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_3 + 0
					end
				end

				arg_113_1.text_.text = var_116_1
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_4 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_4

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1103905028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1103905028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1103905029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.05

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1103905028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 2 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 2)

				if (2 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 2)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1103905029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1103905029
		arg_121_1.duration_ = 1.6

		local var_121_0 = {
			zh = 1.333,
			ja = 1.6
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
				arg_121_0:Play1103905030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1039")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(1103905029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 4 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 4)

				if (4 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 4)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905029", "story_v_side_new_1103905.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905029", "story_v_side_new_1103905.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_side_new_1103905", "1103905029", "story_v_side_new_1103905.awb")

						arg_121_1:RecordAudio("1103905029", var_124_6)
						arg_121_1:RecordAudio("1103905029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905029", "story_v_side_new_1103905.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905029", "story_v_side_new_1103905.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play1103905030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1103905030
		arg_125_1.duration_ = 7

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1103905031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				local var_128_0 = arg_125_1.bgs_.ST01

				arg_125_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_128_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_1 = var_128_0:GetComponent("SpriteRenderer")

				if var_128_1 and var_128_1.sprite then
					local var_128_2 = 2 * (var_128_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_128_0.transform.localScale = Vector3.New(var_128_2 / var_128_1.sprite.bounds.size.y < var_128_2 * manager.ui.mainCameraCom_.aspect / var_128_1.sprite.bounds.size.x and var_128_2 * manager.ui.mainCameraCom_.aspect / var_128_1.sprite.bounds.size.x or var_128_2 / var_128_1.sprite.bounds.size.y, var_128_2 / var_128_1.sprite.bounds.size.y < var_128_2 * manager.ui.mainCameraCom_.aspect / var_128_1.sprite.bounds.size.x and var_128_2 * manager.ui.mainCameraCom_.aspect / var_128_1.sprite.bounds.size.x or var_128_2 / var_128_1.sprite.bounds.size.y, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "ST01" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_3 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_3 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_4 = 2

			if var_128_3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_3 + var_128_4 then
				local var_128_5 = Color.New(0, 0, 0)

				var_128_5.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_3) / var_128_4)
				arg_125_1.mask_.color = var_128_5
			end

			if arg_125_1.time_ >= var_128_3 + var_128_4 and arg_125_1.time_ < var_128_3 + var_128_4 + arg_128_0 then
				local var_128_6 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_6.a = 0
				arg_125_1.mask_.color = var_128_6
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_7 = 2
			local var_128_8 = 1.2

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_9 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_9:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(1103905030).content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_12 = 48 <= 0 and var_128_8 or var_128_8 * (utf8.len(var_128_10) / 48)

				if (48 <= 0 and var_128_8 or var_128_8 * (utf8.len(var_128_10) / 48)) > 0 and var_128_8 < var_128_12 then
					arg_125_1.talkMaxDuration = var_128_12
					var_128_7 = var_128_7 + 0.3

					if var_128_12 + var_128_7 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_7
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_13 = var_128_7 + 0.3
			local var_128_14 = math.max(var_128_8, arg_125_1.talkMaxDuration)

			if var_128_7 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_13 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_13) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_13 + var_128_14 and arg_125_1.time_ < var_128_13 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1103905031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1103905031
		arg_131_1.duration_ = 7.3

		local var_131_0 = {
			zh = 4.7,
			ja = 7.3
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1103905032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1039ui_story = arg_131_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1039ui_story"].transform.position).z)
				arg_131_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1039ui_story"].transform.localEulerAngles = arg_131_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_131_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1039ui_story"].transform.position).z)
				arg_131_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1039ui_story"].transform.localEulerAngles = arg_131_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1039ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1039ui_story == nil then
				arg_131_1.var_.characterEffect1039ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1039ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1039ui_story then
				arg_131_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_134_4 = 0
			local var_134_5 = 0.475

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(1103905031)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 19 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 19)

				if (19 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 19)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905031", "story_v_side_new_1103905.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905031", "story_v_side_new_1103905.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_side_new_1103905", "1103905031", "story_v_side_new_1103905.awb")

						arg_131_1:RecordAudio("1103905031", var_134_11)
						arg_131_1:RecordAudio("1103905031", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905031", "story_v_side_new_1103905.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905031", "story_v_side_new_1103905.awb")
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
				actorName = "1039ui_story",
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
	Play1103905032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1103905032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1103905033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1039ui_story"]) and arg_135_1.var_.characterEffect1039ui_story == nil then
				arg_135_1.var_.characterEffect1039ui_story = arg_135_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1039ui_story"]) then
				if arg_135_1.var_.characterEffect1039ui_story and not isNil(arg_135_1.actors_["1039ui_story"]) then
					arg_135_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1039ui_story"]) and arg_135_1.var_.characterEffect1039ui_story then
				arg_135_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.25

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

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1103905032).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 10 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 10)

				if (10 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 10)) > 0 and var_138_2 < var_138_5 then
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
	Play1103905033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1103905033
		arg_139_1.duration_ = 5.63

		local var_139_0 = {
			zh = 3.9,
			ja = 5.633
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
				arg_139_0:Play1103905034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1039ui_story"]) and arg_139_1.var_.characterEffect1039ui_story == nil then
				arg_139_1.var_.characterEffect1039ui_story = arg_139_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1039ui_story"]) then
				if arg_139_1.var_.characterEffect1039ui_story and not isNil(arg_139_1.actors_["1039ui_story"]) then
					arg_139_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1039ui_story"]) and arg_139_1.var_.characterEffect1039ui_story then
				arg_139_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_142_2 = 0
			local var_142_3 = 0.4

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:GetWordFromCfg(1103905033)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 16 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 16)

				if (16 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 16)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905033", "story_v_side_new_1103905.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905033", "story_v_side_new_1103905.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_side_new_1103905", "1103905033", "story_v_side_new_1103905.awb")

						arg_139_1:RecordAudio("1103905033", var_142_9)
						arg_139_1:RecordAudio("1103905033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905033", "story_v_side_new_1103905.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905033", "story_v_side_new_1103905.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1103905034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1103905034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1103905035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1039ui_story"]) and arg_143_1.var_.characterEffect1039ui_story == nil then
				arg_143_1.var_.characterEffect1039ui_story = arg_143_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1039ui_story"]) then
				if arg_143_1.var_.characterEffect1039ui_story and not isNil(arg_143_1.actors_["1039ui_story"]) then
					arg_143_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1039ui_story"]) and arg_143_1.var_.characterEffect1039ui_story then
				arg_143_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.15

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

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1103905034).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 6 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 6)

				if (6 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 6)) > 0 and var_146_2 < var_146_5 then
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
	Play1103905035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1103905035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1103905036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.875

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1103905035).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 35 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 35)

				if (35 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 35)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1103905036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1103905036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1103905037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.325

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
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

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(1103905036).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 13 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 13)

				if (13 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 13)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1103905037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1103905037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1103905038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.525

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1103905037).content)

				arg_155_1.text_.text = var_158_1

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_3 = 21 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 21)

				if (21 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_1) / 21)) > 0 and var_158_0 < var_158_3 then
					arg_155_1.talkMaxDuration = var_158_3

					if var_158_3 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_3 + 0
					end
				end

				arg_155_1.text_.text = var_158_1
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_4 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_4

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1103905038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1103905038
		arg_159_1.duration_ = 7.97

		local var_159_0 = {
			zh = 7.966,
			ja = 5.533
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1103905039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1039ui_story"]) and arg_159_1.var_.characterEffect1039ui_story == nil then
				arg_159_1.var_.characterEffect1039ui_story = arg_159_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1039ui_story"]) then
				if arg_159_1.var_.characterEffect1039ui_story and not isNil(arg_159_1.actors_["1039ui_story"]) then
					arg_159_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1039ui_story"]) and arg_159_1.var_.characterEffect1039ui_story then
				arg_159_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_162_2 = 0
			local var_162_3 = 0.825

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(1103905038)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 33 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 33)

				if (33 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 33)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905038", "story_v_side_new_1103905.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905038", "story_v_side_new_1103905.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_side_new_1103905", "1103905038", "story_v_side_new_1103905.awb")

						arg_159_1:RecordAudio("1103905038", var_162_9)
						arg_159_1:RecordAudio("1103905038", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905038", "story_v_side_new_1103905.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905038", "story_v_side_new_1103905.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_10 and arg_159_1.time_ < var_162_2 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1103905039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1103905039
		arg_163_1.duration_ = 9.27

		local var_163_0 = {
			zh = 4.566,
			ja = 9.266
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1103905040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_166_0 = 0
			local var_166_1 = 0.475

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(1103905039)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 19 <= 0 and var_166_1 or var_166_1 * (utf8.len(var_166_3) / 19)

				if (19 <= 0 and var_166_1 or var_166_1 * (utf8.len(var_166_3) / 19)) > 0 and var_166_1 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905039", "story_v_side_new_1103905.awb") ~= 0 then
					local var_166_6 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905039", "story_v_side_new_1103905.awb") / 1000

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end

					if var_166_2.prefab_name ~= "" and arg_163_1.actors_[var_166_2.prefab_name] ~= nil then
						local var_166_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_2.prefab_name].transform, "story_v_side_new_1103905", "1103905039", "story_v_side_new_1103905.awb")

						arg_163_1:RecordAudio("1103905039", var_166_7)
						arg_163_1:RecordAudio("1103905039", var_166_7)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905039", "story_v_side_new_1103905.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905039", "story_v_side_new_1103905.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_8 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_8 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_8

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_8 and arg_163_1.time_ < var_166_0 + var_166_8 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1103905040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1103905040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1103905041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1039ui_story"]) and arg_167_1.var_.characterEffect1039ui_story == nil then
				arg_167_1.var_.characterEffect1039ui_story = arg_167_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1039ui_story"]) then
				if arg_167_1.var_.characterEffect1039ui_story and not isNil(arg_167_1.actors_["1039ui_story"]) then
					arg_167_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1039ui_story"]) and arg_167_1.var_.characterEffect1039ui_story then
				arg_167_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_170_1 = 0
			local var_170_2 = 0.675

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1103905040).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 27 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 27)

				if (27 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 27)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1103905041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1103905041
		arg_171_1.duration_ = 6.77

		local var_171_0 = {
			zh = 2.866,
			ja = 6.766
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1103905042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1039ui_story"]) and arg_171_1.var_.characterEffect1039ui_story == nil then
				arg_171_1.var_.characterEffect1039ui_story = arg_171_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1039ui_story"]) then
				if arg_171_1.var_.characterEffect1039ui_story and not isNil(arg_171_1.actors_["1039ui_story"]) then
					arg_171_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1039ui_story"]) and arg_171_1.var_.characterEffect1039ui_story then
				arg_171_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_174_2 = 0
			local var_174_3 = 0.35

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(1103905041)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 14 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 14)

				if (14 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 14)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905041", "story_v_side_new_1103905.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905041", "story_v_side_new_1103905.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_side_new_1103905", "1103905041", "story_v_side_new_1103905.awb")

						arg_171_1:RecordAudio("1103905041", var_174_9)
						arg_171_1:RecordAudio("1103905041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905041", "story_v_side_new_1103905.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905041", "story_v_side_new_1103905.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1103905042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1103905042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1103905043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1039ui_story"]) and arg_175_1.var_.characterEffect1039ui_story == nil then
				arg_175_1.var_.characterEffect1039ui_story = arg_175_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1039ui_story"]) then
				if arg_175_1.var_.characterEffect1039ui_story and not isNil(arg_175_1.actors_["1039ui_story"]) then
					arg_175_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1039ui_story"]) and arg_175_1.var_.characterEffect1039ui_story then
				arg_175_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.525

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1103905042).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 21 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 21)

				if (21 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 21)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1103905043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1103905043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1103905044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.925

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1103905043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 37 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 37)

				if (37 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 37)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1103905044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1103905044
		arg_183_1.duration_ = 10.13

		local var_183_0 = {
			zh = 6.466,
			ja = 10.133
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
				arg_183_0:Play1103905045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1039ui_story"]) and arg_183_1.var_.characterEffect1039ui_story == nil then
				arg_183_1.var_.characterEffect1039ui_story = arg_183_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1039ui_story"]) then
				if arg_183_1.var_.characterEffect1039ui_story and not isNil(arg_183_1.actors_["1039ui_story"]) then
					arg_183_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1039ui_story"]) and arg_183_1.var_.characterEffect1039ui_story then
				arg_183_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_186_2 = 0
			local var_186_3 = 0.675

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
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

				local var_186_4 = arg_183_1:GetWordFromCfg(1103905044)
				local var_186_5 = arg_183_1:FormatText(var_186_4.content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 27 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_5) / 27)

				if (27 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_5) / 27)) > 0 and var_186_3 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905044", "story_v_side_new_1103905.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905044", "story_v_side_new_1103905.awb") / 1000

					if var_186_8 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_2
					end

					if var_186_4.prefab_name ~= "" and arg_183_1.actors_[var_186_4.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_4.prefab_name].transform, "story_v_side_new_1103905", "1103905044", "story_v_side_new_1103905.awb")

						arg_183_1:RecordAudio("1103905044", var_186_9)
						arg_183_1:RecordAudio("1103905044", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905044", "story_v_side_new_1103905.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905044", "story_v_side_new_1103905.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_3, arg_183_1.talkMaxDuration)

			if var_186_2 <= arg_183_1.time_ and arg_183_1.time_ < var_186_2 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_2) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_2 + var_186_10 and arg_183_1.time_ < var_186_2 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1103905045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1103905045
		arg_187_1.duration_ = 5.37

		local var_187_0 = {
			zh = 3.966,
			ja = 5.366
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
				arg_187_0:Play1103905046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.4

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(1103905045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 16 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 16)

				if (16 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 16)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905045", "story_v_side_new_1103905.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905045", "story_v_side_new_1103905.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_side_new_1103905", "1103905045", "story_v_side_new_1103905.awb")

						arg_187_1:RecordAudio("1103905045", var_190_6)
						arg_187_1:RecordAudio("1103905045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905045", "story_v_side_new_1103905.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905045", "story_v_side_new_1103905.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1103905046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1103905046
		arg_191_1.duration_ = 9

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1103905047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if arg_191_1.bgs_.ST12 == nil then
				local var_194_0 = Object.Instantiate(arg_191_1.paintGo_)

				var_194_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_194_0.name = "ST12"
				var_194_0.transform.parent = arg_191_1.stage_.transform
				var_194_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.bgs_.ST12 = var_194_0
			end

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= 2 + arg_194_0 then
				local var_194_1 = arg_191_1.bgs_.ST12

				arg_191_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_194_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_2 = var_194_1:GetComponent("SpriteRenderer")

				if var_194_2 and var_194_2.sprite then
					local var_194_3 = 2 * (var_194_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_194_1.transform.localScale = Vector3.New(var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, var_194_3 / var_194_2.sprite.bounds.size.y < var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x and var_194_3 * manager.ui.mainCameraCom_.aspect / var_194_2.sprite.bounds.size.x or var_194_3 / var_194_2.sprite.bounds.size.y, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "ST12" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_4 = 0

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_5 = 2

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_5 then
				local var_194_6 = Color.New(0, 0, 0)

				var_194_6.a = Mathf.Lerp(0, 1, (arg_191_1.time_ - var_194_4) / var_194_5)
				arg_191_1.mask_.color = var_194_6
			end

			if arg_191_1.time_ >= var_194_4 + var_194_5 and arg_191_1.time_ < var_194_4 + var_194_5 + arg_194_0 then
				local var_194_7 = Color.New(0, 0, 0)

				var_194_7.a = 1
				arg_191_1.mask_.color = var_194_7
			end

			local var_194_8 = 2

			if 2 < arg_191_1.time_ and arg_191_1.time_ <= var_194_8 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_9 = 2

			if var_194_8 <= arg_191_1.time_ and arg_191_1.time_ < var_194_8 + var_194_9 then
				local var_194_10 = Color.New(0, 0, 0)

				var_194_10.a = Mathf.Lerp(1, 0, (arg_191_1.time_ - var_194_8) / var_194_9)
				arg_191_1.mask_.color = var_194_10
			end

			if arg_191_1.time_ >= var_194_8 + var_194_9 and arg_191_1.time_ < var_194_8 + var_194_9 + arg_194_0 then
				local var_194_11 = Color.New(0, 0, 0)

				arg_191_1.mask_.enabled = false
				var_194_11.a = 0
				arg_191_1.mask_.color = var_194_11
			end

			local var_194_12 = arg_191_1.actors_["1039ui_story"].transform

			if 1.96599999815226 < arg_191_1.time_ and arg_191_1.time_ <= 1.96599999815226 + arg_194_0 then
				arg_191_1.var_.moveOldPos1039ui_story = var_194_12.localPosition
			end

			local var_194_13 = 0.001

			if 1.96599999815226 <= arg_191_1.time_ and arg_191_1.time_ < 1.96599999815226 + var_194_13 then
				var_194_12.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 1.96599999815226) / var_194_13)
				var_194_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_12.position).x, (manager.ui.mainCamera.transform.position - var_194_12.position).y, (manager.ui.mainCamera.transform.position - var_194_12.position).z)
				var_194_12.localEulerAngles.z = 0
				var_194_12.localEulerAngles.x = 0
				var_194_12.localEulerAngles = var_194_12.localEulerAngles
			end

			if arg_191_1.time_ >= 1.96599999815226 + var_194_13 and arg_191_1.time_ < 1.96599999815226 + var_194_13 + arg_194_0 then
				var_194_12.localPosition = Vector3.New(0, 100, 0)
				var_194_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_12.position).x, (manager.ui.mainCamera.transform.position - var_194_12.position).y, (manager.ui.mainCamera.transform.position - var_194_12.position).z)
				var_194_12.localEulerAngles.z = 0
				var_194_12.localEulerAngles.x = 0
				var_194_12.localEulerAngles = var_194_12.localEulerAngles
			end

			local var_194_14 = arg_191_1.actors_["1039ui_story"]

			if 1.96599999815226 < arg_191_1.time_ and arg_191_1.time_ <= 1.96599999815226 + arg_194_0 and not isNil(var_194_14) and arg_191_1.var_.characterEffect1039ui_story == nil then
				arg_191_1.var_.characterEffect1039ui_story = var_194_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_15 = 0.034000001847744

			if 1.96599999815226 <= arg_191_1.time_ and arg_191_1.time_ < 1.96599999815226 + var_194_15 and not isNil(var_194_14) then
				if arg_191_1.var_.characterEffect1039ui_story and not isNil(var_194_14) then
					arg_191_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 1.96599999815226) / var_194_15)
				end
			end

			if arg_191_1.time_ >= 1.96599999815226 + var_194_15 and arg_191_1.time_ < 1.96599999815226 + var_194_15 + arg_194_0 and not isNil(var_194_14) and arg_191_1.var_.characterEffect1039ui_story then
				arg_191_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if arg_191_1.frameCnt_ <= 1 then
				arg_191_1.dialog_:SetActive(false)
			end

			local var_194_16 = 3.999999999999
			local var_194_17 = 0.925

			if 3.999999999999 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				arg_191_1.dialog_:SetActive(true)

				arg_191_1.dialogCg_.alpha = 0

				local var_194_18 = LeanTween.value(arg_191_1.dialog_, 0, 1, 0.3)

				var_194_18:setOnUpdate(LuaHelper.FloatAction(function(arg_195_0)
					arg_191_1.dialogCg_.alpha = arg_195_0
				end))
				var_194_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_191_1.dialog_)
					var_194_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_191_1.duration_ = arg_191_1.duration_ + 0.3

				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_19 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1103905046).content)

				arg_191_1.text_.text = var_194_19

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_21 = 37 <= 0 and var_194_17 or var_194_17 * (utf8.len(var_194_19) / 37)

				if (37 <= 0 and var_194_17 or var_194_17 * (utf8.len(var_194_19) / 37)) > 0 and var_194_17 < var_194_21 then
					arg_191_1.talkMaxDuration = var_194_21
					var_194_16 = var_194_16 + 0.3

					if var_194_21 + var_194_16 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_21 + var_194_16
					end
				end

				arg_191_1.text_.text = var_194_19
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_22 = var_194_16 + 0.3
			local var_194_23 = math.max(var_194_17, arg_191_1.talkMaxDuration)

			if var_194_16 + 0.3 <= arg_191_1.time_ and arg_191_1.time_ < var_194_22 + var_194_23 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_22) / var_194_23

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_22 + var_194_23 and arg_191_1.time_ < var_194_22 + var_194_23 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play1103905047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1103905047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1103905048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1.575

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(1103905047).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 63 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 63)

				if (63 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 63)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1103905048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1103905048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1103905049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.725

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(1103905048).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 29 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 29)

				if (29 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 29)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1103905049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1103905049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1103905050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.75

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1103905049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 30 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 30)

				if (30 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 30)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play1103905050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1103905050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1103905051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.3

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1103905050).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 12 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 12)

				if (12 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 12)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play1103905051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1103905051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1103905052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.95

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(1103905051).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 38 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 38)

				if (38 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 38)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play1103905052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1103905052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1103905053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.05

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(1103905052).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 42 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 42)

				if (42 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 42)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1103905053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1103905053
		arg_221_1.duration_ = 9

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1103905054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if arg_221_1.bgs_.ST15a == nil then
				local var_224_0 = Object.Instantiate(arg_221_1.paintGo_)

				var_224_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15a")
				var_224_0.name = "ST15a"
				var_224_0.transform.parent = arg_221_1.stage_.transform
				var_224_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.bgs_.ST15a = var_224_0
			end

			if 1.999999999999 < arg_221_1.time_ and arg_221_1.time_ <= 1.999999999999 + arg_224_0 then
				local var_224_1 = arg_221_1.bgs_.ST15a

				arg_221_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_224_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_2 = var_224_1:GetComponent("SpriteRenderer")

				if var_224_2 and var_224_2.sprite then
					local var_224_3 = 2 * (var_224_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_224_1.transform.localScale = Vector3.New(var_224_3 / var_224_2.sprite.bounds.size.y < var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x and var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x or var_224_3 / var_224_2.sprite.bounds.size.y, var_224_3 / var_224_2.sprite.bounds.size.y < var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x and var_224_3 * manager.ui.mainCameraCom_.aspect / var_224_2.sprite.bounds.size.x or var_224_3 / var_224_2.sprite.bounds.size.y, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "ST15a" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_4 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_5 = 2

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_5 then
				local var_224_6 = Color.New(0, 0, 0)

				var_224_6.a = Mathf.Lerp(0, 1, (arg_221_1.time_ - var_224_4) / var_224_5)
				arg_221_1.mask_.color = var_224_6
			end

			if arg_221_1.time_ >= var_224_4 + var_224_5 and arg_221_1.time_ < var_224_4 + var_224_5 + arg_224_0 then
				local var_224_7 = Color.New(0, 0, 0)

				var_224_7.a = 1
				arg_221_1.mask_.color = var_224_7
			end

			local var_224_8 = 2

			if 2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_9 = 2

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 then
				local var_224_10 = Color.New(0, 0, 0)

				var_224_10.a = Mathf.Lerp(1, 0, (arg_221_1.time_ - var_224_8) / var_224_9)
				arg_221_1.mask_.color = var_224_10
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 then
				local var_224_11 = Color.New(0, 0, 0)

				arg_221_1.mask_.enabled = false
				var_224_11.a = 0
				arg_221_1.mask_.color = var_224_11
			end

			if 1.8 < arg_221_1.time_ and arg_221_1.time_ <= 1.8 + arg_224_0 then
				arg_221_1:AudioAction("play", "effect", "se_story_130", "se_story_130_sea", "")
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_13 = 3.999999999999
			local var_224_14 = 0.7

			if 3.999999999999 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_15 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_15:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_16 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(1103905053).content)

				arg_221_1.text_.text = var_224_16

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_18 = 28 <= 0 and var_224_14 or var_224_14 * (utf8.len(var_224_16) / 28)

				if (28 <= 0 and var_224_14 or var_224_14 * (utf8.len(var_224_16) / 28)) > 0 and var_224_14 < var_224_18 then
					arg_221_1.talkMaxDuration = var_224_18
					var_224_13 = var_224_13 + 0.3

					if var_224_18 + var_224_13 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_18 + var_224_13
					end
				end

				arg_221_1.text_.text = var_224_16
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_19 = var_224_13 + 0.3
			local var_224_20 = math.max(var_224_14, arg_221_1.talkMaxDuration)

			if var_224_13 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_19 + var_224_20 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_19) / var_224_20

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_19 + var_224_20 and arg_221_1.time_ < var_224_19 + var_224_20 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play1103905054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1103905054
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1103905055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1.25

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1103905054).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 50 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 50)

				if (50 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 50)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1103905055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1103905055
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1103905056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0.325

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
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

				local var_234_1 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(1103905055).content)

				arg_231_1.text_.text = var_234_1

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_3 = 13 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 13)

				if (13 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_1) / 13)) > 0 and var_234_0 < var_234_3 then
					arg_231_1.talkMaxDuration = var_234_3

					if var_234_3 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_3 + 0
					end
				end

				arg_231_1.text_.text = var_234_1
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_4 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_4

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1103905056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1103905056
		arg_235_1.duration_ = 4.97

		local var_235_0 = {
			zh = 4.966,
			ja = 1.633
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1103905057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.25

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_1 = arg_235_1:GetWordFromCfg(1103905056)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 10 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 10)

				if (10 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 10)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905056", "story_v_side_new_1103905.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905056", "story_v_side_new_1103905.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_side_new_1103905", "1103905056", "story_v_side_new_1103905.awb")

						arg_235_1:RecordAudio("1103905056", var_238_6)
						arg_235_1:RecordAudio("1103905056", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905056", "story_v_side_new_1103905.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905056", "story_v_side_new_1103905.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1103905057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1103905057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1103905058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 1.175

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(1103905057).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 47 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 47)

				if (47 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 47)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1103905058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1103905058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1103905059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.9

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
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

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(1103905058).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 36 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 36)

				if (36 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 36)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1103905059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1103905059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1103905060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.225

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(1103905059).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 49 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 49)

				if (49 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 49)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1103905060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1103905060
		arg_251_1.duration_ = 2.97

		local var_251_0 = {
			zh = 2.966,
			ja = 1.999999999999
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1103905061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1039ui_story = arg_251_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1039ui_story"].transform.position).z)
				arg_251_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1039ui_story"].transform.localEulerAngles = arg_251_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_251_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1039ui_story"].transform.position).z)
				arg_251_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1039ui_story"].transform.localEulerAngles = arg_251_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1039ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1039ui_story == nil then
				arg_251_1.var_.characterEffect1039ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1039ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1039ui_story then
				arg_251_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_254_4 = 0
			local var_254_5 = 0.1

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_4 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_6 = arg_251_1:GetWordFromCfg(1103905060)
				local var_254_7 = arg_251_1:FormatText(var_254_6.content)

				arg_251_1.text_.text = var_254_7

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_9 = 4 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 4)

				if (4 <= 0 and var_254_5 or var_254_5 * (utf8.len(var_254_7) / 4)) > 0 and var_254_5 < var_254_9 then
					arg_251_1.talkMaxDuration = var_254_9

					if var_254_9 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_9 + var_254_4
					end
				end

				arg_251_1.text_.text = var_254_7
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905060", "story_v_side_new_1103905.awb") ~= 0 then
					local var_254_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905060", "story_v_side_new_1103905.awb") / 1000

					if var_254_10 + var_254_4 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_4
					end

					if var_254_6.prefab_name ~= "" and arg_251_1.actors_[var_254_6.prefab_name] ~= nil then
						local var_254_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_6.prefab_name].transform, "story_v_side_new_1103905", "1103905060", "story_v_side_new_1103905.awb")

						arg_251_1:RecordAudio("1103905060", var_254_11)
						arg_251_1:RecordAudio("1103905060", var_254_11)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905060", "story_v_side_new_1103905.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905060", "story_v_side_new_1103905.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_12 = math.max(var_254_5, arg_251_1.talkMaxDuration)

			if var_254_4 <= arg_251_1.time_ and arg_251_1.time_ < var_254_4 + var_254_12 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_4) / var_254_12

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_4 + var_254_12 and arg_251_1.time_ < var_254_4 + var_254_12 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play1103905061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1103905061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1103905062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1039ui_story"]) and arg_255_1.var_.characterEffect1039ui_story == nil then
				arg_255_1.var_.characterEffect1039ui_story = arg_255_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1039ui_story"]) then
				if arg_255_1.var_.characterEffect1039ui_story and not isNil(arg_255_1.actors_["1039ui_story"]) then
					arg_255_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1039ui_story"]) and arg_255_1.var_.characterEffect1039ui_story then
				arg_255_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_side_1039_plastic", "")
			end

			local var_258_2 = 0
			local var_258_3 = 1.275

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_4 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1103905061).content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_6 = 51 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_4) / 51)

				if (51 <= 0 and var_258_3 or var_258_3 * (utf8.len(var_258_4) / 51)) > 0 and var_258_3 < var_258_6 then
					arg_255_1.talkMaxDuration = var_258_6

					if var_258_6 + var_258_2 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_2
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_3, arg_255_1.talkMaxDuration)

			if var_258_2 <= arg_255_1.time_ and arg_255_1.time_ < var_258_2 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_2) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_2 + var_258_7 and arg_255_1.time_ < var_258_2 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1103905062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1103905062
		arg_259_1.duration_ = 3.97

		local var_259_0 = {
			zh = 3.966,
			ja = 1.999999999999
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1103905063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1039ui_story"]) and arg_259_1.var_.characterEffect1039ui_story == nil then
				arg_259_1.var_.characterEffect1039ui_story = arg_259_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1039ui_story"]) then
				if arg_259_1.var_.characterEffect1039ui_story and not isNil(arg_259_1.actors_["1039ui_story"]) then
					arg_259_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1039ui_story"]) and arg_259_1.var_.characterEffect1039ui_story then
				arg_259_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_262_2 = 0
			local var_262_3 = 0.05

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_4 = arg_259_1:GetWordFromCfg(1103905062)
				local var_262_5 = arg_259_1:FormatText(var_262_4.content)

				arg_259_1.text_.text = var_262_5

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_7 = 2 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 2)

				if (2 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_5) / 2)) > 0 and var_262_3 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_5
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905062", "story_v_side_new_1103905.awb") ~= 0 then
					local var_262_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905062", "story_v_side_new_1103905.awb") / 1000

					if var_262_8 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_8 + var_262_2
					end

					if var_262_4.prefab_name ~= "" and arg_259_1.actors_[var_262_4.prefab_name] ~= nil then
						local var_262_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_4.prefab_name].transform, "story_v_side_new_1103905", "1103905062", "story_v_side_new_1103905.awb")

						arg_259_1:RecordAudio("1103905062", var_262_9)
						arg_259_1:RecordAudio("1103905062", var_262_9)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905062", "story_v_side_new_1103905.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905062", "story_v_side_new_1103905.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_10 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_10 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_10

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_10 and arg_259_1.time_ < var_262_2 + var_262_10 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1103905063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1103905063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1103905064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["1039ui_story"]) and arg_263_1.var_.characterEffect1039ui_story == nil then
				arg_263_1.var_.characterEffect1039ui_story = arg_263_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_0 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["1039ui_story"]) then
				if arg_263_1.var_.characterEffect1039ui_story and not isNil(arg_263_1.actors_["1039ui_story"]) then
					arg_263_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_0)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["1039ui_story"]) and arg_263_1.var_.characterEffect1039ui_story then
				arg_263_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_266_1 = arg_263_1.actors_["1039ui_story"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1039ui_story = var_266_1.localPosition
			end

			local var_266_2 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 then
				var_266_1.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_2)
				var_266_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_1.position).x, (manager.ui.mainCamera.transform.position - var_266_1.position).y, (manager.ui.mainCamera.transform.position - var_266_1.position).z)
				var_266_1.localEulerAngles.z = 0
				var_266_1.localEulerAngles.x = 0
				var_266_1.localEulerAngles = var_266_1.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 then
				var_266_1.localPosition = Vector3.New(0, 100, 0)
				var_266_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_1.position).x, (manager.ui.mainCamera.transform.position - var_266_1.position).y, (manager.ui.mainCamera.transform.position - var_266_1.position).z)
				var_266_1.localEulerAngles.z = 0
				var_266_1.localEulerAngles.x = 0
				var_266_1.localEulerAngles = var_266_1.localEulerAngles
			end

			local var_266_3 = manager.ui.mainCamera.transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.shakeOldPos = var_266_3.localPosition
			end

			local var_266_4 = 0.6

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				local var_266_5, var_266_6 = math.modf((arg_263_1.time_ - 0) / 0.066)

				var_266_3.localPosition = Vector3.New(var_266_6 * 0.13, var_266_6 * 0.13, var_266_6 * 0.13) + arg_263_1.var_.shakeOldPos
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				var_266_3.localPosition = arg_263_1.var_.shakeOldPos
			end

			local var_266_7 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			if arg_263_1.time_ >= var_266_7 + 0.6 and arg_263_1.time_ < var_266_7 + 0.6 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_8 = 0
			local var_266_9 = 1.625

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_10 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1103905063).content)

				arg_263_1.text_.text = var_266_10

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_12 = 65 <= 0 and var_266_9 or var_266_9 * (utf8.len(var_266_10) / 65)

				if (65 <= 0 and var_266_9 or var_266_9 * (utf8.len(var_266_10) / 65)) > 0 and var_266_9 < var_266_12 then
					arg_263_1.talkMaxDuration = var_266_12

					if var_266_12 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_10
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_13 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_13 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_13

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_13 and arg_263_1.time_ < var_266_8 + var_266_13 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play1103905064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1103905064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1103905065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.125

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1103905064).content)

				arg_267_1.text_.text = var_270_1

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_3 = 5 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 5)

				if (5 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_1) / 5)) > 0 and var_270_0 < var_270_3 then
					arg_267_1.talkMaxDuration = var_270_3

					if var_270_3 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_3 + 0
					end
				end

				arg_267_1.text_.text = var_270_1
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_4 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_4

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1103905065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1103905065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1103905066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.4

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(1103905065).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 56 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 56)

				if (56 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 56)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1103905066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1103905066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1103905067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.9

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
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

				local var_278_1 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1103905066).content)

				arg_275_1.text_.text = var_278_1

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_3 = 36 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 36)

				if (36 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_1) / 36)) > 0 and var_278_0 < var_278_3 then
					arg_275_1.talkMaxDuration = var_278_3

					if var_278_3 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_3 + 0
					end
				end

				arg_275_1.text_.text = var_278_1
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_4 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_4 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_4

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_4 and arg_275_1.time_ < 0 + var_278_4 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1103905067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1103905067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1103905068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 1.05

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(1103905067).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 42 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 42)

				if (42 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 42)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1103905068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1103905068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1103905069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.475

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1103905068).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 19 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 19)

				if (19 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 19)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1103905069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1103905069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1103905070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.475

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1103905069).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 19 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 19)

				if (19 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 19)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1103905070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1103905070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1103905071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 1.025

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1103905070).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 41 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 41)

				if (41 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 41)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1103905071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1103905071
		arg_295_1.duration_ = 12.1

		local var_295_0 = {
			zh = 4.8,
			ja = 12.1
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1103905072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.55

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:GetWordFromCfg(1103905071)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 22 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 22)

				if (22 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 22)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905071", "story_v_side_new_1103905.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905071", "story_v_side_new_1103905.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_side_new_1103905", "1103905071", "story_v_side_new_1103905.awb")

						arg_295_1:RecordAudio("1103905071", var_298_6)
						arg_295_1:RecordAudio("1103905071", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905071", "story_v_side_new_1103905.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905071", "story_v_side_new_1103905.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1103905072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1103905072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1103905073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.05

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(1103905072).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 2 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 2)

				if (2 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 2)) > 0 and var_302_0 < var_302_3 then
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
	Play1103905073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1103905073
		arg_303_1.duration_ = 9

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1103905074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 1.999999999999 < arg_303_1.time_ and arg_303_1.time_ <= 1.999999999999 + arg_306_0 then
				local var_306_0 = arg_303_1.bgs_.ST01

				arg_303_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_306_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_306_1 = var_306_0:GetComponent("SpriteRenderer")

				if var_306_1 and var_306_1.sprite then
					local var_306_2 = 2 * (var_306_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_306_0.transform.localScale = Vector3.New(var_306_2 / var_306_1.sprite.bounds.size.y < var_306_2 * manager.ui.mainCameraCom_.aspect / var_306_1.sprite.bounds.size.x and var_306_2 * manager.ui.mainCameraCom_.aspect / var_306_1.sprite.bounds.size.x or var_306_2 / var_306_1.sprite.bounds.size.y, var_306_2 / var_306_1.sprite.bounds.size.y < var_306_2 * manager.ui.mainCameraCom_.aspect / var_306_1.sprite.bounds.size.x and var_306_2 * manager.ui.mainCameraCom_.aspect / var_306_1.sprite.bounds.size.x or var_306_2 / var_306_1.sprite.bounds.size.y, 0)
				end

				for iter_306_0, iter_306_1 in pairs(arg_303_1.bgs_) do
					if iter_306_0 ~= "ST01" then
						iter_306_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_306_3 = 0

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_3 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_4 = 2

			if var_306_3 <= arg_303_1.time_ and arg_303_1.time_ < var_306_3 + var_306_4 then
				local var_306_5 = Color.New(0, 0, 0)

				var_306_5.a = Mathf.Lerp(0, 1, (arg_303_1.time_ - var_306_3) / var_306_4)
				arg_303_1.mask_.color = var_306_5
			end

			if arg_303_1.time_ >= var_306_3 + var_306_4 and arg_303_1.time_ < var_306_3 + var_306_4 + arg_306_0 then
				local var_306_6 = Color.New(0, 0, 0)

				var_306_6.a = 1
				arg_303_1.mask_.color = var_306_6
			end

			local var_306_7 = 2

			if 2 < arg_303_1.time_ and arg_303_1.time_ <= var_306_7 + arg_306_0 then
				arg_303_1.mask_.enabled = true
				arg_303_1.mask_.raycastTarget = true

				arg_303_1:SetGaussion(false)
			end

			local var_306_8 = 2

			if var_306_7 <= arg_303_1.time_ and arg_303_1.time_ < var_306_7 + var_306_8 then
				local var_306_9 = Color.New(0, 0, 0)

				var_306_9.a = Mathf.Lerp(1, 0, (arg_303_1.time_ - var_306_7) / var_306_8)
				arg_303_1.mask_.color = var_306_9
			end

			if arg_303_1.time_ >= var_306_7 + var_306_8 and arg_303_1.time_ < var_306_7 + var_306_8 + arg_306_0 then
				local var_306_10 = Color.New(0, 0, 0)

				arg_303_1.mask_.enabled = false
				var_306_10.a = 0
				arg_303_1.mask_.color = var_306_10
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_sea", "")
			end

			if arg_303_1.frameCnt_ <= 1 then
				arg_303_1.dialog_:SetActive(false)
			end

			local var_306_12 = 3.999999999999
			local var_306_13 = 0.875

			if 3.999999999999 < arg_303_1.time_ and arg_303_1.time_ <= var_306_12 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0

				arg_303_1.dialog_:SetActive(true)

				arg_303_1.dialogCg_.alpha = 0

				local var_306_14 = LeanTween.value(arg_303_1.dialog_, 0, 1, 0.3)

				var_306_14:setOnUpdate(LuaHelper.FloatAction(function(arg_307_0)
					arg_303_1.dialogCg_.alpha = arg_307_0
				end))
				var_306_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_303_1.dialog_)
					var_306_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_303_1.duration_ = arg_303_1.duration_ + 0.3

				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_15 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1103905073).content)

				arg_303_1.text_.text = var_306_15

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_17 = 35 <= 0 and var_306_13 or var_306_13 * (utf8.len(var_306_15) / 35)

				if (35 <= 0 and var_306_13 or var_306_13 * (utf8.len(var_306_15) / 35)) > 0 and var_306_13 < var_306_17 then
					arg_303_1.talkMaxDuration = var_306_17
					var_306_12 = var_306_12 + 0.3

					if var_306_17 + var_306_12 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_17 + var_306_12
					end
				end

				arg_303_1.text_.text = var_306_15
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_18 = var_306_12 + 0.3
			local var_306_19 = math.max(var_306_13, arg_303_1.talkMaxDuration)

			if var_306_12 + 0.3 <= arg_303_1.time_ and arg_303_1.time_ < var_306_18 + var_306_19 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_18) / var_306_19

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_18 + var_306_19 and arg_303_1.time_ < var_306_18 + var_306_19 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1103905074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1103905074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1103905075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 1.425

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1103905074).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 57 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 57)

				if (57 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 57)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1103905075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1103905075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1103905076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 1.475

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(1103905075).content)

				arg_313_1.text_.text = var_316_1

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_3 = 59 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 59)

				if (59 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_1) / 59)) > 0 and var_316_0 < var_316_3 then
					arg_313_1.talkMaxDuration = var_316_3

					if var_316_3 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_3 + 0
					end
				end

				arg_313_1.text_.text = var_316_1
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_4 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_4 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_4

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_4 and arg_313_1.time_ < 0 + var_316_4 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1103905076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1103905076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1103905077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.55

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1103905076).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 22 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 22)

				if (22 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 22)) > 0 and var_320_0 < var_320_3 then
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
	Play1103905077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1103905077
		arg_321_1.duration_ = 1

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"

			SetActive(arg_321_1.choicesGo_, true)

			for iter_322_0, iter_322_1 in ipairs(arg_321_1.choices_) do
				SetActive(iter_322_1.go, iter_322_0 <= 1)
			end

			arg_321_1.choices_[1].txt.text = arg_321_1:FormatText(StoryChoiceCfg[694].name)
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1103905078(arg_321_1)
			end

			arg_321_1:RecordChoiceLog(1103905077, 694)
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.allBtn_.enabled = false
			end

			if arg_321_1.time_ >= 0 + 0.5 and arg_321_1.time_ < 0 + 0.5 + arg_324_0 then
				arg_321_1.allBtn_.enabled = true
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1103905078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1103905078
		arg_325_1.duration_ = 9

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1103905079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 2 < arg_325_1.time_ and arg_325_1.time_ <= 2 + arg_328_0 then
				local var_328_0 = arg_325_1.bgs_.B13

				arg_325_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_328_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_328_1 = var_328_0:GetComponent("SpriteRenderer")

				if var_328_1 and var_328_1.sprite then
					local var_328_2 = 2 * (var_328_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_328_0.transform.localScale = Vector3.New(var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, var_328_2 / var_328_1.sprite.bounds.size.y < var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x and var_328_2 * manager.ui.mainCameraCom_.aspect / var_328_1.sprite.bounds.size.x or var_328_2 / var_328_1.sprite.bounds.size.y, 0)
				end

				for iter_328_0, iter_328_1 in pairs(arg_325_1.bgs_) do
					if iter_328_0 ~= "B13" then
						iter_328_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_328_3 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_3 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_4 = 2

			if var_328_3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_3 + var_328_4 then
				local var_328_5 = Color.New(0, 0, 0)

				var_328_5.a = Mathf.Lerp(0, 1, (arg_325_1.time_ - var_328_3) / var_328_4)
				arg_325_1.mask_.color = var_328_5
			end

			if arg_325_1.time_ >= var_328_3 + var_328_4 and arg_325_1.time_ < var_328_3 + var_328_4 + arg_328_0 then
				local var_328_6 = Color.New(0, 0, 0)

				var_328_6.a = 1
				arg_325_1.mask_.color = var_328_6
			end

			local var_328_7 = 2

			if 2 < arg_325_1.time_ and arg_325_1.time_ <= var_328_7 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_8 = 2

			if var_328_7 <= arg_325_1.time_ and arg_325_1.time_ < var_328_7 + var_328_8 then
				local var_328_9 = Color.New(0, 0, 0)

				var_328_9.a = Mathf.Lerp(1, 0, (arg_325_1.time_ - var_328_7) / var_328_8)
				arg_325_1.mask_.color = var_328_9
			end

			if arg_325_1.time_ >= var_328_7 + var_328_8 and arg_325_1.time_ < var_328_7 + var_328_8 + arg_328_0 then
				local var_328_10 = Color.New(0, 0, 0)

				arg_325_1.mask_.enabled = false
				var_328_10.a = 0
				arg_325_1.mask_.color = var_328_10
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_11 = 3.999999999999
			local var_328_12 = 1.6

			if 3.999999999999 < arg_325_1.time_ and arg_325_1.time_ <= var_328_11 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_13 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_13:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(1103905078).content)

				arg_325_1.text_.text = var_328_14

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_16 = 64 <= 0 and var_328_12 or var_328_12 * (utf8.len(var_328_14) / 64)

				if (64 <= 0 and var_328_12 or var_328_12 * (utf8.len(var_328_14) / 64)) > 0 and var_328_12 < var_328_16 then
					arg_325_1.talkMaxDuration = var_328_16
					var_328_11 = var_328_11 + 0.3

					if var_328_16 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_16 + var_328_11
					end
				end

				arg_325_1.text_.text = var_328_14
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_17 = var_328_11 + 0.3
			local var_328_18 = math.max(var_328_12, arg_325_1.talkMaxDuration)

			if var_328_11 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_17 + var_328_18 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_17) / var_328_18

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_17 + var_328_18 and arg_325_1.time_ < var_328_17 + var_328_18 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1103905079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1103905079
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1103905080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.1

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1103905079).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 4 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 4)

				if (4 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 4)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1103905080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1103905080
		arg_335_1.duration_ = 8.43

		local var_335_0 = {
			zh = 5,
			ja = 8.433
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
				arg_335_0:Play1103905081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1039ui_story = arg_335_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_338_0 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 then
				arg_335_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_335_1.time_ - 0) / var_338_0)
				arg_335_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1039ui_story"].transform.position).z)
				arg_335_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1039ui_story"].transform.localEulerAngles = arg_335_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 then
				arg_335_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_335_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_335_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_335_1.actors_["1039ui_story"].transform.position).z)
				arg_335_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_335_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_335_1.actors_["1039ui_story"].transform.localEulerAngles = arg_335_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_338_1 = arg_335_1.actors_["1039ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1039ui_story == nil then
				arg_335_1.var_.characterEffect1039ui_story = var_338_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 and not isNil(var_338_1) then
				if arg_335_1.var_.characterEffect1039ui_story and not isNil(var_338_1) then
					arg_335_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 and not isNil(var_338_1) and arg_335_1.var_.characterEffect1039ui_story then
				arg_335_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action7_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_338_4 = 0
			local var_338_5 = 0.4

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_6 = arg_335_1:GetWordFromCfg(1103905080)
				local var_338_7 = arg_335_1:FormatText(var_338_6.content)

				arg_335_1.text_.text = var_338_7

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 16 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 16)

				if (16 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 16)) > 0 and var_338_5 < var_338_9 then
					arg_335_1.talkMaxDuration = var_338_9

					if var_338_9 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_9 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_7
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905080", "story_v_side_new_1103905.awb") ~= 0 then
					local var_338_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905080", "story_v_side_new_1103905.awb") / 1000

					if var_338_10 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_4
					end

					if var_338_6.prefab_name ~= "" and arg_335_1.actors_[var_338_6.prefab_name] ~= nil then
						local var_338_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_6.prefab_name].transform, "story_v_side_new_1103905", "1103905080", "story_v_side_new_1103905.awb")

						arg_335_1:RecordAudio("1103905080", var_338_11)
						arg_335_1:RecordAudio("1103905080", var_338_11)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905080", "story_v_side_new_1103905.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905080", "story_v_side_new_1103905.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_12 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_12 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_12

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_12 and arg_335_1.time_ < var_338_4 + var_338_12 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play1103905081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1103905081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1103905082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1039ui_story"]) and arg_339_1.var_.characterEffect1039ui_story == nil then
				arg_339_1.var_.characterEffect1039ui_story = arg_339_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1039ui_story"]) then
				if arg_339_1.var_.characterEffect1039ui_story and not isNil(arg_339_1.actors_["1039ui_story"]) then
					arg_339_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1039ui_story"]) and arg_339_1.var_.characterEffect1039ui_story then
				arg_339_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_342_1 = 0
			local var_342_2 = 1.125

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

				local var_342_3 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(1103905081).content)

				arg_339_1.text_.text = var_342_3

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 45 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 45)

				if (45 <= 0 and var_342_2 or var_342_2 * (utf8.len(var_342_3) / 45)) > 0 and var_342_2 < var_342_5 then
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

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1103905082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1103905082
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1103905083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.55

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1103905082).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 22 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 22)

				if (22 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 22)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1103905083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1103905083
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1103905084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.5

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_1 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1103905083).content)

				arg_347_1.text_.text = var_350_1

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_3 = 20 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 20)

				if (20 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_1) / 20)) > 0 and var_350_0 < var_350_3 then
					arg_347_1.talkMaxDuration = var_350_3

					if var_350_3 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_3 + 0
					end
				end

				arg_347_1.text_.text = var_350_1
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_4 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_4 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_4

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_4 and arg_347_1.time_ < 0 + var_350_4 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1103905084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1103905084
		arg_351_1.duration_ = 7.9

		local var_351_0 = {
			zh = 7.666,
			ja = 7.9
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
				arg_351_0:Play1103905085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1039ui_story = arg_351_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).z)
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles = arg_351_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_351_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1039ui_story"].transform.position).z)
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1039ui_story"].transform.localEulerAngles = arg_351_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["1039ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1039ui_story == nil then
				arg_351_1.var_.characterEffect1039ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect1039ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1039ui_story then
				arg_351_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action7_2")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_354_4 = 0
			local var_354_5 = 0.575

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(1103905084)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 23 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 23)

				if (23 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 23)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905084", "story_v_side_new_1103905.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905084", "story_v_side_new_1103905.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_side_new_1103905", "1103905084", "story_v_side_new_1103905.awb")

						arg_351_1:RecordAudio("1103905084", var_354_11)
						arg_351_1:RecordAudio("1103905084", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905084", "story_v_side_new_1103905.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905084", "story_v_side_new_1103905.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_12 and arg_351_1.time_ < var_354_4 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play1103905085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1103905085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1103905086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1039ui_story"]) and arg_355_1.var_.characterEffect1039ui_story == nil then
				arg_355_1.var_.characterEffect1039ui_story = arg_355_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1039ui_story"]) then
				if arg_355_1.var_.characterEffect1039ui_story and not isNil(arg_355_1.actors_["1039ui_story"]) then
					arg_355_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1039ui_story"]) and arg_355_1.var_.characterEffect1039ui_story then
				arg_355_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.725

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(1103905085).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 29 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 29)

				if (29 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 29)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1103905086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1103905086
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1103905087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 1.2

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(1103905086).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 48 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 48)

				if (48 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 48)) > 0 and var_362_0 < var_362_3 then
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
	Play1103905087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1103905087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1103905088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.95

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

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(1103905087).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 38 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 38)

				if (38 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 38)) > 0 and var_366_0 < var_366_3 then
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
	Play1103905088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1103905088
		arg_367_1.duration_ = 6.27

		local var_367_0 = {
			zh = 6.266,
			ja = 5.7
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
				arg_367_0:Play1103905089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1039ui_story = arg_367_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1039ui_story"].transform.position).z)
				arg_367_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1039ui_story"].transform.localEulerAngles = arg_367_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_367_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1039ui_story"].transform.position).z)
				arg_367_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1039ui_story"].transform.localEulerAngles = arg_367_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["1039ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1039ui_story == nil then
				arg_367_1.var_.characterEffect1039ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect1039ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect1039ui_story then
				arg_367_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_370_4 = 0
			local var_370_5 = 0.475

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(1103905088)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 19 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 19)

				if (19 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 19)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905088", "story_v_side_new_1103905.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905088", "story_v_side_new_1103905.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_side_new_1103905", "1103905088", "story_v_side_new_1103905.awb")

						arg_367_1:RecordAudio("1103905088", var_370_11)
						arg_367_1:RecordAudio("1103905088", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905088", "story_v_side_new_1103905.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905088", "story_v_side_new_1103905.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
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
	Play1103905089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1103905089
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1103905090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1039ui_story"]) and arg_371_1.var_.characterEffect1039ui_story == nil then
				arg_371_1.var_.characterEffect1039ui_story = arg_371_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1039ui_story"]) then
				if arg_371_1.var_.characterEffect1039ui_story and not isNil(arg_371_1.actors_["1039ui_story"]) then
					arg_371_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1039ui_story"]) and arg_371_1.var_.characterEffect1039ui_story then
				arg_371_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0
			local var_374_2 = 0.475

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

				local var_374_3 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1103905089).content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 19 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 19)

				if (19 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 19)) > 0 and var_374_2 < var_374_5 then
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

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1103905090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1103905090
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1103905091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.325

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(1103905090).content)

				arg_375_1.text_.text = var_378_1

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_3 = 13 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 13)

				if (13 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_1) / 13)) > 0 and var_378_0 < var_378_3 then
					arg_375_1.talkMaxDuration = var_378_3

					if var_378_3 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_3 + 0
					end
				end

				arg_375_1.text_.text = var_378_1
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_4 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_4

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1103905091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1103905091
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1103905092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.55

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_1 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1103905091).content)

				arg_379_1.text_.text = var_382_1

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_3 = 22 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 22)

				if (22 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 22)) > 0 and var_382_0 < var_382_3 then
					arg_379_1.talkMaxDuration = var_382_3

					if var_382_3 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_3 + 0
					end
				end

				arg_379_1.text_.text = var_382_1
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_4 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_4

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1103905092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1103905092
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1103905093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 1.6

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1103905092).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 64 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 64)

				if (64 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 64)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1103905093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1103905093
		arg_387_1.duration_ = 7.5

		local var_387_0 = {
			zh = 2.6,
			ja = 7.5
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
				arg_387_0:Play1103905094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["1039ui_story"]) and arg_387_1.var_.characterEffect1039ui_story == nil then
				arg_387_1.var_.characterEffect1039ui_story = arg_387_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["1039ui_story"]) then
				if arg_387_1.var_.characterEffect1039ui_story and not isNil(arg_387_1.actors_["1039ui_story"]) then
					arg_387_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["1039ui_story"]) and arg_387_1.var_.characterEffect1039ui_story then
				arg_387_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_390_2 = 0
			local var_390_3 = 0.2

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_4 = arg_387_1:GetWordFromCfg(1103905093)
				local var_390_5 = arg_387_1:FormatText(var_390_4.content)

				arg_387_1.text_.text = var_390_5

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 8 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 8)

				if (8 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 8)) > 0 and var_390_3 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_5
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905093", "story_v_side_new_1103905.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905093", "story_v_side_new_1103905.awb") / 1000

					if var_390_8 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_2
					end

					if var_390_4.prefab_name ~= "" and arg_387_1.actors_[var_390_4.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_4.prefab_name].transform, "story_v_side_new_1103905", "1103905093", "story_v_side_new_1103905.awb")

						arg_387_1:RecordAudio("1103905093", var_390_9)
						arg_387_1:RecordAudio("1103905093", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905093", "story_v_side_new_1103905.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905093", "story_v_side_new_1103905.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_10 and arg_387_1.time_ < var_390_2 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1103905094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1103905094
		arg_391_1.duration_ = 7.8

		local var_391_0 = {
			zh = 3.8,
			ja = 7.8
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
				arg_391_0:Play1103905095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.35

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:GetWordFromCfg(1103905094)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 14 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 14)

				if (14 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 14)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905094", "story_v_side_new_1103905.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905094", "story_v_side_new_1103905.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_side_new_1103905", "1103905094", "story_v_side_new_1103905.awb")

						arg_391_1:RecordAudio("1103905094", var_394_6)
						arg_391_1:RecordAudio("1103905094", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905094", "story_v_side_new_1103905.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905094", "story_v_side_new_1103905.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1103905095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1103905095
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1103905096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["1039ui_story"]) and arg_395_1.var_.characterEffect1039ui_story == nil then
				arg_395_1.var_.characterEffect1039ui_story = arg_395_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["1039ui_story"]) then
				if arg_395_1.var_.characterEffect1039ui_story and not isNil(arg_395_1.actors_["1039ui_story"]) then
					arg_395_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_0)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["1039ui_story"]) and arg_395_1.var_.characterEffect1039ui_story then
				arg_395_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_398_1 = 0
			local var_398_2 = 1.3

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, false)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_3 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(1103905095).content)

				arg_395_1.text_.text = var_398_3

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_5 = 52 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 52)

				if (52 <= 0 and var_398_2 or var_398_2 * (utf8.len(var_398_3) / 52)) > 0 and var_398_2 < var_398_5 then
					arg_395_1.talkMaxDuration = var_398_5

					if var_398_5 + var_398_1 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + var_398_1
					end
				end

				arg_395_1.text_.text = var_398_3
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_6 = math.max(var_398_2, arg_395_1.talkMaxDuration)

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_6 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_1) / var_398_6

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_1 + var_398_6 and arg_395_1.time_ < var_398_1 + var_398_6 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1103905096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1103905096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1103905097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.3

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1103905096).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 12 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 12)

				if (12 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 12)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1103905097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1103905097
		arg_403_1.duration_ = 5.83

		local var_403_0 = {
			zh = 5.833,
			ja = 3.833
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
				arg_403_0:Play1103905098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1039ui_story"]) and arg_403_1.var_.characterEffect1039ui_story == nil then
				arg_403_1.var_.characterEffect1039ui_story = arg_403_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1039ui_story"]) then
				if arg_403_1.var_.characterEffect1039ui_story and not isNil(arg_403_1.actors_["1039ui_story"]) then
					arg_403_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1039ui_story"]) and arg_403_1.var_.characterEffect1039ui_story then
				arg_403_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_406_2 = 0
			local var_406_3 = 0.5

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_2 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_4 = arg_403_1:GetWordFromCfg(1103905097)
				local var_406_5 = arg_403_1:FormatText(var_406_4.content)

				arg_403_1.text_.text = var_406_5

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_7 = 20 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 20)

				if (20 <= 0 and var_406_3 or var_406_3 * (utf8.len(var_406_5) / 20)) > 0 and var_406_3 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_2
					end
				end

				arg_403_1.text_.text = var_406_5
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905097", "story_v_side_new_1103905.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905097", "story_v_side_new_1103905.awb") / 1000

					if var_406_8 + var_406_2 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_2
					end

					if var_406_4.prefab_name ~= "" and arg_403_1.actors_[var_406_4.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_4.prefab_name].transform, "story_v_side_new_1103905", "1103905097", "story_v_side_new_1103905.awb")

						arg_403_1:RecordAudio("1103905097", var_406_9)
						arg_403_1:RecordAudio("1103905097", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905097", "story_v_side_new_1103905.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905097", "story_v_side_new_1103905.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_3, arg_403_1.talkMaxDuration)

			if var_406_2 <= arg_403_1.time_ and arg_403_1.time_ < var_406_2 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_2) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_2 + var_406_10 and arg_403_1.time_ < var_406_2 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1103905098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1103905098
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1103905099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["1039ui_story"]) and arg_407_1.var_.characterEffect1039ui_story == nil then
				arg_407_1.var_.characterEffect1039ui_story = arg_407_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["1039ui_story"]) then
				if arg_407_1.var_.characterEffect1039ui_story and not isNil(arg_407_1.actors_["1039ui_story"]) then
					arg_407_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_407_1.time_ - 0) / var_410_0)
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["1039ui_story"]) and arg_407_1.var_.characterEffect1039ui_story then
				arg_407_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_410_1 = 0
			local var_410_2 = 0.85

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

				local var_410_3 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1103905098).content)

				arg_407_1.text_.text = var_410_3

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 34 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 34)

				if (34 <= 0 and var_410_2 or var_410_2 * (utf8.len(var_410_3) / 34)) > 0 and var_410_2 < var_410_5 then
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
	Play1103905099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1103905099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1103905100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.1

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1103905099).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 4 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 4)

				if (4 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 4)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1103905100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1103905100
		arg_415_1.duration_ = 9.9

		local var_415_0 = {
			zh = 6.5,
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
				arg_415_0:Play1103905101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1039ui_story = arg_415_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_418_0 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 then
				arg_415_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_415_1.time_ - 0) / var_418_0)
				arg_415_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1039ui_story"].transform.position).z)
				arg_415_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1039ui_story"].transform.localEulerAngles = arg_415_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 then
				arg_415_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_415_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_415_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_415_1.actors_["1039ui_story"].transform.position).z)
				arg_415_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_415_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_415_1.actors_["1039ui_story"].transform.localEulerAngles = arg_415_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_418_1 = arg_415_1.actors_["1039ui_story"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1039ui_story == nil then
				arg_415_1.var_.characterEffect1039ui_story = var_418_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_2 and not isNil(var_418_1) then
				if arg_415_1.var_.characterEffect1039ui_story and not isNil(var_418_1) then
					arg_415_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_2 and arg_415_1.time_ < 0 + var_418_2 + arg_418_0 and not isNil(var_418_1) and arg_415_1.var_.characterEffect1039ui_story then
				arg_415_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action467")
			end

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_418_4 = 0
			local var_418_5 = 0.8

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_6 = arg_415_1:GetWordFromCfg(1103905100)
				local var_418_7 = arg_415_1:FormatText(var_418_6.content)

				arg_415_1.text_.text = var_418_7

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 32 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 32)

				if (32 <= 0 and var_418_5 or var_418_5 * (utf8.len(var_418_7) / 32)) > 0 and var_418_5 < var_418_9 then
					arg_415_1.talkMaxDuration = var_418_9

					if var_418_9 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_9 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_7
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905100", "story_v_side_new_1103905.awb") ~= 0 then
					local var_418_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905100", "story_v_side_new_1103905.awb") / 1000

					if var_418_10 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_4
					end

					if var_418_6.prefab_name ~= "" and arg_415_1.actors_[var_418_6.prefab_name] ~= nil then
						local var_418_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_6.prefab_name].transform, "story_v_side_new_1103905", "1103905100", "story_v_side_new_1103905.awb")

						arg_415_1:RecordAudio("1103905100", var_418_11)
						arg_415_1:RecordAudio("1103905100", var_418_11)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905100", "story_v_side_new_1103905.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905100", "story_v_side_new_1103905.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_12 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_12 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_12

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_12 and arg_415_1.time_ < var_418_4 + var_418_12 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1103905101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1103905101
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1103905102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["1039ui_story"]) and arg_419_1.var_.characterEffect1039ui_story == nil then
				arg_419_1.var_.characterEffect1039ui_story = arg_419_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_0 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["1039ui_story"]) then
				if arg_419_1.var_.characterEffect1039ui_story and not isNil(arg_419_1.actors_["1039ui_story"]) then
					arg_419_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_419_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_0)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["1039ui_story"]) and arg_419_1.var_.characterEffect1039ui_story then
				arg_419_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_419_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_422_1 = 0
			local var_422_2 = 0.45

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_3 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(1103905101).content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 18 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 18)

				if (18 <= 0 and var_422_2 or var_422_2 * (utf8.len(var_422_3) / 18)) > 0 and var_422_2 < var_422_5 then
					arg_419_1.talkMaxDuration = var_422_5

					if var_422_5 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + var_422_1
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_6 = math.max(var_422_2, arg_419_1.talkMaxDuration)

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_6 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_1) / var_422_6

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_1 + var_422_6 and arg_419_1.time_ < var_422_1 + var_422_6 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1103905102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1103905102
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1103905103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos1039ui_story = arg_423_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_426_0 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				arg_423_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1039ui_story"].transform.position).z)
				arg_423_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1039ui_story"].transform.localEulerAngles = arg_423_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				arg_423_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_423_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_423_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_423_1.actors_["1039ui_story"].transform.position).z)
				arg_423_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_423_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_423_1.actors_["1039ui_story"].transform.localEulerAngles = arg_423_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_426_1 = arg_423_1.actors_["1039ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1039ui_story == nil then
				arg_423_1.var_.characterEffect1039ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1039ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_2)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1039ui_story then
				arg_423_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_426_3 = 0
			local var_426_4 = 1.025

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_3 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_5 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1103905102).content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 41 <= 0 and var_426_4 or var_426_4 * (utf8.len(var_426_5) / 41)

				if (41 <= 0 and var_426_4 or var_426_4 * (utf8.len(var_426_5) / 41)) > 0 and var_426_4 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_3 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_3
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_8 = math.max(var_426_4, arg_423_1.talkMaxDuration)

			if var_426_3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_3 + var_426_8 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_3) / var_426_8

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_3 + var_426_8 and arg_423_1.time_ < var_426_3 + var_426_8 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
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
	Play1103905103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1103905103
		arg_427_1.duration_ = 9

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1103905104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 2 < arg_427_1.time_ and arg_427_1.time_ <= 2 + arg_430_0 then
				local var_430_0 = arg_427_1.bgs_.ST01

				arg_427_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_430_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_430_1 = var_430_0:GetComponent("SpriteRenderer")

				if var_430_1 and var_430_1.sprite then
					local var_430_2 = 2 * (var_430_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_430_0.transform.localScale = Vector3.New(var_430_2 / var_430_1.sprite.bounds.size.y < var_430_2 * manager.ui.mainCameraCom_.aspect / var_430_1.sprite.bounds.size.x and var_430_2 * manager.ui.mainCameraCom_.aspect / var_430_1.sprite.bounds.size.x or var_430_2 / var_430_1.sprite.bounds.size.y, var_430_2 / var_430_1.sprite.bounds.size.y < var_430_2 * manager.ui.mainCameraCom_.aspect / var_430_1.sprite.bounds.size.x and var_430_2 * manager.ui.mainCameraCom_.aspect / var_430_1.sprite.bounds.size.x or var_430_2 / var_430_1.sprite.bounds.size.y, 0)
				end

				for iter_430_0, iter_430_1 in pairs(arg_427_1.bgs_) do
					if iter_430_0 ~= "ST01" then
						iter_430_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_430_3 = 0

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_3 + arg_430_0 then
				arg_427_1.mask_.enabled = true
				arg_427_1.mask_.raycastTarget = true

				arg_427_1:SetGaussion(false)
			end

			local var_430_4 = 2

			if var_430_3 <= arg_427_1.time_ and arg_427_1.time_ < var_430_3 + var_430_4 then
				local var_430_5 = Color.New(0, 0, 0)

				var_430_5.a = Mathf.Lerp(0, 1, (arg_427_1.time_ - var_430_3) / var_430_4)
				arg_427_1.mask_.color = var_430_5
			end

			if arg_427_1.time_ >= var_430_3 + var_430_4 and arg_427_1.time_ < var_430_3 + var_430_4 + arg_430_0 then
				local var_430_6 = Color.New(0, 0, 0)

				var_430_6.a = 1
				arg_427_1.mask_.color = var_430_6
			end

			local var_430_7 = 2

			if 2 < arg_427_1.time_ and arg_427_1.time_ <= var_430_7 + arg_430_0 then
				arg_427_1.mask_.enabled = true
				arg_427_1.mask_.raycastTarget = true

				arg_427_1:SetGaussion(false)
			end

			local var_430_8 = 2

			if var_430_7 <= arg_427_1.time_ and arg_427_1.time_ < var_430_7 + var_430_8 then
				local var_430_9 = Color.New(0, 0, 0)

				var_430_9.a = Mathf.Lerp(1, 0, (arg_427_1.time_ - var_430_7) / var_430_8)
				arg_427_1.mask_.color = var_430_9
			end

			if arg_427_1.time_ >= var_430_7 + var_430_8 and arg_427_1.time_ < var_430_7 + var_430_8 + arg_430_0 then
				local var_430_10 = Color.New(0, 0, 0)

				arg_427_1.mask_.enabled = false
				var_430_10.a = 0
				arg_427_1.mask_.color = var_430_10
			end

			if arg_427_1.frameCnt_ <= 1 then
				arg_427_1.dialog_:SetActive(false)
			end

			local var_430_11 = 4
			local var_430_12 = 0.9

			if 4 < arg_427_1.time_ and arg_427_1.time_ <= var_430_11 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0

				arg_427_1.dialog_:SetActive(true)

				arg_427_1.dialogCg_.alpha = 0

				local var_430_13 = LeanTween.value(arg_427_1.dialog_, 0, 1, 0.3)

				var_430_13:setOnUpdate(LuaHelper.FloatAction(function(arg_431_0)
					arg_427_1.dialogCg_.alpha = arg_431_0
				end))
				var_430_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_427_1.dialog_)
					var_430_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_427_1.duration_ = arg_427_1.duration_ + 0.3

				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_14 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(1103905103).content)

				arg_427_1.text_.text = var_430_14

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_16 = 36 <= 0 and var_430_12 or var_430_12 * (utf8.len(var_430_14) / 36)

				if (36 <= 0 and var_430_12 or var_430_12 * (utf8.len(var_430_14) / 36)) > 0 and var_430_12 < var_430_16 then
					arg_427_1.talkMaxDuration = var_430_16
					var_430_11 = var_430_11 + 0.3

					if var_430_16 + var_430_11 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_16 + var_430_11
					end
				end

				arg_427_1.text_.text = var_430_14
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_17 = var_430_11 + 0.3
			local var_430_18 = math.max(var_430_12, arg_427_1.talkMaxDuration)

			if var_430_11 + 0.3 <= arg_427_1.time_ and arg_427_1.time_ < var_430_17 + var_430_18 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_17) / var_430_18

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_17 + var_430_18 and arg_427_1.time_ < var_430_17 + var_430_18 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1103905104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1103905104
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1103905105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 1.1

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1103905104).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 44 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 44)

				if (44 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 44)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1103905105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1103905105
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1103905106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.825

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_1 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(1103905105).content)

				arg_437_1.text_.text = var_440_1

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_3 = 33 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 33)

				if (33 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 33)) > 0 and var_440_0 < var_440_3 then
					arg_437_1.talkMaxDuration = var_440_3

					if var_440_3 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_3 + 0
					end
				end

				arg_437_1.text_.text = var_440_1
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_4 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_4 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_4

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_4 and arg_437_1.time_ < 0 + var_440_4 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1103905106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1103905106
		arg_441_1.duration_ = 2

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1103905107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos1039ui_story = arg_441_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_444_0 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 then
				arg_441_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_441_1.time_ - 0) / var_444_0)
				arg_441_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1039ui_story"].transform.position).z)
				arg_441_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1039ui_story"].transform.localEulerAngles = arg_441_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 then
				arg_441_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_441_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1039ui_story"].transform.position).z)
				arg_441_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1039ui_story"].transform.localEulerAngles = arg_441_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_444_1 = arg_441_1.actors_["1039ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1039ui_story == nil then
				arg_441_1.var_.characterEffect1039ui_story = var_444_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_2 and not isNil(var_444_1) then
				if arg_441_1.var_.characterEffect1039ui_story and not isNil(var_444_1) then
					arg_441_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_2 and arg_441_1.time_ < 0 + var_444_2 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1039ui_story then
				arg_441_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_444_4 = 0
			local var_444_5 = 0.05

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_6 = arg_441_1:GetWordFromCfg(1103905106)
				local var_444_7 = arg_441_1:FormatText(var_444_6.content)

				arg_441_1.text_.text = var_444_7

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_9 = 2 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 2)

				if (2 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 2)) > 0 and var_444_5 < var_444_9 then
					arg_441_1.talkMaxDuration = var_444_9

					if var_444_9 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_9 + var_444_4
					end
				end

				arg_441_1.text_.text = var_444_7
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905106", "story_v_side_new_1103905.awb") ~= 0 then
					local var_444_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905106", "story_v_side_new_1103905.awb") / 1000

					if var_444_10 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_10 + var_444_4
					end

					if var_444_6.prefab_name ~= "" and arg_441_1.actors_[var_444_6.prefab_name] ~= nil then
						local var_444_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_6.prefab_name].transform, "story_v_side_new_1103905", "1103905106", "story_v_side_new_1103905.awb")

						arg_441_1:RecordAudio("1103905106", var_444_11)
						arg_441_1:RecordAudio("1103905106", var_444_11)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905106", "story_v_side_new_1103905.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905106", "story_v_side_new_1103905.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_12 = math.max(var_444_5, arg_441_1.talkMaxDuration)

			if var_444_4 <= arg_441_1.time_ and arg_441_1.time_ < var_444_4 + var_444_12 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_4) / var_444_12

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_4 + var_444_12 and arg_441_1.time_ < var_444_4 + var_444_12 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play1103905107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1103905107
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1103905108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1039ui_story"]) and arg_445_1.var_.characterEffect1039ui_story == nil then
				arg_445_1.var_.characterEffect1039ui_story = arg_445_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1039ui_story"]) then
				if arg_445_1.var_.characterEffect1039ui_story and not isNil(arg_445_1.actors_["1039ui_story"]) then
					arg_445_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1039ui_story"]) and arg_445_1.var_.characterEffect1039ui_story then
				arg_445_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 1.025

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1103905107).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 41 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 41)

				if (41 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 41)) > 0 and var_448_2 < var_448_5 then
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
	Play1103905108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1103905108
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1103905109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.7

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(1103905108).content)

				arg_449_1.text_.text = var_452_1

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_3 = 28 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 28)

				if (28 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 28)) > 0 and var_452_0 < var_452_3 then
					arg_449_1.talkMaxDuration = var_452_3

					if var_452_3 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_3 + 0
					end
				end

				arg_449_1.text_.text = var_452_1
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_4 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_4

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1103905109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1103905109
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1103905110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_456_0 = 0
			local var_456_1 = 1.45

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1103905109).content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 58 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_2) / 58)

				if (58 <= 0 and var_456_1 or var_456_1 * (utf8.len(var_456_2) / 58)) > 0 and var_456_1 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_5 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_5 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_5

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_5 and arg_453_1.time_ < var_456_0 + var_456_5 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1103905110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1103905110
		arg_457_1.duration_ = 3.2

		local var_457_0 = {
			zh = 2.6,
			ja = 3.2
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1103905111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1039ui_story"]) and arg_457_1.var_.characterEffect1039ui_story == nil then
				arg_457_1.var_.characterEffect1039ui_story = arg_457_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1039ui_story"]) then
				if arg_457_1.var_.characterEffect1039ui_story and not isNil(arg_457_1.actors_["1039ui_story"]) then
					arg_457_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1039ui_story"]) and arg_457_1.var_.characterEffect1039ui_story then
				arg_457_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_1")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_460_2 = 0
			local var_460_3 = 0.225

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_2 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_4 = arg_457_1:GetWordFromCfg(1103905110)
				local var_460_5 = arg_457_1:FormatText(var_460_4.content)

				arg_457_1.text_.text = var_460_5

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_7 = 9 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_5) / 9)

				if (9 <= 0 and var_460_3 or var_460_3 * (utf8.len(var_460_5) / 9)) > 0 and var_460_3 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_2
					end
				end

				arg_457_1.text_.text = var_460_5
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905110", "story_v_side_new_1103905.awb") ~= 0 then
					local var_460_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905110", "story_v_side_new_1103905.awb") / 1000

					if var_460_8 + var_460_2 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_8 + var_460_2
					end

					if var_460_4.prefab_name ~= "" and arg_457_1.actors_[var_460_4.prefab_name] ~= nil then
						local var_460_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_4.prefab_name].transform, "story_v_side_new_1103905", "1103905110", "story_v_side_new_1103905.awb")

						arg_457_1:RecordAudio("1103905110", var_460_9)
						arg_457_1:RecordAudio("1103905110", var_460_9)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905110", "story_v_side_new_1103905.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905110", "story_v_side_new_1103905.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_10 = math.max(var_460_3, arg_457_1.talkMaxDuration)

			if var_460_2 <= arg_457_1.time_ and arg_457_1.time_ < var_460_2 + var_460_10 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_2) / var_460_10

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_2 + var_460_10 and arg_457_1.time_ < var_460_2 + var_460_10 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1103905111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1103905111
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1103905112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1039ui_story"]) and arg_461_1.var_.characterEffect1039ui_story == nil then
				arg_461_1.var_.characterEffect1039ui_story = arg_461_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1039ui_story"]) then
				if arg_461_1.var_.characterEffect1039ui_story and not isNil(arg_461_1.actors_["1039ui_story"]) then
					arg_461_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1039ui_story"]) and arg_461_1.var_.characterEffect1039ui_story then
				arg_461_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_2")
			end

			local var_464_1 = 0
			local var_464_2 = 0.85

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_3 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1103905111).content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 34 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 34)

				if (34 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 34)) > 0 and var_464_2 < var_464_5 then
					arg_461_1.talkMaxDuration = var_464_5

					if var_464_5 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_6 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_6 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_6

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_6 and arg_461_1.time_ < var_464_1 + var_464_6 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1103905112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1103905112
		arg_465_1.duration_ = 3.77

		local var_465_0 = {
			zh = 1.999999999999,
			ja = 3.766
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1103905113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_468_0 = arg_465_1.actors_["1039ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect1039ui_story == nil then
				arg_465_1.var_.characterEffect1039ui_story = var_468_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_1 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_1 and not isNil(var_468_0) then
				if arg_465_1.var_.characterEffect1039ui_story and not isNil(var_468_0) then
					arg_465_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_1 and arg_465_1.time_ < 0 + var_468_1 + arg_468_0 and not isNil(var_468_0) and arg_465_1.var_.characterEffect1039ui_story then
				arg_465_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_468_3 = 0
			local var_468_4 = 0.15

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_3 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_5 = arg_465_1:GetWordFromCfg(1103905112)
				local var_468_6 = arg_465_1:FormatText(var_468_5.content)

				arg_465_1.text_.text = var_468_6

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_8 = 6 <= 0 and var_468_4 or var_468_4 * (utf8.len(var_468_6) / 6)

				if (6 <= 0 and var_468_4 or var_468_4 * (utf8.len(var_468_6) / 6)) > 0 and var_468_4 < var_468_8 then
					arg_465_1.talkMaxDuration = var_468_8

					if var_468_8 + var_468_3 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_3
					end
				end

				arg_465_1.text_.text = var_468_6
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905112", "story_v_side_new_1103905.awb") ~= 0 then
					local var_468_9 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905112", "story_v_side_new_1103905.awb") / 1000

					if var_468_9 + var_468_3 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_9 + var_468_3
					end

					if var_468_5.prefab_name ~= "" and arg_465_1.actors_[var_468_5.prefab_name] ~= nil then
						local var_468_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_5.prefab_name].transform, "story_v_side_new_1103905", "1103905112", "story_v_side_new_1103905.awb")

						arg_465_1:RecordAudio("1103905112", var_468_10)
						arg_465_1:RecordAudio("1103905112", var_468_10)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905112", "story_v_side_new_1103905.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905112", "story_v_side_new_1103905.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_11 = math.max(var_468_4, arg_465_1.talkMaxDuration)

			if var_468_3 <= arg_465_1.time_ and arg_465_1.time_ < var_468_3 + var_468_11 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_3) / var_468_11

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_3 + var_468_11 and arg_465_1.time_ < var_468_3 + var_468_11 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1103905113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1103905113
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1103905114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1039ui_story"]) and arg_469_1.var_.characterEffect1039ui_story == nil then
				arg_469_1.var_.characterEffect1039ui_story = arg_469_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1039ui_story"]) then
				if arg_469_1.var_.characterEffect1039ui_story and not isNil(arg_469_1.actors_["1039ui_story"]) then
					arg_469_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1039ui_story"]) and arg_469_1.var_.characterEffect1039ui_story then
				arg_469_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.1

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
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

				local var_472_3 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1103905113).content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 4 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 4)

				if (4 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 4)) > 0 and var_472_2 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_6 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_6 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_6

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_6 and arg_469_1.time_ < var_472_1 + var_472_6 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1103905114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1103905114
		arg_473_1.duration_ = 5.3

		local var_473_0 = {
			zh = 4.233,
			ja = 5.3
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
				arg_473_0:Play1103905115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["1039ui_story"]) and arg_473_1.var_.characterEffect1039ui_story == nil then
				arg_473_1.var_.characterEffect1039ui_story = arg_473_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["1039ui_story"]) then
				if arg_473_1.var_.characterEffect1039ui_story and not isNil(arg_473_1.actors_["1039ui_story"]) then
					arg_473_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["1039ui_story"]) and arg_473_1.var_.characterEffect1039ui_story then
				arg_473_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_1")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_476_2 = 0
			local var_476_3 = 0.45

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_2 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_4 = arg_473_1:GetWordFromCfg(1103905114)
				local var_476_5 = arg_473_1:FormatText(var_476_4.content)

				arg_473_1.text_.text = var_476_5

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_7 = 18 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_5) / 18)

				if (18 <= 0 and var_476_3 or var_476_3 * (utf8.len(var_476_5) / 18)) > 0 and var_476_3 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_2
					end
				end

				arg_473_1.text_.text = var_476_5
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905114", "story_v_side_new_1103905.awb") ~= 0 then
					local var_476_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905114", "story_v_side_new_1103905.awb") / 1000

					if var_476_8 + var_476_2 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_8 + var_476_2
					end

					if var_476_4.prefab_name ~= "" and arg_473_1.actors_[var_476_4.prefab_name] ~= nil then
						local var_476_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_4.prefab_name].transform, "story_v_side_new_1103905", "1103905114", "story_v_side_new_1103905.awb")

						arg_473_1:RecordAudio("1103905114", var_476_9)
						arg_473_1:RecordAudio("1103905114", var_476_9)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905114", "story_v_side_new_1103905.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905114", "story_v_side_new_1103905.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_10 = math.max(var_476_3, arg_473_1.talkMaxDuration)

			if var_476_2 <= arg_473_1.time_ and arg_473_1.time_ < var_476_2 + var_476_10 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_2) / var_476_10

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_2 + var_476_10 and arg_473_1.time_ < var_476_2 + var_476_10 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1103905115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1103905115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1103905116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1039ui_story"]) and arg_477_1.var_.characterEffect1039ui_story == nil then
				arg_477_1.var_.characterEffect1039ui_story = arg_477_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1039ui_story"]) then
				if arg_477_1.var_.characterEffect1039ui_story and not isNil(arg_477_1.actors_["1039ui_story"]) then
					arg_477_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1039ui_story"]) and arg_477_1.var_.characterEffect1039ui_story then
				arg_477_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_480_1 = 0
			local var_480_2 = 0.95

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, false)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1103905115).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 38 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 38)

				if (38 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 38)) > 0 and var_480_2 < var_480_5 then
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
	Play1103905116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1103905116
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1103905117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action3_2")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_484_0 = 0
			local var_484_1 = 0.375

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
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

				local var_484_2 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(1103905116).content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 15 <= 0 and var_484_1 or var_484_1 * (utf8.len(var_484_2) / 15)

				if (15 <= 0 and var_484_1 or var_484_1 * (utf8.len(var_484_2) / 15)) > 0 and var_484_1 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_5 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_5 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_5

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_5 and arg_481_1.time_ < var_484_0 + var_484_5 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1103905117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1103905117
		arg_485_1.duration_ = 7.3

		local var_485_0 = {
			zh = 4.1,
			ja = 7.3
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1103905118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["1039ui_story"]) and arg_485_1.var_.characterEffect1039ui_story == nil then
				arg_485_1.var_.characterEffect1039ui_story = arg_485_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["1039ui_story"]) then
				if arg_485_1.var_.characterEffect1039ui_story and not isNil(arg_485_1.actors_["1039ui_story"]) then
					arg_485_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["1039ui_story"]) and arg_485_1.var_.characterEffect1039ui_story then
				arg_485_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_488_2 = 0
			local var_488_3 = 0.4

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_4 = arg_485_1:GetWordFromCfg(1103905117)
				local var_488_5 = arg_485_1:FormatText(var_488_4.content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 16 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 16)

				if (16 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 16)) > 0 and var_488_3 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905117", "story_v_side_new_1103905.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905117", "story_v_side_new_1103905.awb") / 1000

					if var_488_8 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_2
					end

					if var_488_4.prefab_name ~= "" and arg_485_1.actors_[var_488_4.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_4.prefab_name].transform, "story_v_side_new_1103905", "1103905117", "story_v_side_new_1103905.awb")

						arg_485_1:RecordAudio("1103905117", var_488_9)
						arg_485_1:RecordAudio("1103905117", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905117", "story_v_side_new_1103905.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905117", "story_v_side_new_1103905.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_10 and arg_485_1.time_ < var_488_2 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1103905118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1103905118
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1103905119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["1039ui_story"]) and arg_489_1.var_.characterEffect1039ui_story == nil then
				arg_489_1.var_.characterEffect1039ui_story = arg_489_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["1039ui_story"]) then
				if arg_489_1.var_.characterEffect1039ui_story and not isNil(arg_489_1.actors_["1039ui_story"]) then
					arg_489_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["1039ui_story"]) and arg_489_1.var_.characterEffect1039ui_story then
				arg_489_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_492_1 = 0
			local var_492_2 = 0.925

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

				local var_492_3 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(1103905118).content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 37 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 37)

				if (37 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 37)) > 0 and var_492_2 < var_492_5 then
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
	Play1103905119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1103905119
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1103905120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = 0.5

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, true)
				arg_493_1.iconController_:SetSelectedState("hero")

				arg_493_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_493_1.callingController_:SetSelectedState("normal")

				arg_493_1.keyicon_.color = Color.New(1, 1, 1)
				arg_493_1.icon_.color = Color.New(1, 1, 1)

				local var_496_1 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(1103905119).content)

				arg_493_1.text_.text = var_496_1

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_3 = 20 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 20)

				if (20 <= 0 and var_496_0 or var_496_0 * (utf8.len(var_496_1) / 20)) > 0 and var_496_0 < var_496_3 then
					arg_493_1.talkMaxDuration = var_496_3

					if var_496_3 + 0 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_3 + 0
					end
				end

				arg_493_1.text_.text = var_496_1
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_4 = math.max(var_496_0, arg_493_1.talkMaxDuration)

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_4 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - 0) / var_496_4

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= 0 + var_496_4 and arg_493_1.time_ < 0 + var_496_4 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play1103905120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1103905120
		arg_497_1.duration_ = 7.53

		local var_497_0 = {
			zh = 3.633,
			ja = 7.533
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
				arg_497_0:Play1103905121(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1039ui_story"]) and arg_497_1.var_.characterEffect1039ui_story == nil then
				arg_497_1.var_.characterEffect1039ui_story = arg_497_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1039ui_story"]) then
				if arg_497_1.var_.characterEffect1039ui_story and not isNil(arg_497_1.actors_["1039ui_story"]) then
					arg_497_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1039ui_story"]) and arg_497_1.var_.characterEffect1039ui_story then
				arg_497_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_500_2 = 0
			local var_500_3 = 0.275

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_2 + arg_500_0 then
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

				local var_500_4 = arg_497_1:GetWordFromCfg(1103905120)
				local var_500_5 = arg_497_1:FormatText(var_500_4.content)

				arg_497_1.text_.text = var_500_5

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_7 = 11 <= 0 and var_500_3 or var_500_3 * (utf8.len(var_500_5) / 11)

				if (11 <= 0 and var_500_3 or var_500_3 * (utf8.len(var_500_5) / 11)) > 0 and var_500_3 < var_500_7 then
					arg_497_1.talkMaxDuration = var_500_7

					if var_500_7 + var_500_2 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_2
					end
				end

				arg_497_1.text_.text = var_500_5
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905120", "story_v_side_new_1103905.awb") ~= 0 then
					local var_500_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905120", "story_v_side_new_1103905.awb") / 1000

					if var_500_8 + var_500_2 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_2
					end

					if var_500_4.prefab_name ~= "" and arg_497_1.actors_[var_500_4.prefab_name] ~= nil then
						local var_500_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_4.prefab_name].transform, "story_v_side_new_1103905", "1103905120", "story_v_side_new_1103905.awb")

						arg_497_1:RecordAudio("1103905120", var_500_9)
						arg_497_1:RecordAudio("1103905120", var_500_9)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905120", "story_v_side_new_1103905.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905120", "story_v_side_new_1103905.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_10 = math.max(var_500_3, arg_497_1.talkMaxDuration)

			if var_500_2 <= arg_497_1.time_ and arg_497_1.time_ < var_500_2 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_2) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_2 + var_500_10 and arg_497_1.time_ < var_500_2 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1103905121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1103905121
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1103905122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1039ui_story"]) and arg_501_1.var_.characterEffect1039ui_story == nil then
				arg_501_1.var_.characterEffect1039ui_story = arg_501_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1039ui_story"]) then
				if arg_501_1.var_.characterEffect1039ui_story and not isNil(arg_501_1.actors_["1039ui_story"]) then
					arg_501_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_0)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1039ui_story"]) and arg_501_1.var_.characterEffect1039ui_story then
				arg_501_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_504_1 = 0
			local var_504_2 = 0.45

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_3 = arg_501_1:FormatText(arg_501_1:GetWordFromCfg(1103905121).content)

				arg_501_1.text_.text = var_504_3

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_5 = 18 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 18)

				if (18 <= 0 and var_504_2 or var_504_2 * (utf8.len(var_504_3) / 18)) > 0 and var_504_2 < var_504_5 then
					arg_501_1.talkMaxDuration = var_504_5

					if var_504_5 + var_504_1 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + var_504_1
					end
				end

				arg_501_1.text_.text = var_504_3
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_6 = math.max(var_504_2, arg_501_1.talkMaxDuration)

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_6 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_1) / var_504_6

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_1 + var_504_6 and arg_501_1.time_ < var_504_1 + var_504_6 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play1103905122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1103905122
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1103905123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = 0.325

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_1 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(1103905122).content)

				arg_505_1.text_.text = var_508_1

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_3 = 13 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 13)

				if (13 <= 0 and var_508_0 or var_508_0 * (utf8.len(var_508_1) / 13)) > 0 and var_508_0 < var_508_3 then
					arg_505_1.talkMaxDuration = var_508_3

					if var_508_3 + 0 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_3 + 0
					end
				end

				arg_505_1.text_.text = var_508_1
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_4 = math.max(var_508_0, arg_505_1.talkMaxDuration)

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - 0) / var_508_4

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play1103905123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1103905123
		arg_509_1.duration_ = 14.4

		local var_509_0 = {
			zh = 9.1,
			ja = 14.4
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1103905124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_512_0 = arg_509_1.actors_["1039ui_story"]

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect1039ui_story == nil then
				arg_509_1.var_.characterEffect1039ui_story = var_512_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_1 = 0.200000002980232

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_1 and not isNil(var_512_0) then
				if arg_509_1.var_.characterEffect1039ui_story and not isNil(var_512_0) then
					arg_509_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= 0 + var_512_1 and arg_509_1.time_ < 0 + var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect1039ui_story then
				arg_509_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_512_3 = 0
			local var_512_4 = 1.1

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_3 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_5 = arg_509_1:GetWordFromCfg(1103905123)
				local var_512_6 = arg_509_1:FormatText(var_512_5.content)

				arg_509_1.text_.text = var_512_6

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_8 = 44 <= 0 and var_512_4 or var_512_4 * (utf8.len(var_512_6) / 44)

				if (44 <= 0 and var_512_4 or var_512_4 * (utf8.len(var_512_6) / 44)) > 0 and var_512_4 < var_512_8 then
					arg_509_1.talkMaxDuration = var_512_8

					if var_512_8 + var_512_3 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_8 + var_512_3
					end
				end

				arg_509_1.text_.text = var_512_6
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905123", "story_v_side_new_1103905.awb") ~= 0 then
					local var_512_9 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905123", "story_v_side_new_1103905.awb") / 1000

					if var_512_9 + var_512_3 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_9 + var_512_3
					end

					if var_512_5.prefab_name ~= "" and arg_509_1.actors_[var_512_5.prefab_name] ~= nil then
						local var_512_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_5.prefab_name].transform, "story_v_side_new_1103905", "1103905123", "story_v_side_new_1103905.awb")

						arg_509_1:RecordAudio("1103905123", var_512_10)
						arg_509_1:RecordAudio("1103905123", var_512_10)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905123", "story_v_side_new_1103905.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905123", "story_v_side_new_1103905.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_11 = math.max(var_512_4, arg_509_1.talkMaxDuration)

			if var_512_3 <= arg_509_1.time_ and arg_509_1.time_ < var_512_3 + var_512_11 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_3) / var_512_11

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_3 + var_512_11 and arg_509_1.time_ < var_512_3 + var_512_11 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1103905124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1103905124
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1103905125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 and not isNil(arg_513_1.actors_["1039ui_story"]) and arg_513_1.var_.characterEffect1039ui_story == nil then
				arg_513_1.var_.characterEffect1039ui_story = arg_513_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_516_0 = 0.200000002980232

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 and not isNil(arg_513_1.actors_["1039ui_story"]) then
				if arg_513_1.var_.characterEffect1039ui_story and not isNil(arg_513_1.actors_["1039ui_story"]) then
					arg_513_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_513_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_513_1.time_ - 0) / var_516_0)
				end
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 and not isNil(arg_513_1.actors_["1039ui_story"]) and arg_513_1.var_.characterEffect1039ui_story then
				arg_513_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_513_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_516_1 = 0
			local var_516_2 = 0.4

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_1 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_3 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(1103905124).content)

				arg_513_1.text_.text = var_516_3

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 16 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 16)

				if (16 <= 0 and var_516_2 or var_516_2 * (utf8.len(var_516_3) / 16)) > 0 and var_516_2 < var_516_5 then
					arg_513_1.talkMaxDuration = var_516_5

					if var_516_5 + var_516_1 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + var_516_1
					end
				end

				arg_513_1.text_.text = var_516_3
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_6 = math.max(var_516_2, arg_513_1.talkMaxDuration)

			if var_516_1 <= arg_513_1.time_ and arg_513_1.time_ < var_516_1 + var_516_6 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_1) / var_516_6

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_1 + var_516_6 and arg_513_1.time_ < var_516_1 + var_516_6 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1103905125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1103905125
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1103905126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 1.05

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, true)
				arg_517_1.iconController_:SetSelectedState("hero")

				arg_517_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_517_1.callingController_:SetSelectedState("normal")

				arg_517_1.keyicon_.color = Color.New(1, 1, 1)
				arg_517_1.icon_.color = Color.New(1, 1, 1)

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(1103905125).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 42 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 42)

				if (42 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 42)) > 0 and var_520_0 < var_520_3 then
					arg_517_1.talkMaxDuration = var_520_3

					if var_520_3 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_3 + 0
					end
				end

				arg_517_1.text_.text = var_520_1
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_4 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_4

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1103905126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1103905126
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1103905127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action453")
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_524_0 = 0
			local var_524_1 = 0.75

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_2 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1103905126).content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 30 <= 0 and var_524_1 or var_524_1 * (utf8.len(var_524_2) / 30)

				if (30 <= 0 and var_524_1 or var_524_1 * (utf8.len(var_524_2) / 30)) > 0 and var_524_1 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + var_524_0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + var_524_0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_5 = math.max(var_524_1, arg_521_1.talkMaxDuration)

			if var_524_0 <= arg_521_1.time_ and arg_521_1.time_ < var_524_0 + var_524_5 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_0) / var_524_5

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_0 + var_524_5 and arg_521_1.time_ < var_524_0 + var_524_5 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1103905127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1103905127
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1103905128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.2

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
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

				local var_528_1 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(1103905127).content)

				arg_525_1.text_.text = var_528_1

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_3 = 8 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 8)

				if (8 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 8)) > 0 and var_528_0 < var_528_3 then
					arg_525_1.talkMaxDuration = var_528_3

					if var_528_3 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_3 + 0
					end
				end

				arg_525_1.text_.text = var_528_1
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_4 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_4

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play1103905128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1103905128
		arg_529_1.duration_ = 2.27

		local var_529_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_529_1 = manager.audio:GetLocalizationFlag()

		if var_529_0[var_529_1] ~= nil then
			arg_529_1.duration_ = var_529_0[var_529_1]
		end

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1103905129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["1039ui_story"]) and arg_529_1.var_.characterEffect1039ui_story == nil then
				arg_529_1.var_.characterEffect1039ui_story = arg_529_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["1039ui_story"]) then
				if arg_529_1.var_.characterEffect1039ui_story and not isNil(arg_529_1.actors_["1039ui_story"]) then
					arg_529_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["1039ui_story"]) and arg_529_1.var_.characterEffect1039ui_story then
				arg_529_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action438")
			end

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_532_2 = 0
			local var_532_3 = 0.15

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_2 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_4 = arg_529_1:GetWordFromCfg(1103905128)
				local var_532_5 = arg_529_1:FormatText(var_532_4.content)

				arg_529_1.text_.text = var_532_5

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_7 = 6 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_5) / 6)

				if (6 <= 0 and var_532_3 or var_532_3 * (utf8.len(var_532_5) / 6)) > 0 and var_532_3 < var_532_7 then
					arg_529_1.talkMaxDuration = var_532_7

					if var_532_7 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_2
					end
				end

				arg_529_1.text_.text = var_532_5
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905128", "story_v_side_new_1103905.awb") ~= 0 then
					local var_532_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905128", "story_v_side_new_1103905.awb") / 1000

					if var_532_8 + var_532_2 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_8 + var_532_2
					end

					if var_532_4.prefab_name ~= "" and arg_529_1.actors_[var_532_4.prefab_name] ~= nil then
						local var_532_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_4.prefab_name].transform, "story_v_side_new_1103905", "1103905128", "story_v_side_new_1103905.awb")

						arg_529_1:RecordAudio("1103905128", var_532_9)
						arg_529_1:RecordAudio("1103905128", var_532_9)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905128", "story_v_side_new_1103905.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905128", "story_v_side_new_1103905.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_10 = math.max(var_532_3, arg_529_1.talkMaxDuration)

			if var_532_2 <= arg_529_1.time_ and arg_529_1.time_ < var_532_2 + var_532_10 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_2) / var_532_10

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_2 + var_532_10 and arg_529_1.time_ < var_532_2 + var_532_10 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1103905129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1103905129
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1103905130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action8_2")
			end

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_536_0 = arg_533_1.actors_["1039ui_story"]

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1039ui_story == nil then
				arg_533_1.var_.characterEffect1039ui_story = var_536_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_1 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_1 and not isNil(var_536_0) then
				if arg_533_1.var_.characterEffect1039ui_story and not isNil(var_536_0) then
					arg_533_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_533_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_533_1.time_ - 0) / var_536_1)
				end
			end

			if arg_533_1.time_ >= 0 + var_536_1 and arg_533_1.time_ < 0 + var_536_1 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1039ui_story then
				arg_533_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_533_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_536_2 = 0
			local var_536_3 = 1.275

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_2 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_4 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(1103905129).content)

				arg_533_1.text_.text = var_536_4

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_6 = 51 <= 0 and var_536_3 or var_536_3 * (utf8.len(var_536_4) / 51)

				if (51 <= 0 and var_536_3 or var_536_3 * (utf8.len(var_536_4) / 51)) > 0 and var_536_3 < var_536_6 then
					arg_533_1.talkMaxDuration = var_536_6

					if var_536_6 + var_536_2 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_6 + var_536_2
					end
				end

				arg_533_1.text_.text = var_536_4
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_7 = math.max(var_536_3, arg_533_1.talkMaxDuration)

			if var_536_2 <= arg_533_1.time_ and arg_533_1.time_ < var_536_2 + var_536_7 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_2) / var_536_7

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_2 + var_536_7 and arg_533_1.time_ < var_536_2 + var_536_7 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play1103905130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1103905130
		arg_537_1.duration_ = 5.27

		local var_537_0 = {
			zh = 5.1,
			ja = 5.266
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1103905131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(arg_537_1.actors_["1039ui_story"]) and arg_537_1.var_.characterEffect1039ui_story == nil then
				arg_537_1.var_.characterEffect1039ui_story = arg_537_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_0 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 and not isNil(arg_537_1.actors_["1039ui_story"]) then
				if arg_537_1.var_.characterEffect1039ui_story and not isNil(arg_537_1.actors_["1039ui_story"]) then
					arg_537_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 and not isNil(arg_537_1.actors_["1039ui_story"]) and arg_537_1.var_.characterEffect1039ui_story then
				arg_537_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_540_2 = 0
			local var_540_3 = 0.425

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_2 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_4 = arg_537_1:GetWordFromCfg(1103905130)
				local var_540_5 = arg_537_1:FormatText(var_540_4.content)

				arg_537_1.text_.text = var_540_5

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_7 = 17 <= 0 and var_540_3 or var_540_3 * (utf8.len(var_540_5) / 17)

				if (17 <= 0 and var_540_3 or var_540_3 * (utf8.len(var_540_5) / 17)) > 0 and var_540_3 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_2
					end
				end

				arg_537_1.text_.text = var_540_5
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905130", "story_v_side_new_1103905.awb") ~= 0 then
					local var_540_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905130", "story_v_side_new_1103905.awb") / 1000

					if var_540_8 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_8 + var_540_2
					end

					if var_540_4.prefab_name ~= "" and arg_537_1.actors_[var_540_4.prefab_name] ~= nil then
						local var_540_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_4.prefab_name].transform, "story_v_side_new_1103905", "1103905130", "story_v_side_new_1103905.awb")

						arg_537_1:RecordAudio("1103905130", var_540_9)
						arg_537_1:RecordAudio("1103905130", var_540_9)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905130", "story_v_side_new_1103905.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905130", "story_v_side_new_1103905.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_10 = math.max(var_540_3, arg_537_1.talkMaxDuration)

			if var_540_2 <= arg_537_1.time_ and arg_537_1.time_ < var_540_2 + var_540_10 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_2) / var_540_10

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_2 + var_540_10 and arg_537_1.time_ < var_540_2 + var_540_10 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1103905131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1103905131
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1103905132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["1039ui_story"]) and arg_541_1.var_.characterEffect1039ui_story == nil then
				arg_541_1.var_.characterEffect1039ui_story = arg_541_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_0 = 0.200000002980232

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["1039ui_story"]) then
				if arg_541_1.var_.characterEffect1039ui_story and not isNil(arg_541_1.actors_["1039ui_story"]) then
					arg_541_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_541_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_541_1.time_ - 0) / var_544_0)
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["1039ui_story"]) and arg_541_1.var_.characterEffect1039ui_story then
				arg_541_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_541_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_544_1 = 0
			local var_544_2 = 0.475

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_3 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(1103905131).content)

				arg_541_1.text_.text = var_544_3

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 19 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 19)

				if (19 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 19)) > 0 and var_544_2 < var_544_5 then
					arg_541_1.talkMaxDuration = var_544_5

					if var_544_5 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + var_544_1
					end
				end

				arg_541_1.text_.text = var_544_3
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_6 = math.max(var_544_2, arg_541_1.talkMaxDuration)

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_6 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_1) / var_544_6

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_1 + var_544_6 and arg_541_1.time_ < var_544_1 + var_544_6 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1103905132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1103905132
		arg_545_1.duration_ = 9

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1103905133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 2 < arg_545_1.time_ and arg_545_1.time_ <= 2 + arg_548_0 then
				local var_548_0 = arg_545_1.bgs_.ST01

				arg_545_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_548_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_548_1 = var_548_0:GetComponent("SpriteRenderer")

				if var_548_1 and var_548_1.sprite then
					local var_548_2 = 2 * (var_548_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_548_0.transform.localScale = Vector3.New(var_548_2 / var_548_1.sprite.bounds.size.y < var_548_2 * manager.ui.mainCameraCom_.aspect / var_548_1.sprite.bounds.size.x and var_548_2 * manager.ui.mainCameraCom_.aspect / var_548_1.sprite.bounds.size.x or var_548_2 / var_548_1.sprite.bounds.size.y, var_548_2 / var_548_1.sprite.bounds.size.y < var_548_2 * manager.ui.mainCameraCom_.aspect / var_548_1.sprite.bounds.size.x and var_548_2 * manager.ui.mainCameraCom_.aspect / var_548_1.sprite.bounds.size.x or var_548_2 / var_548_1.sprite.bounds.size.y, 0)
				end

				for iter_548_0, iter_548_1 in pairs(arg_545_1.bgs_) do
					if iter_548_0 ~= "ST01" then
						iter_548_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_548_3 = 0

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_3 + arg_548_0 then
				arg_545_1.mask_.enabled = true
				arg_545_1.mask_.raycastTarget = true

				arg_545_1:SetGaussion(false)
			end

			local var_548_4 = 2

			if var_548_3 <= arg_545_1.time_ and arg_545_1.time_ < var_548_3 + var_548_4 then
				local var_548_5 = Color.New(0, 0, 0)

				var_548_5.a = Mathf.Lerp(0, 1, (arg_545_1.time_ - var_548_3) / var_548_4)
				arg_545_1.mask_.color = var_548_5
			end

			if arg_545_1.time_ >= var_548_3 + var_548_4 and arg_545_1.time_ < var_548_3 + var_548_4 + arg_548_0 then
				local var_548_6 = Color.New(0, 0, 0)

				var_548_6.a = 1
				arg_545_1.mask_.color = var_548_6
			end

			local var_548_7 = 2

			if 2 < arg_545_1.time_ and arg_545_1.time_ <= var_548_7 + arg_548_0 then
				arg_545_1.mask_.enabled = true
				arg_545_1.mask_.raycastTarget = true

				arg_545_1:SetGaussion(false)
			end

			local var_548_8 = 2

			if var_548_7 <= arg_545_1.time_ and arg_545_1.time_ < var_548_7 + var_548_8 then
				local var_548_9 = Color.New(0, 0, 0)

				var_548_9.a = Mathf.Lerp(1, 0, (arg_545_1.time_ - var_548_7) / var_548_8)
				arg_545_1.mask_.color = var_548_9
			end

			if arg_545_1.time_ >= var_548_7 + var_548_8 and arg_545_1.time_ < var_548_7 + var_548_8 + arg_548_0 then
				local var_548_10 = Color.New(0, 0, 0)

				arg_545_1.mask_.enabled = false
				var_548_10.a = 0
				arg_545_1.mask_.color = var_548_10
			end

			local var_548_11 = arg_545_1.actors_["1039ui_story"].transform

			if 1.966 < arg_545_1.time_ and arg_545_1.time_ <= 1.966 + arg_548_0 then
				arg_545_1.var_.moveOldPos1039ui_story = var_548_11.localPosition
			end

			local var_548_12 = 0.001

			if 1.966 <= arg_545_1.time_ and arg_545_1.time_ < 1.966 + var_548_12 then
				var_548_11.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_545_1.time_ - 1.966) / var_548_12)
				var_548_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_548_11.position).x, (manager.ui.mainCamera.transform.position - var_548_11.position).y, (manager.ui.mainCamera.transform.position - var_548_11.position).z)
				var_548_11.localEulerAngles.z = 0
				var_548_11.localEulerAngles.x = 0
				var_548_11.localEulerAngles = var_548_11.localEulerAngles
			end

			if arg_545_1.time_ >= 1.966 + var_548_12 and arg_545_1.time_ < 1.966 + var_548_12 + arg_548_0 then
				var_548_11.localPosition = Vector3.New(0, 100, 0)
				var_548_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_548_11.position).x, (manager.ui.mainCamera.transform.position - var_548_11.position).y, (manager.ui.mainCamera.transform.position - var_548_11.position).z)
				var_548_11.localEulerAngles.z = 0
				var_548_11.localEulerAngles.x = 0
				var_548_11.localEulerAngles = var_548_11.localEulerAngles
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_548_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_545_1.bgmTxt_.text ~= var_548_15 and arg_545_1.bgmTxt_.text ~= "" then
						if arg_545_1.bgmTxt2_.text ~= "" then
							arg_545_1.bgmTxt_.text = arg_545_1.bgmTxt2_.text
						end

						arg_545_1.bgmTxt2_.text = var_548_15

						arg_545_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_545_1.bgmTxt_.text = var_548_15
						arg_545_1.bgmTxt2_.text = var_548_15
					end

					if arg_545_1.bgmTimer then
						arg_545_1.bgmTimer:Stop()

						arg_545_1.bgmTimer = nil
					end

					if arg_545_1.settingData.show_music_name == 1 then
						arg_545_1.musicController:SetSelectedState("show")
						arg_545_1.musicAnimator_:Play("open", 0, 0)

						if arg_545_1.settingData.music_time ~= 0 then
							arg_545_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_545_1.settingData.music_time), function()
								if arg_545_1 == nil or isNil(arg_545_1.bgmTxt_) then
									return
								end

								arg_545_1.musicController:SetSelectedState("hide")
								arg_545_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_545_1.time_ and arg_545_1.time_ <= 1 + arg_548_0 then
				arg_545_1:AudioAction("play", "music", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_548_18 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if "" ~= "" then
					if arg_545_1.bgmTxt_.text ~= var_548_18 and arg_545_1.bgmTxt_.text ~= "" then
						if arg_545_1.bgmTxt2_.text ~= "" then
							arg_545_1.bgmTxt_.text = arg_545_1.bgmTxt2_.text
						end

						arg_545_1.bgmTxt2_.text = var_548_18

						arg_545_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_545_1.bgmTxt_.text = var_548_18
						arg_545_1.bgmTxt2_.text = var_548_18
					end

					if arg_545_1.bgmTimer then
						arg_545_1.bgmTimer:Stop()

						arg_545_1.bgmTimer = nil
					end

					if arg_545_1.settingData.show_music_name == 1 then
						arg_545_1.musicController:SetSelectedState("show")
						arg_545_1.musicAnimator_:Play("open", 0, 0)

						if arg_545_1.settingData.music_time ~= 0 then
							arg_545_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_545_1.settingData.music_time), function()
								if arg_545_1 == nil or isNil(arg_545_1.bgmTxt_) then
									return
								end

								arg_545_1.musicController:SetSelectedState("hide")
								arg_545_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_545_1.frameCnt_ <= 1 then
				arg_545_1.dialog_:SetActive(false)
			end

			local var_548_19 = 4
			local var_548_20 = 0.95

			if 4 < arg_545_1.time_ and arg_545_1.time_ <= var_548_19 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0

				arg_545_1.dialog_:SetActive(true)

				arg_545_1.dialogCg_.alpha = 0

				local var_548_21 = LeanTween.value(arg_545_1.dialog_, 0, 1, 0.3)

				var_548_21:setOnUpdate(LuaHelper.FloatAction(function(arg_551_0)
					arg_545_1.dialogCg_.alpha = arg_551_0
				end))
				var_548_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_545_1.dialog_)
					var_548_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_545_1.duration_ = arg_545_1.duration_ + 0.3

				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_22 = arg_545_1:FormatText(arg_545_1:GetWordFromCfg(1103905132).content)

				arg_545_1.text_.text = var_548_22

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_24 = 38 <= 0 and var_548_20 or var_548_20 * (utf8.len(var_548_22) / 38)

				if (38 <= 0 and var_548_20 or var_548_20 * (utf8.len(var_548_22) / 38)) > 0 and var_548_20 < var_548_24 then
					arg_545_1.talkMaxDuration = var_548_24
					var_548_19 = var_548_19 + 0.3

					if var_548_24 + var_548_19 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_24 + var_548_19
					end
				end

				arg_545_1.text_.text = var_548_22
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_25 = var_548_19 + 0.3
			local var_548_26 = math.max(var_548_20, arg_545_1.talkMaxDuration)

			if var_548_19 + 0.3 <= arg_545_1.time_ and arg_545_1.time_ < var_548_25 + var_548_26 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_25) / var_548_26

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_25 + var_548_26 and arg_545_1.time_ < var_548_25 + var_548_26 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play1103905133 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1103905133
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1103905134(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0.525

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_1 = arg_553_1:FormatText(arg_553_1:GetWordFromCfg(1103905133).content)

				arg_553_1.text_.text = var_556_1

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_3 = 21 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 21)

				if (21 <= 0 and var_556_0 or var_556_0 * (utf8.len(var_556_1) / 21)) > 0 and var_556_0 < var_556_3 then
					arg_553_1.talkMaxDuration = var_556_3

					if var_556_3 + 0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_3 + 0
					end
				end

				arg_553_1.text_.text = var_556_1
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_4 = math.max(var_556_0, arg_553_1.talkMaxDuration)

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_4 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - 0) / var_556_4

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= 0 + var_556_4 and arg_553_1.time_ < 0 + var_556_4 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1103905134 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1103905134
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1103905135(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.325

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_1 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(1103905134).content)

				arg_557_1.text_.text = var_560_1

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_3 = 13 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_1) / 13)

				if (13 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_1) / 13)) > 0 and var_560_0 < var_560_3 then
					arg_557_1.talkMaxDuration = var_560_3

					if var_560_3 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_3 + 0
					end
				end

				arg_557_1.text_.text = var_560_1
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_4 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_4 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_4

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_4 and arg_557_1.time_ < 0 + var_560_4 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1103905135 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1103905135
		arg_561_1.duration_ = 7.93

		local var_561_0 = {
			zh = 3.966,
			ja = 7.933
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1103905136(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos1039ui_story = arg_561_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_564_0 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 then
				arg_561_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_561_1.time_ - 0) / var_564_0)
				arg_561_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1039ui_story"].transform.position).z)
				arg_561_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1039ui_story"].transform.localEulerAngles = arg_561_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 then
				arg_561_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_561_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1039ui_story"].transform.position).z)
				arg_561_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1039ui_story"].transform.localEulerAngles = arg_561_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_564_1 = arg_561_1.actors_["1039ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1039ui_story == nil then
				arg_561_1.var_.characterEffect1039ui_story = var_564_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_2 and not isNil(var_564_1) then
				if arg_561_1.var_.characterEffect1039ui_story and not isNil(var_564_1) then
					arg_561_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_2 and arg_561_1.time_ < 0 + var_564_2 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1039ui_story then
				arg_561_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_564_4 = 0
			local var_564_5 = 0.35

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_6 = arg_561_1:GetWordFromCfg(1103905135)
				local var_564_7 = arg_561_1:FormatText(var_564_6.content)

				arg_561_1.text_.text = var_564_7

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_9 = 14 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 14)

				if (14 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 14)) > 0 and var_564_5 < var_564_9 then
					arg_561_1.talkMaxDuration = var_564_9

					if var_564_9 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_9 + var_564_4
					end
				end

				arg_561_1.text_.text = var_564_7
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905135", "story_v_side_new_1103905.awb") ~= 0 then
					local var_564_10 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905135", "story_v_side_new_1103905.awb") / 1000

					if var_564_10 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_10 + var_564_4
					end

					if var_564_6.prefab_name ~= "" and arg_561_1.actors_[var_564_6.prefab_name] ~= nil then
						local var_564_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_6.prefab_name].transform, "story_v_side_new_1103905", "1103905135", "story_v_side_new_1103905.awb")

						arg_561_1:RecordAudio("1103905135", var_564_11)
						arg_561_1:RecordAudio("1103905135", var_564_11)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905135", "story_v_side_new_1103905.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905135", "story_v_side_new_1103905.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_12 = math.max(var_564_5, arg_561_1.talkMaxDuration)

			if var_564_4 <= arg_561_1.time_ and arg_561_1.time_ < var_564_4 + var_564_12 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_4) / var_564_12

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_4 + var_564_12 and arg_561_1.time_ < var_564_4 + var_564_12 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play1103905136 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1103905136
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1103905137(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1039ui_story"]) and arg_565_1.var_.characterEffect1039ui_story == nil then
				arg_565_1.var_.characterEffect1039ui_story = arg_565_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1039ui_story"]) then
				if arg_565_1.var_.characterEffect1039ui_story and not isNil(arg_565_1.actors_["1039ui_story"]) then
					arg_565_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 0) / var_568_0)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1039ui_story"]) and arg_565_1.var_.characterEffect1039ui_story then
				arg_565_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_568_1 = 0
			local var_568_2 = 0.425

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_3 = arg_565_1:FormatText(arg_565_1:GetWordFromCfg(1103905136).content)

				arg_565_1.text_.text = var_568_3

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_5 = 17 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 17)

				if (17 <= 0 and var_568_2 or var_568_2 * (utf8.len(var_568_3) / 17)) > 0 and var_568_2 < var_568_5 then
					arg_565_1.talkMaxDuration = var_568_5

					if var_568_5 + var_568_1 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_5 + var_568_1
					end
				end

				arg_565_1.text_.text = var_568_3
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_6 = math.max(var_568_2, arg_565_1.talkMaxDuration)

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_6 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_1) / var_568_6

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_1 + var_568_6 and arg_565_1.time_ < var_568_1 + var_568_6 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1103905137 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1103905137
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1103905138(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0.825

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_1 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(1103905137).content)

				arg_569_1.text_.text = var_572_1

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_3 = 33 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_1) / 33)

				if (33 <= 0 and var_572_0 or var_572_0 * (utf8.len(var_572_1) / 33)) > 0 and var_572_0 < var_572_3 then
					arg_569_1.talkMaxDuration = var_572_3

					if var_572_3 + 0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_3 + 0
					end
				end

				arg_569_1.text_.text = var_572_1
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_4 = math.max(var_572_0, arg_569_1.talkMaxDuration)

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_4 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - 0) / var_572_4

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= 0 + var_572_4 and arg_569_1.time_ < 0 + var_572_4 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1103905138 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1103905138
		arg_573_1.duration_ = 6.67

		local var_573_0 = {
			zh = 2.233,
			ja = 6.666
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1103905139(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 and not isNil(arg_573_1.actors_["1039ui_story"]) and arg_573_1.var_.characterEffect1039ui_story == nil then
				arg_573_1.var_.characterEffect1039ui_story = arg_573_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_0 = 0.200000002980232

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_0 and not isNil(arg_573_1.actors_["1039ui_story"]) then
				if arg_573_1.var_.characterEffect1039ui_story and not isNil(arg_573_1.actors_["1039ui_story"]) then
					arg_573_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= 0 + var_576_0 and arg_573_1.time_ < 0 + var_576_0 + arg_576_0 and not isNil(arg_573_1.actors_["1039ui_story"]) and arg_573_1.var_.characterEffect1039ui_story then
				arg_573_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_576_2 = 0
			local var_576_3 = 0.3

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_2 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_4 = arg_573_1:GetWordFromCfg(1103905138)
				local var_576_5 = arg_573_1:FormatText(var_576_4.content)

				arg_573_1.text_.text = var_576_5

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_7 = 12 <= 0 and var_576_3 or var_576_3 * (utf8.len(var_576_5) / 12)

				if (12 <= 0 and var_576_3 or var_576_3 * (utf8.len(var_576_5) / 12)) > 0 and var_576_3 < var_576_7 then
					arg_573_1.talkMaxDuration = var_576_7

					if var_576_7 + var_576_2 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_2
					end
				end

				arg_573_1.text_.text = var_576_5
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905138", "story_v_side_new_1103905.awb") ~= 0 then
					local var_576_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905138", "story_v_side_new_1103905.awb") / 1000

					if var_576_8 + var_576_2 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_8 + var_576_2
					end

					if var_576_4.prefab_name ~= "" and arg_573_1.actors_[var_576_4.prefab_name] ~= nil then
						local var_576_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_4.prefab_name].transform, "story_v_side_new_1103905", "1103905138", "story_v_side_new_1103905.awb")

						arg_573_1:RecordAudio("1103905138", var_576_9)
						arg_573_1:RecordAudio("1103905138", var_576_9)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905138", "story_v_side_new_1103905.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905138", "story_v_side_new_1103905.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_10 = math.max(var_576_3, arg_573_1.talkMaxDuration)

			if var_576_2 <= arg_573_1.time_ and arg_573_1.time_ < var_576_2 + var_576_10 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_2) / var_576_10

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_2 + var_576_10 and arg_573_1.time_ < var_576_2 + var_576_10 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1103905139 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1103905139
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1103905140(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 and not isNil(arg_577_1.actors_["1039ui_story"]) and arg_577_1.var_.characterEffect1039ui_story == nil then
				arg_577_1.var_.characterEffect1039ui_story = arg_577_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_0 = 0.200000002980232

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 and not isNil(arg_577_1.actors_["1039ui_story"]) then
				if arg_577_1.var_.characterEffect1039ui_story and not isNil(arg_577_1.actors_["1039ui_story"]) then
					arg_577_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_577_1.time_ - 0) / var_580_0)
				end
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 and not isNil(arg_577_1.actors_["1039ui_story"]) and arg_577_1.var_.characterEffect1039ui_story then
				arg_577_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_580_1 = 0
			local var_580_2 = 0.4

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				arg_577_1.leftNameTxt_.text = arg_577_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_3 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(1103905139).content)

				arg_577_1.text_.text = var_580_3

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_5 = 16 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 16)

				if (16 <= 0 and var_580_2 or var_580_2 * (utf8.len(var_580_3) / 16)) > 0 and var_580_2 < var_580_5 then
					arg_577_1.talkMaxDuration = var_580_5

					if var_580_5 + var_580_1 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_5 + var_580_1
					end
				end

				arg_577_1.text_.text = var_580_3
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_6 = math.max(var_580_2, arg_577_1.talkMaxDuration)

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_6 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_1) / var_580_6

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_1 + var_580_6 and arg_577_1.time_ < var_580_1 + var_580_6 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1103905140 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1103905140
		arg_581_1.duration_ = 4.63

		local var_581_0 = {
			zh = 3.166,
			ja = 4.633
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1103905141(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(arg_581_1.actors_["1039ui_story"]) and arg_581_1.var_.characterEffect1039ui_story == nil then
				arg_581_1.var_.characterEffect1039ui_story = arg_581_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_0 = 0.200000002980232

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 and not isNil(arg_581_1.actors_["1039ui_story"]) then
				if arg_581_1.var_.characterEffect1039ui_story and not isNil(arg_581_1.actors_["1039ui_story"]) then
					arg_581_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 and not isNil(arg_581_1.actors_["1039ui_story"]) and arg_581_1.var_.characterEffect1039ui_story then
				arg_581_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action465")
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_584_2 = 0
			local var_584_3 = 0.175

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_2 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_4 = arg_581_1:GetWordFromCfg(1103905140)
				local var_584_5 = arg_581_1:FormatText(var_584_4.content)

				arg_581_1.text_.text = var_584_5

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_7 = 7 <= 0 and var_584_3 or var_584_3 * (utf8.len(var_584_5) / 7)

				if (7 <= 0 and var_584_3 or var_584_3 * (utf8.len(var_584_5) / 7)) > 0 and var_584_3 < var_584_7 then
					arg_581_1.talkMaxDuration = var_584_7

					if var_584_7 + var_584_2 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_7 + var_584_2
					end
				end

				arg_581_1.text_.text = var_584_5
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905140", "story_v_side_new_1103905.awb") ~= 0 then
					local var_584_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905140", "story_v_side_new_1103905.awb") / 1000

					if var_584_8 + var_584_2 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_8 + var_584_2
					end

					if var_584_4.prefab_name ~= "" and arg_581_1.actors_[var_584_4.prefab_name] ~= nil then
						local var_584_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_4.prefab_name].transform, "story_v_side_new_1103905", "1103905140", "story_v_side_new_1103905.awb")

						arg_581_1:RecordAudio("1103905140", var_584_9)
						arg_581_1:RecordAudio("1103905140", var_584_9)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905140", "story_v_side_new_1103905.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905140", "story_v_side_new_1103905.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_10 = math.max(var_584_3, arg_581_1.talkMaxDuration)

			if var_584_2 <= arg_581_1.time_ and arg_581_1.time_ < var_584_2 + var_584_10 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_2) / var_584_10

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_2 + var_584_10 and arg_581_1.time_ < var_584_2 + var_584_10 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1103905141 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1103905141
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1103905142(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(arg_585_1.actors_["1039ui_story"]) and arg_585_1.var_.characterEffect1039ui_story == nil then
				arg_585_1.var_.characterEffect1039ui_story = arg_585_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_0 = 0.200000002980232

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 and not isNil(arg_585_1.actors_["1039ui_story"]) then
				if arg_585_1.var_.characterEffect1039ui_story and not isNil(arg_585_1.actors_["1039ui_story"]) then
					arg_585_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_585_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_585_1.time_ - 0) / var_588_0)
				end
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 and not isNil(arg_585_1.actors_["1039ui_story"]) and arg_585_1.var_.characterEffect1039ui_story then
				arg_585_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_585_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_588_1 = 0
			local var_588_2 = 0.575

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_3 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(1103905141).content)

				arg_585_1.text_.text = var_588_3

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_5 = 23 <= 0 and var_588_2 or var_588_2 * (utf8.len(var_588_3) / 23)

				if (23 <= 0 and var_588_2 or var_588_2 * (utf8.len(var_588_3) / 23)) > 0 and var_588_2 < var_588_5 then
					arg_585_1.talkMaxDuration = var_588_5

					if var_588_5 + var_588_1 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_5 + var_588_1
					end
				end

				arg_585_1.text_.text = var_588_3
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_6 = math.max(var_588_2, arg_585_1.talkMaxDuration)

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_6 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_1) / var_588_6

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_1 + var_588_6 and arg_585_1.time_ < var_588_1 + var_588_6 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1103905142 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1103905142
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1103905143(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.575

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_1 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(1103905142).content)

				arg_589_1.text_.text = var_592_1

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_3 = 23 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 23)

				if (23 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 23)) > 0 and var_592_0 < var_592_3 then
					arg_589_1.talkMaxDuration = var_592_3

					if var_592_3 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_3 + 0
					end
				end

				arg_589_1.text_.text = var_592_1
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_4 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_4

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1103905143 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1103905143
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1103905144(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 1.35

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_1 = arg_593_1:FormatText(arg_593_1:GetWordFromCfg(1103905143).content)

				arg_593_1.text_.text = var_596_1

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_3 = 54 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 54)

				if (54 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_1) / 54)) > 0 and var_596_0 < var_596_3 then
					arg_593_1.talkMaxDuration = var_596_3

					if var_596_3 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_3 + 0
					end
				end

				arg_593_1.text_.text = var_596_1
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_4 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_4 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_4

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_4 and arg_593_1.time_ < 0 + var_596_4 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1103905144 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1103905144
		arg_597_1.duration_ = 12.8

		local var_597_0 = {
			zh = 9.666,
			ja = 12.8
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1103905145(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["1039ui_story"]) and arg_597_1.var_.characterEffect1039ui_story == nil then
				arg_597_1.var_.characterEffect1039ui_story = arg_597_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_0 = 0.200000002980232

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["1039ui_story"]) then
				if arg_597_1.var_.characterEffect1039ui_story and not isNil(arg_597_1.actors_["1039ui_story"]) then
					arg_597_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["1039ui_story"]) and arg_597_1.var_.characterEffect1039ui_story then
				arg_597_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_600_2 = 0
			local var_600_3 = 1.1

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_2 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_4 = arg_597_1:GetWordFromCfg(1103905144)
				local var_600_5 = arg_597_1:FormatText(var_600_4.content)

				arg_597_1.text_.text = var_600_5

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_7 = 44 <= 0 and var_600_3 or var_600_3 * (utf8.len(var_600_5) / 44)

				if (44 <= 0 and var_600_3 or var_600_3 * (utf8.len(var_600_5) / 44)) > 0 and var_600_3 < var_600_7 then
					arg_597_1.talkMaxDuration = var_600_7

					if var_600_7 + var_600_2 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_7 + var_600_2
					end
				end

				arg_597_1.text_.text = var_600_5
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905144", "story_v_side_new_1103905.awb") ~= 0 then
					local var_600_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905144", "story_v_side_new_1103905.awb") / 1000

					if var_600_8 + var_600_2 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_8 + var_600_2
					end

					if var_600_4.prefab_name ~= "" and arg_597_1.actors_[var_600_4.prefab_name] ~= nil then
						local var_600_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_4.prefab_name].transform, "story_v_side_new_1103905", "1103905144", "story_v_side_new_1103905.awb")

						arg_597_1:RecordAudio("1103905144", var_600_9)
						arg_597_1:RecordAudio("1103905144", var_600_9)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905144", "story_v_side_new_1103905.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905144", "story_v_side_new_1103905.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_10 = math.max(var_600_3, arg_597_1.talkMaxDuration)

			if var_600_2 <= arg_597_1.time_ and arg_597_1.time_ < var_600_2 + var_600_10 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_2) / var_600_10

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_2 + var_600_10 and arg_597_1.time_ < var_600_2 + var_600_10 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1103905145 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1103905145
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1103905146(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(arg_601_1.actors_["1039ui_story"]) and arg_601_1.var_.characterEffect1039ui_story == nil then
				arg_601_1.var_.characterEffect1039ui_story = arg_601_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_0 = 0.200000002980232

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 and not isNil(arg_601_1.actors_["1039ui_story"]) then
				if arg_601_1.var_.characterEffect1039ui_story and not isNil(arg_601_1.actors_["1039ui_story"]) then
					arg_601_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_601_1.time_ - 0) / var_604_0)
				end
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 and not isNil(arg_601_1.actors_["1039ui_story"]) and arg_601_1.var_.characterEffect1039ui_story then
				arg_601_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_604_1 = 0
			local var_604_2 = 0.425

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_3 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(1103905145).content)

				arg_601_1.text_.text = var_604_3

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 17 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_3) / 17)

				if (17 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_3) / 17)) > 0 and var_604_2 < var_604_5 then
					arg_601_1.talkMaxDuration = var_604_5

					if var_604_5 + var_604_1 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_5 + var_604_1
					end
				end

				arg_601_1.text_.text = var_604_3
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_6 = math.max(var_604_2, arg_601_1.talkMaxDuration)

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_6 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_1) / var_604_6

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_1 + var_604_6 and arg_601_1.time_ < var_604_1 + var_604_6 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play1103905146 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1103905146
		arg_605_1.duration_ = 4.47

		local var_605_0 = {
			zh = 3.733,
			ja = 4.466
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1103905147(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 and not isNil(arg_605_1.actors_["1039ui_story"]) and arg_605_1.var_.characterEffect1039ui_story == nil then
				arg_605_1.var_.characterEffect1039ui_story = arg_605_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_0 = 0.2

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_0 and not isNil(arg_605_1.actors_["1039ui_story"]) then
				if arg_605_1.var_.characterEffect1039ui_story and not isNil(arg_605_1.actors_["1039ui_story"]) then
					arg_605_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= 0 + var_608_0 and arg_605_1.time_ < 0 + var_608_0 + arg_608_0 and not isNil(arg_605_1.actors_["1039ui_story"]) and arg_605_1.var_.characterEffect1039ui_story then
				arg_605_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_608_2 = 0
			local var_608_3 = 0.4

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_2 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_4 = arg_605_1:GetWordFromCfg(1103905146)
				local var_608_5 = arg_605_1:FormatText(var_608_4.content)

				arg_605_1.text_.text = var_608_5

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_7 = 16 <= 0 and var_608_3 or var_608_3 * (utf8.len(var_608_5) / 16)

				if (16 <= 0 and var_608_3 or var_608_3 * (utf8.len(var_608_5) / 16)) > 0 and var_608_3 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_2 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_2
					end
				end

				arg_605_1.text_.text = var_608_5
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905146", "story_v_side_new_1103905.awb") ~= 0 then
					local var_608_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905146", "story_v_side_new_1103905.awb") / 1000

					if var_608_8 + var_608_2 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_8 + var_608_2
					end

					if var_608_4.prefab_name ~= "" and arg_605_1.actors_[var_608_4.prefab_name] ~= nil then
						local var_608_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_4.prefab_name].transform, "story_v_side_new_1103905", "1103905146", "story_v_side_new_1103905.awb")

						arg_605_1:RecordAudio("1103905146", var_608_9)
						arg_605_1:RecordAudio("1103905146", var_608_9)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905146", "story_v_side_new_1103905.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905146", "story_v_side_new_1103905.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_10 = math.max(var_608_3, arg_605_1.talkMaxDuration)

			if var_608_2 <= arg_605_1.time_ and arg_605_1.time_ < var_608_2 + var_608_10 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_2) / var_608_10

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_2 + var_608_10 and arg_605_1.time_ < var_608_2 + var_608_10 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1103905147 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1103905147
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1103905148(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_612_0 = arg_609_1.actors_["1039ui_story"]

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect1039ui_story == nil then
				arg_609_1.var_.characterEffect1039ui_story = var_612_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_1 = 0.2

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_1 and not isNil(var_612_0) then
				if arg_609_1.var_.characterEffect1039ui_story and not isNil(var_612_0) then
					arg_609_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_609_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_609_1.time_ - 0) / var_612_1)
				end
			end

			if arg_609_1.time_ >= 0 + var_612_1 and arg_609_1.time_ < 0 + var_612_1 + arg_612_0 and not isNil(var_612_0) and arg_609_1.var_.characterEffect1039ui_story then
				arg_609_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_609_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_612_2 = 0
			local var_612_3 = 0.95

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_2 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_4 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(1103905147).content)

				arg_609_1.text_.text = var_612_4

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_6 = 38 <= 0 and var_612_3 or var_612_3 * (utf8.len(var_612_4) / 38)

				if (38 <= 0 and var_612_3 or var_612_3 * (utf8.len(var_612_4) / 38)) > 0 and var_612_3 < var_612_6 then
					arg_609_1.talkMaxDuration = var_612_6

					if var_612_6 + var_612_2 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_6 + var_612_2
					end
				end

				arg_609_1.text_.text = var_612_4
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_7 = math.max(var_612_3, arg_609_1.talkMaxDuration)

			if var_612_2 <= arg_609_1.time_ and arg_609_1.time_ < var_612_2 + var_612_7 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_2) / var_612_7

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_2 + var_612_7 and arg_609_1.time_ < var_612_2 + var_612_7 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1103905148 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1103905148
		arg_613_1.duration_ = 5.7

		local var_613_0 = {
			zh = 5.7,
			ja = 4.566
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1103905149(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(arg_613_1.actors_["1039ui_story"]) and arg_613_1.var_.characterEffect1039ui_story == nil then
				arg_613_1.var_.characterEffect1039ui_story = arg_613_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_0 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_0 and not isNil(arg_613_1.actors_["1039ui_story"]) then
				if arg_613_1.var_.characterEffect1039ui_story and not isNil(arg_613_1.actors_["1039ui_story"]) then
					arg_613_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_613_1.time_ >= 0 + var_616_0 and arg_613_1.time_ < 0 + var_616_0 + arg_616_0 and not isNil(arg_613_1.actors_["1039ui_story"]) and arg_613_1.var_.characterEffect1039ui_story then
				arg_613_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_616_2 = 0
			local var_616_3 = 0.3

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_2 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_4 = arg_613_1:GetWordFromCfg(1103905148)
				local var_616_5 = arg_613_1:FormatText(var_616_4.content)

				arg_613_1.text_.text = var_616_5

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_7 = 12 <= 0 and var_616_3 or var_616_3 * (utf8.len(var_616_5) / 12)

				if (12 <= 0 and var_616_3 or var_616_3 * (utf8.len(var_616_5) / 12)) > 0 and var_616_3 < var_616_7 then
					arg_613_1.talkMaxDuration = var_616_7

					if var_616_7 + var_616_2 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_7 + var_616_2
					end
				end

				arg_613_1.text_.text = var_616_5
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905148", "story_v_side_new_1103905.awb") ~= 0 then
					local var_616_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905148", "story_v_side_new_1103905.awb") / 1000

					if var_616_8 + var_616_2 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_8 + var_616_2
					end

					if var_616_4.prefab_name ~= "" and arg_613_1.actors_[var_616_4.prefab_name] ~= nil then
						local var_616_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_4.prefab_name].transform, "story_v_side_new_1103905", "1103905148", "story_v_side_new_1103905.awb")

						arg_613_1:RecordAudio("1103905148", var_616_9)
						arg_613_1:RecordAudio("1103905148", var_616_9)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905148", "story_v_side_new_1103905.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905148", "story_v_side_new_1103905.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_10 = math.max(var_616_3, arg_613_1.talkMaxDuration)

			if var_616_2 <= arg_613_1.time_ and arg_613_1.time_ < var_616_2 + var_616_10 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_2) / var_616_10

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_2 + var_616_10 and arg_613_1.time_ < var_616_2 + var_616_10 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1103905149 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1103905149
		arg_617_1.duration_ = 22.4

		local var_617_0 = {
			zh = 18,
			ja = 22.4
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1103905150(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 1.85

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_1 = arg_617_1:GetWordFromCfg(1103905149)
				local var_620_2 = arg_617_1:FormatText(var_620_1.content)

				arg_617_1.text_.text = var_620_2

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_4 = 74 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_2) / 74)

				if (74 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_2) / 74)) > 0 and var_620_0 < var_620_4 then
					arg_617_1.talkMaxDuration = var_620_4

					if var_620_4 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_4 + 0
					end
				end

				arg_617_1.text_.text = var_620_2
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905149", "story_v_side_new_1103905.awb") ~= 0 then
					local var_620_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905149", "story_v_side_new_1103905.awb") / 1000

					if var_620_5 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + 0
					end

					if var_620_1.prefab_name ~= "" and arg_617_1.actors_[var_620_1.prefab_name] ~= nil then
						local var_620_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_1.prefab_name].transform, "story_v_side_new_1103905", "1103905149", "story_v_side_new_1103905.awb")

						arg_617_1:RecordAudio("1103905149", var_620_6)
						arg_617_1:RecordAudio("1103905149", var_620_6)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905149", "story_v_side_new_1103905.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905149", "story_v_side_new_1103905.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_7 = math.max(var_620_0, arg_617_1.talkMaxDuration)

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_7 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - 0) / var_620_7

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= 0 + var_620_7 and arg_617_1.time_ < 0 + var_620_7 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1103905150 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1103905150
		arg_621_1.duration_ = 9.2

		local var_621_0 = {
			zh = 6.5,
			ja = 9.2
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
				arg_621_0:Play1103905151(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0.625

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_1 = arg_621_1:GetWordFromCfg(1103905150)
				local var_624_2 = arg_621_1:FormatText(var_624_1.content)

				arg_621_1.text_.text = var_624_2

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_4 = 25 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 25)

				if (25 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 25)) > 0 and var_624_0 < var_624_4 then
					arg_621_1.talkMaxDuration = var_624_4

					if var_624_4 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_4 + 0
					end
				end

				arg_621_1.text_.text = var_624_2
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905150", "story_v_side_new_1103905.awb") ~= 0 then
					local var_624_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905150", "story_v_side_new_1103905.awb") / 1000

					if var_624_5 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + 0
					end

					if var_624_1.prefab_name ~= "" and arg_621_1.actors_[var_624_1.prefab_name] ~= nil then
						local var_624_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_1.prefab_name].transform, "story_v_side_new_1103905", "1103905150", "story_v_side_new_1103905.awb")

						arg_621_1:RecordAudio("1103905150", var_624_6)
						arg_621_1:RecordAudio("1103905150", var_624_6)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905150", "story_v_side_new_1103905.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905150", "story_v_side_new_1103905.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_7 = math.max(var_624_0, arg_621_1.talkMaxDuration)

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_7 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - 0) / var_624_7

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= 0 + var_624_7 and arg_621_1.time_ < 0 + var_624_7 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1103905151 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1103905151
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1103905152(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 and not isNil(arg_625_1.actors_["1039ui_story"]) and arg_625_1.var_.characterEffect1039ui_story == nil then
				arg_625_1.var_.characterEffect1039ui_story = arg_625_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_0 = 0.2

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_0 and not isNil(arg_625_1.actors_["1039ui_story"]) then
				if arg_625_1.var_.characterEffect1039ui_story and not isNil(arg_625_1.actors_["1039ui_story"]) then
					arg_625_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_625_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_625_1.time_ - 0) / var_628_0)
				end
			end

			if arg_625_1.time_ >= 0 + var_628_0 and arg_625_1.time_ < 0 + var_628_0 + arg_628_0 and not isNil(arg_625_1.actors_["1039ui_story"]) and arg_625_1.var_.characterEffect1039ui_story then
				arg_625_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_625_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_628_1 = 0
			local var_628_2 = 0.225

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

				local var_628_3 = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(1103905151).content)

				arg_625_1.text_.text = var_628_3

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_5 = 9 <= 0 and var_628_2 or var_628_2 * (utf8.len(var_628_3) / 9)

				if (9 <= 0 and var_628_2 or var_628_2 * (utf8.len(var_628_3) / 9)) > 0 and var_628_2 < var_628_5 then
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
	Play1103905152 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1103905152
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1103905153(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0.625

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

				local var_632_1 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(1103905152).content)

				arg_629_1.text_.text = var_632_1

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_3 = 25 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 25)

				if (25 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 25)) > 0 and var_632_0 < var_632_3 then
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
	Play1103905153 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1103905153
		arg_633_1.duration_ = 7.43

		local var_633_0 = {
			zh = 6,
			ja = 7.433
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
				arg_633_0:Play1103905154(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 and not isNil(arg_633_1.actors_["1039ui_story"]) and arg_633_1.var_.characterEffect1039ui_story == nil then
				arg_633_1.var_.characterEffect1039ui_story = arg_633_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_0 = 0.200000002980232

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_0 and not isNil(arg_633_1.actors_["1039ui_story"]) then
				if arg_633_1.var_.characterEffect1039ui_story and not isNil(arg_633_1.actors_["1039ui_story"]) then
					arg_633_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= 0 + var_636_0 and arg_633_1.time_ < 0 + var_636_0 + arg_636_0 and not isNil(arg_633_1.actors_["1039ui_story"]) and arg_633_1.var_.characterEffect1039ui_story then
				arg_633_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_636_2 = 0
			local var_636_3 = 0.575

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_2 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_4 = arg_633_1:GetWordFromCfg(1103905153)
				local var_636_5 = arg_633_1:FormatText(var_636_4.content)

				arg_633_1.text_.text = var_636_5

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_7 = 23 <= 0 and var_636_3 or var_636_3 * (utf8.len(var_636_5) / 23)

				if (23 <= 0 and var_636_3 or var_636_3 * (utf8.len(var_636_5) / 23)) > 0 and var_636_3 < var_636_7 then
					arg_633_1.talkMaxDuration = var_636_7

					if var_636_7 + var_636_2 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_7 + var_636_2
					end
				end

				arg_633_1.text_.text = var_636_5
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905153", "story_v_side_new_1103905.awb") ~= 0 then
					local var_636_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905153", "story_v_side_new_1103905.awb") / 1000

					if var_636_8 + var_636_2 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_8 + var_636_2
					end

					if var_636_4.prefab_name ~= "" and arg_633_1.actors_[var_636_4.prefab_name] ~= nil then
						local var_636_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_4.prefab_name].transform, "story_v_side_new_1103905", "1103905153", "story_v_side_new_1103905.awb")

						arg_633_1:RecordAudio("1103905153", var_636_9)
						arg_633_1:RecordAudio("1103905153", var_636_9)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905153", "story_v_side_new_1103905.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905153", "story_v_side_new_1103905.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_10 = math.max(var_636_3, arg_633_1.talkMaxDuration)

			if var_636_2 <= arg_633_1.time_ and arg_633_1.time_ < var_636_2 + var_636_10 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_2) / var_636_10

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_2 + var_636_10 and arg_633_1.time_ < var_636_2 + var_636_10 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {}

		arg_633_1:InitPlayNodeList()
	end,
	Play1103905154 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1103905154
		arg_637_1.duration_ = 7.13

		local var_637_0 = {
			zh = 4.5,
			ja = 7.133
		}
		local var_637_1 = manager.audio:GetLocalizationFlag()

		if var_637_0[var_637_1] ~= nil then
			arg_637_1.duration_ = var_637_0[var_637_1]
		end

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1103905155(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = 0.525

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, false)
				arg_637_1.callingController_:SetSelectedState("normal")

				local var_640_1 = arg_637_1:GetWordFromCfg(1103905154)
				local var_640_2 = arg_637_1:FormatText(var_640_1.content)

				arg_637_1.text_.text = var_640_2

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_4 = 21 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_2) / 21)

				if (21 <= 0 and var_640_0 or var_640_0 * (utf8.len(var_640_2) / 21)) > 0 and var_640_0 < var_640_4 then
					arg_637_1.talkMaxDuration = var_640_4

					if var_640_4 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_4 + 0
					end
				end

				arg_637_1.text_.text = var_640_2
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905154", "story_v_side_new_1103905.awb") ~= 0 then
					local var_640_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905154", "story_v_side_new_1103905.awb") / 1000

					if var_640_5 + 0 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_5 + 0
					end

					if var_640_1.prefab_name ~= "" and arg_637_1.actors_[var_640_1.prefab_name] ~= nil then
						local var_640_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_1.prefab_name].transform, "story_v_side_new_1103905", "1103905154", "story_v_side_new_1103905.awb")

						arg_637_1:RecordAudio("1103905154", var_640_6)
						arg_637_1:RecordAudio("1103905154", var_640_6)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905154", "story_v_side_new_1103905.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905154", "story_v_side_new_1103905.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_7 = math.max(var_640_0, arg_637_1.talkMaxDuration)

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_7 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - 0) / var_640_7

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= 0 + var_640_7 and arg_637_1.time_ < 0 + var_640_7 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1103905155 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1103905155
		arg_641_1.duration_ = 5

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1103905156(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 and not isNil(arg_641_1.actors_["1039ui_story"]) and arg_641_1.var_.characterEffect1039ui_story == nil then
				arg_641_1.var_.characterEffect1039ui_story = arg_641_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_0 = 0.2

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_0 and not isNil(arg_641_1.actors_["1039ui_story"]) then
				if arg_641_1.var_.characterEffect1039ui_story and not isNil(arg_641_1.actors_["1039ui_story"]) then
					arg_641_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_641_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_641_1.time_ - 0) / var_644_0)
				end
			end

			if arg_641_1.time_ >= 0 + var_644_0 and arg_641_1.time_ < 0 + var_644_0 + arg_644_0 and not isNil(arg_641_1.actors_["1039ui_story"]) and arg_641_1.var_.characterEffect1039ui_story then
				arg_641_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_641_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_644_1 = 0
			local var_644_2 = 0.35

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_1 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, true)
				arg_641_1.iconController_:SetSelectedState("hero")

				arg_641_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_641_1.callingController_:SetSelectedState("normal")

				arg_641_1.keyicon_.color = Color.New(1, 1, 1)
				arg_641_1.icon_.color = Color.New(1, 1, 1)

				local var_644_3 = arg_641_1:FormatText(arg_641_1:GetWordFromCfg(1103905155).content)

				arg_641_1.text_.text = var_644_3

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_5 = 14 <= 0 and var_644_2 or var_644_2 * (utf8.len(var_644_3) / 14)

				if (14 <= 0 and var_644_2 or var_644_2 * (utf8.len(var_644_3) / 14)) > 0 and var_644_2 < var_644_5 then
					arg_641_1.talkMaxDuration = var_644_5

					if var_644_5 + var_644_1 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_5 + var_644_1
					end
				end

				arg_641_1.text_.text = var_644_3
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)
				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_6 = math.max(var_644_2, arg_641_1.talkMaxDuration)

			if var_644_1 <= arg_641_1.time_ and arg_641_1.time_ < var_644_1 + var_644_6 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_1) / var_644_6

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_1 + var_644_6 and arg_641_1.time_ < var_644_1 + var_644_6 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1103905156 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1103905156
		arg_645_1.duration_ = 5.3

		local var_645_0 = {
			zh = 3.833,
			ja = 5.3
		}
		local var_645_1 = manager.audio:GetLocalizationFlag()

		if var_645_0[var_645_1] ~= nil then
			arg_645_1.duration_ = var_645_0[var_645_1]
		end

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1103905157(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 and not isNil(arg_645_1.actors_["1039ui_story"]) and arg_645_1.var_.characterEffect1039ui_story == nil then
				arg_645_1.var_.characterEffect1039ui_story = arg_645_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_0 = 0.200000002980232

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_0 and not isNil(arg_645_1.actors_["1039ui_story"]) then
				if arg_645_1.var_.characterEffect1039ui_story and not isNil(arg_645_1.actors_["1039ui_story"]) then
					arg_645_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_645_1.time_ >= 0 + var_648_0 and arg_645_1.time_ < 0 + var_648_0 + arg_648_0 and not isNil(arg_645_1.actors_["1039ui_story"]) and arg_645_1.var_.characterEffect1039ui_story then
				arg_645_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_648_2 = 0
			local var_648_3 = 0.45

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_2 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_4 = arg_645_1:GetWordFromCfg(1103905156)
				local var_648_5 = arg_645_1:FormatText(var_648_4.content)

				arg_645_1.text_.text = var_648_5

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_7 = 18 <= 0 and var_648_3 or var_648_3 * (utf8.len(var_648_5) / 18)

				if (18 <= 0 and var_648_3 or var_648_3 * (utf8.len(var_648_5) / 18)) > 0 and var_648_3 < var_648_7 then
					arg_645_1.talkMaxDuration = var_648_7

					if var_648_7 + var_648_2 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_7 + var_648_2
					end
				end

				arg_645_1.text_.text = var_648_5
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905156", "story_v_side_new_1103905.awb") ~= 0 then
					local var_648_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905156", "story_v_side_new_1103905.awb") / 1000

					if var_648_8 + var_648_2 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_8 + var_648_2
					end

					if var_648_4.prefab_name ~= "" and arg_645_1.actors_[var_648_4.prefab_name] ~= nil then
						local var_648_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_645_1.actors_[var_648_4.prefab_name].transform, "story_v_side_new_1103905", "1103905156", "story_v_side_new_1103905.awb")

						arg_645_1:RecordAudio("1103905156", var_648_9)
						arg_645_1:RecordAudio("1103905156", var_648_9)
					else
						arg_645_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905156", "story_v_side_new_1103905.awb")
					end

					arg_645_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905156", "story_v_side_new_1103905.awb")
				end

				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_10 = math.max(var_648_3, arg_645_1.talkMaxDuration)

			if var_648_2 <= arg_645_1.time_ and arg_645_1.time_ < var_648_2 + var_648_10 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_2) / var_648_10

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_2 + var_648_10 and arg_645_1.time_ < var_648_2 + var_648_10 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1103905157 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1103905157
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1103905158(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 and not isNil(arg_649_1.actors_["1039ui_story"]) and arg_649_1.var_.characterEffect1039ui_story == nil then
				arg_649_1.var_.characterEffect1039ui_story = arg_649_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_652_0 = 0.200000002980232

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_0 and not isNil(arg_649_1.actors_["1039ui_story"]) then
				if arg_649_1.var_.characterEffect1039ui_story and not isNil(arg_649_1.actors_["1039ui_story"]) then
					arg_649_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_649_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_649_1.time_ - 0) / var_652_0)
				end
			end

			if arg_649_1.time_ >= 0 + var_652_0 and arg_649_1.time_ < 0 + var_652_0 + arg_652_0 and not isNil(arg_649_1.actors_["1039ui_story"]) and arg_649_1.var_.characterEffect1039ui_story then
				arg_649_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_649_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_652_1 = 0
			local var_652_2 = 0.05

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_1 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, true)
				arg_649_1.iconController_:SetSelectedState("hero")

				arg_649_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_649_1.callingController_:SetSelectedState("normal")

				arg_649_1.keyicon_.color = Color.New(1, 1, 1)
				arg_649_1.icon_.color = Color.New(1, 1, 1)

				local var_652_3 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(1103905157).content)

				arg_649_1.text_.text = var_652_3

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_5 = 2 <= 0 and var_652_2 or var_652_2 * (utf8.len(var_652_3) / 2)

				if (2 <= 0 and var_652_2 or var_652_2 * (utf8.len(var_652_3) / 2)) > 0 and var_652_2 < var_652_5 then
					arg_649_1.talkMaxDuration = var_652_5

					if var_652_5 + var_652_1 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_5 + var_652_1
					end
				end

				arg_649_1.text_.text = var_652_3
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_6 = math.max(var_652_2, arg_649_1.talkMaxDuration)

			if var_652_1 <= arg_649_1.time_ and arg_649_1.time_ < var_652_1 + var_652_6 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_1) / var_652_6

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_1 + var_652_6 and arg_649_1.time_ < var_652_1 + var_652_6 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1103905158 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1103905158
		arg_653_1.duration_ = 8.5

		local var_653_0 = {
			zh = 8.5,
			ja = 6.566
		}
		local var_653_1 = manager.audio:GetLocalizationFlag()

		if var_653_0[var_653_1] ~= nil then
			arg_653_1.duration_ = var_653_0[var_653_1]
		end

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1103905159(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 and not isNil(arg_653_1.actors_["1039ui_story"]) and arg_653_1.var_.characterEffect1039ui_story == nil then
				arg_653_1.var_.characterEffect1039ui_story = arg_653_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_0 = 0.2

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_0 and not isNil(arg_653_1.actors_["1039ui_story"]) then
				if arg_653_1.var_.characterEffect1039ui_story and not isNil(arg_653_1.actors_["1039ui_story"]) then
					arg_653_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_653_1.time_ >= 0 + var_656_0 and arg_653_1.time_ < 0 + var_656_0 + arg_656_0 and not isNil(arg_653_1.actors_["1039ui_story"]) and arg_653_1.var_.characterEffect1039ui_story then
				arg_653_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_656_2 = 0
			local var_656_3 = 1.075

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_2 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				arg_653_1.leftNameTxt_.text = arg_653_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_4 = arg_653_1:GetWordFromCfg(1103905158)
				local var_656_5 = arg_653_1:FormatText(var_656_4.content)

				arg_653_1.text_.text = var_656_5

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_7 = 43 <= 0 and var_656_3 or var_656_3 * (utf8.len(var_656_5) / 43)

				if (43 <= 0 and var_656_3 or var_656_3 * (utf8.len(var_656_5) / 43)) > 0 and var_656_3 < var_656_7 then
					arg_653_1.talkMaxDuration = var_656_7

					if var_656_7 + var_656_2 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_7 + var_656_2
					end
				end

				arg_653_1.text_.text = var_656_5
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905158", "story_v_side_new_1103905.awb") ~= 0 then
					local var_656_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905158", "story_v_side_new_1103905.awb") / 1000

					if var_656_8 + var_656_2 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_8 + var_656_2
					end

					if var_656_4.prefab_name ~= "" and arg_653_1.actors_[var_656_4.prefab_name] ~= nil then
						local var_656_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_4.prefab_name].transform, "story_v_side_new_1103905", "1103905158", "story_v_side_new_1103905.awb")

						arg_653_1:RecordAudio("1103905158", var_656_9)
						arg_653_1:RecordAudio("1103905158", var_656_9)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905158", "story_v_side_new_1103905.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905158", "story_v_side_new_1103905.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_10 = math.max(var_656_3, arg_653_1.talkMaxDuration)

			if var_656_2 <= arg_653_1.time_ and arg_653_1.time_ < var_656_2 + var_656_10 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_2) / var_656_10

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_2 + var_656_10 and arg_653_1.time_ < var_656_2 + var_656_10 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play1103905159 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1103905159
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play1103905160(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(arg_657_1.actors_["1039ui_story"]) and arg_657_1.var_.characterEffect1039ui_story == nil then
				arg_657_1.var_.characterEffect1039ui_story = arg_657_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_0 = 0.2

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 and not isNil(arg_657_1.actors_["1039ui_story"]) then
				if arg_657_1.var_.characterEffect1039ui_story and not isNil(arg_657_1.actors_["1039ui_story"]) then
					arg_657_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_657_1.time_ - 0) / var_660_0)
				end
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 and not isNil(arg_657_1.actors_["1039ui_story"]) and arg_657_1.var_.characterEffect1039ui_story then
				arg_657_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_660_1 = 0
			local var_660_2 = 0.25

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, true)
				arg_657_1.iconController_:SetSelectedState("hero")

				arg_657_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_657_1.callingController_:SetSelectedState("normal")

				arg_657_1.keyicon_.color = Color.New(1, 1, 1)
				arg_657_1.icon_.color = Color.New(1, 1, 1)

				local var_660_3 = arg_657_1:FormatText(arg_657_1:GetWordFromCfg(1103905159).content)

				arg_657_1.text_.text = var_660_3

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_5 = 10 <= 0 and var_660_2 or var_660_2 * (utf8.len(var_660_3) / 10)

				if (10 <= 0 and var_660_2 or var_660_2 * (utf8.len(var_660_3) / 10)) > 0 and var_660_2 < var_660_5 then
					arg_657_1.talkMaxDuration = var_660_5

					if var_660_5 + var_660_1 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_5 + var_660_1
					end
				end

				arg_657_1.text_.text = var_660_3
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_6 = math.max(var_660_2, arg_657_1.talkMaxDuration)

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_6 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_1) / var_660_6

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_1 + var_660_6 and arg_657_1.time_ < var_660_1 + var_660_6 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play1103905160 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 1103905160
		arg_661_1.duration_ = 8.87

		local var_661_0 = {
			zh = 4.7,
			ja = 8.866
		}
		local var_661_1 = manager.audio:GetLocalizationFlag()

		if var_661_0[var_661_1] ~= nil then
			arg_661_1.duration_ = var_661_0[var_661_1]
		end

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play1103905161(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 and not isNil(arg_661_1.actors_["1039ui_story"]) and arg_661_1.var_.characterEffect1039ui_story == nil then
				arg_661_1.var_.characterEffect1039ui_story = arg_661_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_664_0 = 0.2

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_0 and not isNil(arg_661_1.actors_["1039ui_story"]) then
				if arg_661_1.var_.characterEffect1039ui_story and not isNil(arg_661_1.actors_["1039ui_story"]) then
					arg_661_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_661_1.time_ >= 0 + var_664_0 and arg_661_1.time_ < 0 + var_664_0 + arg_664_0 and not isNil(arg_661_1.actors_["1039ui_story"]) and arg_661_1.var_.characterEffect1039ui_story then
				arg_661_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_664_2 = 0
			local var_664_3 = 0.625

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= var_664_2 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_4 = arg_661_1:GetWordFromCfg(1103905160)
				local var_664_5 = arg_661_1:FormatText(var_664_4.content)

				arg_661_1.text_.text = var_664_5

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_7 = 25 <= 0 and var_664_3 or var_664_3 * (utf8.len(var_664_5) / 25)

				if (25 <= 0 and var_664_3 or var_664_3 * (utf8.len(var_664_5) / 25)) > 0 and var_664_3 < var_664_7 then
					arg_661_1.talkMaxDuration = var_664_7

					if var_664_7 + var_664_2 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_7 + var_664_2
					end
				end

				arg_661_1.text_.text = var_664_5
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905160", "story_v_side_new_1103905.awb") ~= 0 then
					local var_664_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905160", "story_v_side_new_1103905.awb") / 1000

					if var_664_8 + var_664_2 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_8 + var_664_2
					end

					if var_664_4.prefab_name ~= "" and arg_661_1.actors_[var_664_4.prefab_name] ~= nil then
						local var_664_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_661_1.actors_[var_664_4.prefab_name].transform, "story_v_side_new_1103905", "1103905160", "story_v_side_new_1103905.awb")

						arg_661_1:RecordAudio("1103905160", var_664_9)
						arg_661_1:RecordAudio("1103905160", var_664_9)
					else
						arg_661_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905160", "story_v_side_new_1103905.awb")
					end

					arg_661_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905160", "story_v_side_new_1103905.awb")
				end

				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_10 = math.max(var_664_3, arg_661_1.talkMaxDuration)

			if var_664_2 <= arg_661_1.time_ and arg_661_1.time_ < var_664_2 + var_664_10 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - var_664_2) / var_664_10

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= var_664_2 + var_664_10 and arg_661_1.time_ < var_664_2 + var_664_10 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play1103905161 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 1103905161
		arg_665_1.duration_ = 5

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play1103905162(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 and not isNil(arg_665_1.actors_["1039ui_story"]) and arg_665_1.var_.characterEffect1039ui_story == nil then
				arg_665_1.var_.characterEffect1039ui_story = arg_665_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_668_0 = 0.2

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_0 and not isNil(arg_665_1.actors_["1039ui_story"]) then
				if arg_665_1.var_.characterEffect1039ui_story and not isNil(arg_665_1.actors_["1039ui_story"]) then
					arg_665_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_665_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_665_1.time_ - 0) / var_668_0)
				end
			end

			if arg_665_1.time_ >= 0 + var_668_0 and arg_665_1.time_ < 0 + var_668_0 + arg_668_0 and not isNil(arg_665_1.actors_["1039ui_story"]) and arg_665_1.var_.characterEffect1039ui_story then
				arg_665_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_665_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_668_1 = 0
			local var_668_2 = 0.25

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0
				arg_665_1.dialogCg_.alpha = 1

				arg_665_1.dialog_:SetActive(true)
				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, true)
				arg_665_1.iconController_:SetSelectedState("hero")

				arg_665_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_665_1.callingController_:SetSelectedState("normal")

				arg_665_1.keyicon_.color = Color.New(1, 1, 1)
				arg_665_1.icon_.color = Color.New(1, 1, 1)

				local var_668_3 = arg_665_1:FormatText(arg_665_1:GetWordFromCfg(1103905161).content)

				arg_665_1.text_.text = var_668_3

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_5 = 10 <= 0 and var_668_2 or var_668_2 * (utf8.len(var_668_3) / 10)

				if (10 <= 0 and var_668_2 or var_668_2 * (utf8.len(var_668_3) / 10)) > 0 and var_668_2 < var_668_5 then
					arg_665_1.talkMaxDuration = var_668_5

					if var_668_5 + var_668_1 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_5 + var_668_1
					end
				end

				arg_665_1.text_.text = var_668_3
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)
				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_6 = math.max(var_668_2, arg_665_1.talkMaxDuration)

			if var_668_1 <= arg_665_1.time_ and arg_665_1.time_ < var_668_1 + var_668_6 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_1) / var_668_6

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_1 + var_668_6 and arg_665_1.time_ < var_668_1 + var_668_6 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {}

		arg_665_1:InitPlayNodeList()
	end,
	Play1103905162 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 1103905162
		arg_669_1.duration_ = 7

		local var_669_0 = {
			zh = 4.433,
			ja = 7
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
				arg_669_0:Play1103905163(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 and not isNil(arg_669_1.actors_["1039ui_story"]) and arg_669_1.var_.characterEffect1039ui_story == nil then
				arg_669_1.var_.characterEffect1039ui_story = arg_669_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_672_0 = 0.200000002980232

			if 0 <= arg_669_1.time_ and arg_669_1.time_ < 0 + var_672_0 and not isNil(arg_669_1.actors_["1039ui_story"]) then
				if arg_669_1.var_.characterEffect1039ui_story and not isNil(arg_669_1.actors_["1039ui_story"]) then
					arg_669_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_669_1.time_ >= 0 + var_672_0 and arg_669_1.time_ < 0 + var_672_0 + arg_672_0 and not isNil(arg_669_1.actors_["1039ui_story"]) and arg_669_1.var_.characterEffect1039ui_story then
				arg_669_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= 0 + arg_672_0 then
				arg_669_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_672_2 = 0
			local var_672_3 = 0.475

			if 0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_2 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, true)

				arg_669_1.leftNameTxt_.text = arg_669_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_669_1.leftNameTxt_.transform)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1.leftNameTxt_.text)
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_4 = arg_669_1:GetWordFromCfg(1103905162)
				local var_672_5 = arg_669_1:FormatText(var_672_4.content)

				arg_669_1.text_.text = var_672_5

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_7 = 19 <= 0 and var_672_3 or var_672_3 * (utf8.len(var_672_5) / 19)

				if (19 <= 0 and var_672_3 or var_672_3 * (utf8.len(var_672_5) / 19)) > 0 and var_672_3 < var_672_7 then
					arg_669_1.talkMaxDuration = var_672_7

					if var_672_7 + var_672_2 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_7 + var_672_2
					end
				end

				arg_669_1.text_.text = var_672_5
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905162", "story_v_side_new_1103905.awb") ~= 0 then
					local var_672_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905162", "story_v_side_new_1103905.awb") / 1000

					if var_672_8 + var_672_2 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_8 + var_672_2
					end

					if var_672_4.prefab_name ~= "" and arg_669_1.actors_[var_672_4.prefab_name] ~= nil then
						local var_672_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_669_1.actors_[var_672_4.prefab_name].transform, "story_v_side_new_1103905", "1103905162", "story_v_side_new_1103905.awb")

						arg_669_1:RecordAudio("1103905162", var_672_9)
						arg_669_1:RecordAudio("1103905162", var_672_9)
					else
						arg_669_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905162", "story_v_side_new_1103905.awb")
					end

					arg_669_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905162", "story_v_side_new_1103905.awb")
				end

				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_10 = math.max(var_672_3, arg_669_1.talkMaxDuration)

			if var_672_2 <= arg_669_1.time_ and arg_669_1.time_ < var_672_2 + var_672_10 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_2) / var_672_10

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_2 + var_672_10 and arg_669_1.time_ < var_672_2 + var_672_10 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play1103905163 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 1103905163
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play1103905164(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			if 0 < arg_673_1.time_ and arg_673_1.time_ <= 0 + arg_676_0 and not isNil(arg_673_1.actors_["1039ui_story"]) and arg_673_1.var_.characterEffect1039ui_story == nil then
				arg_673_1.var_.characterEffect1039ui_story = arg_673_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_676_0 = 0.200000002980232

			if 0 <= arg_673_1.time_ and arg_673_1.time_ < 0 + var_676_0 and not isNil(arg_673_1.actors_["1039ui_story"]) then
				if arg_673_1.var_.characterEffect1039ui_story and not isNil(arg_673_1.actors_["1039ui_story"]) then
					arg_673_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_673_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_673_1.time_ - 0) / var_676_0)
				end
			end

			if arg_673_1.time_ >= 0 + var_676_0 and arg_673_1.time_ < 0 + var_676_0 + arg_676_0 and not isNil(arg_673_1.actors_["1039ui_story"]) and arg_673_1.var_.characterEffect1039ui_story then
				arg_673_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_673_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_676_1 = 0
			local var_676_2 = 0.6

			if 0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_1 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, false)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_673_1.iconTrs_.gameObject, false)
				arg_673_1.callingController_:SetSelectedState("normal")

				local var_676_3 = arg_673_1:FormatText(arg_673_1:GetWordFromCfg(1103905163).content)

				arg_673_1.text_.text = var_676_3

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_5 = 24 <= 0 and var_676_2 or var_676_2 * (utf8.len(var_676_3) / 24)

				if (24 <= 0 and var_676_2 or var_676_2 * (utf8.len(var_676_3) / 24)) > 0 and var_676_2 < var_676_5 then
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
	Play1103905164 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 1103905164
		arg_677_1.duration_ = 10.87

		local var_677_0 = {
			zh = 10.866,
			ja = 10.266
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
				arg_677_0:Play1103905165(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 and not isNil(arg_677_1.actors_["1039ui_story"]) and arg_677_1.var_.characterEffect1039ui_story == nil then
				arg_677_1.var_.characterEffect1039ui_story = arg_677_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_0 = 0.2

			if 0 <= arg_677_1.time_ and arg_677_1.time_ < 0 + var_680_0 and not isNil(arg_677_1.actors_["1039ui_story"]) then
				if arg_677_1.var_.characterEffect1039ui_story and not isNil(arg_677_1.actors_["1039ui_story"]) then
					arg_677_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= 0 + var_680_0 and arg_677_1.time_ < 0 + var_680_0 + arg_680_0 and not isNil(arg_677_1.actors_["1039ui_story"]) and arg_677_1.var_.characterEffect1039ui_story then
				arg_677_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= 0 + arg_680_0 then
				arg_677_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_680_2 = 0
			local var_680_3 = 1.3

			if 0 < arg_677_1.time_ and arg_677_1.time_ <= var_680_2 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				arg_677_1.leftNameTxt_.text = arg_677_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_4 = arg_677_1:GetWordFromCfg(1103905164)
				local var_680_5 = arg_677_1:FormatText(var_680_4.content)

				arg_677_1.text_.text = var_680_5

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_7 = 52 <= 0 and var_680_3 or var_680_3 * (utf8.len(var_680_5) / 52)

				if (52 <= 0 and var_680_3 or var_680_3 * (utf8.len(var_680_5) / 52)) > 0 and var_680_3 < var_680_7 then
					arg_677_1.talkMaxDuration = var_680_7

					if var_680_7 + var_680_2 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_7 + var_680_2
					end
				end

				arg_677_1.text_.text = var_680_5
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905164", "story_v_side_new_1103905.awb") ~= 0 then
					local var_680_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905164", "story_v_side_new_1103905.awb") / 1000

					if var_680_8 + var_680_2 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_8 + var_680_2
					end

					if var_680_4.prefab_name ~= "" and arg_677_1.actors_[var_680_4.prefab_name] ~= nil then
						local var_680_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_677_1.actors_[var_680_4.prefab_name].transform, "story_v_side_new_1103905", "1103905164", "story_v_side_new_1103905.awb")

						arg_677_1:RecordAudio("1103905164", var_680_9)
						arg_677_1:RecordAudio("1103905164", var_680_9)
					else
						arg_677_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905164", "story_v_side_new_1103905.awb")
					end

					arg_677_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905164", "story_v_side_new_1103905.awb")
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
	Play1103905165 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 1103905165
		arg_681_1.duration_ = 15.13

		local var_681_0 = {
			zh = 11.133,
			ja = 15.133
		}
		local var_681_1 = manager.audio:GetLocalizationFlag()

		if var_681_0[var_681_1] ~= nil then
			arg_681_1.duration_ = var_681_0[var_681_1]
		end

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play1103905166(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = 1.325

			if 0 < arg_681_1.time_ and arg_681_1.time_ <= 0 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				arg_681_1.leftNameTxt_.text = arg_681_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_1 = arg_681_1:GetWordFromCfg(1103905165)
				local var_684_2 = arg_681_1:FormatText(var_684_1.content)

				arg_681_1.text_.text = var_684_2

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_4 = 53 <= 0 and var_684_0 or var_684_0 * (utf8.len(var_684_2) / 53)

				if (53 <= 0 and var_684_0 or var_684_0 * (utf8.len(var_684_2) / 53)) > 0 and var_684_0 < var_684_4 then
					arg_681_1.talkMaxDuration = var_684_4

					if var_684_4 + 0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_4 + 0
					end
				end

				arg_681_1.text_.text = var_684_2
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905165", "story_v_side_new_1103905.awb") ~= 0 then
					local var_684_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905165", "story_v_side_new_1103905.awb") / 1000

					if var_684_5 + 0 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_5 + 0
					end

					if var_684_1.prefab_name ~= "" and arg_681_1.actors_[var_684_1.prefab_name] ~= nil then
						local var_684_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_681_1.actors_[var_684_1.prefab_name].transform, "story_v_side_new_1103905", "1103905165", "story_v_side_new_1103905.awb")

						arg_681_1:RecordAudio("1103905165", var_684_6)
						arg_681_1:RecordAudio("1103905165", var_684_6)
					else
						arg_681_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905165", "story_v_side_new_1103905.awb")
					end

					arg_681_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905165", "story_v_side_new_1103905.awb")
				end

				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_7 = math.max(var_684_0, arg_681_1.talkMaxDuration)

			if 0 <= arg_681_1.time_ and arg_681_1.time_ < 0 + var_684_7 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - 0) / var_684_7

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= 0 + var_684_7 and arg_681_1.time_ < 0 + var_684_7 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {}

		arg_681_1:InitPlayNodeList()
	end,
	Play1103905166 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 1103905166
		arg_685_1.duration_ = 16.7

		local var_685_0 = {
			zh = 16.7,
			ja = 13.066
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
				arg_685_0:Play1103905167(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 1.75

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				arg_685_1.leftNameTxt_.text = arg_685_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_1 = arg_685_1:GetWordFromCfg(1103905166)
				local var_688_2 = arg_685_1:FormatText(var_688_1.content)

				arg_685_1.text_.text = var_688_2

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_4 = 70 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_2) / 70)

				if (70 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_2) / 70)) > 0 and var_688_0 < var_688_4 then
					arg_685_1.talkMaxDuration = var_688_4

					if var_688_4 + 0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_4 + 0
					end
				end

				arg_685_1.text_.text = var_688_2
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905166", "story_v_side_new_1103905.awb") ~= 0 then
					local var_688_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905166", "story_v_side_new_1103905.awb") / 1000

					if var_688_5 + 0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_5 + 0
					end

					if var_688_1.prefab_name ~= "" and arg_685_1.actors_[var_688_1.prefab_name] ~= nil then
						local var_688_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_685_1.actors_[var_688_1.prefab_name].transform, "story_v_side_new_1103905", "1103905166", "story_v_side_new_1103905.awb")

						arg_685_1:RecordAudio("1103905166", var_688_6)
						arg_685_1:RecordAudio("1103905166", var_688_6)
					else
						arg_685_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905166", "story_v_side_new_1103905.awb")
					end

					arg_685_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905166", "story_v_side_new_1103905.awb")
				end

				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_7 = math.max(var_688_0, arg_685_1.talkMaxDuration)

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_7 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - 0) / var_688_7

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= 0 + var_688_7 and arg_685_1.time_ < 0 + var_688_7 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play1103905167 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 1103905167
		arg_689_1.duration_ = 8.83

		local var_689_0 = {
			zh = 2.566,
			ja = 8.833
		}
		local var_689_1 = manager.audio:GetLocalizationFlag()

		if var_689_0[var_689_1] ~= nil then
			arg_689_1.duration_ = var_689_0[var_689_1]
		end

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play1103905168(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_692_0 = 0
			local var_692_1 = 0.25

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_0 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_2 = arg_689_1:GetWordFromCfg(1103905167)
				local var_692_3 = arg_689_1:FormatText(var_692_2.content)

				arg_689_1.text_.text = var_692_3

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_5 = 10 <= 0 and var_692_1 or var_692_1 * (utf8.len(var_692_3) / 10)

				if (10 <= 0 and var_692_1 or var_692_1 * (utf8.len(var_692_3) / 10)) > 0 and var_692_1 < var_692_5 then
					arg_689_1.talkMaxDuration = var_692_5

					if var_692_5 + var_692_0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_5 + var_692_0
					end
				end

				arg_689_1.text_.text = var_692_3
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905167", "story_v_side_new_1103905.awb") ~= 0 then
					local var_692_6 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905167", "story_v_side_new_1103905.awb") / 1000

					if var_692_6 + var_692_0 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_6 + var_692_0
					end

					if var_692_2.prefab_name ~= "" and arg_689_1.actors_[var_692_2.prefab_name] ~= nil then
						local var_692_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_689_1.actors_[var_692_2.prefab_name].transform, "story_v_side_new_1103905", "1103905167", "story_v_side_new_1103905.awb")

						arg_689_1:RecordAudio("1103905167", var_692_7)
						arg_689_1:RecordAudio("1103905167", var_692_7)
					else
						arg_689_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905167", "story_v_side_new_1103905.awb")
					end

					arg_689_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905167", "story_v_side_new_1103905.awb")
				end

				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_8 = math.max(var_692_1, arg_689_1.talkMaxDuration)

			if var_692_0 <= arg_689_1.time_ and arg_689_1.time_ < var_692_0 + var_692_8 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_0) / var_692_8

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_0 + var_692_8 and arg_689_1.time_ < var_692_0 + var_692_8 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play1103905168 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 1103905168
		arg_693_1.duration_ = 8.33

		local var_693_0 = {
			zh = 7.866,
			ja = 8.333
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
				arg_693_0:Play1103905169(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = 0.85

			if 0 < arg_693_1.time_ and arg_693_1.time_ <= 0 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				arg_693_1.leftNameTxt_.text = arg_693_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_1 = arg_693_1:GetWordFromCfg(1103905168)
				local var_696_2 = arg_693_1:FormatText(var_696_1.content)

				arg_693_1.text_.text = var_696_2

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_4 = 34 <= 0 and var_696_0 or var_696_0 * (utf8.len(var_696_2) / 34)

				if (34 <= 0 and var_696_0 or var_696_0 * (utf8.len(var_696_2) / 34)) > 0 and var_696_0 < var_696_4 then
					arg_693_1.talkMaxDuration = var_696_4

					if var_696_4 + 0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_4 + 0
					end
				end

				arg_693_1.text_.text = var_696_2
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905168", "story_v_side_new_1103905.awb") ~= 0 then
					local var_696_5 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905168", "story_v_side_new_1103905.awb") / 1000

					if var_696_5 + 0 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_5 + 0
					end

					if var_696_1.prefab_name ~= "" and arg_693_1.actors_[var_696_1.prefab_name] ~= nil then
						local var_696_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_693_1.actors_[var_696_1.prefab_name].transform, "story_v_side_new_1103905", "1103905168", "story_v_side_new_1103905.awb")

						arg_693_1:RecordAudio("1103905168", var_696_6)
						arg_693_1:RecordAudio("1103905168", var_696_6)
					else
						arg_693_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905168", "story_v_side_new_1103905.awb")
					end

					arg_693_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905168", "story_v_side_new_1103905.awb")
				end

				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_7 = math.max(var_696_0, arg_693_1.talkMaxDuration)

			if 0 <= arg_693_1.time_ and arg_693_1.time_ < 0 + var_696_7 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - 0) / var_696_7

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= 0 + var_696_7 and arg_693_1.time_ < 0 + var_696_7 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {}

		arg_693_1:InitPlayNodeList()
	end,
	Play1103905169 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 1103905169
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play1103905170(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			if 0 < arg_697_1.time_ and arg_697_1.time_ <= 0 + arg_700_0 and not isNil(arg_697_1.actors_["1039ui_story"]) and arg_697_1.var_.characterEffect1039ui_story == nil then
				arg_697_1.var_.characterEffect1039ui_story = arg_697_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_700_0 = 0.2

			if 0 <= arg_697_1.time_ and arg_697_1.time_ < 0 + var_700_0 and not isNil(arg_697_1.actors_["1039ui_story"]) then
				if arg_697_1.var_.characterEffect1039ui_story and not isNil(arg_697_1.actors_["1039ui_story"]) then
					arg_697_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_697_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_697_1.time_ - 0) / var_700_0)
				end
			end

			if arg_697_1.time_ >= 0 + var_700_0 and arg_697_1.time_ < 0 + var_700_0 + arg_700_0 and not isNil(arg_697_1.actors_["1039ui_story"]) and arg_697_1.var_.characterEffect1039ui_story then
				arg_697_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_697_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_700_1 = 0
			local var_700_2 = 0.125

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

				local var_700_3 = arg_697_1:FormatText(arg_697_1:GetWordFromCfg(1103905169).content)

				arg_697_1.text_.text = var_700_3

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_5 = 5 <= 0 and var_700_2 or var_700_2 * (utf8.len(var_700_3) / 5)

				if (5 <= 0 and var_700_2 or var_700_2 * (utf8.len(var_700_3) / 5)) > 0 and var_700_2 < var_700_5 then
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
	Play1103905170 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 1103905170
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play1103905171(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 1.075

			if 0 < arg_701_1.time_ and arg_701_1.time_ <= 0 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, false)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_1 = arg_701_1:FormatText(arg_701_1:GetWordFromCfg(1103905170).content)

				arg_701_1.text_.text = var_704_1

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_3 = 43 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 43)

				if (43 <= 0 and var_704_0 or var_704_0 * (utf8.len(var_704_1) / 43)) > 0 and var_704_0 < var_704_3 then
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
	Play1103905171 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 1103905171
		arg_705_1.duration_ = 9.77

		local var_705_0 = {
			zh = 7.566,
			ja = 9.766
		}
		local var_705_1 = manager.audio:GetLocalizationFlag()

		if var_705_0[var_705_1] ~= nil then
			arg_705_1.duration_ = var_705_0[var_705_1]
		end

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play1103905172(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 and not isNil(arg_705_1.actors_["1039ui_story"]) and arg_705_1.var_.characterEffect1039ui_story == nil then
				arg_705_1.var_.characterEffect1039ui_story = arg_705_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_0 = 0.200000002980232

			if 0 <= arg_705_1.time_ and arg_705_1.time_ < 0 + var_708_0 and not isNil(arg_705_1.actors_["1039ui_story"]) then
				if arg_705_1.var_.characterEffect1039ui_story and not isNil(arg_705_1.actors_["1039ui_story"]) then
					arg_705_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_705_1.time_ >= 0 + var_708_0 and arg_705_1.time_ < 0 + var_708_0 + arg_708_0 and not isNil(arg_705_1.actors_["1039ui_story"]) and arg_705_1.var_.characterEffect1039ui_story then
				arg_705_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= 0 + arg_708_0 then
				arg_705_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_708_2 = 0
			local var_708_3 = 0.825

			if 0 < arg_705_1.time_ and arg_705_1.time_ <= var_708_2 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				arg_705_1.leftNameTxt_.text = arg_705_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_4 = arg_705_1:GetWordFromCfg(1103905171)
				local var_708_5 = arg_705_1:FormatText(var_708_4.content)

				arg_705_1.text_.text = var_708_5

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_7 = 33 <= 0 and var_708_3 or var_708_3 * (utf8.len(var_708_5) / 33)

				if (33 <= 0 and var_708_3 or var_708_3 * (utf8.len(var_708_5) / 33)) > 0 and var_708_3 < var_708_7 then
					arg_705_1.talkMaxDuration = var_708_7

					if var_708_7 + var_708_2 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_7 + var_708_2
					end
				end

				arg_705_1.text_.text = var_708_5
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905171", "story_v_side_new_1103905.awb") ~= 0 then
					local var_708_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905171", "story_v_side_new_1103905.awb") / 1000

					if var_708_8 + var_708_2 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_8 + var_708_2
					end

					if var_708_4.prefab_name ~= "" and arg_705_1.actors_[var_708_4.prefab_name] ~= nil then
						local var_708_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_705_1.actors_[var_708_4.prefab_name].transform, "story_v_side_new_1103905", "1103905171", "story_v_side_new_1103905.awb")

						arg_705_1:RecordAudio("1103905171", var_708_9)
						arg_705_1:RecordAudio("1103905171", var_708_9)
					else
						arg_705_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905171", "story_v_side_new_1103905.awb")
					end

					arg_705_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905171", "story_v_side_new_1103905.awb")
				end

				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_10 = math.max(var_708_3, arg_705_1.talkMaxDuration)

			if var_708_2 <= arg_705_1.time_ and arg_705_1.time_ < var_708_2 + var_708_10 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_2) / var_708_10

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_2 + var_708_10 and arg_705_1.time_ < var_708_2 + var_708_10 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {}

		arg_705_1:InitPlayNodeList()
	end,
	Play1103905172 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 1103905172
		arg_709_1.duration_ = 1

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"

			SetActive(arg_709_1.choicesGo_, true)

			for iter_710_0, iter_710_1 in ipairs(arg_709_1.choices_) do
				SetActive(iter_710_1.go, iter_710_0 <= 2)
			end

			arg_709_1.choices_[1].txt.text = arg_709_1:FormatText(StoryChoiceCfg[695].name)
			arg_709_1.choices_[2].txt.text = arg_709_1:FormatText(StoryChoiceCfg[696].name)
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play1103905173(arg_709_1)
			end

			if arg_711_0 == 2 then
				arg_709_0:Play1103905174(arg_709_1)
			end

			arg_709_1:RecordChoiceLog(1103905172, 695, 696)
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			if 0 < arg_709_1.time_ and arg_709_1.time_ <= 0 + arg_712_0 and not isNil(arg_709_1.actors_["1039ui_story"]) and arg_709_1.var_.characterEffect1039ui_story == nil then
				arg_709_1.var_.characterEffect1039ui_story = arg_709_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_712_0 = 0.200000002980232

			if 0 <= arg_709_1.time_ and arg_709_1.time_ < 0 + var_712_0 and not isNil(arg_709_1.actors_["1039ui_story"]) then
				if arg_709_1.var_.characterEffect1039ui_story and not isNil(arg_709_1.actors_["1039ui_story"]) then
					arg_709_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_709_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_709_1.time_ - 0) / var_712_0)
				end
			end

			if arg_709_1.time_ >= 0 + var_712_0 and arg_709_1.time_ < 0 + var_712_0 + arg_712_0 and not isNil(arg_709_1.actors_["1039ui_story"]) and arg_709_1.var_.characterEffect1039ui_story then
				arg_709_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_709_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_712_1 = 0

			if 0 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 then
				arg_709_1.allBtn_.enabled = false
			end

			if arg_709_1.time_ >= var_712_1 + 0.5 and arg_709_1.time_ < var_712_1 + 0.5 + arg_712_0 then
				arg_709_1.allBtn_.enabled = true
			end
		end

		arg_709_1.nodeConfigList_ = {}

		arg_709_1:InitPlayNodeList()
	end,
	Play1103905173 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 1103905173
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play1103905175(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = 0.425

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

				local var_716_1 = arg_713_1:FormatText(arg_713_1:GetWordFromCfg(1103905173).content)

				arg_713_1.text_.text = var_716_1

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_3 = 17 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 17)

				if (17 <= 0 and var_716_0 or var_716_0 * (utf8.len(var_716_1) / 17)) > 0 and var_716_0 < var_716_3 then
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
	Play1103905175 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 1103905175
		arg_717_1.duration_ = 5

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play1103905176(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = 0.625

			if 0 < arg_717_1.time_ and arg_717_1.time_ <= 0 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				arg_717_1.leftNameTxt_.text = arg_717_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, true)
				arg_717_1.iconController_:SetSelectedState("hero")

				arg_717_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_717_1.callingController_:SetSelectedState("normal")

				arg_717_1.keyicon_.color = Color.New(1, 1, 1)
				arg_717_1.icon_.color = Color.New(1, 1, 1)

				local var_720_1 = arg_717_1:FormatText(arg_717_1:GetWordFromCfg(1103905175).content)

				arg_717_1.text_.text = var_720_1

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_3 = 25 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_1) / 25)

				if (25 <= 0 and var_720_0 or var_720_0 * (utf8.len(var_720_1) / 25)) > 0 and var_720_0 < var_720_3 then
					arg_717_1.talkMaxDuration = var_720_3

					if var_720_3 + 0 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_3 + 0
					end
				end

				arg_717_1.text_.text = var_720_1
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)
				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_4 = math.max(var_720_0, arg_717_1.talkMaxDuration)

			if 0 <= arg_717_1.time_ and arg_717_1.time_ < 0 + var_720_4 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - 0) / var_720_4

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= 0 + var_720_4 and arg_717_1.time_ < 0 + var_720_4 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play1103905176 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 1103905176
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play1103905177(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = 0.475

			if 0 < arg_721_1.time_ and arg_721_1.time_ <= 0 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, false)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_1 = arg_721_1:FormatText(arg_721_1:GetWordFromCfg(1103905176).content)

				arg_721_1.text_.text = var_724_1

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_3 = 19 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_1) / 19)

				if (19 <= 0 and var_724_0 or var_724_0 * (utf8.len(var_724_1) / 19)) > 0 and var_724_0 < var_724_3 then
					arg_721_1.talkMaxDuration = var_724_3

					if var_724_3 + 0 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_3 + 0
					end
				end

				arg_721_1.text_.text = var_724_1
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_4 = math.max(var_724_0, arg_721_1.talkMaxDuration)

			if 0 <= arg_721_1.time_ and arg_721_1.time_ < 0 + var_724_4 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - 0) / var_724_4

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= 0 + var_724_4 and arg_721_1.time_ < 0 + var_724_4 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play1103905177 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 1103905177
		arg_725_1.duration_ = 5.97

		local var_725_0 = {
			zh = 4.566,
			ja = 5.966
		}
		local var_725_1 = manager.audio:GetLocalizationFlag()

		if var_725_0[var_725_1] ~= nil then
			arg_725_1.duration_ = var_725_0[var_725_1]
		end

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play1103905178(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 and not isNil(arg_725_1.actors_["1039ui_story"]) and arg_725_1.var_.characterEffect1039ui_story == nil then
				arg_725_1.var_.characterEffect1039ui_story = arg_725_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_728_0 = 0.200000002980232

			if 0 <= arg_725_1.time_ and arg_725_1.time_ < 0 + var_728_0 and not isNil(arg_725_1.actors_["1039ui_story"]) then
				if arg_725_1.var_.characterEffect1039ui_story and not isNil(arg_725_1.actors_["1039ui_story"]) then
					arg_725_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_725_1.time_ >= 0 + var_728_0 and arg_725_1.time_ < 0 + var_728_0 + arg_728_0 and not isNil(arg_725_1.actors_["1039ui_story"]) and arg_725_1.var_.characterEffect1039ui_story then
				arg_725_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_2")
			end

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= 0 + arg_728_0 then
				arg_725_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_728_2 = 0
			local var_728_3 = 0.4

			if 0 < arg_725_1.time_ and arg_725_1.time_ <= var_728_2 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				arg_725_1.leftNameTxt_.text = arg_725_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, false)
				arg_725_1.callingController_:SetSelectedState("normal")

				local var_728_4 = arg_725_1:GetWordFromCfg(1103905177)
				local var_728_5 = arg_725_1:FormatText(var_728_4.content)

				arg_725_1.text_.text = var_728_5

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_7 = 16 <= 0 and var_728_3 or var_728_3 * (utf8.len(var_728_5) / 16)

				if (16 <= 0 and var_728_3 or var_728_3 * (utf8.len(var_728_5) / 16)) > 0 and var_728_3 < var_728_7 then
					arg_725_1.talkMaxDuration = var_728_7

					if var_728_7 + var_728_2 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_7 + var_728_2
					end
				end

				arg_725_1.text_.text = var_728_5
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905177", "story_v_side_new_1103905.awb") ~= 0 then
					local var_728_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905177", "story_v_side_new_1103905.awb") / 1000

					if var_728_8 + var_728_2 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_8 + var_728_2
					end

					if var_728_4.prefab_name ~= "" and arg_725_1.actors_[var_728_4.prefab_name] ~= nil then
						local var_728_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_725_1.actors_[var_728_4.prefab_name].transform, "story_v_side_new_1103905", "1103905177", "story_v_side_new_1103905.awb")

						arg_725_1:RecordAudio("1103905177", var_728_9)
						arg_725_1:RecordAudio("1103905177", var_728_9)
					else
						arg_725_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905177", "story_v_side_new_1103905.awb")
					end

					arg_725_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905177", "story_v_side_new_1103905.awb")
				end

				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_10 = math.max(var_728_3, arg_725_1.talkMaxDuration)

			if var_728_2 <= arg_725_1.time_ and arg_725_1.time_ < var_728_2 + var_728_10 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_2) / var_728_10

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_2 + var_728_10 and arg_725_1.time_ < var_728_2 + var_728_10 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play1103905178 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 1103905178
		arg_729_1.duration_ = 12.47

		local var_729_0 = {
			zh = 6.466,
			ja = 12.466
		}
		local var_729_1 = manager.audio:GetLocalizationFlag()

		if var_729_0[var_729_1] ~= nil then
			arg_729_1.duration_ = var_729_0[var_729_1]
		end

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play1103905179(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_1")
			end

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= 0 + arg_732_0 then
				arg_729_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_732_0 = 0
			local var_732_1 = 0.775

			if 0 < arg_729_1.time_ and arg_729_1.time_ <= var_732_0 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				arg_729_1.leftNameTxt_.text = arg_729_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_2 = arg_729_1:GetWordFromCfg(1103905178)
				local var_732_3 = arg_729_1:FormatText(var_732_2.content)

				arg_729_1.text_.text = var_732_3

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_5 = 31 <= 0 and var_732_1 or var_732_1 * (utf8.len(var_732_3) / 31)

				if (31 <= 0 and var_732_1 or var_732_1 * (utf8.len(var_732_3) / 31)) > 0 and var_732_1 < var_732_5 then
					arg_729_1.talkMaxDuration = var_732_5

					if var_732_5 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_5 + var_732_0
					end
				end

				arg_729_1.text_.text = var_732_3
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905178", "story_v_side_new_1103905.awb") ~= 0 then
					local var_732_6 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905178", "story_v_side_new_1103905.awb") / 1000

					if var_732_6 + var_732_0 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_6 + var_732_0
					end

					if var_732_2.prefab_name ~= "" and arg_729_1.actors_[var_732_2.prefab_name] ~= nil then
						local var_732_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_729_1.actors_[var_732_2.prefab_name].transform, "story_v_side_new_1103905", "1103905178", "story_v_side_new_1103905.awb")

						arg_729_1:RecordAudio("1103905178", var_732_7)
						arg_729_1:RecordAudio("1103905178", var_732_7)
					else
						arg_729_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905178", "story_v_side_new_1103905.awb")
					end

					arg_729_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905178", "story_v_side_new_1103905.awb")
				end

				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_8 = math.max(var_732_1, arg_729_1.talkMaxDuration)

			if var_732_0 <= arg_729_1.time_ and arg_729_1.time_ < var_732_0 + var_732_8 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_0) / var_732_8

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_0 + var_732_8 and arg_729_1.time_ < var_732_0 + var_732_8 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play1103905179 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 1103905179
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play1103905180(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			if 0 < arg_733_1.time_ and arg_733_1.time_ <= 0 + arg_736_0 and not isNil(arg_733_1.actors_["1039ui_story"]) and arg_733_1.var_.characterEffect1039ui_story == nil then
				arg_733_1.var_.characterEffect1039ui_story = arg_733_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_0 = 0.200000002980232

			if 0 <= arg_733_1.time_ and arg_733_1.time_ < 0 + var_736_0 and not isNil(arg_733_1.actors_["1039ui_story"]) then
				if arg_733_1.var_.characterEffect1039ui_story and not isNil(arg_733_1.actors_["1039ui_story"]) then
					arg_733_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_733_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_733_1.time_ - 0) / var_736_0)
				end
			end

			if arg_733_1.time_ >= 0 + var_736_0 and arg_733_1.time_ < 0 + var_736_0 + arg_736_0 and not isNil(arg_733_1.actors_["1039ui_story"]) and arg_733_1.var_.characterEffect1039ui_story then
				arg_733_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_733_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_736_1 = 0
			local var_736_2 = 0.8

			if 0 < arg_733_1.time_ and arg_733_1.time_ <= var_736_1 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, false)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_733_1.iconTrs_.gameObject, false)
				arg_733_1.callingController_:SetSelectedState("normal")

				local var_736_3 = arg_733_1:FormatText(arg_733_1:GetWordFromCfg(1103905179).content)

				arg_733_1.text_.text = var_736_3

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_5 = 32 <= 0 and var_736_2 or var_736_2 * (utf8.len(var_736_3) / 32)

				if (32 <= 0 and var_736_2 or var_736_2 * (utf8.len(var_736_3) / 32)) > 0 and var_736_2 < var_736_5 then
					arg_733_1.talkMaxDuration = var_736_5

					if var_736_5 + var_736_1 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_5 + var_736_1
					end
				end

				arg_733_1.text_.text = var_736_3
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_6 = math.max(var_736_2, arg_733_1.talkMaxDuration)

			if var_736_1 <= arg_733_1.time_ and arg_733_1.time_ < var_736_1 + var_736_6 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_1) / var_736_6

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_1 + var_736_6 and arg_733_1.time_ < var_736_1 + var_736_6 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play1103905180 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 1103905180
		arg_737_1.duration_ = 6.43

		local var_737_0 = {
			zh = 5.533,
			ja = 6.433
		}
		local var_737_1 = manager.audio:GetLocalizationFlag()

		if var_737_0[var_737_1] ~= nil then
			arg_737_1.duration_ = var_737_0[var_737_1]
		end

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play1103905181(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 and not isNil(arg_737_1.actors_["1039ui_story"]) and arg_737_1.var_.characterEffect1039ui_story == nil then
				arg_737_1.var_.characterEffect1039ui_story = arg_737_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_0 = 0.200000002980232

			if 0 <= arg_737_1.time_ and arg_737_1.time_ < 0 + var_740_0 and not isNil(arg_737_1.actors_["1039ui_story"]) then
				if arg_737_1.var_.characterEffect1039ui_story and not isNil(arg_737_1.actors_["1039ui_story"]) then
					arg_737_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_737_1.time_ >= 0 + var_740_0 and arg_737_1.time_ < 0 + var_740_0 + arg_740_0 and not isNil(arg_737_1.actors_["1039ui_story"]) and arg_737_1.var_.characterEffect1039ui_story then
				arg_737_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action468")
			end

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= 0 + arg_740_0 then
				arg_737_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_740_2 = 0
			local var_740_3 = 0.6

			if 0 < arg_737_1.time_ and arg_737_1.time_ <= var_740_2 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				arg_737_1.leftNameTxt_.text = arg_737_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_4 = arg_737_1:GetWordFromCfg(1103905180)
				local var_740_5 = arg_737_1:FormatText(var_740_4.content)

				arg_737_1.text_.text = var_740_5

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_7 = 24 <= 0 and var_740_3 or var_740_3 * (utf8.len(var_740_5) / 24)

				if (24 <= 0 and var_740_3 or var_740_3 * (utf8.len(var_740_5) / 24)) > 0 and var_740_3 < var_740_7 then
					arg_737_1.talkMaxDuration = var_740_7

					if var_740_7 + var_740_2 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_7 + var_740_2
					end
				end

				arg_737_1.text_.text = var_740_5
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905180", "story_v_side_new_1103905.awb") ~= 0 then
					local var_740_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905180", "story_v_side_new_1103905.awb") / 1000

					if var_740_8 + var_740_2 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_8 + var_740_2
					end

					if var_740_4.prefab_name ~= "" and arg_737_1.actors_[var_740_4.prefab_name] ~= nil then
						local var_740_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_737_1.actors_[var_740_4.prefab_name].transform, "story_v_side_new_1103905", "1103905180", "story_v_side_new_1103905.awb")

						arg_737_1:RecordAudio("1103905180", var_740_9)
						arg_737_1:RecordAudio("1103905180", var_740_9)
					else
						arg_737_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905180", "story_v_side_new_1103905.awb")
					end

					arg_737_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905180", "story_v_side_new_1103905.awb")
				end

				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_10 = math.max(var_740_3, arg_737_1.talkMaxDuration)

			if var_740_2 <= arg_737_1.time_ and arg_737_1.time_ < var_740_2 + var_740_10 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_2) / var_740_10

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_2 + var_740_10 and arg_737_1.time_ < var_740_2 + var_740_10 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play1103905181 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 1103905181
		arg_741_1.duration_ = 1

		SetActive(arg_741_1.tipsGo_, true)

		arg_741_1.tipsText_.text = StoryTipsCfg[103901].name

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"

			SetActive(arg_741_1.choicesGo_, true)

			for iter_742_0, iter_742_1 in ipairs(arg_741_1.choices_) do
				SetActive(iter_742_1.go, iter_742_0 <= 2)
			end

			arg_741_1.choices_[1].txt.text = arg_741_1:FormatText(StoryChoiceCfg[697].name)
			arg_741_1.choices_[2].txt.text = arg_741_1:FormatText(StoryChoiceCfg[698].name)
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play1103905182(arg_741_1)
			end

			if arg_743_0 == 2 then
				PlayerAction.UseStoryTrigger(1039013, 210390105, 1103905181, 2)
				arg_741_0:Play1103905184(arg_741_1)
			end

			arg_741_1:RecordChoiceLog(1103905181, 697, 698)
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			if 0 < arg_741_1.time_ and arg_741_1.time_ <= 0 + arg_744_0 and not isNil(arg_741_1.actors_["1039ui_story"]) and arg_741_1.var_.characterEffect1039ui_story == nil then
				arg_741_1.var_.characterEffect1039ui_story = arg_741_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_744_0 = 0.200000002980232

			if 0 <= arg_741_1.time_ and arg_741_1.time_ < 0 + var_744_0 and not isNil(arg_741_1.actors_["1039ui_story"]) then
				if arg_741_1.var_.characterEffect1039ui_story and not isNil(arg_741_1.actors_["1039ui_story"]) then
					arg_741_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_741_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_741_1.time_ - 0) / var_744_0)
				end
			end

			if arg_741_1.time_ >= 0 + var_744_0 and arg_741_1.time_ < 0 + var_744_0 + arg_744_0 and not isNil(arg_741_1.actors_["1039ui_story"]) and arg_741_1.var_.characterEffect1039ui_story then
				arg_741_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_741_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_744_1 = 0

			if 0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_1 + arg_744_0 then
				arg_741_1.allBtn_.enabled = false
			end

			if arg_741_1.time_ >= var_744_1 + 0.5 and arg_741_1.time_ < var_744_1 + 0.5 + arg_744_0 then
				arg_741_1.allBtn_.enabled = true
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play1103905182 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 1103905182
		arg_745_1.duration_ = 3.9

		local var_745_0 = {
			zh = 3.866,
			ja = 3.9
		}
		local var_745_1 = manager.audio:GetLocalizationFlag()

		if var_745_0[var_745_1] ~= nil then
			arg_745_1.duration_ = var_745_0[var_745_1]
		end

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play1103905183(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 and not isNil(arg_745_1.actors_["1039ui_story"]) and arg_745_1.var_.characterEffect1039ui_story == nil then
				arg_745_1.var_.characterEffect1039ui_story = arg_745_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_748_0 = 0.200000002980232

			if 0 <= arg_745_1.time_ and arg_745_1.time_ < 0 + var_748_0 and not isNil(arg_745_1.actors_["1039ui_story"]) then
				if arg_745_1.var_.characterEffect1039ui_story and not isNil(arg_745_1.actors_["1039ui_story"]) then
					arg_745_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_745_1.time_ >= 0 + var_748_0 and arg_745_1.time_ < 0 + var_748_0 + arg_748_0 and not isNil(arg_745_1.actors_["1039ui_story"]) and arg_745_1.var_.characterEffect1039ui_story then
				arg_745_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action8_2")
			end

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= 0 + arg_748_0 then
				arg_745_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_748_2 = 0
			local var_748_3 = 0.275

			if 0 < arg_745_1.time_ and arg_745_1.time_ <= var_748_2 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				arg_745_1.leftNameTxt_.text = arg_745_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_4 = arg_745_1:GetWordFromCfg(1103905182)
				local var_748_5 = arg_745_1:FormatText(var_748_4.content)

				arg_745_1.text_.text = var_748_5

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_7 = 11 <= 0 and var_748_3 or var_748_3 * (utf8.len(var_748_5) / 11)

				if (11 <= 0 and var_748_3 or var_748_3 * (utf8.len(var_748_5) / 11)) > 0 and var_748_3 < var_748_7 then
					arg_745_1.talkMaxDuration = var_748_7

					if var_748_7 + var_748_2 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_7 + var_748_2
					end
				end

				arg_745_1.text_.text = var_748_5
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905182", "story_v_side_new_1103905.awb") ~= 0 then
					local var_748_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905182", "story_v_side_new_1103905.awb") / 1000

					if var_748_8 + var_748_2 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_8 + var_748_2
					end

					if var_748_4.prefab_name ~= "" and arg_745_1.actors_[var_748_4.prefab_name] ~= nil then
						local var_748_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_745_1.actors_[var_748_4.prefab_name].transform, "story_v_side_new_1103905", "1103905182", "story_v_side_new_1103905.awb")

						arg_745_1:RecordAudio("1103905182", var_748_9)
						arg_745_1:RecordAudio("1103905182", var_748_9)
					else
						arg_745_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905182", "story_v_side_new_1103905.awb")
					end

					arg_745_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905182", "story_v_side_new_1103905.awb")
				end

				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_10 = math.max(var_748_3, arg_745_1.talkMaxDuration)

			if var_748_2 <= arg_745_1.time_ and arg_745_1.time_ < var_748_2 + var_748_10 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_2) / var_748_10

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_2 + var_748_10 and arg_745_1.time_ < var_748_2 + var_748_10 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play1103905183 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 1103905183
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play1103905186(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			if 0 < arg_749_1.time_ and arg_749_1.time_ <= 0 + arg_752_0 and not isNil(arg_749_1.actors_["1039ui_story"]) and arg_749_1.var_.characterEffect1039ui_story == nil then
				arg_749_1.var_.characterEffect1039ui_story = arg_749_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_752_0 = 0.200000002980232

			if 0 <= arg_749_1.time_ and arg_749_1.time_ < 0 + var_752_0 and not isNil(arg_749_1.actors_["1039ui_story"]) then
				if arg_749_1.var_.characterEffect1039ui_story and not isNil(arg_749_1.actors_["1039ui_story"]) then
					arg_749_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_749_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_749_1.time_ - 0) / var_752_0)
				end
			end

			if arg_749_1.time_ >= 0 + var_752_0 and arg_749_1.time_ < 0 + var_752_0 + arg_752_0 and not isNil(arg_749_1.actors_["1039ui_story"]) and arg_749_1.var_.characterEffect1039ui_story then
				arg_749_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_749_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_752_1 = 0
			local var_752_2 = 0.675

			if 0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_1 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				arg_749_1.leftNameTxt_.text = arg_749_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, true)
				arg_749_1.iconController_:SetSelectedState("hero")

				arg_749_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_749_1.callingController_:SetSelectedState("normal")

				arg_749_1.keyicon_.color = Color.New(1, 1, 1)
				arg_749_1.icon_.color = Color.New(1, 1, 1)

				local var_752_3 = arg_749_1:FormatText(arg_749_1:GetWordFromCfg(1103905183).content)

				arg_749_1.text_.text = var_752_3

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_5 = 27 <= 0 and var_752_2 or var_752_2 * (utf8.len(var_752_3) / 27)

				if (27 <= 0 and var_752_2 or var_752_2 * (utf8.len(var_752_3) / 27)) > 0 and var_752_2 < var_752_5 then
					arg_749_1.talkMaxDuration = var_752_5

					if var_752_5 + var_752_1 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_5 + var_752_1
					end
				end

				arg_749_1.text_.text = var_752_3
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_6 = math.max(var_752_2, arg_749_1.talkMaxDuration)

			if var_752_1 <= arg_749_1.time_ and arg_749_1.time_ < var_752_1 + var_752_6 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_1) / var_752_6

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_1 + var_752_6 and arg_749_1.time_ < var_752_1 + var_752_6 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play1103905186 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 1103905186
		arg_753_1.duration_ = 5

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play1103905187(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = 0.125

			if 0 < arg_753_1.time_ and arg_753_1.time_ <= 0 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				arg_753_1.leftNameTxt_.text = arg_753_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, true)
				arg_753_1.iconController_:SetSelectedState("hero")

				arg_753_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_753_1.callingController_:SetSelectedState("normal")

				arg_753_1.keyicon_.color = Color.New(1, 1, 1)
				arg_753_1.icon_.color = Color.New(1, 1, 1)

				local var_756_1 = arg_753_1:FormatText(arg_753_1:GetWordFromCfg(1103905186).content)

				arg_753_1.text_.text = var_756_1

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_3 = 5 <= 0 and var_756_0 or var_756_0 * (utf8.len(var_756_1) / 5)

				if (5 <= 0 and var_756_0 or var_756_0 * (utf8.len(var_756_1) / 5)) > 0 and var_756_0 < var_756_3 then
					arg_753_1.talkMaxDuration = var_756_3

					if var_756_3 + 0 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_3 + 0
					end
				end

				arg_753_1.text_.text = var_756_1
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)
				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_4 = math.max(var_756_0, arg_753_1.talkMaxDuration)

			if 0 <= arg_753_1.time_ and arg_753_1.time_ < 0 + var_756_4 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - 0) / var_756_4

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= 0 + var_756_4 and arg_753_1.time_ < 0 + var_756_4 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play1103905187 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 1103905187
		arg_757_1.duration_ = 5

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play1103905188(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = 0.9

			if 0 < arg_757_1.time_ and arg_757_1.time_ <= 0 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, false)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_1 = arg_757_1:FormatText(arg_757_1:GetWordFromCfg(1103905187).content)

				arg_757_1.text_.text = var_760_1

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_3 = 36 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_1) / 36)

				if (36 <= 0 and var_760_0 or var_760_0 * (utf8.len(var_760_1) / 36)) > 0 and var_760_0 < var_760_3 then
					arg_757_1.talkMaxDuration = var_760_3

					if var_760_3 + 0 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_3 + 0
					end
				end

				arg_757_1.text_.text = var_760_1
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)
				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_4 = math.max(var_760_0, arg_757_1.talkMaxDuration)

			if 0 <= arg_757_1.time_ and arg_757_1.time_ < 0 + var_760_4 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - 0) / var_760_4

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= 0 + var_760_4 and arg_757_1.time_ < 0 + var_760_4 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {}

		arg_757_1:InitPlayNodeList()
	end,
	Play1103905188 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 1103905188
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play1103905189(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			local var_764_0 = 0.625

			if 0 < arg_761_1.time_ and arg_761_1.time_ <= 0 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				arg_761_1.leftNameTxt_.text = arg_761_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, true)
				arg_761_1.iconController_:SetSelectedState("hero")

				arg_761_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_761_1.callingController_:SetSelectedState("normal")

				arg_761_1.keyicon_.color = Color.New(1, 1, 1)
				arg_761_1.icon_.color = Color.New(1, 1, 1)

				local var_764_1 = arg_761_1:FormatText(arg_761_1:GetWordFromCfg(1103905188).content)

				arg_761_1.text_.text = var_764_1

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_3 = 25 <= 0 and var_764_0 or var_764_0 * (utf8.len(var_764_1) / 25)

				if (25 <= 0 and var_764_0 or var_764_0 * (utf8.len(var_764_1) / 25)) > 0 and var_764_0 < var_764_3 then
					arg_761_1.talkMaxDuration = var_764_3

					if var_764_3 + 0 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_3 + 0
					end
				end

				arg_761_1.text_.text = var_764_1
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_4 = math.max(var_764_0, arg_761_1.talkMaxDuration)

			if 0 <= arg_761_1.time_ and arg_761_1.time_ < 0 + var_764_4 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - 0) / var_764_4

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= 0 + var_764_4 and arg_761_1.time_ < 0 + var_764_4 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play1103905189 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 1103905189
		arg_765_1.duration_ = 5

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play1103905190(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			local var_768_0 = 0.65

			if 0 < arg_765_1.time_ and arg_765_1.time_ <= 0 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				arg_765_1.leftNameTxt_.text = arg_765_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, true)
				arg_765_1.iconController_:SetSelectedState("hero")

				arg_765_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_765_1.callingController_:SetSelectedState("normal")

				arg_765_1.keyicon_.color = Color.New(1, 1, 1)
				arg_765_1.icon_.color = Color.New(1, 1, 1)

				local var_768_1 = arg_765_1:FormatText(arg_765_1:GetWordFromCfg(1103905189).content)

				arg_765_1.text_.text = var_768_1

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_3 = 26 <= 0 and var_768_0 or var_768_0 * (utf8.len(var_768_1) / 26)

				if (26 <= 0 and var_768_0 or var_768_0 * (utf8.len(var_768_1) / 26)) > 0 and var_768_0 < var_768_3 then
					arg_765_1.talkMaxDuration = var_768_3

					if var_768_3 + 0 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_3 + 0
					end
				end

				arg_765_1.text_.text = var_768_1
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)
				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_4 = math.max(var_768_0, arg_765_1.talkMaxDuration)

			if 0 <= arg_765_1.time_ and arg_765_1.time_ < 0 + var_768_4 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - 0) / var_768_4

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= 0 + var_768_4 and arg_765_1.time_ < 0 + var_768_4 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {}

		arg_765_1:InitPlayNodeList()
	end,
	Play1103905190 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 1103905190
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play1103905191(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			local var_772_0 = 0.825

			if 0 < arg_769_1.time_ and arg_769_1.time_ <= 0 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, false)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_1 = arg_769_1:FormatText(arg_769_1:GetWordFromCfg(1103905190).content)

				arg_769_1.text_.text = var_772_1

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_3 = 33 <= 0 and var_772_0 or var_772_0 * (utf8.len(var_772_1) / 33)

				if (33 <= 0 and var_772_0 or var_772_0 * (utf8.len(var_772_1) / 33)) > 0 and var_772_0 < var_772_3 then
					arg_769_1.talkMaxDuration = var_772_3

					if var_772_3 + 0 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_3 + 0
					end
				end

				arg_769_1.text_.text = var_772_1
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)
				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_4 = math.max(var_772_0, arg_769_1.talkMaxDuration)

			if 0 <= arg_769_1.time_ and arg_769_1.time_ < 0 + var_772_4 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - 0) / var_772_4

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= 0 + var_772_4 and arg_769_1.time_ < 0 + var_772_4 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {}

		arg_769_1:InitPlayNodeList()
	end,
	Play1103905191 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 1103905191
		arg_773_1.duration_ = 4.07

		local var_773_0 = {
			zh = 3.066,
			ja = 4.066
		}
		local var_773_1 = manager.audio:GetLocalizationFlag()

		if var_773_0[var_773_1] ~= nil then
			arg_773_1.duration_ = var_773_0[var_773_1]
		end

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play1103905192(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 and not isNil(arg_773_1.actors_["1039ui_story"]) and arg_773_1.var_.characterEffect1039ui_story == nil then
				arg_773_1.var_.characterEffect1039ui_story = arg_773_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_776_0 = 0.200000002980232

			if 0 <= arg_773_1.time_ and arg_773_1.time_ < 0 + var_776_0 and not isNil(arg_773_1.actors_["1039ui_story"]) then
				if arg_773_1.var_.characterEffect1039ui_story and not isNil(arg_773_1.actors_["1039ui_story"]) then
					arg_773_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_773_1.time_ >= 0 + var_776_0 and arg_773_1.time_ < 0 + var_776_0 + arg_776_0 and not isNil(arg_773_1.actors_["1039ui_story"]) and arg_773_1.var_.characterEffect1039ui_story then
				arg_773_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= 0 + arg_776_0 then
				arg_773_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_776_2 = 0
			local var_776_3 = 0.125

			if 0 < arg_773_1.time_ and arg_773_1.time_ <= var_776_2 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, true)

				arg_773_1.leftNameTxt_.text = arg_773_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_773_1.leftNameTxt_.transform)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1.leftNameTxt_.text)
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_4 = arg_773_1:GetWordFromCfg(1103905191)
				local var_776_5 = arg_773_1:FormatText(var_776_4.content)

				arg_773_1.text_.text = var_776_5

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_7 = 5 <= 0 and var_776_3 or var_776_3 * (utf8.len(var_776_5) / 5)

				if (5 <= 0 and var_776_3 or var_776_3 * (utf8.len(var_776_5) / 5)) > 0 and var_776_3 < var_776_7 then
					arg_773_1.talkMaxDuration = var_776_7

					if var_776_7 + var_776_2 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_7 + var_776_2
					end
				end

				arg_773_1.text_.text = var_776_5
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905191", "story_v_side_new_1103905.awb") ~= 0 then
					local var_776_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905191", "story_v_side_new_1103905.awb") / 1000

					if var_776_8 + var_776_2 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_8 + var_776_2
					end

					if var_776_4.prefab_name ~= "" and arg_773_1.actors_[var_776_4.prefab_name] ~= nil then
						local var_776_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_773_1.actors_[var_776_4.prefab_name].transform, "story_v_side_new_1103905", "1103905191", "story_v_side_new_1103905.awb")

						arg_773_1:RecordAudio("1103905191", var_776_9)
						arg_773_1:RecordAudio("1103905191", var_776_9)
					else
						arg_773_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905191", "story_v_side_new_1103905.awb")
					end

					arg_773_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905191", "story_v_side_new_1103905.awb")
				end

				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_10 = math.max(var_776_3, arg_773_1.talkMaxDuration)

			if var_776_2 <= arg_773_1.time_ and arg_773_1.time_ < var_776_2 + var_776_10 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_2) / var_776_10

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_2 + var_776_10 and arg_773_1.time_ < var_776_2 + var_776_10 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	Play1103905192 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 1103905192
		arg_777_1.duration_ = 5

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play1103905193(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			if 0 < arg_777_1.time_ and arg_777_1.time_ <= 0 + arg_780_0 and not isNil(arg_777_1.actors_["1039ui_story"]) and arg_777_1.var_.characterEffect1039ui_story == nil then
				arg_777_1.var_.characterEffect1039ui_story = arg_777_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_780_0 = 0.200000002980232

			if 0 <= arg_777_1.time_ and arg_777_1.time_ < 0 + var_780_0 and not isNil(arg_777_1.actors_["1039ui_story"]) then
				if arg_777_1.var_.characterEffect1039ui_story and not isNil(arg_777_1.actors_["1039ui_story"]) then
					arg_777_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_777_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_777_1.time_ - 0) / var_780_0)
				end
			end

			if arg_777_1.time_ >= 0 + var_780_0 and arg_777_1.time_ < 0 + var_780_0 + arg_780_0 and not isNil(arg_777_1.actors_["1039ui_story"]) and arg_777_1.var_.characterEffect1039ui_story then
				arg_777_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_777_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_780_1 = 0
			local var_780_2 = 0.675

			if 0 < arg_777_1.time_ and arg_777_1.time_ <= var_780_1 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				arg_777_1.leftNameTxt_.text = arg_777_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_3 = arg_777_1:FormatText(arg_777_1:GetWordFromCfg(1103905192).content)

				arg_777_1.text_.text = var_780_3

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_5 = 27 <= 0 and var_780_2 or var_780_2 * (utf8.len(var_780_3) / 27)

				if (27 <= 0 and var_780_2 or var_780_2 * (utf8.len(var_780_3) / 27)) > 0 and var_780_2 < var_780_5 then
					arg_777_1.talkMaxDuration = var_780_5

					if var_780_5 + var_780_1 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_5 + var_780_1
					end
				end

				arg_777_1.text_.text = var_780_3
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)
				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_6 = math.max(var_780_2, arg_777_1.talkMaxDuration)

			if var_780_1 <= arg_777_1.time_ and arg_777_1.time_ < var_780_1 + var_780_6 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_1) / var_780_6

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_1 + var_780_6 and arg_777_1.time_ < var_780_1 + var_780_6 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play1103905193 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 1103905193
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play1103905194(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = 1.15

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

				local var_784_1 = arg_781_1:FormatText(arg_781_1:GetWordFromCfg(1103905193).content)

				arg_781_1.text_.text = var_784_1

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_3 = 46 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 46)

				if (46 <= 0 and var_784_0 or var_784_0 * (utf8.len(var_784_1) / 46)) > 0 and var_784_0 < var_784_3 then
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
	Play1103905194 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 1103905194
		arg_785_1.duration_ = 5

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play1103905195(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			local var_788_0 = 0.7

			if 0 < arg_785_1.time_ and arg_785_1.time_ <= 0 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				arg_785_1.leftNameTxt_.text = arg_785_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, true)
				arg_785_1.iconController_:SetSelectedState("hero")

				arg_785_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_785_1.callingController_:SetSelectedState("normal")

				arg_785_1.keyicon_.color = Color.New(1, 1, 1)
				arg_785_1.icon_.color = Color.New(1, 1, 1)

				local var_788_1 = arg_785_1:FormatText(arg_785_1:GetWordFromCfg(1103905194).content)

				arg_785_1.text_.text = var_788_1

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_3 = 28 <= 0 and var_788_0 or var_788_0 * (utf8.len(var_788_1) / 28)

				if (28 <= 0 and var_788_0 or var_788_0 * (utf8.len(var_788_1) / 28)) > 0 and var_788_0 < var_788_3 then
					arg_785_1.talkMaxDuration = var_788_3

					if var_788_3 + 0 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_3 + 0
					end
				end

				arg_785_1.text_.text = var_788_1
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)
				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_4 = math.max(var_788_0, arg_785_1.talkMaxDuration)

			if 0 <= arg_785_1.time_ and arg_785_1.time_ < 0 + var_788_4 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - 0) / var_788_4

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= 0 + var_788_4 and arg_785_1.time_ < 0 + var_788_4 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {}

		arg_785_1:InitPlayNodeList()
	end,
	Play1103905195 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 1103905195
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play1103905196(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			local var_792_0 = 0.475

			if 0 < arg_789_1.time_ and arg_789_1.time_ <= 0 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, true)

				arg_789_1.leftNameTxt_.text = arg_789_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_789_1.leftNameTxt_.transform)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1.leftNameTxt_.text)
				SetActive(arg_789_1.iconTrs_.gameObject, true)
				arg_789_1.iconController_:SetSelectedState("hero")

				arg_789_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_789_1.callingController_:SetSelectedState("normal")

				arg_789_1.keyicon_.color = Color.New(1, 1, 1)
				arg_789_1.icon_.color = Color.New(1, 1, 1)

				local var_792_1 = arg_789_1:FormatText(arg_789_1:GetWordFromCfg(1103905195).content)

				arg_789_1.text_.text = var_792_1

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_3 = 19 <= 0 and var_792_0 or var_792_0 * (utf8.len(var_792_1) / 19)

				if (19 <= 0 and var_792_0 or var_792_0 * (utf8.len(var_792_1) / 19)) > 0 and var_792_0 < var_792_3 then
					arg_789_1.talkMaxDuration = var_792_3

					if var_792_3 + 0 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_3 + 0
					end
				end

				arg_789_1.text_.text = var_792_1
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_4 = math.max(var_792_0, arg_789_1.talkMaxDuration)

			if 0 <= arg_789_1.time_ and arg_789_1.time_ < 0 + var_792_4 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - 0) / var_792_4

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= 0 + var_792_4 and arg_789_1.time_ < 0 + var_792_4 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {}

		arg_789_1:InitPlayNodeList()
	end,
	Play1103905196 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 1103905196
		arg_793_1.duration_ = 3.23

		local var_793_0 = {
			zh = 3.233,
			ja = 1.999999999999
		}
		local var_793_1 = manager.audio:GetLocalizationFlag()

		if var_793_0[var_793_1] ~= nil then
			arg_793_1.duration_ = var_793_0[var_793_1]
		end

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play1103905197(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 and not isNil(arg_793_1.actors_["1039ui_story"]) and arg_793_1.var_.characterEffect1039ui_story == nil then
				arg_793_1.var_.characterEffect1039ui_story = arg_793_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_796_0 = 0.200000002980232

			if 0 <= arg_793_1.time_ and arg_793_1.time_ < 0 + var_796_0 and not isNil(arg_793_1.actors_["1039ui_story"]) then
				if arg_793_1.var_.characterEffect1039ui_story and not isNil(arg_793_1.actors_["1039ui_story"]) then
					arg_793_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_793_1.time_ >= 0 + var_796_0 and arg_793_1.time_ < 0 + var_796_0 + arg_796_0 and not isNil(arg_793_1.actors_["1039ui_story"]) and arg_793_1.var_.characterEffect1039ui_story then
				arg_793_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 then
				arg_793_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_2")
			end

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= 0 + arg_796_0 then
				arg_793_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1048/story1048lipsync/1048201101cva")
			end

			local var_796_2 = 0
			local var_796_3 = 0.175

			if 0 < arg_793_1.time_ and arg_793_1.time_ <= var_796_2 + arg_796_0 then
				arg_793_1.talkMaxDuration = 0
				arg_793_1.dialogCg_.alpha = 1

				arg_793_1.dialog_:SetActive(true)
				SetActive(arg_793_1.leftNameGo_, true)

				arg_793_1.leftNameTxt_.text = arg_793_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_793_1.leftNameTxt_.transform)

				arg_793_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_793_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_793_1:RecordName(arg_793_1.leftNameTxt_.text)
				SetActive(arg_793_1.iconTrs_.gameObject, false)
				arg_793_1.callingController_:SetSelectedState("normal")

				local var_796_4 = arg_793_1:GetWordFromCfg(1103905196)
				local var_796_5 = arg_793_1:FormatText(var_796_4.content)

				arg_793_1.text_.text = var_796_5

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_7 = 7 <= 0 and var_796_3 or var_796_3 * (utf8.len(var_796_5) / 7)

				if (7 <= 0 and var_796_3 or var_796_3 * (utf8.len(var_796_5) / 7)) > 0 and var_796_3 < var_796_7 then
					arg_793_1.talkMaxDuration = var_796_7

					if var_796_7 + var_796_2 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_7 + var_796_2
					end
				end

				arg_793_1.text_.text = var_796_5
				arg_793_1.typewritter.percent = 0

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905196", "story_v_side_new_1103905.awb") ~= 0 then
					local var_796_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905196", "story_v_side_new_1103905.awb") / 1000

					if var_796_8 + var_796_2 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_8 + var_796_2
					end

					if var_796_4.prefab_name ~= "" and arg_793_1.actors_[var_796_4.prefab_name] ~= nil then
						local var_796_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_793_1.actors_[var_796_4.prefab_name].transform, "story_v_side_new_1103905", "1103905196", "story_v_side_new_1103905.awb")

						arg_793_1:RecordAudio("1103905196", var_796_9)
						arg_793_1:RecordAudio("1103905196", var_796_9)
					else
						arg_793_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905196", "story_v_side_new_1103905.awb")
					end

					arg_793_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905196", "story_v_side_new_1103905.awb")
				end

				arg_793_1:RecordContent(arg_793_1.text_.text)
			end

			local var_796_10 = math.max(var_796_3, arg_793_1.talkMaxDuration)

			if var_796_2 <= arg_793_1.time_ and arg_793_1.time_ < var_796_2 + var_796_10 then
				arg_793_1.typewritter.percent = (arg_793_1.time_ - var_796_2) / var_796_10

				arg_793_1.typewritter:SetDirty()
			end

			if arg_793_1.time_ >= var_796_2 + var_796_10 and arg_793_1.time_ < var_796_2 + var_796_10 + arg_796_0 then
				arg_793_1.typewritter.percent = 1

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(true)
			end
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play1103905197 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 1103905197
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play1103905198(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			if 0 < arg_797_1.time_ and arg_797_1.time_ <= 0 + arg_800_0 and not isNil(arg_797_1.actors_["1039ui_story"]) and arg_797_1.var_.characterEffect1039ui_story == nil then
				arg_797_1.var_.characterEffect1039ui_story = arg_797_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_800_0 = 0.200000002980232

			if 0 <= arg_797_1.time_ and arg_797_1.time_ < 0 + var_800_0 and not isNil(arg_797_1.actors_["1039ui_story"]) then
				if arg_797_1.var_.characterEffect1039ui_story and not isNil(arg_797_1.actors_["1039ui_story"]) then
					arg_797_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_797_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_797_1.time_ - 0) / var_800_0)
				end
			end

			if arg_797_1.time_ >= 0 + var_800_0 and arg_797_1.time_ < 0 + var_800_0 + arg_800_0 and not isNil(arg_797_1.actors_["1039ui_story"]) and arg_797_1.var_.characterEffect1039ui_story then
				arg_797_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_797_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_800_1 = 0
			local var_800_2 = 0.6

			if 0 < arg_797_1.time_ and arg_797_1.time_ <= var_800_1 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, false)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_797_1.iconTrs_.gameObject, false)
				arg_797_1.callingController_:SetSelectedState("normal")

				local var_800_3 = arg_797_1:FormatText(arg_797_1:GetWordFromCfg(1103905197).content)

				arg_797_1.text_.text = var_800_3

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_5 = 24 <= 0 and var_800_2 or var_800_2 * (utf8.len(var_800_3) / 24)

				if (24 <= 0 and var_800_2 or var_800_2 * (utf8.len(var_800_3) / 24)) > 0 and var_800_2 < var_800_5 then
					arg_797_1.talkMaxDuration = var_800_5

					if var_800_5 + var_800_1 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_5 + var_800_1
					end
				end

				arg_797_1.text_.text = var_800_3
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_6 = math.max(var_800_2, arg_797_1.talkMaxDuration)

			if var_800_1 <= arg_797_1.time_ and arg_797_1.time_ < var_800_1 + var_800_6 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_1) / var_800_6

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_1 + var_800_6 and arg_797_1.time_ < var_800_1 + var_800_6 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play1103905198 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 1103905198
		arg_801_1.duration_ = 10.33

		local var_801_0 = {
			zh = 3.5,
			ja = 10.333
		}
		local var_801_1 = manager.audio:GetLocalizationFlag()

		if var_801_0[var_801_1] ~= nil then
			arg_801_1.duration_ = var_801_0[var_801_1]
		end

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
			arg_801_1.auto_ = false
		end

		function arg_801_1.playNext_(arg_803_0)
			arg_801_1.onStoryFinished_()
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 and not isNil(arg_801_1.actors_["1039ui_story"]) and arg_801_1.var_.characterEffect1039ui_story == nil then
				arg_801_1.var_.characterEffect1039ui_story = arg_801_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_804_0 = 0.200000002980232

			if 0 <= arg_801_1.time_ and arg_801_1.time_ < 0 + var_804_0 and not isNil(arg_801_1.actors_["1039ui_story"]) then
				if arg_801_1.var_.characterEffect1039ui_story and not isNil(arg_801_1.actors_["1039ui_story"]) then
					arg_801_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_801_1.time_ >= 0 + var_804_0 and arg_801_1.time_ < 0 + var_804_0 + arg_804_0 and not isNil(arg_801_1.actors_["1039ui_story"]) and arg_801_1.var_.characterEffect1039ui_story then
				arg_801_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 then
				arg_801_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= 0 + arg_804_0 then
				arg_801_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_804_2 = 0
			local var_804_3 = 0.45

			if 0 < arg_801_1.time_ and arg_801_1.time_ <= var_804_2 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				arg_801_1.leftNameTxt_.text = arg_801_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, false)
				arg_801_1.callingController_:SetSelectedState("normal")

				local var_804_4 = arg_801_1:GetWordFromCfg(1103905198)
				local var_804_5 = arg_801_1:FormatText(var_804_4.content)

				arg_801_1.text_.text = var_804_5

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_7 = 18 <= 0 and var_804_3 or var_804_3 * (utf8.len(var_804_5) / 18)

				if (18 <= 0 and var_804_3 or var_804_3 * (utf8.len(var_804_5) / 18)) > 0 and var_804_3 < var_804_7 then
					arg_801_1.talkMaxDuration = var_804_7

					if var_804_7 + var_804_2 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_7 + var_804_2
					end
				end

				arg_801_1.text_.text = var_804_5
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905198", "story_v_side_new_1103905.awb") ~= 0 then
					local var_804_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905198", "story_v_side_new_1103905.awb") / 1000

					if var_804_8 + var_804_2 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_8 + var_804_2
					end

					if var_804_4.prefab_name ~= "" and arg_801_1.actors_[var_804_4.prefab_name] ~= nil then
						local var_804_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_801_1.actors_[var_804_4.prefab_name].transform, "story_v_side_new_1103905", "1103905198", "story_v_side_new_1103905.awb")

						arg_801_1:RecordAudio("1103905198", var_804_9)
						arg_801_1:RecordAudio("1103905198", var_804_9)
					else
						arg_801_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905198", "story_v_side_new_1103905.awb")
					end

					arg_801_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905198", "story_v_side_new_1103905.awb")
				end

				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_10 = math.max(var_804_3, arg_801_1.talkMaxDuration)

			if var_804_2 <= arg_801_1.time_ and arg_801_1.time_ < var_804_2 + var_804_10 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_2) / var_804_10

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_2 + var_804_10 and arg_801_1.time_ < var_804_2 + var_804_10 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play1103905184 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 1103905184
		arg_805_1.duration_ = 4.7

		local var_805_0 = {
			zh = 2.9,
			ja = 4.7
		}
		local var_805_1 = manager.audio:GetLocalizationFlag()

		if var_805_0[var_805_1] ~= nil then
			arg_805_1.duration_ = var_805_0[var_805_1]
		end

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play1103905185(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			if 0 < arg_805_1.time_ and arg_805_1.time_ <= 0 + arg_808_0 and not isNil(arg_805_1.actors_["1039ui_story"]) and arg_805_1.var_.characterEffect1039ui_story == nil then
				arg_805_1.var_.characterEffect1039ui_story = arg_805_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_808_0 = 0.200000002980232

			if 0 <= arg_805_1.time_ and arg_805_1.time_ < 0 + var_808_0 and not isNil(arg_805_1.actors_["1039ui_story"]) then
				if arg_805_1.var_.characterEffect1039ui_story and not isNil(arg_805_1.actors_["1039ui_story"]) then
					arg_805_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_805_1.time_ >= 0 + var_808_0 and arg_805_1.time_ < 0 + var_808_0 + arg_808_0 and not isNil(arg_805_1.actors_["1039ui_story"]) and arg_805_1.var_.characterEffect1039ui_story then
				arg_805_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_808_2 = 0
			local var_808_3 = 0.3

			if 0 < arg_805_1.time_ and arg_805_1.time_ <= var_808_2 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				arg_805_1.leftNameTxt_.text = arg_805_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, false)
				arg_805_1.callingController_:SetSelectedState("normal")

				local var_808_4 = arg_805_1:GetWordFromCfg(1103905184)
				local var_808_5 = arg_805_1:FormatText(var_808_4.content)

				arg_805_1.text_.text = var_808_5

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_7 = 12 <= 0 and var_808_3 or var_808_3 * (utf8.len(var_808_5) / 12)

				if (12 <= 0 and var_808_3 or var_808_3 * (utf8.len(var_808_5) / 12)) > 0 and var_808_3 < var_808_7 then
					arg_805_1.talkMaxDuration = var_808_7

					if var_808_7 + var_808_2 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_7 + var_808_2
					end
				end

				arg_805_1.text_.text = var_808_5
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905184", "story_v_side_new_1103905.awb") ~= 0 then
					local var_808_8 = manager.audio:GetVoiceLength("story_v_side_new_1103905", "1103905184", "story_v_side_new_1103905.awb") / 1000

					if var_808_8 + var_808_2 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_8 + var_808_2
					end

					if var_808_4.prefab_name ~= "" and arg_805_1.actors_[var_808_4.prefab_name] ~= nil then
						local var_808_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_805_1.actors_[var_808_4.prefab_name].transform, "story_v_side_new_1103905", "1103905184", "story_v_side_new_1103905.awb")

						arg_805_1:RecordAudio("1103905184", var_808_9)
						arg_805_1:RecordAudio("1103905184", var_808_9)
					else
						arg_805_1:AudioAction("play", "voice", "story_v_side_new_1103905", "1103905184", "story_v_side_new_1103905.awb")
					end

					arg_805_1:RecordHistoryTalkVoice("story_v_side_new_1103905", "1103905184", "story_v_side_new_1103905.awb")
				end

				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_10 = math.max(var_808_3, arg_805_1.talkMaxDuration)

			if var_808_2 <= arg_805_1.time_ and arg_805_1.time_ < var_808_2 + var_808_10 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_2) / var_808_10

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_2 + var_808_10 and arg_805_1.time_ < var_808_2 + var_808_10 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {}

		arg_805_1:InitPlayNodeList()
	end,
	Play1103905185 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 1103905185
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play1103905186(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			if 0 < arg_809_1.time_ and arg_809_1.time_ <= 0 + arg_812_0 and not isNil(arg_809_1.actors_["1039ui_story"]) and arg_809_1.var_.characterEffect1039ui_story == nil then
				arg_809_1.var_.characterEffect1039ui_story = arg_809_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_812_0 = 0.200000002980232

			if 0 <= arg_809_1.time_ and arg_809_1.time_ < 0 + var_812_0 and not isNil(arg_809_1.actors_["1039ui_story"]) then
				if arg_809_1.var_.characterEffect1039ui_story and not isNil(arg_809_1.actors_["1039ui_story"]) then
					arg_809_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_809_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_809_1.time_ - 0) / var_812_0)
				end
			end

			if arg_809_1.time_ >= 0 + var_812_0 and arg_809_1.time_ < 0 + var_812_0 + arg_812_0 and not isNil(arg_809_1.actors_["1039ui_story"]) and arg_809_1.var_.characterEffect1039ui_story then
				arg_809_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_809_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_812_1 = 0
			local var_812_2 = 0.35

			if 0 < arg_809_1.time_ and arg_809_1.time_ <= var_812_1 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				arg_809_1.leftNameTxt_.text = arg_809_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, true)
				arg_809_1.iconController_:SetSelectedState("hero")

				arg_809_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_809_1.callingController_:SetSelectedState("normal")

				arg_809_1.keyicon_.color = Color.New(1, 1, 1)
				arg_809_1.icon_.color = Color.New(1, 1, 1)

				local var_812_3 = arg_809_1:FormatText(arg_809_1:GetWordFromCfg(1103905185).content)

				arg_809_1.text_.text = var_812_3

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_5 = 14 <= 0 and var_812_2 or var_812_2 * (utf8.len(var_812_3) / 14)

				if (14 <= 0 and var_812_2 or var_812_2 * (utf8.len(var_812_3) / 14)) > 0 and var_812_2 < var_812_5 then
					arg_809_1.talkMaxDuration = var_812_5

					if var_812_5 + var_812_1 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_5 + var_812_1
					end
				end

				arg_809_1.text_.text = var_812_3
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_6 = math.max(var_812_2, arg_809_1.talkMaxDuration)

			if var_812_1 <= arg_809_1.time_ and arg_809_1.time_ < var_812_1 + var_812_6 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - var_812_1) / var_812_6

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= var_812_1 + var_812_6 and arg_809_1.time_ < var_812_1 + var_812_6 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {}

		arg_809_1:InitPlayNodeList()
	end,
	Play1103905174 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 1103905174
		arg_813_1.duration_ = 5

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play1103905175(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			if 0 < arg_813_1.time_ and arg_813_1.time_ <= 0 + arg_816_0 and not isNil(arg_813_1.actors_["1039ui_story"]) and arg_813_1.var_.characterEffect1039ui_story == nil then
				arg_813_1.var_.characterEffect1039ui_story = arg_813_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_816_0 = 0.200000002980232

			if 0 <= arg_813_1.time_ and arg_813_1.time_ < 0 + var_816_0 and not isNil(arg_813_1.actors_["1039ui_story"]) then
				if arg_813_1.var_.characterEffect1039ui_story and not isNil(arg_813_1.actors_["1039ui_story"]) then
					arg_813_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_813_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_813_1.time_ - 0) / var_816_0)
				end
			end

			if arg_813_1.time_ >= 0 + var_816_0 and arg_813_1.time_ < 0 + var_816_0 + arg_816_0 and not isNil(arg_813_1.actors_["1039ui_story"]) and arg_813_1.var_.characterEffect1039ui_story then
				arg_813_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_813_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_816_1 = 0
			local var_816_2 = 0.65

			if 0 < arg_813_1.time_ and arg_813_1.time_ <= var_816_1 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				arg_813_1.leftNameTxt_.text = arg_813_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, true)
				arg_813_1.iconController_:SetSelectedState("hero")

				arg_813_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_813_1.callingController_:SetSelectedState("normal")

				arg_813_1.keyicon_.color = Color.New(1, 1, 1)
				arg_813_1.icon_.color = Color.New(1, 1, 1)

				local var_816_3 = arg_813_1:FormatText(arg_813_1:GetWordFromCfg(1103905174).content)

				arg_813_1.text_.text = var_816_3

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_5 = 26 <= 0 and var_816_2 or var_816_2 * (utf8.len(var_816_3) / 26)

				if (26 <= 0 and var_816_2 or var_816_2 * (utf8.len(var_816_3) / 26)) > 0 and var_816_2 < var_816_5 then
					arg_813_1.talkMaxDuration = var_816_5

					if var_816_5 + var_816_1 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_5 + var_816_1
					end
				end

				arg_813_1.text_.text = var_816_3
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)
				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_6 = math.max(var_816_2, arg_813_1.talkMaxDuration)

			if var_816_1 <= arg_813_1.time_ and arg_813_1.time_ < var_816_1 + var_816_6 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - var_816_1) / var_816_6

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= var_816_1 + var_816_6 and arg_813_1.time_ < var_816_1 + var_816_6 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {}

		arg_813_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST15a"
	},
	voices = {
		"story_v_side_new_1103905.awb"
	}
}
