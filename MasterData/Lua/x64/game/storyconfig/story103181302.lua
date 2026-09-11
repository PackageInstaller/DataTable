return {
	Play318132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 318132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play318132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C07_1 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C07_1")
				var_4_0.name = "C07_1"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C07_1 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C07_1

				arg_1_1.bgs_.C07_1.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C07_1" then
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_10_story_visbane_factory", "bgm_activity_2_10_story_visbane_factory", "bgm_activity_2_10_story_visbane_factory.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_10_story_visbane_factory", "bgm_activity_2_10_story_visbane_factory")

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
			local var_4_15 = 0.525

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(318132001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 21 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 21)

				if (21 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 21)) > 0 and var_4_15 < var_4_19 then
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
	Play318132002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 318132002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play318132003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.95

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

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(318132002).content)

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
	Play318132003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 318132003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play318132004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.775

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(318132003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 71 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 71)

				if (71 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 71)) > 0 and var_16_0 < var_16_3 then
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
	Play318132004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 318132004
		arg_17_1.duration_ = 3.47

		local var_17_0 = {
			zh = 3.466,
			ja = 3.133
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
				arg_17_0:Play318132005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1150ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1150ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1150ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1150ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1150ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1150ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1150ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1150ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1150ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1150ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.01, -6.2)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1150ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1150ui_story == nil then
				arg_17_1.var_.characterEffect1150ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1150ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1150ui_story then
				arg_17_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_8 = 0
			local var_20_9 = 0.325

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(318132004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 13 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 13)

				if (13 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 13)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132004", "story_v_out_318132.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_318132", "318132004", "story_v_out_318132.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_318132", "318132004", "story_v_out_318132.awb")

						arg_17_1:RecordAudio("318132004", var_20_15)
						arg_17_1:RecordAudio("318132004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_318132", "318132004", "story_v_out_318132.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_318132", "318132004", "story_v_out_318132.awb")
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
				actorName = "1150ui_story",
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
	Play318132005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 318132005
		arg_21_1.duration_ = 6.47

		local var_21_0 = {
			zh = 2.366,
			ja = 6.466
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
				arg_21_0:Play318132006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(318132005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 13 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 13)

				if (13 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 13)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132005", "story_v_out_318132.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_318132", "318132005", "story_v_out_318132.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_318132", "318132005", "story_v_out_318132.awb")

						arg_21_1:RecordAudio("318132005", var_24_6)
						arg_21_1:RecordAudio("318132005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_318132", "318132005", "story_v_out_318132.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_318132", "318132005", "story_v_out_318132.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play318132006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 318132006
		arg_25_1.duration_ = 9

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play318132007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.bgs_.k15f == nil then
				local var_28_0 = Object.Instantiate(arg_25_1.paintGo_)

				var_28_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "k15f")
				var_28_0.name = "k15f"
				var_28_0.transform.parent = arg_25_1.stage_.transform
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.bgs_.k15f = var_28_0
			end

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				local var_28_1 = arg_25_1.bgs_.k15f

				arg_25_1.bgs_.k15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_2 = var_28_1:GetComponent("SpriteRenderer")

				if var_28_2 and var_28_2.sprite then
					local var_28_3 = 2 * (var_28_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_1.transform.localScale = Vector3.New(var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, var_28_3 / var_28_2.sprite.bounds.size.y < var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x and var_28_3 * manager.ui.mainCameraCom_.aspect / var_28_2.sprite.bounds.size.x or var_28_3 / var_28_2.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "k15f" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_4 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_5 = 2

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_5 then
				local var_28_6 = Color.New(0, 0, 0)

				var_28_6.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - var_28_4) / var_28_5)
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.time_ >= var_28_4 + var_28_5 and arg_25_1.time_ < var_28_4 + var_28_5 + arg_28_0 then
				local var_28_7 = Color.New(0, 0, 0)

				var_28_7.a = 1
				arg_25_1.mask_.color = var_28_7
			end

			local var_28_8 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_9 = 2

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 then
				local var_28_10 = Color.New(0, 0, 0)

				var_28_10.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_8) / var_28_9)
				arg_25_1.mask_.color = var_28_10
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 then
				local var_28_11 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_11.a = 0
				arg_25_1.mask_.color = var_28_11
			end

			local var_28_12 = arg_25_1.actors_["1150ui_story"].transform

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 then
				arg_25_1.var_.moveOldPos1150ui_story = var_28_12.localPosition
			end

			local var_28_13 = 0.001

			if 2 <= arg_25_1.time_ and arg_25_1.time_ < 2 + var_28_13 then
				var_28_12.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 2) / var_28_13)
				var_28_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_12.position).x, (manager.ui.mainCamera.transform.position - var_28_12.position).y, (manager.ui.mainCamera.transform.position - var_28_12.position).z)
				var_28_12.localEulerAngles.z = 0
				var_28_12.localEulerAngles.x = 0
				var_28_12.localEulerAngles = var_28_12.localEulerAngles
			end

			if arg_25_1.time_ >= 2 + var_28_13 and arg_25_1.time_ < 2 + var_28_13 + arg_28_0 then
				var_28_12.localPosition = Vector3.New(0, 100, 0)
				var_28_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_12.position).x, (manager.ui.mainCamera.transform.position - var_28_12.position).y, (manager.ui.mainCamera.transform.position - var_28_12.position).z)
				var_28_12.localEulerAngles.z = 0
				var_28_12.localEulerAngles.x = 0
				var_28_12.localEulerAngles = var_28_12.localEulerAngles
			end

			local var_28_14 = arg_25_1.actors_["1150ui_story"]

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= 2 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1150ui_story == nil then
				arg_25_1.var_.characterEffect1150ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_15 = 0.200000002980232

			if 2 <= arg_25_1.time_ and arg_25_1.time_ < 2 + var_28_15 and not isNil(var_28_14) then
				if arg_25_1.var_.characterEffect1150ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 2) / var_28_15)
				end
			end

			if arg_25_1.time_ >= 2 + var_28_15 and arg_25_1.time_ < 2 + var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1150ui_story then
				arg_25_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_16 = 4
			local var_28_17 = 1.15

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_18 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_18:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_19 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(318132006).content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_21 = 46 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_19) / 46)

				if (46 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_19) / 46)) > 0 and var_28_17 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21
					var_28_16 = var_28_16 + 0.3

					if var_28_21 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = var_28_16 + 0.3
			local var_28_23 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_22 + var_28_23 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_22) / var_28_23

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_22 + var_28_23 and arg_25_1.time_ < var_28_22 + var_28_23 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play318132007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 318132007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play318132008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.1

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2038")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(318132007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 4 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 4)

				if (4 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 4)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play318132008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 318132008
		arg_35_1.duration_ = 4.5

		local var_35_0 = {
			zh = 3.166,
			ja = 4.5
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
				arg_35_0:Play318132009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1150ui_story = arg_35_1.actors_["1150ui_story"].transform.localPosition

				arg_35_1:ShowWeapon(arg_35_1.var_["1150ui_story" .. "Animator"].transform, true)
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1150ui_story"].transform.position).z)
				arg_35_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1150ui_story"].transform.localEulerAngles = arg_35_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_35_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1150ui_story"].transform.position).z)
				arg_35_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1150ui_story"].transform.localEulerAngles = arg_35_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1150ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1150ui_story == nil then
				arg_35_1.var_.characterEffect1150ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1150ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1150ui_story then
				arg_35_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action6_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_38_4 = 0
			local var_38_5 = 0.275

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_4 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_6 = arg_35_1:GetWordFromCfg(318132008)
				local var_38_7 = arg_35_1:FormatText(var_38_6.content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 11 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 11)

				if (11 <= 0 and var_38_5 or var_38_5 * (utf8.len(var_38_7) / 11)) > 0 and var_38_5 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_4
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132008", "story_v_out_318132.awb") ~= 0 then
					local var_38_10 = manager.audio:GetVoiceLength("story_v_out_318132", "318132008", "story_v_out_318132.awb") / 1000

					if var_38_10 + var_38_4 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_4
					end

					if var_38_6.prefab_name ~= "" and arg_35_1.actors_[var_38_6.prefab_name] ~= nil then
						local var_38_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_6.prefab_name].transform, "story_v_out_318132", "318132008", "story_v_out_318132.awb")

						arg_35_1:RecordAudio("318132008", var_38_11)
						arg_35_1:RecordAudio("318132008", var_38_11)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_318132", "318132008", "story_v_out_318132.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_318132", "318132008", "story_v_out_318132.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_12 = math.max(var_38_5, arg_35_1.talkMaxDuration)

			if var_38_4 <= arg_35_1.time_ and arg_35_1.time_ < var_38_4 + var_38_12 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_4) / var_38_12

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_4 + var_38_12 and arg_35_1.time_ < var_38_4 + var_38_12 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play318132009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 318132009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play318132010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1150ui_story"]) and arg_39_1.var_.characterEffect1150ui_story == nil then
				arg_39_1.var_.characterEffect1150ui_story = arg_39_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1150ui_story"]) then
				if arg_39_1.var_.characterEffect1150ui_story and not isNil(arg_39_1.actors_["1150ui_story"]) then
					arg_39_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1150ui_story"]) and arg_39_1.var_.characterEffect1150ui_story then
				arg_39_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_whoosh", "")
			end

			local var_42_2 = arg_39_1.actors_["1150ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1150ui_story = var_42_2.localPosition

				arg_39_1:ShowWeapon(arg_39_1.var_["1150ui_story" .. "Animator"].transform, true)
			end

			local var_42_3 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_3 then
				var_42_2.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_39_1.time_ - 0) / var_42_3)
				var_42_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_2.position).x, (manager.ui.mainCamera.transform.position - var_42_2.position).y, (manager.ui.mainCamera.transform.position - var_42_2.position).z)
				var_42_2.localEulerAngles.z = 0
				var_42_2.localEulerAngles.x = 0
				var_42_2.localEulerAngles = var_42_2.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_3 and arg_39_1.time_ < 0 + var_42_3 + arg_42_0 then
				var_42_2.localPosition = Vector3.New(0, 100, 0)
				var_42_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_2.position).x, (manager.ui.mainCamera.transform.position - var_42_2.position).y, (manager.ui.mainCamera.transform.position - var_42_2.position).z)
				var_42_2.localEulerAngles.z = 0
				var_42_2.localEulerAngles.x = 0
				var_42_2.localEulerAngles = var_42_2.localEulerAngles
			end

			local var_42_4 = manager.ui.mainCamera.transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.shakeOldPos = var_42_4.localPosition
			end

			local var_42_5 = 0.6

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				local var_42_6, var_42_7 = math.modf((arg_39_1.time_ - 0) / 0.066)

				var_42_4.localPosition = Vector3.New(var_42_7 * 0.13, var_42_7 * 0.13, var_42_7 * 0.13) + arg_39_1.var_.shakeOldPos
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				var_42_4.localPosition = arg_39_1.var_.shakeOldPos
			end

			local var_42_8 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			if arg_39_1.time_ >= var_42_8 + 0.6 and arg_39_1.time_ < var_42_8 + 0.6 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_9 = 0
			local var_42_10 = 1

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_11 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(318132009).content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 40 <= 0 and var_42_10 or var_42_10 * (utf8.len(var_42_11) / 40)

				if (40 <= 0 and var_42_10 or var_42_10 * (utf8.len(var_42_11) / 40)) > 0 and var_42_10 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_9 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_9
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_10, arg_39_1.talkMaxDuration)

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_9) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_9 + var_42_14 and arg_39_1.time_ < var_42_9 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play318132010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 318132010
		arg_43_1.duration_ = 6.13

		local var_43_0 = {
			zh = 3.466,
			ja = 6.133
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
				arg_43_0:Play318132011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1150ui_story"]) and arg_43_1.var_.characterEffect1150ui_story == nil then
				arg_43_1.var_.characterEffect1150ui_story = arg_43_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1150ui_story"]) then
				if arg_43_1.var_.characterEffect1150ui_story and not isNil(arg_43_1.actors_["1150ui_story"]) then
					arg_43_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1150ui_story"]) and arg_43_1.var_.characterEffect1150ui_story then
				arg_43_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_46_2 = arg_43_1.actors_["1150ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1150ui_story = var_46_2.localPosition
			end

			local var_46_3 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_3 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_43_1.time_ - 0) / var_46_3)
				var_46_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_2.position).x, (manager.ui.mainCamera.transform.position - var_46_2.position).y, (manager.ui.mainCamera.transform.position - var_46_2.position).z)
				var_46_2.localEulerAngles.z = 0
				var_46_2.localEulerAngles.x = 0
				var_46_2.localEulerAngles = var_46_2.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_3 and arg_43_1.time_ < 0 + var_46_3 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(0, -1.01, -6.2)
				var_46_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_2.position).x, (manager.ui.mainCamera.transform.position - var_46_2.position).y, (manager.ui.mainCamera.transform.position - var_46_2.position).z)
				var_46_2.localEulerAngles.z = 0
				var_46_2.localEulerAngles.x = 0
				var_46_2.localEulerAngles = var_46_2.localEulerAngles
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.275

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(318132010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 11 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 11)

				if (11 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 11)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132010", "story_v_out_318132.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_318132", "318132010", "story_v_out_318132.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_318132", "318132010", "story_v_out_318132.awb")

						arg_43_1:RecordAudio("318132010", var_46_11)
						arg_43_1:RecordAudio("318132010", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_318132", "318132010", "story_v_out_318132.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_318132", "318132010", "story_v_out_318132.awb")
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
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play318132011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 318132011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play318132012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1150ui_story"]) and arg_47_1.var_.characterEffect1150ui_story == nil then
				arg_47_1.var_.characterEffect1150ui_story = arg_47_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1150ui_story"]) then
				if arg_47_1.var_.characterEffect1150ui_story and not isNil(arg_47_1.actors_["1150ui_story"]) then
					arg_47_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1150ui_story"]) and arg_47_1.var_.characterEffect1150ui_story then
				arg_47_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			local var_50_1 = arg_47_1.actors_["1150ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1150ui_story = var_50_1.localPosition
			end

			local var_50_2 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 then
				var_50_1.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_2)
				var_50_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_1.position).x, (manager.ui.mainCamera.transform.position - var_50_1.position).y, (manager.ui.mainCamera.transform.position - var_50_1.position).z)
				var_50_1.localEulerAngles.z = 0
				var_50_1.localEulerAngles.x = 0
				var_50_1.localEulerAngles = var_50_1.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 then
				var_50_1.localPosition = Vector3.New(0, 100, 0)
				var_50_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_1.position).x, (manager.ui.mainCamera.transform.position - var_50_1.position).y, (manager.ui.mainCamera.transform.position - var_50_1.position).z)
				var_50_1.localEulerAngles.z = 0
				var_50_1.localEulerAngles.x = 0
				var_50_1.localEulerAngles = var_50_1.localEulerAngles
			end

			local var_50_3 = 0
			local var_50_4 = 1

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_3 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_5 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(318132011).content)

				arg_47_1.text_.text = var_50_5

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 40 <= 0 and var_50_4 or var_50_4 * (utf8.len(var_50_5) / 40)

				if (40 <= 0 and var_50_4 or var_50_4 * (utf8.len(var_50_5) / 40)) > 0 and var_50_4 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_3 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_3
					end
				end

				arg_47_1.text_.text = var_50_5
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_8 = math.max(var_50_4, arg_47_1.talkMaxDuration)

			if var_50_3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_3 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_3) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_3 + var_50_8 and arg_47_1.time_ < var_50_3 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play318132012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 318132012
		arg_51_1.duration_ = 7.23

		local var_51_0 = {
			zh = 3.7,
			ja = 7.233
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
				arg_51_0:Play318132013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1150ui_story"]) and arg_51_1.var_.characterEffect1150ui_story == nil then
				arg_51_1.var_.characterEffect1150ui_story = arg_51_1.actors_["1150ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1150ui_story"]) then
				if arg_51_1.var_.characterEffect1150ui_story and not isNil(arg_51_1.actors_["1150ui_story"]) then
					arg_51_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1150ui_story"]) and arg_51_1.var_.characterEffect1150ui_story then
				arg_51_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			local var_54_2 = arg_51_1.actors_["1150ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1150ui_story = var_54_2.localPosition
			end

			local var_54_3 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 then
				var_54_2.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_51_1.time_ - 0) / var_54_3)
				var_54_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_2.position).x, (manager.ui.mainCamera.transform.position - var_54_2.position).y, (manager.ui.mainCamera.transform.position - var_54_2.position).z)
				var_54_2.localEulerAngles.z = 0
				var_54_2.localEulerAngles.x = 0
				var_54_2.localEulerAngles = var_54_2.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 then
				var_54_2.localPosition = Vector3.New(0, -1.01, -6.2)
				var_54_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_2.position).x, (manager.ui.mainCamera.transform.position - var_54_2.position).y, (manager.ui.mainCamera.transform.position - var_54_2.position).z)
				var_54_2.localEulerAngles.z = 0
				var_54_2.localEulerAngles.x = 0
				var_54_2.localEulerAngles = var_54_2.localEulerAngles
			end

			local var_54_4 = 0
			local var_54_5 = 0.275

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_6 = arg_51_1:GetWordFromCfg(318132012)
				local var_54_7 = arg_51_1:FormatText(var_54_6.content)

				arg_51_1.text_.text = var_54_7

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 11 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 11)

				if (11 <= 0 and var_54_5 or var_54_5 * (utf8.len(var_54_7) / 11)) > 0 and var_54_5 < var_54_9 then
					arg_51_1.talkMaxDuration = var_54_9

					if var_54_9 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_7
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132012", "story_v_out_318132.awb") ~= 0 then
					local var_54_10 = manager.audio:GetVoiceLength("story_v_out_318132", "318132012", "story_v_out_318132.awb") / 1000

					if var_54_10 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_4
					end

					if var_54_6.prefab_name ~= "" and arg_51_1.actors_[var_54_6.prefab_name] ~= nil then
						local var_54_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_6.prefab_name].transform, "story_v_out_318132", "318132012", "story_v_out_318132.awb")

						arg_51_1:RecordAudio("318132012", var_54_11)
						arg_51_1:RecordAudio("318132012", var_54_11)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_318132", "318132012", "story_v_out_318132.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_318132", "318132012", "story_v_out_318132.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_12 and arg_51_1.time_ < var_54_4 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play318132013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 318132013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play318132014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1150ui_story = arg_55_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1150ui_story"].transform.position).z)
				arg_55_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1150ui_story"].transform.localEulerAngles = arg_55_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1150ui_story"].transform.position).z)
				arg_55_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1150ui_story"].transform.localEulerAngles = arg_55_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1150ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1150ui_story == nil then
				arg_55_1.var_.characterEffect1150ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1150ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1150ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1150ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_2)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1150ui_story then
				arg_55_1.var_.characterEffect1150ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1150ui_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_127", "se_story_127_thunder", "")
			end

			local var_58_4 = 0
			local var_58_5 = 1.275

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(318132013).content)

				arg_55_1.text_.text = var_58_6

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_8 = 51 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_6) / 51)

				if (51 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_6) / 51)) > 0 and var_58_5 < var_58_8 then
					arg_55_1.talkMaxDuration = var_58_8

					if var_58_8 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_8 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_6
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_9 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_9 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_9

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_9 and arg_55_1.time_ < var_58_4 + var_58_9 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play318132014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 318132014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play318132015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.8

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(318132014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 32 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 32)

				if (32 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 32)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play318132015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 318132015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play318132016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.95

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(318132015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 38 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 38)

				if (38 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 38)) > 0 and var_66_0 < var_66_3 then
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
	Play318132016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 318132016
		arg_67_1.duration_ = 9

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play318132017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if arg_67_1.bgs_.LX0102 == nil then
				local var_70_0 = Object.Instantiate(arg_67_1.paintGo_)

				var_70_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LX0102")
				var_70_0.name = "LX0102"
				var_70_0.transform.parent = arg_67_1.stage_.transform
				var_70_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.bgs_.LX0102 = var_70_0
			end

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= 2 + arg_70_0 then
				local var_70_1 = arg_67_1.bgs_.LX0102

				arg_67_1.bgs_.LX0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_70_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_70_2 = var_70_1:GetComponent("SpriteRenderer")

				if var_70_2 and var_70_2.sprite then
					local var_70_3 = 2 * (var_70_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_70_1.transform.localScale = Vector3.New(var_70_3 / var_70_2.sprite.bounds.size.y < var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x and var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x or var_70_3 / var_70_2.sprite.bounds.size.y, var_70_3 / var_70_2.sprite.bounds.size.y < var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x and var_70_3 * manager.ui.mainCameraCom_.aspect / var_70_2.sprite.bounds.size.x or var_70_3 / var_70_2.sprite.bounds.size.y, 0)
				end

				for iter_70_0, iter_70_1 in pairs(arg_67_1.bgs_) do
					if iter_70_0 ~= "LX0102" then
						iter_70_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_70_4 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_5 = 2

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_5 then
				local var_70_6 = Color.New(0, 0, 0)

				var_70_6.a = Mathf.Lerp(0, 1, (arg_67_1.time_ - var_70_4) / var_70_5)
				arg_67_1.mask_.color = var_70_6
			end

			if arg_67_1.time_ >= var_70_4 + var_70_5 and arg_67_1.time_ < var_70_4 + var_70_5 + arg_70_0 then
				local var_70_7 = Color.New(0, 0, 0)

				var_70_7.a = 1
				arg_67_1.mask_.color = var_70_7
			end

			local var_70_8 = 2

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_9 = 2

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_9 then
				local var_70_10 = Color.New(0, 0, 0)

				var_70_10.a = Mathf.Lerp(1, 0, (arg_67_1.time_ - var_70_8) / var_70_9)
				arg_67_1.mask_.color = var_70_10
			end

			if arg_67_1.time_ >= var_70_8 + var_70_9 and arg_67_1.time_ < var_70_8 + var_70_9 + arg_70_0 then
				local var_70_11 = Color.New(0, 0, 0)

				arg_67_1.mask_.enabled = false
				var_70_11.a = 0
				arg_67_1.mask_.color = var_70_11
			end

			local var_70_12 = arg_67_1.actors_["1150ui_story"].transform

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= 2 + arg_70_0 then
				arg_67_1.var_.moveOldPos1150ui_story = var_70_12.localPosition
			end

			local var_70_13 = 0.1

			if 2 <= arg_67_1.time_ and arg_67_1.time_ < 2 + var_70_13 then
				var_70_12.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1150ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 2) / var_70_13)
				var_70_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_12.position).x, (manager.ui.mainCamera.transform.position - var_70_12.position).y, (manager.ui.mainCamera.transform.position - var_70_12.position).z)
				var_70_12.localEulerAngles.z = 0
				var_70_12.localEulerAngles.x = 0
				var_70_12.localEulerAngles = var_70_12.localEulerAngles
			end

			if arg_67_1.time_ >= 2 + var_70_13 and arg_67_1.time_ < 2 + var_70_13 + arg_70_0 then
				var_70_12.localPosition = Vector3.New(0, 100, 0)
				var_70_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_12.position).x, (manager.ui.mainCamera.transform.position - var_70_12.position).y, (manager.ui.mainCamera.transform.position - var_70_12.position).z)
				var_70_12.localEulerAngles.z = 0
				var_70_12.localEulerAngles.x = 0
				var_70_12.localEulerAngles = var_70_12.localEulerAngles
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_14 = 4
			local var_70_15 = 0.6

			if 4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_16 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_16:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_17 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(318132016).content)

				arg_67_1.text_.text = var_70_17

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_19 = 24 <= 0 and var_70_15 or var_70_15 * (utf8.len(var_70_17) / 24)

				if (24 <= 0 and var_70_15 or var_70_15 * (utf8.len(var_70_17) / 24)) > 0 and var_70_15 < var_70_19 then
					arg_67_1.talkMaxDuration = var_70_19
					var_70_14 = var_70_14 + 0.3

					if var_70_19 + var_70_14 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_19 + var_70_14
					end
				end

				arg_67_1.text_.text = var_70_17
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_20 = var_70_14 + 0.3
			local var_70_21 = math.max(var_70_15, arg_67_1.talkMaxDuration)

			if var_70_14 + 0.3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_20 + var_70_21 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_20) / var_70_21

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_20 + var_70_21 and arg_67_1.time_ < var_70_20 + var_70_21 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play318132017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 318132017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play318132018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.65

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(318132017).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 26 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 26)

				if (26 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 26)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play318132018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 318132018
		arg_77_1.duration_ = 2.5

		local var_77_0 = {
			zh = 1.7,
			ja = 2.5
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
				arg_77_0:Play318132019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.225

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(318132018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 9 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 9)

				if (9 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 9)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132018", "story_v_out_318132.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_318132", "318132018", "story_v_out_318132.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_318132", "318132018", "story_v_out_318132.awb")

						arg_77_1:RecordAudio("318132018", var_80_6)
						arg_77_1:RecordAudio("318132018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_318132", "318132018", "story_v_out_318132.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_318132", "318132018", "story_v_out_318132.awb")
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
	Play318132019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 318132019
		arg_81_1.duration_ = 5

		local var_81_0 = {
			zh = 4.5,
			ja = 5
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
				arg_81_0:Play318132020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.bgs_.LX0102_blur == nil then
				local var_84_0 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "LX0102_blur")
				var_84_0.name = "LX0102_blur"
				var_84_0.transform.parent = arg_81_1.stage_.transform
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_.LX0102_blur = var_84_0
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				local var_84_1 = arg_81_1.bgs_.LX0102_blur

				arg_81_1.bgs_.LX0102_blur.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_2 = var_84_1:GetComponent("SpriteRenderer")

				if var_84_2 and var_84_2.sprite then
					local var_84_3 = 2 * (var_84_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_1.transform.localScale = Vector3.New(var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "LX0102_blur" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_4 = "LX0102_blur"

			if arg_81_1.bgs_.LX0102_blur == nil then
				local var_84_5 = Object.Instantiate(arg_81_1.blurPaintGo_)

				var_84_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_84_4)
				var_84_5.name = var_84_4
				var_84_5.transform.parent = arg_81_1.stage_.transform
				var_84_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_[var_84_4] = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = arg_81_1.bgs_[var_84_4]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				var_84_7.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_8 = var_84_7:GetComponent("SpriteRenderer")

				if var_84_8 and var_84_8.sprite then
					local var_84_9 = 2 * (var_84_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_7.transform.localScale = Vector3.New(var_84_9 / var_84_8.sprite.bounds.size.y < var_84_9 * manager.ui.mainCameraCom_.aspect / var_84_8.sprite.bounds.size.x and var_84_9 * manager.ui.mainCameraCom_.aspect / var_84_8.sprite.bounds.size.x or var_84_9 / var_84_8.sprite.bounds.size.y, var_84_9 / var_84_8.sprite.bounds.size.y < var_84_9 * manager.ui.mainCameraCom_.aspect / var_84_8.sprite.bounds.size.x and var_84_9 * manager.ui.mainCameraCom_.aspect / var_84_8.sprite.bounds.size.x or var_84_9 / var_84_8.sprite.bounds.size.y, 0)
				end
			end

			local var_84_10 = 2

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_10 then
				local var_84_11 = Color.New(1, 1, 1)

				var_84_11.a = Mathf.Lerp(0, 1, (arg_81_1.time_ - var_84_6) / var_84_10)

				var_84_7:GetComponent("SpriteRenderer").material:SetColor("_Color", var_84_11)
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_12 = 2
			local var_84_13 = 0.275

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_14 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_14:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_15 = arg_81_1:GetWordFromCfg(318132019)
				local var_84_16 = arg_81_1:FormatText(var_84_15.content)

				arg_81_1.text_.text = var_84_16

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_18 = 11 <= 0 and var_84_13 or var_84_13 * (utf8.len(var_84_16) / 11)

				if (11 <= 0 and var_84_13 or var_84_13 * (utf8.len(var_84_16) / 11)) > 0 and var_84_13 < var_84_18 then
					arg_81_1.talkMaxDuration = var_84_18
					var_84_12 = var_84_12 + 0.3

					if var_84_18 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_12
					end
				end

				arg_81_1.text_.text = var_84_16
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132019", "story_v_out_318132.awb") ~= 0 then
					local var_84_19 = manager.audio:GetVoiceLength("story_v_out_318132", "318132019", "story_v_out_318132.awb") / 1000

					if var_84_19 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_12
					end

					if var_84_15.prefab_name ~= "" and arg_81_1.actors_[var_84_15.prefab_name] ~= nil then
						local var_84_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_15.prefab_name].transform, "story_v_out_318132", "318132019", "story_v_out_318132.awb")

						arg_81_1:RecordAudio("318132019", var_84_20)
						arg_81_1:RecordAudio("318132019", var_84_20)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_318132", "318132019", "story_v_out_318132.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_318132", "318132019", "story_v_out_318132.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_21 = var_84_12 + 0.3
			local var_84_22 = math.max(var_84_13, arg_81_1.talkMaxDuration)

			if var_84_12 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_21 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_21) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_21 + var_84_22 and arg_81_1.time_ < var_84_21 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play318132020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 318132020
		arg_87_1.duration_ = 12.33

		local var_87_0 = {
			zh = 12.333,
			ja = 7.6
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
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play318132021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				local var_90_0 = arg_87_1.bgs_.k15f

				arg_87_1.bgs_.k15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_90_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_1 = var_90_0:GetComponent("SpriteRenderer")

				if var_90_1 and var_90_1.sprite then
					local var_90_2 = 2 * (var_90_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_90_0.transform.localScale = Vector3.New(var_90_2 / var_90_1.sprite.bounds.size.y < var_90_2 * manager.ui.mainCameraCom_.aspect / var_90_1.sprite.bounds.size.x and var_90_2 * manager.ui.mainCameraCom_.aspect / var_90_1.sprite.bounds.size.x or var_90_2 / var_90_1.sprite.bounds.size.y, var_90_2 / var_90_1.sprite.bounds.size.y < var_90_2 * manager.ui.mainCameraCom_.aspect / var_90_1.sprite.bounds.size.x and var_90_2 * manager.ui.mainCameraCom_.aspect / var_90_1.sprite.bounds.size.x or var_90_2 / var_90_1.sprite.bounds.size.y, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "k15f" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_3 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_4 = 2

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_4 then
				local var_90_5 = Color.New(0, 0, 0)

				var_90_5.a = Mathf.Lerp(0, 1, (arg_87_1.time_ - var_90_3) / var_90_4)
				arg_87_1.mask_.color = var_90_5
			end

			if arg_87_1.time_ >= var_90_3 + var_90_4 and arg_87_1.time_ < var_90_3 + var_90_4 + arg_90_0 then
				local var_90_6 = Color.New(0, 0, 0)

				var_90_6.a = 1
				arg_87_1.mask_.color = var_90_6
			end

			local var_90_7 = 2

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_8 = 2

			if var_90_7 <= arg_87_1.time_ and arg_87_1.time_ < var_90_7 + var_90_8 then
				local var_90_9 = Color.New(0, 0, 0)

				var_90_9.a = Mathf.Lerp(1, 0, (arg_87_1.time_ - var_90_7) / var_90_8)
				arg_87_1.mask_.color = var_90_9
			end

			if arg_87_1.time_ >= var_90_7 + var_90_8 and arg_87_1.time_ < var_90_7 + var_90_8 + arg_90_0 then
				local var_90_10 = Color.New(0, 0, 0)

				arg_87_1.mask_.enabled = false
				var_90_10.a = 0
				arg_87_1.mask_.color = var_90_10
			end

			local var_90_11 = arg_87_1.actors_["1150ui_story"].transform

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				arg_87_1.var_.moveOldPos1150ui_story = var_90_11.localPosition

				arg_87_1:ShowWeapon(arg_87_1.var_["1150ui_story" .. "Animator"].transform, false)
			end

			local var_90_12 = 0.001

			if 2 <= arg_87_1.time_ and arg_87_1.time_ < 2 + var_90_12 then
				var_90_11.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_87_1.time_ - 2) / var_90_12)
				var_90_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_11.position).x, (manager.ui.mainCamera.transform.position - var_90_11.position).y, (manager.ui.mainCamera.transform.position - var_90_11.position).z)
				var_90_11.localEulerAngles.z = 0
				var_90_11.localEulerAngles.x = 0
				var_90_11.localEulerAngles = var_90_11.localEulerAngles
			end

			if arg_87_1.time_ >= 2 + var_90_12 and arg_87_1.time_ < 2 + var_90_12 + arg_90_0 then
				var_90_11.localPosition = Vector3.New(0, -1.01, -6.2)
				var_90_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_11.position).x, (manager.ui.mainCamera.transform.position - var_90_11.position).y, (manager.ui.mainCamera.transform.position - var_90_11.position).z)
				var_90_11.localEulerAngles.z = 0
				var_90_11.localEulerAngles.x = 0
				var_90_11.localEulerAngles = var_90_11.localEulerAngles
			end

			local var_90_13 = arg_87_1.actors_["1150ui_story"]

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 and not isNil(var_90_13) and arg_87_1.var_.characterEffect1150ui_story == nil then
				arg_87_1.var_.characterEffect1150ui_story = var_90_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_14 = 0.200000002980232

			if 2 <= arg_87_1.time_ and arg_87_1.time_ < 2 + var_90_14 and not isNil(var_90_13) then
				if arg_87_1.var_.characterEffect1150ui_story and not isNil(var_90_13) then
					arg_87_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 2 + var_90_14 and arg_87_1.time_ < 2 + var_90_14 + arg_90_0 and not isNil(var_90_13) and arg_87_1.var_.characterEffect1150ui_story then
				arg_87_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				arg_87_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action1_1")
			end

			if 2 < arg_87_1.time_ and arg_87_1.time_ <= 2 + arg_90_0 then
				arg_87_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_16 = 4
			local var_90_17 = 0.875

			if 4 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_18 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_18:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_19 = arg_87_1:GetWordFromCfg(318132020)
				local var_90_20 = arg_87_1:FormatText(var_90_19.content)

				arg_87_1.text_.text = var_90_20

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_22 = 35 <= 0 and var_90_17 or var_90_17 * (utf8.len(var_90_20) / 35)

				if (35 <= 0 and var_90_17 or var_90_17 * (utf8.len(var_90_20) / 35)) > 0 and var_90_17 < var_90_22 then
					arg_87_1.talkMaxDuration = var_90_22
					var_90_16 = var_90_16 + 0.3

					if var_90_22 + var_90_16 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_16
					end
				end

				arg_87_1.text_.text = var_90_20
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132020", "story_v_out_318132.awb") ~= 0 then
					local var_90_23 = manager.audio:GetVoiceLength("story_v_out_318132", "318132020", "story_v_out_318132.awb") / 1000

					if var_90_23 + var_90_16 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_16
					end

					if var_90_19.prefab_name ~= "" and arg_87_1.actors_[var_90_19.prefab_name] ~= nil then
						local var_90_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_19.prefab_name].transform, "story_v_out_318132", "318132020", "story_v_out_318132.awb")

						arg_87_1:RecordAudio("318132020", var_90_24)
						arg_87_1:RecordAudio("318132020", var_90_24)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_318132", "318132020", "story_v_out_318132.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_318132", "318132020", "story_v_out_318132.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_25 = var_90_16 + 0.3
			local var_90_26 = math.max(var_90_17, arg_87_1.talkMaxDuration)

			if var_90_16 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_25 + var_90_26 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_25) / var_90_26

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_25 + var_90_26 and arg_87_1.time_ < var_90_25 + var_90_26 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play318132021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 318132021
		arg_93_1.duration_ = 7.63

		local var_93_0 = {
			zh = 6.566,
			ja = 7.633
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
				arg_93_0:Play318132022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_96_0 = 0
			local var_96_1 = 0.8

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(318132021)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 32 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 32)

				if (32 <= 0 and var_96_1 or var_96_1 * (utf8.len(var_96_3) / 32)) > 0 and var_96_1 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132021", "story_v_out_318132.awb") ~= 0 then
					local var_96_6 = manager.audio:GetVoiceLength("story_v_out_318132", "318132021", "story_v_out_318132.awb") / 1000

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end

					if var_96_2.prefab_name ~= "" and arg_93_1.actors_[var_96_2.prefab_name] ~= nil then
						local var_96_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_2.prefab_name].transform, "story_v_out_318132", "318132021", "story_v_out_318132.awb")

						arg_93_1:RecordAudio("318132021", var_96_7)
						arg_93_1:RecordAudio("318132021", var_96_7)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_318132", "318132021", "story_v_out_318132.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_318132", "318132021", "story_v_out_318132.awb")
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
	Play318132022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 318132022
		arg_97_1.duration_ = 5.63

		local var_97_0 = {
			zh = 5.633,
			ja = 5.6
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
				arg_97_0:Play318132023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.75

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(318132022)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 30 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 30)

				if (30 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 30)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132022", "story_v_out_318132.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_318132", "318132022", "story_v_out_318132.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_318132", "318132022", "story_v_out_318132.awb")

						arg_97_1:RecordAudio("318132022", var_100_6)
						arg_97_1:RecordAudio("318132022", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_318132", "318132022", "story_v_out_318132.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_318132", "318132022", "story_v_out_318132.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play318132023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 318132023
		arg_101_1.duration_ = 4.67

		local var_101_0 = {
			zh = 4.433,
			ja = 4.666
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
				arg_101_0:Play318132024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_0 = 0
			local var_104_1 = 0.575

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(318132023)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 23 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 23)

				if (23 <= 0 and var_104_1 or var_104_1 * (utf8.len(var_104_3) / 23)) > 0 and var_104_1 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132023", "story_v_out_318132.awb") ~= 0 then
					local var_104_6 = manager.audio:GetVoiceLength("story_v_out_318132", "318132023", "story_v_out_318132.awb") / 1000

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end

					if var_104_2.prefab_name ~= "" and arg_101_1.actors_[var_104_2.prefab_name] ~= nil then
						local var_104_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_2.prefab_name].transform, "story_v_out_318132", "318132023", "story_v_out_318132.awb")

						arg_101_1:RecordAudio("318132023", var_104_7)
						arg_101_1:RecordAudio("318132023", var_104_7)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_318132", "318132023", "story_v_out_318132.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_318132", "318132023", "story_v_out_318132.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play318132024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 318132024
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play318132025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.actors_["1050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1050ui_story"))) then
				local var_108_0 = Object.Instantiate(Asset.Load("Char/" .. "1050ui_story"), arg_105_1.stage_.transform)

				var_108_0.name = "1050ui_story"
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["1050ui_story"] = var_108_0

				local var_108_1 = var_108_0:GetComponentInChildren(typeof(CharacterEffect))

				var_108_1.enabled = true

				local var_108_2 = GameObjectTools.GetOrAddComponent(var_108_0, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(false)
				end

				arg_105_1:ShowWeapon(var_108_1.transform, false)

				arg_105_1.var_["1050ui_story" .. "Animator"] = var_108_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_105_1.var_["1050ui_story" .. "Animator"].applyRootMotion = true
				arg_105_1.var_["1050ui_story" .. "LipSync"] = var_108_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_108_3 = arg_105_1.actors_["1050ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect1050ui_story == nil then
				arg_105_1.var_.characterEffect1050ui_story = var_108_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_4 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 and not isNil(var_108_3) then
				if arg_105_1.var_.characterEffect1050ui_story and not isNil(var_108_3) then
					arg_105_1.var_.characterEffect1050ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_4)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 and not isNil(var_108_3) and arg_105_1.var_.characterEffect1050ui_story then
				arg_105_1.var_.characterEffect1050ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1050ui_story.fillRatio = 0.5
			end

			local var_108_5 = 0
			local var_108_6 = 0.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(318132024).content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 18 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_7) / 18)

				if (18 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_7) / 18)) > 0 and var_108_6 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_6, arg_105_1.talkMaxDuration)

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_5) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_5 + var_108_10 and arg_105_1.time_ < var_108_5 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play318132025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 318132025
		arg_109_1.duration_ = 3.77

		local var_109_0 = {
			zh = 1.999999999999,
			ja = 3.766
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
			arg_109_1.auto_ = false
		end

		function arg_109_1.playNext_(arg_111_0)
			arg_109_1.onStoryFinished_()
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1150ui_story = arg_109_1.actors_["1150ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1150ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1150ui_story, Vector3.New(0, -1.01, -6.2), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1150ui_story"].transform.position).z)
				arg_109_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1150ui_story"].transform.localEulerAngles = arg_109_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1150ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.2)
				arg_109_1.actors_["1150ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1150ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1150ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1150ui_story"].transform.position).z)
				arg_109_1.actors_["1150ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1150ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1150ui_story"].transform.localEulerAngles = arg_109_1.actors_["1150ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1150ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1150ui_story == nil then
				arg_109_1.var_.characterEffect1150ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1150ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1150ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1150ui_story then
				arg_109_1.var_.characterEffect1150ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/story1150/story1150action/1150action4_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1150ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.2

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(318132025)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 8 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 8)

				if (8 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 8)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_318132", "318132025", "story_v_out_318132.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_318132", "318132025", "story_v_out_318132.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_318132", "318132025", "story_v_out_318132.awb")

						arg_109_1:RecordAudio("318132025", var_112_11)
						arg_109_1:RecordAudio("318132025", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_318132", "318132025", "story_v_out_318132.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_318132", "318132025", "story_v_out_318132.awb")
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

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1150ui_story",
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
	assets = {
		"TextureConfig/Background/C07_1",
		"TextureConfig/Background/k15f",
		"TextureConfig/Background/LX0102",
		"TextureConfig/Background/LX0102_blur"
	},
	voices = {
		"story_v_out_318132.awb"
	}
}
