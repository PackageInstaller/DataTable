return {
	Play116071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116071001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST18 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST18")
				var_4_0.name = "ST18"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST18 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_1 = arg_1_1.bgs_.ST18

				arg_1_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST18" then
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

			if 1.23333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.23333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= "" and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = ""

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = ""
						arg_1_1.bgmTxt2_.text = ""
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

			if 1.36666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.36666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "dialog_init", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[95].musicName ~= "" then
					if arg_1_1.bgmTxt_.text ~= MusicRecordCfg[95].musicName and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = MusicRecordCfg[95].musicName

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = MusicRecordCfg[95].musicName
						arg_1_1.bgmTxt2_.text = MusicRecordCfg[95].musicName
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
			local var_4_15 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116071001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 13 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 13)

				if (13 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 13)) > 0 and var_4_15 < var_4_19 then
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
	Play116071002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116071002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116071003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if arg_10_1.actors_["10025ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10025ui_story"))) then
				local var_13_0 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_10_1.stage_.transform)

				var_13_0.name = "10025ui_story"
				var_13_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_10_1.actors_["10025ui_story"] = var_13_0

				local var_13_1 = var_13_0:GetComponentInChildren(typeof(CharacterEffect))

				var_13_1.enabled = true

				local var_13_2 = GameObjectTools.GetOrAddComponent(var_13_0, typeof(DynamicBoneHelper))

				if var_13_2 then
					var_13_2:EnableDynamicBone(false)
				end

				arg_10_1:ShowWeapon(var_13_1.transform, false)

				arg_10_1.var_["10025ui_story" .. "Animator"] = var_13_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_10_1.var_["10025ui_story" .. "Animator"].applyRootMotion = true
				arg_10_1.var_["10025ui_story" .. "LipSync"] = var_13_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_13_3 = arg_10_1.actors_["10025ui_story"]

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 and not isNil(var_13_3) and arg_10_1.var_.characterEffect10025ui_story == nil then
				arg_10_1.var_.characterEffect10025ui_story = var_13_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_4 = 0.2

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_4 and not isNil(var_13_3) then
				if arg_10_1.var_.characterEffect10025ui_story and not isNil(var_13_3) then
					arg_10_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= 0 + var_13_4 and arg_10_1.time_ < 0 + var_13_4 + arg_13_0 and not isNil(var_13_3) and arg_10_1.var_.characterEffect10025ui_story then
				arg_10_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_13_6 = arg_10_1.actors_["10025ui_story"].transform

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPos10025ui_story = var_13_6.localPosition
			end

			local var_13_7 = 0.001

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				var_13_6.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_10_1.time_ - 0) / var_13_7)
				var_13_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_6.position).x, (manager.ui.mainCamera.transform.position - var_13_6.position).y, (manager.ui.mainCamera.transform.position - var_13_6.position).z)
				var_13_6.localEulerAngles.z = 0
				var_13_6.localEulerAngles.x = 0
				var_13_6.localEulerAngles = var_13_6.localEulerAngles
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				var_13_6.localPosition = Vector3.New(0, -1.1, -5.9)
				var_13_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_13_6.position).x, (manager.ui.mainCamera.transform.position - var_13_6.position).y, (manager.ui.mainCamera.transform.position - var_13_6.position).z)
				var_13_6.localEulerAngles.z = 0
				var_13_6.localEulerAngles.x = 0
				var_13_6.localEulerAngles = var_13_6.localEulerAngles
			end

			local var_13_8 = 0
			local var_13_9 = 0.45

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_10 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(116071002).content)

				arg_10_1.text_.text = var_13_10

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_12 = 18 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_10) / 18)

				if (18 <= 0 and var_13_9 or var_13_9 * (utf8.len(var_13_10) / 18)) > 0 and var_13_9 < var_13_12 then
					arg_10_1.talkMaxDuration = var_13_12

					if var_13_12 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_12 + var_13_8
					end
				end

				arg_10_1.text_.text = var_13_10
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_13 = math.max(var_13_9, arg_10_1.talkMaxDuration)

			if var_13_8 <= arg_10_1.time_ and arg_10_1.time_ < var_13_8 + var_13_13 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_8) / var_13_13

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_8 + var_13_13 and arg_10_1.time_ < var_13_8 + var_13_13 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play116071003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116071003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116071004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(arg_14_1.actors_["10025ui_story"]) and arg_14_1.var_.characterEffect10025ui_story == nil then
				arg_14_1.var_.characterEffect10025ui_story = arg_14_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_0 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 and not isNil(arg_14_1.actors_["10025ui_story"]) then
				if arg_14_1.var_.characterEffect10025ui_story and not isNil(arg_14_1.actors_["10025ui_story"]) then
					arg_14_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_14_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_14_1.time_ - 0) / var_17_0)
				end
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 and not isNil(arg_14_1.actors_["10025ui_story"]) and arg_14_1.var_.characterEffect10025ui_story then
				arg_14_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_14_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_17_1 = 0
			local var_17_2 = 0.425

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
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

				local var_17_3 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(116071003).content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 17 <= 0 and var_17_2 or var_17_2 * (utf8.len(var_17_3) / 17)

				if (17 <= 0 and var_17_2 or var_17_2 * (utf8.len(var_17_3) / 17)) > 0 and var_17_2 < var_17_5 then
					arg_14_1.talkMaxDuration = var_17_5

					if var_17_5 + var_17_1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + var_17_1
					end
				end

				arg_14_1.text_.text = var_17_3
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_6 = math.max(var_17_2, arg_14_1.talkMaxDuration)

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_6 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_1) / var_17_6

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_1 + var_17_6 and arg_14_1.time_ < var_17_1 + var_17_6 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play116071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116071004
		arg_18_1.duration_ = 2

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["10025ui_story"]) and arg_18_1.var_.characterEffect10025ui_story == nil then
				arg_18_1.var_.characterEffect10025ui_story = arg_18_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["10025ui_story"]) then
				if arg_18_1.var_.characterEffect10025ui_story and not isNil(arg_18_1.actors_["10025ui_story"]) then
					arg_18_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["10025ui_story"]) and arg_18_1.var_.characterEffect10025ui_story then
				arg_18_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_21_2 = 0
			local var_21_3 = 0.1

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_2 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_4 = arg_18_1:GetWordFromCfg(116071004)
				local var_21_5 = arg_18_1:FormatText(var_21_4.content)

				arg_18_1.text_.text = var_21_5

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_7 = 4 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_5) / 4)

				if (4 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_5) / 4)) > 0 and var_21_3 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_2
					end
				end

				arg_18_1.text_.text = var_21_5
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071004", "story_v_out_116071.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071004", "story_v_out_116071.awb") / 1000

					if var_21_8 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_2
					end

					if var_21_4.prefab_name ~= "" and arg_18_1.actors_[var_21_4.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_4.prefab_name].transform, "story_v_out_116071", "116071004", "story_v_out_116071.awb")

						arg_18_1:RecordAudio("116071004", var_21_9)
						arg_18_1:RecordAudio("116071004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_116071", "116071004", "story_v_out_116071.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_116071", "116071004", "story_v_out_116071.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_3, arg_18_1.talkMaxDuration)

			if var_21_2 <= arg_18_1.time_ and arg_18_1.time_ < var_21_2 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_2) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_2 + var_21_10 and arg_18_1.time_ < var_21_2 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play116071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116071005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(arg_22_1.actors_["10025ui_story"]) and arg_22_1.var_.characterEffect10025ui_story == nil then
				arg_22_1.var_.characterEffect10025ui_story = arg_22_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_0 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 and not isNil(arg_22_1.actors_["10025ui_story"]) then
				if arg_22_1.var_.characterEffect10025ui_story and not isNil(arg_22_1.actors_["10025ui_story"]) then
					arg_22_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_22_1.time_ - 0) / var_25_0)
				end
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 and not isNil(arg_22_1.actors_["10025ui_story"]) and arg_22_1.var_.characterEffect10025ui_story then
				arg_22_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_25_1 = 0
			local var_25_2 = 0.85

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
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

				local var_25_3 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(116071005).content)

				arg_22_1.text_.text = var_25_3

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_5 = 34 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_3) / 34)

				if (34 <= 0 and var_25_2 or var_25_2 * (utf8.len(var_25_3) / 34)) > 0 and var_25_2 < var_25_5 then
					arg_22_1.talkMaxDuration = var_25_5

					if var_25_5 + var_25_1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + var_25_1
					end
				end

				arg_22_1.text_.text = var_25_3
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_6 = math.max(var_25_2, arg_22_1.talkMaxDuration)

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_6 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_1) / var_25_6

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_1 + var_25_6 and arg_22_1.time_ < var_25_1 + var_25_6 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play116071006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116071006
		arg_26_1.duration_ = 6.57

		local var_26_0 = {
			zh = 5,
			ja = 6.566
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
				arg_26_0:Play116071007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["10025ui_story"]) and arg_26_1.var_.characterEffect10025ui_story == nil then
				arg_26_1.var_.characterEffect10025ui_story = arg_26_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.2

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["10025ui_story"]) then
				if arg_26_1.var_.characterEffect10025ui_story and not isNil(arg_26_1.actors_["10025ui_story"]) then
					arg_26_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["10025ui_story"]) and arg_26_1.var_.characterEffect10025ui_story then
				arg_26_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_29_2 = 0
			local var_29_3 = 0.45

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_4 = arg_26_1:GetWordFromCfg(116071006)
				local var_29_5 = arg_26_1:FormatText(var_29_4.content)

				arg_26_1.text_.text = var_29_5

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_7 = 18 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_5) / 18)

				if (18 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_5) / 18)) > 0 and var_29_3 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_2
					end
				end

				arg_26_1.text_.text = var_29_5
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071006", "story_v_out_116071.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071006", "story_v_out_116071.awb") / 1000

					if var_29_8 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_2
					end

					if var_29_4.prefab_name ~= "" and arg_26_1.actors_[var_29_4.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_4.prefab_name].transform, "story_v_out_116071", "116071006", "story_v_out_116071.awb")

						arg_26_1:RecordAudio("116071006", var_29_9)
						arg_26_1:RecordAudio("116071006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_116071", "116071006", "story_v_out_116071.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_116071", "116071006", "story_v_out_116071.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_3, arg_26_1.talkMaxDuration)

			if var_29_2 <= arg_26_1.time_ and arg_26_1.time_ < var_29_2 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_2) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_2 + var_29_10 and arg_26_1.time_ < var_29_2 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play116071007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116071007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116071008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10025ui_story"]) and arg_30_1.var_.characterEffect10025ui_story == nil then
				arg_30_1.var_.characterEffect10025ui_story = arg_30_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10025ui_story"]) then
				if arg_30_1.var_.characterEffect10025ui_story and not isNil(arg_30_1.actors_["10025ui_story"]) then
					arg_30_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_30_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_0)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10025ui_story"]) and arg_30_1.var_.characterEffect10025ui_story then
				arg_30_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_30_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_33_1 = 0
			local var_33_2 = 0.125

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_3 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(116071007).content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 5 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 5)

				if (5 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 5)) > 0 and var_33_2 < var_33_5 then
					arg_30_1.talkMaxDuration = var_33_5

					if var_33_5 + var_33_1 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + var_33_1
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_6 = math.max(var_33_2, arg_30_1.talkMaxDuration)

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_6 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_1) / var_33_6

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_1 + var_33_6 and arg_30_1.time_ < var_33_1 + var_33_6 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play116071008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 116071008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play116071009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10025ui_story = arg_34_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_37_0 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				arg_34_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_34_1.time_ - 0) / var_37_0)
				arg_34_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["10025ui_story"].transform.position).z)
				arg_34_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["10025ui_story"].transform.localEulerAngles = arg_34_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				arg_34_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["10025ui_story"].transform.position).z)
				arg_34_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["10025ui_story"].transform.localEulerAngles = arg_34_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			local var_37_1 = 0
			local var_37_2 = 1.5

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_3 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(116071008).content)

				arg_34_1.text_.text = var_37_3

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_5 = 60 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_3) / 60)

				if (60 <= 0 and var_37_2 or var_37_2 * (utf8.len(var_37_3) / 60)) > 0 and var_37_2 < var_37_5 then
					arg_34_1.talkMaxDuration = var_37_5

					if var_37_5 + var_37_1 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_5 + var_37_1
					end
				end

				arg_34_1.text_.text = var_37_3
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_6 = math.max(var_37_2, arg_34_1.talkMaxDuration)

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_6 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_1) / var_37_6

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_1 + var_37_6 and arg_34_1.time_ < var_37_1 + var_37_6 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play116071009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 116071009
		arg_38_1.duration_ = 2

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play116071010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10025ui_story"]) and arg_38_1.var_.characterEffect10025ui_story == nil then
				arg_38_1.var_.characterEffect10025ui_story = arg_38_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10025ui_story"]) then
				if arg_38_1.var_.characterEffect10025ui_story and not isNil(arg_38_1.actors_["10025ui_story"]) then
					arg_38_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10025ui_story"]) and arg_38_1.var_.characterEffect10025ui_story then
				arg_38_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_41_2 = arg_38_1.actors_["10025ui_story"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10025ui_story = var_41_2.localPosition
			end

			local var_41_3 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 then
				var_41_2.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_38_1.time_ - 0) / var_41_3)
				var_41_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_2.position).x, (manager.ui.mainCamera.transform.position - var_41_2.position).y, (manager.ui.mainCamera.transform.position - var_41_2.position).z)
				var_41_2.localEulerAngles.z = 0
				var_41_2.localEulerAngles.x = 0
				var_41_2.localEulerAngles = var_41_2.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 then
				var_41_2.localPosition = Vector3.New(0, -1.1, -5.9)
				var_41_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_41_2.position).x, (manager.ui.mainCamera.transform.position - var_41_2.position).y, (manager.ui.mainCamera.transform.position - var_41_2.position).z)
				var_41_2.localEulerAngles.z = 0
				var_41_2.localEulerAngles.x = 0
				var_41_2.localEulerAngles = var_41_2.localEulerAngles
			end

			local var_41_4 = 0
			local var_41_5 = 0.1

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(116071009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 4 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 4)

				if (4 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 4)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071009", "story_v_out_116071.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_116071", "116071009", "story_v_out_116071.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_116071", "116071009", "story_v_out_116071.awb")

						arg_38_1:RecordAudio("116071009", var_41_11)
						arg_38_1:RecordAudio("116071009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_116071", "116071009", "story_v_out_116071.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_116071", "116071009", "story_v_out_116071.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_12 and arg_38_1.time_ < var_41_4 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play116071010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116071010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116071011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["10025ui_story"]) and arg_42_1.var_.characterEffect10025ui_story == nil then
				arg_42_1.var_.characterEffect10025ui_story = arg_42_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["10025ui_story"]) then
				if arg_42_1.var_.characterEffect10025ui_story and not isNil(arg_42_1.actors_["10025ui_story"]) then
					arg_42_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["10025ui_story"]) and arg_42_1.var_.characterEffect10025ui_story then
				arg_42_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 0.25

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(116071010).content)

				arg_42_1.text_.text = var_45_3

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 10 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 10)

				if (10 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 10)) > 0 and var_45_2 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_3
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_6 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_6 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_6

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_6 and arg_42_1.time_ < var_45_1 + var_45_6 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116071011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116071011
		arg_46_1.duration_ = 9.37

		local var_46_0 = {
			zh = 5.066,
			ja = 9.366
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
				arg_46_0:Play116071012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10025ui_story"]) and arg_46_1.var_.characterEffect10025ui_story == nil then
				arg_46_1.var_.characterEffect10025ui_story = arg_46_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10025ui_story"]) then
				if arg_46_1.var_.characterEffect10025ui_story and not isNil(arg_46_1.actors_["10025ui_story"]) then
					arg_46_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10025ui_story"]) and arg_46_1.var_.characterEffect10025ui_story then
				arg_46_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_49_2 = 0
			local var_49_3 = 0.5

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:GetWordFromCfg(116071011)
				local var_49_5 = arg_46_1:FormatText(var_49_4.content)

				arg_46_1.text_.text = var_49_5

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_7 = 20 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 20)

				if (20 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_5) / 20)) > 0 and var_49_3 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_5
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071011", "story_v_out_116071.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071011", "story_v_out_116071.awb") / 1000

					if var_49_8 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_2
					end

					if var_49_4.prefab_name ~= "" and arg_46_1.actors_[var_49_4.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_4.prefab_name].transform, "story_v_out_116071", "116071011", "story_v_out_116071.awb")

						arg_46_1:RecordAudio("116071011", var_49_9)
						arg_46_1:RecordAudio("116071011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_116071", "116071011", "story_v_out_116071.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_116071", "116071011", "story_v_out_116071.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_10 and arg_46_1.time_ < var_49_2 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play116071012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116071012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play116071013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10025ui_story"]) and arg_50_1.var_.characterEffect10025ui_story == nil then
				arg_50_1.var_.characterEffect10025ui_story = arg_50_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10025ui_story"]) then
				if arg_50_1.var_.characterEffect10025ui_story and not isNil(arg_50_1.actors_["10025ui_story"]) then
					arg_50_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_50_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10025ui_story"]) and arg_50_1.var_.characterEffect10025ui_story then
				arg_50_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_50_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_53_1 = 0
			local var_53_2 = 0.575

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

				local var_53_3 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(116071012).content)

				arg_50_1.text_.text = var_53_3

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 23 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 23)

				if (23 <= 0 and var_53_2 or var_53_2 * (utf8.len(var_53_3) / 23)) > 0 and var_53_2 < var_53_5 then
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
	Play116071013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 116071013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play116071014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.8

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(116071013).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 32 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 32)

				if (32 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 32)) > 0 and var_57_0 < var_57_3 then
					arg_54_1.talkMaxDuration = var_57_3

					if var_57_3 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_3 + 0
					end
				end

				arg_54_1.text_.text = var_57_1
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_4 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_4

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play116071014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 116071014
		arg_58_1.duration_ = 10.13

		local var_58_0 = {
			zh = 8.433,
			ja = 10.133
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
				arg_58_0:Play116071015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10025ui_story"]) and arg_58_1.var_.characterEffect10025ui_story == nil then
				arg_58_1.var_.characterEffect10025ui_story = arg_58_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10025ui_story"]) then
				if arg_58_1.var_.characterEffect10025ui_story and not isNil(arg_58_1.actors_["10025ui_story"]) then
					arg_58_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10025ui_story"]) and arg_58_1.var_.characterEffect10025ui_story then
				arg_58_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			local var_61_2 = 0
			local var_61_3 = 0.625

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_4 = arg_58_1:GetWordFromCfg(116071014)
				local var_61_5 = arg_58_1:FormatText(var_61_4.content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 25 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 25)

				if (25 <= 0 and var_61_3 or var_61_3 * (utf8.len(var_61_5) / 25)) > 0 and var_61_3 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_2
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071014", "story_v_out_116071.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071014", "story_v_out_116071.awb") / 1000

					if var_61_8 + var_61_2 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_2
					end

					if var_61_4.prefab_name ~= "" and arg_58_1.actors_[var_61_4.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_4.prefab_name].transform, "story_v_out_116071", "116071014", "story_v_out_116071.awb")

						arg_58_1:RecordAudio("116071014", var_61_9)
						arg_58_1:RecordAudio("116071014", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_116071", "116071014", "story_v_out_116071.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_116071", "116071014", "story_v_out_116071.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_3, arg_58_1.talkMaxDuration)

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_2) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_2 + var_61_10 and arg_58_1.time_ < var_61_2 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play116071015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 116071015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play116071016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["10025ui_story"]) and arg_62_1.var_.characterEffect10025ui_story == nil then
				arg_62_1.var_.characterEffect10025ui_story = arg_62_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.2

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["10025ui_story"]) then
				if arg_62_1.var_.characterEffect10025ui_story and not isNil(arg_62_1.actors_["10025ui_story"]) then
					arg_62_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_0)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["10025ui_story"]) and arg_62_1.var_.characterEffect10025ui_story then
				arg_62_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_65_1 = 0
			local var_65_2 = 0.275

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(116071015).content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 11 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 11)

				if (11 <= 0 and var_65_2 or var_65_2 * (utf8.len(var_65_3) / 11)) > 0 and var_65_2 < var_65_5 then
					arg_62_1.talkMaxDuration = var_65_5

					if var_65_5 + var_65_1 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + var_65_1
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_6 = math.max(var_65_2, arg_62_1.talkMaxDuration)

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_6 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_1) / var_65_6

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_1 + var_65_6 and arg_62_1.time_ < var_65_1 + var_65_6 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play116071016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116071016
		arg_66_1.duration_ = 16.53

		local var_66_0 = {
			zh = 6.9,
			ja = 16.533
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
				arg_66_0:Play116071017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10025ui_story"]) and arg_66_1.var_.characterEffect10025ui_story == nil then
				arg_66_1.var_.characterEffect10025ui_story = arg_66_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10025ui_story"]) then
				if arg_66_1.var_.characterEffect10025ui_story and not isNil(arg_66_1.actors_["10025ui_story"]) then
					arg_66_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10025ui_story"]) and arg_66_1.var_.characterEffect10025ui_story then
				arg_66_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_69_2 = 0
			local var_69_3 = 0.5

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_4 = arg_66_1:GetWordFromCfg(116071016)
				local var_69_5 = arg_66_1:FormatText(var_69_4.content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 20 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 20)

				if (20 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_5) / 20)) > 0 and var_69_3 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071016", "story_v_out_116071.awb") ~= 0 then
					local var_69_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071016", "story_v_out_116071.awb") / 1000

					if var_69_8 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_8 + var_69_2
					end

					if var_69_4.prefab_name ~= "" and arg_66_1.actors_[var_69_4.prefab_name] ~= nil then
						local var_69_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_4.prefab_name].transform, "story_v_out_116071", "116071016", "story_v_out_116071.awb")

						arg_66_1:RecordAudio("116071016", var_69_9)
						arg_66_1:RecordAudio("116071016", var_69_9)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_116071", "116071016", "story_v_out_116071.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_116071", "116071016", "story_v_out_116071.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_10 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_10 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_10

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_10 and arg_66_1.time_ < var_69_2 + var_69_10 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play116071017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116071017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116071018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10025ui_story"]) and arg_70_1.var_.characterEffect10025ui_story == nil then
				arg_70_1.var_.characterEffect10025ui_story = arg_70_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10025ui_story"]) then
				if arg_70_1.var_.characterEffect10025ui_story and not isNil(arg_70_1.actors_["10025ui_story"]) then
					arg_70_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10025ui_story"]) and arg_70_1.var_.characterEffect10025ui_story then
				arg_70_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 0.625

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(116071017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 25 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 25)

				if (25 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 25)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play116071018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116071018
		arg_74_1.duration_ = 3.4

		local var_74_0 = {
			zh = 1.999999999999,
			ja = 3.4
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
				arg_74_0:Play116071019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["10025ui_story"]) and arg_74_1.var_.characterEffect10025ui_story == nil then
				arg_74_1.var_.characterEffect10025ui_story = arg_74_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["10025ui_story"]) then
				if arg_74_1.var_.characterEffect10025ui_story and not isNil(arg_74_1.actors_["10025ui_story"]) then
					arg_74_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["10025ui_story"]) and arg_74_1.var_.characterEffect10025ui_story then
				arg_74_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_77_2 = 0
			local var_77_3 = 0.2

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(116071018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 8 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 8)

				if (8 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 8)) > 0 and var_77_3 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071018", "story_v_out_116071.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071018", "story_v_out_116071.awb") / 1000

					if var_77_8 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_2
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_116071", "116071018", "story_v_out_116071.awb")

						arg_74_1:RecordAudio("116071018", var_77_9)
						arg_74_1:RecordAudio("116071018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_116071", "116071018", "story_v_out_116071.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_116071", "116071018", "story_v_out_116071.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_10 and arg_74_1.time_ < var_77_2 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play116071019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116071019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116071020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["10025ui_story"]) and arg_78_1.var_.characterEffect10025ui_story == nil then
				arg_78_1.var_.characterEffect10025ui_story = arg_78_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.2

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["10025ui_story"]) then
				if arg_78_1.var_.characterEffect10025ui_story and not isNil(arg_78_1.actors_["10025ui_story"]) then
					arg_78_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["10025ui_story"]) and arg_78_1.var_.characterEffect10025ui_story then
				arg_78_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_81_1 = 0
			local var_81_2 = 0.575

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_3 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(116071019).content)

				arg_78_1.text_.text = var_81_3

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 23 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 23)

				if (23 <= 0 and var_81_2 or var_81_2 * (utf8.len(var_81_3) / 23)) > 0 and var_81_2 < var_81_5 then
					arg_78_1.talkMaxDuration = var_81_5

					if var_81_5 + var_81_1 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + var_81_1
					end
				end

				arg_78_1.text_.text = var_81_3
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_6 = math.max(var_81_2, arg_78_1.talkMaxDuration)

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_6 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_1) / var_81_6

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_1 + var_81_6 and arg_78_1.time_ < var_81_1 + var_81_6 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play116071020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116071020
		arg_82_1.duration_ = 5.37

		local var_82_0 = {
			zh = 5.366,
			ja = 3.8
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
				arg_82_0:Play116071021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10025ui_story"]) and arg_82_1.var_.characterEffect10025ui_story == nil then
				arg_82_1.var_.characterEffect10025ui_story = arg_82_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10025ui_story"]) then
				if arg_82_1.var_.characterEffect10025ui_story and not isNil(arg_82_1.actors_["10025ui_story"]) then
					arg_82_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10025ui_story"]) and arg_82_1.var_.characterEffect10025ui_story then
				arg_82_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_85_2 = 0
			local var_85_3 = 0.4

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_4 = arg_82_1:GetWordFromCfg(116071020)
				local var_85_5 = arg_82_1:FormatText(var_85_4.content)

				arg_82_1.text_.text = var_85_5

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_7 = 16 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_5) / 16)

				if (16 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_5) / 16)) > 0 and var_85_3 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_2
					end
				end

				arg_82_1.text_.text = var_85_5
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071020", "story_v_out_116071.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071020", "story_v_out_116071.awb") / 1000

					if var_85_8 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_2
					end

					if var_85_4.prefab_name ~= "" and arg_82_1.actors_[var_85_4.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_4.prefab_name].transform, "story_v_out_116071", "116071020", "story_v_out_116071.awb")

						arg_82_1:RecordAudio("116071020", var_85_9)
						arg_82_1:RecordAudio("116071020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_116071", "116071020", "story_v_out_116071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_116071", "116071020", "story_v_out_116071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_3, arg_82_1.talkMaxDuration)

			if var_85_2 <= arg_82_1.time_ and arg_82_1.time_ < var_85_2 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_2) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_2 + var_85_10 and arg_82_1.time_ < var_85_2 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116071021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116071021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116071022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10025ui_story"]) and arg_86_1.var_.characterEffect10025ui_story == nil then
				arg_86_1.var_.characterEffect10025ui_story = arg_86_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10025ui_story"]) then
				if arg_86_1.var_.characterEffect10025ui_story and not isNil(arg_86_1.actors_["10025ui_story"]) then
					arg_86_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_0)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10025ui_story"]) and arg_86_1.var_.characterEffect10025ui_story then
				arg_86_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_89_1 = 0
			local var_89_2 = 0.375

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_3 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(116071021).content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 15 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 15)

				if (15 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 15)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_6 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_6 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_6

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_6 and arg_86_1.time_ < var_89_1 + var_89_6 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play116071022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116071022
		arg_90_1.duration_ = 2.7

		local var_90_0 = {
			zh = 2.7,
			ja = 1.999999999999
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
				arg_90_0:Play116071023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["10025ui_story"]) and arg_90_1.var_.characterEffect10025ui_story == nil then
				arg_90_1.var_.characterEffect10025ui_story = arg_90_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["10025ui_story"]) then
				if arg_90_1.var_.characterEffect10025ui_story and not isNil(arg_90_1.actors_["10025ui_story"]) then
					arg_90_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["10025ui_story"]) and arg_90_1.var_.characterEffect10025ui_story then
				arg_90_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action7_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_93_2 = 0
			local var_93_3 = 0.1

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_2 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_4 = arg_90_1:GetWordFromCfg(116071022)
				local var_93_5 = arg_90_1:FormatText(var_93_4.content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 4 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 4)

				if (4 <= 0 and var_93_3 or var_93_3 * (utf8.len(var_93_5) / 4)) > 0 and var_93_3 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_2
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071022", "story_v_out_116071.awb") ~= 0 then
					local var_93_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071022", "story_v_out_116071.awb") / 1000

					if var_93_8 + var_93_2 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_8 + var_93_2
					end

					if var_93_4.prefab_name ~= "" and arg_90_1.actors_[var_93_4.prefab_name] ~= nil then
						local var_93_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_4.prefab_name].transform, "story_v_out_116071", "116071022", "story_v_out_116071.awb")

						arg_90_1:RecordAudio("116071022", var_93_9)
						arg_90_1:RecordAudio("116071022", var_93_9)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_116071", "116071022", "story_v_out_116071.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_116071", "116071022", "story_v_out_116071.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_3, arg_90_1.talkMaxDuration)

			if var_93_2 <= arg_90_1.time_ and arg_90_1.time_ < var_93_2 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_2) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_2 + var_93_10 and arg_90_1.time_ < var_93_2 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116071023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116071023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116071024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["10025ui_story"]) and arg_94_1.var_.characterEffect10025ui_story == nil then
				arg_94_1.var_.characterEffect10025ui_story = arg_94_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["10025ui_story"]) then
				if arg_94_1.var_.characterEffect10025ui_story and not isNil(arg_94_1.actors_["10025ui_story"]) then
					arg_94_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_0)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["10025ui_story"]) and arg_94_1.var_.characterEffect10025ui_story then
				arg_94_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_97_1 = arg_94_1.actors_["10025ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos10025ui_story = var_97_1.localPosition
			end

			local var_97_2 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_2 then
				var_97_1.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_2)
				var_97_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_1.position).x, (manager.ui.mainCamera.transform.position - var_97_1.position).y, (manager.ui.mainCamera.transform.position - var_97_1.position).z)
				var_97_1.localEulerAngles.z = 0
				var_97_1.localEulerAngles.x = 0
				var_97_1.localEulerAngles = var_97_1.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_2 and arg_94_1.time_ < 0 + var_97_2 + arg_97_0 then
				var_97_1.localPosition = Vector3.New(0, 100, 0)
				var_97_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_1.position).x, (manager.ui.mainCamera.transform.position - var_97_1.position).y, (manager.ui.mainCamera.transform.position - var_97_1.position).z)
				var_97_1.localEulerAngles.z = 0
				var_97_1.localEulerAngles.x = 0
				var_97_1.localEulerAngles = var_97_1.localEulerAngles
			end

			local var_97_3 = 0
			local var_97_4 = 0.65

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_5 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(116071023).content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 26 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_5) / 26)

				if (26 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_5) / 26)) > 0 and var_97_4 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_3
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_4, arg_94_1.talkMaxDuration)

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_3) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_3 + var_97_8 and arg_94_1.time_ < var_97_3 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play116071024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116071024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play116071025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.6

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(116071024).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 24 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 24)

				if (24 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 24)) > 0 and var_101_0 < var_101_3 then
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
	Play116071025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116071025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play116071026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos10025ui_story = arg_102_1.actors_["10025ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["10025ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10025ui_story, Vector3.New(0, -1.1, -5.9), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).z)
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles = arg_102_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["10025ui_story"].transform.localPosition = Vector3.New(0, -1.1, -5.9)
				arg_102_1.actors_["10025ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["10025ui_story"].transform.position).z)
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["10025ui_story"].transform.localEulerAngles = arg_102_1.actors_["10025ui_story"].transform.localEulerAngles
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_105_1 = arg_102_1.actors_["10025ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect10025ui_story == nil then
				arg_102_1.var_.characterEffect10025ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect10025ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_2)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect10025ui_story then
				arg_102_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_105_3 = 0
			local var_105_4 = 0.175

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_5 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(116071025).content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 7 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_5) / 7)

				if (7 <= 0 and var_105_4 or var_105_4 * (utf8.len(var_105_5) / 7)) > 0 and var_105_4 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_3 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_3
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_8 = math.max(var_105_4, arg_102_1.talkMaxDuration)

			if var_105_3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_3 + var_105_8 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_3) / var_105_8

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_3 + var_105_8 and arg_102_1.time_ < var_105_3 + var_105_8 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play116071026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116071026
		arg_106_1.duration_ = 3.7

		local var_106_0 = {
			zh = 3.7,
			ja = 2.766
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
				arg_106_0:Play116071027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10025ui_story"]) and arg_106_1.var_.characterEffect10025ui_story == nil then
				arg_106_1.var_.characterEffect10025ui_story = arg_106_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10025ui_story"]) then
				if arg_106_1.var_.characterEffect10025ui_story and not isNil(arg_106_1.actors_["10025ui_story"]) then
					arg_106_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10025ui_story"]) and arg_106_1.var_.characterEffect10025ui_story then
				arg_106_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_109_2 = 0
			local var_109_3 = 0.2

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(116071026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 8 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 8)

				if (8 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 8)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071026", "story_v_out_116071.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071026", "story_v_out_116071.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_116071", "116071026", "story_v_out_116071.awb")

						arg_106_1:RecordAudio("116071026", var_109_9)
						arg_106_1:RecordAudio("116071026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_116071", "116071026", "story_v_out_116071.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_116071", "116071026", "story_v_out_116071.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_3, arg_106_1.talkMaxDuration)

			if var_109_2 <= arg_106_1.time_ and arg_106_1.time_ < var_109_2 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_2) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_2 + var_109_10 and arg_106_1.time_ < var_109_2 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play116071027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116071027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play116071028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["10025ui_story"]) and arg_110_1.var_.characterEffect10025ui_story == nil then
				arg_110_1.var_.characterEffect10025ui_story = arg_110_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["10025ui_story"]) then
				if arg_110_1.var_.characterEffect10025ui_story and not isNil(arg_110_1.actors_["10025ui_story"]) then
					arg_110_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["10025ui_story"]) and arg_110_1.var_.characterEffect10025ui_story then
				arg_110_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 0.475

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(116071027).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 19 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 19)

				if (19 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 19)) > 0 and var_113_2 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_6 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_6 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_6

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_6 and arg_110_1.time_ < var_113_1 + var_113_6 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play116071028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116071028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116071029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["10025ui_story"]) and arg_114_1.var_.characterEffect10025ui_story == nil then
				arg_114_1.var_.characterEffect10025ui_story = arg_114_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["10025ui_story"]) then
				if arg_114_1.var_.characterEffect10025ui_story and not isNil(arg_114_1.actors_["10025ui_story"]) then
					arg_114_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["10025ui_story"]) and arg_114_1.var_.characterEffect10025ui_story then
				arg_114_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action438")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_117_2 = 0
			local var_117_3 = 0.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(116071028).content)

				arg_114_1.text_.text = var_117_4

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_6 = 13 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_4) / 13)

				if (13 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_4) / 13)) > 0 and var_117_3 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_4
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_7 and arg_114_1.time_ < var_117_2 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play116071029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116071029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play116071030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["10025ui_story"]) and arg_118_1.var_.characterEffect10025ui_story == nil then
				arg_118_1.var_.characterEffect10025ui_story = arg_118_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["10025ui_story"]) then
				if arg_118_1.var_.characterEffect10025ui_story and not isNil(arg_118_1.actors_["10025ui_story"]) then
					arg_118_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["10025ui_story"]) and arg_118_1.var_.characterEffect10025ui_story then
				arg_118_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_121_1 = 0
			local var_121_2 = 0.475

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(116071029).content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 19 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 19)

				if (19 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 19)) > 0 and var_121_2 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_6 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_6 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_6

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_6 and arg_118_1.time_ < var_121_1 + var_121_6 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play116071030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116071030
		arg_122_1.duration_ = 7.1

		local var_122_0 = {
			zh = 4.1,
			ja = 7.1
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
				arg_122_0:Play116071031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["10025ui_story"]) and arg_122_1.var_.characterEffect10025ui_story == nil then
				arg_122_1.var_.characterEffect10025ui_story = arg_122_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["10025ui_story"]) then
				if arg_122_1.var_.characterEffect10025ui_story and not isNil(arg_122_1.actors_["10025ui_story"]) then
					arg_122_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["10025ui_story"]) and arg_122_1.var_.characterEffect10025ui_story then
				arg_122_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action485")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_125_2 = 0
			local var_125_3 = 0.275

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_4 = arg_122_1:GetWordFromCfg(116071030)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 11 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 11)

				if (11 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 11)) > 0 and var_125_3 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116071", "116071030", "story_v_out_116071.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071030", "story_v_out_116071.awb") / 1000

					if var_125_8 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_2
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_out_116071", "116071030", "story_v_out_116071.awb")

						arg_122_1:RecordAudio("116071030", var_125_9)
						arg_122_1:RecordAudio("116071030", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_116071", "116071030", "story_v_out_116071.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_116071", "116071030", "story_v_out_116071.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_10 and arg_122_1.time_ < var_125_2 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play116071031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116071031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play116071032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["10025ui_story"]) and arg_126_1.var_.characterEffect10025ui_story == nil then
				arg_126_1.var_.characterEffect10025ui_story = arg_126_1.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["10025ui_story"]) then
				if arg_126_1.var_.characterEffect10025ui_story and not isNil(arg_126_1.actors_["10025ui_story"]) then
					arg_126_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["10025ui_story"]) and arg_126_1.var_.characterEffect10025ui_story then
				arg_126_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			local var_129_1 = 0
			local var_129_2 = 1

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(116071031).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 40 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 40)

				if (40 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 40)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play116071032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 116071032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play116071033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.725

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(116071032).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 29 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 29)

				if (29 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 29)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play116071033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 116071033
		arg_134_1.duration_ = 8

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play116071034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if arg_134_1.bgs_.SK0110 == nil then
				local var_137_0 = Object.Instantiate(arg_134_1.paintGo_)

				var_137_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0110")
				var_137_0.name = "SK0110"
				var_137_0.transform.parent = arg_134_1.stage_.transform
				var_137_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.bgs_.SK0110 = var_137_0
			end

			if 2 < arg_134_1.time_ and arg_134_1.time_ <= 2 + arg_137_0 then
				local var_137_1 = arg_134_1.bgs_.SK0110

				arg_134_1.bgs_.SK0110.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_137_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_137_2 = var_137_1:GetComponent("SpriteRenderer")

				if var_137_2 and var_137_2.sprite then
					local var_137_3 = 2 * (var_137_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_137_1.transform.localScale = Vector3.New(var_137_3 / var_137_2.sprite.bounds.size.y < var_137_3 * manager.ui.mainCameraCom_.aspect / var_137_2.sprite.bounds.size.x and var_137_3 * manager.ui.mainCameraCom_.aspect / var_137_2.sprite.bounds.size.x or var_137_3 / var_137_2.sprite.bounds.size.y, var_137_3 / var_137_2.sprite.bounds.size.y < var_137_3 * manager.ui.mainCameraCom_.aspect / var_137_2.sprite.bounds.size.x and var_137_3 * manager.ui.mainCameraCom_.aspect / var_137_2.sprite.bounds.size.x or var_137_3 / var_137_2.sprite.bounds.size.y, 0)
				end

				for iter_137_0, iter_137_1 in pairs(arg_134_1.bgs_) do
					if iter_137_0 ~= "SK0110" then
						iter_137_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_137_4 = 0

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = true

				arg_134_1:SetGaussion(false)
			end

			local var_137_5 = 2

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_5 then
				local var_137_6 = Color.New(0, 0, 0)

				var_137_6.a = Mathf.Lerp(0, 1, (arg_134_1.time_ - var_137_4) / var_137_5)
				arg_134_1.mask_.color = var_137_6
			end

			if arg_134_1.time_ >= var_137_4 + var_137_5 and arg_134_1.time_ < var_137_4 + var_137_5 + arg_137_0 then
				local var_137_7 = Color.New(0, 0, 0)

				var_137_7.a = 1
				arg_134_1.mask_.color = var_137_7
			end

			local var_137_8 = 2

			if 2 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = true

				arg_134_1:SetGaussion(false)
			end

			local var_137_9 = 2

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_9 then
				local var_137_10 = Color.New(0, 0, 0)

				var_137_10.a = Mathf.Lerp(1, 0, (arg_134_1.time_ - var_137_8) / var_137_9)
				arg_134_1.mask_.color = var_137_10
			end

			if arg_134_1.time_ >= var_137_8 + var_137_9 and arg_134_1.time_ < var_137_8 + var_137_9 + arg_137_0 then
				local var_137_11 = Color.New(0, 0, 0)

				arg_134_1.mask_.enabled = false
				var_137_11.a = 0
				arg_134_1.mask_.color = var_137_11
			end

			local var_137_12 = arg_134_1.actors_["10025ui_story"].transform

			if 1.966 < arg_134_1.time_ and arg_134_1.time_ <= 1.966 + arg_137_0 then
				arg_134_1.var_.moveOldPos10025ui_story = var_137_12.localPosition
			end

			local var_137_13 = 0.001

			if 1.966 <= arg_134_1.time_ and arg_134_1.time_ < 1.966 + var_137_13 then
				var_137_12.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 1.966) / var_137_13)
				var_137_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_12.position).x, (manager.ui.mainCamera.transform.position - var_137_12.position).y, (manager.ui.mainCamera.transform.position - var_137_12.position).z)
				var_137_12.localEulerAngles.z = 0
				var_137_12.localEulerAngles.x = 0
				var_137_12.localEulerAngles = var_137_12.localEulerAngles
			end

			if arg_134_1.time_ >= 1.966 + var_137_13 and arg_134_1.time_ < 1.966 + var_137_13 + arg_137_0 then
				var_137_12.localPosition = Vector3.New(0, 100, 0)
				var_137_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_12.position).x, (manager.ui.mainCamera.transform.position - var_137_12.position).y, (manager.ui.mainCamera.transform.position - var_137_12.position).z)
				var_137_12.localEulerAngles.z = 0
				var_137_12.localEulerAngles.x = 0
				var_137_12.localEulerAngles = var_137_12.localEulerAngles
			end

			local var_137_14 = arg_134_1.bgs_.SK0110.transform

			if 2 < arg_134_1.time_ and arg_134_1.time_ <= 2 + arg_137_0 then
				arg_134_1.var_.moveOldPosSK0110 = var_137_14.localPosition
			end

			local var_137_15 = 0.001

			if 2 <= arg_134_1.time_ and arg_134_1.time_ < 2 + var_137_15 then
				var_137_14.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPosSK0110, Vector3.New(0, 5, 5), (arg_134_1.time_ - 2) / var_137_15)
			end

			if arg_134_1.time_ >= 2 + var_137_15 and arg_134_1.time_ < 2 + var_137_15 + arg_137_0 then
				var_137_14.localPosition = Vector3.New(0, 5, 5)
			end

			local var_137_16 = arg_134_1.bgs_.SK0110.transform

			if 2.034 < arg_134_1.time_ and arg_134_1.time_ <= 2.034 + arg_137_0 then
				arg_134_1.var_.moveOldPosSK0110 = var_137_16.localPosition
			end

			local var_137_17 = 5

			if 2.034 <= arg_134_1.time_ and arg_134_1.time_ < 2.034 + var_137_17 then
				var_137_16.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPosSK0110, Vector3.New(0, 4.5, 5), (arg_134_1.time_ - 2.034) / var_137_17)
			end

			if arg_134_1.time_ >= 2.034 + var_137_17 and arg_134_1.time_ < 2.034 + var_137_17 + arg_137_0 then
				var_137_16.localPosition = Vector3.New(0, 4.5, 5)
			end

			local var_137_18 = 4

			if 4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_18 + arg_137_0 then
				arg_134_1.allBtn_.enabled = false
			end

			if arg_134_1.time_ >= var_137_18 + 3.034 and arg_134_1.time_ < var_137_18 + 3.034 + arg_137_0 then
				arg_134_1.allBtn_.enabled = true
			end

			if 2.034 < arg_134_1.time_ and arg_134_1.time_ <= 2.034 + arg_137_0 then
				arg_134_1.fswbg_:SetActive(true)
				arg_134_1.dialog_:SetActive(false)

				arg_134_1.fswtw_.percent = 0
				arg_134_1.fswt_.text = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(116071033).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.fswt_)

				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_134_1.fswtw_:SetDirty()

				arg_134_1.typewritterCharCountI18N = 0

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_19 = 4

			if 4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_19 + arg_137_0 then
				arg_134_1.var_.oldValueTypewriter = arg_134_1.fswtw_.percent

				SetActive(arg_134_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_134_1:ShowNextGo(false)
			end

			local var_137_20 = 24
			local var_137_21 = 4
			local var_137_22, var_137_23 = arg_134_1:GetPercentByPara(arg_134_1:FormatText(arg_134_1:GetWordFromCfg(116071033).content), 1)

			if var_137_19 < arg_134_1.time_ and arg_134_1.time_ <= var_137_19 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0

				local var_137_24 = var_137_20 <= 0 and var_137_21 or var_137_21 * ((var_137_23 - arg_134_1.typewritterCharCountI18N) / var_137_20)

				if (var_137_20 <= 0 and var_137_21 or var_137_21 * ((var_137_23 - arg_134_1.typewritterCharCountI18N) / var_137_20)) > 0 and var_137_21 < var_137_24 then
					arg_134_1.talkMaxDuration = var_137_24

					if var_137_24 + var_137_19 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_24 + var_137_19
					end
				end
			end

			local var_137_25 = math.max(4, arg_134_1.talkMaxDuration)

			if var_137_19 <= arg_134_1.time_ and arg_134_1.time_ < var_137_19 + var_137_25 then
				arg_134_1.fswtw_.percent = Mathf.Lerp(arg_134_1.var_.oldValueTypewriter, var_137_22, (arg_134_1.time_ - var_137_19) / var_137_25)
				arg_134_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_134_1.fswtw_:SetDirty()
			end

			if arg_134_1.time_ >= var_137_19 + var_137_25 and arg_134_1.time_ < var_137_19 + var_137_25 + arg_137_0 then
				arg_134_1.fswtw_.percent = var_137_22

				arg_134_1.fswtw_:SetDirty()
				arg_134_1:ShowNextGo(true)

				arg_134_1.typewritterCharCountI18N = var_137_23
			end

			if 4 < arg_134_1.time_ and arg_134_1.time_ <= 4 + arg_137_0 then
				local var_137_26 = arg_134_1.fswbg_.transform:Find("textbox/adapt/content") or arg_134_1.fswbg_.transform:Find("textbox/content")
				local var_137_27 = arg_134_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_137_28 = var_137_26:GetComponent("RectTransform")

				var_137_26:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_137_28.offsetMin = Vector2.New(150, 250)
				var_137_28.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_137_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_134_1.bgmTxt_.text ~= var_137_31 and arg_134_1.bgmTxt_.text ~= "" then
						if arg_134_1.bgmTxt2_.text ~= "" then
							arg_134_1.bgmTxt_.text = arg_134_1.bgmTxt2_.text
						end

						arg_134_1.bgmTxt2_.text = var_137_31

						arg_134_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_134_1.bgmTxt_.text = var_137_31
						arg_134_1.bgmTxt2_.text = var_137_31
					end

					if arg_134_1.bgmTimer then
						arg_134_1.bgmTimer:Stop()

						arg_134_1.bgmTimer = nil
					end

					if arg_134_1.settingData.show_music_name == 1 then
						arg_134_1.musicController:SetSelectedState("show")
						arg_134_1.musicAnimator_:Play("open", 0, 0)

						if arg_134_1.settingData.music_time ~= 0 then
							arg_134_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_134_1.settingData.music_time), function()
								if arg_134_1 == nil or isNil(arg_134_1.bgmTxt_) then
									return
								end

								arg_134_1.musicController:SetSelectedState("hide")
								arg_134_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_134_1.time_ and arg_134_1.time_ <= 2 + arg_137_0 then
				arg_134_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				if "" ~= "" then
					if arg_134_1.bgmTxt_.text ~= "" and arg_134_1.bgmTxt_.text ~= "" then
						if arg_134_1.bgmTxt2_.text ~= "" then
							arg_134_1.bgmTxt_.text = arg_134_1.bgmTxt2_.text
						end

						arg_134_1.bgmTxt2_.text = ""

						arg_134_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_134_1.bgmTxt_.text = ""
						arg_134_1.bgmTxt2_.text = ""
					end

					if arg_134_1.bgmTimer then
						arg_134_1.bgmTimer:Stop()

						arg_134_1.bgmTimer = nil
					end

					if arg_134_1.settingData.show_music_name == 1 then
						arg_134_1.musicController:SetSelectedState("show")
						arg_134_1.musicAnimator_:Play("open", 0, 0)

						if arg_134_1.settingData.music_time ~= 0 then
							arg_134_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_134_1.settingData.music_time), function()
								if arg_134_1 == nil or isNil(arg_134_1.bgmTxt_) then
									return
								end

								arg_134_1.musicController:SetSelectedState("hide")
								arg_134_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.2 < arg_134_1.time_ and arg_134_1.time_ <= 2.2 + arg_137_0 then
				arg_134_1:AudioAction("play", "music", "bgm_activity_1_6_story_story", "story", "bgm_activity_1_6_story_story.awb")

				if MusicRecordCfg[97].musicName ~= "" then
					if arg_134_1.bgmTxt_.text ~= MusicRecordCfg[97].musicName and arg_134_1.bgmTxt_.text ~= "" then
						if arg_134_1.bgmTxt2_.text ~= "" then
							arg_134_1.bgmTxt_.text = arg_134_1.bgmTxt2_.text
						end

						arg_134_1.bgmTxt2_.text = MusicRecordCfg[97].musicName

						arg_134_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_134_1.bgmTxt_.text = MusicRecordCfg[97].musicName
						arg_134_1.bgmTxt2_.text = MusicRecordCfg[97].musicName
					end

					if arg_134_1.bgmTimer then
						arg_134_1.bgmTimer:Stop()

						arg_134_1.bgmTimer = nil
					end

					if arg_134_1.settingData.show_music_name == 1 then
						arg_134_1.musicController:SetSelectedState("show")
						arg_134_1.musicAnimator_:Play("open", 0, 0)

						if arg_134_1.settingData.music_time ~= 0 then
							arg_134_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_134_1.settingData.music_time), function()
								if arg_134_1 == nil or isNil(arg_134_1.bgmTxt_) then
									return
								end

								arg_134_1.musicController:SetSelectedState("hide")
								arg_134_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "SK0110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play116071034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 116071034
		arg_141_1.duration_ = 5.37

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play116071035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.oldValueTypewriter = arg_141_1.fswtw_.percent

				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_141_1:ShowNextGo(false)
			end

			local var_144_0 = 43
			local var_144_1 = 5.375
			local var_144_2, var_144_3 = arg_141_1:GetPercentByPara(arg_141_1:FormatText(arg_141_1:GetWordFromCfg(116071033).content), 2)

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				local var_144_4 = var_144_0 <= 0 and var_144_1 or var_144_1 * ((var_144_3 - arg_141_1.typewritterCharCountI18N) / var_144_0)

				if (var_144_0 <= 0 and var_144_1 or var_144_1 * ((var_144_3 - arg_141_1.typewritterCharCountI18N) / var_144_0)) > 0 and var_144_1 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end
			end

			local var_144_5 = math.max(5.375, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_5 then
				arg_141_1.fswtw_.percent = Mathf.Lerp(arg_141_1.var_.oldValueTypewriter, var_144_2, (arg_141_1.time_ - 0) / var_144_5)
				arg_141_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_141_1.fswtw_:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_5 and arg_141_1.time_ < 0 + var_144_5 + arg_144_0 then
				arg_141_1.fswtw_.percent = var_144_2

				arg_141_1.fswtw_:SetDirty()
				arg_141_1:ShowNextGo(true)

				arg_141_1.typewritterCharCountI18N = var_144_3
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play116071035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 116071035
		arg_145_1.duration_ = 3.5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play116071036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.oldValueTypewriter = arg_145_1.fswtw_.percent

				SetActive(arg_145_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_145_1:ShowNextGo(false)
			end

			local var_148_0 = 21
			local var_148_1 = 3.5
			local var_148_2, var_148_3 = arg_145_1:GetPercentByPara(arg_145_1:FormatText(arg_145_1:GetWordFromCfg(116071033).content), 3)

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				local var_148_4 = var_148_0 <= 0 and var_148_1 or var_148_1 * ((var_148_3 - arg_145_1.typewritterCharCountI18N) / var_148_0)

				if (var_148_0 <= 0 and var_148_1 or var_148_1 * ((var_148_3 - arg_145_1.typewritterCharCountI18N) / var_148_0)) > 0 and var_148_1 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end
			end

			local var_148_5 = math.max(3.5, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 then
				arg_145_1.fswtw_.percent = Mathf.Lerp(arg_145_1.var_.oldValueTypewriter, var_148_2, (arg_145_1.time_ - 0) / var_148_5)
				arg_145_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_145_1.fswtw_:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 then
				arg_145_1.fswtw_.percent = var_148_2

				arg_145_1.fswtw_:SetDirty()
				arg_145_1:ShowNextGo(true)

				arg_145_1.typewritterCharCountI18N = var_148_3
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play116071036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 116071036
		arg_149_1.duration_ = 1.3

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play116071037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.fswbg_:SetActive(true)
				arg_149_1.dialog_:SetActive(false)

				arg_149_1.fswtw_.percent = 0
				arg_149_1.fswt_.text = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(116071036).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.fswt_)

				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_149_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_149_1.fswtw_:SetDirty()

				arg_149_1.typewritterCharCountI18N = 0

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.var_.oldValueTypewriter = arg_149_1.fswtw_.percent

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_1 = 5
			local var_152_2 = 0.833333333333333
			local var_152_3, var_152_4 = arg_149_1:GetPercentByPara(arg_149_1:FormatText(arg_149_1:GetWordFromCfg(116071036).content), 1)

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				local var_152_5 = var_152_1 <= 0 and var_152_2 or var_152_2 * ((var_152_4 - arg_149_1.typewritterCharCountI18N) / var_152_1)

				if (var_152_1 <= 0 and var_152_2 or var_152_2 * ((var_152_4 - arg_149_1.typewritterCharCountI18N) / var_152_1)) > 0 and var_152_2 < var_152_5 then
					arg_149_1.talkMaxDuration = var_152_5

					if var_152_5 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + var_152_0
					end
				end
			end

			local var_152_6 = math.max(0.833333333333333, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_6 then
				arg_149_1.fswtw_.percent = Mathf.Lerp(arg_149_1.var_.oldValueTypewriter, var_152_3, (arg_149_1.time_ - var_152_0) / var_152_6)
				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_149_1.fswtw_:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_6 and arg_149_1.time_ < var_152_0 + var_152_6 + arg_152_0 then
				arg_149_1.fswtw_.percent = var_152_3

				arg_149_1.fswtw_:SetDirty()
				arg_149_1:ShowNextGo(true)

				arg_149_1.typewritterCharCountI18N = var_152_4
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				local var_152_7 = arg_149_1.fswbg_.transform:Find("textbox/adapt/content") or arg_149_1.fswbg_.transform:Find("textbox/content")
				local var_152_8 = arg_149_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_152_9 = var_152_7:GetComponent("RectTransform")

				var_152_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_152_9.offsetMin = Vector2.New(0, 0)
				var_152_9.offsetMax = Vector2.New(1000, -400)
			end

			local var_152_10 = 0
			local var_152_11 = manager.audio:GetVoiceLength("story_v_out_116071", "116071036", "story_v_out_116071.awb") / 1000

			if var_152_11 > 0 and 1.302 < var_152_11 and var_152_11 + var_152_10 > arg_149_1.duration_ then
				arg_149_1.duration_ = var_152_11 + var_152_10
			end

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1:AudioAction("play", "voice", "story_v_out_116071", "116071036", "story_v_out_116071.awb")
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play116071037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 116071037
		arg_153_1.duration_ = 9.2

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play116071038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.fswbg_:SetActive(true)
				arg_153_1.dialog_:SetActive(false)

				arg_153_1.fswtw_.percent = 0
				arg_153_1.fswt_.text = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(116071037).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.fswt_)

				arg_153_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_153_1.fswtw_:SetDirty()

				arg_153_1.typewritterCharCountI18N = 0

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_0 = 0.0333333333333332

			if 0.0333333333333332 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_1 = 55
			local var_156_2 = 9.16666666666667
			local var_156_3, var_156_4 = arg_153_1:GetPercentByPara(arg_153_1:FormatText(arg_153_1:GetWordFromCfg(116071037).content), 2)

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_5 = var_156_1 <= 0 and var_156_2 or var_156_2 * ((var_156_4 - arg_153_1.typewritterCharCountI18N) / var_156_1)

				if (var_156_1 <= 0 and var_156_2 or var_156_2 * ((var_156_4 - arg_153_1.typewritterCharCountI18N) / var_156_1)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_0
					end
				end
			end

			local var_156_6 = math.max(9.16666666666667, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_6 then
				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_3, (arg_153_1.time_ - var_156_0) / var_156_6)
				arg_153_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_6 and arg_153_1.time_ < var_156_0 + var_156_6 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_3

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_4
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				local var_156_7 = arg_153_1.fswbg_.transform:Find("textbox/adapt/content") or arg_153_1.fswbg_.transform:Find("textbox/content")
				local var_156_8 = arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_156_9 = var_156_7:GetComponent("RectTransform")

				var_156_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_156_9.offsetMin = Vector2.New(150, 250)
				var_156_9.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play116071038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 116071038
		arg_157_1.duration_ = 6.67

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play116071039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.oldValueTypewriter = arg_157_1.fswtw_.percent

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_0 = 40
			local var_160_1 = 6.66666666666667
			local var_160_2, var_160_3 = arg_157_1:GetPercentByPara(arg_157_1:FormatText(arg_157_1:GetWordFromCfg(116071037).content), 3)

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				local var_160_4 = var_160_0 <= 0 and var_160_1 or var_160_1 * ((var_160_3 - arg_157_1.typewritterCharCountI18N) / var_160_0)

				if (var_160_0 <= 0 and var_160_1 or var_160_1 * ((var_160_3 - arg_157_1.typewritterCharCountI18N) / var_160_0)) > 0 and var_160_1 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end
			end

			local var_160_5 = math.max(6.66666666666667, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 then
				arg_157_1.fswtw_.percent = Mathf.Lerp(arg_157_1.var_.oldValueTypewriter, var_160_2, (arg_157_1.time_ - 0) / var_160_5)
				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_157_1.fswtw_:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 then
				arg_157_1.fswtw_.percent = var_160_2

				arg_157_1.fswtw_:SetDirty()
				arg_157_1:ShowNextGo(true)

				arg_157_1.typewritterCharCountI18N = var_160_3
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play116071039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 116071039
		arg_161_1.duration_ = 5.7

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play116071040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.fswbg_:SetActive(true)
				arg_161_1.dialog_:SetActive(false)

				arg_161_1.fswtw_.percent = 0
				arg_161_1.fswt_.text = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(116071039).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.fswt_)

				arg_161_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_161_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_161_1.fswtw_:SetDirty()

				arg_161_1.typewritterCharCountI18N = 0

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_0 = 0.0333333333333332

			if 0.0333333333333332 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.var_.oldValueTypewriter = arg_161_1.fswtw_.percent

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_1 = 34
			local var_164_2 = 5.66666666666667
			local var_164_3, var_164_4 = arg_161_1:GetPercentByPara(arg_161_1:FormatText(arg_161_1:GetWordFromCfg(116071039).content), 1)

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				local var_164_5 = var_164_1 <= 0 and var_164_2 or var_164_2 * ((var_164_4 - arg_161_1.typewritterCharCountI18N) / var_164_1)

				if (var_164_1 <= 0 and var_164_2 or var_164_2 * ((var_164_4 - arg_161_1.typewritterCharCountI18N) / var_164_1)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_0
					end
				end
			end

			local var_164_6 = math.max(5.66666666666667, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_6 then
				arg_161_1.fswtw_.percent = Mathf.Lerp(arg_161_1.var_.oldValueTypewriter, var_164_3, (arg_161_1.time_ - var_164_0) / var_164_6)
				arg_161_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_161_1.fswtw_:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_6 and arg_161_1.time_ < var_164_0 + var_164_6 + arg_164_0 then
				arg_161_1.fswtw_.percent = var_164_3

				arg_161_1.fswtw_:SetDirty()
				arg_161_1:ShowNextGo(true)

				arg_161_1.typewritterCharCountI18N = var_164_4
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play116071040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 116071040
		arg_165_1.duration_ = 4

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play116071041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_0 = 24
			local var_168_1 = 4
			local var_168_2, var_168_3 = arg_165_1:GetPercentByPara(arg_165_1:FormatText(arg_165_1:GetWordFromCfg(116071039).content), 2)

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				local var_168_4 = var_168_0 <= 0 and var_168_1 or var_168_1 * ((var_168_3 - arg_165_1.typewritterCharCountI18N) / var_168_0)

				if (var_168_0 <= 0 and var_168_1 or var_168_1 * ((var_168_3 - arg_165_1.typewritterCharCountI18N) / var_168_0)) > 0 and var_168_1 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end
			end

			local var_168_5 = math.max(4, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 then
				arg_165_1.fswtw_.percent = Mathf.Lerp(arg_165_1.var_.oldValueTypewriter, var_168_2, (arg_165_1.time_ - 0) / var_168_5)
				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_165_1.fswtw_:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 then
				arg_165_1.fswtw_.percent = var_168_2

				arg_165_1.fswtw_:SetDirty()
				arg_165_1:ShowNextGo(true)

				arg_165_1.typewritterCharCountI18N = var_168_3
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play116071041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 116071041
		arg_169_1.duration_ = 4.67

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play116071042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.oldValueTypewriter = arg_169_1.fswtw_.percent

				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_0 = 28
			local var_172_1 = 4.66666666666667
			local var_172_2, var_172_3 = arg_169_1:GetPercentByPara(arg_169_1:FormatText(arg_169_1:GetWordFromCfg(116071039).content), 3)

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				local var_172_4 = var_172_0 <= 0 and var_172_1 or var_172_1 * ((var_172_3 - arg_169_1.typewritterCharCountI18N) / var_172_0)

				if (var_172_0 <= 0 and var_172_1 or var_172_1 * ((var_172_3 - arg_169_1.typewritterCharCountI18N) / var_172_0)) > 0 and var_172_1 < var_172_4 then
					arg_169_1.talkMaxDuration = var_172_4

					if var_172_4 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_4 + 0
					end
				end
			end

			local var_172_5 = math.max(4.66666666666667, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 then
				arg_169_1.fswtw_.percent = Mathf.Lerp(arg_169_1.var_.oldValueTypewriter, var_172_2, (arg_169_1.time_ - 0) / var_172_5)
				arg_169_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_169_1.fswtw_:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 then
				arg_169_1.fswtw_.percent = var_172_2

				arg_169_1.fswtw_:SetDirty()
				arg_169_1:ShowNextGo(true)

				arg_169_1.typewritterCharCountI18N = var_172_3
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play116071042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 116071042
		arg_173_1.duration_ = 7

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play116071043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPosSK0110 = arg_173_1.bgs_.SK0110.transform.localPosition
			end

			local var_176_0 = 5

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.bgs_.SK0110.transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPosSK0110, Vector3.New(0, 4, 5), (arg_173_1.time_ - 0) / var_176_0)
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.bgs_.SK0110.transform.localPosition = Vector3.New(0, 4, 5)
			end

			local var_176_1 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			if arg_173_1.time_ >= var_176_1 + 5 and arg_173_1.time_ < var_176_1 + 5 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end

			local var_176_2 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.var_.oldValueTypewriter = arg_173_1.fswtw_.percent

				SetActive(arg_173_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_173_1:ShowNextGo(false)
			end

			local var_176_3 = 42
			local var_176_4 = 7
			local var_176_5, var_176_6 = arg_173_1:GetPercentByPara(arg_173_1:FormatText(arg_173_1:GetWordFromCfg(116071039).content), 4)

			if var_176_2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				local var_176_7 = var_176_3 <= 0 and var_176_4 or var_176_4 * ((var_176_6 - arg_173_1.typewritterCharCountI18N) / var_176_3)

				if (var_176_3 <= 0 and var_176_4 or var_176_4 * ((var_176_6 - arg_173_1.typewritterCharCountI18N) / var_176_3)) > 0 and var_176_4 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_2
					end
				end
			end

			local var_176_8 = math.max(7, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_8 then
				arg_173_1.fswtw_.percent = Mathf.Lerp(arg_173_1.var_.oldValueTypewriter, var_176_5, (arg_173_1.time_ - var_176_2) / var_176_8)
				arg_173_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_173_1.fswtw_:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_8 and arg_173_1.time_ < var_176_2 + var_176_8 + arg_176_0 then
				arg_173_1.fswtw_.percent = var_176_5

				arg_173_1.fswtw_:SetDirty()
				arg_173_1:ShowNextGo(true)

				arg_173_1.typewritterCharCountI18N = var_176_6
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play116071043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 116071043
		arg_177_1.duration_ = 5.19

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play116071044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(true)
				arg_177_1.dialog_:SetActive(false)

				arg_177_1.fswtw_.percent = 0
				arg_177_1.fswt_.text = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(116071043).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.fswt_)

				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_177_1.fswtw_:SetDirty()

				arg_177_1.typewritterCharCountI18N = 0

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.var_.oldValueTypewriter = arg_177_1.fswtw_.percent

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_1 = 13
			local var_180_2 = 2.16666666666667
			local var_180_3, var_180_4 = arg_177_1:GetPercentByPara(arg_177_1:FormatText(arg_177_1:GetWordFromCfg(116071043).content), 1)

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				local var_180_5 = var_180_1 <= 0 and var_180_2 or var_180_2 * ((var_180_4 - arg_177_1.typewritterCharCountI18N) / var_180_1)

				if (var_180_1 <= 0 and var_180_2 or var_180_2 * ((var_180_4 - arg_177_1.typewritterCharCountI18N) / var_180_1)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_0
					end
				end
			end

			local var_180_6 = math.max(2.16666666666667, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_6 then
				arg_177_1.fswtw_.percent = Mathf.Lerp(arg_177_1.var_.oldValueTypewriter, var_180_3, (arg_177_1.time_ - var_180_0) / var_180_6)
				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.fswtw_:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_6 and arg_177_1.time_ < var_180_0 + var_180_6 + arg_180_0 then
				arg_177_1.fswtw_.percent = var_180_3

				arg_177_1.fswtw_:SetDirty()
				arg_177_1:ShowNextGo(true)

				arg_177_1.typewritterCharCountI18N = var_180_4
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				local var_180_7 = arg_177_1.fswbg_.transform:Find("textbox/adapt/content") or arg_177_1.fswbg_.transform:Find("textbox/content")
				local var_180_8 = arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_180_9 = var_180_7:GetComponent("RectTransform")

				var_180_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_180_9.offsetMin = Vector2.New(0, 0)
				var_180_9.offsetMax = Vector2.New(1000, -400)
			end

			local var_180_10 = 0
			local var_180_11 = manager.audio:GetVoiceLength("story_v_out_116071", "116071043", "story_v_out_116071.awb") / 1000

			if var_180_11 > 0 and 5.192 < var_180_11 and var_180_11 + var_180_10 > arg_177_1.duration_ then
				arg_177_1.duration_ = var_180_11 + var_180_10
			end

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1:AudioAction("play", "voice", "story_v_out_116071", "116071043", "story_v_out_116071.awb")
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play116071044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 116071044
		arg_181_1.duration_ = 1.7

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play116071045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(true)
				arg_181_1.dialog_:SetActive(false)

				arg_181_1.fswtw_.percent = 0
				arg_181_1.fswt_.text = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(116071044).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.fswt_)

				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_181_1.fswtw_:SetDirty()

				arg_181_1.typewritterCharCountI18N = 0

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_0 = 0.0333333333333332

			if 0.0333333333333332 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.var_.oldValueTypewriter = arg_181_1.fswtw_.percent

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_1 = 10
			local var_184_2 = 1.66666666666667
			local var_184_3, var_184_4 = arg_181_1:GetPercentByPara(arg_181_1:FormatText(arg_181_1:GetWordFromCfg(116071044).content), 1)

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				local var_184_5 = var_184_1 <= 0 and var_184_2 or var_184_2 * ((var_184_4 - arg_181_1.typewritterCharCountI18N) / var_184_1)

				if (var_184_1 <= 0 and var_184_2 or var_184_2 * ((var_184_4 - arg_181_1.typewritterCharCountI18N) / var_184_1)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_0
					end
				end
			end

			local var_184_6 = math.max(1.66666666666667, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_6 then
				arg_181_1.fswtw_.percent = Mathf.Lerp(arg_181_1.var_.oldValueTypewriter, var_184_3, (arg_181_1.time_ - var_184_0) / var_184_6)
				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_181_1.fswtw_:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_6 and arg_181_1.time_ < var_184_0 + var_184_6 + arg_184_0 then
				arg_181_1.fswtw_.percent = var_184_3

				arg_181_1.fswtw_:SetDirty()
				arg_181_1:ShowNextGo(true)

				arg_181_1.typewritterCharCountI18N = var_184_4
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				local var_184_7 = arg_181_1.fswbg_.transform:Find("textbox/adapt/content") or arg_181_1.fswbg_.transform:Find("textbox/content")
				local var_184_8 = arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_184_9 = var_184_7:GetComponent("RectTransform")

				var_184_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
				var_184_9.offsetMin = Vector2.New(150, 250)
				var_184_9.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play116071045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 116071045
		arg_185_1.duration_ = 9.5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play116071046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPosSK0110 = arg_185_1.bgs_.SK0110.transform.localPosition
			end

			local var_188_0 = 8

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.bgs_.SK0110.transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPosSK0110, Vector3.New(0, 2, 5), (arg_185_1.time_ - 0) / var_188_0)
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.bgs_.SK0110.transform.localPosition = Vector3.New(0, 2, 5)
			end

			local var_188_1 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			if arg_185_1.time_ >= var_188_1 + 7.999999999999 and arg_185_1.time_ < var_188_1 + 7.999999999999 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_2 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.var_.oldValueTypewriter = arg_185_1.fswtw_.percent

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_3 = 57
			local var_188_4 = 9.5
			local var_188_5, var_188_6 = arg_185_1:GetPercentByPara(arg_185_1:FormatText(arg_185_1:GetWordFromCfg(116071044).content), 3)

			if var_188_2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				local var_188_7 = var_188_3 <= 0 and var_188_4 or var_188_4 * ((var_188_6 - arg_185_1.typewritterCharCountI18N) / var_188_3)

				if (var_188_3 <= 0 and var_188_4 or var_188_4 * ((var_188_6 - arg_185_1.typewritterCharCountI18N) / var_188_3)) > 0 and var_188_4 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end
			end

			local var_188_8 = math.max(9.5, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_8 then
				arg_185_1.fswtw_.percent = Mathf.Lerp(arg_185_1.var_.oldValueTypewriter, var_188_5, (arg_185_1.time_ - var_188_2) / var_188_8)
				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_185_1.fswtw_:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_8 and arg_185_1.time_ < var_188_2 + var_188_8 + arg_188_0 then
				arg_185_1.fswtw_.percent = var_188_5

				arg_185_1.fswtw_:SetDirty()
				arg_185_1:ShowNextGo(true)

				arg_185_1.typewritterCharCountI18N = var_188_6
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0110",
				changeDisplayLayer = false,
				needEase = false,
				duration = 8,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play116071046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 116071046
		arg_189_1.duration_ = 8.52

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play116071047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if arg_189_1.bgs_.SK0110b == nil then
				local var_192_0 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0110b")
				var_192_0.name = "SK0110b"
				var_192_0.transform.parent = arg_189_1.stage_.transform
				var_192_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_.SK0110b = var_192_0
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_1 = arg_189_1.bgs_.SK0110b

				arg_189_1.bgs_.SK0110b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_2 = var_192_1:GetComponent("SpriteRenderer")

				if var_192_2 and var_192_2.sprite then
					local var_192_3 = 2 * (var_192_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_1.transform.localScale = Vector3.New(var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "SK0110b" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_4 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_5 = 2

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_5 then
				local var_192_6 = Color.New(1, 1, 1)

				var_192_6.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_4) / var_192_5)
				arg_189_1.mask_.color = var_192_6
			end

			if arg_189_1.time_ >= var_192_4 + var_192_5 and arg_189_1.time_ < var_192_4 + var_192_5 + arg_192_0 then
				local var_192_7 = Color.New(1, 1, 1)

				arg_189_1.mask_.enabled = false
				var_192_7.a = 0
				arg_189_1.mask_.color = var_192_7
			end

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				arg_189_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder02", "")
			end

			local var_192_9 = arg_189_1.bgs_.SK0110b.transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPosSK0110b = var_192_9.localPosition
			end

			local var_192_10 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_10 then
				var_192_9.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPosSK0110b, Vector3.New(0, 2, 5), (arg_189_1.time_ - 0) / var_192_10)
			end

			if arg_189_1.time_ >= 0 + var_192_10 and arg_189_1.time_ < 0 + var_192_10 + arg_192_0 then
				var_192_9.localPosition = Vector3.New(0, 2, 5)
			end

			local var_192_11 = 2.025

			if 2.025 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1.var_.oldValueTypewriter = arg_189_1.fswtw_.percent

				SetActive(arg_189_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_189_1:ShowNextGo(false)
			end

			local var_192_12 = 39
			local var_192_13 = 6.5
			local var_192_14, var_192_15 = arg_189_1:GetPercentByPara(arg_189_1:FormatText(arg_189_1:GetWordFromCfg(116071044).content), 4)

			if var_192_11 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				local var_192_16 = var_192_12 <= 0 and var_192_13 or var_192_13 * ((var_192_15 - arg_189_1.typewritterCharCountI18N) / var_192_12)

				if (var_192_12 <= 0 and var_192_13 or var_192_13 * ((var_192_15 - arg_189_1.typewritterCharCountI18N) / var_192_12)) > 0 and var_192_13 < var_192_16 then
					arg_189_1.talkMaxDuration = var_192_16

					if var_192_16 + var_192_11 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_16 + var_192_11
					end
				end
			end

			local var_192_17 = math.max(6.5, arg_189_1.talkMaxDuration)

			if var_192_11 <= arg_189_1.time_ and arg_189_1.time_ < var_192_11 + var_192_17 then
				arg_189_1.fswtw_.percent = Mathf.Lerp(arg_189_1.var_.oldValueTypewriter, var_192_14, (arg_189_1.time_ - var_192_11) / var_192_17)
				arg_189_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_189_1.fswtw_:SetDirty()
			end

			if arg_189_1.time_ >= var_192_11 + var_192_17 and arg_189_1.time_ < var_192_11 + var_192_17 + arg_192_0 then
				arg_189_1.fswtw_.percent = var_192_14

				arg_189_1.fswtw_:SetDirty()
				arg_189_1:ShowNextGo(true)

				arg_189_1.typewritterCharCountI18N = var_192_15
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0110b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play116071047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 116071047
		arg_193_1.duration_ = 4.03

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play116071048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.fswbg_:SetActive(true)
				arg_193_1.dialog_:SetActive(false)

				arg_193_1.fswtw_.percent = 0
				arg_193_1.fswt_.text = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(116071047).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.fswt_)

				arg_193_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_193_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_193_1.fswtw_:SetDirty()

				arg_193_1.typewritterCharCountI18N = 0

				SetActive(arg_193_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_193_1:ShowNextGo(false)
			end

			local var_196_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.var_.oldValueTypewriter = arg_193_1.fswtw_.percent

				SetActive(arg_193_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_193_1:ShowNextGo(false)
			end

			local var_196_1 = 8
			local var_196_2 = 1.33333333333333
			local var_196_3, var_196_4 = arg_193_1:GetPercentByPara(arg_193_1:FormatText(arg_193_1:GetWordFromCfg(116071047).content), 1)

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				local var_196_5 = var_196_1 <= 0 and var_196_2 or var_196_2 * ((var_196_4 - arg_193_1.typewritterCharCountI18N) / var_196_1)

				if (var_196_1 <= 0 and var_196_2 or var_196_2 * ((var_196_4 - arg_193_1.typewritterCharCountI18N) / var_196_1)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_0
					end
				end
			end

			local var_196_6 = math.max(1.33333333333333, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_6 then
				arg_193_1.fswtw_.percent = Mathf.Lerp(arg_193_1.var_.oldValueTypewriter, var_196_3, (arg_193_1.time_ - var_196_0) / var_196_6)
				arg_193_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_193_1.fswtw_:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_6 and arg_193_1.time_ < var_196_0 + var_196_6 + arg_196_0 then
				arg_193_1.fswtw_.percent = var_196_3

				arg_193_1.fswtw_:SetDirty()
				arg_193_1:ShowNextGo(true)

				arg_193_1.typewritterCharCountI18N = var_196_4
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_7 = arg_193_1.fswbg_.transform:Find("textbox/adapt/content") or arg_193_1.fswbg_.transform:Find("textbox/content")
				local var_196_8 = arg_193_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_196_9 = var_196_7:GetComponent("RectTransform")

				var_196_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_196_9.offsetMin = Vector2.New(0, 0)
				var_196_9.offsetMax = Vector2.New(1000, -400)
			end

			local var_196_10 = 0
			local var_196_11 = manager.audio:GetVoiceLength("story_v_out_116071", "116071047", "story_v_out_116071.awb") / 1000

			if var_196_11 > 0 and 4.028 < var_196_11 and var_196_11 + var_196_10 > arg_193_1.duration_ then
				arg_193_1.duration_ = var_196_11 + var_196_10
			end

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1:AudioAction("play", "voice", "story_v_out_116071", "116071047", "story_v_out_116071.awb")
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play116071048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 116071048
		arg_197_1.duration_ = 5.56

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play116071049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.fswbg_:SetActive(true)
				arg_197_1.dialog_:SetActive(false)

				arg_197_1.fswtw_.percent = 0
				arg_197_1.fswt_.text = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(116071048).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.fswt_)

				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_197_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_197_1.fswtw_:SetDirty()

				arg_197_1.typewritterCharCountI18N = 0

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.var_.oldValueTypewriter = arg_197_1.fswtw_.percent

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_1 = 11
			local var_200_2 = 1.83333333333333
			local var_200_3, var_200_4 = arg_197_1:GetPercentByPara(arg_197_1:FormatText(arg_197_1:GetWordFromCfg(116071048).content), 1)

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				local var_200_5 = var_200_1 <= 0 and var_200_2 or var_200_2 * ((var_200_4 - arg_197_1.typewritterCharCountI18N) / var_200_1)

				if (var_200_1 <= 0 and var_200_2 or var_200_2 * ((var_200_4 - arg_197_1.typewritterCharCountI18N) / var_200_1)) > 0 and var_200_2 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_0
					end
				end
			end

			local var_200_6 = math.max(1.83333333333333, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_6 then
				arg_197_1.fswtw_.percent = Mathf.Lerp(arg_197_1.var_.oldValueTypewriter, var_200_3, (arg_197_1.time_ - var_200_0) / var_200_6)
				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_197_1.fswtw_:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_6 and arg_197_1.time_ < var_200_0 + var_200_6 + arg_200_0 then
				arg_197_1.fswtw_.percent = var_200_3

				arg_197_1.fswtw_:SetDirty()
				arg_197_1:ShowNextGo(true)

				arg_197_1.typewritterCharCountI18N = var_200_4
			end

			local var_200_7 = 0
			local var_200_8 = manager.audio:GetVoiceLength("story_v_out_116071", "116071048", "story_v_out_116071.awb") / 1000

			if var_200_8 > 0 and 5.556 < var_200_8 and var_200_8 + var_200_7 > arg_197_1.duration_ then
				arg_197_1.duration_ = var_200_8 + var_200_7
			end

			if var_200_7 < arg_197_1.time_ and arg_197_1.time_ <= var_200_7 + arg_200_0 then
				arg_197_1:AudioAction("play", "voice", "story_v_out_116071", "116071048", "story_v_out_116071.awb")
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play116071049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 116071049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play116071050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.fswbg_:SetActive(false)
				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_201_1:ShowNextGo(false)
			end

			local var_204_0 = 0
			local var_204_1 = 0.725

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				arg_201_1.dialog_:SetActive(true)

				arg_201_1.dialogCg_.alpha = 0

				local var_204_2 = LeanTween.value(arg_201_1.dialog_, 0, 1, 0.3)

				var_204_2:setOnUpdate(LuaHelper.FloatAction(function(arg_205_0)
					arg_201_1.dialogCg_.alpha = arg_205_0
				end))
				var_204_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_201_1.dialog_)
					var_204_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_201_1.duration_ = arg_201_1.duration_ + 0.3

				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_3 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(116071049).content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 29 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 29)

				if (29 <= 0 and var_204_1 or var_204_1 * (utf8.len(var_204_3) / 29)) > 0 and var_204_1 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5
					var_204_0 = var_204_0 + 0.3

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_6 = var_204_0 + 0.3
			local var_204_7 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 + 0.3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_7 and arg_201_1.time_ < var_204_6 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play116071050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 116071050
		arg_207_1.duration_ = 9

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play116071051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if arg_207_1.bgs_.ST01a == nil then
				local var_210_0 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01a")
				var_210_0.name = "ST01a"
				var_210_0.transform.parent = arg_207_1.stage_.transform
				var_210_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_.ST01a = var_210_0
			end

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= 2 + arg_210_0 then
				local var_210_1 = arg_207_1.bgs_.ST01a

				arg_207_1.bgs_.ST01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_2 = var_210_1:GetComponent("SpriteRenderer")

				if var_210_2 and var_210_2.sprite then
					local var_210_3 = 2 * (var_210_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_1.transform.localScale = Vector3.New(var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "ST01a" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_4 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_5 = 2

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_5 then
				local var_210_6 = Color.New(0, 0, 0)

				var_210_6.a = Mathf.Lerp(0, 1, (arg_207_1.time_ - var_210_4) / var_210_5)
				arg_207_1.mask_.color = var_210_6
			end

			if arg_207_1.time_ >= var_210_4 + var_210_5 and arg_207_1.time_ < var_210_4 + var_210_5 + arg_210_0 then
				local var_210_7 = Color.New(0, 0, 0)

				var_210_7.a = 1
				arg_207_1.mask_.color = var_210_7
			end

			local var_210_8 = 2

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_9 = 2

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 then
				local var_210_10 = Color.New(0, 0, 0)

				var_210_10.a = Mathf.Lerp(1, 0, (arg_207_1.time_ - var_210_8) / var_210_9)
				arg_207_1.mask_.color = var_210_10
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 then
				local var_210_11 = Color.New(0, 0, 0)

				arg_207_1.mask_.enabled = false
				var_210_11.a = 0
				arg_207_1.mask_.color = var_210_11
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_12 = 4
			local var_210_13 = 0.6

			if 4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_14 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_14:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_15 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(116071050).content)

				arg_207_1.text_.text = var_210_15

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_17 = 24 <= 0 and var_210_13 or var_210_13 * (utf8.len(var_210_15) / 24)

				if (24 <= 0 and var_210_13 or var_210_13 * (utf8.len(var_210_15) / 24)) > 0 and var_210_13 < var_210_17 then
					arg_207_1.talkMaxDuration = var_210_17
					var_210_12 = var_210_12 + 0.3

					if var_210_17 + var_210_12 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_17 + var_210_12
					end
				end

				arg_207_1.text_.text = var_210_15
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_18 = var_210_12 + 0.3
			local var_210_19 = math.max(var_210_13, arg_207_1.talkMaxDuration)

			if var_210_12 + 0.3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_18 + var_210_19 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_18) / var_210_19

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_18 + var_210_19 and arg_207_1.time_ < var_210_18 + var_210_19 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play116071051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 116071051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play116071052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.775

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

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(116071051).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 31 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 31)

				if (31 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 31)) > 0 and var_216_0 < var_216_3 then
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
	Play116071052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 116071052
		arg_217_1.duration_ = 5.07

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play116071053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 2 < arg_217_1.time_ and arg_217_1.time_ <= 2 + arg_220_0 then
				arg_217_1.fswbg_:SetActive(true)
				arg_217_1.dialog_:SetActive(false)

				arg_217_1.fswtw_.percent = 0
				arg_217_1.fswt_.text = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(116071052).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.fswt_)

				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_217_1.fswtw_:SetDirty()

				arg_217_1.typewritterCharCountI18N = 0

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_0 = 2.86666666666667

			if 2.86666666666667 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.var_.oldValueTypewriter = arg_217_1.fswtw_.percent

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_1 = 17
			local var_220_2 = 1.13333333333333
			local var_220_3, var_220_4 = arg_217_1:GetPercentByPara(arg_217_1:FormatText(arg_217_1:GetWordFromCfg(116071052).content), 1)

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				local var_220_5 = var_220_1 <= 0 and var_220_2 or var_220_2 * ((var_220_4 - arg_217_1.typewritterCharCountI18N) / var_220_1)

				if (var_220_1 <= 0 and var_220_2 or var_220_2 * ((var_220_4 - arg_217_1.typewritterCharCountI18N) / var_220_1)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end
			end

			local var_220_6 = math.max(1.13333333333333, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_6 then
				arg_217_1.fswtw_.percent = Mathf.Lerp(arg_217_1.var_.oldValueTypewriter, var_220_3, (arg_217_1.time_ - var_220_0) / var_220_6)
				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_217_1.fswtw_:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_6 and arg_217_1.time_ < var_220_0 + var_220_6 + arg_220_0 then
				arg_217_1.fswtw_.percent = var_220_3

				arg_217_1.fswtw_:SetDirty()
				arg_217_1:ShowNextGo(true)

				arg_217_1.typewritterCharCountI18N = var_220_4
			end

			if 2.85 < arg_217_1.time_ and arg_217_1.time_ <= 2.85 + arg_220_0 then
				local var_220_7 = arg_217_1.fswbg_.transform:Find("textbox/adapt/content") or arg_217_1.fswbg_.transform:Find("textbox/content")
				local var_220_8 = arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_220_9 = var_220_7:GetComponent("RectTransform")

				var_220_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_220_9.offsetMin = Vector2.New(0, 0)
				var_220_9.offsetMax = Vector2.New(0, 0)
			end

			local var_220_10 = 0

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_11 = 2

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 then
				local var_220_12 = Color.New(0, 0, 0)

				var_220_12.a = Mathf.Lerp(0, 1, (arg_217_1.time_ - var_220_10) / var_220_11)
				arg_217_1.mask_.color = var_220_12
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 then
				local var_220_13 = Color.New(0, 0, 0)

				var_220_13.a = 1
				arg_217_1.mask_.color = var_220_13
			end

			local var_220_14 = 2

			if 2 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1.mask_.enabled = true
				arg_217_1.mask_.raycastTarget = true

				arg_217_1:SetGaussion(false)
			end

			local var_220_15 = 2

			if var_220_14 <= arg_217_1.time_ and arg_217_1.time_ < var_220_14 + var_220_15 then
				local var_220_16 = Color.New(0, 0, 0)

				var_220_16.a = Mathf.Lerp(1, 0, (arg_217_1.time_ - var_220_14) / var_220_15)
				arg_217_1.mask_.color = var_220_16
			end

			if arg_217_1.time_ >= var_220_14 + var_220_15 and arg_217_1.time_ < var_220_14 + var_220_15 + arg_220_0 then
				local var_220_17 = Color.New(0, 0, 0)

				arg_217_1.mask_.enabled = false
				var_220_17.a = 0
				arg_217_1.mask_.color = var_220_17
			end

			local var_220_18 = "STblack"

			if arg_217_1.bgs_.STblack == nil then
				local var_220_19 = Object.Instantiate(arg_217_1.paintGo_)

				var_220_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_220_18)
				var_220_19.name = var_220_18
				var_220_19.transform.parent = arg_217_1.stage_.transform
				var_220_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.bgs_[var_220_18] = var_220_19
			end

			if 2 < arg_217_1.time_ and arg_217_1.time_ <= 2 + arg_220_0 then
				local var_220_20 = arg_217_1.bgs_.STblack

				arg_217_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_220_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_220_21 = var_220_20:GetComponent("SpriteRenderer")

				if var_220_21 and var_220_21.sprite then
					local var_220_22 = 2 * (var_220_20.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_220_20.transform.localScale = Vector3.New(var_220_22 / var_220_21.sprite.bounds.size.y < var_220_22 * manager.ui.mainCameraCom_.aspect / var_220_21.sprite.bounds.size.x and var_220_22 * manager.ui.mainCameraCom_.aspect / var_220_21.sprite.bounds.size.x or var_220_22 / var_220_21.sprite.bounds.size.y, var_220_22 / var_220_21.sprite.bounds.size.y < var_220_22 * manager.ui.mainCameraCom_.aspect / var_220_21.sprite.bounds.size.x and var_220_22 * manager.ui.mainCameraCom_.aspect / var_220_21.sprite.bounds.size.x or var_220_22 / var_220_21.sprite.bounds.size.y, 0)
				end

				for iter_220_0, iter_220_1 in pairs(arg_217_1.bgs_) do
					if iter_220_0 ~= "STblack" then
						iter_220_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play116071053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 116071053
		arg_221_1.duration_ = 1.82

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play116071054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.fswbg_:SetActive(true)
				arg_221_1.dialog_:SetActive(false)

				arg_221_1.fswtw_.percent = 0
				arg_221_1.fswt_.text = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(116071053).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.fswt_)

				arg_221_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_221_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_221_1.fswtw_:SetDirty()

				arg_221_1.typewritterCharCountI18N = 0

				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.var_.oldValueTypewriter = arg_221_1.fswtw_.percent

				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_1 = 27
			local var_224_2 = 1.8
			local var_224_3, var_224_4 = arg_221_1:GetPercentByPara(arg_221_1:FormatText(arg_221_1:GetWordFromCfg(116071053).content), 1)

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				local var_224_5 = var_224_1 <= 0 and var_224_2 or var_224_2 * ((var_224_4 - arg_221_1.typewritterCharCountI18N) / var_224_1)

				if (var_224_1 <= 0 and var_224_2 or var_224_2 * ((var_224_4 - arg_221_1.typewritterCharCountI18N) / var_224_1)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_0
					end
				end
			end

			local var_224_6 = math.max(1.8, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_6 then
				arg_221_1.fswtw_.percent = Mathf.Lerp(arg_221_1.var_.oldValueTypewriter, var_224_3, (arg_221_1.time_ - var_224_0) / var_224_6)
				arg_221_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_221_1.fswtw_:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_6 and arg_221_1.time_ < var_224_0 + var_224_6 + arg_224_0 then
				arg_221_1.fswtw_.percent = var_224_3

				arg_221_1.fswtw_:SetDirty()
				arg_221_1:ShowNextGo(true)

				arg_221_1.typewritterCharCountI18N = var_224_4
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play116071054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 116071054
		arg_225_1.duration_ = 1.47

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
			arg_225_1.auto_ = false
		end

		function arg_225_1.playNext_(arg_227_0)
			arg_225_1.onStoryFinished_()
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.fswbg_:SetActive(true)
				arg_225_1.dialog_:SetActive(false)

				arg_225_1.fswtw_.percent = 0
				arg_225_1.fswt_.text = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(116071054).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.fswt_)

				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_225_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_225_1.fswtw_:SetDirty()

				arg_225_1.typewritterCharCountI18N = 0

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.var_.oldValueTypewriter = arg_225_1.fswtw_.percent

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_1 = 19
			local var_228_2 = 1.26666666666667
			local var_228_3, var_228_4 = arg_225_1:GetPercentByPara(arg_225_1:FormatText(arg_225_1:GetWordFromCfg(116071054).content), 1)

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				local var_228_5 = var_228_1 <= 0 and var_228_2 or var_228_2 * ((var_228_4 - arg_225_1.typewritterCharCountI18N) / var_228_1)

				if (var_228_1 <= 0 and var_228_2 or var_228_2 * ((var_228_4 - arg_225_1.typewritterCharCountI18N) / var_228_1)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_0
					end
				end
			end

			local var_228_6 = math.max(1.26666666666667, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_6 then
				arg_225_1.fswtw_.percent = Mathf.Lerp(arg_225_1.var_.oldValueTypewriter, var_228_3, (arg_225_1.time_ - var_228_0) / var_228_6)
				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_225_1.fswtw_:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_6 and arg_225_1.time_ < var_228_0 + var_228_6 + arg_228_0 then
				arg_225_1.fswtw_.percent = var_228_3

				arg_225_1.fswtw_:SetDirty()
				arg_225_1:ShowNextGo(true)

				arg_225_1.typewritterCharCountI18N = var_228_4
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/SK0110",
		"TextureConfig/Background/SK0110b",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_116071.awb"
	}
}
