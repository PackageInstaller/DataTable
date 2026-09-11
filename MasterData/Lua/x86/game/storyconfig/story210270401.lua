return {
	Play1102704001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1102704001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1102704002(arg_1_1)
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

			if 1.73333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.73333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

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
			local var_4_15 = 1.875

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1102704001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 75 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 75)

				if (75 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 75)) > 0 and var_4_15 < var_4_19 then
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
	Play1102704002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1102704002
		arg_9_1.duration_ = 9.8

		local var_9_0 = {
			ja = 7.466,
			ko = 9.8,
			zh = 9.8
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1102704003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1027ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1027ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1027ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1027ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1027ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1027ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.81, -5.8)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1027ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1027ui_story == nil then
				arg_9_1.var_.characterEffect1027ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1027ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1027ui_story then
				arg_9_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 1.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(1102704002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 47 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 47)

				if (47 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 47)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704002", "story_v_side_new_1102704.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704002", "story_v_side_new_1102704.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_side_new_1102704", "1102704002", "story_v_side_new_1102704.awb")

						arg_9_1:RecordAudio("1102704002", var_12_15)
						arg_9_1:RecordAudio("1102704002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704002", "story_v_side_new_1102704.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704002", "story_v_side_new_1102704.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play1102704003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1102704003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1102704004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1027ui_story"]) and arg_13_1.var_.characterEffect1027ui_story == nil then
				arg_13_1.var_.characterEffect1027ui_story = arg_13_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1027ui_story"]) then
				if arg_13_1.var_.characterEffect1027ui_story and not isNil(arg_13_1.actors_["1027ui_story"]) then
					arg_13_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1027ui_story"]) and arg_13_1.var_.characterEffect1027ui_story then
				arg_13_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.725

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1102704003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 29 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 29)

				if (29 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 29)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1102704004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1102704004
		arg_17_1.duration_ = 12.1

		local var_17_0 = {
			ja = 10.166,
			ko = 12.1,
			zh = 12.1
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
				arg_17_0:Play1102704005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1027ui_story = arg_17_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1027ui_story"].transform.position).z)
				arg_17_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1027ui_story"].transform.localEulerAngles = arg_17_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_17_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1027ui_story"].transform.position).z)
				arg_17_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1027ui_story"].transform.localEulerAngles = arg_17_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1027ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1027ui_story == nil then
				arg_17_1.var_.characterEffect1027ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1027ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1027ui_story then
				arg_17_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_20_3 = "1039ui_story"

			if arg_17_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_20_4 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_17_1.stage_.transform)

				var_20_4.name = var_20_3
				var_20_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_3] = var_20_4

				local var_20_5 = var_20_4:GetComponentInChildren(typeof(CharacterEffect))

				var_20_5.enabled = true

				local var_20_6 = GameObjectTools.GetOrAddComponent(var_20_4, typeof(DynamicBoneHelper))

				if var_20_6 then
					var_20_6:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_5.transform, false)

				arg_17_1.var_[var_20_3 .. "Animator"] = var_20_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_3 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_3 .. "LipSync"] = var_20_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_7 = arg_17_1.actors_["1039ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1039ui_story = var_20_7.localPosition
			end

			local var_20_8 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 then
				var_20_7.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_17_1.time_ - 0) / var_20_8)
				var_20_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_7.position).x, (manager.ui.mainCamera.transform.position - var_20_7.position).y, (manager.ui.mainCamera.transform.position - var_20_7.position).z)
				var_20_7.localEulerAngles.z = 0
				var_20_7.localEulerAngles.x = 0
				var_20_7.localEulerAngles = var_20_7.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 then
				var_20_7.localPosition = Vector3.New(0.7, -1.01, -5.9)
				var_20_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_7.position).x, (manager.ui.mainCamera.transform.position - var_20_7.position).y, (manager.ui.mainCamera.transform.position - var_20_7.position).z)
				var_20_7.localEulerAngles.z = 0
				var_20_7.localEulerAngles.x = 0
				var_20_7.localEulerAngles = var_20_7.localEulerAngles
			end

			local var_20_9 = arg_17_1.actors_["1039ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1039ui_story == nil then
				arg_17_1.var_.characterEffect1039ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_10 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_10 and not isNil(var_20_9) then
				if arg_17_1.var_.characterEffect1039ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_10 and arg_17_1.time_ < 0 + var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1039ui_story then
				arg_17_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_12 = 0
			local var_20_13 = 1.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
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

				local var_20_14 = arg_17_1:GetWordFromCfg(1102704004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 58 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 58)

				if (58 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 58)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704004", "story_v_side_new_1102704.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704004", "story_v_side_new_1102704.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_side_new_1102704", "1102704004", "story_v_side_new_1102704.awb")

						arg_17_1:RecordAudio("1102704004", var_20_19)
						arg_17_1:RecordAudio("1102704004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704004", "story_v_side_new_1102704.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704004", "story_v_side_new_1102704.awb")
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
	Play1102704005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1102704005
		arg_21_1.duration_ = 10.2

		local var_21_0 = {
			ja = 10.033,
			ko = 10.2,
			zh = 10.2
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
				arg_21_0:Play1102704006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1027ui_story"]) and arg_21_1.var_.characterEffect1027ui_story == nil then
				arg_21_1.var_.characterEffect1027ui_story = arg_21_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1027ui_story"]) then
				if arg_21_1.var_.characterEffect1027ui_story and not isNil(arg_21_1.actors_["1027ui_story"]) then
					arg_21_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1027ui_story"]) and arg_21_1.var_.characterEffect1027ui_story then
				arg_21_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_2 = arg_21_1.actors_["1039ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1039ui_story == nil then
				arg_21_1.var_.characterEffect1039ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect1039ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect1039ui_story then
				arg_21_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 1.15

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(1102704005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 46 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 46)

				if (46 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 46)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704005", "story_v_side_new_1102704.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704005", "story_v_side_new_1102704.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_side_new_1102704", "1102704005", "story_v_side_new_1102704.awb")

						arg_21_1:RecordAudio("1102704005", var_24_11)
						arg_21_1:RecordAudio("1102704005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704005", "story_v_side_new_1102704.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704005", "story_v_side_new_1102704.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1102704006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1102704006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1102704007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1027ui_story"]) and arg_25_1.var_.characterEffect1027ui_story == nil then
				arg_25_1.var_.characterEffect1027ui_story = arg_25_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1027ui_story"]) then
				if arg_25_1.var_.characterEffect1027ui_story and not isNil(arg_25_1.actors_["1027ui_story"]) then
					arg_25_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1027ui_story"]) and arg_25_1.var_.characterEffect1027ui_story then
				arg_25_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.15

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1102704006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 46 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 46)

				if (46 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 46)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1102704007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1102704007
		arg_29_1.duration_ = 16.3

		local var_29_0 = {
			ja = 16.3,
			ko = 9.666,
			zh = 9.666
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
				arg_29_0:Play1102704008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1039ui_story"]) and arg_29_1.var_.characterEffect1039ui_story == nil then
				arg_29_1.var_.characterEffect1039ui_story = arg_29_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1039ui_story"]) then
				if arg_29_1.var_.characterEffect1039ui_story and not isNil(arg_29_1.actors_["1039ui_story"]) then
					arg_29_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1039ui_story"]) and arg_29_1.var_.characterEffect1039ui_story then
				arg_29_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action445")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_2 = 0
			local var_32_3 = 1.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(1102704007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 47 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 47)

				if (47 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 47)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704007", "story_v_side_new_1102704.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704007", "story_v_side_new_1102704.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_side_new_1102704", "1102704007", "story_v_side_new_1102704.awb")

						arg_29_1:RecordAudio("1102704007", var_32_9)
						arg_29_1:RecordAudio("1102704007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704007", "story_v_side_new_1102704.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704007", "story_v_side_new_1102704.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1102704008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1102704008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1102704009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1039ui_story"]) and arg_33_1.var_.characterEffect1039ui_story == nil then
				arg_33_1.var_.characterEffect1039ui_story = arg_33_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1039ui_story"]) then
				if arg_33_1.var_.characterEffect1039ui_story and not isNil(arg_33_1.actors_["1039ui_story"]) then
					arg_33_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1039ui_story"]) and arg_33_1.var_.characterEffect1039ui_story then
				arg_33_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_36_1 = 0
			local var_36_2 = 0.75

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1102704008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 30 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 30)

				if (30 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 30)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1102704009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1102704009
		arg_37_1.duration_ = 9.83

		local var_37_0 = {
			ja = 6.766,
			ko = 9.833,
			zh = 9.833
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
				arg_37_0:Play1102704010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1027ui_story"]) and arg_37_1.var_.characterEffect1027ui_story == nil then
				arg_37_1.var_.characterEffect1027ui_story = arg_37_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1027ui_story"]) then
				if arg_37_1.var_.characterEffect1027ui_story and not isNil(arg_37_1.actors_["1027ui_story"]) then
					arg_37_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1027ui_story"]) and arg_37_1.var_.characterEffect1027ui_story then
				arg_37_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_2 = 0
			local var_40_3 = 1.25

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(1102704009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 50 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 50)

				if (50 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 50)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704009", "story_v_side_new_1102704.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704009", "story_v_side_new_1102704.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_side_new_1102704", "1102704009", "story_v_side_new_1102704.awb")

						arg_37_1:RecordAudio("1102704009", var_40_9)
						arg_37_1:RecordAudio("1102704009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704009", "story_v_side_new_1102704.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704009", "story_v_side_new_1102704.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1102704010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1102704010
		arg_41_1.duration_ = 12.33

		local var_41_0 = {
			ja = 11.766,
			ko = 12.333,
			zh = 12.333
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
				arg_41_0:Play1102704011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1039ui_story"]) and arg_41_1.var_.characterEffect1039ui_story == nil then
				arg_41_1.var_.characterEffect1039ui_story = arg_41_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1039ui_story"]) then
				if arg_41_1.var_.characterEffect1039ui_story and not isNil(arg_41_1.actors_["1039ui_story"]) then
					arg_41_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1039ui_story"]) and arg_41_1.var_.characterEffect1039ui_story then
				arg_41_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action456")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_44_2 = arg_41_1.actors_["1027ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1027ui_story == nil then
				arg_41_1.var_.characterEffect1027ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1027ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1027ui_story then
				arg_41_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_44_4 = 0
			local var_44_5 = 1.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(1102704010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 50 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 50)

				if (50 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 50)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704010", "story_v_side_new_1102704.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704010", "story_v_side_new_1102704.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_side_new_1102704", "1102704010", "story_v_side_new_1102704.awb")

						arg_41_1:RecordAudio("1102704010", var_44_11)
						arg_41_1:RecordAudio("1102704010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704010", "story_v_side_new_1102704.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704010", "story_v_side_new_1102704.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1102704011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1102704011
		arg_45_1.duration_ = 9.1

		local var_45_0 = {
			ja = 4,
			ko = 9.1,
			zh = 9.1
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
				arg_45_0:Play1102704012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_48_0 = 0
			local var_48_1 = 1.175

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(1102704011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 47 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 47)

				if (47 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 47)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704011", "story_v_side_new_1102704.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704011", "story_v_side_new_1102704.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_side_new_1102704", "1102704011", "story_v_side_new_1102704.awb")

						arg_45_1:RecordAudio("1102704011", var_48_7)
						arg_45_1:RecordAudio("1102704011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704011", "story_v_side_new_1102704.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704011", "story_v_side_new_1102704.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1102704012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1102704012
		arg_49_1.duration_ = 9.5

		local var_49_0 = {
			ja = 6.466,
			ko = 9.5,
			zh = 9.5
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
				arg_49_0:Play1102704013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1027ui_story"]) and arg_49_1.var_.characterEffect1027ui_story == nil then
				arg_49_1.var_.characterEffect1027ui_story = arg_49_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1027ui_story"]) then
				if arg_49_1.var_.characterEffect1027ui_story and not isNil(arg_49_1.actors_["1027ui_story"]) then
					arg_49_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1027ui_story"]) and arg_49_1.var_.characterEffect1027ui_story then
				arg_49_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_2 = arg_49_1.actors_["1039ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1039ui_story == nil then
				arg_49_1.var_.characterEffect1039ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1039ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1039ui_story then
				arg_49_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_52_4 = 0
			local var_52_5 = 0.825

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(1102704012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 33 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 33)

				if (33 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 33)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704012", "story_v_side_new_1102704.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704012", "story_v_side_new_1102704.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_side_new_1102704", "1102704012", "story_v_side_new_1102704.awb")

						arg_49_1:RecordAudio("1102704012", var_52_11)
						arg_49_1:RecordAudio("1102704012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704012", "story_v_side_new_1102704.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704012", "story_v_side_new_1102704.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1102704013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1102704013
		arg_53_1.duration_ = 8.7

		local var_53_0 = {
			ja = 6.133,
			ko = 8.7,
			zh = 8.7
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
				arg_53_0:Play1102704014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1039ui_story"]) and arg_53_1.var_.characterEffect1039ui_story == nil then
				arg_53_1.var_.characterEffect1039ui_story = arg_53_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1039ui_story"]) then
				if arg_53_1.var_.characterEffect1039ui_story and not isNil(arg_53_1.actors_["1039ui_story"]) then
					arg_53_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1039ui_story"]) and arg_53_1.var_.characterEffect1039ui_story then
				arg_53_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action6_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_56_2 = arg_53_1.actors_["1027ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1027ui_story == nil then
				arg_53_1.var_.characterEffect1027ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect1027ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_3)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect1027ui_story then
				arg_53_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_56_4 = 0
			local var_56_5 = 0.875

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(1102704013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 35 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 35)

				if (35 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 35)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704013", "story_v_side_new_1102704.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704013", "story_v_side_new_1102704.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_new_1102704", "1102704013", "story_v_side_new_1102704.awb")

						arg_53_1:RecordAudio("1102704013", var_56_11)
						arg_53_1:RecordAudio("1102704013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704013", "story_v_side_new_1102704.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704013", "story_v_side_new_1102704.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1102704014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1102704014
		arg_57_1.duration_ = 6.77

		local var_57_0 = {
			ja = 3.933,
			ko = 6.766,
			zh = 6.766
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
				arg_57_0:Play1102704015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1027ui_story"]) and arg_57_1.var_.characterEffect1027ui_story == nil then
				arg_57_1.var_.characterEffect1027ui_story = arg_57_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1027ui_story"]) then
				if arg_57_1.var_.characterEffect1027ui_story and not isNil(arg_57_1.actors_["1027ui_story"]) then
					arg_57_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1027ui_story"]) and arg_57_1.var_.characterEffect1027ui_story then
				arg_57_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_2 = arg_57_1.actors_["1039ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1039ui_story == nil then
				arg_57_1.var_.characterEffect1039ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1039ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1039ui_story then
				arg_57_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_60_4 = 0
			local var_60_5 = 0.825

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(1102704014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 33 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 33)

				if (33 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 33)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704014", "story_v_side_new_1102704.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704014", "story_v_side_new_1102704.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_side_new_1102704", "1102704014", "story_v_side_new_1102704.awb")

						arg_57_1:RecordAudio("1102704014", var_60_11)
						arg_57_1:RecordAudio("1102704014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704014", "story_v_side_new_1102704.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704014", "story_v_side_new_1102704.awb")
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

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1102704015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1102704015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1102704016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(1102704015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 17 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 17)

				if (17 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 17)) > 0 and var_64_0 < var_64_3 then
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
	Play1102704016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1102704016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1102704017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1027ui_story = arg_65_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).z)
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles = arg_65_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1027ui_story"].transform.position).z)
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1027ui_story"].transform.localEulerAngles = arg_65_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1027ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1027ui_story == nil then
				arg_65_1.var_.characterEffect1027ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.034000001847744

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1027ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_2)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1027ui_story then
				arg_65_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_68_3 = arg_65_1.actors_["1039ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1039ui_story = var_68_3.localPosition
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_3.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_4)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_3.localPosition = Vector3.New(0, 100, 0)
				var_68_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_3.position).x, (manager.ui.mainCamera.transform.position - var_68_3.position).y, (manager.ui.mainCamera.transform.position - var_68_3.position).z)
				var_68_3.localEulerAngles.z = 0
				var_68_3.localEulerAngles.x = 0
				var_68_3.localEulerAngles = var_68_3.localEulerAngles
			end

			local var_68_5 = arg_65_1.actors_["1039ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1039ui_story == nil then
				arg_65_1.var_.characterEffect1039ui_story = var_68_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_6 = 0.034000001847744

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.characterEffect1039ui_story and not isNil(var_68_5) then
					arg_65_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_6)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.characterEffect1039ui_story then
				arg_65_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_68_7 = 0
			local var_68_8 = 0.75

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1102704016).content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 30 <= 0 and var_68_8 or var_68_8 * (utf8.len(var_68_9) / 30)

				if (30 <= 0 and var_68_8 or var_68_8 * (utf8.len(var_68_9) / 30)) > 0 and var_68_8 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_7 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_7
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_8, arg_65_1.talkMaxDuration)

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_7) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_7 + var_68_12 and arg_65_1.time_ < var_68_7 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_65_1:InitPlayNodeList()
	end,
	Play1102704017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1102704017
		arg_69_1.duration_ = 6.37

		local var_69_0 = {
			ja = 6.1,
			ko = 6.366,
			zh = 6.366
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
				arg_69_0:Play1102704018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "1148ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1148ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["1148ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["1148ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["1148ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1148ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_69_1.time_ - 0) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1148ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1148ui_story == nil then
				arg_69_1.var_.characterEffect1148ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1148ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1148ui_story then
				arg_69_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_72_8 = 0
			local var_72_9 = 0.775

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(1102704017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 31 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 31)

				if (31 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 31)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704017", "story_v_side_new_1102704.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704017", "story_v_side_new_1102704.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_side_new_1102704", "1102704017", "story_v_side_new_1102704.awb")

						arg_69_1:RecordAudio("1102704017", var_72_15)
						arg_69_1:RecordAudio("1102704017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704017", "story_v_side_new_1102704.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704017", "story_v_side_new_1102704.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
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
	Play1102704018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1102704018
		arg_73_1.duration_ = 4.37

		local var_73_0 = {
			ja = 4.366,
			ko = 3.466,
			zh = 3.466
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1102704019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1027ui_story = arg_73_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1027ui_story"].transform.position).z)
				arg_73_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1027ui_story"].transform.localEulerAngles = arg_73_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_73_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1027ui_story"].transform.position).z)
				arg_73_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1027ui_story"].transform.localEulerAngles = arg_73_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1027ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1027ui_story == nil then
				arg_73_1.var_.characterEffect1027ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1027ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1027ui_story then
				arg_73_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_76_4 = arg_73_1.actors_["1148ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1148ui_story == nil then
				arg_73_1.var_.characterEffect1148ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_5 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and not isNil(var_76_4) then
				if arg_73_1.var_.characterEffect1148ui_story and not isNil(var_76_4) then
					arg_73_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_5)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1148ui_story then
				arg_73_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_76_6 = 0
			local var_76_7 = 0.4

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:GetWordFromCfg(1102704018)
				local var_76_9 = arg_73_1:FormatText(var_76_8.content)

				arg_73_1.text_.text = var_76_9

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 16 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 16)

				if (16 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_9) / 16)) > 0 and var_76_7 < var_76_11 then
					arg_73_1.talkMaxDuration = var_76_11

					if var_76_11 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_9
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704018", "story_v_side_new_1102704.awb") ~= 0 then
					local var_76_12 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704018", "story_v_side_new_1102704.awb") / 1000

					if var_76_12 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_6
					end

					if var_76_8.prefab_name ~= "" and arg_73_1.actors_[var_76_8.prefab_name] ~= nil then
						local var_76_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_8.prefab_name].transform, "story_v_side_new_1102704", "1102704018", "story_v_side_new_1102704.awb")

						arg_73_1:RecordAudio("1102704018", var_76_13)
						arg_73_1:RecordAudio("1102704018", var_76_13)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704018", "story_v_side_new_1102704.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704018", "story_v_side_new_1102704.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play1102704019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1102704019
		arg_77_1.duration_ = 5.4

		local var_77_0 = {
			ja = 4.2,
			ko = 5.4,
			zh = 5.4
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
				arg_77_0:Play1102704020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1148ui_story"]) and arg_77_1.var_.characterEffect1148ui_story == nil then
				arg_77_1.var_.characterEffect1148ui_story = arg_77_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1148ui_story"]) then
				if arg_77_1.var_.characterEffect1148ui_story and not isNil(arg_77_1.actors_["1148ui_story"]) then
					arg_77_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1148ui_story"]) and arg_77_1.var_.characterEffect1148ui_story then
				arg_77_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action462")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_2 = arg_77_1.actors_["1027ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1027ui_story == nil then
				arg_77_1.var_.characterEffect1027ui_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect1027ui_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_3)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1027ui_story then
				arg_77_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_80_4 = 0
			local var_80_5 = 0.6

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(1102704019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 24 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 24)

				if (24 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 24)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704019", "story_v_side_new_1102704.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704019", "story_v_side_new_1102704.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_side_new_1102704", "1102704019", "story_v_side_new_1102704.awb")

						arg_77_1:RecordAudio("1102704019", var_80_11)
						arg_77_1:RecordAudio("1102704019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704019", "story_v_side_new_1102704.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704019", "story_v_side_new_1102704.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1102704020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1102704020
		arg_81_1.duration_ = 3.67

		local var_81_0 = {
			ja = 3.633,
			ko = 3.666,
			zh = 3.666
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
				arg_81_0:Play1102704021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1027ui_story = arg_81_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).z)
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles = arg_81_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1027ui_story"].transform.position).z)
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1027ui_story"].transform.localEulerAngles = arg_81_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1027ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1027ui_story == nil then
				arg_81_1.var_.characterEffect1027ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1027ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1027ui_story then
				arg_81_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_84_3 = arg_81_1.actors_["1039ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1039ui_story = var_84_3.localPosition
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_3.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (arg_81_1.time_ - 0) / var_84_4)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_3.localPosition = Vector3.New(0.7, -1.01, -5.9)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			local var_84_5 = arg_81_1.actors_["1039ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1039ui_story == nil then
				arg_81_1.var_.characterEffect1039ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.characterEffect1039ui_story and not isNil(var_84_5) then
					arg_81_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1039ui_story then
				arg_81_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_8 = arg_81_1.actors_["1148ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.characterEffect1148ui_story == nil then
				arg_81_1.var_.characterEffect1148ui_story = var_84_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_9 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_9 and not isNil(var_84_8) then
				if arg_81_1.var_.characterEffect1148ui_story and not isNil(var_84_8) then
					arg_81_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_9)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_9 and arg_81_1.time_ < 0 + var_84_9 + arg_84_0 and not isNil(var_84_8) and arg_81_1.var_.characterEffect1148ui_story then
				arg_81_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_84_10 = 0
			local var_84_11 = 0.45

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_12 = arg_81_1:GetWordFromCfg(1102704020)
				local var_84_13 = arg_81_1:FormatText(var_84_12.content)

				arg_81_1.text_.text = var_84_13

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 18 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 18)

				if (18 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 18)) > 0 and var_84_11 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_13
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704020", "story_v_side_new_1102704.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704020", "story_v_side_new_1102704.awb") / 1000

					if var_84_16 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_10
					end

					if var_84_12.prefab_name ~= "" and arg_81_1.actors_[var_84_12.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_12.prefab_name].transform, "story_v_side_new_1102704", "1102704020", "story_v_side_new_1102704.awb")

						arg_81_1:RecordAudio("1102704020", var_84_17)
						arg_81_1:RecordAudio("1102704020", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704020", "story_v_side_new_1102704.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704020", "story_v_side_new_1102704.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_18 and arg_81_1.time_ < var_84_10 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_81_1:InitPlayNodeList()
	end,
	Play1102704021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1102704021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1102704022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1039ui_story"]) and arg_85_1.var_.characterEffect1039ui_story == nil then
				arg_85_1.var_.characterEffect1039ui_story = arg_85_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1039ui_story"]) then
				if arg_85_1.var_.characterEffect1039ui_story and not isNil(arg_85_1.actors_["1039ui_story"]) then
					arg_85_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1039ui_story"]) and arg_85_1.var_.characterEffect1039ui_story then
				arg_85_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.625

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1102704021).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 25 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 25)

				if (25 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 25)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1102704022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1102704022
		arg_89_1.duration_ = 9.43

		local var_89_0 = {
			ja = 9.433,
			ko = 5.966,
			zh = 5.966
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
				arg_89_0:Play1102704023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1148ui_story"]) and arg_89_1.var_.characterEffect1148ui_story == nil then
				arg_89_1.var_.characterEffect1148ui_story = arg_89_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1148ui_story"]) then
				if arg_89_1.var_.characterEffect1148ui_story and not isNil(arg_89_1.actors_["1148ui_story"]) then
					arg_89_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1148ui_story"]) and arg_89_1.var_.characterEffect1148ui_story then
				arg_89_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action2_2")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_2 = 0
			local var_92_3 = 0.725

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:GetWordFromCfg(1102704022)
				local var_92_5 = arg_89_1:FormatText(var_92_4.content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 29 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 29)

				if (29 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_5) / 29)) > 0 and var_92_3 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704022", "story_v_side_new_1102704.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704022", "story_v_side_new_1102704.awb") / 1000

					if var_92_8 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_2
					end

					if var_92_4.prefab_name ~= "" and arg_89_1.actors_[var_92_4.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_4.prefab_name].transform, "story_v_side_new_1102704", "1102704022", "story_v_side_new_1102704.awb")

						arg_89_1:RecordAudio("1102704022", var_92_9)
						arg_89_1:RecordAudio("1102704022", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704022", "story_v_side_new_1102704.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704022", "story_v_side_new_1102704.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_10 and arg_89_1.time_ < var_92_2 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1102704023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1102704023
		arg_93_1.duration_ = 5

		local var_93_0 = {
			ja = 5,
			ko = 4.4,
			zh = 4.4
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
				arg_93_0:Play1102704024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1027ui_story = arg_93_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1027ui_story"].transform.position).z)
				arg_93_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1027ui_story"].transform.localEulerAngles = arg_93_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_93_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1027ui_story"].transform.position).z)
				arg_93_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1027ui_story"].transform.localEulerAngles = arg_93_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1027ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1027ui_story == nil then
				arg_93_1.var_.characterEffect1027ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1027ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1027ui_story then
				arg_93_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_4 = arg_93_1.actors_["1039ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1039ui_story = var_96_4.localPosition
			end

			local var_96_5 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 then
				var_96_4.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_5)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 then
				var_96_4.localPosition = Vector3.New(0, 100, 0)
				var_96_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_4.position).x, (manager.ui.mainCamera.transform.position - var_96_4.position).y, (manager.ui.mainCamera.transform.position - var_96_4.position).z)
				var_96_4.localEulerAngles.z = 0
				var_96_4.localEulerAngles.x = 0
				var_96_4.localEulerAngles = var_96_4.localEulerAngles
			end

			local var_96_6 = arg_93_1.actors_["1039ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1039ui_story == nil then
				arg_93_1.var_.characterEffect1039ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_7 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 and not isNil(var_96_6) then
				if arg_93_1.var_.characterEffect1039ui_story and not isNil(var_96_6) then
					arg_93_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_7)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1039ui_story then
				arg_93_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_96_8 = arg_93_1.actors_["1148ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.characterEffect1148ui_story == nil then
				arg_93_1.var_.characterEffect1148ui_story = var_96_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_9 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.characterEffect1148ui_story and not isNil(var_96_8) then
					arg_93_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_9)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.characterEffect1148ui_story then
				arg_93_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_96_10 = 0
			local var_96_11 = 0.55

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_12 = arg_93_1:GetWordFromCfg(1102704023)
				local var_96_13 = arg_93_1:FormatText(var_96_12.content)

				arg_93_1.text_.text = var_96_13

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_15 = 22 <= 0 and var_96_11 or var_96_11 * (utf8.len(var_96_13) / 22)

				if (22 <= 0 and var_96_11 or var_96_11 * (utf8.len(var_96_13) / 22)) > 0 and var_96_11 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_10
					end
				end

				arg_93_1.text_.text = var_96_13
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704023", "story_v_side_new_1102704.awb") ~= 0 then
					local var_96_16 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704023", "story_v_side_new_1102704.awb") / 1000

					if var_96_16 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_10
					end

					if var_96_12.prefab_name ~= "" and arg_93_1.actors_[var_96_12.prefab_name] ~= nil then
						local var_96_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_12.prefab_name].transform, "story_v_side_new_1102704", "1102704023", "story_v_side_new_1102704.awb")

						arg_93_1:RecordAudio("1102704023", var_96_17)
						arg_93_1:RecordAudio("1102704023", var_96_17)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704023", "story_v_side_new_1102704.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704023", "story_v_side_new_1102704.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_18 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_18 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_10) / var_96_18

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_10 + var_96_18 and arg_93_1.time_ < var_96_10 + var_96_18 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_93_1:InitPlayNodeList()
	end,
	Play1102704024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1102704024
		arg_97_1.duration_ = 9.6

		local var_97_0 = {
			ja = 9.6,
			ko = 4.666,
			zh = 4.666
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
				arg_97_0:Play1102704025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1148ui_story"]) and arg_97_1.var_.characterEffect1148ui_story == nil then
				arg_97_1.var_.characterEffect1148ui_story = arg_97_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1148ui_story"]) then
				if arg_97_1.var_.characterEffect1148ui_story and not isNil(arg_97_1.actors_["1148ui_story"]) then
					arg_97_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1148ui_story"]) and arg_97_1.var_.characterEffect1148ui_story then
				arg_97_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_100_2 = arg_97_1.actors_["1027ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1027ui_story == nil then
				arg_97_1.var_.characterEffect1027ui_story = var_100_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.characterEffect1027ui_story and not isNil(var_100_2) then
					arg_97_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_3)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect1027ui_story then
				arg_97_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_100_4 = 0
			local var_100_5 = 0.45

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(1102704024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 18 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 18)

				if (18 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 18)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704024", "story_v_side_new_1102704.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704024", "story_v_side_new_1102704.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_side_new_1102704", "1102704024", "story_v_side_new_1102704.awb")

						arg_97_1:RecordAudio("1102704024", var_100_11)
						arg_97_1:RecordAudio("1102704024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704024", "story_v_side_new_1102704.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704024", "story_v_side_new_1102704.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1102704025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1102704025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1102704026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1027ui_story = arg_101_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).z)
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles = arg_101_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1027ui_story"].transform.position).z)
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1027ui_story"].transform.localEulerAngles = arg_101_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1027ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1027ui_story == nil then
				arg_101_1.var_.characterEffect1027ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1027ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_2)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1027ui_story then
				arg_101_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_104_3 = arg_101_1.actors_["1148ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1148ui_story = var_104_3.localPosition
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_3.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_4)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_3.localPosition = Vector3.New(0, 100, 0)
				var_104_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_3.position).x, (manager.ui.mainCamera.transform.position - var_104_3.position).y, (manager.ui.mainCamera.transform.position - var_104_3.position).z)
				var_104_3.localEulerAngles.z = 0
				var_104_3.localEulerAngles.x = 0
				var_104_3.localEulerAngles = var_104_3.localEulerAngles
			end

			local var_104_5 = arg_101_1.actors_["1148ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1148ui_story == nil then
				arg_101_1.var_.characterEffect1148ui_story = var_104_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_6 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.characterEffect1148ui_story and not isNil(var_104_5) then
					arg_101_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_6)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.characterEffect1148ui_story then
				arg_101_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_104_7 = 0
			local var_104_8 = 0.9

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_9 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1102704025).content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 36 <= 0 and var_104_8 or var_104_8 * (utf8.len(var_104_9) / 36)

				if (36 <= 0 and var_104_8 or var_104_8 * (utf8.len(var_104_9) / 36)) > 0 and var_104_8 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_7 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_7
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_8, arg_101_1.talkMaxDuration)

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_7) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_7 + var_104_12 and arg_101_1.time_ < var_104_7 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play1102704026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1102704026
		arg_105_1.duration_ = 9

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1102704027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.bgs_.ST01 == nil then
				local var_108_0 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_108_0.name = "ST01"
				var_108_0.transform.parent = arg_105_1.stage_.transform
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_.ST01 = var_108_0
			end

			if 1.999999999999 < arg_105_1.time_ and arg_105_1.time_ <= 1.999999999999 + arg_108_0 then
				local var_108_1 = arg_105_1.bgs_.ST01

				arg_105_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_2 = var_108_1:GetComponent("SpriteRenderer")

				if var_108_2 and var_108_2.sprite then
					local var_108_3 = 2 * (var_108_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_1.transform.localScale = Vector3.New(var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "ST01" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_4 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_5 = 2

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_5 then
				local var_108_6 = Color.New(0, 0, 0)

				var_108_6.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - var_108_4) / var_108_5)
				arg_105_1.mask_.color = var_108_6
			end

			if arg_105_1.time_ >= var_108_4 + var_108_5 and arg_105_1.time_ < var_108_4 + var_108_5 + arg_108_0 then
				local var_108_7 = Color.New(0, 0, 0)

				var_108_7.a = 1
				arg_105_1.mask_.color = var_108_7
			end

			local var_108_8 = 2

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 then
				local var_108_10 = Color.New(0, 0, 0)

				var_108_10.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_8) / var_108_9)
				arg_105_1.mask_.color = var_108_10
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 then
				local var_108_11 = Color.New(0, 0, 0)

				arg_105_1.mask_.enabled = false
				var_108_11.a = 0
				arg_105_1.mask_.color = var_108_11
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_12 = 3.999999999999
			local var_108_13 = 0.975

			if 3.999999999999 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_14 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_14:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_15 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1102704026).content)

				arg_105_1.text_.text = var_108_15

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 39 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_15) / 39)

				if (39 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_15) / 39)) > 0 and var_108_13 < var_108_17 then
					arg_105_1.talkMaxDuration = var_108_17
					var_108_12 = var_108_12 + 0.3

					if var_108_17 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_15
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_18 = var_108_12 + 0.3
			local var_108_19 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_18 + var_108_19 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_18) / var_108_19

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_18 + var_108_19 and arg_105_1.time_ < var_108_18 + var_108_19 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1102704027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1102704027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1102704028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.35

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(1102704027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 54 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 54)

				if (54 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 54)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1102704028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1102704028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1102704029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.175

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(1102704028).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 47 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 47)

				if (47 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 47)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1102704029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1102704029
		arg_119_1.duration_ = 8.53

		local var_119_0 = {
			ja = 8.533,
			ko = 6.433,
			zh = 6.433
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1102704030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1027ui_story = arg_119_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1027ui_story"].transform.position).z)
				arg_119_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1027ui_story"].transform.localEulerAngles = arg_119_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_119_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1027ui_story"].transform.position).z)
				arg_119_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1027ui_story"].transform.localEulerAngles = arg_119_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1027ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1027ui_story == nil then
				arg_119_1.var_.characterEffect1027ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1027ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1027ui_story then
				arg_119_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_122_4 = 0
			local var_122_5 = 0.8

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:GetWordFromCfg(1102704029)
				local var_122_7 = arg_119_1:FormatText(var_122_6.content)

				arg_119_1.text_.text = var_122_7

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 32 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 32)

				if (32 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_7) / 32)) > 0 and var_122_5 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_7
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704029", "story_v_side_new_1102704.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704029", "story_v_side_new_1102704.awb") / 1000

					if var_122_10 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_4
					end

					if var_122_6.prefab_name ~= "" and arg_119_1.actors_[var_122_6.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_6.prefab_name].transform, "story_v_side_new_1102704", "1102704029", "story_v_side_new_1102704.awb")

						arg_119_1:RecordAudio("1102704029", var_122_11)
						arg_119_1:RecordAudio("1102704029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704029", "story_v_side_new_1102704.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704029", "story_v_side_new_1102704.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_12 and arg_119_1.time_ < var_122_4 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play1102704030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1102704030
		arg_123_1.duration_ = 8.73

		local var_123_0 = {
			ja = 8.733,
			ko = 6.333,
			zh = 6.333
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1102704031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_126_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_123_1.stage_.transform)

				var_126_0.name = "1084ui_story"
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.actors_["1084ui_story"] = var_126_0

				local var_126_1 = var_126_0:GetComponentInChildren(typeof(CharacterEffect))

				var_126_1.enabled = true

				local var_126_2 = GameObjectTools.GetOrAddComponent(var_126_0, typeof(DynamicBoneHelper))

				if var_126_2 then
					var_126_2:EnableDynamicBone(false)
				end

				arg_123_1:ShowWeapon(var_126_1.transform, false)

				arg_123_1.var_["1084ui_story" .. "Animator"] = var_126_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_123_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_123_1.var_["1084ui_story" .. "LipSync"] = var_126_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_126_3 = arg_123_1.actors_["1084ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1084ui_story = var_126_3.localPosition
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_3.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_123_1.time_ - 0) / var_126_4)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			local var_126_5 = arg_123_1.actors_["1084ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_5) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_8 = arg_123_1.actors_["1027ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.characterEffect1027ui_story == nil then
				arg_123_1.var_.characterEffect1027ui_story = var_126_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_9 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 and not isNil(var_126_8) then
				if arg_123_1.var_.characterEffect1027ui_story and not isNil(var_126_8) then
					arg_123_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_9)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.characterEffect1027ui_story then
				arg_123_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_126_10 = 0
			local var_126_11 = 0.85

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_12 = arg_123_1:GetWordFromCfg(1102704030)
				local var_126_13 = arg_123_1:FormatText(var_126_12.content)

				arg_123_1.text_.text = var_126_13

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_15 = 34 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 34)

				if (34 <= 0 and var_126_11 or var_126_11 * (utf8.len(var_126_13) / 34)) > 0 and var_126_11 < var_126_15 then
					arg_123_1.talkMaxDuration = var_126_15

					if var_126_15 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_10
					end
				end

				arg_123_1.text_.text = var_126_13
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704030", "story_v_side_new_1102704.awb") ~= 0 then
					local var_126_16 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704030", "story_v_side_new_1102704.awb") / 1000

					if var_126_16 + var_126_10 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_10
					end

					if var_126_12.prefab_name ~= "" and arg_123_1.actors_[var_126_12.prefab_name] ~= nil then
						local var_126_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_12.prefab_name].transform, "story_v_side_new_1102704", "1102704030", "story_v_side_new_1102704.awb")

						arg_123_1:RecordAudio("1102704030", var_126_17)
						arg_123_1:RecordAudio("1102704030", var_126_17)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704030", "story_v_side_new_1102704.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704030", "story_v_side_new_1102704.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_18 = math.max(var_126_11, arg_123_1.talkMaxDuration)

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_18 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_10) / var_126_18

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_10 + var_126_18 and arg_123_1.time_ < var_126_10 + var_126_18 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play1102704031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1102704031
		arg_127_1.duration_ = 5.53

		local var_127_0 = {
			ja = 5.533,
			ko = 3.866,
			zh = 3.866
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1102704032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1027ui_story = arg_127_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).z)
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles = arg_127_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				arg_127_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1027ui_story"].transform.position).z)
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1027ui_story"].transform.localEulerAngles = arg_127_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1027ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1027ui_story == nil then
				arg_127_1.var_.characterEffect1027ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1027ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1027ui_story then
				arg_127_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action424")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_130_4 = arg_127_1.actors_["1084ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_5 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_5 and not isNil(var_130_4) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_4) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_5)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_5 and arg_127_1.time_ < 0 + var_130_5 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_130_6 = 0
			local var_130_7 = 0.325

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:GetWordFromCfg(1102704031)
				local var_130_9 = arg_127_1:FormatText(var_130_8.content)

				arg_127_1.text_.text = var_130_9

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 13 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 13)

				if (13 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_9) / 13)) > 0 and var_130_7 < var_130_11 then
					arg_127_1.talkMaxDuration = var_130_11

					if var_130_11 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_9
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704031", "story_v_side_new_1102704.awb") ~= 0 then
					local var_130_12 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704031", "story_v_side_new_1102704.awb") / 1000

					if var_130_12 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_12 + var_130_6
					end

					if var_130_8.prefab_name ~= "" and arg_127_1.actors_[var_130_8.prefab_name] ~= nil then
						local var_130_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_8.prefab_name].transform, "story_v_side_new_1102704", "1102704031", "story_v_side_new_1102704.awb")

						arg_127_1:RecordAudio("1102704031", var_130_13)
						arg_127_1:RecordAudio("1102704031", var_130_13)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704031", "story_v_side_new_1102704.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704031", "story_v_side_new_1102704.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play1102704032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1102704032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1102704033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1084ui_story = arg_131_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).z)
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles = arg_131_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).z)
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles = arg_131_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1084ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1084ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_2)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_134_3 = arg_131_1.actors_["1027ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1027ui_story = var_134_3.localPosition
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_3.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_4)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_3.localPosition = Vector3.New(0, 100, 0)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			local var_134_5 = arg_131_1.actors_["1027ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect1027ui_story == nil then
				arg_131_1.var_.characterEffect1027ui_story = var_134_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.characterEffect1027ui_story and not isNil(var_134_5) then
					arg_131_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_6)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect1027ui_story then
				arg_131_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_134_7 = 0
			local var_134_8 = 1.35

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_9 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(1102704032).content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 54 <= 0 and var_134_8 or var_134_8 * (utf8.len(var_134_9) / 54)

				if (54 <= 0 and var_134_8 or var_134_8 * (utf8.len(var_134_9) / 54)) > 0 and var_134_8 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_7 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_7
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_8, arg_131_1.talkMaxDuration)

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_7) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_7 + var_134_12 and arg_131_1.time_ < var_134_7 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1102704033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1102704033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1102704034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.075

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1102704033).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 43 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 43)

				if (43 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 43)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1102704034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1102704034
		arg_139_1.duration_ = 7.93

		local var_139_0 = {
			ja = 4.966,
			ko = 7.933,
			zh = 7.933
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
				arg_139_0:Play1102704035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if arg_139_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_142_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_139_1.stage_.transform)

				var_142_0.name = "1080ui_story"
				var_142_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1080ui_story"] = var_142_0

				local var_142_1 = var_142_0:GetComponentInChildren(typeof(CharacterEffect))

				var_142_1.enabled = true

				local var_142_2 = GameObjectTools.GetOrAddComponent(var_142_0, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(false)
				end

				arg_139_1:ShowWeapon(var_142_1.transform, false)

				arg_139_1.var_["1080ui_story" .. "Animator"] = var_142_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_139_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_139_1.var_["1080ui_story" .. "LipSync"] = var_142_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_142_3 = arg_139_1.actors_["1080ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1080ui_story = var_142_3.localPosition
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_3.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_139_1.time_ - 0) / var_142_4)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_3.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			local var_142_5 = arg_139_1.actors_["1080ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1080ui_story == nil then
				arg_139_1.var_.characterEffect1080ui_story = var_142_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.characterEffect1080ui_story and not isNil(var_142_5) then
					arg_139_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1080ui_story then
				arg_139_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_8 = 0
			local var_142_9 = 0.625

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(1102704034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 25 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 25)

				if (25 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 25)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704034", "story_v_side_new_1102704.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704034", "story_v_side_new_1102704.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_side_new_1102704", "1102704034", "story_v_side_new_1102704.awb")

						arg_139_1:RecordAudio("1102704034", var_142_15)
						arg_139_1:RecordAudio("1102704034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704034", "story_v_side_new_1102704.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704034", "story_v_side_new_1102704.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play1102704035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1102704035
		arg_143_1.duration_ = 11.73

		local var_143_0 = {
			ja = 11.733,
			ko = 8.033,
			zh = 8.033
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
				arg_143_0:Play1102704036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1027ui_story = arg_143_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1027ui_story"].transform.position).z)
				arg_143_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1027ui_story"].transform.localEulerAngles = arg_143_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_143_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1027ui_story"].transform.position).z)
				arg_143_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1027ui_story"].transform.localEulerAngles = arg_143_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1027ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1027ui_story == nil then
				arg_143_1.var_.characterEffect1027ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1027ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1027ui_story then
				arg_143_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_146_4 = arg_143_1.actors_["1080ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect1080ui_story == nil then
				arg_143_1.var_.characterEffect1080ui_story = var_146_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_5 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 and not isNil(var_146_4) then
				if arg_143_1.var_.characterEffect1080ui_story and not isNil(var_146_4) then
					arg_143_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_5)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 and not isNil(var_146_4) and arg_143_1.var_.characterEffect1080ui_story then
				arg_143_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_146_6 = 0
			local var_146_7 = 1

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:GetWordFromCfg(1102704035)
				local var_146_9 = arg_143_1:FormatText(var_146_8.content)

				arg_143_1.text_.text = var_146_9

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 40 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 40)

				if (40 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_9) / 40)) > 0 and var_146_7 < var_146_11 then
					arg_143_1.talkMaxDuration = var_146_11

					if var_146_11 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_9
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704035", "story_v_side_new_1102704.awb") ~= 0 then
					local var_146_12 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704035", "story_v_side_new_1102704.awb") / 1000

					if var_146_12 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_12 + var_146_6
					end

					if var_146_8.prefab_name ~= "" and arg_143_1.actors_[var_146_8.prefab_name] ~= nil then
						local var_146_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_8.prefab_name].transform, "story_v_side_new_1102704", "1102704035", "story_v_side_new_1102704.awb")

						arg_143_1:RecordAudio("1102704035", var_146_13)
						arg_143_1:RecordAudio("1102704035", var_146_13)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704035", "story_v_side_new_1102704.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704035", "story_v_side_new_1102704.awb")
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
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play1102704036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1102704036
		arg_147_1.duration_ = 9.17

		local var_147_0 = {
			ja = 9.166,
			ko = 8.766,
			zh = 8.766
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
				arg_147_0:Play1102704037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1080ui_story"]) and arg_147_1.var_.characterEffect1080ui_story == nil then
				arg_147_1.var_.characterEffect1080ui_story = arg_147_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1080ui_story"]) then
				if arg_147_1.var_.characterEffect1080ui_story and not isNil(arg_147_1.actors_["1080ui_story"]) then
					arg_147_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1080ui_story"]) and arg_147_1.var_.characterEffect1080ui_story then
				arg_147_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_2 = arg_147_1.actors_["1027ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect1027ui_story == nil then
				arg_147_1.var_.characterEffect1027ui_story = var_150_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_3 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.characterEffect1027ui_story and not isNil(var_150_2) then
					arg_147_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_3)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.characterEffect1027ui_story then
				arg_147_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_150_4 = 0
			local var_150_5 = 0.825

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(1102704036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 33 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 33)

				if (33 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 33)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704036", "story_v_side_new_1102704.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704036", "story_v_side_new_1102704.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_side_new_1102704", "1102704036", "story_v_side_new_1102704.awb")

						arg_147_1:RecordAudio("1102704036", var_150_11)
						arg_147_1:RecordAudio("1102704036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704036", "story_v_side_new_1102704.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704036", "story_v_side_new_1102704.awb")
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
	Play1102704037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1102704037
		arg_151_1.duration_ = 10.63

		local var_151_0 = {
			ja = 9.2,
			ko = 10.633,
			zh = 10.633
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
				arg_151_0:Play1102704038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1027ui_story"]) and arg_151_1.var_.characterEffect1027ui_story == nil then
				arg_151_1.var_.characterEffect1027ui_story = arg_151_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1027ui_story"]) then
				if arg_151_1.var_.characterEffect1027ui_story and not isNil(arg_151_1.actors_["1027ui_story"]) then
					arg_151_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1027ui_story"]) and arg_151_1.var_.characterEffect1027ui_story then
				arg_151_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_154_2 = arg_151_1.actors_["1080ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect1080ui_story == nil then
				arg_151_1.var_.characterEffect1080ui_story = var_154_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_3 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.characterEffect1080ui_story and not isNil(var_154_2) then
					arg_151_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_3)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect1080ui_story then
				arg_151_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_154_4 = 0
			local var_154_5 = 0.95

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(1102704037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 38 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 38)

				if (38 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 38)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704037", "story_v_side_new_1102704.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704037", "story_v_side_new_1102704.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_side_new_1102704", "1102704037", "story_v_side_new_1102704.awb")

						arg_151_1:RecordAudio("1102704037", var_154_11)
						arg_151_1:RecordAudio("1102704037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704037", "story_v_side_new_1102704.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704037", "story_v_side_new_1102704.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1102704038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1102704038
		arg_155_1.duration_ = 2.17

		local var_155_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1102704039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1080ui_story"]) and arg_155_1.var_.characterEffect1080ui_story == nil then
				arg_155_1.var_.characterEffect1080ui_story = arg_155_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1080ui_story"]) then
				if arg_155_1.var_.characterEffect1080ui_story and not isNil(arg_155_1.actors_["1080ui_story"]) then
					arg_155_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1080ui_story"]) and arg_155_1.var_.characterEffect1080ui_story then
				arg_155_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_158_2 = arg_155_1.actors_["1027ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1027ui_story == nil then
				arg_155_1.var_.characterEffect1027ui_story = var_158_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_3 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.characterEffect1027ui_story and not isNil(var_158_2) then
					arg_155_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_3)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.characterEffect1027ui_story then
				arg_155_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_158_4 = 0
			local var_158_5 = 0.125

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(1102704038)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 5 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 5)

				if (5 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 5)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704038", "story_v_side_new_1102704.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704038", "story_v_side_new_1102704.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_side_new_1102704", "1102704038", "story_v_side_new_1102704.awb")

						arg_155_1:RecordAudio("1102704038", var_158_11)
						arg_155_1:RecordAudio("1102704038", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704038", "story_v_side_new_1102704.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704038", "story_v_side_new_1102704.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1102704039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1102704039
		arg_159_1.duration_ = 10.13

		local var_159_0 = {
			ja = 7.1,
			ko = 10.133,
			zh = 10.133
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
				arg_159_0:Play1102704040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_162_0 = 0
			local var_162_1 = 0.6

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(1102704039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 24 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 24)

				if (24 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 24)) > 0 and var_162_1 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704039", "story_v_side_new_1102704.awb") ~= 0 then
					local var_162_6 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704039", "story_v_side_new_1102704.awb") / 1000

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end

					if var_162_2.prefab_name ~= "" and arg_159_1.actors_[var_162_2.prefab_name] ~= nil then
						local var_162_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_2.prefab_name].transform, "story_v_side_new_1102704", "1102704039", "story_v_side_new_1102704.awb")

						arg_159_1:RecordAudio("1102704039", var_162_7)
						arg_159_1:RecordAudio("1102704039", var_162_7)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704039", "story_v_side_new_1102704.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704039", "story_v_side_new_1102704.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1102704040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1102704040
		arg_163_1.duration_ = 3.77

		local var_163_0 = {
			ja = 3.766,
			ko = 3.366,
			zh = 3.366
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
				arg_163_0:Play1102704041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1027ui_story"]) and arg_163_1.var_.characterEffect1027ui_story == nil then
				arg_163_1.var_.characterEffect1027ui_story = arg_163_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1027ui_story"]) then
				if arg_163_1.var_.characterEffect1027ui_story and not isNil(arg_163_1.actors_["1027ui_story"]) then
					arg_163_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1027ui_story"]) and arg_163_1.var_.characterEffect1027ui_story then
				arg_163_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_2 = arg_163_1.actors_["1080ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1080ui_story == nil then
				arg_163_1.var_.characterEffect1080ui_story = var_166_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_3 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.characterEffect1080ui_story and not isNil(var_166_2) then
					arg_163_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1080ui_story then
				arg_163_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_166_4 = 0
			local var_166_5 = 0.1

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(1102704040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 4 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 4)

				if (4 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 4)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704040", "story_v_side_new_1102704.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704040", "story_v_side_new_1102704.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_side_new_1102704", "1102704040", "story_v_side_new_1102704.awb")

						arg_163_1:RecordAudio("1102704040", var_166_11)
						arg_163_1:RecordAudio("1102704040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704040", "story_v_side_new_1102704.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704040", "story_v_side_new_1102704.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1102704041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1102704041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1102704042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1027ui_story = arg_167_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1027ui_story"].transform.position).z)
				arg_167_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1027ui_story"].transform.localEulerAngles = arg_167_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1027ui_story"].transform.position).z)
				arg_167_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1027ui_story"].transform.localEulerAngles = arg_167_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["1027ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1027ui_story == nil then
				arg_167_1.var_.characterEffect1027ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect1027ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_2)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect1027ui_story then
				arg_167_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_170_3 = arg_167_1.actors_["1080ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1080ui_story = var_170_3.localPosition
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_3.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_4)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_3.localPosition = Vector3.New(0, 100, 0)
				var_170_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_3.position).x, (manager.ui.mainCamera.transform.position - var_170_3.position).y, (manager.ui.mainCamera.transform.position - var_170_3.position).z)
				var_170_3.localEulerAngles.z = 0
				var_170_3.localEulerAngles.x = 0
				var_170_3.localEulerAngles = var_170_3.localEulerAngles
			end

			local var_170_5 = arg_167_1.actors_["1080ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1080ui_story == nil then
				arg_167_1.var_.characterEffect1080ui_story = var_170_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_6 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.characterEffect1080ui_story and not isNil(var_170_5) then
					arg_167_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_6)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.characterEffect1080ui_story then
				arg_167_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_170_7 = 0
			local var_170_8 = 1.025

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_9 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1102704041).content)

				arg_167_1.text_.text = var_170_9

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 41 <= 0 and var_170_8 or var_170_8 * (utf8.len(var_170_9) / 41)

				if (41 <= 0 and var_170_8 or var_170_8 * (utf8.len(var_170_9) / 41)) > 0 and var_170_8 < var_170_11 then
					arg_167_1.talkMaxDuration = var_170_11

					if var_170_11 + var_170_7 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_7
					end
				end

				arg_167_1.text_.text = var_170_9
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_8, arg_167_1.talkMaxDuration)

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_7) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_7 + var_170_12 and arg_167_1.time_ < var_170_7 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
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
	Play1102704042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1102704042
		arg_171_1.duration_ = 11.07

		local var_171_0 = {
			ja = 5.4,
			ko = 11.066,
			zh = 11.066
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
				arg_171_0:Play1102704043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1080ui_story = arg_171_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1080ui_story"].transform.position).z)
				arg_171_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1080ui_story"].transform.localEulerAngles = arg_171_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				arg_171_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1080ui_story"].transform.position).z)
				arg_171_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1080ui_story"].transform.localEulerAngles = arg_171_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1080ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1080ui_story == nil then
				arg_171_1.var_.characterEffect1080ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1080ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1080ui_story then
				arg_171_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_174_4 = 0
			local var_174_5 = 1.125

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(1102704042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 45 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 45)

				if (45 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 45)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704042", "story_v_side_new_1102704.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704042", "story_v_side_new_1102704.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_side_new_1102704", "1102704042", "story_v_side_new_1102704.awb")

						arg_171_1:RecordAudio("1102704042", var_174_11)
						arg_171_1:RecordAudio("1102704042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704042", "story_v_side_new_1102704.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704042", "story_v_side_new_1102704.awb")
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

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
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
	Play1102704043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1102704043
		arg_175_1.duration_ = 13.77

		local var_175_0 = {
			ja = 13.766,
			ko = 13.133,
			zh = 13.133
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1102704044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1027ui_story = arg_175_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1027ui_story"].transform.position).z)
				arg_175_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1027ui_story"].transform.localEulerAngles = arg_175_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_175_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1027ui_story"].transform.position).z)
				arg_175_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1027ui_story"].transform.localEulerAngles = arg_175_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["1027ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1027ui_story == nil then
				arg_175_1.var_.characterEffect1027ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1027ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1027ui_story then
				arg_175_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_178_4 = arg_175_1.actors_["1080ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1080ui_story == nil then
				arg_175_1.var_.characterEffect1080ui_story = var_178_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_5 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_5 and not isNil(var_178_4) then
				if arg_175_1.var_.characterEffect1080ui_story and not isNil(var_178_4) then
					arg_175_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_5)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_5 and arg_175_1.time_ < 0 + var_178_5 + arg_178_0 and not isNil(var_178_4) and arg_175_1.var_.characterEffect1080ui_story then
				arg_175_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_178_6 = 0
			local var_178_7 = 0.95

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:GetWordFromCfg(1102704043)
				local var_178_9 = arg_175_1:FormatText(var_178_8.content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 38 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 38)

				if (38 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 38)) > 0 and var_178_7 < var_178_11 then
					arg_175_1.talkMaxDuration = var_178_11

					if var_178_11 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704043", "story_v_side_new_1102704.awb") ~= 0 then
					local var_178_12 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704043", "story_v_side_new_1102704.awb") / 1000

					if var_178_12 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_6
					end

					if var_178_8.prefab_name ~= "" and arg_175_1.actors_[var_178_8.prefab_name] ~= nil then
						local var_178_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_8.prefab_name].transform, "story_v_side_new_1102704", "1102704043", "story_v_side_new_1102704.awb")

						arg_175_1:RecordAudio("1102704043", var_178_13)
						arg_175_1:RecordAudio("1102704043", var_178_13)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704043", "story_v_side_new_1102704.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704043", "story_v_side_new_1102704.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1102704044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1102704044
		arg_179_1.duration_ = 7.47

		local var_179_0 = {
			ja = 6.333,
			ko = 7.466,
			zh = 7.466
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1102704045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1080ui_story"]) and arg_179_1.var_.characterEffect1080ui_story == nil then
				arg_179_1.var_.characterEffect1080ui_story = arg_179_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1080ui_story"]) then
				if arg_179_1.var_.characterEffect1080ui_story and not isNil(arg_179_1.actors_["1080ui_story"]) then
					arg_179_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1080ui_story"]) and arg_179_1.var_.characterEffect1080ui_story then
				arg_179_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			local var_182_2 = arg_179_1.actors_["1027ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect1027ui_story == nil then
				arg_179_1.var_.characterEffect1027ui_story = var_182_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_3 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.characterEffect1027ui_story and not isNil(var_182_2) then
					arg_179_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_3)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect1027ui_story then
				arg_179_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_182_4 = 0
			local var_182_5 = 0.7

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(1102704044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 28 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 28)

				if (28 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 28)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704044", "story_v_side_new_1102704.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704044", "story_v_side_new_1102704.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_side_new_1102704", "1102704044", "story_v_side_new_1102704.awb")

						arg_179_1:RecordAudio("1102704044", var_182_11)
						arg_179_1:RecordAudio("1102704044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704044", "story_v_side_new_1102704.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704044", "story_v_side_new_1102704.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_12 = math.max(var_182_5, arg_179_1.talkMaxDuration)

			if var_182_4 <= arg_179_1.time_ and arg_179_1.time_ < var_182_4 + var_182_12 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_4) / var_182_12

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_4 + var_182_12 and arg_179_1.time_ < var_182_4 + var_182_12 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1102704045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1102704045
		arg_183_1.duration_ = 2.7

		local var_183_0 = {
			ja = 1.999999999999,
			ko = 2.7,
			zh = 2.7
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
				arg_183_0:Play1102704046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1027ui_story = arg_183_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1027ui_story"].transform.position).z)
				arg_183_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1027ui_story"].transform.localEulerAngles = arg_183_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_183_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1027ui_story"].transform.position).z)
				arg_183_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1027ui_story"].transform.localEulerAngles = arg_183_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1027ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1027ui_story == nil then
				arg_183_1.var_.characterEffect1027ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1027ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1027ui_story then
				arg_183_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_2")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_4 = arg_183_1.actors_["1080ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect1080ui_story == nil then
				arg_183_1.var_.characterEffect1080ui_story = var_186_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_5 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_5 and not isNil(var_186_4) then
				if arg_183_1.var_.characterEffect1080ui_story and not isNil(var_186_4) then
					arg_183_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_5)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_5 and arg_183_1.time_ < 0 + var_186_5 + arg_186_0 and not isNil(var_186_4) and arg_183_1.var_.characterEffect1080ui_story then
				arg_183_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_186_6 = 0
			local var_186_7 = 0.1

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_8 = arg_183_1:GetWordFromCfg(1102704045)
				local var_186_9 = arg_183_1:FormatText(var_186_8.content)

				arg_183_1.text_.text = var_186_9

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_11 = 4 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 4)

				if (4 <= 0 and var_186_7 or var_186_7 * (utf8.len(var_186_9) / 4)) > 0 and var_186_7 < var_186_11 then
					arg_183_1.talkMaxDuration = var_186_11

					if var_186_11 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_6
					end
				end

				arg_183_1.text_.text = var_186_9
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704045", "story_v_side_new_1102704.awb") ~= 0 then
					local var_186_12 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704045", "story_v_side_new_1102704.awb") / 1000

					if var_186_12 + var_186_6 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_12 + var_186_6
					end

					if var_186_8.prefab_name ~= "" and arg_183_1.actors_[var_186_8.prefab_name] ~= nil then
						local var_186_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_8.prefab_name].transform, "story_v_side_new_1102704", "1102704045", "story_v_side_new_1102704.awb")

						arg_183_1:RecordAudio("1102704045", var_186_13)
						arg_183_1:RecordAudio("1102704045", var_186_13)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704045", "story_v_side_new_1102704.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704045", "story_v_side_new_1102704.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_14 = math.max(var_186_7, arg_183_1.talkMaxDuration)

			if var_186_6 <= arg_183_1.time_ and arg_183_1.time_ < var_186_6 + var_186_14 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_6) / var_186_14

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_6 + var_186_14 and arg_183_1.time_ < var_186_6 + var_186_14 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
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
	Play1102704046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1102704046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1102704047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1027ui_story"]) and arg_187_1.var_.characterEffect1027ui_story == nil then
				arg_187_1.var_.characterEffect1027ui_story = arg_187_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1027ui_story"]) then
				if arg_187_1.var_.characterEffect1027ui_story and not isNil(arg_187_1.actors_["1027ui_story"]) then
					arg_187_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1027ui_story"]) and arg_187_1.var_.characterEffect1027ui_story then
				arg_187_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.875

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1102704046).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 35 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 35)

				if (35 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 35)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1102704047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1102704047
		arg_191_1.duration_ = 11.63

		local var_191_0 = {
			ja = 11.633,
			ko = 8.7,
			zh = 8.7
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1102704048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["1027ui_story"]) and arg_191_1.var_.characterEffect1027ui_story == nil then
				arg_191_1.var_.characterEffect1027ui_story = arg_191_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["1027ui_story"]) then
				if arg_191_1.var_.characterEffect1027ui_story and not isNil(arg_191_1.actors_["1027ui_story"]) then
					arg_191_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["1027ui_story"]) and arg_191_1.var_.characterEffect1027ui_story then
				arg_191_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_194_2 = 0
			local var_194_3 = 0.925

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(1102704047)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 37 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 37)

				if (37 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 37)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704047", "story_v_side_new_1102704.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704047", "story_v_side_new_1102704.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_side_new_1102704", "1102704047", "story_v_side_new_1102704.awb")

						arg_191_1:RecordAudio("1102704047", var_194_9)
						arg_191_1:RecordAudio("1102704047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704047", "story_v_side_new_1102704.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704047", "story_v_side_new_1102704.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1102704048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1102704048
		arg_195_1.duration_ = 5.73

		local var_195_0 = {
			ja = 5.733,
			ko = 3.6,
			zh = 3.6
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1102704049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1080ui_story = arg_195_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1080ui_story"].transform.position).z)
				arg_195_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1080ui_story"].transform.localEulerAngles = arg_195_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1080ui_story"].transform.position).z)
				arg_195_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1080ui_story"].transform.localEulerAngles = arg_195_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1080ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1080ui_story == nil then
				arg_195_1.var_.characterEffect1080ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1080ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_2)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1080ui_story then
				arg_195_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_198_3 = "1019ui_story"

			if arg_195_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_198_4 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_195_1.stage_.transform)

				var_198_4.name = var_198_3
				var_198_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_[var_198_3] = var_198_4

				local var_198_5 = var_198_4:GetComponentInChildren(typeof(CharacterEffect))

				var_198_5.enabled = true

				local var_198_6 = GameObjectTools.GetOrAddComponent(var_198_4, typeof(DynamicBoneHelper))

				if var_198_6 then
					var_198_6:EnableDynamicBone(false)
				end

				arg_195_1:ShowWeapon(var_198_5.transform, false)

				arg_195_1.var_[var_198_3 .. "Animator"] = var_198_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_195_1.var_[var_198_3 .. "Animator"].applyRootMotion = true
				arg_195_1.var_[var_198_3 .. "LipSync"] = var_198_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_198_7 = arg_195_1.actors_["1019ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1019ui_story = var_198_7.localPosition
			end

			local var_198_8 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_8 then
				var_198_7.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_195_1.time_ - 0) / var_198_8)
				var_198_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_7.position).x, (manager.ui.mainCamera.transform.position - var_198_7.position).y, (manager.ui.mainCamera.transform.position - var_198_7.position).z)
				var_198_7.localEulerAngles.z = 0
				var_198_7.localEulerAngles.x = 0
				var_198_7.localEulerAngles = var_198_7.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_8 and arg_195_1.time_ < 0 + var_198_8 + arg_198_0 then
				var_198_7.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_198_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_7.position).x, (manager.ui.mainCamera.transform.position - var_198_7.position).y, (manager.ui.mainCamera.transform.position - var_198_7.position).z)
				var_198_7.localEulerAngles.z = 0
				var_198_7.localEulerAngles.x = 0
				var_198_7.localEulerAngles = var_198_7.localEulerAngles
			end

			local var_198_9 = arg_195_1.actors_["1019ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1019ui_story == nil then
				arg_195_1.var_.characterEffect1019ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_10 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_10 and not isNil(var_198_9) then
				if arg_195_1.var_.characterEffect1019ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_10 and arg_195_1.time_ < 0 + var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1019ui_story then
				arg_195_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_198_12 = arg_195_1.actors_["1027ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_12) and arg_195_1.var_.characterEffect1027ui_story == nil then
				arg_195_1.var_.characterEffect1027ui_story = var_198_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_13 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_13 and not isNil(var_198_12) then
				if arg_195_1.var_.characterEffect1027ui_story and not isNil(var_198_12) then
					arg_195_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_13)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_13 and arg_195_1.time_ < 0 + var_198_13 + arg_198_0 and not isNil(var_198_12) and arg_195_1.var_.characterEffect1027ui_story then
				arg_195_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_198_14 = 0
			local var_198_15 = 0.4

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_16 = arg_195_1:GetWordFromCfg(1102704048)
				local var_198_17 = arg_195_1:FormatText(var_198_16.content)

				arg_195_1.text_.text = var_198_17

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_19 = 16 <= 0 and var_198_15 or var_198_15 * (utf8.len(var_198_17) / 16)

				if (16 <= 0 and var_198_15 or var_198_15 * (utf8.len(var_198_17) / 16)) > 0 and var_198_15 < var_198_19 then
					arg_195_1.talkMaxDuration = var_198_19

					if var_198_19 + var_198_14 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_19 + var_198_14
					end
				end

				arg_195_1.text_.text = var_198_17
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704048", "story_v_side_new_1102704.awb") ~= 0 then
					local var_198_20 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704048", "story_v_side_new_1102704.awb") / 1000

					if var_198_20 + var_198_14 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_20 + var_198_14
					end

					if var_198_16.prefab_name ~= "" and arg_195_1.actors_[var_198_16.prefab_name] ~= nil then
						local var_198_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_16.prefab_name].transform, "story_v_side_new_1102704", "1102704048", "story_v_side_new_1102704.awb")

						arg_195_1:RecordAudio("1102704048", var_198_21)
						arg_195_1:RecordAudio("1102704048", var_198_21)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704048", "story_v_side_new_1102704.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704048", "story_v_side_new_1102704.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_22 = math.max(var_198_15, arg_195_1.talkMaxDuration)

			if var_198_14 <= arg_195_1.time_ and arg_195_1.time_ < var_198_14 + var_198_22 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_14) / var_198_22

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_14 + var_198_22 and arg_195_1.time_ < var_198_14 + var_198_22 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_195_1:InitPlayNodeList()
	end,
	Play1102704049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1102704049
		arg_199_1.duration_ = 7.07

		local var_199_0 = {
			ja = 3.1,
			ko = 7.066,
			zh = 7.066
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1102704050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1027ui_story"]) and arg_199_1.var_.characterEffect1027ui_story == nil then
				arg_199_1.var_.characterEffect1027ui_story = arg_199_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1027ui_story"]) then
				if arg_199_1.var_.characterEffect1027ui_story and not isNil(arg_199_1.actors_["1027ui_story"]) then
					arg_199_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1027ui_story"]) and arg_199_1.var_.characterEffect1027ui_story then
				arg_199_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_202_2 = arg_199_1.actors_["1019ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1019ui_story == nil then
				arg_199_1.var_.characterEffect1019ui_story = var_202_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_3 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.characterEffect1019ui_story and not isNil(var_202_2) then
					arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_3)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1019ui_story then
				arg_199_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_202_4 = 0
			local var_202_5 = 0.675

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(1102704049)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 27 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 27)

				if (27 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 27)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704049", "story_v_side_new_1102704.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704049", "story_v_side_new_1102704.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_side_new_1102704", "1102704049", "story_v_side_new_1102704.awb")

						arg_199_1:RecordAudio("1102704049", var_202_11)
						arg_199_1:RecordAudio("1102704049", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704049", "story_v_side_new_1102704.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704049", "story_v_side_new_1102704.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1102704050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1102704050
		arg_203_1.duration_ = 11.43

		local var_203_0 = {
			ja = 11.433,
			ko = 6.466,
			zh = 6.466
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1102704051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1019ui_story = arg_203_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).z)
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles = arg_203_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1019ui_story"].transform.position).z)
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1019ui_story"].transform.localEulerAngles = arg_203_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1019ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1019ui_story == nil then
				arg_203_1.var_.characterEffect1019ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1019ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_2)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1019ui_story then
				arg_203_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_206_3 = arg_203_1.actors_["1084ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1084ui_story = var_206_3.localPosition
			end

			local var_206_4 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				var_206_3.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_203_1.time_ - 0) / var_206_4)
				var_206_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_3.position).x, (manager.ui.mainCamera.transform.position - var_206_3.position).y, (manager.ui.mainCamera.transform.position - var_206_3.position).z)
				var_206_3.localEulerAngles.z = 0
				var_206_3.localEulerAngles.x = 0
				var_206_3.localEulerAngles = var_206_3.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				var_206_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_206_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_3.position).x, (manager.ui.mainCamera.transform.position - var_206_3.position).y, (manager.ui.mainCamera.transform.position - var_206_3.position).z)
				var_206_3.localEulerAngles.z = 0
				var_206_3.localEulerAngles.x = 0
				var_206_3.localEulerAngles = var_206_3.localEulerAngles
			end

			local var_206_5 = arg_203_1.actors_["1084ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_5) and arg_203_1.var_.characterEffect1084ui_story == nil then
				arg_203_1.var_.characterEffect1084ui_story = var_206_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_6 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_6 and not isNil(var_206_5) then
				if arg_203_1.var_.characterEffect1084ui_story and not isNil(var_206_5) then
					arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_6 and arg_203_1.time_ < 0 + var_206_6 + arg_206_0 and not isNil(var_206_5) and arg_203_1.var_.characterEffect1084ui_story then
				arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_8 = arg_203_1.actors_["1027ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_8) and arg_203_1.var_.characterEffect1027ui_story == nil then
				arg_203_1.var_.characterEffect1027ui_story = var_206_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_9 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_9 and not isNil(var_206_8) then
				if arg_203_1.var_.characterEffect1027ui_story and not isNil(var_206_8) then
					arg_203_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_9)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_9 and arg_203_1.time_ < 0 + var_206_9 + arg_206_0 and not isNil(var_206_8) and arg_203_1.var_.characterEffect1027ui_story then
				arg_203_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_206_10 = 0
			local var_206_11 = 0.8

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_12 = arg_203_1:GetWordFromCfg(1102704050)
				local var_206_13 = arg_203_1:FormatText(var_206_12.content)

				arg_203_1.text_.text = var_206_13

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_15 = 32 <= 0 and var_206_11 or var_206_11 * (utf8.len(var_206_13) / 32)

				if (32 <= 0 and var_206_11 or var_206_11 * (utf8.len(var_206_13) / 32)) > 0 and var_206_11 < var_206_15 then
					arg_203_1.talkMaxDuration = var_206_15

					if var_206_15 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_15 + var_206_10
					end
				end

				arg_203_1.text_.text = var_206_13
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704050", "story_v_side_new_1102704.awb") ~= 0 then
					local var_206_16 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704050", "story_v_side_new_1102704.awb") / 1000

					if var_206_16 + var_206_10 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_16 + var_206_10
					end

					if var_206_12.prefab_name ~= "" and arg_203_1.actors_[var_206_12.prefab_name] ~= nil then
						local var_206_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_12.prefab_name].transform, "story_v_side_new_1102704", "1102704050", "story_v_side_new_1102704.awb")

						arg_203_1:RecordAudio("1102704050", var_206_17)
						arg_203_1:RecordAudio("1102704050", var_206_17)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704050", "story_v_side_new_1102704.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704050", "story_v_side_new_1102704.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_18 = math.max(var_206_11, arg_203_1.talkMaxDuration)

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_18 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_10) / var_206_18

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_10 + var_206_18 and arg_203_1.time_ < var_206_10 + var_206_18 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
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
	Play1102704051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1102704051
		arg_207_1.duration_ = 8.23

		local var_207_0 = {
			ja = 6.266,
			ko = 8.233,
			zh = 8.233
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1102704052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_210_0 = 0
			local var_210_1 = 0.975

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(1102704051)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 39 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 39)

				if (39 <= 0 and var_210_1 or var_210_1 * (utf8.len(var_210_3) / 39)) > 0 and var_210_1 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704051", "story_v_side_new_1102704.awb") ~= 0 then
					local var_210_6 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704051", "story_v_side_new_1102704.awb") / 1000

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end

					if var_210_2.prefab_name ~= "" and arg_207_1.actors_[var_210_2.prefab_name] ~= nil then
						local var_210_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_2.prefab_name].transform, "story_v_side_new_1102704", "1102704051", "story_v_side_new_1102704.awb")

						arg_207_1:RecordAudio("1102704051", var_210_7)
						arg_207_1:RecordAudio("1102704051", var_210_7)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704051", "story_v_side_new_1102704.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704051", "story_v_side_new_1102704.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_8 and arg_207_1.time_ < var_210_0 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1102704052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1102704052
		arg_211_1.duration_ = 2.73

		local var_211_0 = {
			ja = 2.733,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1102704053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1027ui_story"]) and arg_211_1.var_.characterEffect1027ui_story == nil then
				arg_211_1.var_.characterEffect1027ui_story = arg_211_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1027ui_story"]) then
				if arg_211_1.var_.characterEffect1027ui_story and not isNil(arg_211_1.actors_["1027ui_story"]) then
					arg_211_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1027ui_story"]) and arg_211_1.var_.characterEffect1027ui_story then
				arg_211_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action462")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_2 = arg_211_1.actors_["1084ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1084ui_story == nil then
				arg_211_1.var_.characterEffect1084ui_story = var_214_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_3 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.characterEffect1084ui_story and not isNil(var_214_2) then
					arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_3)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.characterEffect1084ui_story then
				arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_214_4 = 0
			local var_214_5 = 0.075

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(1102704052)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 3 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 3)

				if (3 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 3)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704052", "story_v_side_new_1102704.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704052", "story_v_side_new_1102704.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_side_new_1102704", "1102704052", "story_v_side_new_1102704.awb")

						arg_211_1:RecordAudio("1102704052", var_214_11)
						arg_211_1:RecordAudio("1102704052", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704052", "story_v_side_new_1102704.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704052", "story_v_side_new_1102704.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1102704053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1102704053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1102704054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1027ui_story = arg_215_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1027ui_story"].transform.position).z)
				arg_215_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1027ui_story"].transform.localEulerAngles = arg_215_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1027ui_story"].transform.position).z)
				arg_215_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1027ui_story"].transform.localEulerAngles = arg_215_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1027ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1027ui_story == nil then
				arg_215_1.var_.characterEffect1027ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1027ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_2)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1027ui_story then
				arg_215_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_218_3 = arg_215_1.actors_["1084ui_story"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1084ui_story = var_218_3.localPosition
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_3.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 0) / var_218_4)
				var_218_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_3.position).x, (manager.ui.mainCamera.transform.position - var_218_3.position).y, (manager.ui.mainCamera.transform.position - var_218_3.position).z)
				var_218_3.localEulerAngles.z = 0
				var_218_3.localEulerAngles.x = 0
				var_218_3.localEulerAngles = var_218_3.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_3.localPosition = Vector3.New(0, 100, 0)
				var_218_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_3.position).x, (manager.ui.mainCamera.transform.position - var_218_3.position).y, (manager.ui.mainCamera.transform.position - var_218_3.position).z)
				var_218_3.localEulerAngles.z = 0
				var_218_3.localEulerAngles.x = 0
				var_218_3.localEulerAngles = var_218_3.localEulerAngles
			end

			local var_218_5 = arg_215_1.actors_["1084ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_5) and arg_215_1.var_.characterEffect1084ui_story == nil then
				arg_215_1.var_.characterEffect1084ui_story = var_218_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_6 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 and not isNil(var_218_5) then
				if arg_215_1.var_.characterEffect1084ui_story and not isNil(var_218_5) then
					arg_215_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_6)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 and not isNil(var_218_5) and arg_215_1.var_.characterEffect1084ui_story then
				arg_215_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_218_7 = 0
			local var_218_8 = 1.1

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_9 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1102704053).content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 44 <= 0 and var_218_8 or var_218_8 * (utf8.len(var_218_9) / 44)

				if (44 <= 0 and var_218_8 or var_218_8 * (utf8.len(var_218_9) / 44)) > 0 and var_218_8 < var_218_11 then
					arg_215_1.talkMaxDuration = var_218_11

					if var_218_11 + var_218_7 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_7
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_12 = math.max(var_218_8, arg_215_1.talkMaxDuration)

			if var_218_7 <= arg_215_1.time_ and arg_215_1.time_ < var_218_7 + var_218_12 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_7) / var_218_12

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_7 + var_218_12 and arg_215_1.time_ < var_218_7 + var_218_12 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play1102704054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1102704054
		arg_219_1.duration_ = 4

		local var_219_0 = {
			ja = 3.5,
			ko = 4,
			zh = 4
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1102704055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1039ui_story = arg_219_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).z)
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles = arg_219_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				arg_219_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1039ui_story"].transform.position).z)
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1039ui_story"].transform.localEulerAngles = arg_219_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1039ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1039ui_story == nil then
				arg_219_1.var_.characterEffect1039ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1039ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1039ui_story then
				arg_219_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_222_4 = 0
			local var_222_5 = 0.325

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(1102704054)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 13 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 13)

				if (13 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 13)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704054", "story_v_side_new_1102704.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704054", "story_v_side_new_1102704.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_side_new_1102704", "1102704054", "story_v_side_new_1102704.awb")

						arg_219_1:RecordAudio("1102704054", var_222_11)
						arg_219_1:RecordAudio("1102704054", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704054", "story_v_side_new_1102704.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704054", "story_v_side_new_1102704.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_12 and arg_219_1.time_ < var_222_4 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
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

		arg_219_1:InitPlayNodeList()
	end,
	Play1102704055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1102704055
		arg_223_1.duration_ = 11.7

		local var_223_0 = {
			ja = 7.333,
			ko = 11.7,
			zh = 11.7
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1102704056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1027ui_story = arg_223_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).z)
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles = arg_223_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_223_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1027ui_story"].transform.position).z)
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1027ui_story"].transform.localEulerAngles = arg_223_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1027ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1027ui_story == nil then
				arg_223_1.var_.characterEffect1027ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1027ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1027ui_story then
				arg_223_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_226_4 = arg_223_1.actors_["1039ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect1039ui_story == nil then
				arg_223_1.var_.characterEffect1039ui_story = var_226_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_5 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_5 and not isNil(var_226_4) then
				if arg_223_1.var_.characterEffect1039ui_story and not isNil(var_226_4) then
					arg_223_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_5)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_5 and arg_223_1.time_ < 0 + var_226_5 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect1039ui_story then
				arg_223_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_226_6 = 0
			local var_226_7 = 1.2

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(1102704055)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 48 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 48)

				if (48 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 48)) > 0 and var_226_7 < var_226_11 then
					arg_223_1.talkMaxDuration = var_226_11

					if var_226_11 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704055", "story_v_side_new_1102704.awb") ~= 0 then
					local var_226_12 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704055", "story_v_side_new_1102704.awb") / 1000

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end

					if var_226_8.prefab_name ~= "" and arg_223_1.actors_[var_226_8.prefab_name] ~= nil then
						local var_226_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_8.prefab_name].transform, "story_v_side_new_1102704", "1102704055", "story_v_side_new_1102704.awb")

						arg_223_1:RecordAudio("1102704055", var_226_13)
						arg_223_1:RecordAudio("1102704055", var_226_13)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704055", "story_v_side_new_1102704.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704055", "story_v_side_new_1102704.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play1102704056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1102704056
		arg_227_1.duration_ = 5.13

		local var_227_0 = {
			ja = 4.833,
			ko = 5.133,
			zh = 5.133
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1102704057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_0 = 0
			local var_230_1 = 0.275

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_2 = arg_227_1:GetWordFromCfg(1102704056)
				local var_230_3 = arg_227_1:FormatText(var_230_2.content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 11 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 11)

				if (11 <= 0 and var_230_1 or var_230_1 * (utf8.len(var_230_3) / 11)) > 0 and var_230_1 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704056", "story_v_side_new_1102704.awb") ~= 0 then
					local var_230_6 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704056", "story_v_side_new_1102704.awb") / 1000

					if var_230_6 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_6 + var_230_0
					end

					if var_230_2.prefab_name ~= "" and arg_227_1.actors_[var_230_2.prefab_name] ~= nil then
						local var_230_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_2.prefab_name].transform, "story_v_side_new_1102704", "1102704056", "story_v_side_new_1102704.awb")

						arg_227_1:RecordAudio("1102704056", var_230_7)
						arg_227_1:RecordAudio("1102704056", var_230_7)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704056", "story_v_side_new_1102704.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704056", "story_v_side_new_1102704.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_8 and arg_227_1.time_ < var_230_0 + var_230_8 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1102704057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1102704057
		arg_231_1.duration_ = 2.6

		local var_231_0 = {
			ja = 2.6,
			ko = 2.133,
			zh = 2.133
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1102704058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1039ui_story = arg_231_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1039ui_story"].transform.position).z)
				arg_231_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1039ui_story"].transform.localEulerAngles = arg_231_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1039ui_story"].transform.position).z)
				arg_231_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1039ui_story"].transform.localEulerAngles = arg_231_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1039ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1039ui_story == nil then
				arg_231_1.var_.characterEffect1039ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1039ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_2)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1039ui_story then
				arg_231_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_234_3 = arg_231_1.actors_["1080ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1080ui_story = var_234_3.localPosition
			end

			local var_234_4 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 then
				var_234_3.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1080ui_story, Vector3.New(-0.7, -1.01, -6.05), (arg_231_1.time_ - 0) / var_234_4)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 then
				var_234_3.localPosition = Vector3.New(-0.7, -1.01, -6.05)
				var_234_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_3.position).x, (manager.ui.mainCamera.transform.position - var_234_3.position).y, (manager.ui.mainCamera.transform.position - var_234_3.position).z)
				var_234_3.localEulerAngles.z = 0
				var_234_3.localEulerAngles.x = 0
				var_234_3.localEulerAngles = var_234_3.localEulerAngles
			end

			local var_234_5 = arg_231_1.actors_["1080ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1080ui_story == nil then
				arg_231_1.var_.characterEffect1080ui_story = var_234_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_6 and not isNil(var_234_5) then
				if arg_231_1.var_.characterEffect1080ui_story and not isNil(var_234_5) then
					arg_231_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_6 and arg_231_1.time_ < 0 + var_234_6 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1080ui_story then
				arg_231_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action1_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_234_8 = arg_231_1.actors_["1027ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.characterEffect1027ui_story == nil then
				arg_231_1.var_.characterEffect1027ui_story = var_234_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_9 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_9 and not isNil(var_234_8) then
				if arg_231_1.var_.characterEffect1027ui_story and not isNil(var_234_8) then
					arg_231_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_9)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_9 and arg_231_1.time_ < 0 + var_234_9 + arg_234_0 and not isNil(var_234_8) and arg_231_1.var_.characterEffect1027ui_story then
				arg_231_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_234_10 = 0
			local var_234_11 = 0.225

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_12 = arg_231_1:GetWordFromCfg(1102704057)
				local var_234_13 = arg_231_1:FormatText(var_234_12.content)

				arg_231_1.text_.text = var_234_13

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_15 = 9 <= 0 and var_234_11 or var_234_11 * (utf8.len(var_234_13) / 9)

				if (9 <= 0 and var_234_11 or var_234_11 * (utf8.len(var_234_13) / 9)) > 0 and var_234_11 < var_234_15 then
					arg_231_1.talkMaxDuration = var_234_15

					if var_234_15 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_10
					end
				end

				arg_231_1.text_.text = var_234_13
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704057", "story_v_side_new_1102704.awb") ~= 0 then
					local var_234_16 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704057", "story_v_side_new_1102704.awb") / 1000

					if var_234_16 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_16 + var_234_10
					end

					if var_234_12.prefab_name ~= "" and arg_231_1.actors_[var_234_12.prefab_name] ~= nil then
						local var_234_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_12.prefab_name].transform, "story_v_side_new_1102704", "1102704057", "story_v_side_new_1102704.awb")

						arg_231_1:RecordAudio("1102704057", var_234_17)
						arg_231_1:RecordAudio("1102704057", var_234_17)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704057", "story_v_side_new_1102704.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704057", "story_v_side_new_1102704.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_18 = math.max(var_234_11, arg_231_1.talkMaxDuration)

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_18 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_10) / var_234_18

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_10 + var_234_18 and arg_231_1.time_ < var_234_10 + var_234_18 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play1102704058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1102704058
		arg_235_1.duration_ = 12.67

		local var_235_0 = {
			ja = 11.166,
			ko = 12.666,
			zh = 12.666
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
				arg_235_0:Play1102704059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1027ui_story"]) and arg_235_1.var_.characterEffect1027ui_story == nil then
				arg_235_1.var_.characterEffect1027ui_story = arg_235_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1027ui_story"]) then
				if arg_235_1.var_.characterEffect1027ui_story and not isNil(arg_235_1.actors_["1027ui_story"]) then
					arg_235_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1027ui_story"]) and arg_235_1.var_.characterEffect1027ui_story then
				arg_235_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_238_2 = arg_235_1.actors_["1080ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1080ui_story == nil then
				arg_235_1.var_.characterEffect1080ui_story = var_238_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_3 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.characterEffect1080ui_story and not isNil(var_238_2) then
					arg_235_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_3)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.characterEffect1080ui_story then
				arg_235_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_238_4 = 0
			local var_238_5 = 1.075

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_6 = arg_235_1:GetWordFromCfg(1102704058)
				local var_238_7 = arg_235_1:FormatText(var_238_6.content)

				arg_235_1.text_.text = var_238_7

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_9 = 44 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 44)

				if (44 <= 0 and var_238_5 or var_238_5 * (utf8.len(var_238_7) / 44)) > 0 and var_238_5 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_4
					end
				end

				arg_235_1.text_.text = var_238_7
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704058", "story_v_side_new_1102704.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704058", "story_v_side_new_1102704.awb") / 1000

					if var_238_10 + var_238_4 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_4
					end

					if var_238_6.prefab_name ~= "" and arg_235_1.actors_[var_238_6.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_6.prefab_name].transform, "story_v_side_new_1102704", "1102704058", "story_v_side_new_1102704.awb")

						arg_235_1:RecordAudio("1102704058", var_238_11)
						arg_235_1:RecordAudio("1102704058", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704058", "story_v_side_new_1102704.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704058", "story_v_side_new_1102704.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_5, arg_235_1.talkMaxDuration)

			if var_238_4 <= arg_235_1.time_ and arg_235_1.time_ < var_238_4 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_4) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_4 + var_238_12 and arg_235_1.time_ < var_238_4 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1102704059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1102704059
		arg_239_1.duration_ = 9.03

		local var_239_0 = {
			ja = 6.4,
			ko = 9.033,
			zh = 9.033
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1102704060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["1027ui_story"]) and arg_239_1.var_.characterEffect1027ui_story == nil then
				arg_239_1.var_.characterEffect1027ui_story = arg_239_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_0 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["1027ui_story"]) then
				if arg_239_1.var_.characterEffect1027ui_story and not isNil(arg_239_1.actors_["1027ui_story"]) then
					arg_239_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_0)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["1027ui_story"]) and arg_239_1.var_.characterEffect1027ui_story then
				arg_239_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_242_1 = 0
			local var_242_2 = 0.925

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[203].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10013")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(1102704059)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 37 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_4) / 37)

				if (37 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_4) / 37)) > 0 and var_242_2 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704059", "story_v_side_new_1102704.awb") ~= 0 then
					local var_242_7 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704059", "story_v_side_new_1102704.awb") / 1000

					if var_242_7 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_1
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_side_new_1102704", "1102704059", "story_v_side_new_1102704.awb")

						arg_239_1:RecordAudio("1102704059", var_242_8)
						arg_239_1:RecordAudio("1102704059", var_242_8)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704059", "story_v_side_new_1102704.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704059", "story_v_side_new_1102704.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_9 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_9 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_9

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_9 and arg_239_1.time_ < var_242_1 + var_242_9 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1102704060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1102704060
		arg_243_1.duration_ = 4.57

		local var_243_0 = {
			ja = 4.433,
			ko = 4.566,
			zh = 4.566
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1102704061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1027ui_story"]) and arg_243_1.var_.characterEffect1027ui_story == nil then
				arg_243_1.var_.characterEffect1027ui_story = arg_243_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1027ui_story"]) then
				if arg_243_1.var_.characterEffect1027ui_story and not isNil(arg_243_1.actors_["1027ui_story"]) then
					arg_243_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1027ui_story"]) and arg_243_1.var_.characterEffect1027ui_story then
				arg_243_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_246_2 = 0
			local var_246_3 = 0.475

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:GetWordFromCfg(1102704060)
				local var_246_5 = arg_243_1:FormatText(var_246_4.content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 19 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 19)

				if (19 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 19)) > 0 and var_246_3 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704060", "story_v_side_new_1102704.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704060", "story_v_side_new_1102704.awb") / 1000

					if var_246_8 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_2
					end

					if var_246_4.prefab_name ~= "" and arg_243_1.actors_[var_246_4.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_4.prefab_name].transform, "story_v_side_new_1102704", "1102704060", "story_v_side_new_1102704.awb")

						arg_243_1:RecordAudio("1102704060", var_246_9)
						arg_243_1:RecordAudio("1102704060", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704060", "story_v_side_new_1102704.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704060", "story_v_side_new_1102704.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_10 and arg_243_1.time_ < var_246_2 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1102704061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1102704061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1102704062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1027ui_story"]) and arg_247_1.var_.characterEffect1027ui_story == nil then
				arg_247_1.var_.characterEffect1027ui_story = arg_247_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1027ui_story"]) then
				if arg_247_1.var_.characterEffect1027ui_story and not isNil(arg_247_1.actors_["1027ui_story"]) then
					arg_247_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1027ui_story"]) and arg_247_1.var_.characterEffect1027ui_story then
				arg_247_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.475

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(1102704061).content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 19 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 19)

				if (19 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_3) / 19)) > 0 and var_250_2 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_6 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_6 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_6

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_6 and arg_247_1.time_ < var_250_1 + var_250_6 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1102704062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1102704062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1102704063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.875

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(1102704062).content)

				arg_251_1.text_.text = var_254_1

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_3 = 35 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 35)

				if (35 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_1) / 35)) > 0 and var_254_0 < var_254_3 then
					arg_251_1.talkMaxDuration = var_254_3

					if var_254_3 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_3 + 0
					end
				end

				arg_251_1.text_.text = var_254_1
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_4 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_4

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1102704063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1102704063
		arg_255_1.duration_ = 5.53

		local var_255_0 = {
			ja = 5.366,
			ko = 5.533,
			zh = 5.533
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1102704064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1080ui_story = arg_255_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1080ui_story"].transform.position).z)
				arg_255_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1080ui_story"].transform.localEulerAngles = arg_255_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1080ui_story"].transform.position).z)
				arg_255_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1080ui_story"].transform.localEulerAngles = arg_255_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1080ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1080ui_story == nil then
				arg_255_1.var_.characterEffect1080ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1080ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_2)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1080ui_story then
				arg_255_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_258_3 = arg_255_1.actors_["1039ui_story"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1039ui_story = var_258_3.localPosition
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_3.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_255_1.time_ - 0) / var_258_4)
				var_258_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_3.position).x, (manager.ui.mainCamera.transform.position - var_258_3.position).y, (manager.ui.mainCamera.transform.position - var_258_3.position).z)
				var_258_3.localEulerAngles.z = 0
				var_258_3.localEulerAngles.x = 0
				var_258_3.localEulerAngles = var_258_3.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_3.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_258_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_3.position).x, (manager.ui.mainCamera.transform.position - var_258_3.position).y, (manager.ui.mainCamera.transform.position - var_258_3.position).z)
				var_258_3.localEulerAngles.z = 0
				var_258_3.localEulerAngles.x = 0
				var_258_3.localEulerAngles = var_258_3.localEulerAngles
			end

			local var_258_5 = arg_255_1.actors_["1039ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect1039ui_story == nil then
				arg_255_1.var_.characterEffect1039ui_story = var_258_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_6 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_6 and not isNil(var_258_5) then
				if arg_255_1.var_.characterEffect1039ui_story and not isNil(var_258_5) then
					arg_255_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_6 and arg_255_1.time_ < 0 + var_258_6 + arg_258_0 and not isNil(var_258_5) and arg_255_1.var_.characterEffect1039ui_story then
				arg_255_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_258_8 = 0
			local var_258_9 = 0.85

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_10 = arg_255_1:GetWordFromCfg(1102704063)
				local var_258_11 = arg_255_1:FormatText(var_258_10.content)

				arg_255_1.text_.text = var_258_11

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 34 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 34)

				if (34 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 34)) > 0 and var_258_9 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_11
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704063", "story_v_side_new_1102704.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704063", "story_v_side_new_1102704.awb") / 1000

					if var_258_14 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_8
					end

					if var_258_10.prefab_name ~= "" and arg_255_1.actors_[var_258_10.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_10.prefab_name].transform, "story_v_side_new_1102704", "1102704063", "story_v_side_new_1102704.awb")

						arg_255_1:RecordAudio("1102704063", var_258_15)
						arg_255_1:RecordAudio("1102704063", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704063", "story_v_side_new_1102704.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704063", "story_v_side_new_1102704.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_16 and arg_255_1.time_ < var_258_8 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_255_1:InitPlayNodeList()
	end,
	Play1102704064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1102704064
		arg_259_1.duration_ = 4.9

		local var_259_0 = {
			ja = 4.9,
			ko = 2.866,
			zh = 2.866
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
				arg_259_0:Play1102704065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1027ui_story"]) and arg_259_1.var_.characterEffect1027ui_story == nil then
				arg_259_1.var_.characterEffect1027ui_story = arg_259_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1027ui_story"]) then
				if arg_259_1.var_.characterEffect1027ui_story and not isNil(arg_259_1.actors_["1027ui_story"]) then
					arg_259_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1027ui_story"]) and arg_259_1.var_.characterEffect1027ui_story then
				arg_259_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_2 = arg_259_1.actors_["1039ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1039ui_story == nil then
				arg_259_1.var_.characterEffect1039ui_story = var_262_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_3 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.characterEffect1039ui_story and not isNil(var_262_2) then
					arg_259_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_3)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.characterEffect1039ui_story then
				arg_259_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_262_4 = 0
			local var_262_5 = 0.35

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_6 = arg_259_1:GetWordFromCfg(1102704064)
				local var_262_7 = arg_259_1:FormatText(var_262_6.content)

				arg_259_1.text_.text = var_262_7

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_9 = 14 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 14)

				if (14 <= 0 and var_262_5 or var_262_5 * (utf8.len(var_262_7) / 14)) > 0 and var_262_5 < var_262_9 then
					arg_259_1.talkMaxDuration = var_262_9

					if var_262_9 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_9 + var_262_4
					end
				end

				arg_259_1.text_.text = var_262_7
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704064", "story_v_side_new_1102704.awb") ~= 0 then
					local var_262_10 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704064", "story_v_side_new_1102704.awb") / 1000

					if var_262_10 + var_262_4 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_4
					end

					if var_262_6.prefab_name ~= "" and arg_259_1.actors_[var_262_6.prefab_name] ~= nil then
						local var_262_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_6.prefab_name].transform, "story_v_side_new_1102704", "1102704064", "story_v_side_new_1102704.awb")

						arg_259_1:RecordAudio("1102704064", var_262_11)
						arg_259_1:RecordAudio("1102704064", var_262_11)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704064", "story_v_side_new_1102704.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704064", "story_v_side_new_1102704.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_12 = math.max(var_262_5, arg_259_1.talkMaxDuration)

			if var_262_4 <= arg_259_1.time_ and arg_259_1.time_ < var_262_4 + var_262_12 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_4) / var_262_12

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_4 + var_262_12 and arg_259_1.time_ < var_262_4 + var_262_12 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1102704065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1102704065
		arg_263_1.duration_ = 5.68

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1102704066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if arg_263_1.bgs_.STblack == nil then
				local var_266_0 = Object.Instantiate(arg_263_1.paintGo_)

				var_266_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_266_0.name = "STblack"
				var_266_0.transform.parent = arg_263_1.stage_.transform
				var_266_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.bgs_.STblack = var_266_0
			end

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 then
				local var_266_1 = arg_263_1.bgs_.STblack

				arg_263_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_2 = var_266_1:GetComponent("SpriteRenderer")

				if var_266_2 and var_266_2.sprite then
					local var_266_3 = 2 * (var_266_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_1.transform.localScale = Vector3.New(var_266_3 / var_266_2.sprite.bounds.size.y < var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x and var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x or var_266_3 / var_266_2.sprite.bounds.size.y, var_266_3 / var_266_2.sprite.bounds.size.y < var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x and var_266_3 * manager.ui.mainCameraCom_.aspect / var_266_2.sprite.bounds.size.x or var_266_3 / var_266_2.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "STblack" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_4 = arg_263_1.actors_["1027ui_story"].transform

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 then
				arg_263_1.var_.moveOldPos1027ui_story = var_266_4.localPosition
			end

			local var_266_5 = 0.001

			if 1.96599999815226 <= arg_263_1.time_ and arg_263_1.time_ < 1.96599999815226 + var_266_5 then
				var_266_4.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 1.96599999815226) / var_266_5)
				var_266_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_4.position).x, (manager.ui.mainCamera.transform.position - var_266_4.position).y, (manager.ui.mainCamera.transform.position - var_266_4.position).z)
				var_266_4.localEulerAngles.z = 0
				var_266_4.localEulerAngles.x = 0
				var_266_4.localEulerAngles = var_266_4.localEulerAngles
			end

			if arg_263_1.time_ >= 1.96599999815226 + var_266_5 and arg_263_1.time_ < 1.96599999815226 + var_266_5 + arg_266_0 then
				var_266_4.localPosition = Vector3.New(0, 100, 0)
				var_266_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_4.position).x, (manager.ui.mainCamera.transform.position - var_266_4.position).y, (manager.ui.mainCamera.transform.position - var_266_4.position).z)
				var_266_4.localEulerAngles.z = 0
				var_266_4.localEulerAngles.x = 0
				var_266_4.localEulerAngles = var_266_4.localEulerAngles
			end

			local var_266_6 = arg_263_1.actors_["1027ui_story"]

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 and not isNil(var_266_6) and arg_263_1.var_.characterEffect1027ui_story == nil then
				arg_263_1.var_.characterEffect1027ui_story = var_266_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_7 = 0.034000001847744

			if 1.96599999815226 <= arg_263_1.time_ and arg_263_1.time_ < 1.96599999815226 + var_266_7 and not isNil(var_266_6) then
				if arg_263_1.var_.characterEffect1027ui_story and not isNil(var_266_6) then
					arg_263_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 1.96599999815226) / var_266_7)
				end
			end

			if arg_263_1.time_ >= 1.96599999815226 + var_266_7 and arg_263_1.time_ < 1.96599999815226 + var_266_7 + arg_266_0 and not isNil(var_266_6) and arg_263_1.var_.characterEffect1027ui_story then
				arg_263_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_266_8 = arg_263_1.actors_["1039ui_story"].transform

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 then
				arg_263_1.var_.moveOldPos1039ui_story = var_266_8.localPosition
			end

			local var_266_9 = 0.001

			if 1.96599999815226 <= arg_263_1.time_ and arg_263_1.time_ < 1.96599999815226 + var_266_9 then
				var_266_8.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 1.96599999815226) / var_266_9)
				var_266_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_8.position).x, (manager.ui.mainCamera.transform.position - var_266_8.position).y, (manager.ui.mainCamera.transform.position - var_266_8.position).z)
				var_266_8.localEulerAngles.z = 0
				var_266_8.localEulerAngles.x = 0
				var_266_8.localEulerAngles = var_266_8.localEulerAngles
			end

			if arg_263_1.time_ >= 1.96599999815226 + var_266_9 and arg_263_1.time_ < 1.96599999815226 + var_266_9 + arg_266_0 then
				var_266_8.localPosition = Vector3.New(0, 100, 0)
				var_266_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_8.position).x, (manager.ui.mainCamera.transform.position - var_266_8.position).y, (manager.ui.mainCamera.transform.position - var_266_8.position).z)
				var_266_8.localEulerAngles.z = 0
				var_266_8.localEulerAngles.x = 0
				var_266_8.localEulerAngles = var_266_8.localEulerAngles
			end

			local var_266_10 = arg_263_1.actors_["1039ui_story"]

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 and not isNil(var_266_10) and arg_263_1.var_.characterEffect1039ui_story == nil then
				arg_263_1.var_.characterEffect1039ui_story = var_266_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.034000001847744

			if 1.96599999815226 <= arg_263_1.time_ and arg_263_1.time_ < 1.96599999815226 + var_266_11 and not isNil(var_266_10) then
				if arg_263_1.var_.characterEffect1039ui_story and not isNil(var_266_10) then
					arg_263_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 1.96599999815226) / var_266_11)
				end
			end

			if arg_263_1.time_ >= 1.96599999815226 + var_266_11 and arg_263_1.time_ < 1.96599999815226 + var_266_11 + arg_266_0 and not isNil(var_266_10) and arg_263_1.var_.characterEffect1039ui_story then
				arg_263_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_266_12 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_12 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_13 = 2

			if var_266_12 <= arg_263_1.time_ and arg_263_1.time_ < var_266_12 + var_266_13 then
				local var_266_14 = Color.New(0, 0, 0)

				var_266_14.a = Mathf.Lerp(0, 1, (arg_263_1.time_ - var_266_12) / var_266_13)
				arg_263_1.mask_.color = var_266_14
			end

			if arg_263_1.time_ >= var_266_12 + var_266_13 and arg_263_1.time_ < var_266_12 + var_266_13 + arg_266_0 then
				local var_266_15 = Color.New(0, 0, 0)

				var_266_15.a = 1
				arg_263_1.mask_.color = var_266_15
			end

			local var_266_16 = 2

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_16 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_17 = 2

			if var_266_16 <= arg_263_1.time_ and arg_263_1.time_ < var_266_16 + var_266_17 then
				local var_266_18 = Color.New(0, 0, 0)

				var_266_18.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_16) / var_266_17)
				arg_263_1.mask_.color = var_266_18
			end

			if arg_263_1.time_ >= var_266_16 + var_266_17 and arg_263_1.time_ < var_266_16 + var_266_17 + arg_266_0 then
				local var_266_19 = Color.New(0, 0, 0)

				arg_263_1.mask_.enabled = false
				var_266_19.a = 0
				arg_263_1.mask_.color = var_266_19
			end

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				arg_263_1.fswbg_:SetActive(true)
				arg_263_1.dialog_:SetActive(false)

				arg_263_1.fswtw_.percent = 0
				arg_263_1.fswt_.text = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1102704065).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.fswt_)

				arg_263_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_263_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_263_1.fswtw_:SetDirty()

				arg_263_1.typewritterCharCountI18N = 0

				SetActive(arg_263_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_263_1:ShowNextGo(false)
			end

			local var_266_20 = 2.01666666666667

			if 2.01666666666667 < arg_263_1.time_ and arg_263_1.time_ <= var_266_20 + arg_266_0 then
				arg_263_1.var_.oldValueTypewriter = arg_263_1.fswtw_.percent

				SetActive(arg_263_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_263_1:ShowNextGo(false)
			end

			local var_266_21 = 55
			local var_266_22 = 3.66666666666667
			local var_266_23, var_266_24 = arg_263_1:GetPercentByPara(arg_263_1:FormatText(arg_263_1:GetWordFromCfg(1102704065).content), 1)

			if var_266_20 < arg_263_1.time_ and arg_263_1.time_ <= var_266_20 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				local var_266_25 = var_266_21 <= 0 and var_266_22 or var_266_22 * ((var_266_24 - arg_263_1.typewritterCharCountI18N) / var_266_21)

				if (var_266_21 <= 0 and var_266_22 or var_266_22 * ((var_266_24 - arg_263_1.typewritterCharCountI18N) / var_266_21)) > 0 and var_266_22 < var_266_25 then
					arg_263_1.talkMaxDuration = var_266_25

					if var_266_25 + var_266_20 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_25 + var_266_20
					end
				end
			end

			local var_266_26 = math.max(3.66666666666667, arg_263_1.talkMaxDuration)

			if var_266_20 <= arg_263_1.time_ and arg_263_1.time_ < var_266_20 + var_266_26 then
				arg_263_1.fswtw_.percent = Mathf.Lerp(arg_263_1.var_.oldValueTypewriter, var_266_23, (arg_263_1.time_ - var_266_20) / var_266_26)
				arg_263_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_263_1.fswtw_:SetDirty()
			end

			if arg_263_1.time_ >= var_266_20 + var_266_26 and arg_263_1.time_ < var_266_20 + var_266_26 + arg_266_0 then
				arg_263_1.fswtw_.percent = var_266_23

				arg_263_1.fswtw_:SetDirty()
				arg_263_1:ShowNextGo(true)

				arg_263_1.typewritterCharCountI18N = var_266_24
			end

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= 2 + arg_266_0 then
				local var_266_27 = arg_263_1.fswbg_.transform:Find("textbox/adapt/content") or arg_263_1.fswbg_.transform:Find("textbox/content")
				local var_266_28 = arg_263_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_266_29 = var_266_27:GetComponent("RectTransform")

				var_266_27:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_266_29.offsetMin = Vector2.New(0, 0)
				var_266_29.offsetMax = Vector2.New(0, 0)
			end

			if 1.96599999815226 < arg_263_1.time_ and arg_263_1.time_ <= 1.96599999815226 + arg_266_0 then
				arg_263_1:AudioAction("play", "effect", "se_story_side_1027", "se_story_side_1027_treat", "")
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_263_1:InitPlayNodeList()
	end,
	Play1102704066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1102704066
		arg_267_1.duration_ = 2.35

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1102704067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.fswbg_:SetActive(true)
				arg_267_1.dialog_:SetActive(false)

				arg_267_1.fswtw_.percent = 0
				arg_267_1.fswt_.text = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1102704066).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.fswt_)

				arg_267_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_267_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_267_1.fswtw_:SetDirty()

				arg_267_1.typewritterCharCountI18N = 0

				SetActive(arg_267_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_267_1:ShowNextGo(false)
			end

			local var_270_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.var_.oldValueTypewriter = arg_267_1.fswtw_.percent

				SetActive(arg_267_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_267_1:ShowNextGo(false)
			end

			local var_270_1 = 35
			local var_270_2 = 2.33333333333333
			local var_270_3, var_270_4 = arg_267_1:GetPercentByPara(arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1102704066).content), 1)

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0

				local var_270_5 = var_270_1 <= 0 and var_270_2 or var_270_2 * ((var_270_4 - arg_267_1.typewritterCharCountI18N) / var_270_1)

				if (var_270_1 <= 0 and var_270_2 or var_270_2 * ((var_270_4 - arg_267_1.typewritterCharCountI18N) / var_270_1)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_0
					end
				end
			end

			local var_270_6 = math.max(2.33333333333333, arg_267_1.talkMaxDuration)

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_6 then
				arg_267_1.fswtw_.percent = Mathf.Lerp(arg_267_1.var_.oldValueTypewriter, var_270_3, (arg_267_1.time_ - var_270_0) / var_270_6)
				arg_267_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_267_1.fswtw_:SetDirty()
			end

			if arg_267_1.time_ >= var_270_0 + var_270_6 and arg_267_1.time_ < var_270_0 + var_270_6 + arg_270_0 then
				arg_267_1.fswtw_.percent = var_270_3

				arg_267_1.fswtw_:SetDirty()
				arg_267_1:ShowNextGo(true)

				arg_267_1.typewritterCharCountI18N = var_270_4
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1102704067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1102704067
		arg_271_1.duration_ = 6.57

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1102704068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if arg_271_1.bgs_.R2701 == nil then
				local var_274_0 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R2701")
				var_274_0.name = "R2701"
				var_274_0.transform.parent = arg_271_1.stage_.transform
				var_274_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_.R2701 = var_274_0
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				local var_274_1 = arg_271_1.bgs_.R2701

				arg_271_1.bgs_.R2701.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_274_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_2 = var_274_1:GetComponent("SpriteRenderer")

				if var_274_2 and var_274_2.sprite then
					local var_274_3 = 2 * (var_274_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_274_1.transform.localScale = Vector3.New(var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "R2701" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_4 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_5 = 2

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_5 then
				local var_274_6 = Color.New(0, 0, 0)

				var_274_6.a = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_4) / var_274_5)
				arg_271_1.mask_.color = var_274_6
			end

			if arg_271_1.time_ >= var_274_4 + var_274_5 and arg_271_1.time_ < var_274_4 + var_274_5 + arg_274_0 then
				local var_274_7 = Color.New(0, 0, 0)

				arg_271_1.mask_.enabled = false
				var_274_7.a = 0
				arg_271_1.mask_.color = var_274_7
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.fswbg_:SetActive(false)
				arg_271_1.dialog_:SetActive(false)
				SetActive(arg_271_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_271_1:ShowNextGo(false)
			end

			local var_274_8 = arg_271_1.bgs_.R2701.transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPosR2701 = var_274_8.localPosition
			end

			local var_274_9 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_9 then
				var_274_8.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPosR2701, Vector3.New(-3.8, -0.2, 1.5), (arg_271_1.time_ - 0) / var_274_9)
			end

			if arg_271_1.time_ >= 0 + var_274_9 and arg_271_1.time_ < 0 + var_274_9 + arg_274_0 then
				var_274_8.localPosition = Vector3.New(-3.8, -0.2, 1.5)
			end

			local var_274_10 = arg_271_1.bgs_.R2701.transform

			if 0.0166666666666667 < arg_271_1.time_ and arg_271_1.time_ <= 0.0166666666666667 + arg_274_0 then
				arg_271_1.var_.moveOldPosR2701 = var_274_10.localPosition
			end

			local var_274_11 = 6

			if 0.0166666666666667 <= arg_271_1.time_ and arg_271_1.time_ < 0.0166666666666667 + var_274_11 then
				var_274_10.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPosR2701, Vector3.New(-3.8, -0.2, 2.5), (arg_271_1.time_ - 0.0166666666666667) / var_274_11)
			end

			if arg_271_1.time_ >= 0.0166666666666667 + var_274_11 and arg_271_1.time_ < 0.0166666666666667 + var_274_11 + arg_274_0 then
				var_274_10.localPosition = Vector3.New(-3.8, -0.2, 2.5)
			end

			local var_274_12 = 2.03400000184674

			if 2.03400000184674 < arg_271_1.time_ and arg_271_1.time_ <= var_274_12 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			if arg_271_1.time_ >= var_274_12 + 3.98266666481992 and arg_271_1.time_ < var_274_12 + 3.98266666481992 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_13 = 1.75
			local var_274_14 = 0.25

			if 1.75 < arg_271_1.time_ and arg_271_1.time_ <= var_274_13 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_15 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_15:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_16 = arg_271_1:GetWordFromCfg(1102704067)
				local var_274_17 = arg_271_1:FormatText(var_274_16.content)

				arg_271_1.text_.text = var_274_17

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_19 = 10 <= 0 and var_274_14 or var_274_14 * (utf8.len(var_274_17) / 10)

				if (10 <= 0 and var_274_14 or var_274_14 * (utf8.len(var_274_17) / 10)) > 0 and var_274_14 < var_274_19 then
					arg_271_1.talkMaxDuration = var_274_19
					var_274_13 = var_274_13 + 0.3

					if var_274_19 + var_274_13 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_19 + var_274_13
					end
				end

				arg_271_1.text_.text = var_274_17
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704067", "story_v_side_new_1102704.awb") ~= 0 then
					local var_274_20 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704067", "story_v_side_new_1102704.awb") / 1000

					if var_274_20 + var_274_13 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_20 + var_274_13
					end

					if var_274_16.prefab_name ~= "" and arg_271_1.actors_[var_274_16.prefab_name] ~= nil then
						local var_274_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_16.prefab_name].transform, "story_v_side_new_1102704", "1102704067", "story_v_side_new_1102704.awb")

						arg_271_1:RecordAudio("1102704067", var_274_21)
						arg_271_1:RecordAudio("1102704067", var_274_21)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704067", "story_v_side_new_1102704.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704067", "story_v_side_new_1102704.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_22 = var_274_13 + 0.3
			local var_274_23 = math.max(var_274_14, arg_271_1.talkMaxDuration)

			if var_274_13 + 0.3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_22 + var_274_23 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_22) / var_274_23

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_22 + var_274_23 and arg_271_1.time_ < var_274_22 + var_274_23 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R2701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R2701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play1102704068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1102704068
		arg_277_1.duration_ = 9.07

		local var_277_0 = {
			ja = 3.2,
			ko = 9.066,
			zh = 9.066
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1102704069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.675

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(1102704068)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 27 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 27)

				if (27 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 27)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704068", "story_v_side_new_1102704.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704068", "story_v_side_new_1102704.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_side_new_1102704", "1102704068", "story_v_side_new_1102704.awb")

						arg_277_1:RecordAudio("1102704068", var_280_6)
						arg_277_1:RecordAudio("1102704068", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704068", "story_v_side_new_1102704.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704068", "story_v_side_new_1102704.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1102704069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1102704069
		arg_281_1.duration_ = 9.8

		local var_281_0 = {
			ja = 9.8,
			ko = 5.933,
			zh = 5.933
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1102704070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.8

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(1102704069)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 32 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 32)

				if (32 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 32)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704069", "story_v_side_new_1102704.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704069", "story_v_side_new_1102704.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_side_new_1102704", "1102704069", "story_v_side_new_1102704.awb")

						arg_281_1:RecordAudio("1102704069", var_284_6)
						arg_281_1:RecordAudio("1102704069", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704069", "story_v_side_new_1102704.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704069", "story_v_side_new_1102704.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1102704070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1102704070
		arg_285_1.duration_ = 7.5

		local var_285_0 = {
			ja = 7.5,
			ko = 3.5,
			zh = 3.5
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1102704071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.35

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(1102704070)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 14 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 14)

				if (14 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 14)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704070", "story_v_side_new_1102704.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704070", "story_v_side_new_1102704.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_side_new_1102704", "1102704070", "story_v_side_new_1102704.awb")

						arg_285_1:RecordAudio("1102704070", var_288_6)
						arg_285_1:RecordAudio("1102704070", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704070", "story_v_side_new_1102704.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704070", "story_v_side_new_1102704.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1102704071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1102704071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1102704072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if arg_289_1.actors_["1127ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1127ui_story"))) then
				local var_292_0 = Object.Instantiate(Asset.Load("Char/" .. "1127ui_story"), arg_289_1.stage_.transform)

				var_292_0.name = "1127ui_story"
				var_292_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.actors_["1127ui_story"] = var_292_0

				local var_292_1 = var_292_0:GetComponentInChildren(typeof(CharacterEffect))

				var_292_1.enabled = true

				local var_292_2 = GameObjectTools.GetOrAddComponent(var_292_0, typeof(DynamicBoneHelper))

				if var_292_2 then
					var_292_2:EnableDynamicBone(false)
				end

				arg_289_1:ShowWeapon(var_292_1.transform, false)

				arg_289_1.var_["1127ui_story" .. "Animator"] = var_292_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_289_1.var_["1127ui_story" .. "Animator"].applyRootMotion = true
				arg_289_1.var_["1127ui_story" .. "LipSync"] = var_292_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_292_3 = arg_289_1.actors_["1127ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_3) and arg_289_1.var_.characterEffect1127ui_story == nil then
				arg_289_1.var_.characterEffect1127ui_story = var_292_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_4 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 and not isNil(var_292_3) then
				if arg_289_1.var_.characterEffect1127ui_story and not isNil(var_292_3) then
					arg_289_1.var_.characterEffect1127ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1127ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_4)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 and not isNil(var_292_3) and arg_289_1.var_.characterEffect1127ui_story then
				arg_289_1.var_.characterEffect1127ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1127ui_story.fillRatio = 0.5
			end

			local var_292_5 = 0
			local var_292_6 = 0.4

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_7 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(1102704071).content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 16 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_7) / 16)

				if (16 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_7) / 16)) > 0 and var_292_6 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_6, arg_289_1.talkMaxDuration)

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_5) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_5 + var_292_10 and arg_289_1.time_ < var_292_5 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1102704072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1102704072
		arg_293_1.duration_ = 9

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1102704073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 2 < arg_293_1.time_ and arg_293_1.time_ <= 2 + arg_296_0 then
				local var_296_0 = arg_293_1.bgs_.R2701

				arg_293_1.bgs_.R2701.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_296_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_1 = var_296_0:GetComponent("SpriteRenderer")

				if var_296_1 and var_296_1.sprite then
					local var_296_2 = 2 * (var_296_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_296_0.transform.localScale = Vector3.New(var_296_2 / var_296_1.sprite.bounds.size.y < var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x and var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x or var_296_2 / var_296_1.sprite.bounds.size.y, var_296_2 / var_296_1.sprite.bounds.size.y < var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x and var_296_2 * manager.ui.mainCameraCom_.aspect / var_296_1.sprite.bounds.size.x or var_296_2 / var_296_1.sprite.bounds.size.y, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "R2701" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_3 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_3 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_4 = 2

			if var_296_3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_3 + var_296_4 then
				local var_296_5 = Color.New(0, 0, 0)

				var_296_5.a = Mathf.Lerp(0, 1, (arg_293_1.time_ - var_296_3) / var_296_4)
				arg_293_1.mask_.color = var_296_5
			end

			if arg_293_1.time_ >= var_296_3 + var_296_4 and arg_293_1.time_ < var_296_3 + var_296_4 + arg_296_0 then
				local var_296_6 = Color.New(0, 0, 0)

				var_296_6.a = 1
				arg_293_1.mask_.color = var_296_6
			end

			local var_296_7 = 2

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_7 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_8 = 2

			if var_296_7 <= arg_293_1.time_ and arg_293_1.time_ < var_296_7 + var_296_8 then
				local var_296_9 = Color.New(0, 0, 0)

				var_296_9.a = Mathf.Lerp(1, 0, (arg_293_1.time_ - var_296_7) / var_296_8)
				arg_293_1.mask_.color = var_296_9
			end

			if arg_293_1.time_ >= var_296_7 + var_296_8 and arg_293_1.time_ < var_296_7 + var_296_8 + arg_296_0 then
				local var_296_10 = Color.New(0, 0, 0)

				arg_293_1.mask_.enabled = false
				var_296_10.a = 0
				arg_293_1.mask_.color = var_296_10
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_11 = 4
			local var_296_12 = 0.8

			if 4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_11 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_13 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_13:setOnUpdate(LuaHelper.FloatAction(function(arg_297_0)
					arg_293_1.dialogCg_.alpha = arg_297_0
				end))
				var_296_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_14 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1102704072).content)

				arg_293_1.text_.text = var_296_14

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_16 = 32 <= 0 and var_296_12 or var_296_12 * (utf8.len(var_296_14) / 32)

				if (32 <= 0 and var_296_12 or var_296_12 * (utf8.len(var_296_14) / 32)) > 0 and var_296_12 < var_296_16 then
					arg_293_1.talkMaxDuration = var_296_16
					var_296_11 = var_296_11 + 0.3

					if var_296_16 + var_296_11 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_16 + var_296_11
					end
				end

				arg_293_1.text_.text = var_296_14
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_17 = var_296_11 + 0.3
			local var_296_18 = math.max(var_296_12, arg_293_1.talkMaxDuration)

			if var_296_11 + 0.3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_17 + var_296_18 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_17) / var_296_18

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_17 + var_296_18 and arg_293_1.time_ < var_296_17 + var_296_18 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1102704073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1102704073
		arg_299_1.duration_ = 5.27

		local var_299_0 = {
			ja = 5.266,
			ko = 4,
			zh = 4
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1102704074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1080ui_story"]) and arg_299_1.var_.characterEffect1080ui_story == nil then
				arg_299_1.var_.characterEffect1080ui_story = arg_299_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1080ui_story"]) then
				if arg_299_1.var_.characterEffect1080ui_story and not isNil(arg_299_1.actors_["1080ui_story"]) then
					arg_299_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1080ui_story"]) and arg_299_1.var_.characterEffect1080ui_story then
				arg_299_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_2")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_302_2 = 0
			local var_302_3 = 0.425

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_2 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_4 = arg_299_1:GetWordFromCfg(1102704073)
				local var_302_5 = arg_299_1:FormatText(var_302_4.content)

				arg_299_1.text_.text = var_302_5

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_7 = 17 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 17)

				if (17 <= 0 and var_302_3 or var_302_3 * (utf8.len(var_302_5) / 17)) > 0 and var_302_3 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_2
					end
				end

				arg_299_1.text_.text = var_302_5
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704073", "story_v_side_new_1102704.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704073", "story_v_side_new_1102704.awb") / 1000

					if var_302_8 + var_302_2 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_2
					end

					if var_302_4.prefab_name ~= "" and arg_299_1.actors_[var_302_4.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_4.prefab_name].transform, "story_v_side_new_1102704", "1102704073", "story_v_side_new_1102704.awb")

						arg_299_1:RecordAudio("1102704073", var_302_9)
						arg_299_1:RecordAudio("1102704073", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704073", "story_v_side_new_1102704.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704073", "story_v_side_new_1102704.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_3, arg_299_1.talkMaxDuration)

			if var_302_2 <= arg_299_1.time_ and arg_299_1.time_ < var_302_2 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_2) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_2 + var_302_10 and arg_299_1.time_ < var_302_2 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play1102704074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1102704074
		arg_303_1.duration_ = 15.63

		local var_303_0 = {
			ja = 15.633,
			ko = 9.8,
			zh = 9.8
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1102704075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.05

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(1102704074)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 42 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 42)

				if (42 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 42)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704074", "story_v_side_new_1102704.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704074", "story_v_side_new_1102704.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_side_new_1102704", "1102704074", "story_v_side_new_1102704.awb")

						arg_303_1:RecordAudio("1102704074", var_306_6)
						arg_303_1:RecordAudio("1102704074", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704074", "story_v_side_new_1102704.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704074", "story_v_side_new_1102704.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1102704075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1102704075
		arg_307_1.duration_ = 12.13

		local var_307_0 = {
			ja = 10.933,
			ko = 12.133,
			zh = 12.133
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1102704076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 1.3

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:GetWordFromCfg(1102704075)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 52 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 52)

				if (52 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 52)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704075", "story_v_side_new_1102704.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704075", "story_v_side_new_1102704.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_side_new_1102704", "1102704075", "story_v_side_new_1102704.awb")

						arg_307_1:RecordAudio("1102704075", var_310_6)
						arg_307_1:RecordAudio("1102704075", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704075", "story_v_side_new_1102704.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704075", "story_v_side_new_1102704.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1102704076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1102704076
		arg_311_1.duration_ = 9.73

		local var_311_0 = {
			ja = 7.233,
			ko = 9.733,
			zh = 9.733
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1102704077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 1.075

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:GetWordFromCfg(1102704076)
				local var_314_2 = arg_311_1:FormatText(var_314_1.content)

				arg_311_1.text_.text = var_314_2

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 43 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 43)

				if (43 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_2) / 43)) > 0 and var_314_0 < var_314_4 then
					arg_311_1.talkMaxDuration = var_314_4

					if var_314_4 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_4 + 0
					end
				end

				arg_311_1.text_.text = var_314_2
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704076", "story_v_side_new_1102704.awb") ~= 0 then
					local var_314_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704076", "story_v_side_new_1102704.awb") / 1000

					if var_314_5 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + 0
					end

					if var_314_1.prefab_name ~= "" and arg_311_1.actors_[var_314_1.prefab_name] ~= nil then
						local var_314_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_1.prefab_name].transform, "story_v_side_new_1102704", "1102704076", "story_v_side_new_1102704.awb")

						arg_311_1:RecordAudio("1102704076", var_314_6)
						arg_311_1:RecordAudio("1102704076", var_314_6)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704076", "story_v_side_new_1102704.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704076", "story_v_side_new_1102704.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1102704077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1102704077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1102704078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.225

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1102704077).content)

				arg_315_1.text_.text = var_318_1

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_3 = 9 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 9)

				if (9 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 9)) > 0 and var_318_0 < var_318_3 then
					arg_315_1.talkMaxDuration = var_318_3

					if var_318_3 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_3 + 0
					end
				end

				arg_315_1.text_.text = var_318_1
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_4 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_4

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1102704078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1102704078
		arg_319_1.duration_ = 8.17

		local var_319_0 = {
			ja = 8.166,
			ko = 4.733,
			zh = 4.733
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1102704079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.525

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:GetWordFromCfg(1102704078)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 21 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 21)

				if (21 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 21)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704078", "story_v_side_new_1102704.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704078", "story_v_side_new_1102704.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_side_new_1102704", "1102704078", "story_v_side_new_1102704.awb")

						arg_319_1:RecordAudio("1102704078", var_322_6)
						arg_319_1:RecordAudio("1102704078", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704078", "story_v_side_new_1102704.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704078", "story_v_side_new_1102704.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1102704079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1102704079
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1102704080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0.175

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_1 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(1102704079).content)

				arg_323_1.text_.text = var_326_1

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_3 = 7 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 7)

				if (7 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 7)) > 0 and var_326_0 < var_326_3 then
					arg_323_1.talkMaxDuration = var_326_3

					if var_326_3 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_3 + 0
					end
				end

				arg_323_1.text_.text = var_326_1
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_4 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_4

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play1102704080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1102704080
		arg_327_1.duration_ = 8.43

		local var_327_0 = {
			ja = 7.3,
			ko = 8.433,
			zh = 8.433
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1102704081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.9

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(1102704080)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 36 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 36)

				if (36 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 36)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704080", "story_v_side_new_1102704.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704080", "story_v_side_new_1102704.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_side_new_1102704", "1102704080", "story_v_side_new_1102704.awb")

						arg_327_1:RecordAudio("1102704080", var_330_6)
						arg_327_1:RecordAudio("1102704080", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704080", "story_v_side_new_1102704.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704080", "story_v_side_new_1102704.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1102704081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1102704081
		arg_331_1.duration_ = 5.37

		local var_331_0 = {
			ja = 5.366,
			ko = 5.233,
			zh = 5.233
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
			arg_331_1.auto_ = false
		end

		function arg_331_1.playNext_(arg_333_0)
			arg_331_1.onStoryFinished_()
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.475

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:GetWordFromCfg(1102704081)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 19 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 19)

				if (19 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 19)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704081", "story_v_side_new_1102704.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_side_new_1102704", "1102704081", "story_v_side_new_1102704.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_side_new_1102704", "1102704081", "story_v_side_new_1102704.awb")

						arg_331_1:RecordAudio("1102704081", var_334_6)
						arg_331_1:RecordAudio("1102704081", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_side_new_1102704", "1102704081", "story_v_side_new_1102704.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_side_new_1102704", "1102704081", "story_v_side_new_1102704.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/R2701"
	},
	voices = {
		"story_v_side_new_1102704.awb"
	}
}
