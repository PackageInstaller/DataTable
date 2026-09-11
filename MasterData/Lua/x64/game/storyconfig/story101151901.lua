return {
	Play115191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115191001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.G02b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "G02b")
				var_4_0.name = "G02b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.G02b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.G02b

				arg_1_1.bgs_.G02b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "G02b" then
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_1_5_story_1", "bgm_activity_1_5_story_1")

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(115191001).content)

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
	Play115191002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115191002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play115191003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 1.45

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(115191002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 58 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 58)

				if (58 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 58)) > 0 and var_12_0 < var_12_3 then
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
	Play115191003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115191003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115191004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.85

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(115191003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)

				if (34 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 34)) > 0 and var_16_0 < var_16_3 then
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
	Play115191004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115191004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115191005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1017ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1017ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1017ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1017ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1017ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1017ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1017ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1017ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			local var_20_3 = arg_17_1.actors_["1017ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1017ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1017ui_story, Vector3.New(0, -1.01, -6.05), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.01, -6.05)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_5 = arg_17_1.actors_["1017ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1017ui_story == nil then
				arg_17_1.var_.characterEffect1017ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1017ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1017ui_story then
				arg_17_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_20_8 = 0
			local var_20_9 = 0.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(115191004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 3 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 3)

				if (3 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 3)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191004", "story_v_out_115191.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_115191", "115191004", "story_v_out_115191.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_115191", "115191004", "story_v_out_115191.awb")

						arg_17_1:RecordAudio("115191004", var_20_15)
						arg_17_1:RecordAudio("115191004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115191", "115191004", "story_v_out_115191.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115191", "115191004", "story_v_out_115191.awb")
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
				actorName = "1017ui_story",
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
	Play115191005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115191005
		arg_21_1.duration_ = 3.23

		local var_21_0 = {
			ja = 1.4,
			ko = 1.6,
			zh = 3.233,
			en = 2.166
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
				arg_21_0:Play115191006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1017ui_story"]) and arg_21_1.var_.characterEffect1017ui_story == nil then
				arg_21_1.var_.characterEffect1017ui_story = arg_21_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1017ui_story"]) then
				if arg_21_1.var_.characterEffect1017ui_story and not isNil(arg_21_1.actors_["1017ui_story"]) then
					arg_21_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1017ui_story"]) and arg_21_1.var_.characterEffect1017ui_story then
				arg_21_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.125

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(115191005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 5 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 5)

				if (5 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_4) / 5)) > 0 and var_24_2 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191005", "story_v_out_115191.awb") ~= 0 then
					local var_24_7 = manager.audio:GetVoiceLength("story_v_out_115191", "115191005", "story_v_out_115191.awb") / 1000

					if var_24_7 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_1
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_115191", "115191005", "story_v_out_115191.awb")

						arg_21_1:RecordAudio("115191005", var_24_8)
						arg_21_1:RecordAudio("115191005", var_24_8)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115191", "115191005", "story_v_out_115191.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115191", "115191005", "story_v_out_115191.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_9 and arg_21_1.time_ < var_24_1 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play115191006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 115191006
		arg_25_1.duration_ = 6.1

		local var_25_0 = {
			ja = 6.066,
			ko = 6.1,
			zh = 5.3,
			en = 5.933
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
				arg_25_0:Play115191007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.525

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(115191006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 21 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 21)

				if (21 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 21)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191006", "story_v_out_115191.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_115191", "115191006", "story_v_out_115191.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_115191", "115191006", "story_v_out_115191.awb")

						arg_25_1:RecordAudio("115191006", var_28_6)
						arg_25_1:RecordAudio("115191006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_115191", "115191006", "story_v_out_115191.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_115191", "115191006", "story_v_out_115191.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play115191007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 115191007
		arg_29_1.duration_ = 5.57

		local var_29_0 = {
			ja = 5.566,
			ko = 4.333,
			zh = 3.3,
			en = 3.9
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
				arg_29_0:Play115191008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_2")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_32_0 = arg_29_1.actors_["1017ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1017ui_story == nil then
				arg_29_1.var_.characterEffect1017ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_1 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 and not isNil(var_32_0) then
				if arg_29_1.var_.characterEffect1017ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1017ui_story then
				arg_29_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_32_3 = 0
			local var_32_4 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:GetWordFromCfg(115191007)
				local var_32_6 = arg_29_1:FormatText(var_32_5.content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 20 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_6) / 20)

				if (20 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_6) / 20)) > 0 and var_32_4 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191007", "story_v_out_115191.awb") ~= 0 then
					local var_32_9 = manager.audio:GetVoiceLength("story_v_out_115191", "115191007", "story_v_out_115191.awb") / 1000

					if var_32_9 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_3
					end

					if var_32_5.prefab_name ~= "" and arg_29_1.actors_[var_32_5.prefab_name] ~= nil then
						local var_32_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_5.prefab_name].transform, "story_v_out_115191", "115191007", "story_v_out_115191.awb")

						arg_29_1:RecordAudio("115191007", var_32_10)
						arg_29_1:RecordAudio("115191007", var_32_10)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_115191", "115191007", "story_v_out_115191.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_115191", "115191007", "story_v_out_115191.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_11 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_11 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_11

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_11 and arg_29_1.time_ < var_32_3 + var_32_11 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play115191008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 115191008
		arg_33_1.duration_ = 3.33

		local var_33_0 = {
			ja = 3.333,
			ko = 2.566,
			zh = 2.8,
			en = 3.2
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
				arg_33_0:Play115191009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1017ui_story"]) and arg_33_1.var_.characterEffect1017ui_story == nil then
				arg_33_1.var_.characterEffect1017ui_story = arg_33_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1017ui_story"]) then
				if arg_33_1.var_.characterEffect1017ui_story and not isNil(arg_33_1.actors_["1017ui_story"]) then
					arg_33_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1017ui_story"]) and arg_33_1.var_.characterEffect1017ui_story then
				arg_33_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(115191008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 14 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 14)

				if (14 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_4) / 14)) > 0 and var_36_2 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191008", "story_v_out_115191.awb") ~= 0 then
					local var_36_7 = manager.audio:GetVoiceLength("story_v_out_115191", "115191008", "story_v_out_115191.awb") / 1000

					if var_36_7 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_1
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_115191", "115191008", "story_v_out_115191.awb")

						arg_33_1:RecordAudio("115191008", var_36_8)
						arg_33_1:RecordAudio("115191008", var_36_8)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_115191", "115191008", "story_v_out_115191.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_115191", "115191008", "story_v_out_115191.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_9 and arg_33_1.time_ < var_36_1 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play115191009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 115191009
		arg_37_1.duration_ = 3.67

		local var_37_0 = {
			ja = 3.666,
			ko = 2.1,
			zh = 2,
			en = 1.999999999999
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
				arg_37_0:Play115191010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_40_0 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_37_1.stage_.transform)

				var_40_0.name = "1024ui_story"
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1024ui_story"] = var_40_0

				local var_40_1 = var_40_0:GetComponentInChildren(typeof(CharacterEffect))

				var_40_1.enabled = true

				local var_40_2 = GameObjectTools.GetOrAddComponent(var_40_0, typeof(DynamicBoneHelper))

				if var_40_2 then
					var_40_2:EnableDynamicBone(false)
				end

				arg_37_1:ShowWeapon(var_40_1.transform, false)

				arg_37_1.var_["1024ui_story" .. "Animator"] = var_40_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_37_1.var_["1024ui_story" .. "Animator"].applyRootMotion = true
				arg_37_1.var_["1024ui_story" .. "LipSync"] = var_40_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_40_3 = arg_37_1.actors_["1024ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1024ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0.7, -1, -6.05)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_40_5 = arg_37_1.actors_["1017ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1017ui_story == nil then
				arg_37_1.var_.characterEffect1017ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect1017ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_6)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect1017ui_story then
				arg_37_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_40_7 = arg_37_1.actors_["1024ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.characterEffect1024ui_story == nil then
				arg_37_1.var_.characterEffect1024ui_story = var_40_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_8 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_8 and not isNil(var_40_7) then
				if arg_37_1.var_.characterEffect1024ui_story and not isNil(var_40_7) then
					arg_37_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_8 and arg_37_1.time_ < 0 + var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.characterEffect1024ui_story then
				arg_37_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_40_10 = arg_37_1.actors_["1017ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1017ui_story = var_40_10.localPosition
			end

			local var_40_11 = 0.5

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_11 then
				var_40_10.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1017ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_37_1.time_ - 0) / var_40_11)
				var_40_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_10.position).x, (manager.ui.mainCamera.transform.position - var_40_10.position).y, (manager.ui.mainCamera.transform.position - var_40_10.position).z)
				var_40_10.localEulerAngles.z = 0
				var_40_10.localEulerAngles.x = 0
				var_40_10.localEulerAngles = var_40_10.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_11 and arg_37_1.time_ < 0 + var_40_11 + arg_40_0 then
				var_40_10.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_40_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_10.position).x, (manager.ui.mainCamera.transform.position - var_40_10.position).y, (manager.ui.mainCamera.transform.position - var_40_10.position).z)
				var_40_10.localEulerAngles.z = 0
				var_40_10.localEulerAngles.x = 0
				var_40_10.localEulerAngles = var_40_10.localEulerAngles
			end

			local var_40_12 = 0
			local var_40_13 = 0.25

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:GetWordFromCfg(115191009)
				local var_40_15 = arg_37_1:FormatText(var_40_14.content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 10 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 10)

				if (10 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 10)) > 0 and var_40_13 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17

					if var_40_17 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191009", "story_v_out_115191.awb") ~= 0 then
					local var_40_18 = manager.audio:GetVoiceLength("story_v_out_115191", "115191009", "story_v_out_115191.awb") / 1000

					if var_40_18 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_18 + var_40_12
					end

					if var_40_14.prefab_name ~= "" and arg_37_1.actors_[var_40_14.prefab_name] ~= nil then
						local var_40_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_14.prefab_name].transform, "story_v_out_115191", "115191009", "story_v_out_115191.awb")

						arg_37_1:RecordAudio("115191009", var_40_19)
						arg_37_1:RecordAudio("115191009", var_40_19)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_115191", "115191009", "story_v_out_115191.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_115191", "115191009", "story_v_out_115191.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_20 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_20 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_20

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_20 and arg_37_1.time_ < var_40_12 + var_40_20 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play115191010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 115191010
		arg_41_1.duration_ = 7.33

		local var_41_0 = {
			ja = 7.333,
			ko = 4.8,
			zh = 3.833,
			en = 5.2
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
				arg_41_0:Play115191011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1024ui_story"]) and arg_41_1.var_.characterEffect1024ui_story == nil then
				arg_41_1.var_.characterEffect1024ui_story = arg_41_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1024ui_story"]) then
				if arg_41_1.var_.characterEffect1024ui_story and not isNil(arg_41_1.actors_["1024ui_story"]) then
					arg_41_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1024ui_story"]) and arg_41_1.var_.characterEffect1024ui_story then
				arg_41_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.5

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1016")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(115191010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 17 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 17)

				if (17 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 17)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191010", "story_v_out_115191.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_out_115191", "115191010", "story_v_out_115191.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_115191", "115191010", "story_v_out_115191.awb")

						arg_41_1:RecordAudio("115191010", var_44_8)
						arg_41_1:RecordAudio("115191010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_115191", "115191010", "story_v_out_115191.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_115191", "115191010", "story_v_out_115191.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_9 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_9

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_9 and arg_41_1.time_ < var_44_1 + var_44_9 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play115191011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 115191011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play115191012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(115191011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 48 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 48)

				if (48 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 48)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play115191012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 115191012
		arg_49_1.duration_ = 4.67

		local var_49_0 = {
			ja = 4.666,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.233
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
				arg_49_0:Play115191013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_52_0 = arg_49_1.actors_["1017ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1017ui_story == nil then
				arg_49_1.var_.characterEffect1017ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_1 = 0.2

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 and not isNil(var_52_0) then
				if arg_49_1.var_.characterEffect1017ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1017ui_story then
				arg_49_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_52_3 = 0
			local var_52_4 = 0.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_5 = arg_49_1:GetWordFromCfg(115191012)
				local var_52_6 = arg_49_1:FormatText(var_52_5.content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 7 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 7)

				if (7 <= 0 and var_52_4 or var_52_4 * (utf8.len(var_52_6) / 7)) > 0 and var_52_4 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_3
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191012", "story_v_out_115191.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_out_115191", "115191012", "story_v_out_115191.awb") / 1000

					if var_52_9 + var_52_3 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_3
					end

					if var_52_5.prefab_name ~= "" and arg_49_1.actors_[var_52_5.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_5.prefab_name].transform, "story_v_out_115191", "115191012", "story_v_out_115191.awb")

						arg_49_1:RecordAudio("115191012", var_52_10)
						arg_49_1:RecordAudio("115191012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_115191", "115191012", "story_v_out_115191.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_115191", "115191012", "story_v_out_115191.awb")
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

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play115191013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 115191013
		arg_53_1.duration_ = 1.2

		local var_53_0 = {
			ja = 1.166,
			ko = 1.2,
			zh = 1.2,
			en = 1.1
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play115191014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1017ui_story"]) and arg_53_1.var_.characterEffect1017ui_story == nil then
				arg_53_1.var_.characterEffect1017ui_story = arg_53_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1017ui_story"]) then
				if arg_53_1.var_.characterEffect1017ui_story and not isNil(arg_53_1.actors_["1017ui_story"]) then
					arg_53_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1017ui_story"]) and arg_53_1.var_.characterEffect1017ui_story then
				arg_53_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[266].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024_1")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_3 = arg_53_1:GetWordFromCfg(115191013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 2 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 2)

				if (2 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 2)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191013", "story_v_out_115191.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_115191", "115191013", "story_v_out_115191.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_115191", "115191013", "story_v_out_115191.awb")

						arg_53_1:RecordAudio("115191013", var_56_8)
						arg_53_1:RecordAudio("115191013", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_115191", "115191013", "story_v_out_115191.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_115191", "115191013", "story_v_out_115191.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play115191014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 115191014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play115191015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1017ui_story = arg_57_1.actors_["1017ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1017ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1017ui_story"].transform.position).z)
				arg_57_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1017ui_story"].transform.localEulerAngles = arg_57_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1017ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1017ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1017ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1017ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1017ui_story"].transform.position).z)
				arg_57_1.actors_["1017ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1017ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1017ui_story"].transform.localEulerAngles = arg_57_1.actors_["1017ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1024ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1024ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, 100, 0)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = 0
			local var_60_4 = 1.5

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(115191014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 60 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 60)

				if (60 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 60)) > 0 and var_60_4 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_8 and arg_57_1.time_ < var_60_3 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
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
	Play115191015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 115191015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play115191016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.2

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(115191015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 48 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 48)

				if (48 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 48)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play115191016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 115191016
		arg_65_1.duration_ = 6.23

		local var_65_0 = {
			ja = 4.433,
			ko = 6.233,
			zh = 4.966,
			en = 5.633
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
				arg_65_0:Play115191017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if arg_65_1.actors_["1016ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1016ui_story"))) then
				local var_68_0 = Object.Instantiate(Asset.Load("Char/" .. "1016ui_story"), arg_65_1.stage_.transform)

				var_68_0.name = "1016ui_story"
				var_68_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1016ui_story"] = var_68_0

				local var_68_1 = var_68_0:GetComponentInChildren(typeof(CharacterEffect))

				var_68_1.enabled = true

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end

				arg_65_1:ShowWeapon(var_68_1.transform, false)

				arg_65_1.var_["1016ui_story" .. "Animator"] = var_68_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_65_1.var_["1016ui_story" .. "Animator"].applyRootMotion = true
				arg_65_1.var_["1016ui_story" .. "LipSync"] = var_68_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_68_3 = arg_65_1.actors_["1016ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1016ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_65_1.time_ - 0) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_68_5 = arg_65_1.actors_["1016ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1016ui_story == nil then
				arg_65_1.var_.characterEffect1016ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.characterEffect1016ui_story and not isNil(var_68_5) then
					arg_65_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1016ui_story then
				arg_65_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_68_8 = 0
			local var_68_9 = 0.575

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(115191016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 24 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 24)

				if (24 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 24)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191016", "story_v_out_115191.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_115191", "115191016", "story_v_out_115191.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_115191", "115191016", "story_v_out_115191.awb")

						arg_65_1:RecordAudio("115191016", var_68_15)
						arg_65_1:RecordAudio("115191016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_115191", "115191016", "story_v_out_115191.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_115191", "115191016", "story_v_out_115191.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play115191017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 115191017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play115191018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1016ui_story"]) and arg_69_1.var_.characterEffect1016ui_story == nil then
				arg_69_1.var_.characterEffect1016ui_story = arg_69_1.actors_["1016ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1016ui_story"]) then
				if arg_69_1.var_.characterEffect1016ui_story and not isNil(arg_69_1.actors_["1016ui_story"]) then
					arg_69_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1016ui_story"]) and arg_69_1.var_.characterEffect1016ui_story then
				arg_69_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_72_1 = "1052ui_story"

			if arg_69_1.actors_["1052ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1052ui_story"))) then
				local var_72_2 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_69_1.stage_.transform)

				var_72_2.name = var_72_1
				var_72_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_[var_72_1] = var_72_2

				local var_72_3 = var_72_2:GetComponentInChildren(typeof(CharacterEffect))

				var_72_3.enabled = true

				local var_72_4 = GameObjectTools.GetOrAddComponent(var_72_2, typeof(DynamicBoneHelper))

				if var_72_4 then
					var_72_4:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_3.transform, false)

				arg_69_1.var_[var_72_1 .. "Animator"] = var_72_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_[var_72_1 .. "Animator"].applyRootMotion = true
				arg_69_1.var_[var_72_1 .. "LipSync"] = var_72_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_5 = arg_69_1.actors_["1052ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1052ui_story = var_72_5.localPosition
			end

			local var_72_6 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1052ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_69_1.time_ - 0) / var_72_6)
				var_72_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_5.position).x, (manager.ui.mainCamera.transform.position - var_72_5.position).y, (manager.ui.mainCamera.transform.position - var_72_5.position).z)
				var_72_5.localEulerAngles.z = 0
				var_72_5.localEulerAngles.x = 0
				var_72_5.localEulerAngles = var_72_5.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(0.7, -1.05, -6.2)
				var_72_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_5.position).x, (manager.ui.mainCamera.transform.position - var_72_5.position).y, (manager.ui.mainCamera.transform.position - var_72_5.position).z)
				var_72_5.localEulerAngles.z = 0
				var_72_5.localEulerAngles.x = 0
				var_72_5.localEulerAngles = var_72_5.localEulerAngles
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_72_7 = arg_69_1.actors_["1052ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.characterEffect1052ui_story == nil then
				arg_69_1.var_.characterEffect1052ui_story = var_72_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_8 and not isNil(var_72_7) then
				if arg_69_1.var_.characterEffect1052ui_story and not isNil(var_72_7) then
					arg_69_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_8 and arg_69_1.time_ < 0 + var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.characterEffect1052ui_story then
				arg_69_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_72_10 = 0
			local var_72_11 = 0.05

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_12 = arg_69_1:GetWordFromCfg(115191017)
				local var_72_13 = arg_69_1:FormatText(var_72_12.content)

				arg_69_1.text_.text = var_72_13

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_15 = 2 <= 0 and var_72_11 or var_72_11 * (utf8.len(var_72_13) / 2)

				if (2 <= 0 and var_72_11 or var_72_11 * (utf8.len(var_72_13) / 2)) > 0 and var_72_11 < var_72_15 then
					arg_69_1.talkMaxDuration = var_72_15

					if var_72_15 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_15 + var_72_10
					end
				end

				arg_69_1.text_.text = var_72_13
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191017", "story_v_out_115191.awb") ~= 0 then
					local var_72_16 = manager.audio:GetVoiceLength("story_v_out_115191", "115191017", "story_v_out_115191.awb") / 1000

					if var_72_16 + var_72_10 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_16 + var_72_10
					end

					if var_72_12.prefab_name ~= "" and arg_69_1.actors_[var_72_12.prefab_name] ~= nil then
						local var_72_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_12.prefab_name].transform, "story_v_out_115191", "115191017", "story_v_out_115191.awb")

						arg_69_1:RecordAudio("115191017", var_72_17)
						arg_69_1:RecordAudio("115191017", var_72_17)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_115191", "115191017", "story_v_out_115191.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_115191", "115191017", "story_v_out_115191.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_18 = math.max(var_72_11, arg_69_1.talkMaxDuration)

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_18 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_10) / var_72_18

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_10 + var_72_18 and arg_69_1.time_ < var_72_10 + var_72_18 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play115191018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 115191018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play115191019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1052ui_story = arg_73_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1052ui_story"].transform.position).z)
				arg_73_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1052ui_story"].transform.localEulerAngles = arg_73_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1052ui_story"].transform.position).z)
				arg_73_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1052ui_story"].transform.localEulerAngles = arg_73_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1016ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1016ui_story = var_76_1.localPosition
			end

			local var_76_2 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 then
				var_76_1.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_2)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 then
				var_76_1.localPosition = Vector3.New(0, 100, 0)
				var_76_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_1.position).x, (manager.ui.mainCamera.transform.position - var_76_1.position).y, (manager.ui.mainCamera.transform.position - var_76_1.position).z)
				var_76_1.localEulerAngles.z = 0
				var_76_1.localEulerAngles.x = 0
				var_76_1.localEulerAngles = var_76_1.localEulerAngles
			end

			local var_76_3 = 0
			local var_76_4 = 1.45

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(115191018).content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 58 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 58)

				if (58 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_5) / 58)) > 0 and var_76_4 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_8 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_8 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_8

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_8 and arg_73_1.time_ < var_76_3 + var_76_8 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play115191019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 115191019
		arg_77_1.duration_ = 19.1

		local var_77_0 = {
			ja = 19.1,
			ko = 8.1,
			zh = 11.033,
			en = 10.033
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play115191020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.875

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(115191019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 35 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 35)

				if (35 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 35)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191019", "story_v_out_115191.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_115191", "115191019", "story_v_out_115191.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_115191", "115191019", "story_v_out_115191.awb")

						arg_77_1:RecordAudio("115191019", var_80_6)
						arg_77_1:RecordAudio("115191019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_115191", "115191019", "story_v_out_115191.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_115191", "115191019", "story_v_out_115191.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play115191020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 115191020
		arg_81_1.duration_ = 26.7

		local var_81_0 = {
			ja = 26.7,
			ko = 15.033,
			zh = 15.9,
			en = 15.633
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play115191021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(115191020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 60 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 60)

				if (60 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 60)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191020", "story_v_out_115191.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_115191", "115191020", "story_v_out_115191.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_115191", "115191020", "story_v_out_115191.awb")

						arg_81_1:RecordAudio("115191020", var_84_6)
						arg_81_1:RecordAudio("115191020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_115191", "115191020", "story_v_out_115191.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_115191", "115191020", "story_v_out_115191.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play115191021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 115191021
		arg_85_1.duration_ = 5.6

		local var_85_0 = {
			ja = 5.6,
			ko = 3.333,
			zh = 4.066,
			en = 4.133
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
				arg_85_0:Play115191022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1016ui_story = arg_85_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1016ui_story"].transform.position).z)
				arg_85_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1016ui_story"].transform.localEulerAngles = arg_85_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(0, -18.66, -121.78)
				arg_85_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1016ui_story"].transform.position).z)
				arg_85_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1016ui_story"].transform.localEulerAngles = arg_85_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action1_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_88_1 = arg_85_1.actors_["1016ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1016ui_story == nil then
				arg_85_1.var_.characterEffect1016ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1016ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1016ui_story then
				arg_85_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.2

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(115191021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 8 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 8)

				if (8 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 8)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191021", "story_v_out_115191.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_115191", "115191021", "story_v_out_115191.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_115191", "115191021", "story_v_out_115191.awb")

						arg_85_1:RecordAudio("115191021", var_88_11)
						arg_85_1:RecordAudio("115191021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_115191", "115191021", "story_v_out_115191.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_115191", "115191021", "story_v_out_115191.awb")
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
				actorName = "1016ui_story",
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
	Play115191022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 115191022
		arg_89_1.duration_ = 24.43

		local var_89_0 = {
			ja = 24.433,
			ko = 18.9,
			zh = 21.3,
			en = 16
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
				arg_89_0:Play115191023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1052ui_story = arg_89_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1052ui_story, Vector3.New(0.7, -1.05, -6.2), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1052ui_story"].transform.position).z)
				arg_89_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1052ui_story"].transform.localEulerAngles = arg_89_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.2)
				arg_89_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1052ui_story"].transform.position).z)
				arg_89_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1052ui_story"].transform.localEulerAngles = arg_89_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_92_1 = arg_89_1.actors_["1052ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1052ui_story == nil then
				arg_89_1.var_.characterEffect1052ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1052ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1052ui_story then
				arg_89_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_92_4 = arg_89_1.actors_["1016ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1016ui_story = var_92_4.localPosition
			end

			local var_92_5 = 0.5

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 then
				var_92_4.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1016ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_89_1.time_ - 0) / var_92_5)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 then
				var_92_4.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			local var_92_6 = arg_89_1.actors_["1016ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1016ui_story == nil then
				arg_89_1.var_.characterEffect1016ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_7 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 and not isNil(var_92_6) then
				if arg_89_1.var_.characterEffect1016ui_story and not isNil(var_92_6) then
					arg_89_1.var_.characterEffect1016ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1016ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_7)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1016ui_story then
				arg_89_1.var_.characterEffect1016ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1016ui_story.fillRatio = 0.5
			end

			local var_92_8 = 0
			local var_92_9 = 2

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(115191022)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 80 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 80)

				if (80 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 80)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191022", "story_v_out_115191.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_115191", "115191022", "story_v_out_115191.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_115191", "115191022", "story_v_out_115191.awb")

						arg_89_1:RecordAudio("115191022", var_92_15)
						arg_89_1:RecordAudio("115191022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_115191", "115191022", "story_v_out_115191.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_115191", "115191022", "story_v_out_115191.awb")
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
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play115191023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 115191023
		arg_93_1.duration_ = 17

		local var_93_0 = {
			ja = 11.066,
			ko = 11.8,
			zh = 17,
			en = 14.466
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play115191024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_0 = 0
			local var_96_1 = 1.7

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(115191023)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 67 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 67)

				if (67 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 67)) > 0 and var_96_1 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191023", "story_v_out_115191.awb") ~= 0 then
					local var_96_6 = manager.audio:GetVoiceLength("story_v_out_115191", "115191023", "story_v_out_115191.awb") / 1000

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end

					if var_96_2.prefab_name ~= "" and arg_93_1.actors_[var_96_2.prefab_name] ~= nil then
						local var_96_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_2.prefab_name].transform, "story_v_out_115191", "115191023", "story_v_out_115191.awb")

						arg_93_1:RecordAudio("115191023", var_96_7)
						arg_93_1:RecordAudio("115191023", var_96_7)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_115191", "115191023", "story_v_out_115191.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_115191", "115191023", "story_v_out_115191.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_8 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_8 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_8

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_8 and arg_93_1.time_ < var_96_0 + var_96_8 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play115191024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 115191024
		arg_97_1.duration_ = 3.33

		local var_97_0 = {
			ja = 2.6,
			ko = 3.233,
			zh = 3.333,
			en = 2.2
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play115191025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1052ui_story"]) and arg_97_1.var_.characterEffect1052ui_story == nil then
				arg_97_1.var_.characterEffect1052ui_story = arg_97_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1052ui_story"]) then
				if arg_97_1.var_.characterEffect1052ui_story and not isNil(arg_97_1.actors_["1052ui_story"]) then
					arg_97_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1052ui_story"]) and arg_97_1.var_.characterEffect1052ui_story then
				arg_97_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.4

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1017")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(115191024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 16 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 16)

				if (16 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 16)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191024", "story_v_out_115191.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_115191", "115191024", "story_v_out_115191.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_115191", "115191024", "story_v_out_115191.awb")

						arg_97_1:RecordAudio("115191024", var_100_8)
						arg_97_1:RecordAudio("115191024", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_115191", "115191024", "story_v_out_115191.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_115191", "115191024", "story_v_out_115191.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play115191025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 115191025
		arg_101_1.duration_ = 12.23

		local var_101_0 = {
			ja = 12.233,
			ko = 6.7,
			zh = 6.566,
			en = 8.266
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
				arg_101_0:Play115191026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action6_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_104_0 = arg_101_1.actors_["1052ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1052ui_story == nil then
				arg_101_1.var_.characterEffect1052ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_1 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 and not isNil(var_104_0) then
				if arg_101_1.var_.characterEffect1052ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1052ui_story then
				arg_101_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_104_3 = 0
			local var_104_4 = 0.775

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_5 = arg_101_1:GetWordFromCfg(115191025)
				local var_104_6 = arg_101_1:FormatText(var_104_5.content)

				arg_101_1.text_.text = var_104_6

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_8 = 31 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_6) / 31)

				if (31 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_6) / 31)) > 0 and var_104_4 < var_104_8 then
					arg_101_1.talkMaxDuration = var_104_8

					if var_104_8 + var_104_3 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_3
					end
				end

				arg_101_1.text_.text = var_104_6
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191025", "story_v_out_115191.awb") ~= 0 then
					local var_104_9 = manager.audio:GetVoiceLength("story_v_out_115191", "115191025", "story_v_out_115191.awb") / 1000

					if var_104_9 + var_104_3 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_3
					end

					if var_104_5.prefab_name ~= "" and arg_101_1.actors_[var_104_5.prefab_name] ~= nil then
						local var_104_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_5.prefab_name].transform, "story_v_out_115191", "115191025", "story_v_out_115191.awb")

						arg_101_1:RecordAudio("115191025", var_104_10)
						arg_101_1:RecordAudio("115191025", var_104_10)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_115191", "115191025", "story_v_out_115191.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_115191", "115191025", "story_v_out_115191.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = math.max(var_104_4, arg_101_1.talkMaxDuration)

			if var_104_3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_3 + var_104_11 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_3) / var_104_11

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_3 + var_104_11 and arg_101_1.time_ < var_104_3 + var_104_11 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play115191026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 115191026
		arg_105_1.duration_ = 10.2

		local var_105_0 = {
			ja = 9.333,
			ko = 10.133,
			zh = 10.2,
			en = 9.066
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play115191027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_108_0 = 0
			local var_108_1 = 1.075

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(115191026)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 43 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 43)

				if (43 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 43)) > 0 and var_108_1 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191026", "story_v_out_115191.awb") ~= 0 then
					local var_108_6 = manager.audio:GetVoiceLength("story_v_out_115191", "115191026", "story_v_out_115191.awb") / 1000

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end

					if var_108_2.prefab_name ~= "" and arg_105_1.actors_[var_108_2.prefab_name] ~= nil then
						local var_108_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_2.prefab_name].transform, "story_v_out_115191", "115191026", "story_v_out_115191.awb")

						arg_105_1:RecordAudio("115191026", var_108_7)
						arg_105_1:RecordAudio("115191026", var_108_7)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_115191", "115191026", "story_v_out_115191.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_115191", "115191026", "story_v_out_115191.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_8 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_8 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_8

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_8 and arg_105_1.time_ < var_108_0 + var_108_8 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play115191027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 115191027
		arg_109_1.duration_ = 2.97

		local var_109_0 = {
			ja = 1.999999999999,
			ko = 2.6,
			zh = 2.966,
			en = 2.466
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play115191028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1052ui_story"]) and arg_109_1.var_.characterEffect1052ui_story == nil then
				arg_109_1.var_.characterEffect1052ui_story = arg_109_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1052ui_story"]) then
				if arg_109_1.var_.characterEffect1052ui_story and not isNil(arg_109_1.actors_["1052ui_story"]) then
					arg_109_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1052ui_story"]) and arg_109_1.var_.characterEffect1052ui_story then
				arg_109_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_112_1 = arg_109_1.actors_["1016ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1016ui_story == nil then
				arg_109_1.var_.characterEffect1016ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1016ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1016ui_story then
				arg_109_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.15

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(115191027)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 6 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 6)

				if (6 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 6)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191027", "story_v_out_115191.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_115191", "115191027", "story_v_out_115191.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_115191", "115191027", "story_v_out_115191.awb")

						arg_109_1:RecordAudio("115191027", var_112_11)
						arg_109_1:RecordAudio("115191027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_115191", "115191027", "story_v_out_115191.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_115191", "115191027", "story_v_out_115191.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play115191028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 115191028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play115191029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1052ui_story = arg_113_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1052ui_story"].transform.position).z)
				arg_113_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1052ui_story"].transform.localEulerAngles = arg_113_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1052ui_story"].transform.position).z)
				arg_113_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1052ui_story"].transform.localEulerAngles = arg_113_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1016ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1016ui_story = var_116_1.localPosition
			end

			local var_116_2 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 then
				var_116_1.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_2)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 then
				var_116_1.localPosition = Vector3.New(0, 100, 0)
				var_116_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_1.position).x, (manager.ui.mainCamera.transform.position - var_116_1.position).y, (manager.ui.mainCamera.transform.position - var_116_1.position).z)
				var_116_1.localEulerAngles.z = 0
				var_116_1.localEulerAngles.x = 0
				var_116_1.localEulerAngles = var_116_1.localEulerAngles
			end

			local var_116_3 = 0
			local var_116_4 = 1.275

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_3 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_5 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(115191028).content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 51 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 51)

				if (51 <= 0 and var_116_4 or var_116_4 * (utf8.len(var_116_5) / 51)) > 0 and var_116_4 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_3 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_3
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_4, arg_113_1.talkMaxDuration)

			if var_116_3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_3 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_3) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_3 + var_116_8 and arg_113_1.time_ < var_116_3 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play115191029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 115191029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play115191030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.225

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

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(115191029).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 49 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 49)

				if (49 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 49)) > 0 and var_120_0 < var_120_3 then
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
	Play115191030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 115191030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play115191031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.675

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(115191030).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 27 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 27)

				if (27 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 27)) > 0 and var_124_0 < var_124_3 then
					arg_121_1.talkMaxDuration = var_124_3

					if var_124_3 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_3 + 0
					end
				end

				arg_121_1.text_.text = var_124_1
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_4 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_4

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play115191031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 115191031
		arg_125_1.duration_ = 3.3

		local var_125_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_125_0:Play115191032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1016ui_story = arg_125_1.actors_["1016ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1016ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1016ui_story, Vector3.New(0, -18.66, -121.78), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1016ui_story"].transform.position).z)
				arg_125_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1016ui_story"].transform.localEulerAngles = arg_125_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1016ui_story"].transform.localPosition = Vector3.New(0, -18.66, -121.78)
				arg_125_1.actors_["1016ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1016ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1016ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1016ui_story"].transform.position).z)
				arg_125_1.actors_["1016ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1016ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1016ui_story"].transform.localEulerAngles = arg_125_1.actors_["1016ui_story"].transform.localEulerAngles
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1016ui_story", "StoryTimeline/CharAction/story1016/story1016action/1016action1_1")
			end

			local var_128_1 = arg_125_1.actors_["1016ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1016ui_story == nil then
				arg_125_1.var_.characterEffect1016ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1016ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1016ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1016ui_story then
				arg_125_1.var_.characterEffect1016ui_story.fillFlat = false
			end

			local var_128_4 = 0
			local var_128_5 = 0.075

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[260].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(115191031)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 3 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 3)

				if (3 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 3)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191031", "story_v_out_115191.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_115191", "115191031", "story_v_out_115191.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_115191", "115191031", "story_v_out_115191.awb")

						arg_125_1:RecordAudio("115191031", var_128_11)
						arg_125_1:RecordAudio("115191031", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_115191", "115191031", "story_v_out_115191.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_115191", "115191031", "story_v_out_115191.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
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
	Play115191032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 115191032
		arg_129_1.duration_ = 6

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play115191033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:AudioAction("play", "effect", "se_story_15", "se_story_15_roar2", "")
			end

			local var_132_1 = arg_129_1.actors_["1016ui_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1016ui_story = var_132_1.localPosition
			end

			local var_132_2 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 then
				var_132_1.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1016ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_2)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 then
				var_132_1.localPosition = Vector3.New(0, 100, 0)
				var_132_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_1.position).x, (manager.ui.mainCamera.transform.position - var_132_1.position).y, (manager.ui.mainCamera.transform.position - var_132_1.position).z)
				var_132_1.localEulerAngles.z = 0
				var_132_1.localEulerAngles.x = 0
				var_132_1.localEulerAngles = var_132_1.localEulerAngles
			end

			local var_132_3 = manager.ui.mainCamera.transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.shakeOldPos = var_132_3.localPosition
			end

			local var_132_4 = 1

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				local var_132_5, var_132_6 = math.modf((arg_129_1.time_ - 0) / 0.066)

				var_132_3.localPosition = Vector3.New(var_132_6 * 0.13, var_132_6 * 0.13, var_132_6 * 0.13) + arg_129_1.var_.shakeOldPos
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_3.localPosition = arg_129_1.var_.shakeOldPos
			end

			local var_132_7 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.allBtn_.enabled = false
			end

			if arg_129_1.time_ >= var_132_7 + 1 and arg_129_1.time_ < var_132_7 + 1 + arg_132_0 then
				arg_129_1.allBtn_.enabled = true
			end

			if arg_129_1.frameCnt_ <= 1 then
				arg_129_1.dialog_:SetActive(false)
			end

			local var_132_8 = 1
			local var_132_9 = 0.6

			if 1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				arg_129_1.dialog_:SetActive(true)

				arg_129_1.dialogCg_.alpha = 0

				local var_132_10 = LeanTween.value(arg_129_1.dialog_, 0, 1, 0.3)

				var_132_10:setOnUpdate(LuaHelper.FloatAction(function(arg_133_0)
					arg_129_1.dialogCg_.alpha = arg_133_0
				end))
				var_132_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_129_1.dialog_)
					var_132_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_129_1.duration_ = arg_129_1.duration_ + 0.3

				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_11 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(115191032).content)

				arg_129_1.text_.text = var_132_11

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_13 = 24 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 24)

				if (24 <= 0 and var_132_9 or var_132_9 * (utf8.len(var_132_11) / 24)) > 0 and var_132_9 < var_132_13 then
					arg_129_1.talkMaxDuration = var_132_13
					var_132_8 = var_132_8 + 0.3

					if var_132_13 + var_132_8 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_13 + var_132_8
					end
				end

				arg_129_1.text_.text = var_132_11
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = var_132_8 + 0.3
			local var_132_15 = math.max(var_132_9, arg_129_1.talkMaxDuration)

			if var_132_8 + 0.3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_14 + var_132_15 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_14) / var_132_15

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_14 + var_132_15 and arg_129_1.time_ < var_132_14 + var_132_15 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1016ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play115191033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 115191033
		arg_135_1.duration_ = 10.5

		local var_135_0 = {
			ja = 10.5,
			ko = 9.4,
			zh = 8.9,
			en = 10.3
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play115191034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1052ui_story = arg_135_1.actors_["1052ui_story"].transform.localPosition

				arg_135_1:ShowWeapon(arg_135_1.var_["1052ui_story" .. "Animator"].transform, true)
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1052ui_story"].transform.position).z)
				arg_135_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1052ui_story"].transform.localEulerAngles = arg_135_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.2)
				arg_135_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1052ui_story"].transform.position).z)
				arg_135_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1052ui_story"].transform.localEulerAngles = arg_135_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action2_1")
			end

			local var_138_1 = arg_135_1.actors_["1052ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1052ui_story == nil then
				arg_135_1.var_.characterEffect1052ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1052ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1052ui_story then
				arg_135_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_138_4 = 0
			local var_138_5 = 0.8

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(115191033)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 32 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 32)

				if (32 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 32)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191033", "story_v_out_115191.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_115191", "115191033", "story_v_out_115191.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_115191", "115191033", "story_v_out_115191.awb")

						arg_135_1:RecordAudio("115191033", var_138_11)
						arg_135_1:RecordAudio("115191033", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_115191", "115191033", "story_v_out_115191.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_115191", "115191033", "story_v_out_115191.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play115191034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 115191034
		arg_139_1.duration_ = 3.17

		local var_139_0 = {
			ja = 3.1,
			ko = 2.166,
			zh = 1.999999999999,
			en = 3.166
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
				arg_139_0:Play115191035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1052ui_story = arg_139_1.actors_["1052ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1052ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1052ui_story"].transform.position).z)
				arg_139_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1052ui_story"].transform.localEulerAngles = arg_139_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1052ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1052ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1052ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1052ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1052ui_story"].transform.position).z)
				arg_139_1.actors_["1052ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1052ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1052ui_story"].transform.localEulerAngles = arg_139_1.actors_["1052ui_story"].transform.localEulerAngles
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/story1017/story1017action/1017action3_1")
			end

			local var_142_1 = arg_139_1.actors_["1017ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1017ui_story = var_142_1.localPosition
			end

			local var_142_2 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 then
				var_142_1.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1017ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_139_1.time_ - 0) / var_142_2)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 then
				var_142_1.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_142_3 = arg_139_1.actors_["1017ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_3) and arg_139_1.var_.characterEffect1017ui_story == nil then
				arg_139_1.var_.characterEffect1017ui_story = var_142_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_4 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 and not isNil(var_142_3) then
				if arg_139_1.var_.characterEffect1017ui_story and not isNil(var_142_3) then
					arg_139_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 and not isNil(var_142_3) and arg_139_1.var_.characterEffect1017ui_story then
				arg_139_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			local var_142_6 = 0
			local var_142_7 = 0.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_8 = arg_139_1:GetWordFromCfg(115191034)
				local var_142_9 = arg_139_1:FormatText(var_142_8.content)

				arg_139_1.text_.text = var_142_9

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 12 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 12)

				if (12 <= 0 and var_142_7 or var_142_7 * (utf8.len(var_142_9) / 12)) > 0 and var_142_7 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_9
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191034", "story_v_out_115191.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_115191", "115191034", "story_v_out_115191.awb") / 1000

					if var_142_12 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_6
					end

					if var_142_8.prefab_name ~= "" and arg_139_1.actors_[var_142_8.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_8.prefab_name].transform, "story_v_out_115191", "115191034", "story_v_out_115191.awb")

						arg_139_1:RecordAudio("115191034", var_142_13)
						arg_139_1:RecordAudio("115191034", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_115191", "115191034", "story_v_out_115191.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_115191", "115191034", "story_v_out_115191.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play115191035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 115191035
		arg_143_1.duration_ = 2.03

		local var_143_0 = {
			ja = 2.033,
			ko = 2,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play115191036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1017ui_story"]) and arg_143_1.var_.characterEffect1017ui_story == nil then
				arg_143_1.var_.characterEffect1017ui_story = arg_143_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1017ui_story"]) then
				if arg_143_1.var_.characterEffect1017ui_story and not isNil(arg_143_1.actors_["1017ui_story"]) then
					arg_143_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1017ui_story"]) and arg_143_1.var_.characterEffect1017ui_story then
				arg_143_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			local var_146_1 = arg_143_1.actors_["1024ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1024ui_story == nil then
				arg_143_1.var_.characterEffect1024ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1024ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1024ui_story then
				arg_143_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_146_4 = arg_143_1.actors_["1024ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1024ui_story = var_146_4.localPosition
			end

			local var_146_5 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1024ui_story, Vector3.New(0.7, -1, -6.05), (arg_143_1.time_ - 0) / var_146_5)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				var_146_4.localPosition = Vector3.New(0.7, -1, -6.05)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			local var_146_6 = 0
			local var_146_7 = 0.15

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(115191035)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 6 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 6)

				if (6 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 6)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191035", "story_v_out_115191.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_out_115191", "115191035", "story_v_out_115191.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_out_115191", "115191035", "story_v_out_115191.awb")

						arg_143_1:RecordAudio("115191035", var_146_13)
						arg_143_1:RecordAudio("115191035", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_115191", "115191035", "story_v_out_115191.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_115191", "115191035", "story_v_out_115191.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_14 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_14 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_14

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_14 and arg_143_1.time_ < var_146_6 + var_146_14 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play115191036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 115191036
		arg_147_1.duration_ = 2.17

		local var_147_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_147_0:Play115191037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1017ui_story"]) and arg_147_1.var_.characterEffect1017ui_story == nil then
				arg_147_1.var_.characterEffect1017ui_story = arg_147_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1017ui_story"]) then
				if arg_147_1.var_.characterEffect1017ui_story and not isNil(arg_147_1.actors_["1017ui_story"]) then
					arg_147_1.var_.characterEffect1017ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1017ui_story"]) and arg_147_1.var_.characterEffect1017ui_story then
				arg_147_1.var_.characterEffect1017ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1017ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_150_2 = arg_147_1.actors_["1024ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect1024ui_story == nil then
				arg_147_1.var_.characterEffect1024ui_story = var_150_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_3 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.characterEffect1024ui_story and not isNil(var_150_2) then
					arg_147_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_3)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect1024ui_story then
				arg_147_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_150_4 = 0
			local var_150_5 = 0.1

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[273].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(115191036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 4 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 4)

				if (4 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 4)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191036", "story_v_out_115191.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_115191", "115191036", "story_v_out_115191.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_115191", "115191036", "story_v_out_115191.awb")

						arg_147_1:RecordAudio("115191036", var_150_11)
						arg_147_1:RecordAudio("115191036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_115191", "115191036", "story_v_out_115191.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_115191", "115191036", "story_v_out_115191.awb")
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

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play115191037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 115191037
		arg_151_1.duration_ = 13.8

		local var_151_0 = {
			ja = 6.766,
			ko = 12.033,
			zh = 13.8,
			en = 12.433
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play115191038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1017ui_story"]) and arg_151_1.var_.characterEffect1017ui_story == nil then
				arg_151_1.var_.characterEffect1017ui_story = arg_151_1.actors_["1017ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1017ui_story"]) then
				if arg_151_1.var_.characterEffect1017ui_story and not isNil(arg_151_1.actors_["1017ui_story"]) then
					arg_151_1.var_.characterEffect1017ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1017ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1017ui_story"]) and arg_151_1.var_.characterEffect1017ui_story then
				arg_151_1.var_.characterEffect1017ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1017ui_story.fillRatio = 0.5
			end

			local var_154_1 = arg_151_1.actors_["1024ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1024ui_story = var_154_1.localPosition
			end

			local var_154_2 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 then
				var_154_1.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_2)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 then
				var_154_1.localPosition = Vector3.New(0, 100, 0)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			local var_154_3 = arg_151_1.actors_["1017ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1017ui_story = var_154_3.localPosition
			end

			local var_154_4 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_3.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1017ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_4)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_3.localPosition = Vector3.New(0, 100, 0)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			local var_154_5 = arg_151_1.actors_["1052ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1052ui_story = var_154_5.localPosition

				arg_151_1:ShowWeapon(arg_151_1.var_["1052ui_story" .. "Animator"].transform, true)
			end

			local var_154_6 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_6 then
				var_154_5.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_151_1.time_ - 0) / var_154_6)
				var_154_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_5.position).x, (manager.ui.mainCamera.transform.position - var_154_5.position).y, (manager.ui.mainCamera.transform.position - var_154_5.position).z)
				var_154_5.localEulerAngles.z = 0
				var_154_5.localEulerAngles.x = 0
				var_154_5.localEulerAngles = var_154_5.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_6 and arg_151_1.time_ < 0 + var_154_6 + arg_154_0 then
				var_154_5.localPosition = Vector3.New(0, -1.05, -6.2)
				var_154_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_5.position).x, (manager.ui.mainCamera.transform.position - var_154_5.position).y, (manager.ui.mainCamera.transform.position - var_154_5.position).z)
				var_154_5.localEulerAngles.z = 0
				var_154_5.localEulerAngles.x = 0
				var_154_5.localEulerAngles = var_154_5.localEulerAngles
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_154_7 = arg_151_1.actors_["1052ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_7) and arg_151_1.var_.characterEffect1052ui_story == nil then
				arg_151_1.var_.characterEffect1052ui_story = var_154_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_8 and not isNil(var_154_7) then
				if arg_151_1.var_.characterEffect1052ui_story and not isNil(var_154_7) then
					arg_151_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_8 and arg_151_1.time_ < 0 + var_154_8 + arg_154_0 and not isNil(var_154_7) and arg_151_1.var_.characterEffect1052ui_story then
				arg_151_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			local var_154_10 = 0
			local var_154_11 = 1.25

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_12 = arg_151_1:GetWordFromCfg(115191037)
				local var_154_13 = arg_151_1:FormatText(var_154_12.content)

				arg_151_1.text_.text = var_154_13

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_15 = 50 <= 0 and var_154_11 or var_154_11 * (utf8.len(var_154_13) / 50)

				if (50 <= 0 and var_154_11 or var_154_11 * (utf8.len(var_154_13) / 50)) > 0 and var_154_11 < var_154_15 then
					arg_151_1.talkMaxDuration = var_154_15

					if var_154_15 + var_154_10 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_15 + var_154_10
					end
				end

				arg_151_1.text_.text = var_154_13
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191037", "story_v_out_115191.awb") ~= 0 then
					local var_154_16 = manager.audio:GetVoiceLength("story_v_out_115191", "115191037", "story_v_out_115191.awb") / 1000

					if var_154_16 + var_154_10 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_16 + var_154_10
					end

					if var_154_12.prefab_name ~= "" and arg_151_1.actors_[var_154_12.prefab_name] ~= nil then
						local var_154_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_12.prefab_name].transform, "story_v_out_115191", "115191037", "story_v_out_115191.awb")

						arg_151_1:RecordAudio("115191037", var_154_17)
						arg_151_1:RecordAudio("115191037", var_154_17)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_115191", "115191037", "story_v_out_115191.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_115191", "115191037", "story_v_out_115191.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_18 = math.max(var_154_11, arg_151_1.talkMaxDuration)

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_18 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_10) / var_154_18

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_10 + var_154_18 and arg_151_1.time_ < var_154_10 + var_154_18 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1017ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play115191038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 115191038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play115191039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1052ui_story"]) and arg_155_1.var_.characterEffect1052ui_story == nil then
				arg_155_1.var_.characterEffect1052ui_story = arg_155_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1052ui_story"]) then
				if arg_155_1.var_.characterEffect1052ui_story and not isNil(arg_155_1.actors_["1052ui_story"]) then
					arg_155_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1052ui_story"]) and arg_155_1.var_.characterEffect1052ui_story then
				arg_155_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.7

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

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(115191038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 23 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 23)

				if (23 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 23)) > 0 and var_158_2 < var_158_5 then
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

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play115191039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 115191039
		arg_159_1.duration_ = 20.97

		local var_159_0 = {
			ja = 10.8,
			ko = 19.5,
			zh = 20.966,
			en = 19.133
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
				arg_159_0:Play115191040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1052ui_story"]) and arg_159_1.var_.characterEffect1052ui_story == nil then
				arg_159_1.var_.characterEffect1052ui_story = arg_159_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1052ui_story"]) then
				if arg_159_1.var_.characterEffect1052ui_story and not isNil(arg_159_1.actors_["1052ui_story"]) then
					arg_159_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1052ui_story"]) and arg_159_1.var_.characterEffect1052ui_story then
				arg_159_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_162_2 = 0
			local var_162_3 = 1.9

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(115191039)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 76 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 76)

				if (76 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 76)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191039", "story_v_out_115191.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_115191", "115191039", "story_v_out_115191.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_115191", "115191039", "story_v_out_115191.awb")

						arg_159_1:RecordAudio("115191039", var_162_9)
						arg_159_1:RecordAudio("115191039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_115191", "115191039", "story_v_out_115191.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_115191", "115191039", "story_v_out_115191.awb")
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
	Play115191040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 115191040
		arg_163_1.duration_ = 6.07

		local var_163_0 = {
			ja = 4.4,
			ko = 6.066,
			zh = 5.233,
			en = 4.4
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
				arg_163_0:Play115191041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_166_0 = 0
			local var_166_1 = 0.5

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(115191040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 20 <= 0 and var_166_1 or var_166_1 * (utf8.len(var_166_3) / 20)

				if (20 <= 0 and var_166_1 or var_166_1 * (utf8.len(var_166_3) / 20)) > 0 and var_166_1 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191040", "story_v_out_115191.awb") ~= 0 then
					local var_166_6 = manager.audio:GetVoiceLength("story_v_out_115191", "115191040", "story_v_out_115191.awb") / 1000

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end

					if var_166_2.prefab_name ~= "" and arg_163_1.actors_[var_166_2.prefab_name] ~= nil then
						local var_166_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_2.prefab_name].transform, "story_v_out_115191", "115191040", "story_v_out_115191.awb")

						arg_163_1:RecordAudio("115191040", var_166_7)
						arg_163_1:RecordAudio("115191040", var_166_7)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_115191", "115191040", "story_v_out_115191.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_115191", "115191040", "story_v_out_115191.awb")
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
	Play115191041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 115191041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play115191042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:AudioAction("play", "effect", "se_story_15", "se_story_15_roar3", "")
			end

			local var_170_1 = arg_167_1.actors_["1052ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1052ui_story = var_170_1.localPosition

				arg_167_1:ShowWeapon(arg_167_1.var_["1052ui_story" .. "Animator"].transform, true)
			end

			local var_170_2 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 then
				var_170_1.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_2)
				var_170_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_1.position).x, (manager.ui.mainCamera.transform.position - var_170_1.position).y, (manager.ui.mainCamera.transform.position - var_170_1.position).z)
				var_170_1.localEulerAngles.z = 0
				var_170_1.localEulerAngles.x = 0
				var_170_1.localEulerAngles = var_170_1.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 then
				var_170_1.localPosition = Vector3.New(0, 100, 0)
				var_170_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_1.position).x, (manager.ui.mainCamera.transform.position - var_170_1.position).y, (manager.ui.mainCamera.transform.position - var_170_1.position).z)
				var_170_1.localEulerAngles.z = 0
				var_170_1.localEulerAngles.x = 0
				var_170_1.localEulerAngles = var_170_1.localEulerAngles
			end

			local var_170_3 = 0

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_3 + arg_170_0 then
				arg_167_1.var_.shakeOldPos = var_170_1.localPosition
			end

			local var_170_4 = 1

			if var_170_3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_3 + var_170_4 then
				local var_170_5, var_170_6 = math.modf((arg_167_1.time_ - var_170_3) / 0)

				var_170_1.localPosition = Vector3.New(var_170_6 * 0, var_170_6 * 0, var_170_6 * 0) + arg_167_1.var_.shakeOldPos
			end

			if arg_167_1.time_ >= var_170_3 + var_170_4 and arg_167_1.time_ < var_170_3 + var_170_4 + arg_170_0 then
				var_170_1.localPosition = arg_167_1.var_.shakeOldPos
			end

			local var_170_7 = 0

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 then
				arg_167_1.allBtn_.enabled = false
			end

			if arg_167_1.time_ >= var_170_7 + 1 and arg_167_1.time_ < var_170_7 + 1 + arg_170_0 then
				arg_167_1.allBtn_.enabled = true
			end

			local var_170_8 = 0
			local var_170_9 = 0.475

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_10 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(115191041).content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_12 = 19 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_10) / 19)

				if (19 <= 0 and var_170_9 or var_170_9 * (utf8.len(var_170_10) / 19)) > 0 and var_170_9 < var_170_12 then
					arg_167_1.talkMaxDuration = var_170_12

					if var_170_12 + var_170_8 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_8
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_9, arg_167_1.talkMaxDuration)

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_8) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_8 + var_170_13 and arg_167_1.time_ < var_170_8 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play115191042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 115191042
		arg_171_1.duration_ = 7.1

		local var_171_0 = {
			ja = 7.1,
			ko = 4.1,
			zh = 5.3,
			en = 6.633
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
			arg_171_1.auto_ = false
		end

		function arg_171_1.playNext_(arg_173_0)
			arg_171_1.onStoryFinished_()
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_174_0 = 0.6

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				local var_174_1, var_174_2 = math.modf((arg_171_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_174_2 * 0.13, var_174_2 * 0.13, var_174_2 * 0.13) + arg_171_1.var_.shakeOldPos
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				manager.ui.mainCamera.transform.localPosition = arg_171_1.var_.shakeOldPos
			end

			local var_174_3 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.allBtn_.enabled = false
			end

			if arg_171_1.time_ >= var_174_3 + 0.6 and arg_171_1.time_ < var_174_3 + 0.6 + arg_174_0 then
				arg_171_1.allBtn_.enabled = true
			end

			local var_174_4 = 0
			local var_174_5 = 0.425

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1052")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_6 = arg_171_1:GetWordFromCfg(115191042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 17 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 17)

				if (17 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 17)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115191", "115191042", "story_v_out_115191.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_115191", "115191042", "story_v_out_115191.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_115191", "115191042", "story_v_out_115191.awb")

						arg_171_1:RecordAudio("115191042", var_174_11)
						arg_171_1:RecordAudio("115191042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_115191", "115191042", "story_v_out_115191.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_115191", "115191042", "story_v_out_115191.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/G02b"
	},
	voices = {
		"story_v_out_115191.awb"
	}
}
