return {
	Play1109403001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1109403001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1109403002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST08 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST08")
				var_4_0.name = "ST08"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST08 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST08

				arg_1_1.bgs_.ST08.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST08" then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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
			local var_4_15 = 0.8

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1109403001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)

				if (32 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 32)) > 0 and var_4_15 < var_4_19 then
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
	Play1109403002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1109403002
		arg_9_1.duration_ = 6.63

		local var_9_0 = {
			ja = 6.633,
			ko = 5.566,
			zh = 5.566
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
				arg_9_0:Play1109403003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1019ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1019ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1019ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1019ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1019ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1019ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1019ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1019ui_story == nil then
				arg_9_1.var_.characterEffect1019ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1019ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1019ui_story then
				arg_9_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[47].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(1109403002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 28 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 28)

				if (28 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 28)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb")

						arg_9_1:RecordAudio("1109403002", var_12_15)
						arg_9_1:RecordAudio("1109403002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403002", "story_v_side_new_1109403.awb")
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
				actorName = "1019ui_story",
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
	Play1109403003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1109403003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1109403004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1019ui_story"]) and arg_13_1.var_.characterEffect1019ui_story == nil then
				arg_13_1.var_.characterEffect1019ui_story = arg_13_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1019ui_story"]) then
				if arg_13_1.var_.characterEffect1019ui_story and not isNil(arg_13_1.actors_["1019ui_story"]) then
					arg_13_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1019ui_story"]) and arg_13_1.var_.characterEffect1019ui_story then
				arg_13_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.1

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

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(1109403003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 4 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 4)

				if (4 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 4)) > 0 and var_16_2 < var_16_5 then
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
	Play1109403004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1109403004
		arg_17_1.duration_ = 10.97

		local var_17_0 = {
			ja = 10.966,
			ko = 8.233,
			zh = 8.233
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
				arg_17_0:Play1109403005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1019ui_story = arg_17_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).z)
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles = arg_17_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_17_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1019ui_story"].transform.position).z)
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1019ui_story"].transform.localEulerAngles = arg_17_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1019ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1019ui_story == nil then
				arg_17_1.var_.characterEffect1019ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1019ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1019ui_story then
				arg_17_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = 0
			local var_20_5 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[47].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(1109403004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 36 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 36)

				if (36 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 36)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb")

						arg_17_1:RecordAudio("1109403004", var_20_11)
						arg_17_1:RecordAudio("1109403004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403004", "story_v_side_new_1109403.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play1109403005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1109403005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1109403006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) and arg_21_1.var_.characterEffect1019ui_story == nil then
				arg_21_1.var_.characterEffect1019ui_story = arg_21_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) then
				if arg_21_1.var_.characterEffect1019ui_story and not isNil(arg_21_1.actors_["1019ui_story"]) then
					arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1019ui_story"]) and arg_21_1.var_.characterEffect1019ui_story then
				arg_21_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1109403005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 20 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 20)

				if (20 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 20)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1109403006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1109403006
		arg_25_1.duration_ = 8.83

		local var_25_0 = {
			ja = 8.8,
			ko = 8.833,
			zh = 8.833
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
				arg_25_0:Play1109403007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1019ui_story = arg_25_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).z)
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles = arg_25_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1019ui_story"].transform.position).z)
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1019ui_story"].transform.localEulerAngles = arg_25_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1019ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1019ui_story == nil then
				arg_25_1.var_.characterEffect1019ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1019ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1019ui_story then
				arg_25_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_28_3 = 0
			local var_28_4 = 0.925

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_5 = arg_25_1:GetWordFromCfg(1109403006)
				local var_28_6 = arg_25_1:FormatText(var_28_5.content)

				arg_25_1.text_.text = var_28_6

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_8 = 37 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_6) / 37)

				if (37 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_6) / 37)) > 0 and var_28_4 < var_28_8 then
					arg_25_1.talkMaxDuration = var_28_8

					if var_28_8 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_6
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb") ~= 0 then
					local var_28_9 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb") / 1000

					if var_28_9 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_3
					end

					if var_28_5.prefab_name ~= "" and arg_25_1.actors_[var_28_5.prefab_name] ~= nil then
						local var_28_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_5.prefab_name].transform, "story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb")

						arg_25_1:RecordAudio("1109403006", var_28_10)
						arg_25_1:RecordAudio("1109403006", var_28_10)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403006", "story_v_side_new_1109403.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_11 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_11 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_11

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_11 and arg_25_1.time_ < var_28_3 + var_28_11 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play1109403007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1109403007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1109403008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1109403007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 35 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 35)

				if (35 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 35)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1109403008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1109403008
		arg_33_1.duration_ = 9

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1109403009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.bgs_.B13 == nil then
				local var_36_0 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")
				var_36_0.name = "B13"
				var_36_0.transform.parent = arg_33_1.stage_.transform
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_.B13 = var_36_0
			end

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= 2 + arg_36_0 then
				local var_36_1 = arg_33_1.bgs_.B13

				arg_33_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_2 = var_36_1:GetComponent("SpriteRenderer")

				if var_36_2 and var_36_2.sprite then
					local var_36_3 = 2 * (var_36_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_1.transform.localScale = Vector3.New(var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "B13" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_4 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_5 = 2

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_5 then
				local var_36_6 = Color.New(0, 0, 0)

				var_36_6.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_4) / var_36_5)
				arg_33_1.mask_.color = var_36_6
			end

			if arg_33_1.time_ >= var_36_4 + var_36_5 and arg_33_1.time_ < var_36_4 + var_36_5 + arg_36_0 then
				local var_36_7 = Color.New(0, 0, 0)

				var_36_7.a = 1
				arg_33_1.mask_.color = var_36_7
			end

			local var_36_8 = 2

			if 2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_9 = 2

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 then
				local var_36_10 = Color.New(0, 0, 0)

				var_36_10.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_8) / var_36_9)
				arg_33_1.mask_.color = var_36_10
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 then
				local var_36_11 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_11.a = 0
				arg_33_1.mask_.color = var_36_11
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_12 = 4
			local var_36_13 = 0.45

			if 4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_14 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_14:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_15 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1109403008).content)

				arg_33_1.text_.text = var_36_15

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_17 = 18 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 18)

				if (18 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_15) / 18)) > 0 and var_36_13 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17
					var_36_12 = var_36_12 + 0.3

					if var_36_17 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_15
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = var_36_12 + 0.3
			local var_36_19 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 + 0.3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_18 + var_36_19 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_18) / var_36_19

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_18 + var_36_19 and arg_33_1.time_ < var_36_18 + var_36_19 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1109403009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1109403009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1109403010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_knock", "")
			end

			local var_42_1 = 0
			local var_42_2 = 0.95

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

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(1109403009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 38 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 38)

				if (38 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 38)) > 0 and var_42_2 < var_42_5 then
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
	Play1109403010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1109403010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1109403011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.125

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

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(1109403010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 5 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 5)

				if (5 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 5)) > 0 and var_46_0 < var_46_3 then
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
	Play1109403011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1109403011
		arg_47_1.duration_ = 2.53

		local var_47_0 = {
			ja = 1.999999999999,
			ko = 2.533,
			zh = 2.533
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1109403012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.actors_["1094ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1094ui_story"))) then
				local var_50_0 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_47_1.stage_.transform)

				var_50_0.name = "1094ui_story"
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1094ui_story"] = var_50_0

				local var_50_1 = var_50_0:GetComponentInChildren(typeof(CharacterEffect))

				var_50_1.enabled = true

				local var_50_2 = GameObjectTools.GetOrAddComponent(var_50_0, typeof(DynamicBoneHelper))

				if var_50_2 then
					var_50_2:EnableDynamicBone(false)
				end

				arg_47_1:ShowWeapon(var_50_1.transform, false)

				arg_47_1.var_["1094ui_story" .. "Animator"] = var_50_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_47_1.var_["1094ui_story" .. "Animator"].applyRootMotion = true
				arg_47_1.var_["1094ui_story" .. "LipSync"] = var_50_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_50_3 = arg_47_1.actors_["1094ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1094ui_story = var_50_3.localPosition
			end

			local var_50_4 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				var_50_3.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_47_1.time_ - 0) / var_50_4)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				var_50_3.localPosition = Vector3.New(0, -0.84, -6.1)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			local var_50_5 = arg_47_1.actors_["1094ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1094ui_story == nil then
				arg_47_1.var_.characterEffect1094ui_story = var_50_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_6 and not isNil(var_50_5) then
				if arg_47_1.var_.characterEffect1094ui_story and not isNil(var_50_5) then
					arg_47_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_6 and arg_47_1.time_ < 0 + var_50_6 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1094ui_story then
				arg_47_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_50_8 = 0
			local var_50_9 = 0.25

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(1109403011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 10 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 10)

				if (10 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 10)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb")

						arg_47_1:RecordAudio("1109403011", var_50_15)
						arg_47_1:RecordAudio("1109403011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403011", "story_v_side_new_1109403.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play1109403012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1109403012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1109403013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1094ui_story"]) and arg_51_1.var_.characterEffect1094ui_story == nil then
				arg_51_1.var_.characterEffect1094ui_story = arg_51_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1094ui_story"]) then
				if arg_51_1.var_.characterEffect1094ui_story and not isNil(arg_51_1.actors_["1094ui_story"]) then
					arg_51_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1094ui_story"]) and arg_51_1.var_.characterEffect1094ui_story then
				arg_51_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.4

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(1109403012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 16 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 16)

				if (16 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 16)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1109403013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1109403013
		arg_55_1.duration_ = 2

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play1109403014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1094ui_story = arg_55_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1094ui_story"].transform.position).z)
				arg_55_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1094ui_story"].transform.localEulerAngles = arg_55_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_55_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1094ui_story"].transform.position).z)
				arg_55_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1094ui_story"].transform.localEulerAngles = arg_55_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1094ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1094ui_story == nil then
				arg_55_1.var_.characterEffect1094ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1094ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1094ui_story then
				arg_55_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_58_4 = 0
			local var_58_5 = 0.1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(1109403013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 4 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 4)

				if (4 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 4)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb")

						arg_55_1:RecordAudio("1109403013", var_58_11)
						arg_55_1:RecordAudio("1109403013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403013", "story_v_side_new_1109403.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109403014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1109403014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1109403015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1094ui_story"]) and arg_59_1.var_.characterEffect1094ui_story == nil then
				arg_59_1.var_.characterEffect1094ui_story = arg_59_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1094ui_story"]) then
				if arg_59_1.var_.characterEffect1094ui_story and not isNil(arg_59_1.actors_["1094ui_story"]) then
					arg_59_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1094ui_story"]) and arg_59_1.var_.characterEffect1094ui_story then
				arg_59_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1109403014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 7 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 7)

				if (7 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 7)) > 0 and var_62_2 < var_62_5 then
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
	Play1109403015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1109403015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1109403016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.575

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

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(1109403015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 23 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 23)

				if (23 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 23)) > 0 and var_66_0 < var_66_3 then
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
	Play1109403016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1109403016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1109403017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.45

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1109403016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 18 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 18)

				if (18 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 18)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play1109403017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1109403017
		arg_71_1.duration_ = 2.9

		local var_71_0 = {
			ja = 2.9,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_71_0:Play1109403018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1094ui_story = arg_71_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).z)
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles = arg_71_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_71_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1094ui_story"].transform.position).z)
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1094ui_story"].transform.localEulerAngles = arg_71_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1094ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1094ui_story == nil then
				arg_71_1.var_.characterEffect1094ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1094ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1094ui_story then
				arg_71_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.125

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(1109403017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 5 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 5)

				if (5 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 5)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb")

						arg_71_1:RecordAudio("1109403017", var_74_11)
						arg_71_1:RecordAudio("1109403017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403017", "story_v_side_new_1109403.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play1109403018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1109403018
		arg_75_1.duration_ = 9

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play1109403019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.bgs_.ST01 == nil then
				local var_78_0 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_78_0.name = "ST01"
				var_78_0.transform.parent = arg_75_1.stage_.transform
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_.ST01 = var_78_0
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				if arg_75_0.sceneSettingEffect_ then
					arg_75_1.sceneSettingEffect_.enabled = false
				end

				arg_75_1.sceneSettingGo_:SetActive(true)

				local var_78_1 = arg_75_1.bgs_.ST01

				arg_75_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_78_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_2 = var_78_1:GetComponent("SpriteRenderer")

				if var_78_2 and var_78_2.sprite then
					local var_78_3 = 2 * (var_78_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_78_1.transform.localScale = Vector3.New(var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "ST01" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_4 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_5 = 2

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_5 then
				local var_78_6 = Color.New(0, 0, 0)

				var_78_6.a = Mathf.Lerp(0, 1, (arg_75_1.time_ - var_78_4) / var_78_5)
				arg_75_1.mask_.color = var_78_6
			end

			if arg_75_1.time_ >= var_78_4 + var_78_5 and arg_75_1.time_ < var_78_4 + var_78_5 + arg_78_0 then
				local var_78_7 = Color.New(0, 0, 0)

				var_78_7.a = 1
				arg_75_1.mask_.color = var_78_7
			end

			local var_78_8 = 2

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_8 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_9 = 2

			if var_78_8 <= arg_75_1.time_ and arg_75_1.time_ < var_78_8 + var_78_9 then
				local var_78_10 = Color.New(0, 0, 0)

				var_78_10.a = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_8) / var_78_9)
				arg_75_1.mask_.color = var_78_10
			end

			if arg_75_1.time_ >= var_78_8 + var_78_9 and arg_75_1.time_ < var_78_8 + var_78_9 + arg_78_0 then
				local var_78_11 = Color.New(0, 0, 0)

				arg_75_1.mask_.enabled = false
				var_78_11.a = 0
				arg_75_1.mask_.color = var_78_11
			end

			local var_78_12 = arg_75_1.actors_["1094ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_12) and arg_75_1.var_.characterEffect1094ui_story == nil then
				arg_75_1.var_.characterEffect1094ui_story = var_78_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_13 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_13 and not isNil(var_78_12) then
				if arg_75_1.var_.characterEffect1094ui_story and not isNil(var_78_12) then
					arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_13)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_13 and arg_75_1.time_ < 0 + var_78_13 + arg_78_0 and not isNil(var_78_12) and arg_75_1.var_.characterEffect1094ui_story then
				arg_75_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_78_14 = arg_75_1.actors_["1094ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1094ui_story = var_78_14.localPosition
			end

			local var_78_15 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_15 then
				var_78_14.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_15)
				var_78_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_14.position).x, (manager.ui.mainCamera.transform.position - var_78_14.position).y, (manager.ui.mainCamera.transform.position - var_78_14.position).z)
				var_78_14.localEulerAngles.z = 0
				var_78_14.localEulerAngles.x = 0
				var_78_14.localEulerAngles = var_78_14.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_15 and arg_75_1.time_ < 0 + var_78_15 + arg_78_0 then
				var_78_14.localPosition = Vector3.New(0, 100, 0)
				var_78_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_14.position).x, (manager.ui.mainCamera.transform.position - var_78_14.position).y, (manager.ui.mainCamera.transform.position - var_78_14.position).z)
				var_78_14.localEulerAngles.z = 0
				var_78_14.localEulerAngles.x = 0
				var_78_14.localEulerAngles = var_78_14.localEulerAngles
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_16 = 4
			local var_78_17 = 0.625

			if 4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_16 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_18 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_18:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_19 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(1109403018).content)

				arg_75_1.text_.text = var_78_19

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_21 = 25 <= 0 and var_78_17 or var_78_17 * (utf8.len(var_78_19) / 25)

				if (25 <= 0 and var_78_17 or var_78_17 * (utf8.len(var_78_19) / 25)) > 0 and var_78_17 < var_78_21 then
					arg_75_1.talkMaxDuration = var_78_21
					var_78_16 = var_78_16 + 0.3

					if var_78_21 + var_78_16 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_21 + var_78_16
					end
				end

				arg_75_1.text_.text = var_78_19
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_22 = var_78_16 + 0.3
			local var_78_23 = math.max(var_78_17, arg_75_1.talkMaxDuration)

			if var_78_16 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_22 + var_78_23 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_22) / var_78_23

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_22 + var_78_23 and arg_75_1.time_ < var_78_22 + var_78_23 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play1109403019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1109403019
		arg_81_1.duration_ = 5.57

		local var_81_0 = {
			ja = 5.566,
			ko = 3.366,
			zh = 3.366
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
				arg_81_0:Play1109403020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.45

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(1109403019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 18 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 18)

				if (18 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 18)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb")

						arg_81_1:RecordAudio("1109403019", var_84_6)
						arg_81_1:RecordAudio("1109403019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403019", "story_v_side_new_1109403.awb")
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
	Play1109403020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1109403020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1109403021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.85

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(1109403020).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 34 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 34)

				if (34 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 34)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1109403021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1109403021
		arg_89_1.duration_ = 7.33

		local var_89_0 = {
			ja = 7.333,
			ko = 3.933,
			zh = 3.933
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
				arg_89_0:Play1109403022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(1109403021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)

				if (18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb")

						arg_89_1:RecordAudio("1109403021", var_92_6)
						arg_89_1:RecordAudio("1109403021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403021", "story_v_side_new_1109403.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1109403022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1109403022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1109403023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.425

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

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(1109403022).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 17 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 17)

				if (17 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 17)) > 0 and var_96_0 < var_96_3 then
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
	Play1109403023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1109403023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1109403024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.4

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1109403023).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 16 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 16)

				if (16 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 16)) > 0 and var_100_0 < var_100_3 then
					arg_97_1.talkMaxDuration = var_100_3

					if var_100_3 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_3 + 0
					end
				end

				arg_97_1.text_.text = var_100_1
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_4 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_4

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1109403024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1109403024
		arg_101_1.duration_ = 2.47

		local var_101_0 = {
			ja = 1.133,
			ko = 2.466,
			zh = 2.466
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
				arg_101_0:Play1109403025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1094ui_story = arg_101_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1094ui_story"].transform.position).z)
				arg_101_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1094ui_story"].transform.localEulerAngles = arg_101_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_101_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1094ui_story"].transform.position).z)
				arg_101_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1094ui_story"].transform.localEulerAngles = arg_101_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1094ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1094ui_story == nil then
				arg_101_1.var_.characterEffect1094ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1094ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1094ui_story then
				arg_101_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_4 = 0
			local var_104_5 = 0.15

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(1109403024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 6 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 6)

				if (6 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 6)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb")

						arg_101_1:RecordAudio("1109403024", var_104_11)
						arg_101_1:RecordAudio("1109403024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403024", "story_v_side_new_1109403.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109403025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1109403025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1109403026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1094ui_story"]) and arg_105_1.var_.characterEffect1094ui_story == nil then
				arg_105_1.var_.characterEffect1094ui_story = arg_105_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1094ui_story"]) then
				if arg_105_1.var_.characterEffect1094ui_story and not isNil(arg_105_1.actors_["1094ui_story"]) then
					arg_105_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1094ui_story"]) and arg_105_1.var_.characterEffect1094ui_story then
				arg_105_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 1.1

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1109403025).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 44 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 44)

				if (44 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 44)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play1109403026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1109403026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1109403027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.65

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

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1109403026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 26 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 26)

				if (26 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 26)) > 0 and var_112_0 < var_112_3 then
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
	Play1109403027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1109403027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1109403028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.575

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1109403027).content)

				arg_113_1.text_.text = var_116_1

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_3 = 23 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 23)

				if (23 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_1) / 23)) > 0 and var_116_0 < var_116_3 then
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
	Play1109403028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1109403028
		arg_117_1.duration_ = 11.07

		local var_117_0 = {
			ja = 11.066,
			ko = 6.633,
			zh = 6.633
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1109403029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.75

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:GetWordFromCfg(1109403028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 30 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 30)

				if (30 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 30)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb")

						arg_117_1:RecordAudio("1109403028", var_120_6)
						arg_117_1:RecordAudio("1109403028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403028", "story_v_side_new_1109403.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1109403029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1109403029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1109403030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.725

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(1109403029).content)

				arg_121_1.text_.text = var_124_1

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_3 = 29 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 29)

				if (29 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_1) / 29)) > 0 and var_124_0 < var_124_3 then
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
	Play1109403030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1109403030
		arg_125_1.duration_ = 2

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1109403031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1094ui_story = arg_125_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1094ui_story"].transform.position).z)
				arg_125_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1094ui_story"].transform.localEulerAngles = arg_125_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_125_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1094ui_story"].transform.position).z)
				arg_125_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1094ui_story"].transform.localEulerAngles = arg_125_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1094ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1094ui_story == nil then
				arg_125_1.var_.characterEffect1094ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1094ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1094ui_story then
				arg_125_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.075

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(1109403030)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb")

						arg_125_1:RecordAudio("1109403030", var_128_11)
						arg_125_1:RecordAudio("1109403030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403030", "story_v_side_new_1109403.awb")
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
				actorName = "1094ui_story",
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
	Play1109403031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1109403031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1109403032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1094ui_story"]) and arg_129_1.var_.characterEffect1094ui_story == nil then
				arg_129_1.var_.characterEffect1094ui_story = arg_129_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1094ui_story"]) then
				if arg_129_1.var_.characterEffect1094ui_story and not isNil(arg_129_1.actors_["1094ui_story"]) then
					arg_129_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1094ui_story"]) and arg_129_1.var_.characterEffect1094ui_story then
				arg_129_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.4

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(1109403031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 16 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 16)

				if (16 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 16)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1109403032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1109403032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1109403033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.425

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1109403032).content)

				arg_133_1.text_.text = var_136_1

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_3 = 17 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 17)

				if (17 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_1) / 17)) > 0 and var_136_0 < var_136_3 then
					arg_133_1.talkMaxDuration = var_136_3

					if var_136_3 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_3 + 0
					end
				end

				arg_133_1.text_.text = var_136_1
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_4 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_4

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1109403033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1109403033
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1109403034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1094ui_story = arg_137_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1094ui_story"].transform.position).z)
				arg_137_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1094ui_story"].transform.localEulerAngles = arg_137_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_137_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1094ui_story"].transform.position).z)
				arg_137_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1094ui_story"].transform.localEulerAngles = arg_137_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1094ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1094ui_story == nil then
				arg_137_1.var_.characterEffect1094ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1094ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1094ui_story then
				arg_137_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_140_4 = 0
			local var_140_5 = 0.075

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(1109403033)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 3 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 3)

				if (3 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 3)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb")

						arg_137_1:RecordAudio("1109403033", var_140_11)
						arg_137_1:RecordAudio("1109403033", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403033", "story_v_side_new_1109403.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
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
	Play1109403034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1109403034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1109403035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1094ui_story"]) and arg_141_1.var_.characterEffect1094ui_story == nil then
				arg_141_1.var_.characterEffect1094ui_story = arg_141_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1094ui_story"]) then
				if arg_141_1.var_.characterEffect1094ui_story and not isNil(arg_141_1.actors_["1094ui_story"]) then
					arg_141_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1094ui_story"]) and arg_141_1.var_.characterEffect1094ui_story then
				arg_141_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_144_1 = 0
			local var_144_2 = 0.7

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(1109403034).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 28 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 28)

				if (28 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 28)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1109403035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1109403035
		arg_145_1.duration_ = 2.3

		local var_145_0 = {
			ja = 2.3,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1109403036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1094ui_story = arg_145_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1094ui_story"].transform.position).z)
				arg_145_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1094ui_story"].transform.localEulerAngles = arg_145_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_145_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1094ui_story"].transform.position).z)
				arg_145_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1094ui_story"].transform.localEulerAngles = arg_145_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["1094ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1094ui_story == nil then
				arg_145_1.var_.characterEffect1094ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect1094ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect1094ui_story then
				arg_145_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_148_4 = 0
			local var_148_5 = 0.1

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(1109403035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 4 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 4)

				if (4 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 4)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb")

						arg_145_1:RecordAudio("1109403035", var_148_11)
						arg_145_1:RecordAudio("1109403035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403035", "story_v_side_new_1109403.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play1109403036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1109403036
		arg_149_1.duration_ = 4.77

		local var_149_0 = {
			ja = 4.766,
			ko = 2.433,
			zh = 2.433
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1109403037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["1094ui_story"]) and arg_149_1.var_.characterEffect1094ui_story == nil then
				arg_149_1.var_.characterEffect1094ui_story = arg_149_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["1094ui_story"]) then
				if arg_149_1.var_.characterEffect1094ui_story and not isNil(arg_149_1.actors_["1094ui_story"]) then
					arg_149_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_0)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["1094ui_story"]) and arg_149_1.var_.characterEffect1094ui_story then
				arg_149_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_152_1 = 0
			local var_152_2 = 0.175

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_3 = arg_149_1:GetWordFromCfg(1109403036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 7 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 7)

				if (7 <= 0 and var_152_2 or var_152_2 * (utf8.len(var_152_4) / 7)) > 0 and var_152_2 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_1
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb") ~= 0 then
					local var_152_7 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb") / 1000

					if var_152_7 + var_152_1 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_1
					end

					if var_152_3.prefab_name ~= "" and arg_149_1.actors_[var_152_3.prefab_name] ~= nil then
						local var_152_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_3.prefab_name].transform, "story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb")

						arg_149_1:RecordAudio("1109403036", var_152_8)
						arg_149_1:RecordAudio("1109403036", var_152_8)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403036", "story_v_side_new_1109403.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_9 = math.max(var_152_2, arg_149_1.talkMaxDuration)

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_9 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_1) / var_152_9

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_1 + var_152_9 and arg_149_1.time_ < var_152_1 + var_152_9 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play1109403037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1109403037
		arg_153_1.duration_ = 9.77

		local var_153_0 = {
			ja = 9.766,
			ko = 4.033,
			zh = 4.033
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1109403038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.5

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(1109403037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 20 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 20)

				if (20 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 20)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb")

						arg_153_1:RecordAudio("1109403037", var_156_6)
						arg_153_1:RecordAudio("1109403037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403037", "story_v_side_new_1109403.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play1109403038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1109403038
		arg_157_1.duration_ = 2

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1109403039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_160_0 = 0
			local var_160_1 = 0.05

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[435].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(1109403038)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 2 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 2)

				if (2 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_3) / 2)) > 0 and var_160_1 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb") ~= 0 then
					local var_160_6 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb") / 1000

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end

					if var_160_2.prefab_name ~= "" and arg_157_1.actors_[var_160_2.prefab_name] ~= nil then
						local var_160_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_2.prefab_name].transform, "story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb")

						arg_157_1:RecordAudio("1109403038", var_160_7)
						arg_157_1:RecordAudio("1109403038", var_160_7)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403038", "story_v_side_new_1109403.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_8 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_8 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_8

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_8 and arg_157_1.time_ < var_160_0 + var_160_8 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1109403039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1109403039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1109403040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.325

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(1109403039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 13 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 13)

				if (13 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 13)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play1109403040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1109403040
		arg_165_1.duration_ = 5.4

		local var_165_0 = {
			ja = 5.4,
			ko = 1.766,
			zh = 1.766
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1109403041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1094ui_story = arg_165_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).z)
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles = arg_165_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_165_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1094ui_story"].transform.position).z)
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1094ui_story"].transform.localEulerAngles = arg_165_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1094ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1094ui_story == nil then
				arg_165_1.var_.characterEffect1094ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1094ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1094ui_story then
				arg_165_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_168_4 = 0
			local var_168_5 = 0.175

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(1109403040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 7 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 7)

				if (7 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 7)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb")

						arg_165_1:RecordAudio("1109403040", var_168_11)
						arg_165_1:RecordAudio("1109403040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403040", "story_v_side_new_1109403.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play1109403041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 1109403041
		arg_169_1.duration_ = 3.6

		local var_169_0 = {
			ja = 3.333,
			ko = 3.6,
			zh = 3.6
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play1109403042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1094ui_story = arg_169_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1094ui_story"].transform.position).z)
				arg_169_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1094ui_story"].transform.localEulerAngles = arg_169_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_169_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1094ui_story"].transform.position).z)
				arg_169_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1094ui_story"].transform.localEulerAngles = arg_169_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1094ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1094ui_story == nil then
				arg_169_1.var_.characterEffect1094ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1094ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1094ui_story then
				arg_169_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_172_4 = 0
			local var_172_5 = 0.325

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(1109403041)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 13 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 13)

				if (13 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 13)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb")

						arg_169_1:RecordAudio("1109403041", var_172_11)
						arg_169_1:RecordAudio("1109403041", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403041", "story_v_side_new_1109403.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play1109403042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 1109403042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play1109403043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1094ui_story"]) and arg_173_1.var_.characterEffect1094ui_story == nil then
				arg_173_1.var_.characterEffect1094ui_story = arg_173_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1094ui_story"]) then
				if arg_173_1.var_.characterEffect1094ui_story and not isNil(arg_173_1.actors_["1094ui_story"]) then
					arg_173_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1094ui_story"]) and arg_173_1.var_.characterEffect1094ui_story then
				arg_173_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_176_1 = 0
			local var_176_2 = 0.3

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(1109403042).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 12 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 12)

				if (12 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 12)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play1109403043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 1109403043
		arg_177_1.duration_ = 4.1

		local var_177_0 = {
			ja = 4.1,
			ko = 2,
			zh = 2
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play1109403044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.05

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(1109403043)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 2 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 2)

				if (2 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 2)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb")

						arg_177_1:RecordAudio("1109403043", var_180_6)
						arg_177_1:RecordAudio("1109403043", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403043", "story_v_side_new_1109403.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play1109403044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 1109403044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play1109403045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1094ui_story = arg_181_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1094ui_story"].transform.position).z)
				arg_181_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1094ui_story"].transform.localEulerAngles = arg_181_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1094ui_story"].transform.position).z)
				arg_181_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1094ui_story"].transform.localEulerAngles = arg_181_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_184_1 = 0
			local var_184_2 = 0.575

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(1109403044).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 23 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 23)

				if (23 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 23)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play1109403045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 1109403045
		arg_185_1.duration_ = 4.03

		local var_185_0 = {
			ja = 4.033,
			ko = 3.5,
			zh = 3.5
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play1109403046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1094ui_story = arg_185_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1094ui_story"].transform.position).z)
				arg_185_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1094ui_story"].transform.localEulerAngles = arg_185_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_185_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1094ui_story"].transform.position).z)
				arg_185_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1094ui_story"].transform.localEulerAngles = arg_185_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1094ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1094ui_story == nil then
				arg_185_1.var_.characterEffect1094ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1094ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1094ui_story then
				arg_185_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_188_4 = 0
			local var_188_5 = 0.275

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(1109403045)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 11 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 11)

				if (11 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 11)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb")

						arg_185_1:RecordAudio("1109403045", var_188_11)
						arg_185_1:RecordAudio("1109403045", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403045", "story_v_side_new_1109403.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play1109403046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 1109403046
		arg_189_1.duration_ = 10.63

		local var_189_0 = {
			ja = 10.633,
			ko = 6.1,
			zh = 6.1
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play1109403047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1094ui_story"]) and arg_189_1.var_.characterEffect1094ui_story == nil then
				arg_189_1.var_.characterEffect1094ui_story = arg_189_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1094ui_story"]) then
				if arg_189_1.var_.characterEffect1094ui_story and not isNil(arg_189_1.actors_["1094ui_story"]) then
					arg_189_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1094ui_story"]) and arg_189_1.var_.characterEffect1094ui_story then
				arg_189_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.675

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_3 = arg_189_1:GetWordFromCfg(1109403046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 27 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_4) / 27)

				if (27 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_4) / 27)) > 0 and var_192_2 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb") ~= 0 then
					local var_192_7 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb") / 1000

					if var_192_7 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_1
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb")

						arg_189_1:RecordAudio("1109403046", var_192_8)
						arg_189_1:RecordAudio("1109403046", var_192_8)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403046", "story_v_side_new_1109403.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_9 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_9 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_9

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_9 and arg_189_1.time_ < var_192_1 + var_192_9 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play1109403047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 1109403047
		arg_193_1.duration_ = 8.03

		local var_193_0 = {
			ja = 8.033,
			ko = 3.433,
			zh = 3.433
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play1109403048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:GetWordFromCfg(1109403047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 14 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 14)

				if (14 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 14)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb")

						arg_193_1:RecordAudio("1109403047", var_196_6)
						arg_193_1:RecordAudio("1109403047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403047", "story_v_side_new_1109403.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play1109403048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 1109403048
		arg_197_1.duration_ = 16.4

		local var_197_0 = {
			ja = 16.4,
			ko = 8.8,
			zh = 8.8
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play1109403049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.925

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_1 = arg_197_1:GetWordFromCfg(1109403048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 37 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 37)

				if (37 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 37)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb")

						arg_197_1:RecordAudio("1109403048", var_200_6)
						arg_197_1:RecordAudio("1109403048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403048", "story_v_side_new_1109403.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play1109403049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 1109403049
		arg_201_1.duration_ = 14.4

		local var_201_0 = {
			ja = 14.4,
			ko = 9.533,
			zh = 9.533
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play1109403050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.175

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(1109403049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 47 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 47)

				if (47 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 47)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb")

						arg_201_1:RecordAudio("1109403049", var_204_6)
						arg_201_1:RecordAudio("1109403049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403049", "story_v_side_new_1109403.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play1109403050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 1109403050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play1109403051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.2

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

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(1109403050).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 8 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 8)

				if (8 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 8)) > 0 and var_208_0 < var_208_3 then
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
	Play1109403051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1109403051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1109403052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.65

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(1109403051).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 26 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 26)

				if (26 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 26)) > 0 and var_212_0 < var_212_3 then
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
	Play1109403052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1109403052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1109403053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.425

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(1109403052).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 17 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 17)

				if (17 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 17)) > 0 and var_216_0 < var_216_3 then
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
	Play1109403053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1109403053
		arg_217_1.duration_ = 0.2

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"

			SetActive(arg_217_1.choicesGo_, true)

			for iter_218_0, iter_218_1 in ipairs(arg_217_1.choices_) do
				SetActive(iter_218_1.go, iter_218_0 <= 1)
			end

			arg_217_1.choices_[1].txt.text = arg_217_1:FormatText(StoryChoiceCfg[408].name)
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1109403054(arg_217_1)
			end

			arg_217_1:RecordChoiceLog(1109403053, 408)
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= 0 + 0.200000002980232 and arg_217_1.time_ < 0 + 0.200000002980232 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1109403054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1109403054
		arg_221_1.duration_ = 2.9

		local var_221_0 = {
			ja = 2.066,
			ko = 2.9,
			zh = 2.9
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1109403055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1094ui_story = arg_221_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1094ui_story"].transform.position).z)
				arg_221_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1094ui_story"].transform.localEulerAngles = arg_221_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_221_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1094ui_story"].transform.position).z)
				arg_221_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1094ui_story"].transform.localEulerAngles = arg_221_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1094ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1094ui_story == nil then
				arg_221_1.var_.characterEffect1094ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1094ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1094ui_story then
				arg_221_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_224_4 = 0
			local var_224_5 = 0.275

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(1109403054)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 11 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 11)

				if (11 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 11)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb")

						arg_221_1:RecordAudio("1109403054", var_224_11)
						arg_221_1:RecordAudio("1109403054", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403054", "story_v_side_new_1109403.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_12 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_12 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_12

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_12 and arg_221_1.time_ < var_224_4 + var_224_12 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play1109403055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1109403055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1109403056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1094ui_story"]) and arg_225_1.var_.characterEffect1094ui_story == nil then
				arg_225_1.var_.characterEffect1094ui_story = arg_225_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1094ui_story"]) then
				if arg_225_1.var_.characterEffect1094ui_story and not isNil(arg_225_1.actors_["1094ui_story"]) then
					arg_225_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1094ui_story"]) and arg_225_1.var_.characterEffect1094ui_story then
				arg_225_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 0.675

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(1109403055).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 27 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 27)

				if (27 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 27)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1109403056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1109403056
		arg_229_1.duration_ = 2

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1109403057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1094ui_story = arg_229_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1094ui_story"].transform.position).z)
				arg_229_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1094ui_story"].transform.localEulerAngles = arg_229_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_229_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1094ui_story"].transform.position).z)
				arg_229_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1094ui_story"].transform.localEulerAngles = arg_229_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1094ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1094ui_story == nil then
				arg_229_1.var_.characterEffect1094ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1094ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1094ui_story then
				arg_229_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action3_2")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_232_4 = 0
			local var_232_5 = 0.05

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(1109403056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 2 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 2)

				if (2 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 2)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb")

						arg_229_1:RecordAudio("1109403056", var_232_11)
						arg_229_1:RecordAudio("1109403056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403056", "story_v_side_new_1109403.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play1109403057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1109403057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1109403058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1094ui_story"]) and arg_233_1.var_.characterEffect1094ui_story == nil then
				arg_233_1.var_.characterEffect1094ui_story = arg_233_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1094ui_story"]) then
				if arg_233_1.var_.characterEffect1094ui_story and not isNil(arg_233_1.actors_["1094ui_story"]) then
					arg_233_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1094ui_story"]) and arg_233_1.var_.characterEffect1094ui_story then
				arg_233_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.425

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(1109403057).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 17 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 17)

				if (17 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 17)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1109403058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1109403058
		arg_237_1.duration_ = 1.2

		local var_237_0 = {
			ja = 1.2,
			ko = 1.133,
			zh = 1.133
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1109403059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1094ui_story = arg_237_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1094ui_story"].transform.position).z)
				arg_237_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1094ui_story"].transform.localEulerAngles = arg_237_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1094ui_story"].transform.position).z)
				arg_237_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1094ui_story"].transform.localEulerAngles = arg_237_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_240_1 = 0
			local var_240_2 = 0.075

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(1109403058)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_6 = 3 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_4) / 3)

				if (3 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_4) / 3)) > 0 and var_240_2 < var_240_6 then
					arg_237_1.talkMaxDuration = var_240_6

					if var_240_6 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb") ~= 0 then
					local var_240_7 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb") / 1000

					if var_240_7 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_1
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb")

						arg_237_1:RecordAudio("1109403058", var_240_8)
						arg_237_1:RecordAudio("1109403058", var_240_8)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403058", "story_v_side_new_1109403.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_9 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_9 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_9

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_9 and arg_237_1.time_ < var_240_1 + var_240_9 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1109403059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1109403059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1109403060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_244_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_241_1.bgmTxt_.text ~= var_244_2 and arg_241_1.bgmTxt_.text ~= "" then
						if arg_241_1.bgmTxt2_.text ~= "" then
							arg_241_1.bgmTxt_.text = arg_241_1.bgmTxt2_.text
						end

						arg_241_1.bgmTxt2_.text = var_244_2

						arg_241_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_241_1.bgmTxt_.text = var_244_2
						arg_241_1.bgmTxt2_.text = var_244_2
					end

					if arg_241_1.bgmTimer then
						arg_241_1.bgmTimer:Stop()

						arg_241_1.bgmTimer = nil
					end

					if arg_241_1.settingData.show_music_name == 1 then
						arg_241_1.musicController:SetSelectedState("show")
						arg_241_1.musicAnimator_:Play("open", 0, 0)

						if arg_241_1.settingData.music_time ~= 0 then
							arg_241_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_241_1.settingData.music_time), function()
								if arg_241_1 == nil or isNil(arg_241_1.bgmTxt_) then
									return
								end

								arg_241_1.musicController:SetSelectedState("hide")
								arg_241_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_244_3 = 0
			local var_244_4 = 0.65

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_5 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(1109403059).content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 27 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 27)

				if (27 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 27)) > 0 and var_244_4 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_8 and arg_241_1.time_ < var_244_3 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1109403060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1109403060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1109403061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_249_0 = 0.5

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				local var_249_1, var_249_2 = math.modf((arg_246_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_249_2 * 0.13, var_249_2 * 0.13, var_249_2 * 0.13) + arg_246_1.var_.shakeOldPos
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				manager.ui.mainCamera.transform.localPosition = arg_246_1.var_.shakeOldPos
			end

			local var_249_3 = 0
			local var_249_4 = 0.1

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_3 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_5 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(1109403060).content)

				arg_246_1.text_.text = var_249_5

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 4 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_5) / 4)

				if (4 <= 0 and var_249_4 or var_249_4 * (utf8.len(var_249_5) / 4)) > 0 and var_249_4 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_3 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_3
					end
				end

				arg_246_1.text_.text = var_249_5
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_8 = math.max(var_249_4, arg_246_1.talkMaxDuration)

			if var_249_3 <= arg_246_1.time_ and arg_246_1.time_ < var_249_3 + var_249_8 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_3) / var_249_8

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_3 + var_249_8 and arg_246_1.time_ < var_249_3 + var_249_8 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1109403061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1109403061
		arg_250_1.duration_ = 7

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1109403062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if arg_250_1.bgs_.STblack == nil then
				local var_253_0 = Object.Instantiate(arg_250_1.paintGo_)

				var_253_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_253_0.name = "STblack"
				var_253_0.transform.parent = arg_250_1.stage_.transform
				var_253_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.bgs_.STblack = var_253_0
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				local var_253_1 = arg_250_1.bgs_.STblack

				arg_250_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_253_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_253_2 = var_253_1:GetComponent("SpriteRenderer")

				if var_253_2 and var_253_2.sprite then
					local var_253_3 = 2 * (var_253_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_253_1.transform.localScale = Vector3.New(var_253_3 / var_253_2.sprite.bounds.size.y < var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x and var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x or var_253_3 / var_253_2.sprite.bounds.size.y, var_253_3 / var_253_2.sprite.bounds.size.y < var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x and var_253_3 * manager.ui.mainCameraCom_.aspect / var_253_2.sprite.bounds.size.x or var_253_3 / var_253_2.sprite.bounds.size.y, 0)
				end

				for iter_253_0, iter_253_1 in pairs(arg_250_1.bgs_) do
					if iter_253_0 ~= "STblack" then
						iter_253_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_253_4 = 0

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.mask_.enabled = true
				arg_250_1.mask_.raycastTarget = true

				arg_250_1:SetGaussion(false)
			end

			local var_253_5 = 2

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_5 then
				local var_253_6 = Color.New(0, 0, 0)

				var_253_6.a = Mathf.Lerp(1, 0, (arg_250_1.time_ - var_253_4) / var_253_5)
				arg_250_1.mask_.color = var_253_6
			end

			if arg_250_1.time_ >= var_253_4 + var_253_5 and arg_250_1.time_ < var_253_4 + var_253_5 + arg_253_0 then
				local var_253_7 = Color.New(0, 0, 0)

				arg_250_1.mask_.enabled = false
				var_253_7.a = 0
				arg_250_1.mask_.color = var_253_7
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_8 = 2
			local var_253_9 = 1.125

			if 2 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_10 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_10:setOnUpdate(LuaHelper.FloatAction(function(arg_254_0)
					arg_250_1.dialogCg_.alpha = arg_254_0
				end))
				var_253_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_11 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(1109403061).content)

				arg_250_1.text_.text = var_253_11

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_13 = 53 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_11) / 53)

				if (53 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_11) / 53)) > 0 and var_253_9 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13
					var_253_8 = var_253_8 + 0.3

					if var_253_13 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_8
					end
				end

				arg_250_1.text_.text = var_253_11
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_14 = var_253_8 + 0.3
			local var_253_15 = math.max(var_253_9, arg_250_1.talkMaxDuration)

			if var_253_8 + 0.3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_14 + var_253_15 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_14) / var_253_15

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_14 + var_253_15 and arg_250_1.time_ < var_253_14 + var_253_15 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1109403062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1109403062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1109403063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.575

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(1109403062).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 23 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 23)

				if (23 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 23)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1109403063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1109403063
		arg_260_1.duration_ = 7

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1109403064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if arg_260_1.bgs_.ST12 == nil then
				local var_263_0 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_263_0.name = "ST12"
				var_263_0.transform.parent = arg_260_1.stage_.transform
				var_263_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_.ST12 = var_263_0
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				if arg_260_0.sceneSettingEffect_ then
					arg_260_1.sceneSettingEffect_.enabled = false
				end

				arg_260_1.sceneSettingGo_:SetActive(true)

				local var_263_1 = arg_260_1.bgs_.ST12

				arg_260_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_263_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_2 = var_263_1:GetComponent("SpriteRenderer")

				if var_263_2 and var_263_2.sprite then
					local var_263_3 = 2 * (var_263_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_263_1.transform.localScale = Vector3.New(var_263_3 / var_263_2.sprite.bounds.size.y < var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x and var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x or var_263_3 / var_263_2.sprite.bounds.size.y, var_263_3 / var_263_2.sprite.bounds.size.y < var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x and var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x or var_263_3 / var_263_2.sprite.bounds.size.y, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "ST12" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_4 = 0

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = true

				arg_260_1:SetGaussion(false)
			end

			local var_263_5 = 2

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_5 then
				local var_263_6 = Color.New(0, 0, 0)

				var_263_6.a = Mathf.Lerp(1, 0, (arg_260_1.time_ - var_263_4) / var_263_5)
				arg_260_1.mask_.color = var_263_6
			end

			if arg_260_1.time_ >= var_263_4 + var_263_5 and arg_260_1.time_ < var_263_4 + var_263_5 + arg_263_0 then
				local var_263_7 = Color.New(0, 0, 0)

				arg_260_1.mask_.enabled = false
				var_263_7.a = 0
				arg_260_1.mask_.color = var_263_7
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_8 = 2
			local var_263_9 = 0.725

			if 2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_10 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_10:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_11 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(1109403063).content)

				arg_260_1.text_.text = var_263_11

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_13 = 30 <= 0 and var_263_9 or var_263_9 * (utf8.len(var_263_11) / 30)

				if (30 <= 0 and var_263_9 or var_263_9 * (utf8.len(var_263_11) / 30)) > 0 and var_263_9 < var_263_13 then
					arg_260_1.talkMaxDuration = var_263_13
					var_263_8 = var_263_8 + 0.3

					if var_263_13 + var_263_8 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_13 + var_263_8
					end
				end

				arg_260_1.text_.text = var_263_11
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_14 = var_263_8 + 0.3
			local var_263_15 = math.max(var_263_9, arg_260_1.talkMaxDuration)

			if var_263_8 + 0.3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_14 + var_263_15 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_14) / var_263_15

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_14 + var_263_15 and arg_260_1.time_ < var_263_14 + var_263_15 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1109403064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1109403064
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1109403065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.25

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(1109403064).content)

				arg_266_1.text_.text = var_269_1

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_3 = 10 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 10)

				if (10 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 10)) > 0 and var_269_0 < var_269_3 then
					arg_266_1.talkMaxDuration = var_269_3

					if var_269_3 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_3 + 0
					end
				end

				arg_266_1.text_.text = var_269_1
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_4 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_4

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1109403065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1109403065
		arg_270_1.duration_ = 9.47

		local var_270_0 = {
			ja = 9.4,
			ko = 9.466,
			zh = 9.466
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1109403066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if arg_270_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_273_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_270_1.stage_.transform)

				var_273_0.name = "1038ui_story"
				var_273_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.actors_["1038ui_story"] = var_273_0

				local var_273_1 = var_273_0:GetComponentInChildren(typeof(CharacterEffect))

				var_273_1.enabled = true

				local var_273_2 = GameObjectTools.GetOrAddComponent(var_273_0, typeof(DynamicBoneHelper))

				if var_273_2 then
					var_273_2:EnableDynamicBone(false)
				end

				arg_270_1:ShowWeapon(var_273_1.transform, false)

				arg_270_1.var_["1038ui_story" .. "Animator"] = var_273_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_270_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_270_1.var_["1038ui_story" .. "LipSync"] = var_273_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_273_3 = arg_270_1.actors_["1038ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1038ui_story = var_273_3.localPosition
			end

			local var_273_4 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				var_273_3.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_270_1.time_ - 0) / var_273_4)
				var_273_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_3.position).x, (manager.ui.mainCamera.transform.position - var_273_3.position).y, (manager.ui.mainCamera.transform.position - var_273_3.position).z)
				var_273_3.localEulerAngles.z = 0
				var_273_3.localEulerAngles.x = 0
				var_273_3.localEulerAngles = var_273_3.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				var_273_3.localPosition = Vector3.New(0, -1.11, -5.9)
				var_273_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_3.position).x, (manager.ui.mainCamera.transform.position - var_273_3.position).y, (manager.ui.mainCamera.transform.position - var_273_3.position).z)
				var_273_3.localEulerAngles.z = 0
				var_273_3.localEulerAngles.x = 0
				var_273_3.localEulerAngles = var_273_3.localEulerAngles
			end

			local var_273_5 = arg_270_1.actors_["1038ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1038ui_story == nil then
				arg_270_1.var_.characterEffect1038ui_story = var_273_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_6 and not isNil(var_273_5) then
				if arg_270_1.var_.characterEffect1038ui_story and not isNil(var_273_5) then
					arg_270_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_6 and arg_270_1.time_ < 0 + var_273_6 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1038ui_story then
				arg_270_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				if arg_270_1.var_.characterEffect1038ui_story == nil then
					arg_270_1.var_.characterEffect1038ui_story = arg_270_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_273_8 = arg_270_1.var_.characterEffect1038ui_story

				arg_270_1.var_.characterEffect1038ui_story.imageEffect:turnOff()

				var_273_8.interferenceEffect.enabled = true
				var_273_8.interferenceEffect.noise = 0.001
				var_273_8.interferenceEffect.simTimeScale = 1
				var_273_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_273_9 = 0
			local var_273_10 = 1

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_11 = arg_270_1:GetWordFromCfg(1109403065)
				local var_273_12 = arg_270_1:FormatText(var_273_11.content)

				arg_270_1.text_.text = var_273_12

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_14 = 40 <= 0 and var_273_10 or var_273_10 * (utf8.len(var_273_12) / 40)

				if (40 <= 0 and var_273_10 or var_273_10 * (utf8.len(var_273_12) / 40)) > 0 and var_273_10 < var_273_14 then
					arg_270_1.talkMaxDuration = var_273_14

					if var_273_14 + var_273_9 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_9
					end
				end

				arg_270_1.text_.text = var_273_12
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb") ~= 0 then
					local var_273_15 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb") / 1000

					if var_273_15 + var_273_9 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_9
					end

					if var_273_11.prefab_name ~= "" and arg_270_1.actors_[var_273_11.prefab_name] ~= nil then
						local var_273_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_11.prefab_name].transform, "story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb")

						arg_270_1:RecordAudio("1109403065", var_273_16)
						arg_270_1:RecordAudio("1109403065", var_273_16)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403065", "story_v_side_new_1109403.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_17 = math.max(var_273_10, arg_270_1.talkMaxDuration)

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_17 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_9) / var_273_17

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_9 + var_273_17 and arg_270_1.time_ < var_273_9 + var_273_17 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play1109403066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1109403066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1109403067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1038ui_story"]) and arg_274_1.var_.characterEffect1038ui_story == nil then
				arg_274_1.var_.characterEffect1038ui_story = arg_274_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1038ui_story"]) then
				if arg_274_1.var_.characterEffect1038ui_story and not isNil(arg_274_1.actors_["1038ui_story"]) then
					arg_274_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1038ui_story"]) and arg_274_1.var_.characterEffect1038ui_story then
				arg_274_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_277_1 = 0
			local var_277_2 = 0.3

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(1109403066).content)

				arg_274_1.text_.text = var_277_3

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 12 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 12)

				if (12 <= 0 and var_277_2 or var_277_2 * (utf8.len(var_277_3) / 12)) > 0 and var_277_2 < var_277_5 then
					arg_274_1.talkMaxDuration = var_277_5

					if var_277_5 + var_277_1 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + var_277_1
					end
				end

				arg_274_1.text_.text = var_277_3
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_6 = math.max(var_277_2, arg_274_1.talkMaxDuration)

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_6 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_1) / var_277_6

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_1 + var_277_6 and arg_274_1.time_ < var_277_1 + var_277_6 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1109403067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1109403067
		arg_278_1.duration_ = 8.67

		local var_278_0 = {
			ja = 6.233,
			ko = 8.666,
			zh = 8.666
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1109403068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos1038ui_story = arg_278_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_281_0 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 then
				arg_278_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_278_1.time_ - 0) / var_281_0)
				arg_278_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1038ui_story"].transform.position).z)
				arg_278_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1038ui_story"].transform.localEulerAngles = arg_278_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 then
				arg_278_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_278_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["1038ui_story"].transform.position).z)
				arg_278_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["1038ui_story"].transform.localEulerAngles = arg_278_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_281_1 = arg_278_1.actors_["1038ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1038ui_story == nil then
				arg_278_1.var_.characterEffect1038ui_story = var_281_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_2 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_2 and not isNil(var_281_1) then
				if arg_278_1.var_.characterEffect1038ui_story and not isNil(var_281_1) then
					arg_278_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_2 and arg_278_1.time_ < 0 + var_281_2 + arg_281_0 and not isNil(var_281_1) and arg_278_1.var_.characterEffect1038ui_story then
				arg_278_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_281_4 = 0
			local var_281_5 = 1

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_6 = arg_278_1:GetWordFromCfg(1109403067)
				local var_281_7 = arg_278_1:FormatText(var_281_6.content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 39 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 39)

				if (39 <= 0 and var_281_5 or var_281_5 * (utf8.len(var_281_7) / 39)) > 0 and var_281_5 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_4
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb") ~= 0 then
					local var_281_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb") / 1000

					if var_281_10 + var_281_4 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_4
					end

					if var_281_6.prefab_name ~= "" and arg_278_1.actors_[var_281_6.prefab_name] ~= nil then
						local var_281_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_6.prefab_name].transform, "story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb")

						arg_278_1:RecordAudio("1109403067", var_281_11)
						arg_278_1:RecordAudio("1109403067", var_281_11)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403067", "story_v_side_new_1109403.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_12 = math.max(var_281_5, arg_278_1.talkMaxDuration)

			if var_281_4 <= arg_278_1.time_ and arg_278_1.time_ < var_281_4 + var_281_12 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_4) / var_281_12

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_4 + var_281_12 and arg_278_1.time_ < var_281_4 + var_281_12 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play1109403068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1109403068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1109403069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1038ui_story"]) and arg_282_1.var_.characterEffect1038ui_story == nil then
				arg_282_1.var_.characterEffect1038ui_story = arg_282_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1038ui_story"]) then
				if arg_282_1.var_.characterEffect1038ui_story and not isNil(arg_282_1.actors_["1038ui_story"]) then
					arg_282_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_0)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1038ui_story"]) and arg_282_1.var_.characterEffect1038ui_story then
				arg_282_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_285_1 = 0
			local var_285_2 = 0.575

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1109403068).content)

				arg_282_1.text_.text = var_285_3

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 23 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 23)

				if (23 <= 0 and var_285_2 or var_285_2 * (utf8.len(var_285_3) / 23)) > 0 and var_285_2 < var_285_5 then
					arg_282_1.talkMaxDuration = var_285_5

					if var_285_5 + var_285_1 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_5 + var_285_1
					end
				end

				arg_282_1.text_.text = var_285_3
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_6 = math.max(var_285_2, arg_282_1.talkMaxDuration)

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_6 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_1) / var_285_6

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_1 + var_285_6 and arg_282_1.time_ < var_285_1 + var_285_6 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1109403069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1109403069
		arg_286_1.duration_ = 12

		local var_286_0 = {
			ja = 10.066,
			ko = 12,
			zh = 12
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1109403070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1038ui_story = arg_286_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_289_0 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 then
				arg_286_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_286_1.time_ - 0) / var_289_0)
				arg_286_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1038ui_story"].transform.position).z)
				arg_286_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1038ui_story"].transform.localEulerAngles = arg_286_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 then
				arg_286_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_286_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1038ui_story"].transform.position).z)
				arg_286_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1038ui_story"].transform.localEulerAngles = arg_286_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_289_1 = arg_286_1.actors_["1038ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1038ui_story == nil then
				arg_286_1.var_.characterEffect1038ui_story = var_289_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_2 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_2 and not isNil(var_289_1) then
				if arg_286_1.var_.characterEffect1038ui_story and not isNil(var_289_1) then
					arg_286_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_2 and arg_286_1.time_ < 0 + var_289_2 + arg_289_0 and not isNil(var_289_1) and arg_286_1.var_.characterEffect1038ui_story then
				arg_286_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action456")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_289_4 = 0
			local var_289_5 = 1.25

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_4 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_6 = arg_286_1:GetWordFromCfg(1109403069)
				local var_289_7 = arg_286_1:FormatText(var_289_6.content)

				arg_286_1.text_.text = var_289_7

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_9 = 50 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 50)

				if (50 <= 0 and var_289_5 or var_289_5 * (utf8.len(var_289_7) / 50)) > 0 and var_289_5 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_4
					end
				end

				arg_286_1.text_.text = var_289_7
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb") ~= 0 then
					local var_289_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb") / 1000

					if var_289_10 + var_289_4 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_4
					end

					if var_289_6.prefab_name ~= "" and arg_286_1.actors_[var_289_6.prefab_name] ~= nil then
						local var_289_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_6.prefab_name].transform, "story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb")

						arg_286_1:RecordAudio("1109403069", var_289_11)
						arg_286_1:RecordAudio("1109403069", var_289_11)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403069", "story_v_side_new_1109403.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_12 = math.max(var_289_5, arg_286_1.talkMaxDuration)

			if var_289_4 <= arg_286_1.time_ and arg_286_1.time_ < var_289_4 + var_289_12 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_4) / var_289_12

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_4 + var_289_12 and arg_286_1.time_ < var_289_4 + var_289_12 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play1109403070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1109403070
		arg_290_1.duration_ = 7.47

		local var_290_0 = {
			ja = 7.466,
			ko = 3.3,
			zh = 3.3
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1109403071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos1038ui_story = arg_290_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_293_0 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				arg_290_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_290_1.time_ - 0) / var_293_0)
				arg_290_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1038ui_story"].transform.position).z)
				arg_290_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1038ui_story"].transform.localEulerAngles = arg_290_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				arg_290_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_290_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1038ui_story"].transform.position).z)
				arg_290_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1038ui_story"].transform.localEulerAngles = arg_290_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_293_1 = arg_290_1.actors_["1038ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_1) and arg_290_1.var_.characterEffect1038ui_story == nil then
				arg_290_1.var_.characterEffect1038ui_story = var_293_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_2 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_2 and not isNil(var_293_1) then
				if arg_290_1.var_.characterEffect1038ui_story and not isNil(var_293_1) then
					arg_290_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_2 and arg_290_1.time_ < 0 + var_293_2 + arg_293_0 and not isNil(var_293_1) and arg_290_1.var_.characterEffect1038ui_story then
				arg_290_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_293_4 = 0
			local var_293_5 = 0.35

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_6 = arg_290_1:GetWordFromCfg(1109403070)
				local var_293_7 = arg_290_1:FormatText(var_293_6.content)

				arg_290_1.text_.text = var_293_7

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_9 = 14 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 14)

				if (14 <= 0 and var_293_5 or var_293_5 * (utf8.len(var_293_7) / 14)) > 0 and var_293_5 < var_293_9 then
					arg_290_1.talkMaxDuration = var_293_9

					if var_293_9 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_9 + var_293_4
					end
				end

				arg_290_1.text_.text = var_293_7
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb") ~= 0 then
					local var_293_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb") / 1000

					if var_293_10 + var_293_4 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_4
					end

					if var_293_6.prefab_name ~= "" and arg_290_1.actors_[var_293_6.prefab_name] ~= nil then
						local var_293_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_6.prefab_name].transform, "story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb")

						arg_290_1:RecordAudio("1109403070", var_293_11)
						arg_290_1:RecordAudio("1109403070", var_293_11)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403070", "story_v_side_new_1109403.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_12 = math.max(var_293_5, arg_290_1.talkMaxDuration)

			if var_293_4 <= arg_290_1.time_ and arg_290_1.time_ < var_293_4 + var_293_12 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_4) / var_293_12

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_4 + var_293_12 and arg_290_1.time_ < var_293_4 + var_293_12 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play1109403071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1109403071
		arg_294_1.duration_ = 0.2

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"

			SetActive(arg_294_1.choicesGo_, true)

			for iter_295_0, iter_295_1 in ipairs(arg_294_1.choices_) do
				SetActive(iter_295_1.go, iter_295_0 <= 1)
			end

			arg_294_1.choices_[1].txt.text = arg_294_1:FormatText(StoryChoiceCfg[409].name)
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1109403072(arg_294_1)
			end

			arg_294_1:RecordChoiceLog(1109403071, 409)
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1038ui_story"]) and arg_294_1.var_.characterEffect1038ui_story == nil then
				arg_294_1.var_.characterEffect1038ui_story = arg_294_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1038ui_story"]) then
				if arg_294_1.var_.characterEffect1038ui_story and not isNil(arg_294_1.actors_["1038ui_story"]) then
					arg_294_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_0)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1038ui_story"]) and arg_294_1.var_.characterEffect1038ui_story then
				arg_294_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_297_1 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.allBtn_.enabled = false
			end

			if arg_294_1.time_ >= var_297_1 + 0.200000002980232 and arg_294_1.time_ < var_297_1 + 0.200000002980232 + arg_297_0 then
				arg_294_1.allBtn_.enabled = true
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1109403072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1109403072
		arg_298_1.duration_ = 2.63

		local var_298_0 = {
			ja = 2.633,
			ko = 2.133,
			zh = 2.133
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1109403073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1038ui_story = arg_298_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_301_0 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				arg_298_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1038ui_story"].transform.position).z)
				arg_298_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1038ui_story"].transform.localEulerAngles = arg_298_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				arg_298_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_298_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1038ui_story"].transform.position).z)
				arg_298_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1038ui_story"].transform.localEulerAngles = arg_298_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_301_1 = arg_298_1.actors_["1038ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect1038ui_story == nil then
				arg_298_1.var_.characterEffect1038ui_story = var_301_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_2 and not isNil(var_301_1) then
				if arg_298_1.var_.characterEffect1038ui_story and not isNil(var_301_1) then
					arg_298_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 0 + var_301_2 and arg_298_1.time_ < 0 + var_301_2 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect1038ui_story then
				arg_298_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_301_4 = 0
			local var_301_5 = 0.175

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_6 = arg_298_1:GetWordFromCfg(1109403072)
				local var_301_7 = arg_298_1:FormatText(var_301_6.content)

				arg_298_1.text_.text = var_301_7

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_9 = 7 <= 0 and var_301_5 or var_301_5 * (utf8.len(var_301_7) / 7)

				if (7 <= 0 and var_301_5 or var_301_5 * (utf8.len(var_301_7) / 7)) > 0 and var_301_5 < var_301_9 then
					arg_298_1.talkMaxDuration = var_301_9

					if var_301_9 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_9 + var_301_4
					end
				end

				arg_298_1.text_.text = var_301_7
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb") ~= 0 then
					local var_301_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb") / 1000

					if var_301_10 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_10 + var_301_4
					end

					if var_301_6.prefab_name ~= "" and arg_298_1.actors_[var_301_6.prefab_name] ~= nil then
						local var_301_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_6.prefab_name].transform, "story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb")

						arg_298_1:RecordAudio("1109403072", var_301_11)
						arg_298_1:RecordAudio("1109403072", var_301_11)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403072", "story_v_side_new_1109403.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_12 = math.max(var_301_5, arg_298_1.talkMaxDuration)

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_12 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_4) / var_301_12

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_4 + var_301_12 and arg_298_1.time_ < var_301_4 + var_301_12 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play1109403073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1109403073
		arg_302_1.duration_ = 9.33

		local var_302_0 = {
			ja = 6.7,
			ko = 9.333,
			zh = 9.333
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1109403074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1038ui_story = arg_302_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1038ui_story"].transform.position).z)
				arg_302_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1038ui_story"].transform.localEulerAngles = arg_302_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_302_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1038ui_story"].transform.position).z)
				arg_302_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1038ui_story"].transform.localEulerAngles = arg_302_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["1038ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1038ui_story == nil then
				arg_302_1.var_.characterEffect1038ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1038ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1038ui_story then
				arg_302_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038actionlink/1038action467")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_305_4 = 0
			local var_305_5 = 1.025

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_4 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_6 = arg_302_1:GetWordFromCfg(1109403073)
				local var_305_7 = arg_302_1:FormatText(var_305_6.content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 41 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 41)

				if (41 <= 0 and var_305_5 or var_305_5 * (utf8.len(var_305_7) / 41)) > 0 and var_305_5 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_4
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb") / 1000

					if var_305_10 + var_305_4 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_4
					end

					if var_305_6.prefab_name ~= "" and arg_302_1.actors_[var_305_6.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_6.prefab_name].transform, "story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb")

						arg_302_1:RecordAudio("1109403073", var_305_11)
						arg_302_1:RecordAudio("1109403073", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403073", "story_v_side_new_1109403.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_5, arg_302_1.talkMaxDuration)

			if var_305_4 <= arg_302_1.time_ and arg_302_1.time_ < var_305_4 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_4) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_4 + var_305_12 and arg_302_1.time_ < var_305_4 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play1109403074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1109403074
		arg_306_1.duration_ = 20.7

		local var_306_0 = {
			ja = 20.7,
			ko = 14.066,
			zh = 14.066
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1109403075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos1038ui_story = arg_306_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_309_0 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 then
				arg_306_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_306_1.time_ - 0) / var_309_0)
				arg_306_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1038ui_story"].transform.position).z)
				arg_306_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1038ui_story"].transform.localEulerAngles = arg_306_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 then
				arg_306_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_306_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_306_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_306_1.actors_["1038ui_story"].transform.position).z)
				arg_306_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_306_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_306_1.actors_["1038ui_story"].transform.localEulerAngles = arg_306_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_309_1 = arg_306_1.actors_["1038ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_1) and arg_306_1.var_.characterEffect1038ui_story == nil then
				arg_306_1.var_.characterEffect1038ui_story = var_309_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_2 and not isNil(var_309_1) then
				if arg_306_1.var_.characterEffect1038ui_story and not isNil(var_309_1) then
					arg_306_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_2 and arg_306_1.time_ < 0 + var_309_2 + arg_309_0 and not isNil(var_309_1) and arg_306_1.var_.characterEffect1038ui_story then
				arg_306_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_309_4 = 0
			local var_309_5 = 1.675

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_6 = arg_306_1:GetWordFromCfg(1109403074)
				local var_309_7 = arg_306_1:FormatText(var_309_6.content)

				arg_306_1.text_.text = var_309_7

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_9 = 67 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_7) / 67)

				if (67 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_7) / 67)) > 0 and var_309_5 < var_309_9 then
					arg_306_1.talkMaxDuration = var_309_9

					if var_309_9 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_9 + var_309_4
					end
				end

				arg_306_1.text_.text = var_309_7
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb") ~= 0 then
					local var_309_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb") / 1000

					if var_309_10 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_4
					end

					if var_309_6.prefab_name ~= "" and arg_306_1.actors_[var_309_6.prefab_name] ~= nil then
						local var_309_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_6.prefab_name].transform, "story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb")

						arg_306_1:RecordAudio("1109403074", var_309_11)
						arg_306_1:RecordAudio("1109403074", var_309_11)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403074", "story_v_side_new_1109403.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_12 = math.max(var_309_5, arg_306_1.talkMaxDuration)

			if var_309_4 <= arg_306_1.time_ and arg_306_1.time_ < var_309_4 + var_309_12 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_4) / var_309_12

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_4 + var_309_12 and arg_306_1.time_ < var_309_4 + var_309_12 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play1109403075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1109403075
		arg_310_1.duration_ = 0.2

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"

			SetActive(arg_310_1.choicesGo_, true)

			for iter_311_0, iter_311_1 in ipairs(arg_310_1.choices_) do
				SetActive(iter_311_1.go, iter_311_0 <= 1)
			end

			arg_310_1.choices_[1].txt.text = arg_310_1:FormatText(StoryChoiceCfg[410].name)
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1109403076(arg_310_1)
			end

			arg_310_1:RecordChoiceLog(1109403075, 410)
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1038ui_story"]) and arg_310_1.var_.characterEffect1038ui_story == nil then
				arg_310_1.var_.characterEffect1038ui_story = arg_310_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1038ui_story"]) then
				if arg_310_1.var_.characterEffect1038ui_story and not isNil(arg_310_1.actors_["1038ui_story"]) then
					arg_310_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_310_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_0)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1038ui_story"]) and arg_310_1.var_.characterEffect1038ui_story then
				arg_310_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_310_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_313_1 = 0

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.allBtn_.enabled = false
			end

			if arg_310_1.time_ >= var_313_1 + 0.200000002980232 and arg_310_1.time_ < var_313_1 + 0.200000002980232 + arg_313_0 then
				arg_310_1.allBtn_.enabled = true
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1109403076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1109403076
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1109403077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos1038ui_story = arg_314_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_317_0 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 then
				arg_314_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_314_1.time_ - 0) / var_317_0)
				arg_314_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1038ui_story"].transform.position).z)
				arg_314_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["1038ui_story"].transform.localEulerAngles = arg_314_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 then
				arg_314_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_314_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["1038ui_story"].transform.position).z)
				arg_314_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["1038ui_story"].transform.localEulerAngles = arg_314_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_317_1 = arg_314_1.actors_["1038ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect1038ui_story == nil then
				arg_314_1.var_.characterEffect1038ui_story = var_317_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_2 and not isNil(var_317_1) then
				if arg_314_1.var_.characterEffect1038ui_story and not isNil(var_317_1) then
					arg_314_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_2)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_2 and arg_314_1.time_ < 0 + var_317_2 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect1038ui_story then
				arg_314_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_317_3 = 0
			local var_317_4 = 0.9

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_3 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_5 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(1109403076).content)

				arg_314_1.text_.text = var_317_5

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_7 = 36 <= 0 and var_317_4 or var_317_4 * (utf8.len(var_317_5) / 36)

				if (36 <= 0 and var_317_4 or var_317_4 * (utf8.len(var_317_5) / 36)) > 0 and var_317_4 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_3 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_3
					end
				end

				arg_314_1.text_.text = var_317_5
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_8 = math.max(var_317_4, arg_314_1.talkMaxDuration)

			if var_317_3 <= arg_314_1.time_ and arg_314_1.time_ < var_317_3 + var_317_8 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_3) / var_317_8

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_3 + var_317_8 and arg_314_1.time_ < var_317_3 + var_317_8 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play1109403077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1109403077
		arg_318_1.duration_ = 13.13

		local var_318_0 = {
			ja = 7.933,
			ko = 13.133,
			zh = 13.133
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1109403078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 2 < arg_318_1.time_ and arg_318_1.time_ <= 2 + arg_321_0 then
				local var_321_0 = arg_318_1.bgs_.ST01

				arg_318_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_321_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_1 = var_321_0:GetComponent("SpriteRenderer")

				if var_321_1 and var_321_1.sprite then
					local var_321_2 = 2 * (var_321_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_321_0.transform.localScale = Vector3.New(var_321_2 / var_321_1.sprite.bounds.size.y < var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x and var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x or var_321_2 / var_321_1.sprite.bounds.size.y, var_321_2 / var_321_1.sprite.bounds.size.y < var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x and var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x or var_321_2 / var_321_1.sprite.bounds.size.y, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "ST01" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_321_3 = 0

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_3 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_4 = 2

			if var_321_3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_3 + var_321_4 then
				local var_321_5 = Color.New(0, 0, 0)

				var_321_5.a = Mathf.Lerp(0, 1, (arg_318_1.time_ - var_321_3) / var_321_4)
				arg_318_1.mask_.color = var_321_5
			end

			if arg_318_1.time_ >= var_321_3 + var_321_4 and arg_318_1.time_ < var_321_3 + var_321_4 + arg_321_0 then
				local var_321_6 = Color.New(0, 0, 0)

				var_321_6.a = 1
				arg_318_1.mask_.color = var_321_6
			end

			local var_321_7 = 2

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= var_321_7 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = true

				arg_318_1:SetGaussion(false)
			end

			local var_321_8 = 2

			if var_321_7 <= arg_318_1.time_ and arg_318_1.time_ < var_321_7 + var_321_8 then
				local var_321_9 = Color.New(0, 0, 0)

				var_321_9.a = Mathf.Lerp(1, 0, (arg_318_1.time_ - var_321_7) / var_321_8)
				arg_318_1.mask_.color = var_321_9
			end

			if arg_318_1.time_ >= var_321_7 + var_321_8 and arg_318_1.time_ < var_321_7 + var_321_8 + arg_321_0 then
				local var_321_10 = Color.New(0, 0, 0)

				arg_318_1.mask_.enabled = false
				var_321_10.a = 0
				arg_318_1.mask_.color = var_321_10
			end

			local var_321_11 = arg_318_1.actors_["1094ui_story"].transform

			if 4 < arg_318_1.time_ and arg_318_1.time_ <= 4 + arg_321_0 then
				arg_318_1.var_.moveOldPos1094ui_story = var_321_11.localPosition
			end

			local var_321_12 = 0.001

			if 4 <= arg_318_1.time_ and arg_318_1.time_ < 4 + var_321_12 then
				var_321_11.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_318_1.time_ - 4) / var_321_12)
				var_321_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_11.position).x, (manager.ui.mainCamera.transform.position - var_321_11.position).y, (manager.ui.mainCamera.transform.position - var_321_11.position).z)
				var_321_11.localEulerAngles.z = 0
				var_321_11.localEulerAngles.x = 0
				var_321_11.localEulerAngles = var_321_11.localEulerAngles
			end

			if arg_318_1.time_ >= 4 + var_321_12 and arg_318_1.time_ < 4 + var_321_12 + arg_321_0 then
				var_321_11.localPosition = Vector3.New(0, -0.84, -6.1)
				var_321_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_321_11.position).x, (manager.ui.mainCamera.transform.position - var_321_11.position).y, (manager.ui.mainCamera.transform.position - var_321_11.position).z)
				var_321_11.localEulerAngles.z = 0
				var_321_11.localEulerAngles.x = 0
				var_321_11.localEulerAngles = var_321_11.localEulerAngles
			end

			local var_321_13 = arg_318_1.actors_["1094ui_story"]

			if 4 < arg_318_1.time_ and arg_318_1.time_ <= 4 + arg_321_0 and not isNil(var_321_13) and arg_318_1.var_.characterEffect1094ui_story == nil then
				arg_318_1.var_.characterEffect1094ui_story = var_321_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_14 = 0.200000002980232

			if 4 <= arg_318_1.time_ and arg_318_1.time_ < 4 + var_321_14 and not isNil(var_321_13) then
				if arg_318_1.var_.characterEffect1094ui_story and not isNil(var_321_13) then
					arg_318_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_318_1.time_ >= 4 + var_321_14 and arg_318_1.time_ < 4 + var_321_14 + arg_321_0 and not isNil(var_321_13) and arg_318_1.var_.characterEffect1094ui_story then
				arg_318_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 4 < arg_318_1.time_ and arg_318_1.time_ <= 4 + arg_321_0 then
				arg_318_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 4 < arg_318_1.time_ and arg_318_1.time_ <= 4 + arg_321_0 then
				arg_318_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_321_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_318_1.bgmTxt_.text ~= var_321_18 and arg_318_1.bgmTxt_.text ~= "" then
						if arg_318_1.bgmTxt2_.text ~= "" then
							arg_318_1.bgmTxt_.text = arg_318_1.bgmTxt2_.text
						end

						arg_318_1.bgmTxt2_.text = var_321_18

						arg_318_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_318_1.bgmTxt_.text = var_321_18
						arg_318_1.bgmTxt2_.text = var_321_18
					end

					if arg_318_1.bgmTimer then
						arg_318_1.bgmTimer:Stop()

						arg_318_1.bgmTimer = nil
					end

					if arg_318_1.settingData.show_music_name == 1 then
						arg_318_1.musicController:SetSelectedState("show")
						arg_318_1.musicAnimator_:Play("open", 0, 0)

						if arg_318_1.settingData.music_time ~= 0 then
							arg_318_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_318_1.settingData.music_time), function()
								if arg_318_1 == nil or isNil(arg_318_1.bgmTxt_) then
									return
								end

								arg_318_1.musicController:SetSelectedState("hide")
								arg_318_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 3.63333333333333 < arg_318_1.time_ and arg_318_1.time_ <= 3.63333333333333 + arg_321_0 then
				arg_318_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_321_21 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_318_1.bgmTxt_.text ~= var_321_21 and arg_318_1.bgmTxt_.text ~= "" then
						if arg_318_1.bgmTxt2_.text ~= "" then
							arg_318_1.bgmTxt_.text = arg_318_1.bgmTxt2_.text
						end

						arg_318_1.bgmTxt2_.text = var_321_21

						arg_318_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_318_1.bgmTxt_.text = var_321_21
						arg_318_1.bgmTxt2_.text = var_321_21
					end

					if arg_318_1.bgmTimer then
						arg_318_1.bgmTimer:Stop()

						arg_318_1.bgmTimer = nil
					end

					if arg_318_1.settingData.show_music_name == 1 then
						arg_318_1.musicController:SetSelectedState("show")
						arg_318_1.musicAnimator_:Play("open", 0, 0)

						if arg_318_1.settingData.music_time ~= 0 then
							arg_318_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_318_1.settingData.music_time), function()
								if arg_318_1 == nil or isNil(arg_318_1.bgmTxt_) then
									return
								end

								arg_318_1.musicController:SetSelectedState("hide")
								arg_318_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_318_1.frameCnt_ <= 1 then
				arg_318_1.dialog_:SetActive(false)
			end

			local var_321_22 = 4
			local var_321_23 = 0.75

			if 4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_22 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0

				arg_318_1.dialog_:SetActive(true)

				arg_318_1.dialogCg_.alpha = 0

				local var_321_24 = LeanTween.value(arg_318_1.dialog_, 0, 1, 0.3)

				var_321_24:setOnUpdate(LuaHelper.FloatAction(function(arg_324_0)
					arg_318_1.dialogCg_.alpha = arg_324_0
				end))
				var_321_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_318_1.dialog_)
					var_321_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_318_1.duration_ = arg_318_1.duration_ + 0.3

				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_25 = arg_318_1:GetWordFromCfg(1109403077)
				local var_321_26 = arg_318_1:FormatText(var_321_25.content)

				arg_318_1.text_.text = var_321_26

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_28 = 30 <= 0 and var_321_23 or var_321_23 * (utf8.len(var_321_26) / 30)

				if (30 <= 0 and var_321_23 or var_321_23 * (utf8.len(var_321_26) / 30)) > 0 and var_321_23 < var_321_28 then
					arg_318_1.talkMaxDuration = var_321_28
					var_321_22 = var_321_22 + 0.3

					if var_321_28 + var_321_22 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_28 + var_321_22
					end
				end

				arg_318_1.text_.text = var_321_26
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb") ~= 0 then
					local var_321_29 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb") / 1000

					if var_321_29 + var_321_22 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_29 + var_321_22
					end

					if var_321_25.prefab_name ~= "" and arg_318_1.actors_[var_321_25.prefab_name] ~= nil then
						local var_321_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_25.prefab_name].transform, "story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb")

						arg_318_1:RecordAudio("1109403077", var_321_30)
						arg_318_1:RecordAudio("1109403077", var_321_30)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403077", "story_v_side_new_1109403.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_31 = var_321_22 + 0.3
			local var_321_32 = math.max(var_321_23, arg_318_1.talkMaxDuration)

			if var_321_22 + 0.3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_31 + var_321_32 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_31) / var_321_32

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_31 + var_321_32 and arg_318_1.time_ < var_321_31 + var_321_32 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play1109403078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1109403078
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1109403079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["1094ui_story"]) and arg_326_1.var_.characterEffect1094ui_story == nil then
				arg_326_1.var_.characterEffect1094ui_story = arg_326_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_0 = 0.200000002980232

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["1094ui_story"]) then
				if arg_326_1.var_.characterEffect1094ui_story and not isNil(arg_326_1.actors_["1094ui_story"]) then
					arg_326_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_326_1.time_ - 0) / var_329_0)
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["1094ui_story"]) and arg_326_1.var_.characterEffect1094ui_story then
				arg_326_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_329_1 = 0
			local var_329_2 = 0.55

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_3 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(1109403078).content)

				arg_326_1.text_.text = var_329_3

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 22 <= 0 and var_329_2 or var_329_2 * (utf8.len(var_329_3) / 22)

				if (22 <= 0 and var_329_2 or var_329_2 * (utf8.len(var_329_3) / 22)) > 0 and var_329_2 < var_329_5 then
					arg_326_1.talkMaxDuration = var_329_5

					if var_329_5 + var_329_1 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_5 + var_329_1
					end
				end

				arg_326_1.text_.text = var_329_3
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_6 = math.max(var_329_2, arg_326_1.talkMaxDuration)

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_6 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_1) / var_329_6

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_1 + var_329_6 and arg_326_1.time_ < var_329_1 + var_329_6 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play1109403079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1109403079
		arg_330_1.duration_ = 3.97

		local var_330_0 = {
			ja = 3.6,
			ko = 3.966,
			zh = 3.966
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
				arg_330_0:Play1109403080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos1094ui_story = arg_330_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_333_0 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 then
				arg_330_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_330_1.time_ - 0) / var_333_0)
				arg_330_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1094ui_story"].transform.position).z)
				arg_330_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1094ui_story"].transform.localEulerAngles = arg_330_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 then
				arg_330_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_330_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_330_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_330_1.actors_["1094ui_story"].transform.position).z)
				arg_330_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_330_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_330_1.actors_["1094ui_story"].transform.localEulerAngles = arg_330_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_333_1 = arg_330_1.actors_["1094ui_story"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1094ui_story == nil then
				arg_330_1.var_.characterEffect1094ui_story = var_333_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_2 and not isNil(var_333_1) then
				if arg_330_1.var_.characterEffect1094ui_story and not isNil(var_333_1) then
					arg_330_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_330_1.time_ >= 0 + var_333_2 and arg_330_1.time_ < 0 + var_333_2 + arg_333_0 and not isNil(var_333_1) and arg_330_1.var_.characterEffect1094ui_story then
				arg_330_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_333_4 = 0
			local var_333_5 = 0.3

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_4 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_6 = arg_330_1:GetWordFromCfg(1109403079)
				local var_333_7 = arg_330_1:FormatText(var_333_6.content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 12 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 12)

				if (12 <= 0 and var_333_5 or var_333_5 * (utf8.len(var_333_7) / 12)) > 0 and var_333_5 < var_333_9 then
					arg_330_1.talkMaxDuration = var_333_9

					if var_333_9 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_9 + var_333_4
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb") ~= 0 then
					local var_333_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb") / 1000

					if var_333_10 + var_333_4 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_4
					end

					if var_333_6.prefab_name ~= "" and arg_330_1.actors_[var_333_6.prefab_name] ~= nil then
						local var_333_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_6.prefab_name].transform, "story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb")

						arg_330_1:RecordAudio("1109403079", var_333_11)
						arg_330_1:RecordAudio("1109403079", var_333_11)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403079", "story_v_side_new_1109403.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_12 = math.max(var_333_5, arg_330_1.talkMaxDuration)

			if var_333_4 <= arg_330_1.time_ and arg_330_1.time_ < var_333_4 + var_333_12 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_4) / var_333_12

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_4 + var_333_12 and arg_330_1.time_ < var_333_4 + var_333_12 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play1109403080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1109403080
		arg_334_1.duration_ = 4.9

		local var_334_0 = {
			ja = 4.9,
			ko = 3.3,
			zh = 3.3
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
				arg_334_0:Play1109403081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1094ui_story"]) and arg_334_1.var_.characterEffect1094ui_story == nil then
				arg_334_1.var_.characterEffect1094ui_story = arg_334_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_0 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1094ui_story"]) then
				if arg_334_1.var_.characterEffect1094ui_story and not isNil(arg_334_1.actors_["1094ui_story"]) then
					arg_334_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_0)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1094ui_story"]) and arg_334_1.var_.characterEffect1094ui_story then
				arg_334_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_337_1 = 0
			local var_337_2 = 0.35

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_3 = arg_334_1:GetWordFromCfg(1109403080)
				local var_337_4 = arg_334_1:FormatText(var_337_3.content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_6 = 14 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_4) / 14)

				if (14 <= 0 and var_337_2 or var_337_2 * (utf8.len(var_337_4) / 14)) > 0 and var_337_2 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_1
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb") ~= 0 then
					local var_337_7 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb") / 1000

					if var_337_7 + var_337_1 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_7 + var_337_1
					end

					if var_337_3.prefab_name ~= "" and arg_334_1.actors_[var_337_3.prefab_name] ~= nil then
						local var_337_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_3.prefab_name].transform, "story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb")

						arg_334_1:RecordAudio("1109403080", var_337_8)
						arg_334_1:RecordAudio("1109403080", var_337_8)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403080", "story_v_side_new_1109403.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_9 = math.max(var_337_2, arg_334_1.talkMaxDuration)

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_9 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_1) / var_337_9

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_1 + var_337_9 and arg_334_1.time_ < var_337_1 + var_337_9 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play1109403081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1109403081
		arg_338_1.duration_ = 3.07

		local var_338_0 = {
			ja = 3.066,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_338_0:Play1109403082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1094ui_story = arg_338_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_341_0 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 then
				arg_338_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_338_1.time_ - 0) / var_341_0)
				arg_338_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1094ui_story"].transform.position).z)
				arg_338_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["1094ui_story"].transform.localEulerAngles = arg_338_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 then
				arg_338_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_338_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["1094ui_story"].transform.position).z)
				arg_338_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["1094ui_story"].transform.localEulerAngles = arg_338_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_341_1 = arg_338_1.actors_["1094ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect1094ui_story == nil then
				arg_338_1.var_.characterEffect1094ui_story = var_341_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_2 and not isNil(var_341_1) then
				if arg_338_1.var_.characterEffect1094ui_story and not isNil(var_341_1) then
					arg_338_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= 0 + var_341_2 and arg_338_1.time_ < 0 + var_341_2 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect1094ui_story then
				arg_338_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_341_4 = 0
			local var_341_5 = 0.225

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_6 = arg_338_1:GetWordFromCfg(1109403081)
				local var_341_7 = arg_338_1:FormatText(var_341_6.content)

				arg_338_1.text_.text = var_341_7

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 9 <= 0 and var_341_5 or var_341_5 * (utf8.len(var_341_7) / 9)

				if (9 <= 0 and var_341_5 or var_341_5 * (utf8.len(var_341_7) / 9)) > 0 and var_341_5 < var_341_9 then
					arg_338_1.talkMaxDuration = var_341_9

					if var_341_9 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_7
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb") ~= 0 then
					local var_341_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb") / 1000

					if var_341_10 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_4
					end

					if var_341_6.prefab_name ~= "" and arg_338_1.actors_[var_341_6.prefab_name] ~= nil then
						local var_341_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_6.prefab_name].transform, "story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb")

						arg_338_1:RecordAudio("1109403081", var_341_11)
						arg_338_1:RecordAudio("1109403081", var_341_11)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403081", "story_v_side_new_1109403.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_12 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_12 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_12

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_12 and arg_338_1.time_ < var_341_4 + var_341_12 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play1109403082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1109403082
		arg_342_1.duration_ = 9.17

		local var_342_0 = {
			ja = 9.166,
			ko = 6.266,
			zh = 6.266
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1109403083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1094ui_story"]) and arg_342_1.var_.characterEffect1094ui_story == nil then
				arg_342_1.var_.characterEffect1094ui_story = arg_342_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_0 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1094ui_story"]) then
				if arg_342_1.var_.characterEffect1094ui_story and not isNil(arg_342_1.actors_["1094ui_story"]) then
					arg_342_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_342_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_342_1.time_ - 0) / var_345_0)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1094ui_story"]) and arg_342_1.var_.characterEffect1094ui_story then
				arg_342_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_342_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_345_1 = 0
			local var_345_2 = 0.8

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_3 = arg_342_1:GetWordFromCfg(1109403082)
				local var_345_4 = arg_342_1:FormatText(var_345_3.content)

				arg_342_1.text_.text = var_345_4

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_6 = 32 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_4) / 32)

				if (32 <= 0 and var_345_2 or var_345_2 * (utf8.len(var_345_4) / 32)) > 0 and var_345_2 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_1
					end
				end

				arg_342_1.text_.text = var_345_4
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb") ~= 0 then
					local var_345_7 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb") / 1000

					if var_345_7 + var_345_1 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_1
					end

					if var_345_3.prefab_name ~= "" and arg_342_1.actors_[var_345_3.prefab_name] ~= nil then
						local var_345_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_3.prefab_name].transform, "story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb")

						arg_342_1:RecordAudio("1109403082", var_345_8)
						arg_342_1:RecordAudio("1109403082", var_345_8)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403082", "story_v_side_new_1109403.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_9 = math.max(var_345_2, arg_342_1.talkMaxDuration)

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_9 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_1) / var_345_9

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_1 + var_345_9 and arg_342_1.time_ < var_345_1 + var_345_9 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1109403083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1109403083
		arg_346_1.duration_ = 4.8

		local var_346_0 = {
			ja = 4.8,
			ko = 2.8,
			zh = 2.8
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1109403084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0.325

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_1 = arg_346_1:GetWordFromCfg(1109403083)
				local var_349_2 = arg_346_1:FormatText(var_349_1.content)

				arg_346_1.text_.text = var_349_2

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_4 = 13 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_2) / 13)

				if (13 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_2) / 13)) > 0 and var_349_0 < var_349_4 then
					arg_346_1.talkMaxDuration = var_349_4

					if var_349_4 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_4 + 0
					end
				end

				arg_346_1.text_.text = var_349_2
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb") ~= 0 then
					local var_349_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb") / 1000

					if var_349_5 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_5 + 0
					end

					if var_349_1.prefab_name ~= "" and arg_346_1.actors_[var_349_1.prefab_name] ~= nil then
						local var_349_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_1.prefab_name].transform, "story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb")

						arg_346_1:RecordAudio("1109403083", var_349_6)
						arg_346_1:RecordAudio("1109403083", var_349_6)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403083", "story_v_side_new_1109403.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_7 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_7 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_7

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_7 and arg_346_1.time_ < 0 + var_349_7 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1109403084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1109403084
		arg_350_1.duration_ = 2

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1109403085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos1094ui_story = arg_350_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_353_0 = 0.001

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 then
				arg_350_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_350_1.time_ - 0) / var_353_0)
				arg_350_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1094ui_story"].transform.position).z)
				arg_350_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1094ui_story"].transform.localEulerAngles = arg_350_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 then
				arg_350_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_350_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_350_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_350_1.actors_["1094ui_story"].transform.position).z)
				arg_350_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_350_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_350_1.actors_["1094ui_story"].transform.localEulerAngles = arg_350_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_353_1 = arg_350_1.actors_["1094ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect1094ui_story == nil then
				arg_350_1.var_.characterEffect1094ui_story = var_353_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_2 and not isNil(var_353_1) then
				if arg_350_1.var_.characterEffect1094ui_story and not isNil(var_353_1) then
					arg_350_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_2 and arg_350_1.time_ < 0 + var_353_2 + arg_353_0 and not isNil(var_353_1) and arg_350_1.var_.characterEffect1094ui_story then
				arg_350_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_353_4 = 0
			local var_353_5 = 0.1

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_6 = arg_350_1:GetWordFromCfg(1109403084)
				local var_353_7 = arg_350_1:FormatText(var_353_6.content)

				arg_350_1.text_.text = var_353_7

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_9 = 4 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 4)

				if (4 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 4)) > 0 and var_353_5 < var_353_9 then
					arg_350_1.talkMaxDuration = var_353_9

					if var_353_9 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_9 + var_353_4
					end
				end

				arg_350_1.text_.text = var_353_7
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb") ~= 0 then
					local var_353_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb") / 1000

					if var_353_10 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_4
					end

					if var_353_6.prefab_name ~= "" and arg_350_1.actors_[var_353_6.prefab_name] ~= nil then
						local var_353_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_6.prefab_name].transform, "story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb")

						arg_350_1:RecordAudio("1109403084", var_353_11)
						arg_350_1:RecordAudio("1109403084", var_353_11)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403084", "story_v_side_new_1109403.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_12 = math.max(var_353_5, arg_350_1.talkMaxDuration)

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_12 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_4) / var_353_12

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_4 + var_353_12 and arg_350_1.time_ < var_353_4 + var_353_12 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play1109403085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1109403085
		arg_354_1.duration_ = 2.73

		local var_354_0 = {
			ja = 2.733,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1109403086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1094ui_story = arg_354_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_357_0 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				arg_354_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1094ui_story"].transform.position).z)
				arg_354_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1094ui_story"].transform.localEulerAngles = arg_354_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				arg_354_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_354_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1094ui_story"].transform.position).z)
				arg_354_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1094ui_story"].transform.localEulerAngles = arg_354_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_357_1 = arg_354_1.actors_["1094ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect1094ui_story == nil then
				arg_354_1.var_.characterEffect1094ui_story = var_357_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_2 and not isNil(var_357_1) then
				if arg_354_1.var_.characterEffect1094ui_story and not isNil(var_357_1) then
					arg_354_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= 0 + var_357_2 and arg_354_1.time_ < 0 + var_357_2 + arg_357_0 and not isNil(var_357_1) and arg_354_1.var_.characterEffect1094ui_story then
				arg_354_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_357_4 = 0
			local var_357_5 = 0.125

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_6 = arg_354_1:GetWordFromCfg(1109403085)
				local var_357_7 = arg_354_1:FormatText(var_357_6.content)

				arg_354_1.text_.text = var_357_7

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_9 = 5 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 5)

				if (5 <= 0 and var_357_5 or var_357_5 * (utf8.len(var_357_7) / 5)) > 0 and var_357_5 < var_357_9 then
					arg_354_1.talkMaxDuration = var_357_9

					if var_357_9 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_9 + var_357_4
					end
				end

				arg_354_1.text_.text = var_357_7
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb") ~= 0 then
					local var_357_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb") / 1000

					if var_357_10 + var_357_4 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_4
					end

					if var_357_6.prefab_name ~= "" and arg_354_1.actors_[var_357_6.prefab_name] ~= nil then
						local var_357_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_6.prefab_name].transform, "story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb")

						arg_354_1:RecordAudio("1109403085", var_357_11)
						arg_354_1:RecordAudio("1109403085", var_357_11)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403085", "story_v_side_new_1109403.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_12 = math.max(var_357_5, arg_354_1.talkMaxDuration)

			if var_357_4 <= arg_354_1.time_ and arg_354_1.time_ < var_357_4 + var_357_12 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_4) / var_357_12

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_4 + var_357_12 and arg_354_1.time_ < var_357_4 + var_357_12 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play1109403086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1109403086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1109403087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1094ui_story"]) and arg_358_1.var_.characterEffect1094ui_story == nil then
				arg_358_1.var_.characterEffect1094ui_story = arg_358_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_0 = 0.200000002980232

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1094ui_story"]) then
				if arg_358_1.var_.characterEffect1094ui_story and not isNil(arg_358_1.actors_["1094ui_story"]) then
					arg_358_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_358_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_358_1.time_ - 0) / var_361_0)
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1094ui_story"]) and arg_358_1.var_.characterEffect1094ui_story then
				arg_358_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_358_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_361_1 = 0
			local var_361_2 = 0.3

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, true)
				arg_358_1.iconController_:SetSelectedState("hero")

				arg_358_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_358_1.callingController_:SetSelectedState("normal")

				arg_358_1.keyicon_.color = Color.New(1, 1, 1)
				arg_358_1.icon_.color = Color.New(1, 1, 1)

				local var_361_3 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(1109403086).content)

				arg_358_1.text_.text = var_361_3

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_5 = 12 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_3) / 12)

				if (12 <= 0 and var_361_2 or var_361_2 * (utf8.len(var_361_3) / 12)) > 0 and var_361_2 < var_361_5 then
					arg_358_1.talkMaxDuration = var_361_5

					if var_361_5 + var_361_1 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_5 + var_361_1
					end
				end

				arg_358_1.text_.text = var_361_3
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_6 = math.max(var_361_2, arg_358_1.talkMaxDuration)

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_6 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_1) / var_361_6

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_1 + var_361_6 and arg_358_1.time_ < var_361_1 + var_361_6 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1109403087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1109403087
		arg_362_1.duration_ = 9.2

		local var_362_0 = {
			ja = 9.2,
			ko = 5.366,
			zh = 5.366
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1109403088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.625

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_1 = arg_362_1:GetWordFromCfg(1109403087)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 25 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 25)

				if (25 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 25)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb")

						arg_362_1:RecordAudio("1109403087", var_365_6)
						arg_362_1:RecordAudio("1109403087", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403087", "story_v_side_new_1109403.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1109403088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1109403088
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1109403089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 1.125

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, true)
				arg_366_1.iconController_:SetSelectedState("hero")

				arg_366_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_366_1.callingController_:SetSelectedState("normal")

				arg_366_1.keyicon_.color = Color.New(1, 1, 1)
				arg_366_1.icon_.color = Color.New(1, 1, 1)

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(1109403088).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 45 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 45)

				if (45 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 45)) > 0 and var_369_0 < var_369_3 then
					arg_366_1.talkMaxDuration = var_369_3

					if var_369_3 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_3 + 0
					end
				end

				arg_366_1.text_.text = var_369_1
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_4 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_4

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1109403089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1109403089
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1109403090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.55

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_1 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(1109403089).content)

				arg_370_1.text_.text = var_373_1

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_3 = 22 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 22)

				if (22 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 22)) > 0 and var_373_0 < var_373_3 then
					arg_370_1.talkMaxDuration = var_373_3

					if var_373_3 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_3 + 0
					end
				end

				arg_370_1.text_.text = var_373_1
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_4 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_4

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1109403090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1109403090
		arg_374_1.duration_ = 2.03

		local var_374_0 = {
			ja = 1.999999999999,
			ko = 2.033,
			zh = 2.033
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1109403091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1094ui_story = arg_374_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_377_0 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 then
				arg_374_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_374_1.time_ - 0) / var_377_0)
				arg_374_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1094ui_story"].transform.position).z)
				arg_374_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1094ui_story"].transform.localEulerAngles = arg_374_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 then
				arg_374_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_374_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_374_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_374_1.actors_["1094ui_story"].transform.position).z)
				arg_374_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_374_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_374_1.actors_["1094ui_story"].transform.localEulerAngles = arg_374_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_377_1 = arg_374_1.actors_["1094ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1094ui_story == nil then
				arg_374_1.var_.characterEffect1094ui_story = var_377_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_2 and not isNil(var_377_1) then
				if arg_374_1.var_.characterEffect1094ui_story and not isNil(var_377_1) then
					arg_374_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_2 and arg_374_1.time_ < 0 + var_377_2 + arg_377_0 and not isNil(var_377_1) and arg_374_1.var_.characterEffect1094ui_story then
				arg_374_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_1")
			end

			local var_377_4 = 0
			local var_377_5 = 0.075

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_6 = arg_374_1:GetWordFromCfg(1109403090)
				local var_377_7 = arg_374_1:FormatText(var_377_6.content)

				arg_374_1.text_.text = var_377_7

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_9 = 3 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 3)

				if (3 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 3)) > 0 and var_377_5 < var_377_9 then
					arg_374_1.talkMaxDuration = var_377_9

					if var_377_9 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_9 + var_377_4
					end
				end

				arg_374_1.text_.text = var_377_7
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb") ~= 0 then
					local var_377_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb") / 1000

					if var_377_10 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_4
					end

					if var_377_6.prefab_name ~= "" and arg_374_1.actors_[var_377_6.prefab_name] ~= nil then
						local var_377_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_6.prefab_name].transform, "story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb")

						arg_374_1:RecordAudio("1109403090", var_377_11)
						arg_374_1:RecordAudio("1109403090", var_377_11)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403090", "story_v_side_new_1109403.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_12 = math.max(var_377_5, arg_374_1.talkMaxDuration)

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_12 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_4) / var_377_12

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_4 + var_377_12 and arg_374_1.time_ < var_377_4 + var_377_12 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play1109403091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1109403091
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1109403092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(arg_378_1.actors_["1094ui_story"]) and arg_378_1.var_.characterEffect1094ui_story == nil then
				arg_378_1.var_.characterEffect1094ui_story = arg_378_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_0 = 0.200000002980232

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 and not isNil(arg_378_1.actors_["1094ui_story"]) then
				if arg_378_1.var_.characterEffect1094ui_story and not isNil(arg_378_1.actors_["1094ui_story"]) then
					arg_378_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_378_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_378_1.time_ - 0) / var_381_0)
				end
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 and not isNil(arg_378_1.actors_["1094ui_story"]) and arg_378_1.var_.characterEffect1094ui_story then
				arg_378_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_378_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_381_1 = 0
			local var_381_2 = 0.95

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, false)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_3 = arg_378_1:FormatText(arg_378_1:GetWordFromCfg(1109403091).content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 38 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 38)

				if (38 <= 0 and var_381_2 or var_381_2 * (utf8.len(var_381_3) / 38)) > 0 and var_381_2 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_1 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_1
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_6 = math.max(var_381_2, arg_378_1.talkMaxDuration)

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_6 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_1) / var_381_6

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_1 + var_381_6 and arg_378_1.time_ < var_381_1 + var_381_6 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1109403092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1109403092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1109403093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.175

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_1 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(1109403092).content)

				arg_382_1.text_.text = var_385_1

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_3 = 7 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 7)

				if (7 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 7)) > 0 and var_385_0 < var_385_3 then
					arg_382_1.talkMaxDuration = var_385_3

					if var_385_3 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_3 + 0
					end
				end

				arg_382_1.text_.text = var_385_1
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_4 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_4

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1109403093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1109403093
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1109403094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.3

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(1109403093).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 12 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 12)

				if (12 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 12)) > 0 and var_389_0 < var_389_3 then
					arg_386_1.talkMaxDuration = var_389_3

					if var_389_3 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_3 + 0
					end
				end

				arg_386_1.text_.text = var_389_1
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_4 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_4

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1109403094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1109403094
		arg_390_1.duration_ = 4.23

		local var_390_0 = {
			ja = 1.999999999999,
			ko = 4.233,
			zh = 4.233
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1109403095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1094ui_story = arg_390_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_393_0 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				arg_390_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1094ui_story"].transform.position).z)
				arg_390_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1094ui_story"].transform.localEulerAngles = arg_390_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				arg_390_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_390_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1094ui_story"].transform.position).z)
				arg_390_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1094ui_story"].transform.localEulerAngles = arg_390_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_393_1 = arg_390_1.actors_["1094ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_1) and arg_390_1.var_.characterEffect1094ui_story == nil then
				arg_390_1.var_.characterEffect1094ui_story = var_393_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_2 and not isNil(var_393_1) then
				if arg_390_1.var_.characterEffect1094ui_story and not isNil(var_393_1) then
					arg_390_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_2 and arg_390_1.time_ < 0 + var_393_2 + arg_393_0 and not isNil(var_393_1) and arg_390_1.var_.characterEffect1094ui_story then
				arg_390_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action5_2")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_393_4 = 0
			local var_393_5 = 0.275

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_4 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_6 = arg_390_1:GetWordFromCfg(1109403094)
				local var_393_7 = arg_390_1:FormatText(var_393_6.content)

				arg_390_1.text_.text = var_393_7

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_9 = 11 <= 0 and var_393_5 or var_393_5 * (utf8.len(var_393_7) / 11)

				if (11 <= 0 and var_393_5 or var_393_5 * (utf8.len(var_393_7) / 11)) > 0 and var_393_5 < var_393_9 then
					arg_390_1.talkMaxDuration = var_393_9

					if var_393_9 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_9 + var_393_4
					end
				end

				arg_390_1.text_.text = var_393_7
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb") ~= 0 then
					local var_393_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb") / 1000

					if var_393_10 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_4
					end

					if var_393_6.prefab_name ~= "" and arg_390_1.actors_[var_393_6.prefab_name] ~= nil then
						local var_393_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_6.prefab_name].transform, "story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb")

						arg_390_1:RecordAudio("1109403094", var_393_11)
						arg_390_1:RecordAudio("1109403094", var_393_11)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403094", "story_v_side_new_1109403.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_12 = math.max(var_393_5, arg_390_1.talkMaxDuration)

			if var_393_4 <= arg_390_1.time_ and arg_390_1.time_ < var_393_4 + var_393_12 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_4) / var_393_12

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_4 + var_393_12 and arg_390_1.time_ < var_393_4 + var_393_12 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play1109403095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1109403095
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1109403096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(arg_394_1.actors_["1094ui_story"]) and arg_394_1.var_.characterEffect1094ui_story == nil then
				arg_394_1.var_.characterEffect1094ui_story = arg_394_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_0 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 and not isNil(arg_394_1.actors_["1094ui_story"]) then
				if arg_394_1.var_.characterEffect1094ui_story and not isNil(arg_394_1.actors_["1094ui_story"]) then
					arg_394_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_0)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 and not isNil(arg_394_1.actors_["1094ui_story"]) and arg_394_1.var_.characterEffect1094ui_story then
				arg_394_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_397_1 = 0
			local var_397_2 = 0.275

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(1109403095).content)

				arg_394_1.text_.text = var_397_3

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 11 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 11)

				if (11 <= 0 and var_397_2 or var_397_2 * (utf8.len(var_397_3) / 11)) > 0 and var_397_2 < var_397_5 then
					arg_394_1.talkMaxDuration = var_397_5

					if var_397_5 + var_397_1 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + var_397_1
					end
				end

				arg_394_1.text_.text = var_397_3
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_6 = math.max(var_397_2, arg_394_1.talkMaxDuration)

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_6 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_1) / var_397_6

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_1 + var_397_6 and arg_394_1.time_ < var_397_1 + var_397_6 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1109403096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1109403096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1109403097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0.95

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(1109403096).content)

				arg_398_1.text_.text = var_401_1

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_3 = 38 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 38)

				if (38 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 38)) > 0 and var_401_0 < var_401_3 then
					arg_398_1.talkMaxDuration = var_401_3

					if var_401_3 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_3 + 0
					end
				end

				arg_398_1.text_.text = var_401_1
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_4 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_4 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_4

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_4 and arg_398_1.time_ < 0 + var_401_4 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1109403097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1109403097
		arg_402_1.duration_ = 8.13

		local var_402_0 = {
			ja = 8.133,
			ko = 5.566,
			zh = 5.566
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1109403098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.625

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:GetWordFromCfg(1109403097)
				local var_405_2 = arg_402_1:FormatText(var_405_1.content)

				arg_402_1.text_.text = var_405_2

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_4 = 25 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 25)

				if (25 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_2) / 25)) > 0 and var_405_0 < var_405_4 then
					arg_402_1.talkMaxDuration = var_405_4

					if var_405_4 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_4 + 0
					end
				end

				arg_402_1.text_.text = var_405_2
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb") ~= 0 then
					local var_405_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb") / 1000

					if var_405_5 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_5 + 0
					end

					if var_405_1.prefab_name ~= "" and arg_402_1.actors_[var_405_1.prefab_name] ~= nil then
						local var_405_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_1.prefab_name].transform, "story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb")

						arg_402_1:RecordAudio("1109403097", var_405_6)
						arg_402_1:RecordAudio("1109403097", var_405_6)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403097", "story_v_side_new_1109403.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_7 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_7

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1109403098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1109403098
		arg_406_1.duration_ = 2.93

		local var_406_0 = {
			ja = 2.233,
			ko = 2.933,
			zh = 2.933
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1109403099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1094ui_story = arg_406_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_409_0 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 then
				arg_406_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_406_1.time_ - 0) / var_409_0)
				arg_406_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1094ui_story"].transform.position).z)
				arg_406_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1094ui_story"].transform.localEulerAngles = arg_406_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 then
				arg_406_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_406_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1094ui_story"].transform.position).z)
				arg_406_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1094ui_story"].transform.localEulerAngles = arg_406_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_409_1 = arg_406_1.actors_["1094ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_1) and arg_406_1.var_.characterEffect1094ui_story == nil then
				arg_406_1.var_.characterEffect1094ui_story = var_409_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_2 and not isNil(var_409_1) then
				if arg_406_1.var_.characterEffect1094ui_story and not isNil(var_409_1) then
					arg_406_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_2 and arg_406_1.time_ < 0 + var_409_2 + arg_409_0 and not isNil(var_409_1) and arg_406_1.var_.characterEffect1094ui_story then
				arg_406_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_409_4 = 0
			local var_409_5 = 0.15

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_6 = arg_406_1:GetWordFromCfg(1109403098)
				local var_409_7 = arg_406_1:FormatText(var_409_6.content)

				arg_406_1.text_.text = var_409_7

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 6 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 6)

				if (6 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 6)) > 0 and var_409_5 < var_409_9 then
					arg_406_1.talkMaxDuration = var_409_9

					if var_409_9 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_9 + var_409_4
					end
				end

				arg_406_1.text_.text = var_409_7
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb") ~= 0 then
					local var_409_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb") / 1000

					if var_409_10 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_4
					end

					if var_409_6.prefab_name ~= "" and arg_406_1.actors_[var_409_6.prefab_name] ~= nil then
						local var_409_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_6.prefab_name].transform, "story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb")

						arg_406_1:RecordAudio("1109403098", var_409_11)
						arg_406_1:RecordAudio("1109403098", var_409_11)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403098", "story_v_side_new_1109403.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_12 = math.max(var_409_5, arg_406_1.talkMaxDuration)

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_12 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_4) / var_409_12

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_4 + var_409_12 and arg_406_1.time_ < var_409_4 + var_409_12 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play1109403099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 1109403099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play1109403100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1094ui_story"]) and arg_410_1.var_.characterEffect1094ui_story == nil then
				arg_410_1.var_.characterEffect1094ui_story = arg_410_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.200000002980232

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1094ui_story"]) then
				if arg_410_1.var_.characterEffect1094ui_story and not isNil(arg_410_1.actors_["1094ui_story"]) then
					arg_410_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 0) / var_413_0)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1094ui_story"]) and arg_410_1.var_.characterEffect1094ui_story then
				arg_410_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_413_1 = 0
			local var_413_2 = 0.725

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(1109403099).content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 29 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 29)

				if (29 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 29)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_6 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_6 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_6

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_6 and arg_410_1.time_ < var_413_1 + var_413_6 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play1109403100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 1109403100
		arg_414_1.duration_ = 6.3

		local var_414_0 = {
			ja = 5.5,
			ko = 6.3,
			zh = 6.3
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play1109403101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1094ui_story = arg_414_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_417_0 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 then
				arg_414_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_414_1.time_ - 0) / var_417_0)
				arg_414_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1094ui_story"].transform.position).z)
				arg_414_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1094ui_story"].transform.localEulerAngles = arg_414_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 then
				arg_414_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_414_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1094ui_story"].transform.position).z)
				arg_414_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1094ui_story"].transform.localEulerAngles = arg_414_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_417_1 = arg_414_1.actors_["1094ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_1) and arg_414_1.var_.characterEffect1094ui_story == nil then
				arg_414_1.var_.characterEffect1094ui_story = var_417_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_2 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_2 and not isNil(var_417_1) then
				if arg_414_1.var_.characterEffect1094ui_story and not isNil(var_417_1) then
					arg_414_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_414_1.time_ >= 0 + var_417_2 and arg_414_1.time_ < 0 + var_417_2 + arg_417_0 and not isNil(var_417_1) and arg_414_1.var_.characterEffect1094ui_story then
				arg_414_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_417_4 = 0
			local var_417_5 = 0.35

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_4 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				arg_414_1.leftNameTxt_.text = arg_414_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_6 = arg_414_1:GetWordFromCfg(1109403100)
				local var_417_7 = arg_414_1:FormatText(var_417_6.content)

				arg_414_1.text_.text = var_417_7

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_9 = 14 <= 0 and var_417_5 or var_417_5 * (utf8.len(var_417_7) / 14)

				if (14 <= 0 and var_417_5 or var_417_5 * (utf8.len(var_417_7) / 14)) > 0 and var_417_5 < var_417_9 then
					arg_414_1.talkMaxDuration = var_417_9

					if var_417_9 + var_417_4 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_9 + var_417_4
					end
				end

				arg_414_1.text_.text = var_417_7
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb") ~= 0 then
					local var_417_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb") / 1000

					if var_417_10 + var_417_4 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_10 + var_417_4
					end

					if var_417_6.prefab_name ~= "" and arg_414_1.actors_[var_417_6.prefab_name] ~= nil then
						local var_417_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_6.prefab_name].transform, "story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb")

						arg_414_1:RecordAudio("1109403100", var_417_11)
						arg_414_1:RecordAudio("1109403100", var_417_11)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403100", "story_v_side_new_1109403.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_12 = math.max(var_417_5, arg_414_1.talkMaxDuration)

			if var_417_4 <= arg_414_1.time_ and arg_414_1.time_ < var_417_4 + var_417_12 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_4) / var_417_12

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_4 + var_417_12 and arg_414_1.time_ < var_417_4 + var_417_12 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play1109403101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 1109403101
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play1109403102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(arg_418_1.actors_["1094ui_story"]) and arg_418_1.var_.characterEffect1094ui_story == nil then
				arg_418_1.var_.characterEffect1094ui_story = arg_418_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_0 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 and not isNil(arg_418_1.actors_["1094ui_story"]) then
				if arg_418_1.var_.characterEffect1094ui_story and not isNil(arg_418_1.actors_["1094ui_story"]) then
					arg_418_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_418_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_418_1.time_ - 0) / var_421_0)
				end
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 and not isNil(arg_418_1.actors_["1094ui_story"]) and arg_418_1.var_.characterEffect1094ui_story then
				arg_418_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_418_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_421_1 = 0
			local var_421_2 = 0.45

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_3 = arg_418_1:FormatText(arg_418_1:GetWordFromCfg(1109403101).content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 18 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 18)

				if (18 <= 0 and var_421_2 or var_421_2 * (utf8.len(var_421_3) / 18)) > 0 and var_421_2 < var_421_5 then
					arg_418_1.talkMaxDuration = var_421_5

					if var_421_5 + var_421_1 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_5 + var_421_1
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_6 = math.max(var_421_2, arg_418_1.talkMaxDuration)

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_6 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_1) / var_421_6

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_1 + var_421_6 and arg_418_1.time_ < var_421_1 + var_421_6 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play1109403102 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 1109403102
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play1109403103(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0.425

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_1 = arg_422_1:FormatText(arg_422_1:GetWordFromCfg(1109403102).content)

				arg_422_1.text_.text = var_425_1

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_3 = 17 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 17)

				if (17 <= 0 and var_425_0 or var_425_0 * (utf8.len(var_425_1) / 17)) > 0 and var_425_0 < var_425_3 then
					arg_422_1.talkMaxDuration = var_425_3

					if var_425_3 + 0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_3 + 0
					end
				end

				arg_422_1.text_.text = var_425_1
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_4 = math.max(var_425_0, arg_422_1.talkMaxDuration)

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - 0) / var_425_4

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play1109403103 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 1109403103
		arg_426_1.duration_ = 3.03

		local var_426_0 = {
			ja = 1.999999999999,
			ko = 3.033,
			zh = 3.033
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play1109403104(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1.var_.moveOldPos1094ui_story = arg_426_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_429_0 = 0.001

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 then
				arg_426_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_426_1.time_ - 0) / var_429_0)
				arg_426_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1094ui_story"].transform.position).z)
				arg_426_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["1094ui_story"].transform.localEulerAngles = arg_426_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 then
				arg_426_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_426_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_426_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_426_1.actors_["1094ui_story"].transform.position).z)
				arg_426_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_426_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_426_1.actors_["1094ui_story"].transform.localEulerAngles = arg_426_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_429_1 = arg_426_1.actors_["1094ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect1094ui_story == nil then
				arg_426_1.var_.characterEffect1094ui_story = var_429_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_2 and not isNil(var_429_1) then
				if arg_426_1.var_.characterEffect1094ui_story and not isNil(var_429_1) then
					arg_426_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= 0 + var_429_2 and arg_426_1.time_ < 0 + var_429_2 + arg_429_0 and not isNil(var_429_1) and arg_426_1.var_.characterEffect1094ui_story then
				arg_426_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 then
				arg_426_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_429_4 = 0
			local var_429_5 = 0.175

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_4 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_6 = arg_426_1:GetWordFromCfg(1109403103)
				local var_429_7 = arg_426_1:FormatText(var_429_6.content)

				arg_426_1.text_.text = var_429_7

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_9 = 7 <= 0 and var_429_5 or var_429_5 * (utf8.len(var_429_7) / 7)

				if (7 <= 0 and var_429_5 or var_429_5 * (utf8.len(var_429_7) / 7)) > 0 and var_429_5 < var_429_9 then
					arg_426_1.talkMaxDuration = var_429_9

					if var_429_9 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_9 + var_429_4
					end
				end

				arg_426_1.text_.text = var_429_7
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb") ~= 0 then
					local var_429_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb") / 1000

					if var_429_10 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_10 + var_429_4
					end

					if var_429_6.prefab_name ~= "" and arg_426_1.actors_[var_429_6.prefab_name] ~= nil then
						local var_429_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_6.prefab_name].transform, "story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb")

						arg_426_1:RecordAudio("1109403103", var_429_11)
						arg_426_1:RecordAudio("1109403103", var_429_11)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403103", "story_v_side_new_1109403.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_12 = math.max(var_429_5, arg_426_1.talkMaxDuration)

			if var_429_4 <= arg_426_1.time_ and arg_426_1.time_ < var_429_4 + var_429_12 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_4) / var_429_12

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_4 + var_429_12 and arg_426_1.time_ < var_429_4 + var_429_12 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play1109403104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1109403104
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1109403105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1094ui_story"]) and arg_430_1.var_.characterEffect1094ui_story == nil then
				arg_430_1.var_.characterEffect1094ui_story = arg_430_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1094ui_story"]) then
				if arg_430_1.var_.characterEffect1094ui_story and not isNil(arg_430_1.actors_["1094ui_story"]) then
					arg_430_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_430_1.time_ - 0) / var_433_0)
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1094ui_story"]) and arg_430_1.var_.characterEffect1094ui_story then
				arg_430_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_433_1 = 0
			local var_433_2 = 0.975

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_3 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(1109403104).content)

				arg_430_1.text_.text = var_433_3

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 39 <= 0 and var_433_2 or var_433_2 * (utf8.len(var_433_3) / 39)

				if (39 <= 0 and var_433_2 or var_433_2 * (utf8.len(var_433_3) / 39)) > 0 and var_433_2 < var_433_5 then
					arg_430_1.talkMaxDuration = var_433_5

					if var_433_5 + var_433_1 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_5 + var_433_1
					end
				end

				arg_430_1.text_.text = var_433_3
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_6 = math.max(var_433_2, arg_430_1.talkMaxDuration)

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_6 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_1) / var_433_6

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_1 + var_433_6 and arg_430_1.time_ < var_433_1 + var_433_6 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1109403105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1109403105
		arg_434_1.duration_ = 2.07

		local var_434_0 = {
			ja = 1.999999999999,
			ko = 2.066,
			zh = 2.066
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1109403106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1094ui_story = arg_434_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_437_0 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 then
				arg_434_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_434_1.time_ - 0) / var_437_0)
				arg_434_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1094ui_story"].transform.position).z)
				arg_434_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1094ui_story"].transform.localEulerAngles = arg_434_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 then
				arg_434_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_434_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1094ui_story"].transform.position).z)
				arg_434_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1094ui_story"].transform.localEulerAngles = arg_434_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_437_1 = arg_434_1.actors_["1094ui_story"]

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(var_437_1) and arg_434_1.var_.characterEffect1094ui_story == nil then
				arg_434_1.var_.characterEffect1094ui_story = var_437_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_2 and not isNil(var_437_1) then
				if arg_434_1.var_.characterEffect1094ui_story and not isNil(var_437_1) then
					arg_434_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_434_1.time_ >= 0 + var_437_2 and arg_434_1.time_ < 0 + var_437_2 + arg_437_0 and not isNil(var_437_1) and arg_434_1.var_.characterEffect1094ui_story then
				arg_434_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_437_4 = 0
			local var_437_5 = 0.075

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_4 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_6 = arg_434_1:GetWordFromCfg(1109403105)
				local var_437_7 = arg_434_1:FormatText(var_437_6.content)

				arg_434_1.text_.text = var_437_7

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_9 = 3 <= 0 and var_437_5 or var_437_5 * (utf8.len(var_437_7) / 3)

				if (3 <= 0 and var_437_5 or var_437_5 * (utf8.len(var_437_7) / 3)) > 0 and var_437_5 < var_437_9 then
					arg_434_1.talkMaxDuration = var_437_9

					if var_437_9 + var_437_4 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_9 + var_437_4
					end
				end

				arg_434_1.text_.text = var_437_7
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb") ~= 0 then
					local var_437_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb") / 1000

					if var_437_10 + var_437_4 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_10 + var_437_4
					end

					if var_437_6.prefab_name ~= "" and arg_434_1.actors_[var_437_6.prefab_name] ~= nil then
						local var_437_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_6.prefab_name].transform, "story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb")

						arg_434_1:RecordAudio("1109403105", var_437_11)
						arg_434_1:RecordAudio("1109403105", var_437_11)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403105", "story_v_side_new_1109403.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_12 = math.max(var_437_5, arg_434_1.talkMaxDuration)

			if var_437_4 <= arg_434_1.time_ and arg_434_1.time_ < var_437_4 + var_437_12 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_4) / var_437_12

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_4 + var_437_12 and arg_434_1.time_ < var_437_4 + var_437_12 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play1109403106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1109403106
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1109403107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(arg_438_1.actors_["1094ui_story"]) and arg_438_1.var_.characterEffect1094ui_story == nil then
				arg_438_1.var_.characterEffect1094ui_story = arg_438_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_0 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 and not isNil(arg_438_1.actors_["1094ui_story"]) then
				if arg_438_1.var_.characterEffect1094ui_story and not isNil(arg_438_1.actors_["1094ui_story"]) then
					arg_438_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_438_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_438_1.time_ - 0) / var_441_0)
				end
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 and not isNil(arg_438_1.actors_["1094ui_story"]) and arg_438_1.var_.characterEffect1094ui_story then
				arg_438_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_438_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_441_1 = 0
			local var_441_2 = 0.2

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:FormatText(arg_438_1:GetWordFromCfg(1109403106).content)

				arg_438_1.text_.text = var_441_3

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 8 <= 0 and var_441_2 or var_441_2 * (utf8.len(var_441_3) / 8)

				if (8 <= 0 and var_441_2 or var_441_2 * (utf8.len(var_441_3) / 8)) > 0 and var_441_2 < var_441_5 then
					arg_438_1.talkMaxDuration = var_441_5

					if var_441_5 + var_441_1 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + var_441_1
					end
				end

				arg_438_1.text_.text = var_441_3
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_6 = math.max(var_441_2, arg_438_1.talkMaxDuration)

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_6 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_1) / var_441_6

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_1 + var_441_6 and arg_438_1.time_ < var_441_1 + var_441_6 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play1109403107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1109403107
		arg_442_1.duration_ = 4.33

		local var_442_0 = {
			ja = 2.266,
			ko = 4.333,
			zh = 4.333
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1109403108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1094ui_story = arg_442_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_445_0 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 then
				arg_442_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_442_1.time_ - 0) / var_445_0)
				arg_442_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1094ui_story"].transform.position).z)
				arg_442_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["1094ui_story"].transform.localEulerAngles = arg_442_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 then
				arg_442_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_442_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["1094ui_story"].transform.position).z)
				arg_442_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["1094ui_story"].transform.localEulerAngles = arg_442_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_445_1 = arg_442_1.actors_["1094ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect1094ui_story == nil then
				arg_442_1.var_.characterEffect1094ui_story = var_445_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_2 and not isNil(var_445_1) then
				if arg_442_1.var_.characterEffect1094ui_story and not isNil(var_445_1) then
					arg_442_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_2 and arg_442_1.time_ < 0 + var_445_2 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect1094ui_story then
				arg_442_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_2")
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_445_4 = 0
			local var_445_5 = 0.275

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_4 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_6 = arg_442_1:GetWordFromCfg(1109403107)
				local var_445_7 = arg_442_1:FormatText(var_445_6.content)

				arg_442_1.text_.text = var_445_7

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_9 = 11 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 11)

				if (11 <= 0 and var_445_5 or var_445_5 * (utf8.len(var_445_7) / 11)) > 0 and var_445_5 < var_445_9 then
					arg_442_1.talkMaxDuration = var_445_9

					if var_445_9 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_9 + var_445_4
					end
				end

				arg_442_1.text_.text = var_445_7
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb") ~= 0 then
					local var_445_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb") / 1000

					if var_445_10 + var_445_4 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_10 + var_445_4
					end

					if var_445_6.prefab_name ~= "" and arg_442_1.actors_[var_445_6.prefab_name] ~= nil then
						local var_445_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_6.prefab_name].transform, "story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb")

						arg_442_1:RecordAudio("1109403107", var_445_11)
						arg_442_1:RecordAudio("1109403107", var_445_11)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403107", "story_v_side_new_1109403.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_12 = math.max(var_445_5, arg_442_1.talkMaxDuration)

			if var_445_4 <= arg_442_1.time_ and arg_442_1.time_ < var_445_4 + var_445_12 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_4) / var_445_12

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_4 + var_445_12 and arg_442_1.time_ < var_445_4 + var_445_12 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play1109403108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1109403108
		arg_446_1.duration_ = 7.27

		local var_446_0 = {
			ja = 7.266,
			ko = 4.8,
			zh = 4.8
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1109403109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["1094ui_story"]) and arg_446_1.var_.characterEffect1094ui_story == nil then
				arg_446_1.var_.characterEffect1094ui_story = arg_446_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_0 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["1094ui_story"]) then
				if arg_446_1.var_.characterEffect1094ui_story and not isNil(arg_446_1.actors_["1094ui_story"]) then
					arg_446_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_0)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["1094ui_story"]) and arg_446_1.var_.characterEffect1094ui_story then
				arg_446_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_449_1 = 0
			local var_449_2 = 0.65

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:GetWordFromCfg(1109403108)
				local var_449_4 = arg_446_1:FormatText(var_449_3.content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_6 = 26 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_4) / 26)

				if (26 <= 0 and var_449_2 or var_449_2 * (utf8.len(var_449_4) / 26)) > 0 and var_449_2 < var_449_6 then
					arg_446_1.talkMaxDuration = var_449_6

					if var_449_6 + var_449_1 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_6 + var_449_1
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb") ~= 0 then
					local var_449_7 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb") / 1000

					if var_449_7 + var_449_1 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_1
					end

					if var_449_3.prefab_name ~= "" and arg_446_1.actors_[var_449_3.prefab_name] ~= nil then
						local var_449_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_3.prefab_name].transform, "story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb")

						arg_446_1:RecordAudio("1109403108", var_449_8)
						arg_446_1:RecordAudio("1109403108", var_449_8)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403108", "story_v_side_new_1109403.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_9 = math.max(var_449_2, arg_446_1.talkMaxDuration)

			if var_449_1 <= arg_446_1.time_ and arg_446_1.time_ < var_449_1 + var_449_9 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_1) / var_449_9

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_1 + var_449_9 and arg_446_1.time_ < var_449_1 + var_449_9 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1109403109 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1109403109
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1109403110(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos1094ui_story = arg_450_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_453_0 = 0.001

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 then
				arg_450_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_450_1.time_ - 0) / var_453_0)
				arg_450_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1094ui_story"].transform.position).z)
				arg_450_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["1094ui_story"].transform.localEulerAngles = arg_450_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 then
				arg_450_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_450_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_450_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_450_1.actors_["1094ui_story"].transform.position).z)
				arg_450_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_450_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_450_1.actors_["1094ui_story"].transform.localEulerAngles = arg_450_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_453_1 = 0
			local var_453_2 = 0.425

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_3 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(1109403109).content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 17 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 17)

				if (17 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 17)) > 0 and var_453_2 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_1
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_6 = math.max(var_453_2, arg_450_1.talkMaxDuration)

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_6 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_1) / var_453_6

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_1 + var_453_6 and arg_450_1.time_ < var_453_1 + var_453_6 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play1109403110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1109403110
		arg_454_1.duration_ = 8.47

		local var_454_0 = {
			ja = 8.466,
			ko = 6.6,
			zh = 6.6
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1109403111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.175

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_1 = arg_454_1:GetWordFromCfg(1109403110)
				local var_457_2 = arg_454_1:FormatText(var_457_1.content)

				arg_454_1.text_.text = var_457_2

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 7 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 7)

				if (7 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 7)) > 0 and var_457_0 < var_457_4 then
					arg_454_1.talkMaxDuration = var_457_4

					if var_457_4 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_4 + 0
					end
				end

				arg_454_1.text_.text = var_457_2
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb") ~= 0 then
					local var_457_5 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb") / 1000

					if var_457_5 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_5 + 0
					end

					if var_457_1.prefab_name ~= "" and arg_454_1.actors_[var_457_1.prefab_name] ~= nil then
						local var_457_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_1.prefab_name].transform, "story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb")

						arg_454_1:RecordAudio("1109403110", var_457_6)
						arg_454_1:RecordAudio("1109403110", var_457_6)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403110", "story_v_side_new_1109403.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_7 and arg_454_1.time_ < 0 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1109403111 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1109403111
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1109403112(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1094ui_story"]) and arg_458_1.var_.characterEffect1094ui_story == nil then
				arg_458_1.var_.characterEffect1094ui_story = arg_458_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1094ui_story"]) then
				if arg_458_1.var_.characterEffect1094ui_story and not isNil(arg_458_1.actors_["1094ui_story"]) then
					arg_458_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1094ui_story"]) and arg_458_1.var_.characterEffect1094ui_story then
				arg_458_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_461_1 = 0
			local var_461_2 = 0.075

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_3 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(1109403111).content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 3 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 3)

				if (3 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 3)) > 0 and var_461_2 < var_461_5 then
					arg_458_1.talkMaxDuration = var_461_5

					if var_461_5 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_6 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_6 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_6

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_6 and arg_458_1.time_ < var_461_1 + var_461_6 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1109403112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1109403112
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1109403113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0.95

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_1 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(1109403112).content)

				arg_462_1.text_.text = var_465_1

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_3 = 38 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 38)

				if (38 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 38)) > 0 and var_465_0 < var_465_3 then
					arg_462_1.talkMaxDuration = var_465_3

					if var_465_3 + 0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_3 + 0
					end
				end

				arg_462_1.text_.text = var_465_1
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_4 = math.max(var_465_0, arg_462_1.talkMaxDuration)

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - 0) / var_465_4

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play1109403113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1109403113
		arg_466_1.duration_ = 5

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1109403114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = 0.45

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, false)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_1 = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(1109403113).content)

				arg_466_1.text_.text = var_469_1

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_3 = 33 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_1) / 33)

				if (33 <= 0 and var_469_0 or var_469_0 * (utf8.len(var_469_1) / 33)) > 0 and var_469_0 < var_469_3 then
					arg_466_1.talkMaxDuration = var_469_3

					if var_469_3 + 0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_3 + 0
					end
				end

				arg_466_1.text_.text = var_469_1
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)
				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_4 = math.max(var_469_0, arg_466_1.talkMaxDuration)

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_4 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - 0) / var_469_4

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= 0 + var_469_4 and arg_466_1.time_ < 0 + var_469_4 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1109403114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1109403114
		arg_470_1.duration_ = 9

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1109403115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 2 < arg_470_1.time_ and arg_470_1.time_ <= 2 + arg_473_0 then
				local var_473_0 = arg_470_1.bgs_.B13

				arg_470_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_473_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_473_1 = var_473_0:GetComponent("SpriteRenderer")

				if var_473_1 and var_473_1.sprite then
					local var_473_2 = 2 * (var_473_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_473_0.transform.localScale = Vector3.New(var_473_2 / var_473_1.sprite.bounds.size.y < var_473_2 * manager.ui.mainCameraCom_.aspect / var_473_1.sprite.bounds.size.x and var_473_2 * manager.ui.mainCameraCom_.aspect / var_473_1.sprite.bounds.size.x or var_473_2 / var_473_1.sprite.bounds.size.y, var_473_2 / var_473_1.sprite.bounds.size.y < var_473_2 * manager.ui.mainCameraCom_.aspect / var_473_1.sprite.bounds.size.x and var_473_2 * manager.ui.mainCameraCom_.aspect / var_473_1.sprite.bounds.size.x or var_473_2 / var_473_1.sprite.bounds.size.y, 0)
				end

				for iter_473_0, iter_473_1 in pairs(arg_470_1.bgs_) do
					if iter_473_0 ~= "B13" then
						iter_473_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_473_3 = 0

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_3 + arg_473_0 then
				arg_470_1.mask_.enabled = true
				arg_470_1.mask_.raycastTarget = true

				arg_470_1:SetGaussion(false)
			end

			local var_473_4 = 2

			if var_473_3 <= arg_470_1.time_ and arg_470_1.time_ < var_473_3 + var_473_4 then
				local var_473_5 = Color.New(0, 0, 0)

				var_473_5.a = Mathf.Lerp(0, 1, (arg_470_1.time_ - var_473_3) / var_473_4)
				arg_470_1.mask_.color = var_473_5
			end

			if arg_470_1.time_ >= var_473_3 + var_473_4 and arg_470_1.time_ < var_473_3 + var_473_4 + arg_473_0 then
				local var_473_6 = Color.New(0, 0, 0)

				var_473_6.a = 1
				arg_470_1.mask_.color = var_473_6
			end

			local var_473_7 = 2

			if 2 < arg_470_1.time_ and arg_470_1.time_ <= var_473_7 + arg_473_0 then
				arg_470_1.mask_.enabled = true
				arg_470_1.mask_.raycastTarget = true

				arg_470_1:SetGaussion(false)
			end

			local var_473_8 = 2

			if var_473_7 <= arg_470_1.time_ and arg_470_1.time_ < var_473_7 + var_473_8 then
				local var_473_9 = Color.New(0, 0, 0)

				var_473_9.a = Mathf.Lerp(1, 0, (arg_470_1.time_ - var_473_7) / var_473_8)
				arg_470_1.mask_.color = var_473_9
			end

			if arg_470_1.time_ >= var_473_7 + var_473_8 and arg_470_1.time_ < var_473_7 + var_473_8 + arg_473_0 then
				local var_473_10 = Color.New(0, 0, 0)

				arg_470_1.mask_.enabled = false
				var_473_10.a = 0
				arg_470_1.mask_.color = var_473_10
			end

			if arg_470_1.frameCnt_ <= 1 then
				arg_470_1.dialog_:SetActive(false)
			end

			local var_473_11 = 4
			local var_473_12 = 0.75

			if 4 < arg_470_1.time_ and arg_470_1.time_ <= var_473_11 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0

				arg_470_1.dialog_:SetActive(true)

				arg_470_1.dialogCg_.alpha = 0

				local var_473_13 = LeanTween.value(arg_470_1.dialog_, 0, 1, 0.3)

				var_473_13:setOnUpdate(LuaHelper.FloatAction(function(arg_474_0)
					arg_470_1.dialogCg_.alpha = arg_474_0
				end))
				var_473_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_470_1.dialog_)
					var_473_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_470_1.duration_ = arg_470_1.duration_ + 0.3

				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_14 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(1109403114).content)

				arg_470_1.text_.text = var_473_14

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_16 = 30 <= 0 and var_473_12 or var_473_12 * (utf8.len(var_473_14) / 30)

				if (30 <= 0 and var_473_12 or var_473_12 * (utf8.len(var_473_14) / 30)) > 0 and var_473_12 < var_473_16 then
					arg_470_1.talkMaxDuration = var_473_16
					var_473_11 = var_473_11 + 0.3

					if var_473_16 + var_473_11 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_16 + var_473_11
					end
				end

				arg_470_1.text_.text = var_473_14
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_17 = var_473_11 + 0.3
			local var_473_18 = math.max(var_473_12, arg_470_1.talkMaxDuration)

			if var_473_11 + 0.3 <= arg_470_1.time_ and arg_470_1.time_ < var_473_17 + var_473_18 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_17) / var_473_18

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_17 + var_473_18 and arg_470_1.time_ < var_473_17 + var_473_18 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1109403115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1109403115
		arg_476_1.duration_ = 5

		local var_476_0 = {
			ja = 5,
			ko = 4.266,
			zh = 4.266
		}
		local var_476_1 = manager.audio:GetLocalizationFlag()

		if var_476_0[var_476_1] ~= nil then
			arg_476_1.duration_ = var_476_0[var_476_1]
		end

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1109403116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if arg_476_1.actors_["1048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1048ui_story"))) then
				local var_479_0 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_476_1.stage_.transform)

				var_479_0.name = "1048ui_story"
				var_479_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_476_1.actors_["1048ui_story"] = var_479_0

				local var_479_1 = var_479_0:GetComponentInChildren(typeof(CharacterEffect))

				var_479_1.enabled = true

				local var_479_2 = GameObjectTools.GetOrAddComponent(var_479_0, typeof(DynamicBoneHelper))

				if var_479_2 then
					var_479_2:EnableDynamicBone(false)
				end

				arg_476_1:ShowWeapon(var_479_1.transform, false)

				arg_476_1.var_["1048ui_story" .. "Animator"] = var_479_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_476_1.var_["1048ui_story" .. "Animator"].applyRootMotion = true
				arg_476_1.var_["1048ui_story" .. "LipSync"] = var_479_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_479_3 = arg_476_1.actors_["1048ui_story"].transform

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.var_.moveOldPos1048ui_story = var_479_3.localPosition
			end

			local var_479_4 = 0.001

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_4 then
				var_479_3.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_476_1.time_ - 0) / var_479_4)
				var_479_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_479_3.position).x, (manager.ui.mainCamera.transform.position - var_479_3.position).y, (manager.ui.mainCamera.transform.position - var_479_3.position).z)
				var_479_3.localEulerAngles.z = 0
				var_479_3.localEulerAngles.x = 0
				var_479_3.localEulerAngles = var_479_3.localEulerAngles
			end

			if arg_476_1.time_ >= 0 + var_479_4 and arg_476_1.time_ < 0 + var_479_4 + arg_479_0 then
				var_479_3.localPosition = Vector3.New(0, -0.8, -6.2)
				var_479_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_479_3.position).x, (manager.ui.mainCamera.transform.position - var_479_3.position).y, (manager.ui.mainCamera.transform.position - var_479_3.position).z)
				var_479_3.localEulerAngles.z = 0
				var_479_3.localEulerAngles.x = 0
				var_479_3.localEulerAngles = var_479_3.localEulerAngles
			end

			local var_479_5 = arg_476_1.actors_["1048ui_story"]

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(var_479_5) and arg_476_1.var_.characterEffect1048ui_story == nil then
				arg_476_1.var_.characterEffect1048ui_story = var_479_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_6 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_6 and not isNil(var_479_5) then
				if arg_476_1.var_.characterEffect1048ui_story and not isNil(var_479_5) then
					arg_476_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_476_1.time_ >= 0 + var_479_6 and arg_476_1.time_ < 0 + var_479_6 + arg_479_0 and not isNil(var_479_5) and arg_476_1.var_.characterEffect1048ui_story then
				arg_476_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_1")
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_479_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_476_1.bgmTxt_.text ~= var_479_10 and arg_476_1.bgmTxt_.text ~= "" then
						if arg_476_1.bgmTxt2_.text ~= "" then
							arg_476_1.bgmTxt_.text = arg_476_1.bgmTxt2_.text
						end

						arg_476_1.bgmTxt2_.text = var_479_10

						arg_476_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_476_1.bgmTxt_.text = var_479_10
						arg_476_1.bgmTxt2_.text = var_479_10
					end

					if arg_476_1.bgmTimer then
						arg_476_1.bgmTimer:Stop()

						arg_476_1.bgmTimer = nil
					end

					if arg_476_1.settingData.show_music_name == 1 then
						arg_476_1.musicController:SetSelectedState("show")
						arg_476_1.musicAnimator_:Play("open", 0, 0)

						if arg_476_1.settingData.music_time ~= 0 then
							arg_476_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_476_1.settingData.music_time), function()
								if arg_476_1 == nil or isNil(arg_476_1.bgmTxt_) then
									return
								end

								arg_476_1.musicController:SetSelectedState("hide")
								arg_476_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_476_1.time_ and arg_476_1.time_ <= 1 + arg_479_0 then
				arg_476_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_479_13 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_476_1.bgmTxt_.text ~= var_479_13 and arg_476_1.bgmTxt_.text ~= "" then
						if arg_476_1.bgmTxt2_.text ~= "" then
							arg_476_1.bgmTxt_.text = arg_476_1.bgmTxt2_.text
						end

						arg_476_1.bgmTxt2_.text = var_479_13

						arg_476_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_476_1.bgmTxt_.text = var_479_13
						arg_476_1.bgmTxt2_.text = var_479_13
					end

					if arg_476_1.bgmTimer then
						arg_476_1.bgmTimer:Stop()

						arg_476_1.bgmTimer = nil
					end

					if arg_476_1.settingData.show_music_name == 1 then
						arg_476_1.musicController:SetSelectedState("show")
						arg_476_1.musicAnimator_:Play("open", 0, 0)

						if arg_476_1.settingData.music_time ~= 0 then
							arg_476_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_476_1.settingData.music_time), function()
								if arg_476_1 == nil or isNil(arg_476_1.bgmTxt_) then
									return
								end

								arg_476_1.musicController:SetSelectedState("hide")
								arg_476_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_479_14 = 0
			local var_479_15 = 0.55

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_14 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_16 = arg_476_1:GetWordFromCfg(1109403115)
				local var_479_17 = arg_476_1:FormatText(var_479_16.content)

				arg_476_1.text_.text = var_479_17

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_19 = 22 <= 0 and var_479_15 or var_479_15 * (utf8.len(var_479_17) / 22)

				if (22 <= 0 and var_479_15 or var_479_15 * (utf8.len(var_479_17) / 22)) > 0 and var_479_15 < var_479_19 then
					arg_476_1.talkMaxDuration = var_479_19

					if var_479_19 + var_479_14 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_19 + var_479_14
					end
				end

				arg_476_1.text_.text = var_479_17
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb") ~= 0 then
					local var_479_20 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb") / 1000

					if var_479_20 + var_479_14 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_20 + var_479_14
					end

					if var_479_16.prefab_name ~= "" and arg_476_1.actors_[var_479_16.prefab_name] ~= nil then
						local var_479_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_16.prefab_name].transform, "story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb")

						arg_476_1:RecordAudio("1109403115", var_479_21)
						arg_476_1:RecordAudio("1109403115", var_479_21)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403115", "story_v_side_new_1109403.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_22 = math.max(var_479_15, arg_476_1.talkMaxDuration)

			if var_479_14 <= arg_476_1.time_ and arg_476_1.time_ < var_479_14 + var_479_22 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_14) / var_479_22

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_14 + var_479_22 and arg_476_1.time_ < var_479_14 + var_479_22 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_476_1:InitPlayNodeList()
	end,
	Play1109403116 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1109403116
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1109403117(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["1048ui_story"]) and arg_482_1.var_.characterEffect1048ui_story == nil then
				arg_482_1.var_.characterEffect1048ui_story = arg_482_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_0 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["1048ui_story"]) then
				if arg_482_1.var_.characterEffect1048ui_story and not isNil(arg_482_1.actors_["1048ui_story"]) then
					arg_482_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_482_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_0)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["1048ui_story"]) and arg_482_1.var_.characterEffect1048ui_story then
				arg_482_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_482_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_485_1 = 0
			local var_485_2 = 0.425

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_1 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:FormatText(arg_482_1:GetWordFromCfg(1109403116).content)

				arg_482_1.text_.text = var_485_3

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 17 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_3) / 17)

				if (17 <= 0 and var_485_2 or var_485_2 * (utf8.len(var_485_3) / 17)) > 0 and var_485_2 < var_485_5 then
					arg_482_1.talkMaxDuration = var_485_5

					if var_485_5 + var_485_1 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + var_485_1
					end
				end

				arg_482_1.text_.text = var_485_3
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_6 = math.max(var_485_2, arg_482_1.talkMaxDuration)

			if var_485_1 <= arg_482_1.time_ and arg_482_1.time_ < var_485_1 + var_485_6 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_1) / var_485_6

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_1 + var_485_6 and arg_482_1.time_ < var_485_1 + var_485_6 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1109403117 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1109403117
		arg_486_1.duration_ = 4.47

		local var_486_0 = {
			ja = 4.466,
			ko = 2.333,
			zh = 2.333
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1109403118(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.moveOldPos1048ui_story = arg_486_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_489_0 = 0.001

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_0 then
				arg_486_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_486_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_486_1.time_ - 0) / var_489_0)
				arg_486_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1048ui_story"].transform.position).z)
				arg_486_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1048ui_story"].transform.localEulerAngles = arg_486_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_486_1.time_ >= 0 + var_489_0 and arg_486_1.time_ < 0 + var_489_0 + arg_489_0 then
				arg_486_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_486_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_486_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_486_1.actors_["1048ui_story"].transform.position).z)
				arg_486_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_486_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_486_1.actors_["1048ui_story"].transform.localEulerAngles = arg_486_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_489_1 = arg_486_1.actors_["1048ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_1) and arg_486_1.var_.characterEffect1048ui_story == nil then
				arg_486_1.var_.characterEffect1048ui_story = var_489_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_2 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_2 and not isNil(var_489_1) then
				if arg_486_1.var_.characterEffect1048ui_story and not isNil(var_489_1) then
					arg_486_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_486_1.time_ >= 0 + var_489_2 and arg_486_1.time_ < 0 + var_489_2 + arg_489_0 and not isNil(var_489_1) and arg_486_1.var_.characterEffect1048ui_story then
				arg_486_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_2")
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_489_4 = 0
			local var_489_5 = 0.2

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_4 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_6 = arg_486_1:GetWordFromCfg(1109403117)
				local var_489_7 = arg_486_1:FormatText(var_489_6.content)

				arg_486_1.text_.text = var_489_7

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_9 = 8 <= 0 and var_489_5 or var_489_5 * (utf8.len(var_489_7) / 8)

				if (8 <= 0 and var_489_5 or var_489_5 * (utf8.len(var_489_7) / 8)) > 0 and var_489_5 < var_489_9 then
					arg_486_1.talkMaxDuration = var_489_9

					if var_489_9 + var_489_4 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_9 + var_489_4
					end
				end

				arg_486_1.text_.text = var_489_7
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb") ~= 0 then
					local var_489_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb") / 1000

					if var_489_10 + var_489_4 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_10 + var_489_4
					end

					if var_489_6.prefab_name ~= "" and arg_486_1.actors_[var_489_6.prefab_name] ~= nil then
						local var_489_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_6.prefab_name].transform, "story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb")

						arg_486_1:RecordAudio("1109403117", var_489_11)
						arg_486_1:RecordAudio("1109403117", var_489_11)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403117", "story_v_side_new_1109403.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_12 = math.max(var_489_5, arg_486_1.talkMaxDuration)

			if var_489_4 <= arg_486_1.time_ and arg_486_1.time_ < var_489_4 + var_489_12 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_4) / var_489_12

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_4 + var_489_12 and arg_486_1.time_ < var_489_4 + var_489_12 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_486_1:InitPlayNodeList()
	end,
	Play1109403118 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1109403118
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1109403119(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(arg_490_1.actors_["1048ui_story"]) and arg_490_1.var_.characterEffect1048ui_story == nil then
				arg_490_1.var_.characterEffect1048ui_story = arg_490_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_0 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_0 and not isNil(arg_490_1.actors_["1048ui_story"]) then
				if arg_490_1.var_.characterEffect1048ui_story and not isNil(arg_490_1.actors_["1048ui_story"]) then
					arg_490_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_490_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_490_1.time_ - 0) / var_493_0)
				end
			end

			if arg_490_1.time_ >= 0 + var_493_0 and arg_490_1.time_ < 0 + var_493_0 + arg_493_0 and not isNil(arg_490_1.actors_["1048ui_story"]) and arg_490_1.var_.characterEffect1048ui_story then
				arg_490_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_490_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_493_1 = 0
			local var_493_2 = 0.45

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_3 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(1109403118).content)

				arg_490_1.text_.text = var_493_3

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 18 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 18)

				if (18 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 18)) > 0 and var_493_2 < var_493_5 then
					arg_490_1.talkMaxDuration = var_493_5

					if var_493_5 + var_493_1 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + var_493_1
					end
				end

				arg_490_1.text_.text = var_493_3
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_6 = math.max(var_493_2, arg_490_1.talkMaxDuration)

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_6 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_1) / var_493_6

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_1 + var_493_6 and arg_490_1.time_ < var_493_1 + var_493_6 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1109403119 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1109403119
		arg_494_1.duration_ = 7.2

		local var_494_0 = {
			ja = 7.2,
			ko = 3.733,
			zh = 3.733
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1109403120(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.var_.moveOldPos1048ui_story = arg_494_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_497_0 = 0.001

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 then
				arg_494_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_494_1.time_ - 0) / var_497_0)
				arg_494_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_494_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1048ui_story"].transform.position).z)
				arg_494_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_494_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_494_1.actors_["1048ui_story"].transform.localEulerAngles = arg_494_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 then
				arg_494_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_494_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_494_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1048ui_story"].transform.position).z)
				arg_494_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_494_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_494_1.actors_["1048ui_story"].transform.localEulerAngles = arg_494_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_497_1 = arg_494_1.actors_["1048ui_story"]

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(var_497_1) and arg_494_1.var_.characterEffect1048ui_story == nil then
				arg_494_1.var_.characterEffect1048ui_story = var_497_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_2 and not isNil(var_497_1) then
				if arg_494_1.var_.characterEffect1048ui_story and not isNil(var_497_1) then
					arg_494_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= 0 + var_497_2 and arg_494_1.time_ < 0 + var_497_2 + arg_497_0 and not isNil(var_497_1) and arg_494_1.var_.characterEffect1048ui_story then
				arg_494_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_497_4 = 0
			local var_497_5 = 0.45

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_4 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_6 = arg_494_1:GetWordFromCfg(1109403119)
				local var_497_7 = arg_494_1:FormatText(var_497_6.content)

				arg_494_1.text_.text = var_497_7

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_9 = 18 <= 0 and var_497_5 or var_497_5 * (utf8.len(var_497_7) / 18)

				if (18 <= 0 and var_497_5 or var_497_5 * (utf8.len(var_497_7) / 18)) > 0 and var_497_5 < var_497_9 then
					arg_494_1.talkMaxDuration = var_497_9

					if var_497_9 + var_497_4 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_9 + var_497_4
					end
				end

				arg_494_1.text_.text = var_497_7
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb") ~= 0 then
					local var_497_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb") / 1000

					if var_497_10 + var_497_4 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_10 + var_497_4
					end

					if var_497_6.prefab_name ~= "" and arg_494_1.actors_[var_497_6.prefab_name] ~= nil then
						local var_497_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_6.prefab_name].transform, "story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb")

						arg_494_1:RecordAudio("1109403119", var_497_11)
						arg_494_1:RecordAudio("1109403119", var_497_11)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403119", "story_v_side_new_1109403.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_12 = math.max(var_497_5, arg_494_1.talkMaxDuration)

			if var_497_4 <= arg_494_1.time_ and arg_494_1.time_ < var_497_4 + var_497_12 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_4) / var_497_12

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_4 + var_497_12 and arg_494_1.time_ < var_497_4 + var_497_12 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_494_1:InitPlayNodeList()
	end,
	Play1109403120 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1109403120
		arg_498_1.duration_ = 5

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1109403121(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["1048ui_story"]) and arg_498_1.var_.characterEffect1048ui_story == nil then
				arg_498_1.var_.characterEffect1048ui_story = arg_498_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["1048ui_story"]) then
				if arg_498_1.var_.characterEffect1048ui_story and not isNil(arg_498_1.actors_["1048ui_story"]) then
					arg_498_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_498_1.time_ - 0) / var_501_0)
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["1048ui_story"]) and arg_498_1.var_.characterEffect1048ui_story then
				arg_498_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_501_1 = 0
			local var_501_2 = 0.325

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, true)
				arg_498_1.iconController_:SetSelectedState("hero")

				arg_498_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_498_1.callingController_:SetSelectedState("normal")

				arg_498_1.keyicon_.color = Color.New(1, 1, 1)
				arg_498_1.icon_.color = Color.New(1, 1, 1)

				local var_501_3 = arg_498_1:FormatText(arg_498_1:GetWordFromCfg(1109403120).content)

				arg_498_1.text_.text = var_501_3

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_5 = 13 <= 0 and var_501_2 or var_501_2 * (utf8.len(var_501_3) / 13)

				if (13 <= 0 and var_501_2 or var_501_2 * (utf8.len(var_501_3) / 13)) > 0 and var_501_2 < var_501_5 then
					arg_498_1.talkMaxDuration = var_501_5

					if var_501_5 + var_501_1 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_5 + var_501_1
					end
				end

				arg_498_1.text_.text = var_501_3
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)
				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_6 = math.max(var_501_2, arg_498_1.talkMaxDuration)

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_6 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_1) / var_501_6

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_1 + var_501_6 and arg_498_1.time_ < var_501_1 + var_501_6 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1109403121 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1109403121
		arg_502_1.duration_ = 5.3

		local var_502_0 = {
			ja = 4.433,
			ko = 5.3,
			zh = 5.3
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1109403122(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.var_.moveOldPos1048ui_story = arg_502_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_505_0 = 0.001

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 then
				arg_502_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_502_1.time_ - 0) / var_505_0)
				arg_502_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_502_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1048ui_story"].transform.position).z)
				arg_502_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_502_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_502_1.actors_["1048ui_story"].transform.localEulerAngles = arg_502_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 then
				arg_502_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_502_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_502_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1048ui_story"].transform.position).z)
				arg_502_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_502_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_502_1.actors_["1048ui_story"].transform.localEulerAngles = arg_502_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_505_1 = arg_502_1.actors_["1048ui_story"]

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(var_505_1) and arg_502_1.var_.characterEffect1048ui_story == nil then
				arg_502_1.var_.characterEffect1048ui_story = var_505_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_2 and not isNil(var_505_1) then
				if arg_502_1.var_.characterEffect1048ui_story and not isNil(var_505_1) then
					arg_502_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= 0 + var_505_2 and arg_502_1.time_ < 0 + var_505_2 + arg_505_0 and not isNil(var_505_1) and arg_502_1.var_.characterEffect1048ui_story then
				arg_502_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action443")
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_505_4 = 0
			local var_505_5 = 0.55

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_6 = arg_502_1:GetWordFromCfg(1109403121)
				local var_505_7 = arg_502_1:FormatText(var_505_6.content)

				arg_502_1.text_.text = var_505_7

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_9 = 22 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 22)

				if (22 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 22)) > 0 and var_505_5 < var_505_9 then
					arg_502_1.talkMaxDuration = var_505_9

					if var_505_9 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_9 + var_505_4
					end
				end

				arg_502_1.text_.text = var_505_7
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb") ~= 0 then
					local var_505_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb") / 1000

					if var_505_10 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_4
					end

					if var_505_6.prefab_name ~= "" and arg_502_1.actors_[var_505_6.prefab_name] ~= nil then
						local var_505_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_6.prefab_name].transform, "story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb")

						arg_502_1:RecordAudio("1109403121", var_505_11)
						arg_502_1:RecordAudio("1109403121", var_505_11)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403121", "story_v_side_new_1109403.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_12 = math.max(var_505_5, arg_502_1.talkMaxDuration)

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_12 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_4) / var_505_12

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_4 + var_505_12 and arg_502_1.time_ < var_505_4 + var_505_12 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_502_1:InitPlayNodeList()
	end,
	Play1109403122 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1109403122
		arg_506_1.duration_ = 12.3

		local var_506_0 = {
			ja = 12.3,
			ko = 8.066,
			zh = 8.066
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1109403123(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1.var_.moveOldPos1048ui_story = arg_506_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_509_0 = 0.001

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 then
				arg_506_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_506_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_506_1.time_ - 0) / var_509_0)
				arg_506_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_506_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["1048ui_story"].transform.position).z)
				arg_506_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_506_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_506_1.actors_["1048ui_story"].transform.localEulerAngles = arg_506_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 then
				arg_506_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_506_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_506_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_506_1.actors_["1048ui_story"].transform.position).z)
				arg_506_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_506_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_506_1.actors_["1048ui_story"].transform.localEulerAngles = arg_506_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_509_1 = arg_506_1.actors_["1048ui_story"]

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(var_509_1) and arg_506_1.var_.characterEffect1048ui_story == nil then
				arg_506_1.var_.characterEffect1048ui_story = var_509_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_2 and not isNil(var_509_1) then
				if arg_506_1.var_.characterEffect1048ui_story and not isNil(var_509_1) then
					arg_506_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= 0 + var_509_2 and arg_506_1.time_ < 0 + var_509_2 + arg_509_0 and not isNil(var_509_1) and arg_506_1.var_.characterEffect1048ui_story then
				arg_506_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action435")
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_509_4 = 0
			local var_509_5 = 0.975

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_4 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_6 = arg_506_1:GetWordFromCfg(1109403122)
				local var_509_7 = arg_506_1:FormatText(var_509_6.content)

				arg_506_1.text_.text = var_509_7

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_9 = 39 <= 0 and var_509_5 or var_509_5 * (utf8.len(var_509_7) / 39)

				if (39 <= 0 and var_509_5 or var_509_5 * (utf8.len(var_509_7) / 39)) > 0 and var_509_5 < var_509_9 then
					arg_506_1.talkMaxDuration = var_509_9

					if var_509_9 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_9 + var_509_4
					end
				end

				arg_506_1.text_.text = var_509_7
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb") ~= 0 then
					local var_509_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb") / 1000

					if var_509_10 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_10 + var_509_4
					end

					if var_509_6.prefab_name ~= "" and arg_506_1.actors_[var_509_6.prefab_name] ~= nil then
						local var_509_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_6.prefab_name].transform, "story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb")

						arg_506_1:RecordAudio("1109403122", var_509_11)
						arg_506_1:RecordAudio("1109403122", var_509_11)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403122", "story_v_side_new_1109403.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_12 = math.max(var_509_5, arg_506_1.talkMaxDuration)

			if var_509_4 <= arg_506_1.time_ and arg_506_1.time_ < var_509_4 + var_509_12 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_4) / var_509_12

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_4 + var_509_12 and arg_506_1.time_ < var_509_4 + var_509_12 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_506_1:InitPlayNodeList()
	end,
	Play1109403123 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1109403123
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1109403124(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["1048ui_story"]) and arg_510_1.var_.characterEffect1048ui_story == nil then
				arg_510_1.var_.characterEffect1048ui_story = arg_510_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_0 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["1048ui_story"]) then
				if arg_510_1.var_.characterEffect1048ui_story and not isNil(arg_510_1.actors_["1048ui_story"]) then
					arg_510_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_510_1.time_ - 0) / var_513_0)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["1048ui_story"]) and arg_510_1.var_.characterEffect1048ui_story then
				arg_510_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_513_1 = 0
			local var_513_2 = 0.775

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_3 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(1109403123).content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_5 = 31 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 31)

				if (31 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 31)) > 0 and var_513_2 < var_513_5 then
					arg_510_1.talkMaxDuration = var_513_5

					if var_513_5 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + var_513_1
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_6 = math.max(var_513_2, arg_510_1.talkMaxDuration)

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_6 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_1) / var_513_6

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_1 + var_513_6 and arg_510_1.time_ < var_513_1 + var_513_6 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play1109403124 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1109403124
		arg_514_1.duration_ = 8.47

		local var_514_0 = {
			ja = 8.466,
			ko = 4.1,
			zh = 4.1
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1109403125(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos1048ui_story = arg_514_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_517_0 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 then
				arg_514_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_514_1.time_ - 0) / var_517_0)
				arg_514_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["1048ui_story"].transform.position).z)
				arg_514_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["1048ui_story"].transform.localEulerAngles = arg_514_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 then
				arg_514_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_514_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["1048ui_story"].transform.position).z)
				arg_514_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["1048ui_story"].transform.localEulerAngles = arg_514_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_517_1 = arg_514_1.actors_["1048ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_1) and arg_514_1.var_.characterEffect1048ui_story == nil then
				arg_514_1.var_.characterEffect1048ui_story = var_517_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_2 and not isNil(var_517_1) then
				if arg_514_1.var_.characterEffect1048ui_story and not isNil(var_517_1) then
					arg_514_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_2 and arg_514_1.time_ < 0 + var_517_2 + arg_517_0 and not isNil(var_517_1) and arg_514_1.var_.characterEffect1048ui_story then
				arg_514_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_517_4 = 0
			local var_517_5 = 0.4

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_6 = arg_514_1:GetWordFromCfg(1109403124)
				local var_517_7 = arg_514_1:FormatText(var_517_6.content)

				arg_514_1.text_.text = var_517_7

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_9 = 16 <= 0 and var_517_5 or var_517_5 * (utf8.len(var_517_7) / 16)

				if (16 <= 0 and var_517_5 or var_517_5 * (utf8.len(var_517_7) / 16)) > 0 and var_517_5 < var_517_9 then
					arg_514_1.talkMaxDuration = var_517_9

					if var_517_9 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_9 + var_517_4
					end
				end

				arg_514_1.text_.text = var_517_7
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb") ~= 0 then
					local var_517_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb") / 1000

					if var_517_10 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_10 + var_517_4
					end

					if var_517_6.prefab_name ~= "" and arg_514_1.actors_[var_517_6.prefab_name] ~= nil then
						local var_517_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_6.prefab_name].transform, "story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb")

						arg_514_1:RecordAudio("1109403124", var_517_11)
						arg_514_1:RecordAudio("1109403124", var_517_11)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403124", "story_v_side_new_1109403.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_12 = math.max(var_517_5, arg_514_1.talkMaxDuration)

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_12 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_4) / var_517_12

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_4 + var_517_12 and arg_514_1.time_ < var_517_4 + var_517_12 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play1109403125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1109403125
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1109403126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["1048ui_story"]) and arg_518_1.var_.characterEffect1048ui_story == nil then
				arg_518_1.var_.characterEffect1048ui_story = arg_518_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["1048ui_story"]) then
				if arg_518_1.var_.characterEffect1048ui_story and not isNil(arg_518_1.actors_["1048ui_story"]) then
					arg_518_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_0)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["1048ui_story"]) and arg_518_1.var_.characterEffect1048ui_story then
				arg_518_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_521_1 = 0
			local var_521_2 = 0.525

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_3 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(1109403125).content)

				arg_518_1.text_.text = var_521_3

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_5 = 21 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_3) / 21)

				if (21 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_3) / 21)) > 0 and var_521_2 < var_521_5 then
					arg_518_1.talkMaxDuration = var_521_5

					if var_521_5 + var_521_1 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_5 + var_521_1
					end
				end

				arg_518_1.text_.text = var_521_3
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_6 = math.max(var_521_2, arg_518_1.talkMaxDuration)

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_6 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_1) / var_521_6

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_1 + var_521_6 and arg_518_1.time_ < var_521_1 + var_521_6 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play1109403126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1109403126
		arg_522_1.duration_ = 4.83

		local var_522_0 = {
			ja = 4.833,
			ko = 3.066,
			zh = 3.066
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1109403127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1.var_.moveOldPos1048ui_story = arg_522_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_525_0 = 0.001

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 then
				arg_522_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_522_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_522_1.time_ - 0) / var_525_0)
				arg_522_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_522_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["1048ui_story"].transform.position).z)
				arg_522_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_522_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_522_1.actors_["1048ui_story"].transform.localEulerAngles = arg_522_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 then
				arg_522_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_522_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_522_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_522_1.actors_["1048ui_story"].transform.position).z)
				arg_522_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_522_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_522_1.actors_["1048ui_story"].transform.localEulerAngles = arg_522_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_525_1 = arg_522_1.actors_["1048ui_story"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_1) and arg_522_1.var_.characterEffect1048ui_story == nil then
				arg_522_1.var_.characterEffect1048ui_story = var_525_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_2 and not isNil(var_525_1) then
				if arg_522_1.var_.characterEffect1048ui_story and not isNil(var_525_1) then
					arg_522_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= 0 + var_525_2 and arg_522_1.time_ < 0 + var_525_2 + arg_525_0 and not isNil(var_525_1) and arg_522_1.var_.characterEffect1048ui_story then
				arg_522_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048actionlink/1048action452")
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_525_4 = 0
			local var_525_5 = 0.325

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_6 = arg_522_1:GetWordFromCfg(1109403126)
				local var_525_7 = arg_522_1:FormatText(var_525_6.content)

				arg_522_1.text_.text = var_525_7

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_9 = 13 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 13)

				if (13 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 13)) > 0 and var_525_5 < var_525_9 then
					arg_522_1.talkMaxDuration = var_525_9

					if var_525_9 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_9 + var_525_4
					end
				end

				arg_522_1.text_.text = var_525_7
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb") ~= 0 then
					local var_525_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb") / 1000

					if var_525_10 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_10 + var_525_4
					end

					if var_525_6.prefab_name ~= "" and arg_522_1.actors_[var_525_6.prefab_name] ~= nil then
						local var_525_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_6.prefab_name].transform, "story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb")

						arg_522_1:RecordAudio("1109403126", var_525_11)
						arg_522_1:RecordAudio("1109403126", var_525_11)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403126", "story_v_side_new_1109403.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_12 = math.max(var_525_5, arg_522_1.talkMaxDuration)

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_12 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_4) / var_525_12

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_4 + var_525_12 and arg_522_1.time_ < var_525_4 + var_525_12 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_522_1:InitPlayNodeList()
	end,
	Play1109403127 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1109403127
		arg_526_1.duration_ = 12.47

		local var_526_0 = {
			ja = 12.466,
			ko = 7.4,
			zh = 7.4
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1109403128(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.var_.moveOldPos1048ui_story = arg_526_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_529_0 = 0.001

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_0 then
				arg_526_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_526_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_526_1.time_ - 0) / var_529_0)
				arg_526_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1048ui_story"].transform.position).z)
				arg_526_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["1048ui_story"].transform.localEulerAngles = arg_526_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_526_1.time_ >= 0 + var_529_0 and arg_526_1.time_ < 0 + var_529_0 + arg_529_0 then
				arg_526_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_526_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_526_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_526_1.actors_["1048ui_story"].transform.position).z)
				arg_526_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_526_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_526_1.actors_["1048ui_story"].transform.localEulerAngles = arg_526_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_529_1 = arg_526_1.actors_["1048ui_story"]

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 and not isNil(var_529_1) and arg_526_1.var_.characterEffect1048ui_story == nil then
				arg_526_1.var_.characterEffect1048ui_story = var_529_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_2 and not isNil(var_529_1) then
				if arg_526_1.var_.characterEffect1048ui_story and not isNil(var_529_1) then
					arg_526_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_526_1.time_ >= 0 + var_529_2 and arg_526_1.time_ < 0 + var_529_2 + arg_529_0 and not isNil(var_529_1) and arg_526_1.var_.characterEffect1048ui_story then
				arg_526_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_2")
			end

			local var_529_4 = 0
			local var_529_5 = 0.975

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_4 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_6 = arg_526_1:GetWordFromCfg(1109403127)
				local var_529_7 = arg_526_1:FormatText(var_529_6.content)

				arg_526_1.text_.text = var_529_7

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_9 = 39 <= 0 and var_529_5 or var_529_5 * (utf8.len(var_529_7) / 39)

				if (39 <= 0 and var_529_5 or var_529_5 * (utf8.len(var_529_7) / 39)) > 0 and var_529_5 < var_529_9 then
					arg_526_1.talkMaxDuration = var_529_9

					if var_529_9 + var_529_4 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_9 + var_529_4
					end
				end

				arg_526_1.text_.text = var_529_7
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb") ~= 0 then
					local var_529_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb") / 1000

					if var_529_10 + var_529_4 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_10 + var_529_4
					end

					if var_529_6.prefab_name ~= "" and arg_526_1.actors_[var_529_6.prefab_name] ~= nil then
						local var_529_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_6.prefab_name].transform, "story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb")

						arg_526_1:RecordAudio("1109403127", var_529_11)
						arg_526_1:RecordAudio("1109403127", var_529_11)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403127", "story_v_side_new_1109403.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_12 = math.max(var_529_5, arg_526_1.talkMaxDuration)

			if var_529_4 <= arg_526_1.time_ and arg_526_1.time_ < var_529_4 + var_529_12 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_4) / var_529_12

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_4 + var_529_12 and arg_526_1.time_ < var_529_4 + var_529_12 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_526_1:InitPlayNodeList()
	end,
	Play1109403128 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1109403128
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1109403129(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(arg_530_1.actors_["1048ui_story"]) and arg_530_1.var_.characterEffect1048ui_story == nil then
				arg_530_1.var_.characterEffect1048ui_story = arg_530_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_0 = 0.200000002980232

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 and not isNil(arg_530_1.actors_["1048ui_story"]) then
				if arg_530_1.var_.characterEffect1048ui_story and not isNil(arg_530_1.actors_["1048ui_story"]) then
					arg_530_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_530_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_530_1.time_ - 0) / var_533_0)
				end
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 and not isNil(arg_530_1.actors_["1048ui_story"]) and arg_530_1.var_.characterEffect1048ui_story then
				arg_530_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_530_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_533_1 = 0
			local var_533_2 = 0.225

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				arg_530_1.leftNameTxt_.text = arg_530_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, true)
				arg_530_1.iconController_:SetSelectedState("hero")

				arg_530_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_530_1.callingController_:SetSelectedState("normal")

				arg_530_1.keyicon_.color = Color.New(1, 1, 1)
				arg_530_1.icon_.color = Color.New(1, 1, 1)

				local var_533_3 = arg_530_1:FormatText(arg_530_1:GetWordFromCfg(1109403128).content)

				arg_530_1.text_.text = var_533_3

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_5 = 9 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_3) / 9)

				if (9 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_3) / 9)) > 0 and var_533_2 < var_533_5 then
					arg_530_1.talkMaxDuration = var_533_5

					if var_533_5 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_5 + var_533_1
					end
				end

				arg_530_1.text_.text = var_533_3
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_6 = math.max(var_533_2, arg_530_1.talkMaxDuration)

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_6 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_1) / var_533_6

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_1 + var_533_6 and arg_530_1.time_ < var_533_1 + var_533_6 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play1109403129 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1109403129
		arg_534_1.duration_ = 4.9

		local var_534_0 = {
			ja = 4.8,
			ko = 4.9,
			zh = 4.9
		}
		local var_534_1 = manager.audio:GetLocalizationFlag()

		if var_534_0[var_534_1] ~= nil then
			arg_534_1.duration_ = var_534_0[var_534_1]
		end

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1109403130(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.var_.moveOldPos1048ui_story = arg_534_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_537_0 = 0.001

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_0 then
				arg_534_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_534_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_534_1.time_ - 0) / var_537_0)
				arg_534_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_534_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1048ui_story"].transform.position).z)
				arg_534_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_534_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_534_1.actors_["1048ui_story"].transform.localEulerAngles = arg_534_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_534_1.time_ >= 0 + var_537_0 and arg_534_1.time_ < 0 + var_537_0 + arg_537_0 then
				arg_534_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_534_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_534_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_534_1.actors_["1048ui_story"].transform.position).z)
				arg_534_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_534_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_534_1.actors_["1048ui_story"].transform.localEulerAngles = arg_534_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_537_1 = arg_534_1.actors_["1048ui_story"]

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 and not isNil(var_537_1) and arg_534_1.var_.characterEffect1048ui_story == nil then
				arg_534_1.var_.characterEffect1048ui_story = var_537_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_537_2 = 0.200000002980232

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_2 and not isNil(var_537_1) then
				if arg_534_1.var_.characterEffect1048ui_story and not isNil(var_537_1) then
					arg_534_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_534_1.time_ >= 0 + var_537_2 and arg_534_1.time_ < 0 + var_537_2 + arg_537_0 and not isNil(var_537_1) and arg_534_1.var_.characterEffect1048ui_story then
				arg_534_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_1")
			end

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_537_4 = 0
			local var_537_5 = 0.375

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_4 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				arg_534_1.leftNameTxt_.text = arg_534_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_6 = arg_534_1:GetWordFromCfg(1109403129)
				local var_537_7 = arg_534_1:FormatText(var_537_6.content)

				arg_534_1.text_.text = var_537_7

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_9 = 15 <= 0 and var_537_5 or var_537_5 * (utf8.len(var_537_7) / 15)

				if (15 <= 0 and var_537_5 or var_537_5 * (utf8.len(var_537_7) / 15)) > 0 and var_537_5 < var_537_9 then
					arg_534_1.talkMaxDuration = var_537_9

					if var_537_9 + var_537_4 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_9 + var_537_4
					end
				end

				arg_534_1.text_.text = var_537_7
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb") ~= 0 then
					local var_537_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb") / 1000

					if var_537_10 + var_537_4 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_10 + var_537_4
					end

					if var_537_6.prefab_name ~= "" and arg_534_1.actors_[var_537_6.prefab_name] ~= nil then
						local var_537_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_6.prefab_name].transform, "story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb")

						arg_534_1:RecordAudio("1109403129", var_537_11)
						arg_534_1:RecordAudio("1109403129", var_537_11)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403129", "story_v_side_new_1109403.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_12 = math.max(var_537_5, arg_534_1.talkMaxDuration)

			if var_537_4 <= arg_534_1.time_ and arg_534_1.time_ < var_537_4 + var_537_12 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_4) / var_537_12

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_4 + var_537_12 and arg_534_1.time_ < var_537_4 + var_537_12 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_534_1:InitPlayNodeList()
	end,
	Play1109403130 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1109403130
		arg_538_1.duration_ = 9

		local var_538_0 = {
			ja = 9,
			ko = 6.6,
			zh = 6.6
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1109403131(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.var_.moveOldPos1048ui_story = arg_538_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_541_0 = 0.001

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 then
				arg_538_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_538_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_538_1.time_ - 0) / var_541_0)
				arg_538_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1048ui_story"].transform.position).z)
				arg_538_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["1048ui_story"].transform.localEulerAngles = arg_538_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 then
				arg_538_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_538_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_538_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_538_1.actors_["1048ui_story"].transform.position).z)
				arg_538_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_538_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_538_1.actors_["1048ui_story"].transform.localEulerAngles = arg_538_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_541_1 = arg_538_1.actors_["1048ui_story"]

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(var_541_1) and arg_538_1.var_.characterEffect1048ui_story == nil then
				arg_538_1.var_.characterEffect1048ui_story = var_541_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_2 and not isNil(var_541_1) then
				if arg_538_1.var_.characterEffect1048ui_story and not isNil(var_541_1) then
					arg_538_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= 0 + var_541_2 and arg_538_1.time_ < 0 + var_541_2 + arg_541_0 and not isNil(var_541_1) and arg_538_1.var_.characterEffect1048ui_story then
				arg_538_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action435")
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_541_4 = 0
			local var_541_5 = 0.775

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_4 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_6 = arg_538_1:GetWordFromCfg(1109403130)
				local var_541_7 = arg_538_1:FormatText(var_541_6.content)

				arg_538_1.text_.text = var_541_7

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_9 = 31 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 31)

				if (31 <= 0 and var_541_5 or var_541_5 * (utf8.len(var_541_7) / 31)) > 0 and var_541_5 < var_541_9 then
					arg_538_1.talkMaxDuration = var_541_9

					if var_541_9 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_9 + var_541_4
					end
				end

				arg_538_1.text_.text = var_541_7
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb") ~= 0 then
					local var_541_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb") / 1000

					if var_541_10 + var_541_4 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_10 + var_541_4
					end

					if var_541_6.prefab_name ~= "" and arg_538_1.actors_[var_541_6.prefab_name] ~= nil then
						local var_541_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_6.prefab_name].transform, "story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb")

						arg_538_1:RecordAudio("1109403130", var_541_11)
						arg_538_1:RecordAudio("1109403130", var_541_11)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403130", "story_v_side_new_1109403.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_12 = math.max(var_541_5, arg_538_1.talkMaxDuration)

			if var_541_4 <= arg_538_1.time_ and arg_538_1.time_ < var_541_4 + var_541_12 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_4) / var_541_12

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_4 + var_541_12 and arg_538_1.time_ < var_541_4 + var_541_12 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_538_1:InitPlayNodeList()
	end,
	Play1109403131 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1109403131
		arg_542_1.duration_ = 5

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1109403132(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 and not isNil(arg_542_1.actors_["1048ui_story"]) and arg_542_1.var_.characterEffect1048ui_story == nil then
				arg_542_1.var_.characterEffect1048ui_story = arg_542_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_0 = 0.200000002980232

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_0 and not isNil(arg_542_1.actors_["1048ui_story"]) then
				if arg_542_1.var_.characterEffect1048ui_story and not isNil(arg_542_1.actors_["1048ui_story"]) then
					arg_542_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_542_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_542_1.time_ - 0) / var_545_0)
				end
			end

			if arg_542_1.time_ >= 0 + var_545_0 and arg_542_1.time_ < 0 + var_545_0 + arg_545_0 and not isNil(arg_542_1.actors_["1048ui_story"]) and arg_542_1.var_.characterEffect1048ui_story then
				arg_542_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_542_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_545_1 = 0
			local var_545_2 = 0.25

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, true)
				arg_542_1.iconController_:SetSelectedState("hero")

				arg_542_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_542_1.callingController_:SetSelectedState("normal")

				arg_542_1.keyicon_.color = Color.New(1, 1, 1)
				arg_542_1.icon_.color = Color.New(1, 1, 1)

				local var_545_3 = arg_542_1:FormatText(arg_542_1:GetWordFromCfg(1109403131).content)

				arg_542_1.text_.text = var_545_3

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_5 = 11 <= 0 and var_545_2 or var_545_2 * (utf8.len(var_545_3) / 11)

				if (11 <= 0 and var_545_2 or var_545_2 * (utf8.len(var_545_3) / 11)) > 0 and var_545_2 < var_545_5 then
					arg_542_1.talkMaxDuration = var_545_5

					if var_545_5 + var_545_1 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_5 + var_545_1
					end
				end

				arg_542_1.text_.text = var_545_3
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)
				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_6 = math.max(var_545_2, arg_542_1.talkMaxDuration)

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_6 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_1) / var_545_6

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_1 + var_545_6 and arg_542_1.time_ < var_545_1 + var_545_6 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play1109403132 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1109403132
		arg_546_1.duration_ = 10.13

		local var_546_0 = {
			ja = 10.133,
			ko = 8.033,
			zh = 8.033
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1109403133(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1.var_.moveOldPos1048ui_story = arg_546_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_549_0 = 0.001

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_0 then
				arg_546_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_546_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_546_1.time_ - 0) / var_549_0)
				arg_546_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_546_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1048ui_story"].transform.position).z)
				arg_546_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_546_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_546_1.actors_["1048ui_story"].transform.localEulerAngles = arg_546_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_546_1.time_ >= 0 + var_549_0 and arg_546_1.time_ < 0 + var_549_0 + arg_549_0 then
				arg_546_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_546_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_546_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_546_1.actors_["1048ui_story"].transform.position).z)
				arg_546_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_546_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_546_1.actors_["1048ui_story"].transform.localEulerAngles = arg_546_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_549_1 = arg_546_1.actors_["1048ui_story"]

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 and not isNil(var_549_1) and arg_546_1.var_.characterEffect1048ui_story == nil then
				arg_546_1.var_.characterEffect1048ui_story = var_549_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_2 = 0.200000002980232

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_2 and not isNil(var_549_1) then
				if arg_546_1.var_.characterEffect1048ui_story and not isNil(var_549_1) then
					arg_546_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_546_1.time_ >= 0 + var_549_2 and arg_546_1.time_ < 0 + var_549_2 + arg_549_0 and not isNil(var_549_1) and arg_546_1.var_.characterEffect1048ui_story then
				arg_546_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_549_4 = 0
			local var_549_5 = 0.95

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_4 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_6 = arg_546_1:GetWordFromCfg(1109403132)
				local var_549_7 = arg_546_1:FormatText(var_549_6.content)

				arg_546_1.text_.text = var_549_7

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_9 = 38 <= 0 and var_549_5 or var_549_5 * (utf8.len(var_549_7) / 38)

				if (38 <= 0 and var_549_5 or var_549_5 * (utf8.len(var_549_7) / 38)) > 0 and var_549_5 < var_549_9 then
					arg_546_1.talkMaxDuration = var_549_9

					if var_549_9 + var_549_4 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_9 + var_549_4
					end
				end

				arg_546_1.text_.text = var_549_7
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb") ~= 0 then
					local var_549_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb") / 1000

					if var_549_10 + var_549_4 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_10 + var_549_4
					end

					if var_549_6.prefab_name ~= "" and arg_546_1.actors_[var_549_6.prefab_name] ~= nil then
						local var_549_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_6.prefab_name].transform, "story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb")

						arg_546_1:RecordAudio("1109403132", var_549_11)
						arg_546_1:RecordAudio("1109403132", var_549_11)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403132", "story_v_side_new_1109403.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_12 = math.max(var_549_5, arg_546_1.talkMaxDuration)

			if var_549_4 <= arg_546_1.time_ and arg_546_1.time_ < var_549_4 + var_549_12 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_4) / var_549_12

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_4 + var_549_12 and arg_546_1.time_ < var_549_4 + var_549_12 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_546_1:InitPlayNodeList()
	end,
	Play1109403133 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 1109403133
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play1109403134(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 and not isNil(arg_550_1.actors_["1048ui_story"]) and arg_550_1.var_.characterEffect1048ui_story == nil then
				arg_550_1.var_.characterEffect1048ui_story = arg_550_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_0 = 0.200000002980232

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_0 and not isNil(arg_550_1.actors_["1048ui_story"]) then
				if arg_550_1.var_.characterEffect1048ui_story and not isNil(arg_550_1.actors_["1048ui_story"]) then
					arg_550_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_550_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_550_1.time_ - 0) / var_553_0)
				end
			end

			if arg_550_1.time_ >= 0 + var_553_0 and arg_550_1.time_ < 0 + var_553_0 + arg_553_0 and not isNil(arg_550_1.actors_["1048ui_story"]) and arg_550_1.var_.characterEffect1048ui_story then
				arg_550_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_550_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_553_1 = 0
			local var_553_2 = 0.625

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				arg_550_1.leftNameTxt_.text = arg_550_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_3 = arg_550_1:FormatText(arg_550_1:GetWordFromCfg(1109403133).content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_5 = 25 <= 0 and var_553_2 or var_553_2 * (utf8.len(var_553_3) / 25)

				if (25 <= 0 and var_553_2 or var_553_2 * (utf8.len(var_553_3) / 25)) > 0 and var_553_2 < var_553_5 then
					arg_550_1.talkMaxDuration = var_553_5

					if var_553_5 + var_553_1 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_5 + var_553_1
					end
				end

				arg_550_1.text_.text = var_553_3
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_6 = math.max(var_553_2, arg_550_1.talkMaxDuration)

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_6 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_1) / var_553_6

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_1 + var_553_6 and arg_550_1.time_ < var_553_1 + var_553_6 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play1109403134 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 1109403134
		arg_554_1.duration_ = 10.17

		local var_554_0 = {
			ja = 10.166,
			ko = 7,
			zh = 7
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play1109403135(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1.var_.moveOldPos1048ui_story = arg_554_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_557_0 = 0.001

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_0 then
				arg_554_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_554_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_554_1.time_ - 0) / var_557_0)
				arg_554_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_554_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1048ui_story"].transform.position).z)
				arg_554_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_554_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_554_1.actors_["1048ui_story"].transform.localEulerAngles = arg_554_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_554_1.time_ >= 0 + var_557_0 and arg_554_1.time_ < 0 + var_557_0 + arg_557_0 then
				arg_554_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_554_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_554_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_554_1.actors_["1048ui_story"].transform.position).z)
				arg_554_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_554_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_554_1.actors_["1048ui_story"].transform.localEulerAngles = arg_554_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_557_1 = arg_554_1.actors_["1048ui_story"]

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(var_557_1) and arg_554_1.var_.characterEffect1048ui_story == nil then
				arg_554_1.var_.characterEffect1048ui_story = var_557_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_2 = 0.200000002980232

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_2 and not isNil(var_557_1) then
				if arg_554_1.var_.characterEffect1048ui_story and not isNil(var_557_1) then
					arg_554_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= 0 + var_557_2 and arg_554_1.time_ < 0 + var_557_2 + arg_557_0 and not isNil(var_557_1) and arg_554_1.var_.characterEffect1048ui_story then
				arg_554_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action454")
			end

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 then
				arg_554_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_557_4 = 0
			local var_557_5 = 0.75

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_4 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_6 = arg_554_1:GetWordFromCfg(1109403134)
				local var_557_7 = arg_554_1:FormatText(var_557_6.content)

				arg_554_1.text_.text = var_557_7

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_9 = 30 <= 0 and var_557_5 or var_557_5 * (utf8.len(var_557_7) / 30)

				if (30 <= 0 and var_557_5 or var_557_5 * (utf8.len(var_557_7) / 30)) > 0 and var_557_5 < var_557_9 then
					arg_554_1.talkMaxDuration = var_557_9

					if var_557_9 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_9 + var_557_4
					end
				end

				arg_554_1.text_.text = var_557_7
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb") ~= 0 then
					local var_557_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb") / 1000

					if var_557_10 + var_557_4 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_10 + var_557_4
					end

					if var_557_6.prefab_name ~= "" and arg_554_1.actors_[var_557_6.prefab_name] ~= nil then
						local var_557_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_6.prefab_name].transform, "story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb")

						arg_554_1:RecordAudio("1109403134", var_557_11)
						arg_554_1:RecordAudio("1109403134", var_557_11)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403134", "story_v_side_new_1109403.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_12 = math.max(var_557_5, arg_554_1.talkMaxDuration)

			if var_557_4 <= arg_554_1.time_ and arg_554_1.time_ < var_557_4 + var_557_12 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_4) / var_557_12

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_4 + var_557_12 and arg_554_1.time_ < var_557_4 + var_557_12 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_554_1:InitPlayNodeList()
	end,
	Play1109403135 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1109403135
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1109403136(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 and not isNil(arg_558_1.actors_["1048ui_story"]) and arg_558_1.var_.characterEffect1048ui_story == nil then
				arg_558_1.var_.characterEffect1048ui_story = arg_558_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_0 = 0.200000002980232

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_0 and not isNil(arg_558_1.actors_["1048ui_story"]) then
				if arg_558_1.var_.characterEffect1048ui_story and not isNil(arg_558_1.actors_["1048ui_story"]) then
					arg_558_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_558_1.time_ - 0) / var_561_0)
				end
			end

			if arg_558_1.time_ >= 0 + var_561_0 and arg_558_1.time_ < 0 + var_561_0 + arg_561_0 and not isNil(arg_558_1.actors_["1048ui_story"]) and arg_558_1.var_.characterEffect1048ui_story then
				arg_558_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_561_1 = 0
			local var_561_2 = 0.2

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_3 = arg_558_1:FormatText(arg_558_1:GetWordFromCfg(1109403135).content)

				arg_558_1.text_.text = var_561_3

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_5 = 8 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_3) / 8)

				if (8 <= 0 and var_561_2 or var_561_2 * (utf8.len(var_561_3) / 8)) > 0 and var_561_2 < var_561_5 then
					arg_558_1.talkMaxDuration = var_561_5

					if var_561_5 + var_561_1 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_5 + var_561_1
					end
				end

				arg_558_1.text_.text = var_561_3
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_6 = math.max(var_561_2, arg_558_1.talkMaxDuration)

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_6 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_1) / var_561_6

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_1 + var_561_6 and arg_558_1.time_ < var_561_1 + var_561_6 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play1109403136 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1109403136
		arg_562_1.duration_ = 8.97

		local var_562_0 = {
			ja = 8.966,
			ko = 3.166,
			zh = 3.166
		}
		local var_562_1 = manager.audio:GetLocalizationFlag()

		if var_562_0[var_562_1] ~= nil then
			arg_562_1.duration_ = var_562_0[var_562_1]
		end

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1109403137(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1.var_.moveOldPos1048ui_story = arg_562_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_565_0 = 0.001

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_0 then
				arg_562_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_562_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_562_1.time_ - 0) / var_565_0)
				arg_562_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_562_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["1048ui_story"].transform.position).z)
				arg_562_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_562_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_562_1.actors_["1048ui_story"].transform.localEulerAngles = arg_562_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_562_1.time_ >= 0 + var_565_0 and arg_562_1.time_ < 0 + var_565_0 + arg_565_0 then
				arg_562_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_562_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_562_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_562_1.actors_["1048ui_story"].transform.position).z)
				arg_562_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_562_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_562_1.actors_["1048ui_story"].transform.localEulerAngles = arg_562_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_565_1 = arg_562_1.actors_["1048ui_story"]

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 and not isNil(var_565_1) and arg_562_1.var_.characterEffect1048ui_story == nil then
				arg_562_1.var_.characterEffect1048ui_story = var_565_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_565_2 = 0.200000002980232

			if 0 <= arg_562_1.time_ and arg_562_1.time_ < 0 + var_565_2 and not isNil(var_565_1) then
				if arg_562_1.var_.characterEffect1048ui_story and not isNil(var_565_1) then
					arg_562_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_562_1.time_ >= 0 + var_565_2 and arg_562_1.time_ < 0 + var_565_2 + arg_565_0 and not isNil(var_565_1) and arg_562_1.var_.characterEffect1048ui_story then
				arg_562_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action446")
			end

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= 0 + arg_565_0 then
				arg_562_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_565_4 = 0
			local var_565_5 = 0.35

			if 0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_4 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				arg_562_1.leftNameTxt_.text = arg_562_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_6 = arg_562_1:GetWordFromCfg(1109403136)
				local var_565_7 = arg_562_1:FormatText(var_565_6.content)

				arg_562_1.text_.text = var_565_7

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_9 = 14 <= 0 and var_565_5 or var_565_5 * (utf8.len(var_565_7) / 14)

				if (14 <= 0 and var_565_5 or var_565_5 * (utf8.len(var_565_7) / 14)) > 0 and var_565_5 < var_565_9 then
					arg_562_1.talkMaxDuration = var_565_9

					if var_565_9 + var_565_4 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_9 + var_565_4
					end
				end

				arg_562_1.text_.text = var_565_7
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb") ~= 0 then
					local var_565_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb") / 1000

					if var_565_10 + var_565_4 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_10 + var_565_4
					end

					if var_565_6.prefab_name ~= "" and arg_562_1.actors_[var_565_6.prefab_name] ~= nil then
						local var_565_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_562_1.actors_[var_565_6.prefab_name].transform, "story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb")

						arg_562_1:RecordAudio("1109403136", var_565_11)
						arg_562_1:RecordAudio("1109403136", var_565_11)
					else
						arg_562_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb")
					end

					arg_562_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403136", "story_v_side_new_1109403.awb")
				end

				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_12 = math.max(var_565_5, arg_562_1.talkMaxDuration)

			if var_565_4 <= arg_562_1.time_ and arg_562_1.time_ < var_565_4 + var_565_12 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_4) / var_565_12

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_4 + var_565_12 and arg_562_1.time_ < var_565_4 + var_565_12 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_562_1:InitPlayNodeList()
	end,
	Play1109403137 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1109403137
		arg_566_1.duration_ = 4.47

		local var_566_0 = {
			ja = 4.466,
			ko = 3.733,
			zh = 3.733
		}
		local var_566_1 = manager.audio:GetLocalizationFlag()

		if var_566_0[var_566_1] ~= nil then
			arg_566_1.duration_ = var_566_0[var_566_1]
		end

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1109403138(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1.var_.moveOldPos1048ui_story = arg_566_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_569_0 = 0.001

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_0 then
				arg_566_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_566_1.time_ - 0) / var_569_0)
				arg_566_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_566_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1048ui_story"].transform.position).z)
				arg_566_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_566_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_566_1.actors_["1048ui_story"].transform.localEulerAngles = arg_566_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_566_1.time_ >= 0 + var_569_0 and arg_566_1.time_ < 0 + var_569_0 + arg_569_0 then
				arg_566_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_566_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_566_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_566_1.actors_["1048ui_story"].transform.position).z)
				arg_566_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_566_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_566_1.actors_["1048ui_story"].transform.localEulerAngles = arg_566_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_569_1 = arg_566_1.actors_["1048ui_story"]

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 and not isNil(var_569_1) and arg_566_1.var_.characterEffect1048ui_story == nil then
				arg_566_1.var_.characterEffect1048ui_story = var_569_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_2 = 0.200000002980232

			if 0 <= arg_566_1.time_ and arg_566_1.time_ < 0 + var_569_2 and not isNil(var_569_1) then
				if arg_566_1.var_.characterEffect1048ui_story and not isNil(var_569_1) then
					arg_566_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_566_1.time_ >= 0 + var_569_2 and arg_566_1.time_ < 0 + var_569_2 + arg_569_0 and not isNil(var_569_1) and arg_566_1.var_.characterEffect1048ui_story then
				arg_566_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= 0 + arg_569_0 then
				arg_566_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_569_4 = 0
			local var_569_5 = 0.375

			if 0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_4 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				arg_566_1.leftNameTxt_.text = arg_566_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_6 = arg_566_1:GetWordFromCfg(1109403137)
				local var_569_7 = arg_566_1:FormatText(var_569_6.content)

				arg_566_1.text_.text = var_569_7

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_9 = 15 <= 0 and var_569_5 or var_569_5 * (utf8.len(var_569_7) / 15)

				if (15 <= 0 and var_569_5 or var_569_5 * (utf8.len(var_569_7) / 15)) > 0 and var_569_5 < var_569_9 then
					arg_566_1.talkMaxDuration = var_569_9

					if var_569_9 + var_569_4 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_9 + var_569_4
					end
				end

				arg_566_1.text_.text = var_569_7
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb") ~= 0 then
					local var_569_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb") / 1000

					if var_569_10 + var_569_4 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_10 + var_569_4
					end

					if var_569_6.prefab_name ~= "" and arg_566_1.actors_[var_569_6.prefab_name] ~= nil then
						local var_569_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_6.prefab_name].transform, "story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb")

						arg_566_1:RecordAudio("1109403137", var_569_11)
						arg_566_1:RecordAudio("1109403137", var_569_11)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403137", "story_v_side_new_1109403.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_12 = math.max(var_569_5, arg_566_1.talkMaxDuration)

			if var_569_4 <= arg_566_1.time_ and arg_566_1.time_ < var_569_4 + var_569_12 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_4) / var_569_12

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_4 + var_569_12 and arg_566_1.time_ < var_569_4 + var_569_12 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play1109403138 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1109403138
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1109403139(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			if 0 < arg_570_1.time_ and arg_570_1.time_ <= 0 + arg_573_0 and not isNil(arg_570_1.actors_["1048ui_story"]) and arg_570_1.var_.characterEffect1048ui_story == nil then
				arg_570_1.var_.characterEffect1048ui_story = arg_570_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_0 = 0.200000002980232

			if 0 <= arg_570_1.time_ and arg_570_1.time_ < 0 + var_573_0 and not isNil(arg_570_1.actors_["1048ui_story"]) then
				if arg_570_1.var_.characterEffect1048ui_story and not isNil(arg_570_1.actors_["1048ui_story"]) then
					arg_570_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_570_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_570_1.time_ - 0) / var_573_0)
				end
			end

			if arg_570_1.time_ >= 0 + var_573_0 and arg_570_1.time_ < 0 + var_573_0 + arg_573_0 and not isNil(arg_570_1.actors_["1048ui_story"]) and arg_570_1.var_.characterEffect1048ui_story then
				arg_570_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_570_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_573_1 = 0
			local var_573_2 = 0.85

			if 0 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_3 = arg_570_1:FormatText(arg_570_1:GetWordFromCfg(1109403138).content)

				arg_570_1.text_.text = var_573_3

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_5 = 34 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_3) / 34)

				if (34 <= 0 and var_573_2 or var_573_2 * (utf8.len(var_573_3) / 34)) > 0 and var_573_2 < var_573_5 then
					arg_570_1.talkMaxDuration = var_573_5

					if var_573_5 + var_573_1 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_5 + var_573_1
					end
				end

				arg_570_1.text_.text = var_573_3
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_6 = math.max(var_573_2, arg_570_1.talkMaxDuration)

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_6 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_1) / var_573_6

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_1 + var_573_6 and arg_570_1.time_ < var_573_1 + var_573_6 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play1109403139 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1109403139
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1109403140(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 1.525

			if 0 < arg_574_1.time_ and arg_574_1.time_ <= 0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				arg_574_1.leftNameTxt_.text = arg_574_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_1 = arg_574_1:FormatText(arg_574_1:GetWordFromCfg(1109403139).content)

				arg_574_1.text_.text = var_577_1

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_3 = 61 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_1) / 61)

				if (61 <= 0 and var_577_0 or var_577_0 * (utf8.len(var_577_1) / 61)) > 0 and var_577_0 < var_577_3 then
					arg_574_1.talkMaxDuration = var_577_3

					if var_577_3 + 0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_3 + 0
					end
				end

				arg_574_1.text_.text = var_577_1
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_4 = math.max(var_577_0, arg_574_1.talkMaxDuration)

			if 0 <= arg_574_1.time_ and arg_574_1.time_ < 0 + var_577_4 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - 0) / var_577_4

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= 0 + var_577_4 and arg_574_1.time_ < 0 + var_577_4 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play1109403140 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1109403140
		arg_578_1.duration_ = 5.53

		local var_578_0 = {
			ja = 5.533,
			ko = 3.9,
			zh = 3.9
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1109403141(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1.var_.moveOldPos1048ui_story = arg_578_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_581_0 = 0.001

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_0 then
				arg_578_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_578_1.time_ - 0) / var_581_0)
				arg_578_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1048ui_story"].transform.position).z)
				arg_578_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["1048ui_story"].transform.localEulerAngles = arg_578_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_578_1.time_ >= 0 + var_581_0 and arg_578_1.time_ < 0 + var_581_0 + arg_581_0 then
				arg_578_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_578_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_578_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_578_1.actors_["1048ui_story"].transform.position).z)
				arg_578_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_578_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_578_1.actors_["1048ui_story"].transform.localEulerAngles = arg_578_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_581_1 = arg_578_1.actors_["1048ui_story"]

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 and not isNil(var_581_1) and arg_578_1.var_.characterEffect1048ui_story == nil then
				arg_578_1.var_.characterEffect1048ui_story = var_581_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.200000002980232

			if 0 <= arg_578_1.time_ and arg_578_1.time_ < 0 + var_581_2 and not isNil(var_581_1) then
				if arg_578_1.var_.characterEffect1048ui_story and not isNil(var_581_1) then
					arg_578_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_578_1.time_ >= 0 + var_581_2 and arg_578_1.time_ < 0 + var_581_2 + arg_581_0 and not isNil(var_581_1) and arg_578_1.var_.characterEffect1048ui_story then
				arg_578_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= 0 + arg_581_0 then
				arg_578_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_581_4 = 0
			local var_581_5 = 0.425

			if 0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_4 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				arg_578_1.leftNameTxt_.text = arg_578_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_6 = arg_578_1:GetWordFromCfg(1109403140)
				local var_581_7 = arg_578_1:FormatText(var_581_6.content)

				arg_578_1.text_.text = var_581_7

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_9 = 17 <= 0 and var_581_5 or var_581_5 * (utf8.len(var_581_7) / 17)

				if (17 <= 0 and var_581_5 or var_581_5 * (utf8.len(var_581_7) / 17)) > 0 and var_581_5 < var_581_9 then
					arg_578_1.talkMaxDuration = var_581_9

					if var_581_9 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_9 + var_581_4
					end
				end

				arg_578_1.text_.text = var_581_7
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb") ~= 0 then
					local var_581_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb") / 1000

					if var_581_10 + var_581_4 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_10 + var_581_4
					end

					if var_581_6.prefab_name ~= "" and arg_578_1.actors_[var_581_6.prefab_name] ~= nil then
						local var_581_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_6.prefab_name].transform, "story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb")

						arg_578_1:RecordAudio("1109403140", var_581_11)
						arg_578_1:RecordAudio("1109403140", var_581_11)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403140", "story_v_side_new_1109403.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_12 = math.max(var_581_5, arg_578_1.talkMaxDuration)

			if var_581_4 <= arg_578_1.time_ and arg_578_1.time_ < var_581_4 + var_581_12 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_4) / var_581_12

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_4 + var_581_12 and arg_578_1.time_ < var_581_4 + var_581_12 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_578_1:InitPlayNodeList()
	end,
	Play1109403141 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1109403141
		arg_582_1.duration_ = 0.2

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"

			SetActive(arg_582_1.choicesGo_, true)

			for iter_583_0, iter_583_1 in ipairs(arg_582_1.choices_) do
				SetActive(iter_583_1.go, iter_583_0 <= 1)
			end

			arg_582_1.choices_[1].txt.text = arg_582_1:FormatText(StoryChoiceCfg[411].name)
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1109403142(arg_582_1)
			end

			arg_582_1:RecordChoiceLog(1109403141, 411)
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			if 0 < arg_582_1.time_ and arg_582_1.time_ <= 0 + arg_585_0 and not isNil(arg_582_1.actors_["1048ui_story"]) and arg_582_1.var_.characterEffect1048ui_story == nil then
				arg_582_1.var_.characterEffect1048ui_story = arg_582_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_585_0 = 0.200000002980232

			if 0 <= arg_582_1.time_ and arg_582_1.time_ < 0 + var_585_0 and not isNil(arg_582_1.actors_["1048ui_story"]) then
				if arg_582_1.var_.characterEffect1048ui_story and not isNil(arg_582_1.actors_["1048ui_story"]) then
					arg_582_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_582_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_582_1.time_ - 0) / var_585_0)
				end
			end

			if arg_582_1.time_ >= 0 + var_585_0 and arg_582_1.time_ < 0 + var_585_0 + arg_585_0 and not isNil(arg_582_1.actors_["1048ui_story"]) and arg_582_1.var_.characterEffect1048ui_story then
				arg_582_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_582_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_585_1 = 0

			if 0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 then
				arg_582_1.allBtn_.enabled = false
			end

			if arg_582_1.time_ >= var_585_1 + 0.200000002980232 and arg_582_1.time_ < var_585_1 + 0.200000002980232 + arg_585_0 then
				arg_582_1.allBtn_.enabled = true
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play1109403142 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1109403142
		arg_586_1.duration_ = 9.4

		local var_586_0 = {
			ja = 9.4,
			ko = 8.1,
			zh = 8.1
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1109403143(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1.var_.moveOldPos1048ui_story = arg_586_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_589_0 = 0.001

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_0 then
				arg_586_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_586_1.time_ - 0) / var_589_0)
				arg_586_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_586_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["1048ui_story"].transform.position).z)
				arg_586_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_586_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_586_1.actors_["1048ui_story"].transform.localEulerAngles = arg_586_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_586_1.time_ >= 0 + var_589_0 and arg_586_1.time_ < 0 + var_589_0 + arg_589_0 then
				arg_586_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_586_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_586_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_586_1.actors_["1048ui_story"].transform.position).z)
				arg_586_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_586_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_586_1.actors_["1048ui_story"].transform.localEulerAngles = arg_586_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_589_1 = arg_586_1.actors_["1048ui_story"]

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 and not isNil(var_589_1) and arg_586_1.var_.characterEffect1048ui_story == nil then
				arg_586_1.var_.characterEffect1048ui_story = var_589_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_2 = 0.200000002980232

			if 0 <= arg_586_1.time_ and arg_586_1.time_ < 0 + var_589_2 and not isNil(var_589_1) then
				if arg_586_1.var_.characterEffect1048ui_story and not isNil(var_589_1) then
					arg_586_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_586_1.time_ >= 0 + var_589_2 and arg_586_1.time_ < 0 + var_589_2 + arg_589_0 and not isNil(var_589_1) and arg_586_1.var_.characterEffect1048ui_story then
				arg_586_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action467")
			end

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= 0 + arg_589_0 then
				arg_586_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_589_4 = 0
			local var_589_5 = 0.8

			if 0 < arg_586_1.time_ and arg_586_1.time_ <= var_589_4 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				arg_586_1.leftNameTxt_.text = arg_586_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_6 = arg_586_1:GetWordFromCfg(1109403142)
				local var_589_7 = arg_586_1:FormatText(var_589_6.content)

				arg_586_1.text_.text = var_589_7

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_9 = 32 <= 0 and var_589_5 or var_589_5 * (utf8.len(var_589_7) / 32)

				if (32 <= 0 and var_589_5 or var_589_5 * (utf8.len(var_589_7) / 32)) > 0 and var_589_5 < var_589_9 then
					arg_586_1.talkMaxDuration = var_589_9

					if var_589_9 + var_589_4 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_9 + var_589_4
					end
				end

				arg_586_1.text_.text = var_589_7
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb") ~= 0 then
					local var_589_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb") / 1000

					if var_589_10 + var_589_4 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_10 + var_589_4
					end

					if var_589_6.prefab_name ~= "" and arg_586_1.actors_[var_589_6.prefab_name] ~= nil then
						local var_589_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_6.prefab_name].transform, "story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb")

						arg_586_1:RecordAudio("1109403142", var_589_11)
						arg_586_1:RecordAudio("1109403142", var_589_11)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403142", "story_v_side_new_1109403.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_12 = math.max(var_589_5, arg_586_1.talkMaxDuration)

			if var_589_4 <= arg_586_1.time_ and arg_586_1.time_ < var_589_4 + var_589_12 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_4) / var_589_12

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_4 + var_589_12 and arg_586_1.time_ < var_589_4 + var_589_12 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_586_1:InitPlayNodeList()
	end,
	Play1109403143 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1109403143
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1109403144(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			if 0 < arg_590_1.time_ and arg_590_1.time_ <= 0 + arg_593_0 and not isNil(arg_590_1.actors_["1048ui_story"]) and arg_590_1.var_.characterEffect1048ui_story == nil then
				arg_590_1.var_.characterEffect1048ui_story = arg_590_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_593_0 = 0.200000002980232

			if 0 <= arg_590_1.time_ and arg_590_1.time_ < 0 + var_593_0 and not isNil(arg_590_1.actors_["1048ui_story"]) then
				if arg_590_1.var_.characterEffect1048ui_story and not isNil(arg_590_1.actors_["1048ui_story"]) then
					arg_590_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_590_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_590_1.time_ - 0) / var_593_0)
				end
			end

			if arg_590_1.time_ >= 0 + var_593_0 and arg_590_1.time_ < 0 + var_593_0 + arg_593_0 and not isNil(arg_590_1.actors_["1048ui_story"]) and arg_590_1.var_.characterEffect1048ui_story then
				arg_590_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_590_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_593_1 = 0
			local var_593_2 = 0.05

			if 0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				arg_590_1.leftNameTxt_.text = arg_590_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, true)
				arg_590_1.iconController_:SetSelectedState("hero")

				arg_590_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_590_1.callingController_:SetSelectedState("normal")

				arg_590_1.keyicon_.color = Color.New(1, 1, 1)
				arg_590_1.icon_.color = Color.New(1, 1, 1)

				local var_593_3 = arg_590_1:FormatText(arg_590_1:GetWordFromCfg(1109403143).content)

				arg_590_1.text_.text = var_593_3

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_5 = 2 <= 0 and var_593_2 or var_593_2 * (utf8.len(var_593_3) / 2)

				if (2 <= 0 and var_593_2 or var_593_2 * (utf8.len(var_593_3) / 2)) > 0 and var_593_2 < var_593_5 then
					arg_590_1.talkMaxDuration = var_593_5

					if var_593_5 + var_593_1 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_5 + var_593_1
					end
				end

				arg_590_1.text_.text = var_593_3
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_6 = math.max(var_593_2, arg_590_1.talkMaxDuration)

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_6 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_1) / var_593_6

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_1 + var_593_6 and arg_590_1.time_ < var_593_1 + var_593_6 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1109403144 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1109403144
		arg_594_1.duration_ = 9.2

		local var_594_0 = {
			ja = 9.2,
			ko = 6.4,
			zh = 6.4
		}
		local var_594_1 = manager.audio:GetLocalizationFlag()

		if var_594_0[var_594_1] ~= nil then
			arg_594_1.duration_ = var_594_0[var_594_1]
		end

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1109403145(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1.var_.moveOldPos1048ui_story = arg_594_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_597_0 = 0.001

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_0 then
				arg_594_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_594_1.time_ - 0) / var_597_0)
				arg_594_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_594_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_594_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_594_1.actors_["1048ui_story"].transform.position).z)
				arg_594_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_594_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_594_1.actors_["1048ui_story"].transform.localEulerAngles = arg_594_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_594_1.time_ >= 0 + var_597_0 and arg_594_1.time_ < 0 + var_597_0 + arg_597_0 then
				arg_594_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_594_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_594_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_594_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_594_1.actors_["1048ui_story"].transform.position).z)
				arg_594_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_594_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_594_1.actors_["1048ui_story"].transform.localEulerAngles = arg_594_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_597_1 = arg_594_1.actors_["1048ui_story"]

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 and not isNil(var_597_1) and arg_594_1.var_.characterEffect1048ui_story == nil then
				arg_594_1.var_.characterEffect1048ui_story = var_597_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_597_2 = 0.200000002980232

			if 0 <= arg_594_1.time_ and arg_594_1.time_ < 0 + var_597_2 and not isNil(var_597_1) then
				if arg_594_1.var_.characterEffect1048ui_story and not isNil(var_597_1) then
					arg_594_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_594_1.time_ >= 0 + var_597_2 and arg_594_1.time_ < 0 + var_597_2 + arg_597_0 and not isNil(var_597_1) and arg_594_1.var_.characterEffect1048ui_story then
				arg_594_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= 0 + arg_597_0 then
				arg_594_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_597_4 = 0
			local var_597_5 = 0.7

			if 0 < arg_594_1.time_ and arg_594_1.time_ <= var_597_4 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				arg_594_1.leftNameTxt_.text = arg_594_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_6 = arg_594_1:GetWordFromCfg(1109403144)
				local var_597_7 = arg_594_1:FormatText(var_597_6.content)

				arg_594_1.text_.text = var_597_7

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_9 = 28 <= 0 and var_597_5 or var_597_5 * (utf8.len(var_597_7) / 28)

				if (28 <= 0 and var_597_5 or var_597_5 * (utf8.len(var_597_7) / 28)) > 0 and var_597_5 < var_597_9 then
					arg_594_1.talkMaxDuration = var_597_9

					if var_597_9 + var_597_4 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_9 + var_597_4
					end
				end

				arg_594_1.text_.text = var_597_7
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb") ~= 0 then
					local var_597_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb") / 1000

					if var_597_10 + var_597_4 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_10 + var_597_4
					end

					if var_597_6.prefab_name ~= "" and arg_594_1.actors_[var_597_6.prefab_name] ~= nil then
						local var_597_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_6.prefab_name].transform, "story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb")

						arg_594_1:RecordAudio("1109403144", var_597_11)
						arg_594_1:RecordAudio("1109403144", var_597_11)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403144", "story_v_side_new_1109403.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_12 = math.max(var_597_5, arg_594_1.talkMaxDuration)

			if var_597_4 <= arg_594_1.time_ and arg_594_1.time_ < var_597_4 + var_597_12 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_4) / var_597_12

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_4 + var_597_12 and arg_594_1.time_ < var_597_4 + var_597_12 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play1109403145 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1109403145
		arg_598_1.duration_ = 5

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1109403146(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			if 0 < arg_598_1.time_ and arg_598_1.time_ <= 0 + arg_601_0 and not isNil(arg_598_1.actors_["1048ui_story"]) and arg_598_1.var_.characterEffect1048ui_story == nil then
				arg_598_1.var_.characterEffect1048ui_story = arg_598_1.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_601_0 = 0.200000002980232

			if 0 <= arg_598_1.time_ and arg_598_1.time_ < 0 + var_601_0 and not isNil(arg_598_1.actors_["1048ui_story"]) then
				if arg_598_1.var_.characterEffect1048ui_story and not isNil(arg_598_1.actors_["1048ui_story"]) then
					arg_598_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_598_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_598_1.time_ - 0) / var_601_0)
				end
			end

			if arg_598_1.time_ >= 0 + var_601_0 and arg_598_1.time_ < 0 + var_601_0 + arg_601_0 and not isNil(arg_598_1.actors_["1048ui_story"]) and arg_598_1.var_.characterEffect1048ui_story then
				arg_598_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_598_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_601_1 = 0
			local var_601_2 = 1.05

			if 0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_1 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				arg_598_1.leftNameTxt_.text = arg_598_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, true)
				arg_598_1.iconController_:SetSelectedState("hero")

				arg_598_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_598_1.callingController_:SetSelectedState("normal")

				arg_598_1.keyicon_.color = Color.New(1, 1, 1)
				arg_598_1.icon_.color = Color.New(1, 1, 1)

				local var_601_3 = arg_598_1:FormatText(arg_598_1:GetWordFromCfg(1109403145).content)

				arg_598_1.text_.text = var_601_3

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_5 = 42 <= 0 and var_601_2 or var_601_2 * (utf8.len(var_601_3) / 42)

				if (42 <= 0 and var_601_2 or var_601_2 * (utf8.len(var_601_3) / 42)) > 0 and var_601_2 < var_601_5 then
					arg_598_1.talkMaxDuration = var_601_5

					if var_601_5 + var_601_1 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_5 + var_601_1
					end
				end

				arg_598_1.text_.text = var_601_3
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)
				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_6 = math.max(var_601_2, arg_598_1.talkMaxDuration)

			if var_601_1 <= arg_598_1.time_ and arg_598_1.time_ < var_601_1 + var_601_6 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_1) / var_601_6

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_1 + var_601_6 and arg_598_1.time_ < var_601_1 + var_601_6 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play1109403146 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1109403146
		arg_602_1.duration_ = 2

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1109403147(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1.var_.moveOldPos1048ui_story = arg_602_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_605_0 = 0.001

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_0 then
				arg_602_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_602_1.var_.moveOldPos1048ui_story, Vector3.New(0, -0.8, -6.2), (arg_602_1.time_ - 0) / var_605_0)
				arg_602_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_602_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["1048ui_story"].transform.position).z)
				arg_602_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_602_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_602_1.actors_["1048ui_story"].transform.localEulerAngles = arg_602_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_602_1.time_ >= 0 + var_605_0 and arg_602_1.time_ < 0 + var_605_0 + arg_605_0 then
				arg_602_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_602_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_602_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_602_1.actors_["1048ui_story"].transform.position).z)
				arg_602_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_602_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_602_1.actors_["1048ui_story"].transform.localEulerAngles = arg_602_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_605_1 = arg_602_1.actors_["1048ui_story"]

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 and not isNil(var_605_1) and arg_602_1.var_.characterEffect1048ui_story == nil then
				arg_602_1.var_.characterEffect1048ui_story = var_605_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_2 = 0.200000002980232

			if 0 <= arg_602_1.time_ and arg_602_1.time_ < 0 + var_605_2 and not isNil(var_605_1) then
				if arg_602_1.var_.characterEffect1048ui_story and not isNil(var_605_1) then
					arg_602_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_602_1.time_ >= 0 + var_605_2 and arg_602_1.time_ < 0 + var_605_2 + arg_605_0 and not isNil(var_605_1) and arg_602_1.var_.characterEffect1048ui_story then
				arg_602_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= 0 + arg_605_0 then
				arg_602_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_605_4 = 0
			local var_605_5 = 0.125

			if 0 < arg_602_1.time_ and arg_602_1.time_ <= var_605_4 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				arg_602_1.leftNameTxt_.text = arg_602_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, false)
				arg_602_1.callingController_:SetSelectedState("normal")

				local var_605_6 = arg_602_1:GetWordFromCfg(1109403146)
				local var_605_7 = arg_602_1:FormatText(var_605_6.content)

				arg_602_1.text_.text = var_605_7

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_9 = 5 <= 0 and var_605_5 or var_605_5 * (utf8.len(var_605_7) / 5)

				if (5 <= 0 and var_605_5 or var_605_5 * (utf8.len(var_605_7) / 5)) > 0 and var_605_5 < var_605_9 then
					arg_602_1.talkMaxDuration = var_605_9

					if var_605_9 + var_605_4 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_9 + var_605_4
					end
				end

				arg_602_1.text_.text = var_605_7
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb") ~= 0 then
					local var_605_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb") / 1000

					if var_605_10 + var_605_4 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_10 + var_605_4
					end

					if var_605_6.prefab_name ~= "" and arg_602_1.actors_[var_605_6.prefab_name] ~= nil then
						local var_605_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_602_1.actors_[var_605_6.prefab_name].transform, "story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb")

						arg_602_1:RecordAudio("1109403146", var_605_11)
						arg_602_1:RecordAudio("1109403146", var_605_11)
					else
						arg_602_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb")
					end

					arg_602_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403146", "story_v_side_new_1109403.awb")
				end

				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_12 = math.max(var_605_5, arg_602_1.talkMaxDuration)

			if var_605_4 <= arg_602_1.time_ and arg_602_1.time_ < var_605_4 + var_605_12 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_4) / var_605_12

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_4 + var_605_12 and arg_602_1.time_ < var_605_4 + var_605_12 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_602_1:InitPlayNodeList()
	end,
	Play1109403147 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1109403147
		arg_606_1.duration_ = 7

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1109403148(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				local var_609_0 = arg_606_1.bgs_.STblack

				arg_606_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_609_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_609_1 = var_609_0:GetComponent("SpriteRenderer")

				if var_609_1 and var_609_1.sprite then
					local var_609_2 = 2 * (var_609_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_609_0.transform.localScale = Vector3.New(var_609_2 / var_609_1.sprite.bounds.size.y < var_609_2 * manager.ui.mainCameraCom_.aspect / var_609_1.sprite.bounds.size.x and var_609_2 * manager.ui.mainCameraCom_.aspect / var_609_1.sprite.bounds.size.x or var_609_2 / var_609_1.sprite.bounds.size.y, var_609_2 / var_609_1.sprite.bounds.size.y < var_609_2 * manager.ui.mainCameraCom_.aspect / var_609_1.sprite.bounds.size.x and var_609_2 * manager.ui.mainCameraCom_.aspect / var_609_1.sprite.bounds.size.x or var_609_2 / var_609_1.sprite.bounds.size.y, 0)
				end

				for iter_609_0, iter_609_1 in pairs(arg_606_1.bgs_) do
					if iter_609_0 ~= "STblack" then
						iter_609_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_609_3 = 0

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_3 + arg_609_0 then
				arg_606_1.mask_.enabled = true
				arg_606_1.mask_.raycastTarget = true

				arg_606_1:SetGaussion(false)
			end

			local var_609_4 = 2

			if var_609_3 <= arg_606_1.time_ and arg_606_1.time_ < var_609_3 + var_609_4 then
				local var_609_5 = Color.New(0, 0, 0)

				var_609_5.a = Mathf.Lerp(1, 0, (arg_606_1.time_ - var_609_3) / var_609_4)
				arg_606_1.mask_.color = var_609_5
			end

			if arg_606_1.time_ >= var_609_3 + var_609_4 and arg_606_1.time_ < var_609_3 + var_609_4 + arg_609_0 then
				local var_609_6 = Color.New(0, 0, 0)

				arg_606_1.mask_.enabled = false
				var_609_6.a = 0
				arg_606_1.mask_.color = var_609_6
			end

			local var_609_7 = arg_606_1.actors_["1048ui_story"].transform

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 then
				arg_606_1.var_.moveOldPos1048ui_story = var_609_7.localPosition
			end

			local var_609_8 = 0.001

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_8 then
				var_609_7.localPosition = Vector3.Lerp(arg_606_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_606_1.time_ - 0) / var_609_8)
				var_609_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_609_7.position).x, (manager.ui.mainCamera.transform.position - var_609_7.position).y, (manager.ui.mainCamera.transform.position - var_609_7.position).z)
				var_609_7.localEulerAngles.z = 0
				var_609_7.localEulerAngles.x = 0
				var_609_7.localEulerAngles = var_609_7.localEulerAngles
			end

			if arg_606_1.time_ >= 0 + var_609_8 and arg_606_1.time_ < 0 + var_609_8 + arg_609_0 then
				var_609_7.localPosition = Vector3.New(0, 100, 0)
				var_609_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_609_7.position).x, (manager.ui.mainCamera.transform.position - var_609_7.position).y, (manager.ui.mainCamera.transform.position - var_609_7.position).z)
				var_609_7.localEulerAngles.z = 0
				var_609_7.localEulerAngles.x = 0
				var_609_7.localEulerAngles = var_609_7.localEulerAngles
			end

			local var_609_9 = arg_606_1.actors_["1048ui_story"]

			if 0 < arg_606_1.time_ and arg_606_1.time_ <= 0 + arg_609_0 and not isNil(var_609_9) and arg_606_1.var_.characterEffect1048ui_story == nil then
				arg_606_1.var_.characterEffect1048ui_story = var_609_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_609_10 = 0.200000002980232

			if 0 <= arg_606_1.time_ and arg_606_1.time_ < 0 + var_609_10 and not isNil(var_609_9) then
				if arg_606_1.var_.characterEffect1048ui_story and not isNil(var_609_9) then
					arg_606_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_606_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_606_1.time_ - 0) / var_609_10)
				end
			end

			if arg_606_1.time_ >= 0 + var_609_10 and arg_606_1.time_ < 0 + var_609_10 + arg_609_0 and not isNil(var_609_9) and arg_606_1.var_.characterEffect1048ui_story then
				arg_606_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_606_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			if arg_606_1.frameCnt_ <= 1 then
				arg_606_1.dialog_:SetActive(false)
			end

			local var_609_11 = 2
			local var_609_12 = 0.125

			if 2 < arg_606_1.time_ and arg_606_1.time_ <= var_609_11 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0

				arg_606_1.dialog_:SetActive(true)

				arg_606_1.dialogCg_.alpha = 0

				local var_609_13 = LeanTween.value(arg_606_1.dialog_, 0, 1, 0.3)

				var_609_13:setOnUpdate(LuaHelper.FloatAction(function(arg_610_0)
					arg_606_1.dialogCg_.alpha = arg_610_0
				end))
				var_609_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_606_1.dialog_)
					var_609_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_606_1.duration_ = arg_606_1.duration_ + 0.3

				SetActive(arg_606_1.leftNameGo_, false)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_14 = arg_606_1:FormatText(arg_606_1:GetWordFromCfg(1109403147).content)

				arg_606_1.text_.text = var_609_14

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_16 = 5 <= 0 and var_609_12 or var_609_12 * (utf8.len(var_609_14) / 5)

				if (5 <= 0 and var_609_12 or var_609_12 * (utf8.len(var_609_14) / 5)) > 0 and var_609_12 < var_609_16 then
					arg_606_1.talkMaxDuration = var_609_16
					var_609_11 = var_609_11 + 0.3

					if var_609_16 + var_609_11 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_16 + var_609_11
					end
				end

				arg_606_1.text_.text = var_609_14
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)
				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_17 = var_609_11 + 0.3
			local var_609_18 = math.max(var_609_12, arg_606_1.talkMaxDuration)

			if var_609_11 + 0.3 <= arg_606_1.time_ and arg_606_1.time_ < var_609_17 + var_609_18 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_17) / var_609_18

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_17 + var_609_18 and arg_606_1.time_ < var_609_17 + var_609_18 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_606_1:InitPlayNodeList()
	end,
	Play1109403148 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1109403148
		arg_612_1.duration_ = 10.6

		local var_612_0 = {
			ja = 10.2,
			ko = 10.6,
			zh = 10.6
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play1109403149(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			if arg_612_1.bgs_.ST10 == nil then
				local var_615_0 = Object.Instantiate(arg_612_1.paintGo_)

				var_615_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")
				var_615_0.name = "ST10"
				var_615_0.transform.parent = arg_612_1.stage_.transform
				var_615_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_612_1.bgs_.ST10 = var_615_0
			end

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= 0 + arg_615_0 then
				local var_615_1 = arg_612_1.bgs_.ST10

				arg_612_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_615_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_615_2 = var_615_1:GetComponent("SpriteRenderer")

				if var_615_2 and var_615_2.sprite then
					local var_615_3 = 2 * (var_615_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_615_1.transform.localScale = Vector3.New(var_615_3 / var_615_2.sprite.bounds.size.y < var_615_3 * manager.ui.mainCameraCom_.aspect / var_615_2.sprite.bounds.size.x and var_615_3 * manager.ui.mainCameraCom_.aspect / var_615_2.sprite.bounds.size.x or var_615_3 / var_615_2.sprite.bounds.size.y, var_615_3 / var_615_2.sprite.bounds.size.y < var_615_3 * manager.ui.mainCameraCom_.aspect / var_615_2.sprite.bounds.size.x and var_615_3 * manager.ui.mainCameraCom_.aspect / var_615_2.sprite.bounds.size.x or var_615_3 / var_615_2.sprite.bounds.size.y, 0)
				end

				for iter_615_0, iter_615_1 in pairs(arg_612_1.bgs_) do
					if iter_615_0 ~= "ST10" then
						iter_615_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_615_4 = 0

			if 0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_4 + arg_615_0 then
				arg_612_1.mask_.enabled = true
				arg_612_1.mask_.raycastTarget = true

				arg_612_1:SetGaussion(false)
			end

			local var_615_5 = 2

			if var_615_4 <= arg_612_1.time_ and arg_612_1.time_ < var_615_4 + var_615_5 then
				local var_615_6 = Color.New(0, 0, 0)

				var_615_6.a = Mathf.Lerp(1, 0, (arg_612_1.time_ - var_615_4) / var_615_5)
				arg_612_1.mask_.color = var_615_6
			end

			if arg_612_1.time_ >= var_615_4 + var_615_5 and arg_612_1.time_ < var_615_4 + var_615_5 + arg_615_0 then
				local var_615_7 = Color.New(0, 0, 0)

				arg_612_1.mask_.enabled = false
				var_615_7.a = 0
				arg_612_1.mask_.color = var_615_7
			end

			local var_615_8 = "1066ui_story"

			if arg_612_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_615_9 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_612_1.stage_.transform)

				var_615_9.name = var_615_8
				var_615_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_612_1.actors_[var_615_8] = var_615_9

				local var_615_10 = var_615_9:GetComponentInChildren(typeof(CharacterEffect))

				var_615_10.enabled = true

				local var_615_11 = GameObjectTools.GetOrAddComponent(var_615_9, typeof(DynamicBoneHelper))

				if var_615_11 then
					var_615_11:EnableDynamicBone(false)
				end

				arg_612_1:ShowWeapon(var_615_10.transform, false)

				arg_612_1.var_[var_615_8 .. "Animator"] = var_615_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_612_1.var_[var_615_8 .. "Animator"].applyRootMotion = true
				arg_612_1.var_[var_615_8 .. "LipSync"] = var_615_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_615_12 = arg_612_1.actors_["1066ui_story"].transform

			if 2 < arg_612_1.time_ and arg_612_1.time_ <= 2 + arg_615_0 then
				arg_612_1.var_.moveOldPos1066ui_story = var_615_12.localPosition
			end

			local var_615_13 = 0.001

			if 2 <= arg_612_1.time_ and arg_612_1.time_ < 2 + var_615_13 then
				var_615_12.localPosition = Vector3.Lerp(arg_612_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_612_1.time_ - 2) / var_615_13)
				var_615_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_615_12.position).x, (manager.ui.mainCamera.transform.position - var_615_12.position).y, (manager.ui.mainCamera.transform.position - var_615_12.position).z)
				var_615_12.localEulerAngles.z = 0
				var_615_12.localEulerAngles.x = 0
				var_615_12.localEulerAngles = var_615_12.localEulerAngles
			end

			if arg_612_1.time_ >= 2 + var_615_13 and arg_612_1.time_ < 2 + var_615_13 + arg_615_0 then
				var_615_12.localPosition = Vector3.New(0, -0.77, -6.1)
				var_615_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_615_12.position).x, (manager.ui.mainCamera.transform.position - var_615_12.position).y, (manager.ui.mainCamera.transform.position - var_615_12.position).z)
				var_615_12.localEulerAngles.z = 0
				var_615_12.localEulerAngles.x = 0
				var_615_12.localEulerAngles = var_615_12.localEulerAngles
			end

			local var_615_14 = arg_612_1.actors_["1066ui_story"]

			if 2 < arg_612_1.time_ and arg_612_1.time_ <= 2 + arg_615_0 and not isNil(var_615_14) and arg_612_1.var_.characterEffect1066ui_story == nil then
				arg_612_1.var_.characterEffect1066ui_story = var_615_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_615_15 = 0.200000002980232

			if 2 <= arg_612_1.time_ and arg_612_1.time_ < 2 + var_615_15 and not isNil(var_615_14) then
				if arg_612_1.var_.characterEffect1066ui_story and not isNil(var_615_14) then
					arg_612_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_612_1.time_ >= 2 + var_615_15 and arg_612_1.time_ < 2 + var_615_15 + arg_615_0 and not isNil(var_615_14) and arg_612_1.var_.characterEffect1066ui_story then
				arg_612_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 2 < arg_612_1.time_ and arg_612_1.time_ <= 2 + arg_615_0 then
				arg_612_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 2 < arg_612_1.time_ and arg_612_1.time_ <= 2 + arg_615_0 then
				arg_612_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_612_1.frameCnt_ <= 1 then
				arg_612_1.dialog_:SetActive(false)
			end

			local var_615_17 = 2
			local var_615_18 = 0.825

			if 2 < arg_612_1.time_ and arg_612_1.time_ <= var_615_17 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0

				arg_612_1.dialog_:SetActive(true)

				arg_612_1.dialogCg_.alpha = 0

				local var_615_19 = LeanTween.value(arg_612_1.dialog_, 0, 1, 0.3)

				var_615_19:setOnUpdate(LuaHelper.FloatAction(function(arg_616_0)
					arg_612_1.dialogCg_.alpha = arg_616_0
				end))
				var_615_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_612_1.dialog_)
					var_615_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_612_1.duration_ = arg_612_1.duration_ + 0.3

				SetActive(arg_612_1.leftNameGo_, true)

				arg_612_1.leftNameTxt_.text = arg_612_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_20 = arg_612_1:GetWordFromCfg(1109403148)
				local var_615_21 = arg_612_1:FormatText(var_615_20.content)

				arg_612_1.text_.text = var_615_21

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_23 = 33 <= 0 and var_615_18 or var_615_18 * (utf8.len(var_615_21) / 33)

				if (33 <= 0 and var_615_18 or var_615_18 * (utf8.len(var_615_21) / 33)) > 0 and var_615_18 < var_615_23 then
					arg_612_1.talkMaxDuration = var_615_23
					var_615_17 = var_615_17 + 0.3

					if var_615_23 + var_615_17 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_23 + var_615_17
					end
				end

				arg_612_1.text_.text = var_615_21
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb") ~= 0 then
					local var_615_24 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb") / 1000

					if var_615_24 + var_615_17 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_24 + var_615_17
					end

					if var_615_20.prefab_name ~= "" and arg_612_1.actors_[var_615_20.prefab_name] ~= nil then
						local var_615_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_20.prefab_name].transform, "story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb")

						arg_612_1:RecordAudio("1109403148", var_615_25)
						arg_612_1:RecordAudio("1109403148", var_615_25)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403148", "story_v_side_new_1109403.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_26 = var_615_17 + 0.3
			local var_615_27 = math.max(var_615_18, arg_612_1.talkMaxDuration)

			if var_615_17 + 0.3 <= arg_612_1.time_ and arg_612_1.time_ < var_615_26 + var_615_27 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_26) / var_615_27

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_26 + var_615_27 and arg_612_1.time_ < var_615_26 + var_615_27 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_612_1:InitPlayNodeList()
	end,
	Play1109403149 = function(arg_618_0, arg_618_1)
		arg_618_1.time_ = 0
		arg_618_1.frameCnt_ = 0
		arg_618_1.state_ = "playing"
		arg_618_1.curTalkId_ = 1109403149
		arg_618_1.duration_ = 5.53

		local var_618_0 = {
			ja = 5.266,
			ko = 5.533,
			zh = 5.533
		}
		local var_618_1 = manager.audio:GetLocalizationFlag()

		if var_618_0[var_618_1] ~= nil then
			arg_618_1.duration_ = var_618_0[var_618_1]
		end

		SetActive(arg_618_1.tipsGo_, false)

		function arg_618_1.onSingleLineFinish_()
			arg_618_1.onSingleLineUpdate_ = nil
			arg_618_1.onSingleLineFinish_ = nil
			arg_618_1.state_ = "waiting"
		end

		function arg_618_1.playNext_(arg_620_0)
			if arg_620_0 == 1 then
				arg_618_0:Play1109403150(arg_618_1)
			end
		end

		function arg_618_1.onSingleLineUpdate_(arg_621_0)
			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1.var_.moveOldPos1066ui_story = arg_618_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_621_0 = 0.001

			if 0 <= arg_618_1.time_ and arg_618_1.time_ < 0 + var_621_0 then
				arg_618_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_618_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_618_1.time_ - 0) / var_621_0)
				arg_618_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_618_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1066ui_story"].transform.position).z)
				arg_618_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_618_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_618_1.actors_["1066ui_story"].transform.localEulerAngles = arg_618_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_618_1.time_ >= 0 + var_621_0 and arg_618_1.time_ < 0 + var_621_0 + arg_621_0 then
				arg_618_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_618_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_618_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_618_1.actors_["1066ui_story"].transform.position).z)
				arg_618_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_618_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_618_1.actors_["1066ui_story"].transform.localEulerAngles = arg_618_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= 0 + arg_621_0 then
				arg_618_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_621_1 = 0
			local var_621_2 = 0.625

			if 0 < arg_618_1.time_ and arg_618_1.time_ <= var_621_1 + arg_621_0 then
				arg_618_1.talkMaxDuration = 0
				arg_618_1.dialogCg_.alpha = 1

				arg_618_1.dialog_:SetActive(true)
				SetActive(arg_618_1.leftNameGo_, true)

				arg_618_1.leftNameTxt_.text = arg_618_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_618_1.leftNameTxt_.transform)

				arg_618_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_618_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_618_1:RecordName(arg_618_1.leftNameTxt_.text)
				SetActive(arg_618_1.iconTrs_.gameObject, false)
				arg_618_1.callingController_:SetSelectedState("normal")

				local var_621_3 = arg_618_1:GetWordFromCfg(1109403149)
				local var_621_4 = arg_618_1:FormatText(var_621_3.content)

				arg_618_1.text_.text = var_621_4

				LuaForUtil.ClearLinePrefixSymbol(arg_618_1.text_)

				local var_621_6 = 25 <= 0 and var_621_2 or var_621_2 * (utf8.len(var_621_4) / 25)

				if (25 <= 0 and var_621_2 or var_621_2 * (utf8.len(var_621_4) / 25)) > 0 and var_621_2 < var_621_6 then
					arg_618_1.talkMaxDuration = var_621_6

					if var_621_6 + var_621_1 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_6 + var_621_1
					end
				end

				arg_618_1.text_.text = var_621_4
				arg_618_1.typewritter.percent = 0

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb") ~= 0 then
					local var_621_7 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb") / 1000

					if var_621_7 + var_621_1 > arg_618_1.duration_ then
						arg_618_1.duration_ = var_621_7 + var_621_1
					end

					if var_621_3.prefab_name ~= "" and arg_618_1.actors_[var_621_3.prefab_name] ~= nil then
						local var_621_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_618_1.actors_[var_621_3.prefab_name].transform, "story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb")

						arg_618_1:RecordAudio("1109403149", var_621_8)
						arg_618_1:RecordAudio("1109403149", var_621_8)
					else
						arg_618_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb")
					end

					arg_618_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403149", "story_v_side_new_1109403.awb")
				end

				arg_618_1:RecordContent(arg_618_1.text_.text)
			end

			local var_621_9 = math.max(var_621_2, arg_618_1.talkMaxDuration)

			if var_621_1 <= arg_618_1.time_ and arg_618_1.time_ < var_621_1 + var_621_9 then
				arg_618_1.typewritter.percent = (arg_618_1.time_ - var_621_1) / var_621_9

				arg_618_1.typewritter:SetDirty()
			end

			if arg_618_1.time_ >= var_621_1 + var_621_9 and arg_618_1.time_ < var_621_1 + var_621_9 + arg_621_0 then
				arg_618_1.typewritter.percent = 1

				arg_618_1.typewritter:SetDirty()
				arg_618_1:ShowNextGo(true)
			end
		end

		arg_618_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_618_1:InitPlayNodeList()
	end,
	Play1109403150 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1109403150
		arg_622_1.duration_ = 10.17

		local var_622_0 = {
			ja = 10.166,
			ko = 7.566,
			zh = 7.566
		}
		local var_622_1 = manager.audio:GetLocalizationFlag()

		if var_622_0[var_622_1] ~= nil then
			arg_622_1.duration_ = var_622_0[var_622_1]
		end

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1109403151(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1.var_.moveOldPos1066ui_story = arg_622_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_625_0 = 0.001

			if 0 <= arg_622_1.time_ and arg_622_1.time_ < 0 + var_625_0 then
				arg_622_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_622_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_622_1.time_ - 0) / var_625_0)
				arg_622_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_622_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_622_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_622_1.actors_["1066ui_story"].transform.position).z)
				arg_622_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_622_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_622_1.actors_["1066ui_story"].transform.localEulerAngles = arg_622_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_622_1.time_ >= 0 + var_625_0 and arg_622_1.time_ < 0 + var_625_0 + arg_625_0 then
				arg_622_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_622_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_622_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_622_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_622_1.actors_["1066ui_story"].transform.position).z)
				arg_622_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_622_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_622_1.actors_["1066ui_story"].transform.localEulerAngles = arg_622_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action423")
			end

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= 0 + arg_625_0 then
				arg_622_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_625_1 = 0
			local var_625_2 = 0.675

			if 0 < arg_622_1.time_ and arg_622_1.time_ <= var_625_1 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				arg_622_1.leftNameTxt_.text = arg_622_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, false)
				arg_622_1.callingController_:SetSelectedState("normal")

				local var_625_3 = arg_622_1:GetWordFromCfg(1109403150)
				local var_625_4 = arg_622_1:FormatText(var_625_3.content)

				arg_622_1.text_.text = var_625_4

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_6 = 27 <= 0 and var_625_2 or var_625_2 * (utf8.len(var_625_4) / 27)

				if (27 <= 0 and var_625_2 or var_625_2 * (utf8.len(var_625_4) / 27)) > 0 and var_625_2 < var_625_6 then
					arg_622_1.talkMaxDuration = var_625_6

					if var_625_6 + var_625_1 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_6 + var_625_1
					end
				end

				arg_622_1.text_.text = var_625_4
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb") ~= 0 then
					local var_625_7 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb") / 1000

					if var_625_7 + var_625_1 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_7 + var_625_1
					end

					if var_625_3.prefab_name ~= "" and arg_622_1.actors_[var_625_3.prefab_name] ~= nil then
						local var_625_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_622_1.actors_[var_625_3.prefab_name].transform, "story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb")

						arg_622_1:RecordAudio("1109403150", var_625_8)
						arg_622_1:RecordAudio("1109403150", var_625_8)
					else
						arg_622_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb")
					end

					arg_622_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403150", "story_v_side_new_1109403.awb")
				end

				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_9 = math.max(var_625_2, arg_622_1.talkMaxDuration)

			if var_625_1 <= arg_622_1.time_ and arg_622_1.time_ < var_625_1 + var_625_9 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_1) / var_625_9

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_1 + var_625_9 and arg_622_1.time_ < var_625_1 + var_625_9 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_622_1:InitPlayNodeList()
	end,
	Play1109403151 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1109403151
		arg_626_1.duration_ = 14.3

		local var_626_0 = {
			ja = 14.3,
			ko = 11.7,
			zh = 11.7
		}
		local var_626_1 = manager.audio:GetLocalizationFlag()

		if var_626_0[var_626_1] ~= nil then
			arg_626_1.duration_ = var_626_0[var_626_1]
		end

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1109403152(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			if 2 < arg_626_1.time_ and arg_626_1.time_ <= 2 + arg_629_0 then
				local var_629_0 = arg_626_1.bgs_.ST01

				arg_626_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_629_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_629_1 = var_629_0:GetComponent("SpriteRenderer")

				if var_629_1 and var_629_1.sprite then
					local var_629_2 = 2 * (var_629_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_629_0.transform.localScale = Vector3.New(var_629_2 / var_629_1.sprite.bounds.size.y < var_629_2 * manager.ui.mainCameraCom_.aspect / var_629_1.sprite.bounds.size.x and var_629_2 * manager.ui.mainCameraCom_.aspect / var_629_1.sprite.bounds.size.x or var_629_2 / var_629_1.sprite.bounds.size.y, var_629_2 / var_629_1.sprite.bounds.size.y < var_629_2 * manager.ui.mainCameraCom_.aspect / var_629_1.sprite.bounds.size.x and var_629_2 * manager.ui.mainCameraCom_.aspect / var_629_1.sprite.bounds.size.x or var_629_2 / var_629_1.sprite.bounds.size.y, 0)
				end

				for iter_629_0, iter_629_1 in pairs(arg_626_1.bgs_) do
					if iter_629_0 ~= "ST01" then
						iter_629_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_629_3 = 0

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_3 + arg_629_0 then
				arg_626_1.mask_.enabled = true
				arg_626_1.mask_.raycastTarget = true

				arg_626_1:SetGaussion(false)
			end

			local var_629_4 = 2

			if var_629_3 <= arg_626_1.time_ and arg_626_1.time_ < var_629_3 + var_629_4 then
				local var_629_5 = Color.New(0, 0, 0)

				var_629_5.a = Mathf.Lerp(0, 1, (arg_626_1.time_ - var_629_3) / var_629_4)
				arg_626_1.mask_.color = var_629_5
			end

			if arg_626_1.time_ >= var_629_3 + var_629_4 and arg_626_1.time_ < var_629_3 + var_629_4 + arg_629_0 then
				local var_629_6 = Color.New(0, 0, 0)

				var_629_6.a = 1
				arg_626_1.mask_.color = var_629_6
			end

			local var_629_7 = 2

			if 2 < arg_626_1.time_ and arg_626_1.time_ <= var_629_7 + arg_629_0 then
				arg_626_1.mask_.enabled = true
				arg_626_1.mask_.raycastTarget = true

				arg_626_1:SetGaussion(false)
			end

			local var_629_8 = 2

			if var_629_7 <= arg_626_1.time_ and arg_626_1.time_ < var_629_7 + var_629_8 then
				local var_629_9 = Color.New(0, 0, 0)

				var_629_9.a = Mathf.Lerp(1, 0, (arg_626_1.time_ - var_629_7) / var_629_8)
				arg_626_1.mask_.color = var_629_9
			end

			if arg_626_1.time_ >= var_629_7 + var_629_8 and arg_626_1.time_ < var_629_7 + var_629_8 + arg_629_0 then
				local var_629_10 = Color.New(0, 0, 0)

				arg_626_1.mask_.enabled = false
				var_629_10.a = 0
				arg_626_1.mask_.color = var_629_10
			end

			local var_629_11 = "1011ui_story"

			if arg_626_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_629_12 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_626_1.stage_.transform)

				var_629_12.name = var_629_11
				var_629_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_626_1.actors_[var_629_11] = var_629_12

				local var_629_13 = var_629_12:GetComponentInChildren(typeof(CharacterEffect))

				var_629_13.enabled = true

				local var_629_14 = GameObjectTools.GetOrAddComponent(var_629_12, typeof(DynamicBoneHelper))

				if var_629_14 then
					var_629_14:EnableDynamicBone(false)
				end

				arg_626_1:ShowWeapon(var_629_13.transform, false)

				arg_626_1.var_[var_629_11 .. "Animator"] = var_629_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_626_1.var_[var_629_11 .. "Animator"].applyRootMotion = true
				arg_626_1.var_[var_629_11 .. "LipSync"] = var_629_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_629_15 = arg_626_1.actors_["1011ui_story"].transform

			if 4 < arg_626_1.time_ and arg_626_1.time_ <= 4 + arg_629_0 then
				arg_626_1.var_.moveOldPos1011ui_story = var_629_15.localPosition
			end

			local var_629_16 = 0.001

			if 4 <= arg_626_1.time_ and arg_626_1.time_ < 4 + var_629_16 then
				var_629_15.localPosition = Vector3.Lerp(arg_626_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_626_1.time_ - 4) / var_629_16)
				var_629_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_629_15.position).x, (manager.ui.mainCamera.transform.position - var_629_15.position).y, (manager.ui.mainCamera.transform.position - var_629_15.position).z)
				var_629_15.localEulerAngles.z = 0
				var_629_15.localEulerAngles.x = 0
				var_629_15.localEulerAngles = var_629_15.localEulerAngles
			end

			if arg_626_1.time_ >= 4 + var_629_16 and arg_626_1.time_ < 4 + var_629_16 + arg_629_0 then
				var_629_15.localPosition = Vector3.New(0, -0.71, -6)
				var_629_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_629_15.position).x, (manager.ui.mainCamera.transform.position - var_629_15.position).y, (manager.ui.mainCamera.transform.position - var_629_15.position).z)
				var_629_15.localEulerAngles.z = 0
				var_629_15.localEulerAngles.x = 0
				var_629_15.localEulerAngles = var_629_15.localEulerAngles
			end

			local var_629_17 = arg_626_1.actors_["1011ui_story"]

			if 4 < arg_626_1.time_ and arg_626_1.time_ <= 4 + arg_629_0 and not isNil(var_629_17) and arg_626_1.var_.characterEffect1011ui_story == nil then
				arg_626_1.var_.characterEffect1011ui_story = var_629_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_629_18 = 0.200000002980232

			if 4 <= arg_626_1.time_ and arg_626_1.time_ < 4 + var_629_18 and not isNil(var_629_17) then
				if arg_626_1.var_.characterEffect1011ui_story and not isNil(var_629_17) then
					arg_626_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_626_1.time_ >= 4 + var_629_18 and arg_626_1.time_ < 4 + var_629_18 + arg_629_0 and not isNil(var_629_17) and arg_626_1.var_.characterEffect1011ui_story then
				arg_626_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 4 < arg_626_1.time_ and arg_626_1.time_ <= 4 + arg_629_0 then
				arg_626_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 4 < arg_626_1.time_ and arg_626_1.time_ <= 4 + arg_629_0 then
				arg_626_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_629_20 = arg_626_1.actors_["1066ui_story"].transform

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 then
				arg_626_1.var_.moveOldPos1066ui_story = var_629_20.localPosition
			end

			local var_629_21 = 0.001

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_21 then
				var_629_20.localPosition = Vector3.Lerp(arg_626_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_626_1.time_ - 0) / var_629_21)
				var_629_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_629_20.position).x, (manager.ui.mainCamera.transform.position - var_629_20.position).y, (manager.ui.mainCamera.transform.position - var_629_20.position).z)
				var_629_20.localEulerAngles.z = 0
				var_629_20.localEulerAngles.x = 0
				var_629_20.localEulerAngles = var_629_20.localEulerAngles
			end

			if arg_626_1.time_ >= 0 + var_629_21 and arg_626_1.time_ < 0 + var_629_21 + arg_629_0 then
				var_629_20.localPosition = Vector3.New(0, 100, 0)
				var_629_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_629_20.position).x, (manager.ui.mainCamera.transform.position - var_629_20.position).y, (manager.ui.mainCamera.transform.position - var_629_20.position).z)
				var_629_20.localEulerAngles.z = 0
				var_629_20.localEulerAngles.x = 0
				var_629_20.localEulerAngles = var_629_20.localEulerAngles
			end

			local var_629_22 = arg_626_1.actors_["1066ui_story"]

			if 0 < arg_626_1.time_ and arg_626_1.time_ <= 0 + arg_629_0 and not isNil(var_629_22) and arg_626_1.var_.characterEffect1066ui_story == nil then
				arg_626_1.var_.characterEffect1066ui_story = var_629_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_629_23 = 0.200000002980232

			if 0 <= arg_626_1.time_ and arg_626_1.time_ < 0 + var_629_23 and not isNil(var_629_22) then
				if arg_626_1.var_.characterEffect1066ui_story and not isNil(var_629_22) then
					arg_626_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_626_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_626_1.time_ - 0) / var_629_23)
				end
			end

			if arg_626_1.time_ >= 0 + var_629_23 and arg_626_1.time_ < 0 + var_629_23 + arg_629_0 and not isNil(var_629_22) and arg_626_1.var_.characterEffect1066ui_story then
				arg_626_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_626_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if arg_626_1.frameCnt_ <= 1 then
				arg_626_1.dialog_:SetActive(false)
			end

			local var_629_24 = 4
			local var_629_25 = 0.7

			if 4 < arg_626_1.time_ and arg_626_1.time_ <= var_629_24 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0

				arg_626_1.dialog_:SetActive(true)

				arg_626_1.dialogCg_.alpha = 0

				local var_629_26 = LeanTween.value(arg_626_1.dialog_, 0, 1, 0.3)

				var_629_26:setOnUpdate(LuaHelper.FloatAction(function(arg_630_0)
					arg_626_1.dialogCg_.alpha = arg_630_0
				end))
				var_629_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_626_1.dialog_)
					var_629_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_626_1.duration_ = arg_626_1.duration_ + 0.3

				SetActive(arg_626_1.leftNameGo_, true)

				arg_626_1.leftNameTxt_.text = arg_626_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, false)
				arg_626_1.callingController_:SetSelectedState("normal")

				local var_629_27 = arg_626_1:GetWordFromCfg(1109403151)
				local var_629_28 = arg_626_1:FormatText(var_629_27.content)

				arg_626_1.text_.text = var_629_28

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_30 = 28 <= 0 and var_629_25 or var_629_25 * (utf8.len(var_629_28) / 28)

				if (28 <= 0 and var_629_25 or var_629_25 * (utf8.len(var_629_28) / 28)) > 0 and var_629_25 < var_629_30 then
					arg_626_1.talkMaxDuration = var_629_30
					var_629_24 = var_629_24 + 0.3

					if var_629_30 + var_629_24 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_30 + var_629_24
					end
				end

				arg_626_1.text_.text = var_629_28
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb") ~= 0 then
					local var_629_31 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb") / 1000

					if var_629_31 + var_629_24 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_31 + var_629_24
					end

					if var_629_27.prefab_name ~= "" and arg_626_1.actors_[var_629_27.prefab_name] ~= nil then
						local var_629_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_626_1.actors_[var_629_27.prefab_name].transform, "story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb")

						arg_626_1:RecordAudio("1109403151", var_629_32)
						arg_626_1:RecordAudio("1109403151", var_629_32)
					else
						arg_626_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb")
					end

					arg_626_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403151", "story_v_side_new_1109403.awb")
				end

				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_33 = var_629_24 + 0.3
			local var_629_34 = math.max(var_629_25, arg_626_1.talkMaxDuration)

			if var_629_24 + 0.3 <= arg_626_1.time_ and arg_626_1.time_ < var_629_33 + var_629_34 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_33) / var_629_34

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_33 + var_629_34 and arg_626_1.time_ < var_629_33 + var_629_34 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_626_1:InitPlayNodeList()
	end,
	Play1109403152 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1109403152
		arg_632_1.duration_ = 13.57

		local var_632_0 = {
			ja = 13.566,
			ko = 6.066,
			zh = 6.066
		}
		local var_632_1 = manager.audio:GetLocalizationFlag()

		if var_632_0[var_632_1] ~= nil then
			arg_632_1.duration_ = var_632_0[var_632_1]
		end

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1109403153(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1.var_.moveOldPos1011ui_story = arg_632_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_635_0 = 0.001

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_0 then
				arg_632_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_632_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_632_1.time_ - 0) / var_635_0)
				arg_632_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_632_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["1011ui_story"].transform.position).z)
				arg_632_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_632_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_632_1.actors_["1011ui_story"].transform.localEulerAngles = arg_632_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_632_1.time_ >= 0 + var_635_0 and arg_632_1.time_ < 0 + var_635_0 + arg_635_0 then
				arg_632_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_632_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_632_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_632_1.actors_["1011ui_story"].transform.position).z)
				arg_632_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_632_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_632_1.actors_["1011ui_story"].transform.localEulerAngles = arg_632_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_635_1 = arg_632_1.actors_["1011ui_story"]

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 and not isNil(var_635_1) and arg_632_1.var_.characterEffect1011ui_story == nil then
				arg_632_1.var_.characterEffect1011ui_story = var_635_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_2 = 0.200000002980232

			if 0 <= arg_632_1.time_ and arg_632_1.time_ < 0 + var_635_2 and not isNil(var_635_1) then
				if arg_632_1.var_.characterEffect1011ui_story and not isNil(var_635_1) then
					arg_632_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_632_1.time_ >= 0 + var_635_2 and arg_632_1.time_ < 0 + var_635_2 + arg_635_0 and not isNil(var_635_1) and arg_632_1.var_.characterEffect1011ui_story then
				arg_632_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action462")
			end

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= 0 + arg_635_0 then
				arg_632_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_635_4 = 0
			local var_635_5 = 0.725

			if 0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_4 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				arg_632_1.leftNameTxt_.text = arg_632_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, false)
				arg_632_1.callingController_:SetSelectedState("normal")

				local var_635_6 = arg_632_1:GetWordFromCfg(1109403152)
				local var_635_7 = arg_632_1:FormatText(var_635_6.content)

				arg_632_1.text_.text = var_635_7

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_9 = 29 <= 0 and var_635_5 or var_635_5 * (utf8.len(var_635_7) / 29)

				if (29 <= 0 and var_635_5 or var_635_5 * (utf8.len(var_635_7) / 29)) > 0 and var_635_5 < var_635_9 then
					arg_632_1.talkMaxDuration = var_635_9

					if var_635_9 + var_635_4 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_9 + var_635_4
					end
				end

				arg_632_1.text_.text = var_635_7
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb") ~= 0 then
					local var_635_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb") / 1000

					if var_635_10 + var_635_4 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_10 + var_635_4
					end

					if var_635_6.prefab_name ~= "" and arg_632_1.actors_[var_635_6.prefab_name] ~= nil then
						local var_635_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_632_1.actors_[var_635_6.prefab_name].transform, "story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb")

						arg_632_1:RecordAudio("1109403152", var_635_11)
						arg_632_1:RecordAudio("1109403152", var_635_11)
					else
						arg_632_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb")
					end

					arg_632_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403152", "story_v_side_new_1109403.awb")
				end

				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_12 = math.max(var_635_5, arg_632_1.talkMaxDuration)

			if var_635_4 <= arg_632_1.time_ and arg_632_1.time_ < var_635_4 + var_635_12 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_4) / var_635_12

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_4 + var_635_12 and arg_632_1.time_ < var_635_4 + var_635_12 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_632_1:InitPlayNodeList()
	end,
	Play1109403153 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1109403153
		arg_636_1.duration_ = 12.93

		local var_636_0 = {
			ja = 12.933,
			ko = 10.833,
			zh = 10.833
		}
		local var_636_1 = manager.audio:GetLocalizationFlag()

		if var_636_0[var_636_1] ~= nil then
			arg_636_1.duration_ = var_636_0[var_636_1]
		end

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1109403154(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			if 2 < arg_636_1.time_ and arg_636_1.time_ <= 2 + arg_639_0 then
				local var_639_0 = arg_636_1.bgs_.ST01

				arg_636_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_639_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_639_1 = var_639_0:GetComponent("SpriteRenderer")

				if var_639_1 and var_639_1.sprite then
					local var_639_2 = 2 * (var_639_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_639_0.transform.localScale = Vector3.New(var_639_2 / var_639_1.sprite.bounds.size.y < var_639_2 * manager.ui.mainCameraCom_.aspect / var_639_1.sprite.bounds.size.x and var_639_2 * manager.ui.mainCameraCom_.aspect / var_639_1.sprite.bounds.size.x or var_639_2 / var_639_1.sprite.bounds.size.y, var_639_2 / var_639_1.sprite.bounds.size.y < var_639_2 * manager.ui.mainCameraCom_.aspect / var_639_1.sprite.bounds.size.x and var_639_2 * manager.ui.mainCameraCom_.aspect / var_639_1.sprite.bounds.size.x or var_639_2 / var_639_1.sprite.bounds.size.y, 0)
				end

				for iter_639_0, iter_639_1 in pairs(arg_636_1.bgs_) do
					if iter_639_0 ~= "ST01" then
						iter_639_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_639_3 = 0

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_3 + arg_639_0 then
				arg_636_1.mask_.enabled = true
				arg_636_1.mask_.raycastTarget = true

				arg_636_1:SetGaussion(false)
			end

			local var_639_4 = 2

			if var_639_3 <= arg_636_1.time_ and arg_636_1.time_ < var_639_3 + var_639_4 then
				local var_639_5 = Color.New(0, 0, 0)

				var_639_5.a = Mathf.Lerp(0, 1, (arg_636_1.time_ - var_639_3) / var_639_4)
				arg_636_1.mask_.color = var_639_5
			end

			if arg_636_1.time_ >= var_639_3 + var_639_4 and arg_636_1.time_ < var_639_3 + var_639_4 + arg_639_0 then
				local var_639_6 = Color.New(0, 0, 0)

				var_639_6.a = 1
				arg_636_1.mask_.color = var_639_6
			end

			local var_639_7 = 2

			if 2 < arg_636_1.time_ and arg_636_1.time_ <= var_639_7 + arg_639_0 then
				arg_636_1.mask_.enabled = true
				arg_636_1.mask_.raycastTarget = true

				arg_636_1:SetGaussion(false)
			end

			local var_639_8 = 2

			if var_639_7 <= arg_636_1.time_ and arg_636_1.time_ < var_639_7 + var_639_8 then
				local var_639_9 = Color.New(0, 0, 0)

				var_639_9.a = Mathf.Lerp(1, 0, (arg_636_1.time_ - var_639_7) / var_639_8)
				arg_636_1.mask_.color = var_639_9
			end

			if arg_636_1.time_ >= var_639_7 + var_639_8 and arg_636_1.time_ < var_639_7 + var_639_8 + arg_639_0 then
				local var_639_10 = Color.New(0, 0, 0)

				arg_636_1.mask_.enabled = false
				var_639_10.a = 0
				arg_636_1.mask_.color = var_639_10
			end

			local var_639_11 = "1039ui_story"

			if arg_636_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_639_12 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_636_1.stage_.transform)

				var_639_12.name = var_639_11
				var_639_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_636_1.actors_[var_639_11] = var_639_12

				local var_639_13 = var_639_12:GetComponentInChildren(typeof(CharacterEffect))

				var_639_13.enabled = true

				local var_639_14 = GameObjectTools.GetOrAddComponent(var_639_12, typeof(DynamicBoneHelper))

				if var_639_14 then
					var_639_14:EnableDynamicBone(false)
				end

				arg_636_1:ShowWeapon(var_639_13.transform, false)

				arg_636_1.var_[var_639_11 .. "Animator"] = var_639_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_636_1.var_[var_639_11 .. "Animator"].applyRootMotion = true
				arg_636_1.var_[var_639_11 .. "LipSync"] = var_639_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_639_15 = arg_636_1.actors_["1039ui_story"].transform

			if 4 < arg_636_1.time_ and arg_636_1.time_ <= 4 + arg_639_0 then
				arg_636_1.var_.moveOldPos1039ui_story = var_639_15.localPosition
			end

			local var_639_16 = 0.001

			if 4 <= arg_636_1.time_ and arg_636_1.time_ < 4 + var_639_16 then
				var_639_15.localPosition = Vector3.Lerp(arg_636_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_636_1.time_ - 4) / var_639_16)
				var_639_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_639_15.position).x, (manager.ui.mainCamera.transform.position - var_639_15.position).y, (manager.ui.mainCamera.transform.position - var_639_15.position).z)
				var_639_15.localEulerAngles.z = 0
				var_639_15.localEulerAngles.x = 0
				var_639_15.localEulerAngles = var_639_15.localEulerAngles
			end

			if arg_636_1.time_ >= 4 + var_639_16 and arg_636_1.time_ < 4 + var_639_16 + arg_639_0 then
				var_639_15.localPosition = Vector3.New(0, -1.01, -5.9)
				var_639_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_639_15.position).x, (manager.ui.mainCamera.transform.position - var_639_15.position).y, (manager.ui.mainCamera.transform.position - var_639_15.position).z)
				var_639_15.localEulerAngles.z = 0
				var_639_15.localEulerAngles.x = 0
				var_639_15.localEulerAngles = var_639_15.localEulerAngles
			end

			local var_639_17 = arg_636_1.actors_["1039ui_story"]

			if 4 < arg_636_1.time_ and arg_636_1.time_ <= 4 + arg_639_0 and not isNil(var_639_17) and arg_636_1.var_.characterEffect1039ui_story == nil then
				arg_636_1.var_.characterEffect1039ui_story = var_639_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_18 = 0.200000002980232

			if 4 <= arg_636_1.time_ and arg_636_1.time_ < 4 + var_639_18 and not isNil(var_639_17) then
				if arg_636_1.var_.characterEffect1039ui_story and not isNil(var_639_17) then
					arg_636_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_636_1.time_ >= 4 + var_639_18 and arg_636_1.time_ < 4 + var_639_18 + arg_639_0 and not isNil(var_639_17) and arg_636_1.var_.characterEffect1039ui_story then
				arg_636_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 4 < arg_636_1.time_ and arg_636_1.time_ <= 4 + arg_639_0 then
				arg_636_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action1_1")
			end

			if 4 < arg_636_1.time_ and arg_636_1.time_ <= 4 + arg_639_0 then
				arg_636_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_639_20 = arg_636_1.actors_["1011ui_story"].transform

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 then
				arg_636_1.var_.moveOldPos1011ui_story = var_639_20.localPosition
			end

			local var_639_21 = 0.001

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_21 then
				var_639_20.localPosition = Vector3.Lerp(arg_636_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_636_1.time_ - 0) / var_639_21)
				var_639_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_639_20.position).x, (manager.ui.mainCamera.transform.position - var_639_20.position).y, (manager.ui.mainCamera.transform.position - var_639_20.position).z)
				var_639_20.localEulerAngles.z = 0
				var_639_20.localEulerAngles.x = 0
				var_639_20.localEulerAngles = var_639_20.localEulerAngles
			end

			if arg_636_1.time_ >= 0 + var_639_21 and arg_636_1.time_ < 0 + var_639_21 + arg_639_0 then
				var_639_20.localPosition = Vector3.New(0, 100, 0)
				var_639_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_639_20.position).x, (manager.ui.mainCamera.transform.position - var_639_20.position).y, (manager.ui.mainCamera.transform.position - var_639_20.position).z)
				var_639_20.localEulerAngles.z = 0
				var_639_20.localEulerAngles.x = 0
				var_639_20.localEulerAngles = var_639_20.localEulerAngles
			end

			local var_639_22 = arg_636_1.actors_["1011ui_story"]

			if 0 < arg_636_1.time_ and arg_636_1.time_ <= 0 + arg_639_0 and not isNil(var_639_22) and arg_636_1.var_.characterEffect1011ui_story == nil then
				arg_636_1.var_.characterEffect1011ui_story = var_639_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_23 = 0.200000002980232

			if 0 <= arg_636_1.time_ and arg_636_1.time_ < 0 + var_639_23 and not isNil(var_639_22) then
				if arg_636_1.var_.characterEffect1011ui_story and not isNil(var_639_22) then
					arg_636_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_636_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_636_1.time_ - 0) / var_639_23)
				end
			end

			if arg_636_1.time_ >= 0 + var_639_23 and arg_636_1.time_ < 0 + var_639_23 + arg_639_0 and not isNil(var_639_22) and arg_636_1.var_.characterEffect1011ui_story then
				arg_636_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_636_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if arg_636_1.frameCnt_ <= 1 then
				arg_636_1.dialog_:SetActive(false)
			end

			local var_639_24 = 4
			local var_639_25 = 0.725

			if 4 < arg_636_1.time_ and arg_636_1.time_ <= var_639_24 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0

				arg_636_1.dialog_:SetActive(true)

				arg_636_1.dialogCg_.alpha = 0

				local var_639_26 = LeanTween.value(arg_636_1.dialog_, 0, 1, 0.3)

				var_639_26:setOnUpdate(LuaHelper.FloatAction(function(arg_640_0)
					arg_636_1.dialogCg_.alpha = arg_640_0
				end))
				var_639_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_636_1.dialog_)
					var_639_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_636_1.duration_ = arg_636_1.duration_ + 0.3

				SetActive(arg_636_1.leftNameGo_, true)

				arg_636_1.leftNameTxt_.text = arg_636_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_27 = arg_636_1:GetWordFromCfg(1109403153)
				local var_639_28 = arg_636_1:FormatText(var_639_27.content)

				arg_636_1.text_.text = var_639_28

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_30 = 29 <= 0 and var_639_25 or var_639_25 * (utf8.len(var_639_28) / 29)

				if (29 <= 0 and var_639_25 or var_639_25 * (utf8.len(var_639_28) / 29)) > 0 and var_639_25 < var_639_30 then
					arg_636_1.talkMaxDuration = var_639_30
					var_639_24 = var_639_24 + 0.3

					if var_639_30 + var_639_24 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_30 + var_639_24
					end
				end

				arg_636_1.text_.text = var_639_28
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb") ~= 0 then
					local var_639_31 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb") / 1000

					if var_639_31 + var_639_24 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_31 + var_639_24
					end

					if var_639_27.prefab_name ~= "" and arg_636_1.actors_[var_639_27.prefab_name] ~= nil then
						local var_639_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_27.prefab_name].transform, "story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb")

						arg_636_1:RecordAudio("1109403153", var_639_32)
						arg_636_1:RecordAudio("1109403153", var_639_32)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403153", "story_v_side_new_1109403.awb")
				end

				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_33 = var_639_24 + 0.3
			local var_639_34 = math.max(var_639_25, arg_636_1.talkMaxDuration)

			if var_639_24 + 0.3 <= arg_636_1.time_ and arg_636_1.time_ < var_639_33 + var_639_34 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_33) / var_639_34

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_33 + var_639_34 and arg_636_1.time_ < var_639_33 + var_639_34 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_636_1:InitPlayNodeList()
	end,
	Play1109403154 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1109403154
		arg_642_1.duration_ = 10.6

		local var_642_0 = {
			ja = 10.6,
			ko = 8.133,
			zh = 8.133
		}
		local var_642_1 = manager.audio:GetLocalizationFlag()

		if var_642_0[var_642_1] ~= nil then
			arg_642_1.duration_ = var_642_0[var_642_1]
		end

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1109403155(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1.var_.moveOldPos1039ui_story = arg_642_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_645_0 = 0.001

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_0 then
				arg_642_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_642_1.var_.moveOldPos1039ui_story, Vector3.New(0, -1.01, -5.9), (arg_642_1.time_ - 0) / var_645_0)
				arg_642_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_642_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_642_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_642_1.actors_["1039ui_story"].transform.position).z)
				arg_642_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_642_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_642_1.actors_["1039ui_story"].transform.localEulerAngles = arg_642_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_642_1.time_ >= 0 + var_645_0 and arg_642_1.time_ < 0 + var_645_0 + arg_645_0 then
				arg_642_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.9)
				arg_642_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_642_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_642_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_642_1.actors_["1039ui_story"].transform.position).z)
				arg_642_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_642_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_642_1.actors_["1039ui_story"].transform.localEulerAngles = arg_642_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_645_1 = arg_642_1.actors_["1039ui_story"]

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 and not isNil(var_645_1) and arg_642_1.var_.characterEffect1039ui_story == nil then
				arg_642_1.var_.characterEffect1039ui_story = var_645_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_2 = 0.200000002980232

			if 0 <= arg_642_1.time_ and arg_642_1.time_ < 0 + var_645_2 and not isNil(var_645_1) then
				if arg_642_1.var_.characterEffect1039ui_story and not isNil(var_645_1) then
					arg_642_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_642_1.time_ >= 0 + var_645_2 and arg_642_1.time_ < 0 + var_645_2 + arg_645_0 and not isNil(var_645_1) and arg_642_1.var_.characterEffect1039ui_story then
				arg_642_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= 0 + arg_645_0 then
				arg_642_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_645_4 = 0
			local var_645_5 = 0.925

			if 0 < arg_642_1.time_ and arg_642_1.time_ <= var_645_4 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				arg_642_1.leftNameTxt_.text = arg_642_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, false)
				arg_642_1.callingController_:SetSelectedState("normal")

				local var_645_6 = arg_642_1:GetWordFromCfg(1109403154)
				local var_645_7 = arg_642_1:FormatText(var_645_6.content)

				arg_642_1.text_.text = var_645_7

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_9 = 37 <= 0 and var_645_5 or var_645_5 * (utf8.len(var_645_7) / 37)

				if (37 <= 0 and var_645_5 or var_645_5 * (utf8.len(var_645_7) / 37)) > 0 and var_645_5 < var_645_9 then
					arg_642_1.talkMaxDuration = var_645_9

					if var_645_9 + var_645_4 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_9 + var_645_4
					end
				end

				arg_642_1.text_.text = var_645_7
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb") ~= 0 then
					local var_645_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb") / 1000

					if var_645_10 + var_645_4 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_10 + var_645_4
					end

					if var_645_6.prefab_name ~= "" and arg_642_1.actors_[var_645_6.prefab_name] ~= nil then
						local var_645_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_642_1.actors_[var_645_6.prefab_name].transform, "story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb")

						arg_642_1:RecordAudio("1109403154", var_645_11)
						arg_642_1:RecordAudio("1109403154", var_645_11)
					else
						arg_642_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb")
					end

					arg_642_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403154", "story_v_side_new_1109403.awb")
				end

				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_12 = math.max(var_645_5, arg_642_1.talkMaxDuration)

			if var_645_4 <= arg_642_1.time_ and arg_642_1.time_ < var_645_4 + var_645_12 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_4) / var_645_12

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_4 + var_645_12 and arg_642_1.time_ < var_645_4 + var_645_12 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {
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

		arg_642_1:InitPlayNodeList()
	end,
	Play1109403155 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1109403155
		arg_646_1.duration_ = 9

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1109403156(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			if 2 < arg_646_1.time_ and arg_646_1.time_ <= 2 + arg_649_0 then
				local var_649_0 = arg_646_1.bgs_.B13

				arg_646_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_649_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_649_1 = var_649_0:GetComponent("SpriteRenderer")

				if var_649_1 and var_649_1.sprite then
					local var_649_2 = 2 * (var_649_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_649_0.transform.localScale = Vector3.New(var_649_2 / var_649_1.sprite.bounds.size.y < var_649_2 * manager.ui.mainCameraCom_.aspect / var_649_1.sprite.bounds.size.x and var_649_2 * manager.ui.mainCameraCom_.aspect / var_649_1.sprite.bounds.size.x or var_649_2 / var_649_1.sprite.bounds.size.y, var_649_2 / var_649_1.sprite.bounds.size.y < var_649_2 * manager.ui.mainCameraCom_.aspect / var_649_1.sprite.bounds.size.x and var_649_2 * manager.ui.mainCameraCom_.aspect / var_649_1.sprite.bounds.size.x or var_649_2 / var_649_1.sprite.bounds.size.y, 0)
				end

				for iter_649_0, iter_649_1 in pairs(arg_646_1.bgs_) do
					if iter_649_0 ~= "B13" then
						iter_649_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_649_3 = 0

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= var_649_3 + arg_649_0 then
				arg_646_1.mask_.enabled = true
				arg_646_1.mask_.raycastTarget = true

				arg_646_1:SetGaussion(false)
			end

			local var_649_4 = 2

			if var_649_3 <= arg_646_1.time_ and arg_646_1.time_ < var_649_3 + var_649_4 then
				local var_649_5 = Color.New(0, 0, 0)

				var_649_5.a = Mathf.Lerp(0, 1, (arg_646_1.time_ - var_649_3) / var_649_4)
				arg_646_1.mask_.color = var_649_5
			end

			if arg_646_1.time_ >= var_649_3 + var_649_4 and arg_646_1.time_ < var_649_3 + var_649_4 + arg_649_0 then
				local var_649_6 = Color.New(0, 0, 0)

				var_649_6.a = 1
				arg_646_1.mask_.color = var_649_6
			end

			local var_649_7 = 2

			if 2 < arg_646_1.time_ and arg_646_1.time_ <= var_649_7 + arg_649_0 then
				arg_646_1.mask_.enabled = true
				arg_646_1.mask_.raycastTarget = true

				arg_646_1:SetGaussion(false)
			end

			local var_649_8 = 2

			if var_649_7 <= arg_646_1.time_ and arg_646_1.time_ < var_649_7 + var_649_8 then
				local var_649_9 = Color.New(0, 0, 0)

				var_649_9.a = Mathf.Lerp(1, 0, (arg_646_1.time_ - var_649_7) / var_649_8)
				arg_646_1.mask_.color = var_649_9
			end

			if arg_646_1.time_ >= var_649_7 + var_649_8 and arg_646_1.time_ < var_649_7 + var_649_8 + arg_649_0 then
				local var_649_10 = Color.New(0, 0, 0)

				arg_646_1.mask_.enabled = false
				var_649_10.a = 0
				arg_646_1.mask_.color = var_649_10
			end

			local var_649_11 = arg_646_1.actors_["1039ui_story"].transform

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 then
				arg_646_1.var_.moveOldPos1039ui_story = var_649_11.localPosition
			end

			local var_649_12 = 0.001

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_12 then
				var_649_11.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_646_1.time_ - 0) / var_649_12)
				var_649_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_649_11.position).x, (manager.ui.mainCamera.transform.position - var_649_11.position).y, (manager.ui.mainCamera.transform.position - var_649_11.position).z)
				var_649_11.localEulerAngles.z = 0
				var_649_11.localEulerAngles.x = 0
				var_649_11.localEulerAngles = var_649_11.localEulerAngles
			end

			if arg_646_1.time_ >= 0 + var_649_12 and arg_646_1.time_ < 0 + var_649_12 + arg_649_0 then
				var_649_11.localPosition = Vector3.New(0, 100, 0)
				var_649_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_649_11.position).x, (manager.ui.mainCamera.transform.position - var_649_11.position).y, (manager.ui.mainCamera.transform.position - var_649_11.position).z)
				var_649_11.localEulerAngles.z = 0
				var_649_11.localEulerAngles.x = 0
				var_649_11.localEulerAngles = var_649_11.localEulerAngles
			end

			local var_649_13 = arg_646_1.actors_["1039ui_story"]

			if 0 < arg_646_1.time_ and arg_646_1.time_ <= 0 + arg_649_0 and not isNil(var_649_13) and arg_646_1.var_.characterEffect1039ui_story == nil then
				arg_646_1.var_.characterEffect1039ui_story = var_649_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_14 = 0.200000002980232

			if 0 <= arg_646_1.time_ and arg_646_1.time_ < 0 + var_649_14 and not isNil(var_649_13) then
				if arg_646_1.var_.characterEffect1039ui_story and not isNil(var_649_13) then
					arg_646_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_646_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_646_1.time_ - 0) / var_649_14)
				end
			end

			if arg_646_1.time_ >= 0 + var_649_14 and arg_646_1.time_ < 0 + var_649_14 + arg_649_0 and not isNil(var_649_13) and arg_646_1.var_.characterEffect1039ui_story then
				arg_646_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_646_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_649_15 = arg_646_1.actors_["1094ui_story"].transform

			if 4 < arg_646_1.time_ and arg_646_1.time_ <= 4 + arg_649_0 then
				arg_646_1.var_.moveOldPos1094ui_story = var_649_15.localPosition
			end

			local var_649_16 = 0.001

			if 4 <= arg_646_1.time_ and arg_646_1.time_ < 4 + var_649_16 then
				var_649_15.localPosition = Vector3.Lerp(arg_646_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_646_1.time_ - 4) / var_649_16)
				var_649_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_649_15.position).x, (manager.ui.mainCamera.transform.position - var_649_15.position).y, (manager.ui.mainCamera.transform.position - var_649_15.position).z)
				var_649_15.localEulerAngles.z = 0
				var_649_15.localEulerAngles.x = 0
				var_649_15.localEulerAngles = var_649_15.localEulerAngles
			end

			if arg_646_1.time_ >= 4 + var_649_16 and arg_646_1.time_ < 4 + var_649_16 + arg_649_0 then
				var_649_15.localPosition = Vector3.New(0, -0.84, -6.1)
				var_649_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_649_15.position).x, (manager.ui.mainCamera.transform.position - var_649_15.position).y, (manager.ui.mainCamera.transform.position - var_649_15.position).z)
				var_649_15.localEulerAngles.z = 0
				var_649_15.localEulerAngles.x = 0
				var_649_15.localEulerAngles = var_649_15.localEulerAngles
			end

			local var_649_17 = arg_646_1.actors_["1094ui_story"]

			if 4 < arg_646_1.time_ and arg_646_1.time_ <= 4 + arg_649_0 and not isNil(var_649_17) and arg_646_1.var_.characterEffect1094ui_story == nil then
				arg_646_1.var_.characterEffect1094ui_story = var_649_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_18 = 0.0166666666666667

			if 4 <= arg_646_1.time_ and arg_646_1.time_ < 4 + var_649_18 and not isNil(var_649_17) then
				if arg_646_1.var_.characterEffect1094ui_story and not isNil(var_649_17) then
					arg_646_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_646_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_646_1.time_ - 4) / var_649_18)
				end
			end

			if arg_646_1.time_ >= 4 + var_649_18 and arg_646_1.time_ < 4 + var_649_18 + arg_649_0 and not isNil(var_649_17) and arg_646_1.var_.characterEffect1094ui_story then
				arg_646_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_646_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			if 4 < arg_646_1.time_ and arg_646_1.time_ <= 4 + arg_649_0 then
				arg_646_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if arg_646_1.frameCnt_ <= 1 then
				arg_646_1.dialog_:SetActive(false)
			end

			local var_649_19 = 4
			local var_649_20 = 0.375

			if 4 < arg_646_1.time_ and arg_646_1.time_ <= var_649_19 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0

				arg_646_1.dialog_:SetActive(true)

				arg_646_1.dialogCg_.alpha = 0

				local var_649_21 = LeanTween.value(arg_646_1.dialog_, 0, 1, 0.3)

				var_649_21:setOnUpdate(LuaHelper.FloatAction(function(arg_650_0)
					arg_646_1.dialogCg_.alpha = arg_650_0
				end))
				var_649_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_646_1.dialog_)
					var_649_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_646_1.duration_ = arg_646_1.duration_ + 0.3

				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_22 = arg_646_1:FormatText(arg_646_1:GetWordFromCfg(1109403155).content)

				arg_646_1.text_.text = var_649_22

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_24 = 15 <= 0 and var_649_20 or var_649_20 * (utf8.len(var_649_22) / 15)

				if (15 <= 0 and var_649_20 or var_649_20 * (utf8.len(var_649_22) / 15)) > 0 and var_649_20 < var_649_24 then
					arg_646_1.talkMaxDuration = var_649_24
					var_649_19 = var_649_19 + 0.3

					if var_649_24 + var_649_19 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_24 + var_649_19
					end
				end

				arg_646_1.text_.text = var_649_22
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_25 = var_649_19 + 0.3
			local var_649_26 = math.max(var_649_20, arg_646_1.talkMaxDuration)

			if var_649_19 + 0.3 <= arg_646_1.time_ and arg_646_1.time_ < var_649_25 + var_649_26 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_25) / var_649_26

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_25 + var_649_26 and arg_646_1.time_ < var_649_25 + var_649_26 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {
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
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_646_1:InitPlayNodeList()
	end,
	Play1109403156 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1109403156
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1109403157(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			if 0 < arg_652_1.time_ and arg_652_1.time_ <= 0 + arg_655_0 then
				arg_652_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_cat", "")
			end

			local var_655_1 = 0
			local var_655_2 = 0.1

			if 0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_1 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, true)

				arg_652_1.leftNameTxt_.text = arg_652_1:FormatText(StoryNameCfg[197].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_652_1.leftNameTxt_.transform)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1.leftNameTxt_.text)
				SetActive(arg_652_1.iconTrs_.gameObject, true)
				arg_652_1.iconController_:SetSelectedState("hero")

				arg_652_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_catb")

				arg_652_1.callingController_:SetSelectedState("normal")

				arg_652_1.keyicon_.color = Color.New(1, 1, 1)
				arg_652_1.icon_.color = Color.New(1, 1, 1)

				local var_655_3 = arg_652_1:FormatText(arg_652_1:GetWordFromCfg(1109403156).content)

				arg_652_1.text_.text = var_655_3

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_5 = 4 <= 0 and var_655_2 or var_655_2 * (utf8.len(var_655_3) / 4)

				if (4 <= 0 and var_655_2 or var_655_2 * (utf8.len(var_655_3) / 4)) > 0 and var_655_2 < var_655_5 then
					arg_652_1.talkMaxDuration = var_655_5

					if var_655_5 + var_655_1 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_5 + var_655_1
					end
				end

				arg_652_1.text_.text = var_655_3
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_6 = math.max(var_655_2, arg_652_1.talkMaxDuration)

			if var_655_1 <= arg_652_1.time_ and arg_652_1.time_ < var_655_1 + var_655_6 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_1) / var_655_6

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_1 + var_655_6 and arg_652_1.time_ < var_655_1 + var_655_6 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play1109403157 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1109403157
		arg_656_1.duration_ = 4.9

		local var_656_0 = {
			ja = 3.966,
			ko = 4.9,
			zh = 4.9
		}
		local var_656_1 = manager.audio:GetLocalizationFlag()

		if var_656_0[var_656_1] ~= nil then
			arg_656_1.duration_ = var_656_0[var_656_1]
		end

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1109403158(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1.var_.moveOldPos1094ui_story = arg_656_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_659_0 = 0.001

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_0 then
				arg_656_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_656_1.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (arg_656_1.time_ - 0) / var_659_0)
				arg_656_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_656_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_656_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_656_1.actors_["1094ui_story"].transform.position).z)
				arg_656_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_656_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_656_1.actors_["1094ui_story"].transform.localEulerAngles = arg_656_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_656_1.time_ >= 0 + var_659_0 and arg_656_1.time_ < 0 + var_659_0 + arg_659_0 then
				arg_656_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0, -0.84, -6.1)
				arg_656_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_656_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_656_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_656_1.actors_["1094ui_story"].transform.position).z)
				arg_656_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_656_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_656_1.actors_["1094ui_story"].transform.localEulerAngles = arg_656_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_659_1 = arg_656_1.actors_["1094ui_story"]

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 and not isNil(var_659_1) and arg_656_1.var_.characterEffect1094ui_story == nil then
				arg_656_1.var_.characterEffect1094ui_story = var_659_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_2 = 0.200000002980232

			if 0 <= arg_656_1.time_ and arg_656_1.time_ < 0 + var_659_2 and not isNil(var_659_1) then
				if arg_656_1.var_.characterEffect1094ui_story and not isNil(var_659_1) then
					arg_656_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_656_1.time_ >= 0 + var_659_2 and arg_656_1.time_ < 0 + var_659_2 + arg_659_0 and not isNil(var_659_1) and arg_656_1.var_.characterEffect1094ui_story then
				arg_656_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= 0 + arg_659_0 then
				arg_656_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_659_4 = 0
			local var_659_5 = 0.175

			if 0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_4 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				arg_656_1.leftNameTxt_.text = arg_656_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_6 = arg_656_1:GetWordFromCfg(1109403157)
				local var_659_7 = arg_656_1:FormatText(var_659_6.content)

				arg_656_1.text_.text = var_659_7

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_9 = 7 <= 0 and var_659_5 or var_659_5 * (utf8.len(var_659_7) / 7)

				if (7 <= 0 and var_659_5 or var_659_5 * (utf8.len(var_659_7) / 7)) > 0 and var_659_5 < var_659_9 then
					arg_656_1.talkMaxDuration = var_659_9

					if var_659_9 + var_659_4 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_9 + var_659_4
					end
				end

				arg_656_1.text_.text = var_659_7
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb") ~= 0 then
					local var_659_10 = manager.audio:GetVoiceLength("story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb") / 1000

					if var_659_10 + var_659_4 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_10 + var_659_4
					end

					if var_659_6.prefab_name ~= "" and arg_656_1.actors_[var_659_6.prefab_name] ~= nil then
						local var_659_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_6.prefab_name].transform, "story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb")

						arg_656_1:RecordAudio("1109403157", var_659_11)
						arg_656_1:RecordAudio("1109403157", var_659_11)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1109403", "1109403157", "story_v_side_new_1109403.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_12 = math.max(var_659_5, arg_656_1.talkMaxDuration)

			if var_659_4 <= arg_656_1.time_ and arg_656_1.time_ < var_659_4 + var_659_12 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_4) / var_659_12

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_4 + var_659_12 and arg_656_1.time_ < var_659_4 + var_659_12 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_656_1:InitPlayNodeList()
	end,
	Play1109403158 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1109403158
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
			arg_660_1.auto_ = false
		end

		function arg_660_1.playNext_(arg_662_0)
			arg_660_1.onStoryFinished_()
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0.675

			if 0 < arg_660_1.time_ and arg_660_1.time_ <= 0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, false)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_1 = arg_660_1:FormatText(arg_660_1:GetWordFromCfg(1109403158).content)

				arg_660_1.text_.text = var_663_1

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_3 = 27 <= 0 and var_663_0 or var_663_0 * (utf8.len(var_663_1) / 27)

				if (27 <= 0 and var_663_0 or var_663_0 * (utf8.len(var_663_1) / 27)) > 0 and var_663_0 < var_663_3 then
					arg_660_1.talkMaxDuration = var_663_3

					if var_663_3 + 0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_3 + 0
					end
				end

				arg_660_1.text_.text = var_663_1
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_4 = math.max(var_663_0, arg_660_1.talkMaxDuration)

			if 0 <= arg_660_1.time_ and arg_660_1.time_ < 0 + var_663_4 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - 0) / var_663_4

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= 0 + var_663_4 and arg_660_1.time_ < 0 + var_663_4 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST08",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST10"
	},
	voices = {
		"story_v_side_new_1109403.awb"
	}
}
