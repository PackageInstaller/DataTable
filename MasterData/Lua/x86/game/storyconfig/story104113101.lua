return {
	Play411311001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411311001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411311002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11o == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_4_0.name = "I11o"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11o = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11o

				arg_1_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11o" then
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

			if 0.666666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.666666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_leisure", "bgm_activity_3_0_story_daily_leisure")

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
			local var_4_15 = 0.925

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(411311001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 37 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 37)

				if (37 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 37)) > 0 and var_4_15 < var_4_19 then
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
	Play411311002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 411311002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play411311003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.15

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(411311002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 6 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 6)

				if (6 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 6)) > 0 and var_12_0 < var_12_3 then
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
	Play411311003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 411311003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play411311004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.775

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(411311003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 31)

				if (31 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 31)) > 0 and var_16_0 < var_16_3 then
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
	Play411311004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 411311004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play411311005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "10066ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10066ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["10066ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["10066ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["10066ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10066ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["10066ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10066ui_story == nil then
				arg_17_1.var_.characterEffect10066ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect10066ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10066ui_story then
				arg_17_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_20_8 = 0
			local var_20_9 = 0.675

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(411311004).content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 27 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 27)

				if (27 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 27)) > 0 and var_20_9 < var_20_12 then
					arg_17_1.talkMaxDuration = var_20_12

					if var_20_12 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_12 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_13 and arg_17_1.time_ < var_20_8 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play411311005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 411311005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play411311006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "10058ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["10058ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["10058ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["10058ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["10058ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10058ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["10058ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect10058ui_story == nil then
				arg_21_1.var_.characterEffect10058ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect10058ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect10058ui_story then
				arg_21_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_8 = arg_21_1.actors_["10066ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect10066ui_story == nil then
				arg_21_1.var_.characterEffect10066ui_story = var_24_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_9 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.characterEffect10066ui_story and not isNil(var_24_8) then
					arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_9)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect10066ui_story then
				arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_24_10 = arg_21_1.actors_["10066ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10066ui_story = var_24_10.localPosition
			end

			local var_24_11 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_11 then
				var_24_10.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_21_1.time_ - 0) / var_24_11)
				var_24_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_10.position).x, (manager.ui.mainCamera.transform.position - var_24_10.position).y, (manager.ui.mainCamera.transform.position - var_24_10.position).z)
				var_24_10.localEulerAngles.z = 0
				var_24_10.localEulerAngles.x = 0
				var_24_10.localEulerAngles = var_24_10.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_11 and arg_21_1.time_ < 0 + var_24_11 + arg_24_0 then
				var_24_10.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_24_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_10.position).x, (manager.ui.mainCamera.transform.position - var_24_10.position).y, (manager.ui.mainCamera.transform.position - var_24_10.position).z)
				var_24_10.localEulerAngles.z = 0
				var_24_10.localEulerAngles.x = 0
				var_24_10.localEulerAngles = var_24_10.localEulerAngles
			end

			local var_24_12 = 0
			local var_24_13 = 0.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(411311005).content)

				arg_21_1.text_.text = var_24_14

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_16 = 10 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_14) / 10)

				if (10 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_14) / 10)) > 0 and var_24_13 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_14
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_17 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_17 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_17

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_17 and arg_21_1.time_ < var_24_12 + var_24_17 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play411311006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 411311006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play411311007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10066ui_story = arg_25_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10066ui_story"].transform.position).z)
				arg_25_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10066ui_story"].transform.localEulerAngles = arg_25_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_25_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10066ui_story"].transform.position).z)
				arg_25_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10066ui_story"].transform.localEulerAngles = arg_25_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["10066ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10066ui_story == nil then
				arg_25_1.var_.characterEffect10066ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect10066ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect10066ui_story then
				arg_25_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_28_4 = arg_25_1.actors_["10058ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10058ui_story == nil then
				arg_25_1.var_.characterEffect10058ui_story = var_28_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_5 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_4) then
				if arg_25_1.var_.characterEffect10058ui_story and not isNil(var_28_4) then
					arg_25_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_5)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_4) and arg_25_1.var_.characterEffect10058ui_story then
				arg_25_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_28_6 = 0
			local var_28_7 = 0.925

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_8 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(411311006).content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 37 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_8) / 37)

				if (37 <= 0 and var_28_7 or var_28_7 * (utf8.len(var_28_8) / 37)) > 0 and var_28_7 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_11 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_11 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_11

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_11 and arg_25_1.time_ < var_28_6 + var_28_11 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play411311007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 411311007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play411311008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10058ui_story = arg_29_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10058ui_story"].transform.position).z)
				arg_29_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10058ui_story"].transform.localEulerAngles = arg_29_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_29_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10058ui_story"].transform.position).z)
				arg_29_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10058ui_story"].transform.localEulerAngles = arg_29_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10058ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10058ui_story == nil then
				arg_29_1.var_.characterEffect10058ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10058ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10058ui_story then
				arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_32_4 = arg_29_1.actors_["10066ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect10066ui_story == nil then
				arg_29_1.var_.characterEffect10066ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_5 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 and not isNil(var_32_4) then
				if arg_29_1.var_.characterEffect10066ui_story and not isNil(var_32_4) then
					arg_29_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_5)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect10066ui_story then
				arg_29_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_32_6 = 0
			local var_32_7 = 0.35

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(411311007).content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 14 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_8) / 14)

				if (14 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_8) / 14)) > 0 and var_32_7 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_11 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_11 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_11

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_11 and arg_29_1.time_ < var_32_6 + var_32_11 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play411311008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 411311008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play411311009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10066ui_story = arg_33_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10066ui_story"].transform.position).z)
				arg_33_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10066ui_story"].transform.localEulerAngles = arg_33_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_33_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10066ui_story"].transform.position).z)
				arg_33_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10066ui_story"].transform.localEulerAngles = arg_33_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["10066ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10066ui_story == nil then
				arg_33_1.var_.characterEffect10066ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect10066ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10066ui_story then
				arg_33_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_36_4 = arg_33_1.actors_["10058ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect10058ui_story == nil then
				arg_33_1.var_.characterEffect10058ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect10058ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect10058ui_story then
				arg_33_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_36_6 = 0
			local var_36_7 = 0.15

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(411311008).content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 6 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_8) / 6)

				if (6 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_8) / 6)) > 0 and var_36_7 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_11 and arg_33_1.time_ < var_36_6 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play411311009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 411311009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play411311010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10066ui_story = arg_37_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10066ui_story"].transform.position).z)
				arg_37_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10066ui_story"].transform.localEulerAngles = arg_37_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10066ui_story"].transform.position).z)
				arg_37_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10066ui_story"].transform.localEulerAngles = arg_37_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10066ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10066ui_story == nil then
				arg_37_1.var_.characterEffect10066ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10066ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_2)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10066ui_story then
				arg_37_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_40_3 = arg_37_1.actors_["10058ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10058ui_story = var_40_3.localPosition
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_3.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_4)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_3.localPosition = Vector3.New(0, 100, 0)
				var_40_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_3.position).x, (manager.ui.mainCamera.transform.position - var_40_3.position).y, (manager.ui.mainCamera.transform.position - var_40_3.position).z)
				var_40_3.localEulerAngles.z = 0
				var_40_3.localEulerAngles.x = 0
				var_40_3.localEulerAngles = var_40_3.localEulerAngles
			end

			local var_40_5 = arg_37_1.actors_["10058ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10058ui_story == nil then
				arg_37_1.var_.characterEffect10058ui_story = var_40_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_6 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 and not isNil(var_40_5) then
				if arg_37_1.var_.characterEffect10058ui_story and not isNil(var_40_5) then
					arg_37_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_6)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 and not isNil(var_40_5) and arg_37_1.var_.characterEffect10058ui_story then
				arg_37_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_40_7 = 0
			local var_40_8 = 0.725

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(411311009).content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 29 <= 0 and var_40_8 or var_40_8 * (utf8.len(var_40_9) / 29)

				if (29 <= 0 and var_40_8 or var_40_8 * (utf8.len(var_40_9) / 29)) > 0 and var_40_8 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_12 and arg_37_1.time_ < var_40_7 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play411311010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 411311010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play411311011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10058ui_story = arg_41_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10058ui_story"].transform.position).z)
				arg_41_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10058ui_story"].transform.localEulerAngles = arg_41_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_41_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10058ui_story"].transform.position).z)
				arg_41_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10058ui_story"].transform.localEulerAngles = arg_41_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["10058ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10058ui_story == nil then
				arg_41_1.var_.characterEffect10058ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect10058ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10058ui_story then
				arg_41_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_44_4 = arg_41_1.actors_["10066ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10066ui_story = var_44_4.localPosition
			end

			local var_44_5 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 then
				var_44_4.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_41_1.time_ - 0) / var_44_5)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 then
				var_44_4.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_44_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_4.position).x, (manager.ui.mainCamera.transform.position - var_44_4.position).y, (manager.ui.mainCamera.transform.position - var_44_4.position).z)
				var_44_4.localEulerAngles.z = 0
				var_44_4.localEulerAngles.x = 0
				var_44_4.localEulerAngles = var_44_4.localEulerAngles
			end

			local var_44_6 = arg_41_1.actors_["10066ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect10066ui_story == nil then
				arg_41_1.var_.characterEffect10066ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_7 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 and not isNil(var_44_6) then
				if arg_41_1.var_.characterEffect10066ui_story and not isNil(var_44_6) then
					arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_7)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect10066ui_story then
				arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_44_8 = 0
			local var_44_9 = 0.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_10 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(411311010).content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_12 = 15 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_10) / 15)

				if (15 <= 0 and var_44_9 or var_44_9 * (utf8.len(var_44_10) / 15)) > 0 and var_44_9 < var_44_12 then
					arg_41_1.talkMaxDuration = var_44_12

					if var_44_12 + var_44_8 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_8
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_9, arg_41_1.talkMaxDuration)

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_8) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_8 + var_44_13 and arg_41_1.time_ < var_44_8 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play411311011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 411311011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play411311012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10066ui_story = arg_45_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10066ui_story"].transform.position).z)
				arg_45_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10066ui_story"].transform.localEulerAngles = arg_45_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_45_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["10066ui_story"].transform.position).z)
				arg_45_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["10066ui_story"].transform.localEulerAngles = arg_45_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["10066ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect10066ui_story == nil then
				arg_45_1.var_.characterEffect10066ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect10066ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect10066ui_story then
				arg_45_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = arg_45_1.actors_["10058ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect10058ui_story == nil then
				arg_45_1.var_.characterEffect10058ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect10058ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect10058ui_story then
				arg_45_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_48_6 = 0
			local var_48_7 = 0.5

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(411311011).content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 20 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_8) / 20)

				if (20 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_8) / 20)) > 0 and var_48_7 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_11 and arg_45_1.time_ < var_48_6 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play411311012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 411311012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play411311013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10066ui_story"]) and arg_49_1.var_.characterEffect10066ui_story == nil then
				arg_49_1.var_.characterEffect10066ui_story = arg_49_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10066ui_story"]) then
				if arg_49_1.var_.characterEffect10066ui_story and not isNil(arg_49_1.actors_["10066ui_story"]) then
					arg_49_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10066ui_story"]) and arg_49_1.var_.characterEffect10066ui_story then
				arg_49_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.825

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(411311012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 33 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 33)

				if (33 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 33)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play411311013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 411311013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play411311014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action446")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_56_0 = arg_53_1.actors_["10066ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10066ui_story == nil then
				arg_53_1.var_.characterEffect10066ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_1 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 and not isNil(var_56_0) then
				if arg_53_1.var_.characterEffect10066ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10066ui_story then
				arg_53_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_56_3 = 0
			local var_56_4 = 0.525

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(411311013).content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 21 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 21)

				if (21 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 21)) > 0 and var_56_4 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_8 and arg_53_1.time_ < var_56_3 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play411311014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 411311014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play411311015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(411311014).content)

				arg_57_1.text_.text = var_60_1

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_3 = 28 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 28)

				if (28 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_1) / 28)) > 0 and var_60_0 < var_60_3 then
					arg_57_1.talkMaxDuration = var_60_3

					if var_60_3 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_3 + 0
					end
				end

				arg_57_1.text_.text = var_60_1
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_4 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_4

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play411311015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 411311015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play411311016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10058ui_story = arg_61_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10058ui_story"].transform.position).z)
				arg_61_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10058ui_story"].transform.localEulerAngles = arg_61_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_61_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10058ui_story"].transform.position).z)
				arg_61_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10058ui_story"].transform.localEulerAngles = arg_61_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10058ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10058ui_story == nil then
				arg_61_1.var_.characterEffect10058ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10058ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10058ui_story then
				arg_61_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_64_4 = arg_61_1.actors_["10066ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect10066ui_story == nil then
				arg_61_1.var_.characterEffect10066ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 and not isNil(var_64_4) then
				if arg_61_1.var_.characterEffect10066ui_story and not isNil(var_64_4) then
					arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_5)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect10066ui_story then
				arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_64_6 = 0
			local var_64_7 = 0.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(411311015).content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 4 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_8) / 4)

				if (4 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_8) / 4)) > 0 and var_64_7 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_11 and arg_61_1.time_ < var_64_6 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play411311016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 411311016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play411311017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10058ui_story = arg_65_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).z)
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles = arg_65_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_65_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).z)
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles = arg_65_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["10058ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10058ui_story == nil then
				arg_65_1.var_.characterEffect10058ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect10058ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_2)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10058ui_story then
				arg_65_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_68_3 = arg_65_1.actors_["10066ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10066ui_story == nil then
				arg_65_1.var_.characterEffect10066ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect10066ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10066ui_story then
				arg_65_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_68_6 = 0
			local var_68_7 = 0.575

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(411311016).content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 23 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_8) / 23)

				if (23 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_8) / 23)) > 0 and var_68_7 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_11 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_11 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_11

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_11 and arg_65_1.time_ < var_68_6 + var_68_11 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play411311017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 411311017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play411311018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10058ui_story = arg_69_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).z)
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles = arg_69_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_69_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["10058ui_story"].transform.position).z)
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["10058ui_story"].transform.localEulerAngles = arg_69_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["10058ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10058ui_story == nil then
				arg_69_1.var_.characterEffect10058ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10058ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10058ui_story then
				arg_69_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_2")
			end

			local var_72_4 = arg_69_1.actors_["10066ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect10066ui_story == nil then
				arg_69_1.var_.characterEffect10066ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_5 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 and not isNil(var_72_4) then
				if arg_69_1.var_.characterEffect10066ui_story and not isNil(var_72_4) then
					arg_69_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_5)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect10066ui_story then
				arg_69_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_72_6 = 0
			local var_72_7 = 0.2

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(411311017).content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 8 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_8) / 8)

				if (8 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_8) / 8)) > 0 and var_72_7 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_11 and arg_69_1.time_ < var_72_6 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play411311018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 411311018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play411311019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10058ui_story"]) and arg_73_1.var_.characterEffect10058ui_story == nil then
				arg_73_1.var_.characterEffect10058ui_story = arg_73_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10058ui_story"]) then
				if arg_73_1.var_.characterEffect10058ui_story and not isNil(arg_73_1.actors_["10058ui_story"]) then
					arg_73_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10058ui_story"]) and arg_73_1.var_.characterEffect10058ui_story then
				arg_73_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_76_1 = 0
			local var_76_2 = 1.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(411311018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 48 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 48)

				if (48 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 48)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play411311019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 411311019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play411311020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10066ui_story = arg_77_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).z)
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles = arg_77_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_77_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10066ui_story"].transform.position).z)
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10066ui_story"].transform.localEulerAngles = arg_77_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10066ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10066ui_story == nil then
				arg_77_1.var_.characterEffect10066ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect10066ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10066ui_story then
				arg_77_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.5

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(411311019).content)

				arg_77_1.text_.text = var_80_6

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_8 = 20 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_6) / 20)

				if (20 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_6) / 20)) > 0 and var_80_5 < var_80_8 then
					arg_77_1.talkMaxDuration = var_80_8

					if var_80_8 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_6
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_9 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_9 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_9

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_9 and arg_77_1.time_ < var_80_4 + var_80_9 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play411311020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 411311020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play411311021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10058ui_story = arg_81_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10058ui_story"].transform.position).z)
				arg_81_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10058ui_story"].transform.localEulerAngles = arg_81_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_81_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["10058ui_story"].transform.position).z)
				arg_81_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["10058ui_story"].transform.localEulerAngles = arg_81_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["10058ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10058ui_story == nil then
				arg_81_1.var_.characterEffect10058ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect10058ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect10058ui_story then
				arg_81_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_84_4 = arg_81_1.actors_["10066ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10066ui_story == nil then
				arg_81_1.var_.characterEffect10066ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_5 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 and not isNil(var_84_4) then
				if arg_81_1.var_.characterEffect10066ui_story and not isNil(var_84_4) then
					arg_81_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_5)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10066ui_story then
				arg_81_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			local var_84_6 = arg_81_1.actors_["10066ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10066ui_story = var_84_6.localPosition
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_6.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_81_1.time_ - 0) / var_84_7)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_6.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			local var_84_8 = 0
			local var_84_9 = 0.3

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_10 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_10:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_11 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(411311020).content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 12 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 12)

				if (12 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 12)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13
					var_84_8 = var_84_8 + 0.3

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = var_84_8 + 0.3
			local var_84_15 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_14 + var_84_15 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_14) / var_84_15

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_14 + var_84_15 and arg_81_1.time_ < var_84_14 + var_84_15 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play411311021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411311021
		arg_87_1.duration_ = 7.53

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411311022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.bgs_.ST02 == nil then
				local var_90_0 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST02")
				var_90_0.name = "ST02"
				var_90_0.transform.parent = arg_87_1.stage_.transform
				var_90_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_.ST02 = var_90_0
			end

			if 1.025 < arg_87_1.time_ and arg_87_1.time_ <= 1.025 + arg_90_0 then
				local var_90_1 = arg_87_1.bgs_.ST02

				arg_87_1.bgs_.ST02.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_2 = var_90_1:GetComponent("SpriteRenderer")

				if var_90_2 and var_90_2.sprite then
					local var_90_3 = 2 * (var_90_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_1.transform.localScale = Vector3.New(var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, var_90_3 / var_90_2.sprite.bounds.size.y < var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x and var_90_3 * manager.ui.mainCameraCom_.aspect / var_90_2.sprite.bounds.size.x or var_90_3 / var_90_2.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "ST02" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_4 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_5 = 1.025

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_5 then
				local var_90_6 = Color.New(0, 0, 0)

				var_90_6.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_4) / var_90_5)
				arg_87_1.mask_.color = var_90_6
			end

			if arg_87_1.time_ >= var_90_4 + var_90_5 and arg_87_1.time_ < var_90_4 + var_90_5 + arg_90_0 then
				local var_90_7 = Color.New(0, 0, 0)

				var_90_7.a = 1
				arg_87_1.mask_.color = var_90_7
			end

			local var_90_8 = 1.025

			if 1.025 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_9 = 2

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_9 then
				local var_90_10 = Color.New(0, 0, 0)

				var_90_10.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_8) / var_90_9)
				arg_87_1.mask_.color = var_90_10
			end

			if arg_87_1.time_ >= var_90_8 + var_90_9 and arg_87_1.time_ < var_90_8 + var_90_9 + arg_90_0 then
				local var_90_11 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_11.a = 0
				arg_87_1.mask_.color = var_90_11
			end

			local var_90_12 = arg_87_1.actors_["10058ui_story"].transform

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= 1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10058ui_story = var_90_12.localPosition
			end

			local var_90_13 = 0.001

			if 1 <= arg_87_1.time_ and arg_87_1.time_ < 1 + var_90_13 then
				var_90_12.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 1) / var_90_13)
				var_90_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_12.position).x, (manager.ui.mainCamera.transform.position - var_90_12.position).y, (manager.ui.mainCamera.transform.position - var_90_12.position).z)
				var_90_12.localEulerAngles.z = 0
				var_90_12.localEulerAngles.x = 0
				var_90_12.localEulerAngles = var_90_12.localEulerAngles
			end

			if arg_87_1.time_ >= 1 + var_90_13 and arg_87_1.time_ < 1 + var_90_13 + arg_90_0 then
				var_90_12.localPosition = Vector3.New(0, 100, 0)
				var_90_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_12.position).x, (manager.ui.mainCamera.transform.position - var_90_12.position).y, (manager.ui.mainCamera.transform.position - var_90_12.position).z)
				var_90_12.localEulerAngles.z = 0
				var_90_12.localEulerAngles.x = 0
				var_90_12.localEulerAngles = var_90_12.localEulerAngles
			end

			local var_90_14 = arg_87_1.actors_["10058ui_story"]

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= 1 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.characterEffect10058ui_story == nil then
				arg_87_1.var_.characterEffect10058ui_story = var_90_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_15 = 0.200000002980232

			if 1 <= arg_87_1.time_ and arg_87_1.time_ < 1 + var_90_15 and not isNil(var_90_14) then
				if arg_87_1.var_.characterEffect10058ui_story and not isNil(var_90_14) then
					arg_87_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 1) / var_90_15)
				end
			end

			if arg_87_1.time_ >= 1 + var_90_15 and arg_87_1.time_ < 1 + var_90_15 + arg_90_0 and not isNil(var_90_14) and arg_87_1.var_.characterEffect10058ui_story then
				arg_87_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_90_16 = arg_87_1.actors_["10066ui_story"].transform

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= 1 + arg_90_0 then
				arg_87_1.var_.moveOldPos10066ui_story = var_90_16.localPosition
			end

			local var_90_17 = 0.001

			if 1 <= arg_87_1.time_ and arg_87_1.time_ < 1 + var_90_17 then
				var_90_16.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 1) / var_90_17)
				var_90_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_16.position).x, (manager.ui.mainCamera.transform.position - var_90_16.position).y, (manager.ui.mainCamera.transform.position - var_90_16.position).z)
				var_90_16.localEulerAngles.z = 0
				var_90_16.localEulerAngles.x = 0
				var_90_16.localEulerAngles = var_90_16.localEulerAngles
			end

			if arg_87_1.time_ >= 1 + var_90_17 and arg_87_1.time_ < 1 + var_90_17 + arg_90_0 then
				var_90_16.localPosition = Vector3.New(0, 100, 0)
				var_90_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_16.position).x, (manager.ui.mainCamera.transform.position - var_90_16.position).y, (manager.ui.mainCamera.transform.position - var_90_16.position).z)
				var_90_16.localEulerAngles.z = 0
				var_90_16.localEulerAngles.x = 0
				var_90_16.localEulerAngles = var_90_16.localEulerAngles
			end

			local var_90_18 = arg_87_1.actors_["10066ui_story"]

			if 1 < arg_87_1.time_ and arg_87_1.time_ <= 1 + arg_90_0 and not isNil(var_90_18) and arg_87_1.var_.characterEffect10066ui_story == nil then
				arg_87_1.var_.characterEffect10066ui_story = var_90_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_19 = 0.200000002980232

			if 1 <= arg_87_1.time_ and arg_87_1.time_ < 1 + var_90_19 and not isNil(var_90_18) then
				if arg_87_1.var_.characterEffect10066ui_story and not isNil(var_90_18) then
					arg_87_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 1) / var_90_19)
				end
			end

			if arg_87_1.time_ >= 1 + var_90_19 and arg_87_1.time_ < 1 + var_90_19 + arg_90_0 and not isNil(var_90_18) and arg_87_1.var_.characterEffect10066ui_story then
				arg_87_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0.833333333333333 < arg_87_1.time_ and arg_87_1.time_ <= 0.833333333333333 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_21 = 2.53333333333333
			local var_90_22 = 1.025

			if 2.53333333333333 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_23 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_23:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_24 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(411311021).content)

				arg_87_1.text_.text = var_90_24

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_26 = 41 <= 0 and var_90_22 or var_90_22 * (utf8.len(var_90_24) / 41)

				if (41 <= 0 and var_90_22 or var_90_22 * (utf8.len(var_90_24) / 41)) > 0 and var_90_22 < var_90_26 then
					arg_87_1.talkMaxDuration = var_90_26
					var_90_21 = var_90_21 + 0.3

					if var_90_26 + var_90_21 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_26 + var_90_21
					end
				end

				arg_87_1.text_.text = var_90_24
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_27 = var_90_21 + 0.3
			local var_90_28 = math.max(var_90_22, arg_87_1.talkMaxDuration)

			if var_90_21 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_27 + var_90_28 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_27) / var_90_28

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_27 + var_90_28 and arg_87_1.time_ < var_90_27 + var_90_28 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play411311022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 411311022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play411311023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(411311022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 48 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 48)

				if (48 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 48)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play411311023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 411311023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play411311024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10066ui_story = arg_97_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).z)
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles = arg_97_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_97_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10066ui_story"].transform.position).z)
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10066ui_story"].transform.localEulerAngles = arg_97_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10066ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10066ui_story == nil then
				arg_97_1.var_.characterEffect10066ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10066ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10066ui_story then
				arg_97_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.725

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(411311023).content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_8 = 29 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 29)

				if (29 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_6) / 29)) > 0 and var_100_5 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_9 and arg_97_1.time_ < var_100_4 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play411311024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 411311024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play411311025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10066ui_story"]) and arg_101_1.var_.characterEffect10066ui_story == nil then
				arg_101_1.var_.characterEffect10066ui_story = arg_101_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10066ui_story"]) then
				if arg_101_1.var_.characterEffect10066ui_story and not isNil(arg_101_1.actors_["10066ui_story"]) then
					arg_101_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10066ui_story"]) and arg_101_1.var_.characterEffect10066ui_story then
				arg_101_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.65

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(411311024).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 26 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 26)

				if (26 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 26)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play411311025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411311025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play411311026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10066ui_story = arg_105_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).z)
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles = arg_105_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_105_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10066ui_story"].transform.position).z)
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10066ui_story"].transform.localEulerAngles = arg_105_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10066ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10066ui_story == nil then
				arg_105_1.var_.characterEffect10066ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10066ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10066ui_story then
				arg_105_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_108_4 = 0
			local var_108_5 = 0.625

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(411311025).content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_8 = 25 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 25)

				if (25 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_6) / 25)) > 0 and var_108_5 < var_108_8 then
					arg_105_1.talkMaxDuration = var_108_8

					if var_108_8 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_9 and arg_105_1.time_ < var_108_4 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play411311026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 411311026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play411311027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10058ui_story = arg_109_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10058ui_story"].transform.position).z)
				arg_109_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10058ui_story"].transform.localEulerAngles = arg_109_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_109_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10058ui_story"].transform.position).z)
				arg_109_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10058ui_story"].transform.localEulerAngles = arg_109_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["10058ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10058ui_story == nil then
				arg_109_1.var_.characterEffect10058ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect10058ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10058ui_story then
				arg_109_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_112_4 = arg_109_1.actors_["10066ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect10066ui_story == nil then
				arg_109_1.var_.characterEffect10066ui_story = var_112_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_5 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_5 and not isNil(var_112_4) then
				if arg_109_1.var_.characterEffect10066ui_story and not isNil(var_112_4) then
					arg_109_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_5)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_5 and arg_109_1.time_ < 0 + var_112_5 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect10066ui_story then
				arg_109_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_112_6 = arg_109_1.actors_["10066ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10066ui_story = var_112_6.localPosition
			end

			local var_112_7 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				var_112_6.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_109_1.time_ - 0) / var_112_7)
				var_112_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_6.position).x, (manager.ui.mainCamera.transform.position - var_112_6.position).y, (manager.ui.mainCamera.transform.position - var_112_6.position).z)
				var_112_6.localEulerAngles.z = 0
				var_112_6.localEulerAngles.x = 0
				var_112_6.localEulerAngles = var_112_6.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				var_112_6.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_112_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_6.position).x, (manager.ui.mainCamera.transform.position - var_112_6.position).y, (manager.ui.mainCamera.transform.position - var_112_6.position).z)
				var_112_6.localEulerAngles.z = 0
				var_112_6.localEulerAngles.x = 0
				var_112_6.localEulerAngles = var_112_6.localEulerAngles
			end

			local var_112_8 = 0
			local var_112_9 = 0.3

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(411311026).content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_12 = 12 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_10) / 12)

				if (12 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_10) / 12)) > 0 and var_112_9 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_13 and arg_109_1.time_ < var_112_8 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play411311027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 411311027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play411311028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10066ui_story = arg_113_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10066ui_story"].transform.position).z)
				arg_113_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10066ui_story"].transform.localEulerAngles = arg_113_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_113_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10066ui_story"].transform.position).z)
				arg_113_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10066ui_story"].transform.localEulerAngles = arg_113_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10066ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10066ui_story == nil then
				arg_113_1.var_.characterEffect10066ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10066ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10066ui_story then
				arg_113_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_116_4 = arg_113_1.actors_["10058ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect10058ui_story == nil then
				arg_113_1.var_.characterEffect10058ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_5 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 and not isNil(var_116_4) then
				if arg_113_1.var_.characterEffect10058ui_story and not isNil(var_116_4) then
					arg_113_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_5)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect10058ui_story then
				arg_113_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_116_6 = 0
			local var_116_7 = 0.275

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(411311027).content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 11 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_8) / 11)

				if (11 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_8) / 11)) > 0 and var_116_7 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_11 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_11 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_11

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_11 and arg_113_1.time_ < var_116_6 + var_116_11 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play411311028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 411311028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play411311029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10066ui_story"]) and arg_117_1.var_.characterEffect10066ui_story == nil then
				arg_117_1.var_.characterEffect10066ui_story = arg_117_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10066ui_story"]) then
				if arg_117_1.var_.characterEffect10066ui_story and not isNil(arg_117_1.actors_["10066ui_story"]) then
					arg_117_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10066ui_story"]) and arg_117_1.var_.characterEffect10066ui_story then
				arg_117_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.8

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(411311028).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 32 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 32)

				if (32 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 32)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play411311029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 411311029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play411311030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10066ui_story = arg_121_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10066ui_story"].transform.position).z)
				arg_121_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10066ui_story"].transform.localEulerAngles = arg_121_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_121_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["10066ui_story"].transform.position).z)
				arg_121_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["10066ui_story"].transform.localEulerAngles = arg_121_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["10066ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10066ui_story == nil then
				arg_121_1.var_.characterEffect10066ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect10066ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect10066ui_story then
				arg_121_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_124_4 = 0
			local var_124_5 = 1.15

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(411311029).content)

				arg_121_1.text_.text = var_124_6

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_8 = 46 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_6) / 46)

				if (46 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_6) / 46)) > 0 and var_124_5 < var_124_8 then
					arg_121_1.talkMaxDuration = var_124_8

					if var_124_8 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_8 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_6
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_9 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_9 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_9

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_9 and arg_121_1.time_ < var_124_4 + var_124_9 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play411311030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 411311030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play411311031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10058ui_story = arg_125_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10058ui_story"].transform.position).z)
				arg_125_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10058ui_story"].transform.localEulerAngles = arg_125_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_125_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10058ui_story"].transform.position).z)
				arg_125_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10058ui_story"].transform.localEulerAngles = arg_125_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["10058ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10058ui_story == nil then
				arg_125_1.var_.characterEffect10058ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect10058ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10058ui_story then
				arg_125_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["10066ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect10066ui_story == nil then
				arg_125_1.var_.characterEffect10066ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_5 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 and not isNil(var_128_4) then
				if arg_125_1.var_.characterEffect10066ui_story and not isNil(var_128_4) then
					arg_125_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_5)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect10066ui_story then
				arg_125_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_128_6 = 0
			local var_128_7 = 0.4

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(411311030).content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 16 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_8) / 16)

				if (16 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_8) / 16)) > 0 and var_128_7 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_11 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_11 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_11

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_11 and arg_125_1.time_ < var_128_6 + var_128_11 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play411311031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 411311031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play411311032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10066ui_story = arg_129_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10066ui_story"].transform.position).z)
				arg_129_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10066ui_story"].transform.localEulerAngles = arg_129_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_129_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10066ui_story"].transform.position).z)
				arg_129_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10066ui_story"].transform.localEulerAngles = arg_129_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["10066ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10066ui_story == nil then
				arg_129_1.var_.characterEffect10066ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect10066ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10066ui_story then
				arg_129_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_132_4 = arg_129_1.actors_["10058ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect10058ui_story == nil then
				arg_129_1.var_.characterEffect10058ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_5 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 and not isNil(var_132_4) then
				if arg_129_1.var_.characterEffect10058ui_story and not isNil(var_132_4) then
					arg_129_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_5)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect10058ui_story then
				arg_129_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_132_6 = 0
			local var_132_7 = 1.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(411311031).content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 61 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 61)

				if (61 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_8) / 61)) > 0 and var_132_7 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_11 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_11 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_11

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_11 and arg_129_1.time_ < var_132_6 + var_132_11 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play411311032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 411311032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play411311033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10066ui_story"]) and arg_133_1.var_.characterEffect10066ui_story == nil then
				arg_133_1.var_.characterEffect10066ui_story = arg_133_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10066ui_story"]) then
				if arg_133_1.var_.characterEffect10066ui_story and not isNil(arg_133_1.actors_["10066ui_story"]) then
					arg_133_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10066ui_story"]) and arg_133_1.var_.characterEffect10066ui_story then
				arg_133_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 1.475

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(411311032).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 59 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 59)

				if (59 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 59)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play411311033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 411311033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play411311034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10058ui_story = arg_137_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10058ui_story"].transform.position).z)
				arg_137_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10058ui_story"].transform.localEulerAngles = arg_137_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_137_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["10058ui_story"].transform.position).z)
				arg_137_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["10058ui_story"].transform.localEulerAngles = arg_137_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["10058ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10058ui_story == nil then
				arg_137_1.var_.characterEffect10058ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect10058ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect10058ui_story then
				arg_137_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_140_4 = 0
			local var_140_5 = 0.15

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(411311033).content)

				arg_137_1.text_.text = var_140_6

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_8 = 6 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_6) / 6)

				if (6 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_6) / 6)) > 0 and var_140_5 < var_140_8 then
					arg_137_1.talkMaxDuration = var_140_8

					if var_140_8 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_6
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_9 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_9 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_9

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_9 and arg_137_1.time_ < var_140_4 + var_140_9 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play411311034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 411311034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play411311035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10066ui_story = arg_141_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10066ui_story"].transform.position).z)
				arg_141_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10066ui_story"].transform.localEulerAngles = arg_141_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_141_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10066ui_story"].transform.position).z)
				arg_141_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10066ui_story"].transform.localEulerAngles = arg_141_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["10066ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10066ui_story == nil then
				arg_141_1.var_.characterEffect10066ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10066ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10066ui_story then
				arg_141_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_144_4 = arg_141_1.actors_["10058ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect10058ui_story == nil then
				arg_141_1.var_.characterEffect10058ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_5 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 and not isNil(var_144_4) then
				if arg_141_1.var_.characterEffect10058ui_story and not isNil(var_144_4) then
					arg_141_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_5)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect10058ui_story then
				arg_141_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_144_6 = 0
			local var_144_7 = 0.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_8 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(411311034).content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 14 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_8) / 14)

				if (14 <= 0 and var_144_7 or var_144_7 * (utf8.len(var_144_8) / 14)) > 0 and var_144_7 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_11 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_11 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_11

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_11 and arg_141_1.time_ < var_144_6 + var_144_11 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play411311035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 411311035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play411311036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action436")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_148_0 = 0
			local var_148_1 = 0.8

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(411311035).content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 32 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_2) / 32)

				if (32 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_2) / 32)) > 0 and var_148_1 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_5 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_5 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_5

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_5 and arg_145_1.time_ < var_148_0 + var_148_5 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play411311036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 411311036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play411311037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10058ui_story = arg_149_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10058ui_story"].transform.position).z)
				arg_149_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["10058ui_story"].transform.localEulerAngles = arg_149_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_149_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["10058ui_story"].transform.position).z)
				arg_149_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["10058ui_story"].transform.localEulerAngles = arg_149_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["10058ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect10058ui_story == nil then
				arg_149_1.var_.characterEffect10058ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect10058ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect10058ui_story then
				arg_149_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_152_4 = arg_149_1.actors_["10066ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10066ui_story == nil then
				arg_149_1.var_.characterEffect10066ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect10066ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10066ui_story then
				arg_149_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action4_1")
			end

			local var_152_6 = 0
			local var_152_7 = 0.325

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(411311036).content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 13 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_8) / 13)

				if (13 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_8) / 13)) > 0 and var_152_7 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_11 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_11 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_11

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_11 and arg_149_1.time_ < var_152_6 + var_152_11 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play411311037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 411311037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play411311038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10066ui_story = arg_153_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10066ui_story"].transform.position).z)
				arg_153_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10066ui_story"].transform.localEulerAngles = arg_153_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_153_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10066ui_story"].transform.position).z)
				arg_153_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10066ui_story"].transform.localEulerAngles = arg_153_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["10066ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10066ui_story == nil then
				arg_153_1.var_.characterEffect10066ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect10066ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10066ui_story then
				arg_153_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action467")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_156_4 = arg_153_1.actors_["10058ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10058ui_story == nil then
				arg_153_1.var_.characterEffect10058ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_5 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 and not isNil(var_156_4) then
				if arg_153_1.var_.characterEffect10058ui_story and not isNil(var_156_4) then
					arg_153_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_5)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10058ui_story then
				arg_153_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_156_6 = 0
			local var_156_7 = 0.575

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_8 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(411311037).content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 23 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_8) / 23)

				if (23 <= 0 and var_156_7 or var_156_7 * (utf8.len(var_156_8) / 23)) > 0 and var_156_7 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_6 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_6
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_11 = math.max(var_156_7, arg_153_1.talkMaxDuration)

			if var_156_6 <= arg_153_1.time_ and arg_153_1.time_ < var_156_6 + var_156_11 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_6) / var_156_11

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_6 + var_156_11 and arg_153_1.time_ < var_156_6 + var_156_11 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play411311038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 411311038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play411311039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10058ui_story = arg_157_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10058ui_story"].transform.position).z)
				arg_157_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10058ui_story"].transform.localEulerAngles = arg_157_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_157_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10058ui_story"].transform.position).z)
				arg_157_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10058ui_story"].transform.localEulerAngles = arg_157_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["10058ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10058ui_story == nil then
				arg_157_1.var_.characterEffect10058ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect10058ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect10058ui_story then
				arg_157_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_160_4 = arg_157_1.actors_["10066ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect10066ui_story == nil then
				arg_157_1.var_.characterEffect10066ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_5 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 and not isNil(var_160_4) then
				if arg_157_1.var_.characterEffect10066ui_story and not isNil(var_160_4) then
					arg_157_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_5)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect10066ui_story then
				arg_157_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_160_6 = 0
			local var_160_7 = 0.225

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(411311038).content)

				arg_157_1.text_.text = var_160_8

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 9 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_8) / 9)

				if (9 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_8) / 9)) > 0 and var_160_7 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_8
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_11 and arg_157_1.time_ < var_160_6 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play411311039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 411311039
		arg_161_1.duration_ = 8.73

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play411311040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if arg_161_1.bgs_.ST74 == nil then
				local var_164_0 = Object.Instantiate(arg_161_1.paintGo_)

				var_164_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74")
				var_164_0.name = "ST74"
				var_164_0.transform.parent = arg_161_1.stage_.transform
				var_164_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.bgs_.ST74 = var_164_0
			end

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= 2 + arg_164_0 then
				local var_164_1 = arg_161_1.bgs_.ST74

				arg_161_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_164_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_164_2 = var_164_1:GetComponent("SpriteRenderer")

				if var_164_2 and var_164_2.sprite then
					local var_164_3 = 2 * (var_164_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_164_1.transform.localScale = Vector3.New(var_164_3 / var_164_2.sprite.bounds.size.y < var_164_3 * manager.ui.mainCameraCom_.aspect / var_164_2.sprite.bounds.size.x and var_164_3 * manager.ui.mainCameraCom_.aspect / var_164_2.sprite.bounds.size.x or var_164_3 / var_164_2.sprite.bounds.size.y, var_164_3 / var_164_2.sprite.bounds.size.y < var_164_3 * manager.ui.mainCameraCom_.aspect / var_164_2.sprite.bounds.size.x and var_164_3 * manager.ui.mainCameraCom_.aspect / var_164_2.sprite.bounds.size.x or var_164_3 / var_164_2.sprite.bounds.size.y, 0)
				end

				for iter_164_0, iter_164_1 in pairs(arg_161_1.bgs_) do
					if iter_164_0 ~= "ST74" then
						iter_164_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_164_4 = 0

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_5 = 2

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_5 then
				local var_164_6 = Color.New(0, 0, 0)

				var_164_6.a = Mathf.Lerp(0, 1, (arg_161_1.time_ - var_164_4) / var_164_5)
				arg_161_1.mask_.color = var_164_6
			end

			if arg_161_1.time_ >= var_164_4 + var_164_5 and arg_161_1.time_ < var_164_4 + var_164_5 + arg_164_0 then
				local var_164_7 = Color.New(0, 0, 0)

				var_164_7.a = 1
				arg_161_1.mask_.color = var_164_7
			end

			local var_164_8 = 2

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_9 = 2

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_9 then
				local var_164_10 = Color.New(0, 0, 0)

				var_164_10.a = Mathf.Lerp(1, 0, (arg_161_1.time_ - var_164_8) / var_164_9)
				arg_161_1.mask_.color = var_164_10
			end

			if arg_161_1.time_ >= var_164_8 + var_164_9 and arg_161_1.time_ < var_164_8 + var_164_9 + arg_164_0 then
				local var_164_11 = Color.New(0, 0, 0)

				arg_161_1.mask_.enabled = false
				var_164_11.a = 0
				arg_161_1.mask_.color = var_164_11
			end

			local var_164_12 = arg_161_1.actors_["10058ui_story"].transform

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= 2 + arg_164_0 then
				arg_161_1.var_.moveOldPos10058ui_story = var_164_12.localPosition
			end

			local var_164_13 = 0.001

			if 2 <= arg_161_1.time_ and arg_161_1.time_ < 2 + var_164_13 then
				var_164_12.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 2) / var_164_13)
				var_164_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_12.position).x, (manager.ui.mainCamera.transform.position - var_164_12.position).y, (manager.ui.mainCamera.transform.position - var_164_12.position).z)
				var_164_12.localEulerAngles.z = 0
				var_164_12.localEulerAngles.x = 0
				var_164_12.localEulerAngles = var_164_12.localEulerAngles
			end

			if arg_161_1.time_ >= 2 + var_164_13 and arg_161_1.time_ < 2 + var_164_13 + arg_164_0 then
				var_164_12.localPosition = Vector3.New(0, 100, 0)
				var_164_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_12.position).x, (manager.ui.mainCamera.transform.position - var_164_12.position).y, (manager.ui.mainCamera.transform.position - var_164_12.position).z)
				var_164_12.localEulerAngles.z = 0
				var_164_12.localEulerAngles.x = 0
				var_164_12.localEulerAngles = var_164_12.localEulerAngles
			end

			local var_164_14 = arg_161_1.actors_["10058ui_story"]

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= 2 + arg_164_0 and not isNil(var_164_14) and arg_161_1.var_.characterEffect10058ui_story == nil then
				arg_161_1.var_.characterEffect10058ui_story = var_164_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_15 = 0.200000002980232

			if 2 <= arg_161_1.time_ and arg_161_1.time_ < 2 + var_164_15 and not isNil(var_164_14) then
				if arg_161_1.var_.characterEffect10058ui_story and not isNil(var_164_14) then
					arg_161_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 2) / var_164_15)
				end
			end

			if arg_161_1.time_ >= 2 + var_164_15 and arg_161_1.time_ < 2 + var_164_15 + arg_164_0 and not isNil(var_164_14) and arg_161_1.var_.characterEffect10058ui_story then
				arg_161_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_164_16 = arg_161_1.actors_["10066ui_story"].transform

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= 2 + arg_164_0 then
				arg_161_1.var_.moveOldPos10066ui_story = var_164_16.localPosition
			end

			local var_164_17 = 0.001

			if 2 <= arg_161_1.time_ and arg_161_1.time_ < 2 + var_164_17 then
				var_164_16.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 2) / var_164_17)
				var_164_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_16.position).x, (manager.ui.mainCamera.transform.position - var_164_16.position).y, (manager.ui.mainCamera.transform.position - var_164_16.position).z)
				var_164_16.localEulerAngles.z = 0
				var_164_16.localEulerAngles.x = 0
				var_164_16.localEulerAngles = var_164_16.localEulerAngles
			end

			if arg_161_1.time_ >= 2 + var_164_17 and arg_161_1.time_ < 2 + var_164_17 + arg_164_0 then
				var_164_16.localPosition = Vector3.New(0, 100, 0)
				var_164_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_16.position).x, (manager.ui.mainCamera.transform.position - var_164_16.position).y, (manager.ui.mainCamera.transform.position - var_164_16.position).z)
				var_164_16.localEulerAngles.z = 0
				var_164_16.localEulerAngles.x = 0
				var_164_16.localEulerAngles = var_164_16.localEulerAngles
			end

			local var_164_18 = arg_161_1.actors_["10066ui_story"]

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= 2 + arg_164_0 and not isNil(var_164_18) and arg_161_1.var_.characterEffect10066ui_story == nil then
				arg_161_1.var_.characterEffect10066ui_story = var_164_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_19 = 0.200000002980232

			if 2 <= arg_161_1.time_ and arg_161_1.time_ < 2 + var_164_19 and not isNil(var_164_18) then
				if arg_161_1.var_.characterEffect10066ui_story and not isNil(var_164_18) then
					arg_161_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 2) / var_164_19)
				end
			end

			if arg_161_1.time_ >= 2 + var_164_19 and arg_161_1.time_ < 2 + var_164_19 + arg_164_0 and not isNil(var_164_18) and arg_161_1.var_.characterEffect10066ui_story then
				arg_161_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:AudioAction("stop", "effect", "se_story_221_00", "se_story_221_00_canteen_loop", "")
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_21 = 3.73333333333333
			local var_164_22 = 1.175

			if 3.73333333333333 < arg_161_1.time_ and arg_161_1.time_ <= var_164_21 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_23 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_23:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_24 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(411311039).content)

				arg_161_1.text_.text = var_164_24

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_26 = 47 <= 0 and var_164_22 or var_164_22 * (utf8.len(var_164_24) / 47)

				if (47 <= 0 and var_164_22 or var_164_22 * (utf8.len(var_164_24) / 47)) > 0 and var_164_22 < var_164_26 then
					arg_161_1.talkMaxDuration = var_164_26
					var_164_21 = var_164_21 + 0.3

					if var_164_26 + var_164_21 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_26 + var_164_21
					end
				end

				arg_161_1.text_.text = var_164_24
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_27 = var_164_21 + 0.3
			local var_164_28 = math.max(var_164_22, arg_161_1.talkMaxDuration)

			if var_164_21 + 0.3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_27 + var_164_28 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_27) / var_164_28

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_27 + var_164_28 and arg_161_1.time_ < var_164_27 + var_164_28 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play411311040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411311040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play411311041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10066ui_story = arg_167_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10066ui_story"].transform.position).z)
				arg_167_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10066ui_story"].transform.localEulerAngles = arg_167_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_167_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10066ui_story"].transform.position).z)
				arg_167_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10066ui_story"].transform.localEulerAngles = arg_167_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["10066ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10066ui_story == nil then
				arg_167_1.var_.characterEffect10066ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect10066ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10066ui_story then
				arg_167_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_4 = 0
			local var_170_5 = 0.375

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(411311040).content)

				arg_167_1.text_.text = var_170_6

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_8 = 15 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_6) / 15)

				if (15 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_6) / 15)) > 0 and var_170_5 < var_170_8 then
					arg_167_1.talkMaxDuration = var_170_8

					if var_170_8 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_6
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_9 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_9 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_9

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_9 and arg_167_1.time_ < var_170_4 + var_170_9 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play411311041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411311041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411311042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10058ui_story = arg_171_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).z)
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles = arg_171_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_171_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10058ui_story"].transform.position).z)
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10058ui_story"].transform.localEulerAngles = arg_171_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10058ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10058ui_story == nil then
				arg_171_1.var_.characterEffect10058ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10058ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10058ui_story then
				arg_171_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_174_4 = arg_171_1.actors_["10066ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect10066ui_story == nil then
				arg_171_1.var_.characterEffect10066ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_5 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 and not isNil(var_174_4) then
				if arg_171_1.var_.characterEffect10066ui_story and not isNil(var_174_4) then
					arg_171_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_5)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect10066ui_story then
				arg_171_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_174_6 = arg_171_1.actors_["10066ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10066ui_story = var_174_6.localPosition
			end

			local var_174_7 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				var_174_6.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_171_1.time_ - 0) / var_174_7)
				var_174_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_6.position).x, (manager.ui.mainCamera.transform.position - var_174_6.position).y, (manager.ui.mainCamera.transform.position - var_174_6.position).z)
				var_174_6.localEulerAngles.z = 0
				var_174_6.localEulerAngles.x = 0
				var_174_6.localEulerAngles = var_174_6.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				var_174_6.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_174_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_6.position).x, (manager.ui.mainCamera.transform.position - var_174_6.position).y, (manager.ui.mainCamera.transform.position - var_174_6.position).z)
				var_174_6.localEulerAngles.z = 0
				var_174_6.localEulerAngles.x = 0
				var_174_6.localEulerAngles = var_174_6.localEulerAngles
			end

			local var_174_8 = 0
			local var_174_9 = 0.4

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(411311041).content)

				arg_171_1.text_.text = var_174_10

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_12 = 16 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_10) / 16)

				if (16 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_10) / 16)) > 0 and var_174_9 < var_174_12 then
					arg_171_1.talkMaxDuration = var_174_12

					if var_174_12 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_10
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_13 and arg_171_1.time_ < var_174_8 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play411311042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411311042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411311043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10066ui_story = arg_175_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10066ui_story"].transform.position).z)
				arg_175_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10066ui_story"].transform.localEulerAngles = arg_175_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_175_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10066ui_story"].transform.position).z)
				arg_175_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10066ui_story"].transform.localEulerAngles = arg_175_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["10066ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10066ui_story == nil then
				arg_175_1.var_.characterEffect10066ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect10066ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10066ui_story then
				arg_175_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_178_4 = arg_175_1.actors_["10058ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect10058ui_story == nil then
				arg_175_1.var_.characterEffect10058ui_story = var_178_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_5 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_5 and not isNil(var_178_4) then
				if arg_175_1.var_.characterEffect10058ui_story and not isNil(var_178_4) then
					arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_5)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_5 and arg_175_1.time_ < 0 + var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect10058ui_story then
				arg_175_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_178_6 = 0
			local var_178_7 = 0.5

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(411311042).content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 20 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_8) / 20)

				if (20 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_8) / 20)) > 0 and var_178_7 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_11 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_11 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_11

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_11 and arg_175_1.time_ < var_178_6 + var_178_11 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play411311043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411311043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play411311044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10066ui_story"]) and arg_179_1.var_.characterEffect10066ui_story == nil then
				arg_179_1.var_.characterEffect10066ui_story = arg_179_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10066ui_story"]) then
				if arg_179_1.var_.characterEffect10066ui_story and not isNil(arg_179_1.actors_["10066ui_story"]) then
					arg_179_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10066ui_story"]) and arg_179_1.var_.characterEffect10066ui_story then
				arg_179_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_182_1 = 0
			local var_182_2 = 0.55

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

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(411311043).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 22 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 22)

				if (22 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 22)) > 0 and var_182_2 < var_182_5 then
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
	Play411311044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411311044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play411311045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10066ui_story = arg_183_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10066ui_story"].transform.position).z)
				arg_183_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10066ui_story"].transform.localEulerAngles = arg_183_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_183_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10066ui_story"].transform.position).z)
				arg_183_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10066ui_story"].transform.localEulerAngles = arg_183_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["10066ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect10066ui_story == nil then
				arg_183_1.var_.characterEffect10066ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect10066ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect10066ui_story then
				arg_183_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_186_4 = 0
			local var_186_5 = 0.275

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(411311044).content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 11 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_6) / 11)

				if (11 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_6) / 11)) > 0 and var_186_5 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_9 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_9 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_9

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_9 and arg_183_1.time_ < var_186_4 + var_186_9 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play411311045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411311045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play411311046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10066ui_story = arg_187_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10066ui_story"].transform.position).z)
				arg_187_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10066ui_story"].transform.localEulerAngles = arg_187_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10066ui_story"].transform.position).z)
				arg_187_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10066ui_story"].transform.localEulerAngles = arg_187_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["10066ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10066ui_story == nil then
				arg_187_1.var_.characterEffect10066ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect10066ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_2)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10066ui_story then
				arg_187_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_190_3 = arg_187_1.actors_["10058ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10058ui_story = var_190_3.localPosition
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_3.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 0) / var_190_4)
				var_190_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_3.position).x, (manager.ui.mainCamera.transform.position - var_190_3.position).y, (manager.ui.mainCamera.transform.position - var_190_3.position).z)
				var_190_3.localEulerAngles.z = 0
				var_190_3.localEulerAngles.x = 0
				var_190_3.localEulerAngles = var_190_3.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				var_190_3.localPosition = Vector3.New(0, 100, 0)
				var_190_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_3.position).x, (manager.ui.mainCamera.transform.position - var_190_3.position).y, (manager.ui.mainCamera.transform.position - var_190_3.position).z)
				var_190_3.localEulerAngles.z = 0
				var_190_3.localEulerAngles.x = 0
				var_190_3.localEulerAngles = var_190_3.localEulerAngles
			end

			local var_190_5 = arg_187_1.actors_["10058ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect10058ui_story == nil then
				arg_187_1.var_.characterEffect10058ui_story = var_190_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 and not isNil(var_190_5) then
				if arg_187_1.var_.characterEffect10058ui_story and not isNil(var_190_5) then
					arg_187_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_6)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect10058ui_story then
				arg_187_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_190_7 = 0
			local var_190_8 = 1.55

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_9 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(411311045).content)

				arg_187_1.text_.text = var_190_9

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 62 <= 0 and var_190_8 or var_190_8 * (utf8.len(var_190_9) / 62)

				if (62 <= 0 and var_190_8 or var_190_8 * (utf8.len(var_190_9) / 62)) > 0 and var_190_8 < var_190_11 then
					arg_187_1.talkMaxDuration = var_190_11

					if var_190_11 + var_190_7 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_7
					end
				end

				arg_187_1.text_.text = var_190_9
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_8, arg_187_1.talkMaxDuration)

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_7) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_7 + var_190_12 and arg_187_1.time_ < var_190_7 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play411311046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411311046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play411311047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.275

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(411311046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 51 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 51)

				if (51 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 51)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play411311047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411311047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play411311048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10058ui_story = arg_195_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).z)
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles = arg_195_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_195_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10058ui_story"].transform.position).z)
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10058ui_story"].transform.localEulerAngles = arg_195_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["10058ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10058ui_story == nil then
				arg_195_1.var_.characterEffect10058ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect10058ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10058ui_story then
				arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_198_4 = 0
			local var_198_5 = 0.225

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(411311047).content)

				arg_195_1.text_.text = var_198_6

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_8 = 9 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_6) / 9)

				if (9 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_6) / 9)) > 0 and var_198_5 < var_198_8 then
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
				actorName = "10058ui_story",
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
	Play411311048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411311048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411311049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10066ui_story = arg_199_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10066ui_story"].transform.position).z)
				arg_199_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10066ui_story"].transform.localEulerAngles = arg_199_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_199_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["10066ui_story"].transform.position).z)
				arg_199_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["10066ui_story"].transform.localEulerAngles = arg_199_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["10066ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10066ui_story == nil then
				arg_199_1.var_.characterEffect10066ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect10066ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect10066ui_story then
				arg_199_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action443")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_202_4 = arg_199_1.actors_["10058ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect10058ui_story == nil then
				arg_199_1.var_.characterEffect10058ui_story = var_202_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_5 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 and not isNil(var_202_4) then
				if arg_199_1.var_.characterEffect10058ui_story and not isNil(var_202_4) then
					arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_5)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect10058ui_story then
				arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_202_6 = arg_199_1.actors_["10058ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10058ui_story = var_202_6.localPosition
			end

			local var_202_7 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				var_202_6.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_199_1.time_ - 0) / var_202_7)
				var_202_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_6.position).x, (manager.ui.mainCamera.transform.position - var_202_6.position).y, (manager.ui.mainCamera.transform.position - var_202_6.position).z)
				var_202_6.localEulerAngles.z = 0
				var_202_6.localEulerAngles.x = 0
				var_202_6.localEulerAngles = var_202_6.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				var_202_6.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_202_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_6.position).x, (manager.ui.mainCamera.transform.position - var_202_6.position).y, (manager.ui.mainCamera.transform.position - var_202_6.position).z)
				var_202_6.localEulerAngles.z = 0
				var_202_6.localEulerAngles.x = 0
				var_202_6.localEulerAngles = var_202_6.localEulerAngles
			end

			local var_202_8 = 0
			local var_202_9 = 0.125

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(411311048).content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_12 = 5 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_10) / 5)

				if (5 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_10) / 5)) > 0 and var_202_9 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_13 and arg_199_1.time_ < var_202_8 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play411311049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 411311049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play411311050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10058ui_story = arg_203_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10058ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10058ui_story"].transform.position).z)
				arg_203_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10058ui_story"].transform.localEulerAngles = arg_203_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_203_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10058ui_story"].transform.position).z)
				arg_203_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10058ui_story"].transform.localEulerAngles = arg_203_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["10058ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10058ui_story == nil then
				arg_203_1.var_.characterEffect10058ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect10058ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect10058ui_story then
				arg_203_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_206_4 = arg_203_1.actors_["10066ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect10066ui_story == nil then
				arg_203_1.var_.characterEffect10066ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_5 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 and not isNil(var_206_4) then
				if arg_203_1.var_.characterEffect10066ui_story and not isNil(var_206_4) then
					arg_203_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_5)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect10066ui_story then
				arg_203_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_206_6 = 0
			local var_206_7 = 0.175

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(411311049).content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 7 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_8) / 7)

				if (7 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_8) / 7)) > 0 and var_206_7 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_11 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_11 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_11

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_11 and arg_203_1.time_ < var_206_6 + var_206_11 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play411311050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 411311050
		arg_207_1.duration_ = 7

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
			arg_207_1.auto_ = false
		end

		function arg_207_1.playNext_(arg_209_0)
			arg_207_1.onStoryFinished_()
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 2.02499999701977 < arg_207_1.time_ and arg_207_1.time_ <= 2.02499999701977 + arg_210_0 then
				arg_207_1.var_.moveOldPos10066ui_story = arg_207_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 2.02499999701977 <= arg_207_1.time_ and arg_207_1.time_ < 2.02499999701977 + var_210_0 then
				arg_207_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 2.02499999701977) / var_210_0)
				arg_207_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10066ui_story"].transform.position).z)
				arg_207_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["10066ui_story"].transform.localEulerAngles = arg_207_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 2.02499999701977 + var_210_0 and arg_207_1.time_ < 2.02499999701977 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10066ui_story"].transform.position).z)
				arg_207_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["10066ui_story"].transform.localEulerAngles = arg_207_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["10066ui_story"]

			if 2.02499999701977 < arg_207_1.time_ and arg_207_1.time_ <= 2.02499999701977 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10066ui_story == nil then
				arg_207_1.var_.characterEffect10066ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 2.02499999701977 <= arg_207_1.time_ and arg_207_1.time_ < 2.02499999701977 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect10066ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 2.02499999701977) / var_210_2)
				end
			end

			if arg_207_1.time_ >= 2.02499999701977 + var_210_2 and arg_207_1.time_ < 2.02499999701977 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10066ui_story then
				arg_207_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_210_3 = arg_207_1.actors_["10058ui_story"].transform

			if 2.02499999701977 < arg_207_1.time_ and arg_207_1.time_ <= 2.02499999701977 + arg_210_0 then
				arg_207_1.var_.moveOldPos10058ui_story = var_210_3.localPosition
			end

			local var_210_4 = 0.001

			if 2.02499999701977 <= arg_207_1.time_ and arg_207_1.time_ < 2.02499999701977 + var_210_4 then
				var_210_3.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 2.02499999701977) / var_210_4)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			if arg_207_1.time_ >= 2.02499999701977 + var_210_4 and arg_207_1.time_ < 2.02499999701977 + var_210_4 + arg_210_0 then
				var_210_3.localPosition = Vector3.New(0, 100, 0)
				var_210_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_3.position).x, (manager.ui.mainCamera.transform.position - var_210_3.position).y, (manager.ui.mainCamera.transform.position - var_210_3.position).z)
				var_210_3.localEulerAngles.z = 0
				var_210_3.localEulerAngles.x = 0
				var_210_3.localEulerAngles = var_210_3.localEulerAngles
			end

			local var_210_5 = arg_207_1.actors_["10058ui_story"]

			if 2.02499999701977 < arg_207_1.time_ and arg_207_1.time_ <= 2.02499999701977 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect10058ui_story == nil then
				arg_207_1.var_.characterEffect10058ui_story = var_210_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if 2.02499999701977 <= arg_207_1.time_ and arg_207_1.time_ < 2.02499999701977 + var_210_6 and not isNil(var_210_5) then
				if arg_207_1.var_.characterEffect10058ui_story and not isNil(var_210_5) then
					arg_207_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 2.02499999701977) / var_210_6)
				end
			end

			if arg_207_1.time_ >= 2.02499999701977 + var_210_6 and arg_207_1.time_ < 2.02499999701977 + var_210_6 + arg_210_0 and not isNil(var_210_5) and arg_207_1.var_.characterEffect10058ui_story then
				arg_207_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_210_7 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_8 = 2

			if var_210_7 <= arg_207_1.time_ and arg_207_1.time_ < var_210_7 + var_210_8 then
				local var_210_9 = Color.New(1, 1, 1)

				var_210_9.a = Mathf.Lerp(0, 1, (arg_207_1.time_ - var_210_7) / var_210_8)
				arg_207_1.mask_.color = var_210_9
			end

			if arg_207_1.time_ >= var_210_7 + var_210_8 and arg_207_1.time_ < var_210_7 + var_210_8 + arg_210_0 then
				local var_210_10 = Color.New(1, 1, 1)

				var_210_10.a = 1
				arg_207_1.mask_.color = var_210_10
			end

			local var_210_11 = 2

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_12 = 2

			if var_210_11 <= arg_207_1.time_ and arg_207_1.time_ < var_210_11 + var_210_12 then
				local var_210_13 = Color.New(1, 1, 1)

				var_210_13.a = Mathf.Lerp(1, 0, (arg_207_1.time_ - var_210_11) / var_210_12)
				arg_207_1.mask_.color = var_210_13
			end

			if arg_207_1.time_ >= var_210_11 + var_210_12 and arg_207_1.time_ < var_210_11 + var_210_12 + arg_210_0 then
				local var_210_14 = Color.New(1, 1, 1)

				arg_207_1.mask_.enabled = false
				var_210_14.a = 0
				arg_207_1.mask_.color = var_210_14
			end

			local var_210_15 = 2
			local var_210_16 = 0.225

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_15 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_17 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(411311050).content)

				arg_207_1.text_.text = var_210_17

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_19 = 9 <= 0 and var_210_16 or var_210_16 * (utf8.len(var_210_17) / 9)

				if (9 <= 0 and var_210_16 or var_210_16 * (utf8.len(var_210_17) / 9)) > 0 and var_210_16 < var_210_19 then
					arg_207_1.talkMaxDuration = var_210_19

					if var_210_19 + var_210_15 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_19 + var_210_15
					end
				end

				arg_207_1.text_.text = var_210_17
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_20 = math.max(var_210_16, arg_207_1.talkMaxDuration)

			if var_210_15 <= arg_207_1.time_ and arg_207_1.time_ < var_210_15 + var_210_20 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_15) / var_210_20

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_15 + var_210_20 and arg_207_1.time_ < var_210_15 + var_210_20 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.02499999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.02499999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST74"
	},
	voices = {}
}
