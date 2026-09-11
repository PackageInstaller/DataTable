return {
	Play123112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 123112001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play123112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K06g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K06g")
				var_4_0.name = "K06g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K06g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K06g

				arg_1_1.bgs_.K06g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K06g" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_2_4_battle_xiajingqu", "bgm_activity_2_4_battle_xiajingqu")

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
			local var_4_15 = 0.95

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(123112001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 38 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 38)

				if (38 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 38)) > 0 and var_4_15 < var_4_19 then
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
	Play123112002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 123112002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play123112003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1055ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1055ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1055ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1055ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1055ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1055ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1055ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1055ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1055ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1055ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.965, -6.2)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1055ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1055ui_story == nil then
				arg_9_1.var_.characterEffect1055ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1055ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1055ui_story then
				arg_9_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(123112002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 3 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 3)

				if (3 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 3)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112002", "story_v_out_123112.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112002", "story_v_out_123112.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_123112", "123112002", "story_v_out_123112.awb")

						arg_9_1:RecordAudio("123112002", var_12_15)
						arg_9_1:RecordAudio("123112002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_123112", "123112002", "story_v_out_123112.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_123112", "123112002", "story_v_out_123112.awb")
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
				actorName = "1055ui_story",
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
	Play123112003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 123112003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play123112004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1055ui_story"]) and arg_13_1.var_.characterEffect1055ui_story == nil then
				arg_13_1.var_.characterEffect1055ui_story = arg_13_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1055ui_story"]) then
				if arg_13_1.var_.characterEffect1055ui_story and not isNil(arg_13_1.actors_["1055ui_story"]) then
					arg_13_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1055ui_story"]) and arg_13_1.var_.characterEffect1055ui_story then
				arg_13_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(123112003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 20 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 20)

				if (20 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 20)) > 0 and var_16_2 < var_16_5 then
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
	Play123112004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 123112004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play123112005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1055ui_story"]) and arg_17_1.var_.characterEffect1055ui_story == nil then
				arg_17_1.var_.characterEffect1055ui_story = arg_17_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1055ui_story"]) then
				if arg_17_1.var_.characterEffect1055ui_story and not isNil(arg_17_1.actors_["1055ui_story"]) then
					arg_17_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1055ui_story"]) and arg_17_1.var_.characterEffect1055ui_story then
				arg_17_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_20_2 = 0
			local var_20_3 = 0.075

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(123112004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 3 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 3)

				if (3 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 3)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112004", "story_v_out_123112.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112004", "story_v_out_123112.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_123112", "123112004", "story_v_out_123112.awb")

						arg_17_1:RecordAudio("123112004", var_20_9)
						arg_17_1:RecordAudio("123112004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_123112", "123112004", "story_v_out_123112.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_123112", "123112004", "story_v_out_123112.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play123112005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 123112005
		arg_21_1.duration_ = 7.3

		local var_21_0 = {
			zh = 7.3,
			ja = 5.8
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
				arg_21_0:Play123112006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1093ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1093ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1093ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1093ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1093ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1093ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1093ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_24_8 = arg_21_1.actors_["1055ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1055ui_story == nil then
				arg_21_1.var_.characterEffect1055ui_story = var_24_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_9 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 and not isNil(var_24_8) then
				if arg_21_1.var_.characterEffect1055ui_story and not isNil(var_24_8) then
					arg_21_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_9)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.characterEffect1055ui_story then
				arg_21_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_24_10 = arg_21_1.actors_["1055ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1055ui_story = var_24_10.localPosition
			end

			local var_24_11 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_11 then
				var_24_10.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_11)
				var_24_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_10.position).x, (manager.ui.mainCamera.transform.position - var_24_10.position).y, (manager.ui.mainCamera.transform.position - var_24_10.position).z)
				var_24_10.localEulerAngles.z = 0
				var_24_10.localEulerAngles.x = 0
				var_24_10.localEulerAngles = var_24_10.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_11 and arg_21_1.time_ < 0 + var_24_11 + arg_24_0 then
				var_24_10.localPosition = Vector3.New(0, 100, 0)
				var_24_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_10.position).x, (manager.ui.mainCamera.transform.position - var_24_10.position).y, (manager.ui.mainCamera.transform.position - var_24_10.position).z)
				var_24_10.localEulerAngles.z = 0
				var_24_10.localEulerAngles.x = 0
				var_24_10.localEulerAngles = var_24_10.localEulerAngles
			end

			local var_24_12 = 0
			local var_24_13 = 0.675

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(123112005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 27 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 27)

				if (27 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 27)) > 0 and var_24_13 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112005", "story_v_out_123112.awb") ~= 0 then
					local var_24_18 = manager.audio:GetVoiceLength("story_v_out_123112", "123112005", "story_v_out_123112.awb") / 1000

					if var_24_18 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_12
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_123112", "123112005", "story_v_out_123112.awb")

						arg_21_1:RecordAudio("123112005", var_24_19)
						arg_21_1:RecordAudio("123112005", var_24_19)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_123112", "123112005", "story_v_out_123112.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_123112", "123112005", "story_v_out_123112.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_20 and arg_21_1.time_ < var_24_12 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
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
	Play123112006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 123112006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play123112007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1055ui_story = arg_25_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1055ui_story"].transform.position).z)
				arg_25_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1055ui_story"].transform.localEulerAngles = arg_25_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1055ui_story"].transform.position).z)
				arg_25_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1055ui_story"].transform.localEulerAngles = arg_25_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1055ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1055ui_story == nil then
				arg_25_1.var_.characterEffect1055ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1055ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_2)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1055ui_story then
				arg_25_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_28_3 = arg_25_1.actors_["1093ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1093ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0, 100, 0)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["1093ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1093ui_story == nil then
				arg_25_1.var_.characterEffect1093ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect1093ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_6)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect1093ui_story then
				arg_25_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_28_7 = 0
			local var_28_8 = 1.35

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(123112006).content)

				arg_25_1.text_.text = var_28_9

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 54 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_9) / 54)

				if (54 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_9) / 54)) > 0 and var_28_8 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_9
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_12 and arg_25_1.time_ < var_28_7 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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

		arg_25_1:InitPlayNodeList()
	end,
	Play123112007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 123112007
		arg_29_1.duration_ = 3.37

		local var_29_0 = {
			zh = 3.366,
			ja = 2.8
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
				arg_29_0:Play123112008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.225

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[499].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(123112007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 9 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 9)

				if (9 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 9)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112007", "story_v_out_123112.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_123112", "123112007", "story_v_out_123112.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_123112", "123112007", "story_v_out_123112.awb")

						arg_29_1:RecordAudio("123112007", var_32_6)
						arg_29_1:RecordAudio("123112007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_123112", "123112007", "story_v_out_123112.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_123112", "123112007", "story_v_out_123112.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play123112008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 123112008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play123112009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.15

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(123112008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 46 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 46)

				if (46 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 46)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play123112009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 123112009
		arg_37_1.duration_ = 4.6

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 4.6
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
				arg_37_0:Play123112010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1055ui_story = arg_37_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1055ui_story"].transform.position).z)
				arg_37_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1055ui_story"].transform.localEulerAngles = arg_37_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_37_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1055ui_story"].transform.position).z)
				arg_37_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1055ui_story"].transform.localEulerAngles = arg_37_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1055ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1055ui_story == nil then
				arg_37_1.var_.characterEffect1055ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1055ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1055ui_story then
				arg_37_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_40_4 = 0
			local var_40_5 = 0.1

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(123112009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 4 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 4)

				if (4 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 4)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112009", "story_v_out_123112.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112009", "story_v_out_123112.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_123112", "123112009", "story_v_out_123112.awb")

						arg_37_1:RecordAudio("123112009", var_40_11)
						arg_37_1:RecordAudio("123112009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_123112", "123112009", "story_v_out_123112.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_123112", "123112009", "story_v_out_123112.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123112010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 123112010
		arg_41_1.duration_ = 10.73

		local var_41_0 = {
			zh = 10.733,
			ja = 9.6
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
				arg_41_0:Play123112011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1055ui_story"]) and arg_41_1.var_.characterEffect1055ui_story == nil then
				arg_41_1.var_.characterEffect1055ui_story = arg_41_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1055ui_story"]) then
				if arg_41_1.var_.characterEffect1055ui_story and not isNil(arg_41_1.actors_["1055ui_story"]) then
					arg_41_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1055ui_story"]) and arg_41_1.var_.characterEffect1055ui_story then
				arg_41_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 1.15

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[499].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(123112010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 46 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 46)

				if (46 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_4) / 46)) > 0 and var_44_2 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6

					if var_44_6 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112010", "story_v_out_123112.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_out_123112", "123112010", "story_v_out_123112.awb") / 1000

					if var_44_7 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_1
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_123112", "123112010", "story_v_out_123112.awb")

						arg_41_1:RecordAudio("123112010", var_44_8)
						arg_41_1:RecordAudio("123112010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_123112", "123112010", "story_v_out_123112.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_123112", "123112010", "story_v_out_123112.awb")
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
	Play123112011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 123112011
		arg_45_1.duration_ = 6.03

		local var_45_0 = {
			zh = 6.033,
			ja = 4.733
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
				arg_45_0:Play123112012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1093ui_story = arg_45_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).z)
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles = arg_45_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_45_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1093ui_story"].transform.position).z)
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1093ui_story"].transform.localEulerAngles = arg_45_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1093ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1093ui_story == nil then
				arg_45_1.var_.characterEffect1093ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1093ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1093ui_story then
				arg_45_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_48_4 = arg_45_1.actors_["1055ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1055ui_story = var_48_4.localPosition
			end

			local var_48_5 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 then
				var_48_4.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_45_1.time_ - 0) / var_48_5)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 then
				var_48_4.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				var_48_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_4.position).x, (manager.ui.mainCamera.transform.position - var_48_4.position).y, (manager.ui.mainCamera.transform.position - var_48_4.position).z)
				var_48_4.localEulerAngles.z = 0
				var_48_4.localEulerAngles.x = 0
				var_48_4.localEulerAngles = var_48_4.localEulerAngles
			end

			local var_48_6 = 0
			local var_48_7 = 0.475

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(123112011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 19 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 19)

				if (19 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 19)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112011", "story_v_out_123112.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_123112", "123112011", "story_v_out_123112.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_123112", "123112011", "story_v_out_123112.awb")

						arg_45_1:RecordAudio("123112011", var_48_13)
						arg_45_1:RecordAudio("123112011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_123112", "123112011", "story_v_out_123112.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_123112", "123112011", "story_v_out_123112.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
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
	Play123112012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 123112012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play123112013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) and arg_49_1.var_.characterEffect1093ui_story == nil then
				arg_49_1.var_.characterEffect1093ui_story = arg_49_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) then
				if arg_49_1.var_.characterEffect1093ui_story and not isNil(arg_49_1.actors_["1093ui_story"]) then
					arg_49_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1093ui_story"]) and arg_49_1.var_.characterEffect1093ui_story then
				arg_49_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.9

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

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(123112012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 36 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 36)

				if (36 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 36)) > 0 and var_52_2 < var_52_5 then
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
	Play123112013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 123112013
		arg_53_1.duration_ = 5.97

		local var_53_0 = {
			zh = 1.999999999999,
			ja = 5.966
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
				arg_53_0:Play123112014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1055ui_story"]) and arg_53_1.var_.characterEffect1055ui_story == nil then
				arg_53_1.var_.characterEffect1055ui_story = arg_53_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1055ui_story"]) then
				if arg_53_1.var_.characterEffect1055ui_story and not isNil(arg_53_1.actors_["1055ui_story"]) then
					arg_53_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1055ui_story"]) and arg_53_1.var_.characterEffect1055ui_story then
				arg_53_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_2 = 0
			local var_56_3 = 0.2

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(123112013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 8 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 8)

				if (8 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 8)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112013", "story_v_out_123112.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112013", "story_v_out_123112.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_123112", "123112013", "story_v_out_123112.awb")

						arg_53_1:RecordAudio("123112013", var_56_9)
						arg_53_1:RecordAudio("123112013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_123112", "123112013", "story_v_out_123112.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_123112", "123112013", "story_v_out_123112.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play123112014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 123112014
		arg_57_1.duration_ = 2.03

		local var_57_0 = {
			zh = 1.666,
			ja = 2.033
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
				arg_57_0:Play123112015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1055ui_story"]) and arg_57_1.var_.characterEffect1055ui_story == nil then
				arg_57_1.var_.characterEffect1055ui_story = arg_57_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1055ui_story"]) then
				if arg_57_1.var_.characterEffect1055ui_story and not isNil(arg_57_1.actors_["1055ui_story"]) then
					arg_57_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1055ui_story"]) and arg_57_1.var_.characterEffect1055ui_story then
				arg_57_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[499].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(123112014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 5 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_4) / 5)

				if (5 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_4) / 5)) > 0 and var_60_2 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112014", "story_v_out_123112.awb") ~= 0 then
					local var_60_7 = manager.audio:GetVoiceLength("story_v_out_123112", "123112014", "story_v_out_123112.awb") / 1000

					if var_60_7 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_1
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_123112", "123112014", "story_v_out_123112.awb")

						arg_57_1:RecordAudio("123112014", var_60_8)
						arg_57_1:RecordAudio("123112014", var_60_8)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_123112", "123112014", "story_v_out_123112.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_123112", "123112014", "story_v_out_123112.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_9 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_9 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_9

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_9 and arg_57_1.time_ < var_60_1 + var_60_9 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play123112015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 123112015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play123112016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.075

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

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(123112015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 43 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 43)

				if (43 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 43)) > 0 and var_64_0 < var_64_3 then
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
	Play123112016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 123112016
		arg_65_1.duration_ = 5.2

		local var_65_0 = {
			zh = 2.166,
			ja = 5.2
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
				arg_65_0:Play123112017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1055ui_story = arg_65_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1055ui_story"].transform.position).z)
				arg_65_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1055ui_story"].transform.localEulerAngles = arg_65_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				arg_65_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1055ui_story"].transform.position).z)
				arg_65_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1055ui_story"].transform.localEulerAngles = arg_65_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1055ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1055ui_story == nil then
				arg_65_1.var_.characterEffect1055ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1055ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1055ui_story then
				arg_65_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(123112016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 12 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 12)

				if (12 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 12)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112016", "story_v_out_123112.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112016", "story_v_out_123112.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_123112", "123112016", "story_v_out_123112.awb")

						arg_65_1:RecordAudio("123112016", var_68_11)
						arg_65_1:RecordAudio("123112016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_123112", "123112016", "story_v_out_123112.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_123112", "123112016", "story_v_out_123112.awb")
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
				actorName = "1055ui_story",
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
	Play123112017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 123112017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play123112018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1055ui_story"]) and arg_69_1.var_.characterEffect1055ui_story == nil then
				arg_69_1.var_.characterEffect1055ui_story = arg_69_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1055ui_story"]) then
				if arg_69_1.var_.characterEffect1055ui_story and not isNil(arg_69_1.actors_["1055ui_story"]) then
					arg_69_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1055ui_story"]) and arg_69_1.var_.characterEffect1055ui_story then
				arg_69_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 1.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(123112017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 50 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 50)

				if (50 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 50)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play123112018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 123112018
		arg_73_1.duration_ = 5.9

		local var_73_0 = {
			zh = 5.9,
			ja = 4.366
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
				arg_73_0:Play123112019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.2

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[500].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(123112018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 8 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 8)

				if (8 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 8)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112018", "story_v_out_123112.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_123112", "123112018", "story_v_out_123112.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_123112", "123112018", "story_v_out_123112.awb")

						arg_73_1:RecordAudio("123112018", var_76_6)
						arg_73_1:RecordAudio("123112018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_123112", "123112018", "story_v_out_123112.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_123112", "123112018", "story_v_out_123112.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play123112019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 123112019
		arg_77_1.duration_ = 2.23

		local var_77_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_77_0:Play123112020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1093ui_story = arg_77_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).z)
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles = arg_77_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_77_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1093ui_story"].transform.position).z)
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1093ui_story"].transform.localEulerAngles = arg_77_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1093ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1093ui_story == nil then
				arg_77_1.var_.characterEffect1093ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1093ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1093ui_story then
				arg_77_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action465")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(123112019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 4 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 4)

				if (4 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 4)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112019", "story_v_out_123112.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112019", "story_v_out_123112.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_123112", "123112019", "story_v_out_123112.awb")

						arg_77_1:RecordAudio("123112019", var_80_11)
						arg_77_1:RecordAudio("123112019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_123112", "123112019", "story_v_out_123112.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_123112", "123112019", "story_v_out_123112.awb")
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

		arg_77_1.nodeConfigList_ = {
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

		arg_77_1:InitPlayNodeList()
	end,
	Play123112020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 123112020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play123112021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) and arg_81_1.var_.characterEffect1093ui_story == nil then
				arg_81_1.var_.characterEffect1093ui_story = arg_81_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) then
				if arg_81_1.var_.characterEffect1093ui_story and not isNil(arg_81_1.actors_["1093ui_story"]) then
					arg_81_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1093ui_story"]) and arg_81_1.var_.characterEffect1093ui_story then
				arg_81_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.45

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(123112020).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 18 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 18)

				if (18 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 18)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play123112021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 123112021
		arg_85_1.duration_ = 7.43

		local var_85_0 = {
			zh = 6.8,
			ja = 7.433
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
				arg_85_0:Play123112022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1055ui_story = arg_85_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1055ui_story"].transform.position).z)
				arg_85_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1055ui_story"].transform.localEulerAngles = arg_85_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				arg_85_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1055ui_story"].transform.position).z)
				arg_85_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1055ui_story"].transform.localEulerAngles = arg_85_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1055ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1055ui_story == nil then
				arg_85_1.var_.characterEffect1055ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1055ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1055ui_story then
				arg_85_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action5_2")
			end

			local var_88_4 = 0
			local var_88_5 = 0.65

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(123112021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 26 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 26)

				if (26 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 26)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112021", "story_v_out_123112.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112021", "story_v_out_123112.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_123112", "123112021", "story_v_out_123112.awb")

						arg_85_1:RecordAudio("123112021", var_88_11)
						arg_85_1:RecordAudio("123112021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_123112", "123112021", "story_v_out_123112.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_123112", "123112021", "story_v_out_123112.awb")
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play123112022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 123112022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play123112023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1055ui_story"]) and arg_89_1.var_.characterEffect1055ui_story == nil then
				arg_89_1.var_.characterEffect1055ui_story = arg_89_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1055ui_story"]) then
				if arg_89_1.var_.characterEffect1055ui_story and not isNil(arg_89_1.actors_["1055ui_story"]) then
					arg_89_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1055ui_story"]) and arg_89_1.var_.characterEffect1055ui_story then
				arg_89_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.725

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(123112022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 29 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 29)

				if (29 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 29)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play123112023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 123112023
		arg_93_1.duration_ = 3.33

		local var_93_0 = {
			zh = 3.333,
			ja = 2.5
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
				arg_93_0:Play123112024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1093ui_story = arg_93_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).z)
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles = arg_93_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1093ui_story"].transform.position).z)
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1093ui_story"].transform.localEulerAngles = arg_93_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1093ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1093ui_story == nil then
				arg_93_1.var_.characterEffect1093ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1093ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_2)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1093ui_story then
				arg_93_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_96_3 = arg_93_1.actors_["1055ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1055ui_story = var_96_3.localPosition
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_3.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_93_1.time_ - 0) / var_96_4)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_3.localPosition = Vector3.New(0, -0.965, -6.2)
				var_96_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_3.position).x, (manager.ui.mainCamera.transform.position - var_96_3.position).y, (manager.ui.mainCamera.transform.position - var_96_3.position).z)
				var_96_3.localEulerAngles.z = 0
				var_96_3.localEulerAngles.x = 0
				var_96_3.localEulerAngles = var_96_3.localEulerAngles
			end

			local var_96_5 = arg_93_1.actors_["1055ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1055ui_story == nil then
				arg_93_1.var_.characterEffect1055ui_story = var_96_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.characterEffect1055ui_story and not isNil(var_96_5) then
					arg_93_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_6)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.characterEffect1055ui_story then
				arg_93_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_96_7 = 0
			local var_96_8 = 0.325

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[500].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_9 = arg_93_1:GetWordFromCfg(123112023)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_12 = 13 <= 0 and var_96_8 or var_96_8 * (utf8.len(var_96_10) / 13)

				if (13 <= 0 and var_96_8 or var_96_8 * (utf8.len(var_96_10) / 13)) > 0 and var_96_8 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_7 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_7
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112023", "story_v_out_123112.awb") ~= 0 then
					local var_96_13 = manager.audio:GetVoiceLength("story_v_out_123112", "123112023", "story_v_out_123112.awb") / 1000

					if var_96_13 + var_96_7 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_7
					end

					if var_96_9.prefab_name ~= "" and arg_93_1.actors_[var_96_9.prefab_name] ~= nil then
						local var_96_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_9.prefab_name].transform, "story_v_out_123112", "123112023", "story_v_out_123112.awb")

						arg_93_1:RecordAudio("123112023", var_96_14)
						arg_93_1:RecordAudio("123112023", var_96_14)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_123112", "123112023", "story_v_out_123112.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_123112", "123112023", "story_v_out_123112.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_15 = math.max(var_96_8, arg_93_1.talkMaxDuration)

			if var_96_7 <= arg_93_1.time_ and arg_93_1.time_ < var_96_7 + var_96_15 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_7) / var_96_15

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_7 + var_96_15 and arg_93_1.time_ < var_96_7 + var_96_15 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
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
	Play123112024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 123112024
		arg_97_1.duration_ = 5.6

		local var_97_0 = {
			zh = 5.6,
			ja = 4.9
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
				arg_97_0:Play123112025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.625

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[500].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(123112024)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 25 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 25)

				if (25 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 25)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112024", "story_v_out_123112.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_123112", "123112024", "story_v_out_123112.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_123112", "123112024", "story_v_out_123112.awb")

						arg_97_1:RecordAudio("123112024", var_100_6)
						arg_97_1:RecordAudio("123112024", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_123112", "123112024", "story_v_out_123112.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_123112", "123112024", "story_v_out_123112.awb")
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
	Play123112025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 123112025
		arg_101_1.duration_ = 12.77

		local var_101_0 = {
			zh = 7.833,
			ja = 12.766
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
				arg_101_0:Play123112026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1055ui_story = arg_101_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1055ui_story"].transform.position).z)
				arg_101_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1055ui_story"].transform.localEulerAngles = arg_101_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_101_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1055ui_story"].transform.position).z)
				arg_101_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1055ui_story"].transform.localEulerAngles = arg_101_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1055ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1055ui_story == nil then
				arg_101_1.var_.characterEffect1055ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1055ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1055ui_story then
				arg_101_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_104_4 = 0
			local var_104_5 = 1.1

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(123112025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 44 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 44)

				if (44 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 44)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112025", "story_v_out_123112.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112025", "story_v_out_123112.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_123112", "123112025", "story_v_out_123112.awb")

						arg_101_1:RecordAudio("123112025", var_104_11)
						arg_101_1:RecordAudio("123112025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_123112", "123112025", "story_v_out_123112.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_123112", "123112025", "story_v_out_123112.awb")
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
				actorName = "1055ui_story",
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
	Play123112026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 123112026
		arg_105_1.duration_ = 4.9

		local var_105_0 = {
			zh = 4.5,
			ja = 4.9
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
				arg_105_0:Play123112027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1055ui_story"]) and arg_105_1.var_.characterEffect1055ui_story == nil then
				arg_105_1.var_.characterEffect1055ui_story = arg_105_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1055ui_story"]) then
				if arg_105_1.var_.characterEffect1055ui_story and not isNil(arg_105_1.actors_["1055ui_story"]) then
					arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1055ui_story"]) and arg_105_1.var_.characterEffect1055ui_story then
				arg_105_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.525

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[500].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_3 = arg_105_1:GetWordFromCfg(123112026)
				local var_108_4 = arg_105_1:FormatText(var_108_3.content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 21 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_4) / 21)

				if (21 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_4) / 21)) > 0 and var_108_2 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112026", "story_v_out_123112.awb") ~= 0 then
					local var_108_7 = manager.audio:GetVoiceLength("story_v_out_123112", "123112026", "story_v_out_123112.awb") / 1000

					if var_108_7 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_1
					end

					if var_108_3.prefab_name ~= "" and arg_105_1.actors_[var_108_3.prefab_name] ~= nil then
						local var_108_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_3.prefab_name].transform, "story_v_out_123112", "123112026", "story_v_out_123112.awb")

						arg_105_1:RecordAudio("123112026", var_108_8)
						arg_105_1:RecordAudio("123112026", var_108_8)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_123112", "123112026", "story_v_out_123112.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_123112", "123112026", "story_v_out_123112.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_9 and arg_105_1.time_ < var_108_1 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play123112027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 123112027
		arg_109_1.duration_ = 2.9

		local var_109_0 = {
			zh = 2.866,
			ja = 2.9
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
				arg_109_0:Play123112028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.225

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[499].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(123112027)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 9 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 9)

				if (9 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 9)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112027", "story_v_out_123112.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_123112", "123112027", "story_v_out_123112.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_123112", "123112027", "story_v_out_123112.awb")

						arg_109_1:RecordAudio("123112027", var_112_6)
						arg_109_1:RecordAudio("123112027", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_123112", "123112027", "story_v_out_123112.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_123112", "123112027", "story_v_out_123112.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play123112028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 123112028
		arg_113_1.duration_ = 5.23

		local var_113_0 = {
			zh = 5.233,
			ja = 5
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play123112029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.55

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[500].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_1 = arg_113_1:GetWordFromCfg(123112028)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 22 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 22)

				if (22 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 22)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112028", "story_v_out_123112.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_123112", "123112028", "story_v_out_123112.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_123112", "123112028", "story_v_out_123112.awb")

						arg_113_1:RecordAudio("123112028", var_116_6)
						arg_113_1:RecordAudio("123112028", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_123112", "123112028", "story_v_out_123112.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_123112", "123112028", "story_v_out_123112.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play123112029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 123112029
		arg_117_1.duration_ = 6

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play123112030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_0 = 1

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				local var_120_1 = Color.New(1, 1, 1)

				var_120_1.a = Mathf.Lerp(1, 0, (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.mask_.color = var_120_1
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				local var_120_2 = Color.New(1, 1, 1)

				arg_117_1.mask_.enabled = false
				var_120_2.a = 0
				arg_117_1.mask_.color = var_120_2
			end

			local var_120_3 = arg_117_1.actors_["1055ui_story"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1055ui_story = var_120_3.localPosition
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_3.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_4)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_3.localPosition = Vector3.New(0, 100, 0)
				var_120_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_120_3.position).x, (manager.ui.mainCamera.transform.position - var_120_3.position).y, (manager.ui.mainCamera.transform.position - var_120_3.position).z)
				var_120_3.localEulerAngles.z = 0
				var_120_3.localEulerAngles.x = 0
				var_120_3.localEulerAngles = var_120_3.localEulerAngles
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_5 = 1
			local var_120_6 = 0.775

			if 1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_7 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_7:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(123112029).content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 31 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 31)

				if (31 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 31)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10
					var_120_5 = var_120_5 + 0.3

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_11 = var_120_5 + 0.3
			local var_120_12 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_11) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_11 + var_120_12 and arg_117_1.time_ < var_120_11 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play123112030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 123112030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play123112031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 1.1

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(123112030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 44 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 44)

				if (44 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 44)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play123112031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 123112031
		arg_127_1.duration_ = 13.8

		local var_127_0 = {
			zh = 11.433,
			ja = 13.8
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
				arg_127_0:Play123112032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1055ui_story = arg_127_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1055ui_story"].transform.position).z)
				arg_127_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1055ui_story"].transform.localEulerAngles = arg_127_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_127_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1055ui_story"].transform.position).z)
				arg_127_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1055ui_story"].transform.localEulerAngles = arg_127_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1055ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1055ui_story == nil then
				arg_127_1.var_.characterEffect1055ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1055ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1055ui_story then
				arg_127_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_130_4 = 0
			local var_130_5 = 1

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(123112031)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 40 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 40)

				if (40 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 40)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112031", "story_v_out_123112.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112031", "story_v_out_123112.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_123112", "123112031", "story_v_out_123112.awb")

						arg_127_1:RecordAudio("123112031", var_130_11)
						arg_127_1:RecordAudio("123112031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_123112", "123112031", "story_v_out_123112.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_123112", "123112031", "story_v_out_123112.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123112032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 123112032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play123112033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1055ui_story"]) and arg_131_1.var_.characterEffect1055ui_story == nil then
				arg_131_1.var_.characterEffect1055ui_story = arg_131_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1055ui_story"]) then
				if arg_131_1.var_.characterEffect1055ui_story and not isNil(arg_131_1.actors_["1055ui_story"]) then
					arg_131_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1055ui_story"]) and arg_131_1.var_.characterEffect1055ui_story then
				arg_131_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 1.375

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(123112032).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 55 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 55)

				if (55 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 55)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play123112033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 123112033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play123112034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action3_2")
			end

			local var_138_0 = 0
			local var_138_1 = 0.975

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(123112033).content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 39 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_2) / 39)

				if (39 <= 0 and var_138_1 or var_138_1 * (utf8.len(var_138_2) / 39)) > 0 and var_138_1 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_5 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_5 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_5

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_5 and arg_135_1.time_ < var_138_0 + var_138_5 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play123112034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 123112034
		arg_139_1.duration_ = 3.17

		local var_139_0 = {
			zh = 1.999999999999,
			ja = 3.166
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
				arg_139_0:Play123112035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1093ui_story = arg_139_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1093ui_story"].transform.position).z)
				arg_139_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1093ui_story"].transform.localEulerAngles = arg_139_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_139_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1093ui_story"].transform.position).z)
				arg_139_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1093ui_story"].transform.localEulerAngles = arg_139_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1093ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1093ui_story == nil then
				arg_139_1.var_.characterEffect1093ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1093ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1093ui_story then
				arg_139_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action8_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_142_4 = arg_139_1.actors_["1055ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1055ui_story = var_142_4.localPosition
			end

			local var_142_5 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_139_1.time_ - 0) / var_142_5)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				var_142_4.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			local var_142_6 = arg_139_1.actors_["1055ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1055ui_story == nil then
				arg_139_1.var_.characterEffect1055ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_7 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 and not isNil(var_142_6) then
				if arg_139_1.var_.characterEffect1055ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_7)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1055ui_story then
				arg_139_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			local var_142_8 = 0
			local var_142_9 = 0.15

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(123112034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 6 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 6)

				if (6 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 6)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112034", "story_v_out_123112.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_123112", "123112034", "story_v_out_123112.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_123112", "123112034", "story_v_out_123112.awb")

						arg_139_1:RecordAudio("123112034", var_142_15)
						arg_139_1:RecordAudio("123112034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_123112", "123112034", "story_v_out_123112.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_123112", "123112034", "story_v_out_123112.awb")
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
				actorName = "1055ui_story",
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
	Play123112035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 123112035
		arg_143_1.duration_ = 9.7

		local var_143_0 = {
			zh = 7.766,
			ja = 9.7
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
				arg_143_0:Play123112036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1055ui_story"]) and arg_143_1.var_.characterEffect1055ui_story == nil then
				arg_143_1.var_.characterEffect1055ui_story = arg_143_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1055ui_story"]) then
				if arg_143_1.var_.characterEffect1055ui_story and not isNil(arg_143_1.actors_["1055ui_story"]) then
					arg_143_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1055ui_story"]) and arg_143_1.var_.characterEffect1055ui_story then
				arg_143_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_146_2 = arg_143_1.actors_["1093ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect1093ui_story == nil then
				arg_143_1.var_.characterEffect1093ui_story = var_146_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_3 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.characterEffect1093ui_story and not isNil(var_146_2) then
					arg_143_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_3)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect1093ui_story then
				arg_143_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_146_4 = 0
			local var_146_5 = 0.875

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(123112035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 35 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 35)

				if (35 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 35)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112035", "story_v_out_123112.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112035", "story_v_out_123112.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_123112", "123112035", "story_v_out_123112.awb")

						arg_143_1:RecordAudio("123112035", var_146_11)
						arg_143_1:RecordAudio("123112035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_123112", "123112035", "story_v_out_123112.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_123112", "123112035", "story_v_out_123112.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play123112036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 123112036
		arg_147_1.duration_ = 5.57

		local var_147_0 = {
			zh = 4.666,
			ja = 5.566
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
				arg_147_0:Play123112037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1093ui_story = arg_147_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1093ui_story"].transform.position).z)
				arg_147_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1093ui_story"].transform.localEulerAngles = arg_147_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_147_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1093ui_story"].transform.position).z)
				arg_147_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1093ui_story"].transform.localEulerAngles = arg_147_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1093ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1093ui_story == nil then
				arg_147_1.var_.characterEffect1093ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1093ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1093ui_story then
				arg_147_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_150_4 = arg_147_1.actors_["1055ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect1055ui_story == nil then
				arg_147_1.var_.characterEffect1055ui_story = var_150_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_5 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 and not isNil(var_150_4) then
				if arg_147_1.var_.characterEffect1055ui_story and not isNil(var_150_4) then
					arg_147_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_5)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect1055ui_story then
				arg_147_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action486")
			end

			local var_150_6 = 0
			local var_150_7 = 0.575

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(123112036)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 22 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 22)

				if (22 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 22)) > 0 and var_150_7 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112036", "story_v_out_123112.awb") ~= 0 then
					local var_150_12 = manager.audio:GetVoiceLength("story_v_out_123112", "123112036", "story_v_out_123112.awb") / 1000

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end

					if var_150_8.prefab_name ~= "" and arg_147_1.actors_[var_150_8.prefab_name] ~= nil then
						local var_150_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_8.prefab_name].transform, "story_v_out_123112", "123112036", "story_v_out_123112.awb")

						arg_147_1:RecordAudio("123112036", var_150_13)
						arg_147_1:RecordAudio("123112036", var_150_13)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_123112", "123112036", "story_v_out_123112.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_123112", "123112036", "story_v_out_123112.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play123112037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 123112037
		arg_151_1.duration_ = 2.5

		local var_151_0 = {
			zh = 2.5,
			ja = 2.433
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
				arg_151_0:Play123112038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1055ui_story"]) and arg_151_1.var_.characterEffect1055ui_story == nil then
				arg_151_1.var_.characterEffect1055ui_story = arg_151_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1055ui_story"]) then
				if arg_151_1.var_.characterEffect1055ui_story and not isNil(arg_151_1.actors_["1055ui_story"]) then
					arg_151_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1055ui_story"]) and arg_151_1.var_.characterEffect1055ui_story then
				arg_151_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_154_2 = arg_151_1.actors_["1093ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect1093ui_story == nil then
				arg_151_1.var_.characterEffect1093ui_story = var_154_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_3 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_3 and not isNil(var_154_2) then
				if arg_151_1.var_.characterEffect1093ui_story and not isNil(var_154_2) then
					arg_151_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_3)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_3 and arg_151_1.time_ < 0 + var_154_3 + arg_154_0 and not isNil(var_154_2) and arg_151_1.var_.characterEffect1093ui_story then
				arg_151_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_154_4 = 0
			local var_154_5 = 0.225

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(123112037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 9 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 9)

				if (9 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 9)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112037", "story_v_out_123112.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112037", "story_v_out_123112.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_123112", "123112037", "story_v_out_123112.awb")

						arg_151_1:RecordAudio("123112037", var_154_11)
						arg_151_1:RecordAudio("123112037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_123112", "123112037", "story_v_out_123112.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_123112", "123112037", "story_v_out_123112.awb")
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
	Play123112038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 123112038
		arg_155_1.duration_ = 10.8

		local var_155_0 = {
			zh = 10.8,
			ja = 9.1
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
				arg_155_0:Play123112039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1055ui_story"]) and arg_155_1.var_.characterEffect1055ui_story == nil then
				arg_155_1.var_.characterEffect1055ui_story = arg_155_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1055ui_story"]) then
				if arg_155_1.var_.characterEffect1055ui_story and not isNil(arg_155_1.actors_["1055ui_story"]) then
					arg_155_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1055ui_story"]) and arg_155_1.var_.characterEffect1055ui_story then
				arg_155_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_158_1 = arg_155_1.actors_["1093ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1093ui_story == nil then
				arg_155_1.var_.characterEffect1093ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect1093ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect1093ui_story then
				arg_155_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_158_4 = 0
			local var_158_5 = 1.075

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(123112038)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 43 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 43)

				if (43 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 43)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112038", "story_v_out_123112.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112038", "story_v_out_123112.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_out_123112", "123112038", "story_v_out_123112.awb")

						arg_155_1:RecordAudio("123112038", var_158_11)
						arg_155_1:RecordAudio("123112038", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_123112", "123112038", "story_v_out_123112.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_123112", "123112038", "story_v_out_123112.awb")
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
	Play123112039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 123112039
		arg_159_1.duration_ = 13.17

		local var_159_0 = {
			zh = 11.933,
			ja = 13.166
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
				arg_159_0:Play123112040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_0 = 0
			local var_162_1 = 1.1

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(123112039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 44 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 44)

				if (44 <= 0 and var_162_1 or var_162_1 * (utf8.len(var_162_3) / 44)) > 0 and var_162_1 < var_162_5 then
					arg_159_1.talkMaxDuration = var_162_5

					if var_162_5 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112039", "story_v_out_123112.awb") ~= 0 then
					local var_162_6 = manager.audio:GetVoiceLength("story_v_out_123112", "123112039", "story_v_out_123112.awb") / 1000

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end

					if var_162_2.prefab_name ~= "" and arg_159_1.actors_[var_162_2.prefab_name] ~= nil then
						local var_162_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_2.prefab_name].transform, "story_v_out_123112", "123112039", "story_v_out_123112.awb")

						arg_159_1:RecordAudio("123112039", var_162_7)
						arg_159_1:RecordAudio("123112039", var_162_7)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_123112", "123112039", "story_v_out_123112.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_123112", "123112039", "story_v_out_123112.awb")
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
	Play123112040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 123112040
		arg_163_1.duration_ = 4.17

		local var_163_0 = {
			zh = 2.866,
			ja = 4.166
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
				arg_163_0:Play123112041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1055ui_story"]) and arg_163_1.var_.characterEffect1055ui_story == nil then
				arg_163_1.var_.characterEffect1055ui_story = arg_163_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1055ui_story"]) then
				if arg_163_1.var_.characterEffect1055ui_story and not isNil(arg_163_1.actors_["1055ui_story"]) then
					arg_163_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1055ui_story"]) and arg_163_1.var_.characterEffect1055ui_story then
				arg_163_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_166_2 = arg_163_1.actors_["1093ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1093ui_story == nil then
				arg_163_1.var_.characterEffect1093ui_story = var_166_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_3 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.characterEffect1093ui_story and not isNil(var_166_2) then
					arg_163_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1093ui_story then
				arg_163_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_166_4 = 0
			local var_166_5 = 0.25

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(123112040)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 10 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 10)

				if (10 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 10)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112040", "story_v_out_123112.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112040", "story_v_out_123112.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_123112", "123112040", "story_v_out_123112.awb")

						arg_163_1:RecordAudio("123112040", var_166_11)
						arg_163_1:RecordAudio("123112040", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_123112", "123112040", "story_v_out_123112.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_123112", "123112040", "story_v_out_123112.awb")
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
	Play123112041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 123112041
		arg_167_1.duration_ = 2.63

		local var_167_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play123112042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1093ui_story"]) and arg_167_1.var_.characterEffect1093ui_story == nil then
				arg_167_1.var_.characterEffect1093ui_story = arg_167_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1093ui_story"]) then
				if arg_167_1.var_.characterEffect1093ui_story and not isNil(arg_167_1.actors_["1093ui_story"]) then
					arg_167_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1093ui_story"]) and arg_167_1.var_.characterEffect1093ui_story then
				arg_167_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_170_2 = arg_167_1.actors_["1055ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect1055ui_story == nil then
				arg_167_1.var_.characterEffect1055ui_story = var_170_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_3 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.characterEffect1055ui_story and not isNil(var_170_2) then
					arg_167_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_3)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect1055ui_story then
				arg_167_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_170_4 = 0
			local var_170_5 = 0.2

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:GetWordFromCfg(123112041)
				local var_170_7 = arg_167_1:FormatText(var_170_6.content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 8 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 8)

				if (8 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_7) / 8)) > 0 and var_170_5 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112041", "story_v_out_123112.awb") ~= 0 then
					local var_170_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112041", "story_v_out_123112.awb") / 1000

					if var_170_10 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_4
					end

					if var_170_6.prefab_name ~= "" and arg_167_1.actors_[var_170_6.prefab_name] ~= nil then
						local var_170_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_6.prefab_name].transform, "story_v_out_123112", "123112041", "story_v_out_123112.awb")

						arg_167_1:RecordAudio("123112041", var_170_11)
						arg_167_1:RecordAudio("123112041", var_170_11)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_123112", "123112041", "story_v_out_123112.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_123112", "123112041", "story_v_out_123112.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_12 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_12 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_12

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_12 and arg_167_1.time_ < var_170_4 + var_170_12 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play123112042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 123112042
		arg_171_1.duration_ = 11.83

		local var_171_0 = {
			zh = 11.833,
			ja = 9.5
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
				arg_171_0:Play123112043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1055ui_story"]) and arg_171_1.var_.characterEffect1055ui_story == nil then
				arg_171_1.var_.characterEffect1055ui_story = arg_171_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1055ui_story"]) then
				if arg_171_1.var_.characterEffect1055ui_story and not isNil(arg_171_1.actors_["1055ui_story"]) then
					arg_171_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1055ui_story"]) and arg_171_1.var_.characterEffect1055ui_story then
				arg_171_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055actionlink/1055action425")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_174_2 = arg_171_1.actors_["1093ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1093ui_story == nil then
				arg_171_1.var_.characterEffect1093ui_story = var_174_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_3 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.characterEffect1093ui_story and not isNil(var_174_2) then
					arg_171_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_3)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1093ui_story then
				arg_171_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_174_4 = 0
			local var_174_5 = 1.275

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(123112042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 51 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 51)

				if (51 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 51)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112042", "story_v_out_123112.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112042", "story_v_out_123112.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_123112", "123112042", "story_v_out_123112.awb")

						arg_171_1:RecordAudio("123112042", var_174_11)
						arg_171_1:RecordAudio("123112042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_123112", "123112042", "story_v_out_123112.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_123112", "123112042", "story_v_out_123112.awb")
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
	Play123112043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 123112043
		arg_175_1.duration_ = 6.43

		local var_175_0 = {
			zh = 6.433,
			ja = 6.166
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
				arg_175_0:Play123112044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1055ui_story"]) and arg_175_1.var_.characterEffect1055ui_story == nil then
				arg_175_1.var_.characterEffect1055ui_story = arg_175_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1055ui_story"]) then
				if arg_175_1.var_.characterEffect1055ui_story and not isNil(arg_175_1.actors_["1055ui_story"]) then
					arg_175_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1055ui_story"]) and arg_175_1.var_.characterEffect1055ui_story then
				arg_175_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_1 = arg_175_1.actors_["1093ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1093ui_story == nil then
				arg_175_1.var_.characterEffect1093ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1093ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1093ui_story then
				arg_175_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_178_4 = 0
			local var_178_5 = 0.7

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(123112043)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 28 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 28)

				if (28 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 28)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112043", "story_v_out_123112.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112043", "story_v_out_123112.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_123112", "123112043", "story_v_out_123112.awb")

						arg_175_1:RecordAudio("123112043", var_178_11)
						arg_175_1:RecordAudio("123112043", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_123112", "123112043", "story_v_out_123112.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_123112", "123112043", "story_v_out_123112.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play123112044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 123112044
		arg_179_1.duration_ = 3.1

		local var_179_0 = {
			zh = 3,
			ja = 3.1
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
				arg_179_0:Play123112045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093actionlink/1093action467")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_182_0 = 0
			local var_182_1 = 0.275

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_2 = arg_179_1:GetWordFromCfg(123112044)
				local var_182_3 = arg_179_1:FormatText(var_182_2.content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 11 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 11)

				if (11 <= 0 and var_182_1 or var_182_1 * (utf8.len(var_182_3) / 11)) > 0 and var_182_1 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112044", "story_v_out_123112.awb") ~= 0 then
					local var_182_6 = manager.audio:GetVoiceLength("story_v_out_123112", "123112044", "story_v_out_123112.awb") / 1000

					if var_182_6 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_0
					end

					if var_182_2.prefab_name ~= "" and arg_179_1.actors_[var_182_2.prefab_name] ~= nil then
						local var_182_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_2.prefab_name].transform, "story_v_out_123112", "123112044", "story_v_out_123112.awb")

						arg_179_1:RecordAudio("123112044", var_182_7)
						arg_179_1:RecordAudio("123112044", var_182_7)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_123112", "123112044", "story_v_out_123112.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_123112", "123112044", "story_v_out_123112.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_8 and arg_179_1.time_ < var_182_0 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play123112045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 123112045
		arg_183_1.duration_ = 2.7

		local var_183_0 = {
			zh = 2.7,
			ja = 2.466
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
				arg_183_0:Play123112046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1055ui_story"]) and arg_183_1.var_.characterEffect1055ui_story == nil then
				arg_183_1.var_.characterEffect1055ui_story = arg_183_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1055ui_story"]) then
				if arg_183_1.var_.characterEffect1055ui_story and not isNil(arg_183_1.actors_["1055ui_story"]) then
					arg_183_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1055ui_story"]) and arg_183_1.var_.characterEffect1055ui_story then
				arg_183_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_186_2 = arg_183_1.actors_["1093ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1093ui_story == nil then
				arg_183_1.var_.characterEffect1093ui_story = var_186_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_3 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.characterEffect1093ui_story and not isNil(var_186_2) then
					arg_183_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_3)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1093ui_story then
				arg_183_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_186_4 = 0
			local var_186_5 = 0.15

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(123112045)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 6 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 6)

				if (6 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 6)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112045", "story_v_out_123112.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112045", "story_v_out_123112.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_123112", "123112045", "story_v_out_123112.awb")

						arg_183_1:RecordAudio("123112045", var_186_11)
						arg_183_1:RecordAudio("123112045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_123112", "123112045", "story_v_out_123112.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_123112", "123112045", "story_v_out_123112.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play123112046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 123112046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play123112047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1093ui_story = arg_187_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1093ui_story"].transform.position).z)
				arg_187_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1093ui_story"].transform.localEulerAngles = arg_187_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_187_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["1093ui_story"].transform.position).z)
				arg_187_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["1093ui_story"].transform.localEulerAngles = arg_187_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["1093ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1093ui_story == nil then
				arg_187_1.var_.characterEffect1093ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect1093ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_2)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect1093ui_story then
				arg_187_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_190_3 = arg_187_1.actors_["1055ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1055ui_story = var_190_3.localPosition
			end

			local var_190_4 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				var_190_3.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 0) / var_190_4)
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

			local var_190_5 = arg_187_1.actors_["1055ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect1055ui_story == nil then
				arg_187_1.var_.characterEffect1055ui_story = var_190_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 and not isNil(var_190_5) then
				if arg_187_1.var_.characterEffect1055ui_story and not isNil(var_190_5) then
					arg_187_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_6)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.characterEffect1055ui_story then
				arg_187_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_190_7 = 0
			local var_190_8 = 0.775

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

				local var_190_9 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(123112046).content)

				arg_187_1.text_.text = var_190_9

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 31 <= 0 and var_190_8 or var_190_8 * (utf8.len(var_190_9) / 31)

				if (31 <= 0 and var_190_8 or var_190_8 * (utf8.len(var_190_9) / 31)) > 0 and var_190_8 < var_190_11 then
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
				actorName = "1055ui_story",
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
	Play123112047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 123112047
		arg_191_1.duration_ = 6.23

		local var_191_0 = {
			zh = 6.233,
			ja = 5.4
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
				arg_191_0:Play123112048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1055ui_story = arg_191_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1055ui_story"].transform.position).z)
				arg_191_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1055ui_story"].transform.localEulerAngles = arg_191_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_191_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1055ui_story"].transform.position).z)
				arg_191_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1055ui_story"].transform.localEulerAngles = arg_191_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1055ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1055ui_story == nil then
				arg_191_1.var_.characterEffect1055ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1055ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1055ui_story then
				arg_191_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.725

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(123112047)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 29 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 29)

				if (29 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 29)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112047", "story_v_out_123112.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112047", "story_v_out_123112.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_123112", "123112047", "story_v_out_123112.awb")

						arg_191_1:RecordAudio("123112047", var_194_11)
						arg_191_1:RecordAudio("123112047", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_123112", "123112047", "story_v_out_123112.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_123112", "123112047", "story_v_out_123112.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play123112048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 123112048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play123112049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1055ui_story"]) and arg_195_1.var_.characterEffect1055ui_story == nil then
				arg_195_1.var_.characterEffect1055ui_story = arg_195_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1055ui_story"]) then
				if arg_195_1.var_.characterEffect1055ui_story and not isNil(arg_195_1.actors_["1055ui_story"]) then
					arg_195_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1055ui_story"]) and arg_195_1.var_.characterEffect1055ui_story then
				arg_195_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.275

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(123112048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 11 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 11)

				if (11 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 11)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play123112049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 123112049
		arg_199_1.duration_ = 2.97

		local var_199_0 = {
			zh = 2.466,
			ja = 2.966
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
				arg_199_0:Play123112050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1093ui_story = arg_199_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1093ui_story"].transform.position).z)
				arg_199_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1093ui_story"].transform.localEulerAngles = arg_199_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_199_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1093ui_story"].transform.position).z)
				arg_199_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1093ui_story"].transform.localEulerAngles = arg_199_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1093ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1093ui_story == nil then
				arg_199_1.var_.characterEffect1093ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1093ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1093ui_story then
				arg_199_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_202_4 = arg_199_1.actors_["1055ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1055ui_story = var_202_4.localPosition
			end

			local var_202_5 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 then
				var_202_4.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_199_1.time_ - 0) / var_202_5)
				var_202_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_4.position).x, (manager.ui.mainCamera.transform.position - var_202_4.position).y, (manager.ui.mainCamera.transform.position - var_202_4.position).z)
				var_202_4.localEulerAngles.z = 0
				var_202_4.localEulerAngles.x = 0
				var_202_4.localEulerAngles = var_202_4.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 then
				var_202_4.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				var_202_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_4.position).x, (manager.ui.mainCamera.transform.position - var_202_4.position).y, (manager.ui.mainCamera.transform.position - var_202_4.position).z)
				var_202_4.localEulerAngles.z = 0
				var_202_4.localEulerAngles.x = 0
				var_202_4.localEulerAngles = var_202_4.localEulerAngles
			end

			local var_202_6 = 0
			local var_202_7 = 0.275

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(123112049)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 11 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 11)

				if (11 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 11)) > 0 and var_202_7 < var_202_11 then
					arg_199_1.talkMaxDuration = var_202_11

					if var_202_11 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112049", "story_v_out_123112.awb") ~= 0 then
					local var_202_12 = manager.audio:GetVoiceLength("story_v_out_123112", "123112049", "story_v_out_123112.awb") / 1000

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end

					if var_202_8.prefab_name ~= "" and arg_199_1.actors_[var_202_8.prefab_name] ~= nil then
						local var_202_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_8.prefab_name].transform, "story_v_out_123112", "123112049", "story_v_out_123112.awb")

						arg_199_1:RecordAudio("123112049", var_202_13)
						arg_199_1:RecordAudio("123112049", var_202_13)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_123112", "123112049", "story_v_out_123112.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_123112", "123112049", "story_v_out_123112.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_14 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_14 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_14

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_14 and arg_199_1.time_ < var_202_6 + var_202_14 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
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
	Play123112050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 123112050
		arg_203_1.duration_ = 8.27

		local var_203_0 = {
			zh = 8.266,
			ja = 7
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
				arg_203_0:Play123112051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1055ui_story = arg_203_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).z)
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles = arg_203_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				arg_203_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1055ui_story"].transform.position).z)
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1055ui_story"].transform.localEulerAngles = arg_203_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1055ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1055ui_story == nil then
				arg_203_1.var_.characterEffect1055ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1055ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1055ui_story then
				arg_203_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_206_4 = arg_203_1.actors_["1093ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1093ui_story == nil then
				arg_203_1.var_.characterEffect1093ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_5 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 and not isNil(var_206_4) then
				if arg_203_1.var_.characterEffect1093ui_story and not isNil(var_206_4) then
					arg_203_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_5)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect1093ui_story then
				arg_203_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_206_6 = 0
			local var_206_7 = 0.975

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(123112050)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 39 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 39)

				if (39 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 39)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112050", "story_v_out_123112.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_123112", "123112050", "story_v_out_123112.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_123112", "123112050", "story_v_out_123112.awb")

						arg_203_1:RecordAudio("123112050", var_206_13)
						arg_203_1:RecordAudio("123112050", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_123112", "123112050", "story_v_out_123112.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_123112", "123112050", "story_v_out_123112.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
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
	Play123112051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 123112051
		arg_207_1.duration_ = 4

		local var_207_0 = {
			zh = 4,
			ja = 2.5
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
				arg_207_0:Play123112052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1093ui_story"]) and arg_207_1.var_.characterEffect1093ui_story == nil then
				arg_207_1.var_.characterEffect1093ui_story = arg_207_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1093ui_story"]) then
				if arg_207_1.var_.characterEffect1093ui_story and not isNil(arg_207_1.actors_["1093ui_story"]) then
					arg_207_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1093ui_story"]) and arg_207_1.var_.characterEffect1093ui_story then
				arg_207_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9902cva")
			end

			local var_210_2 = arg_207_1.actors_["1055ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect1055ui_story == nil then
				arg_207_1.var_.characterEffect1055ui_story = var_210_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_3 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_3 and not isNil(var_210_2) then
				if arg_207_1.var_.characterEffect1055ui_story and not isNil(var_210_2) then
					arg_207_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_3)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_3 and arg_207_1.time_ < 0 + var_210_3 + arg_210_0 and not isNil(var_210_2) and arg_207_1.var_.characterEffect1055ui_story then
				arg_207_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_210_4 = 0
			local var_210_5 = 0.3

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(123112051)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 12 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 12)

				if (12 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 12)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112051", "story_v_out_123112.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112051", "story_v_out_123112.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_out_123112", "123112051", "story_v_out_123112.awb")

						arg_207_1:RecordAudio("123112051", var_210_11)
						arg_207_1:RecordAudio("123112051", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_123112", "123112051", "story_v_out_123112.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_123112", "123112051", "story_v_out_123112.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play123112052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 123112052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play123112053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1093ui_story = arg_211_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1093ui_story"].transform.position).z)
				arg_211_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1093ui_story"].transform.localEulerAngles = arg_211_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1093ui_story"].transform.position).z)
				arg_211_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1093ui_story"].transform.localEulerAngles = arg_211_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1093ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1093ui_story == nil then
				arg_211_1.var_.characterEffect1093ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1093ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_2)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1093ui_story then
				arg_211_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_214_3 = arg_211_1.actors_["1055ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1055ui_story = var_214_3.localPosition
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_3.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_4)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_3.localPosition = Vector3.New(0, 100, 0)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			local var_214_5 = arg_211_1.actors_["1055ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect1055ui_story == nil then
				arg_211_1.var_.characterEffect1055ui_story = var_214_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 and not isNil(var_214_5) then
				if arg_211_1.var_.characterEffect1055ui_story and not isNil(var_214_5) then
					arg_211_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_6)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 and not isNil(var_214_5) and arg_211_1.var_.characterEffect1055ui_story then
				arg_211_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_214_7 = 0
			local var_214_8 = 1.25

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_9 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(123112052).content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 50 <= 0 and var_214_8 or var_214_8 * (utf8.len(var_214_9) / 50)

				if (50 <= 0 and var_214_8 or var_214_8 * (utf8.len(var_214_9) / 50)) > 0 and var_214_8 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_7 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_7
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_8, arg_211_1.talkMaxDuration)

			if var_214_7 <= arg_211_1.time_ and arg_211_1.time_ < var_214_7 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_7) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_7 + var_214_12 and arg_211_1.time_ < var_214_7 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play123112053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 123112053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play123112054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.475

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(123112053).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 19 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 19)

				if (19 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 19)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play123112054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 123112054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play123112055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.325

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(123112054).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 13 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 13)

				if (13 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 13)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play123112055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 123112055
		arg_223_1.duration_ = 4.3

		local var_223_0 = {
			zh = 4.3,
			ja = 4.2
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
				arg_223_0:Play123112056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1093ui_story = arg_223_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1093ui_story, Vector3.New(0.7, -1.11, -5.88), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).z)
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles = arg_223_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0.7, -1.11, -5.88)
				arg_223_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1093ui_story"].transform.position).z)
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1093ui_story"].transform.localEulerAngles = arg_223_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["1093ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1093ui_story == nil then
				arg_223_1.var_.characterEffect1093ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect1093ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect1093ui_story then
				arg_223_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_4 = 0
			local var_226_5 = 0.625

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(123112055)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 25 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 25)

				if (25 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 25)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112055", "story_v_out_123112.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112055", "story_v_out_123112.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_123112", "123112055", "story_v_out_123112.awb")

						arg_223_1:RecordAudio("123112055", var_226_11)
						arg_223_1:RecordAudio("123112055", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_123112", "123112055", "story_v_out_123112.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_123112", "123112055", "story_v_out_123112.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play123112056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 123112056
		arg_227_1.duration_ = 2

		local var_227_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_227_0:Play123112057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1055ui_story = arg_227_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1055ui_story, Vector3.New(-0.7, -0.965, -6.2), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).z)
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles = arg_227_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(-0.7, -0.965, -6.2)
				arg_227_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1055ui_story"].transform.position).z)
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1055ui_story"].transform.localEulerAngles = arg_227_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1055ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1055ui_story == nil then
				arg_227_1.var_.characterEffect1055ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1055ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1055ui_story then
				arg_227_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_230_4 = arg_227_1.actors_["1093ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect1093ui_story == nil then
				arg_227_1.var_.characterEffect1093ui_story = var_230_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_5 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_5 and not isNil(var_230_4) then
				if arg_227_1.var_.characterEffect1093ui_story and not isNil(var_230_4) then
					arg_227_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_5)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_5 and arg_227_1.time_ < 0 + var_230_5 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect1093ui_story then
				arg_227_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_230_6 = 0
			local var_230_7 = 0.125

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_8 = arg_227_1:GetWordFromCfg(123112056)
				local var_230_9 = arg_227_1:FormatText(var_230_8.content)

				arg_227_1.text_.text = var_230_9

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 5 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 5)

				if (5 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 5)) > 0 and var_230_7 < var_230_11 then
					arg_227_1.talkMaxDuration = var_230_11

					if var_230_11 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_9
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112056", "story_v_out_123112.awb") ~= 0 then
					local var_230_12 = manager.audio:GetVoiceLength("story_v_out_123112", "123112056", "story_v_out_123112.awb") / 1000

					if var_230_12 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_12 + var_230_6
					end

					if var_230_8.prefab_name ~= "" and arg_227_1.actors_[var_230_8.prefab_name] ~= nil then
						local var_230_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_8.prefab_name].transform, "story_v_out_123112", "123112056", "story_v_out_123112.awb")

						arg_227_1:RecordAudio("123112056", var_230_13)
						arg_227_1:RecordAudio("123112056", var_230_13)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_123112", "123112056", "story_v_out_123112.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_123112", "123112056", "story_v_out_123112.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_14 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_14

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_14 and arg_227_1.time_ < var_230_6 + var_230_14 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play123112057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 123112057
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play123112058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if arg_231_1.bgs_.K05g == nil then
				local var_234_0 = Object.Instantiate(arg_231_1.paintGo_)

				var_234_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K05g")
				var_234_0.name = "K05g"
				var_234_0.transform.parent = arg_231_1.stage_.transform
				var_234_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.bgs_.K05g = var_234_0
			end

			if 1.999999999999 < arg_231_1.time_ and arg_231_1.time_ <= 1.999999999999 + arg_234_0 then
				local var_234_1 = arg_231_1.bgs_.K05g

				arg_231_1.bgs_.K05g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_234_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_234_2 = var_234_1:GetComponent("SpriteRenderer")

				if var_234_2 and var_234_2.sprite then
					local var_234_3 = 2 * (var_234_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_234_1.transform.localScale = Vector3.New(var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, var_234_3 / var_234_2.sprite.bounds.size.y < var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x and var_234_3 * manager.ui.mainCameraCom_.aspect / var_234_2.sprite.bounds.size.x or var_234_3 / var_234_2.sprite.bounds.size.y, 0)
				end

				for iter_234_0, iter_234_1 in pairs(arg_231_1.bgs_) do
					if iter_234_0 ~= "K05g" then
						iter_234_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_234_4 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_5 = 2

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_5 then
				local var_234_6 = Color.New(0, 0, 0)

				var_234_6.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_4) / var_234_5)
				arg_231_1.mask_.color = var_234_6
			end

			if arg_231_1.time_ >= var_234_4 + var_234_5 and arg_231_1.time_ < var_234_4 + var_234_5 + arg_234_0 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = 1
				arg_231_1.mask_.color = var_234_7
			end

			local var_234_8 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_9 = 2

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_9 then
				local var_234_10 = Color.New(0, 0, 0)

				var_234_10.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_8) / var_234_9)
				arg_231_1.mask_.color = var_234_10
			end

			if arg_231_1.time_ >= var_234_8 + var_234_9 and arg_231_1.time_ < var_234_8 + var_234_9 + arg_234_0 then
				local var_234_11 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_11.a = 0
				arg_231_1.mask_.color = var_234_11
			end

			local var_234_12 = arg_231_1.actors_["1093ui_story"].transform

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 then
				arg_231_1.var_.moveOldPos1093ui_story = var_234_12.localPosition
			end

			local var_234_13 = 0.001

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_13 then
				var_234_12.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 1.96599999815226) / var_234_13)
				var_234_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_12.position).x, (manager.ui.mainCamera.transform.position - var_234_12.position).y, (manager.ui.mainCamera.transform.position - var_234_12.position).z)
				var_234_12.localEulerAngles.z = 0
				var_234_12.localEulerAngles.x = 0
				var_234_12.localEulerAngles = var_234_12.localEulerAngles
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_13 and arg_231_1.time_ < 1.96599999815226 + var_234_13 + arg_234_0 then
				var_234_12.localPosition = Vector3.New(0, 100, 0)
				var_234_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_12.position).x, (manager.ui.mainCamera.transform.position - var_234_12.position).y, (manager.ui.mainCamera.transform.position - var_234_12.position).z)
				var_234_12.localEulerAngles.z = 0
				var_234_12.localEulerAngles.x = 0
				var_234_12.localEulerAngles = var_234_12.localEulerAngles
			end

			local var_234_14 = arg_231_1.actors_["1093ui_story"]

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 and not isNil(var_234_14) and arg_231_1.var_.characterEffect1093ui_story == nil then
				arg_231_1.var_.characterEffect1093ui_story = var_234_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_15 = 0.034000001847744

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_15 and not isNil(var_234_14) then
				if arg_231_1.var_.characterEffect1093ui_story and not isNil(var_234_14) then
					arg_231_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 1.96599999815226) / var_234_15)
				end
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_15 and arg_231_1.time_ < 1.96599999815226 + var_234_15 + arg_234_0 and not isNil(var_234_14) and arg_231_1.var_.characterEffect1093ui_story then
				arg_231_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_234_16 = arg_231_1.actors_["1055ui_story"].transform

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 then
				arg_231_1.var_.moveOldPos1055ui_story = var_234_16.localPosition
			end

			local var_234_17 = 0.001

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_17 then
				var_234_16.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 1.96599999815226) / var_234_17)
				var_234_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_16.position).x, (manager.ui.mainCamera.transform.position - var_234_16.position).y, (manager.ui.mainCamera.transform.position - var_234_16.position).z)
				var_234_16.localEulerAngles.z = 0
				var_234_16.localEulerAngles.x = 0
				var_234_16.localEulerAngles = var_234_16.localEulerAngles
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_17 and arg_231_1.time_ < 1.96599999815226 + var_234_17 + arg_234_0 then
				var_234_16.localPosition = Vector3.New(0, 100, 0)
				var_234_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_16.position).x, (manager.ui.mainCamera.transform.position - var_234_16.position).y, (manager.ui.mainCamera.transform.position - var_234_16.position).z)
				var_234_16.localEulerAngles.z = 0
				var_234_16.localEulerAngles.x = 0
				var_234_16.localEulerAngles = var_234_16.localEulerAngles
			end

			local var_234_18 = arg_231_1.actors_["1055ui_story"]

			if 1.96599999815226 < arg_231_1.time_ and arg_231_1.time_ <= 1.96599999815226 + arg_234_0 and not isNil(var_234_18) and arg_231_1.var_.characterEffect1055ui_story == nil then
				arg_231_1.var_.characterEffect1055ui_story = var_234_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_19 = 0.034000001847744

			if 1.96599999815226 <= arg_231_1.time_ and arg_231_1.time_ < 1.96599999815226 + var_234_19 and not isNil(var_234_18) then
				if arg_231_1.var_.characterEffect1055ui_story and not isNil(var_234_18) then
					arg_231_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 1.96599999815226) / var_234_19)
				end
			end

			if arg_231_1.time_ >= 1.96599999815226 + var_234_19 and arg_231_1.time_ < 1.96599999815226 + var_234_19 + arg_234_0 and not isNil(var_234_18) and arg_231_1.var_.characterEffect1055ui_story then
				arg_231_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_20 = 4
			local var_234_21 = 1.125

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_20 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_22 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_22:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_23 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(123112057).content)

				arg_231_1.text_.text = var_234_23

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_25 = 45 <= 0 and var_234_21 or var_234_21 * (utf8.len(var_234_23) / 45)

				if (45 <= 0 and var_234_21 or var_234_21 * (utf8.len(var_234_23) / 45)) > 0 and var_234_21 < var_234_25 then
					arg_231_1.talkMaxDuration = var_234_25
					var_234_20 = var_234_20 + 0.3

					if var_234_25 + var_234_20 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_25 + var_234_20
					end
				end

				arg_231_1.text_.text = var_234_23
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_26 = var_234_20 + 0.3
			local var_234_27 = math.max(var_234_21, arg_231_1.talkMaxDuration)

			if var_234_20 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_26 + var_234_27 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_26) / var_234_27

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_26 + var_234_27 and arg_231_1.time_ < var_234_26 + var_234_27 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play123112058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 123112058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play123112059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 1.425

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(123112058).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 57 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 57)

				if (57 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 57)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play123112059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 123112059
		arg_241_1.duration_ = 5.13

		local var_241_0 = {
			zh = 5.133,
			ja = 4.533
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play123112060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1055ui_story = arg_241_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).z)
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles = arg_241_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_241_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1055ui_story"].transform.position).z)
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1055ui_story"].transform.localEulerAngles = arg_241_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1055ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1055ui_story == nil then
				arg_241_1.var_.characterEffect1055ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1055ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1055ui_story then
				arg_241_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_244_4 = 0
			local var_244_5 = 0.725

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(123112059)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 29 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 29)

				if (29 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 29)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112059", "story_v_out_123112.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112059", "story_v_out_123112.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_123112", "123112059", "story_v_out_123112.awb")

						arg_241_1:RecordAudio("123112059", var_244_11)
						arg_241_1:RecordAudio("123112059", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_123112", "123112059", "story_v_out_123112.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_123112", "123112059", "story_v_out_123112.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_12 and arg_241_1.time_ < var_244_4 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play123112060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 123112060
		arg_245_1.duration_ = 3.53

		local var_245_0 = {
			zh = 3.533,
			ja = 3.166
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play123112061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) and arg_245_1.var_.characterEffect1055ui_story == nil then
				arg_245_1.var_.characterEffect1055ui_story = arg_245_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) then
				if arg_245_1.var_.characterEffect1055ui_story and not isNil(arg_245_1.actors_["1055ui_story"]) then
					arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1055ui_story"]) and arg_245_1.var_.characterEffect1055ui_story then
				arg_245_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.175

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[499].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_littleboyb")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(123112060)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 7 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 7)

				if (7 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 7)) > 0 and var_248_2 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112060", "story_v_out_123112.awb") ~= 0 then
					local var_248_7 = manager.audio:GetVoiceLength("story_v_out_123112", "123112060", "story_v_out_123112.awb") / 1000

					if var_248_7 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_1
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_123112", "123112060", "story_v_out_123112.awb")

						arg_245_1:RecordAudio("123112060", var_248_8)
						arg_245_1:RecordAudio("123112060", var_248_8)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_123112", "123112060", "story_v_out_123112.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_123112", "123112060", "story_v_out_123112.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_9 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_9 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_9

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_9 and arg_245_1.time_ < var_248_1 + var_248_9 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play123112061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 123112061
		arg_249_1.duration_ = 2

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play123112062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1055ui_story = arg_249_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1055ui_story"].transform.position).z)
				arg_249_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1055ui_story"].transform.localEulerAngles = arg_249_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_249_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1055ui_story"].transform.position).z)
				arg_249_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1055ui_story"].transform.localEulerAngles = arg_249_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1055ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1055ui_story == nil then
				arg_249_1.var_.characterEffect1055ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1055ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1055ui_story then
				arg_249_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action5_2")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.075

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(123112061)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 3 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 3)

				if (3 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 3)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112061", "story_v_out_123112.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112061", "story_v_out_123112.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_123112", "123112061", "story_v_out_123112.awb")

						arg_249_1:RecordAudio("123112061", var_252_11)
						arg_249_1:RecordAudio("123112061", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_123112", "123112061", "story_v_out_123112.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_123112", "123112061", "story_v_out_123112.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play123112062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 123112062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play123112063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1055ui_story"]) and arg_253_1.var_.characterEffect1055ui_story == nil then
				arg_253_1.var_.characterEffect1055ui_story = arg_253_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1055ui_story"]) then
				if arg_253_1.var_.characterEffect1055ui_story and not isNil(arg_253_1.actors_["1055ui_story"]) then
					arg_253_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1055ui_story"]) and arg_253_1.var_.characterEffect1055ui_story then
				arg_253_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.575

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(123112062).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 23 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 23)

				if (23 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 23)) > 0 and var_256_2 < var_256_5 then
					arg_253_1.talkMaxDuration = var_256_5

					if var_256_5 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_6 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_6 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_6

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_6 and arg_253_1.time_ < var_256_1 + var_256_6 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play123112063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 123112063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play123112064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.5

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(123112063).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 20 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 20)

				if (20 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 20)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play123112064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 123112064
		arg_261_1.duration_ = 6.23

		local var_261_0 = {
			zh = 6.233,
			ja = 4.966
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play123112065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos1055ui_story = arg_261_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1055ui_story, Vector3.New(0, -0.965, -6.2), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1055ui_story"].transform.position).z)
				arg_261_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1055ui_story"].transform.localEulerAngles = arg_261_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, -0.965, -6.2)
				arg_261_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["1055ui_story"].transform.position).z)
				arg_261_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["1055ui_story"].transform.localEulerAngles = arg_261_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_264_1 = arg_261_1.actors_["1055ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1055ui_story == nil then
				arg_261_1.var_.characterEffect1055ui_story = var_264_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_2 and not isNil(var_264_1) then
				if arg_261_1.var_.characterEffect1055ui_story and not isNil(var_264_1) then
					arg_261_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_2 and arg_261_1.time_ < 0 + var_264_2 + arg_264_0 and not isNil(var_264_1) and arg_261_1.var_.characterEffect1055ui_story then
				arg_261_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_264_4 = 0
			local var_264_5 = 0.875

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(123112064)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 35 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 35)

				if (35 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 35)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112064", "story_v_out_123112.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112064", "story_v_out_123112.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_123112", "123112064", "story_v_out_123112.awb")

						arg_261_1:RecordAudio("123112064", var_264_11)
						arg_261_1:RecordAudio("123112064", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_123112", "123112064", "story_v_out_123112.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_123112", "123112064", "story_v_out_123112.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_12 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_12 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_12

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_12 and arg_261_1.time_ < var_264_4 + var_264_12 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play123112065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 123112065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play123112066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1055ui_story"]) and arg_265_1.var_.characterEffect1055ui_story == nil then
				arg_265_1.var_.characterEffect1055ui_story = arg_265_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1055ui_story"]) then
				if arg_265_1.var_.characterEffect1055ui_story and not isNil(arg_265_1.actors_["1055ui_story"]) then
					arg_265_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1055ui_story"]) and arg_265_1.var_.characterEffect1055ui_story then
				arg_265_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_268_1 = 0
			local var_268_2 = 0.05

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(123112065).content)

				arg_265_1.text_.text = var_268_3

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 2 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 2)

				if (2 <= 0 and var_268_2 or var_268_2 * (utf8.len(var_268_3) / 2)) > 0 and var_268_2 < var_268_5 then
					arg_265_1.talkMaxDuration = var_268_5

					if var_268_5 + var_268_1 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + var_268_1
					end
				end

				arg_265_1.text_.text = var_268_3
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_6 = math.max(var_268_2, arg_265_1.talkMaxDuration)

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_6 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_1) / var_268_6

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_1 + var_268_6 and arg_265_1.time_ < var_268_1 + var_268_6 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play123112066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 123112066
		arg_269_1.duration_ = 14.4

		local var_269_0 = {
			zh = 12.866,
			ja = 14.4
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play123112067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1055ui_story"]) and arg_269_1.var_.characterEffect1055ui_story == nil then
				arg_269_1.var_.characterEffect1055ui_story = arg_269_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1055ui_story"]) then
				if arg_269_1.var_.characterEffect1055ui_story and not isNil(arg_269_1.actors_["1055ui_story"]) then
					arg_269_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1055ui_story"]) and arg_269_1.var_.characterEffect1055ui_story then
				arg_269_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action6_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_272_2 = 0
			local var_272_3 = 1.4

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_4 = arg_269_1:GetWordFromCfg(123112066)
				local var_272_5 = arg_269_1:FormatText(var_272_4.content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 56 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 56)

				if (56 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_5) / 56)) > 0 and var_272_3 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112066", "story_v_out_123112.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112066", "story_v_out_123112.awb") / 1000

					if var_272_8 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_2
					end

					if var_272_4.prefab_name ~= "" and arg_269_1.actors_[var_272_4.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_4.prefab_name].transform, "story_v_out_123112", "123112066", "story_v_out_123112.awb")

						arg_269_1:RecordAudio("123112066", var_272_9)
						arg_269_1:RecordAudio("123112066", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_123112", "123112066", "story_v_out_123112.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_123112", "123112066", "story_v_out_123112.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_10 and arg_269_1.time_ < var_272_2 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play123112067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 123112067
		arg_273_1.duration_ = 10.97

		local var_273_0 = {
			zh = 6.233,
			ja = 10.966
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play123112068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_276_0 = 0
			local var_276_1 = 0.875

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_2 = arg_273_1:GetWordFromCfg(123112067)
				local var_276_3 = arg_273_1:FormatText(var_276_2.content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 35 <= 0 and var_276_1 or var_276_1 * (utf8.len(var_276_3) / 35)

				if (35 <= 0 and var_276_1 or var_276_1 * (utf8.len(var_276_3) / 35)) > 0 and var_276_1 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_0
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112067", "story_v_out_123112.awb") ~= 0 then
					local var_276_6 = manager.audio:GetVoiceLength("story_v_out_123112", "123112067", "story_v_out_123112.awb") / 1000

					if var_276_6 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_0
					end

					if var_276_2.prefab_name ~= "" and arg_273_1.actors_[var_276_2.prefab_name] ~= nil then
						local var_276_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_2.prefab_name].transform, "story_v_out_123112", "123112067", "story_v_out_123112.awb")

						arg_273_1:RecordAudio("123112067", var_276_7)
						arg_273_1:RecordAudio("123112067", var_276_7)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_123112", "123112067", "story_v_out_123112.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_123112", "123112067", "story_v_out_123112.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_8 = math.max(var_276_1, arg_273_1.talkMaxDuration)

			if var_276_0 <= arg_273_1.time_ and arg_273_1.time_ < var_276_0 + var_276_8 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_0) / var_276_8

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_0 + var_276_8 and arg_273_1.time_ < var_276_0 + var_276_8 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play123112068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 123112068
		arg_277_1.duration_ = 8.43

		local var_277_0 = {
			zh = 6.8,
			ja = 8.433
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
				arg_277_0:Play123112069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action6_2")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_0 = 0
			local var_280_1 = 0.825

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(123112068)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 33 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 33)

				if (33 <= 0 and var_280_1 or var_280_1 * (utf8.len(var_280_3) / 33)) > 0 and var_280_1 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112068", "story_v_out_123112.awb") ~= 0 then
					local var_280_6 = manager.audio:GetVoiceLength("story_v_out_123112", "123112068", "story_v_out_123112.awb") / 1000

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end

					if var_280_2.prefab_name ~= "" and arg_277_1.actors_[var_280_2.prefab_name] ~= nil then
						local var_280_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_2.prefab_name].transform, "story_v_out_123112", "123112068", "story_v_out_123112.awb")

						arg_277_1:RecordAudio("123112068", var_280_7)
						arg_277_1:RecordAudio("123112068", var_280_7)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_123112", "123112068", "story_v_out_123112.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_123112", "123112068", "story_v_out_123112.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_8 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_8 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_8

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_8 and arg_277_1.time_ < var_280_0 + var_280_8 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play123112069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 123112069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play123112070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1055ui_story"]) and arg_281_1.var_.characterEffect1055ui_story == nil then
				arg_281_1.var_.characterEffect1055ui_story = arg_281_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1055ui_story"]) then
				if arg_281_1.var_.characterEffect1055ui_story and not isNil(arg_281_1.actors_["1055ui_story"]) then
					arg_281_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_0)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1055ui_story"]) and arg_281_1.var_.characterEffect1055ui_story then
				arg_281_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_284_1 = 0
			local var_284_2 = 0.625

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(123112069).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 25 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 25)

				if (25 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 25)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play123112070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 123112070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play123112071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.575

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(123112070).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 23 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 23)

				if (23 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 23)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play123112071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 123112071
		arg_289_1.duration_ = 8.1

		local var_289_0 = {
			zh = 6.2,
			ja = 8.1
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play123112072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["1055ui_story"]) and arg_289_1.var_.characterEffect1055ui_story == nil then
				arg_289_1.var_.characterEffect1055ui_story = arg_289_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["1055ui_story"]) then
				if arg_289_1.var_.characterEffect1055ui_story and not isNil(arg_289_1.actors_["1055ui_story"]) then
					arg_289_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["1055ui_story"]) and arg_289_1.var_.characterEffect1055ui_story then
				arg_289_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_292_2 = 0
			local var_292_3 = 0.775

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(123112071)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 31 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 31)

				if (31 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 31)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112071", "story_v_out_123112.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112071", "story_v_out_123112.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_out_123112", "123112071", "story_v_out_123112.awb")

						arg_289_1:RecordAudio("123112071", var_292_9)
						arg_289_1:RecordAudio("123112071", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_123112", "123112071", "story_v_out_123112.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_123112", "123112071", "story_v_out_123112.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play123112072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 123112072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play123112073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1055ui_story"]) and arg_293_1.var_.characterEffect1055ui_story == nil then
				arg_293_1.var_.characterEffect1055ui_story = arg_293_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1055ui_story"]) then
				if arg_293_1.var_.characterEffect1055ui_story and not isNil(arg_293_1.actors_["1055ui_story"]) then
					arg_293_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1055ui_story"]) and arg_293_1.var_.characterEffect1055ui_story then
				arg_293_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.825

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(123112072).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 33 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 33)

				if (33 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 33)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play123112073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 123112073
		arg_297_1.duration_ = 7.9

		local var_297_0 = {
			zh = 7.9,
			ja = 6.5
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play123112074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_300_0 = arg_297_1.actors_["1055ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1055ui_story == nil then
				arg_297_1.var_.characterEffect1055ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_1 = 0.2

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 and not isNil(var_300_0) then
				if arg_297_1.var_.characterEffect1055ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1055ui_story then
				arg_297_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_300_3 = 0
			local var_300_4 = 0.675

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_3 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_5 = arg_297_1:GetWordFromCfg(123112073)
				local var_300_6 = arg_297_1:FormatText(var_300_5.content)

				arg_297_1.text_.text = var_300_6

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_8 = 26 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_6) / 26)

				if (26 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_6) / 26)) > 0 and var_300_4 < var_300_8 then
					arg_297_1.talkMaxDuration = var_300_8

					if var_300_8 + var_300_3 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_3
					end
				end

				arg_297_1.text_.text = var_300_6
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112073", "story_v_out_123112.awb") ~= 0 then
					local var_300_9 = manager.audio:GetVoiceLength("story_v_out_123112", "123112073", "story_v_out_123112.awb") / 1000

					if var_300_9 + var_300_3 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_3
					end

					if var_300_5.prefab_name ~= "" and arg_297_1.actors_[var_300_5.prefab_name] ~= nil then
						local var_300_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_5.prefab_name].transform, "story_v_out_123112", "123112073", "story_v_out_123112.awb")

						arg_297_1:RecordAudio("123112073", var_300_10)
						arg_297_1:RecordAudio("123112073", var_300_10)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_123112", "123112073", "story_v_out_123112.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_123112", "123112073", "story_v_out_123112.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_11 = math.max(var_300_4, arg_297_1.talkMaxDuration)

			if var_300_3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_3 + var_300_11 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_3) / var_300_11

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_3 + var_300_11 and arg_297_1.time_ < var_300_3 + var_300_11 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play123112074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 123112074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play123112075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1055ui_story"]) and arg_301_1.var_.characterEffect1055ui_story == nil then
				arg_301_1.var_.characterEffect1055ui_story = arg_301_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1055ui_story"]) then
				if arg_301_1.var_.characterEffect1055ui_story and not isNil(arg_301_1.actors_["1055ui_story"]) then
					arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_0)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1055ui_story"]) and arg_301_1.var_.characterEffect1055ui_story then
				arg_301_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_304_1 = 0
			local var_304_2 = 0.925

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(123112074).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 37 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 37)

				if (37 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 37)) > 0 and var_304_2 < var_304_5 then
					arg_301_1.talkMaxDuration = var_304_5

					if var_304_5 + var_304_1 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + var_304_1
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_6 = math.max(var_304_2, arg_301_1.talkMaxDuration)

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_6 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_1) / var_304_6

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_1 + var_304_6 and arg_301_1.time_ < var_304_1 + var_304_6 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play123112075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 123112075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play123112076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.5

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(123112075).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 20 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 20)

				if (20 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 20)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play123112076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 123112076
		arg_309_1.duration_ = 9.43

		local var_309_0 = {
			zh = 9.433,
			ja = 4.366
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play123112077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1055ui_story"]) and arg_309_1.var_.characterEffect1055ui_story == nil then
				arg_309_1.var_.characterEffect1055ui_story = arg_309_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1055ui_story"]) then
				if arg_309_1.var_.characterEffect1055ui_story and not isNil(arg_309_1.actors_["1055ui_story"]) then
					arg_309_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1055ui_story"]) and arg_309_1.var_.characterEffect1055ui_story then
				arg_309_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action4_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_312_2 = 0
			local var_312_3 = 0.75

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(123112076)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 30 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 30)

				if (30 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 30)) > 0 and var_312_3 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112076", "story_v_out_123112.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112076", "story_v_out_123112.awb") / 1000

					if var_312_8 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_2
					end

					if var_312_4.prefab_name ~= "" and arg_309_1.actors_[var_312_4.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_4.prefab_name].transform, "story_v_out_123112", "123112076", "story_v_out_123112.awb")

						arg_309_1:RecordAudio("123112076", var_312_9)
						arg_309_1:RecordAudio("123112076", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_123112", "123112076", "story_v_out_123112.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_123112", "123112076", "story_v_out_123112.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_10 and arg_309_1.time_ < var_312_2 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play123112077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 123112077
		arg_313_1.duration_ = 18.07

		local var_313_0 = {
			zh = 12.733,
			ja = 18.066
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play123112078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_0 = 0
			local var_316_1 = 1.475

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_2 = arg_313_1:GetWordFromCfg(123112077)
				local var_316_3 = arg_313_1:FormatText(var_316_2.content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 59 <= 0 and var_316_1 or var_316_1 * (utf8.len(var_316_3) / 59)

				if (59 <= 0 and var_316_1 or var_316_1 * (utf8.len(var_316_3) / 59)) > 0 and var_316_1 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112077", "story_v_out_123112.awb") ~= 0 then
					local var_316_6 = manager.audio:GetVoiceLength("story_v_out_123112", "123112077", "story_v_out_123112.awb") / 1000

					if var_316_6 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_0
					end

					if var_316_2.prefab_name ~= "" and arg_313_1.actors_[var_316_2.prefab_name] ~= nil then
						local var_316_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_2.prefab_name].transform, "story_v_out_123112", "123112077", "story_v_out_123112.awb")

						arg_313_1:RecordAudio("123112077", var_316_7)
						arg_313_1:RecordAudio("123112077", var_316_7)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_123112", "123112077", "story_v_out_123112.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_123112", "123112077", "story_v_out_123112.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_8 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_8 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_8

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_8 and arg_313_1.time_ < var_316_0 + var_316_8 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play123112078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 123112078
		arg_317_1.duration_ = 7.57

		local var_317_0 = {
			zh = 3.866,
			ja = 7.566
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play123112079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055actionlink/1055action445")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_0 = 0
			local var_320_1 = 0.45

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(123112078)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 18 <= 0 and var_320_1 or var_320_1 * (utf8.len(var_320_3) / 18)

				if (18 <= 0 and var_320_1 or var_320_1 * (utf8.len(var_320_3) / 18)) > 0 and var_320_1 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112078", "story_v_out_123112.awb") ~= 0 then
					local var_320_6 = manager.audio:GetVoiceLength("story_v_out_123112", "123112078", "story_v_out_123112.awb") / 1000

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end

					if var_320_2.prefab_name ~= "" and arg_317_1.actors_[var_320_2.prefab_name] ~= nil then
						local var_320_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_2.prefab_name].transform, "story_v_out_123112", "123112078", "story_v_out_123112.awb")

						arg_317_1:RecordAudio("123112078", var_320_7)
						arg_317_1:RecordAudio("123112078", var_320_7)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_123112", "123112078", "story_v_out_123112.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_123112", "123112078", "story_v_out_123112.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_8 and arg_317_1.time_ < var_320_0 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play123112079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 123112079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play123112080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1055ui_story"]) and arg_321_1.var_.characterEffect1055ui_story == nil then
				arg_321_1.var_.characterEffect1055ui_story = arg_321_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1055ui_story"]) then
				if arg_321_1.var_.characterEffect1055ui_story and not isNil(arg_321_1.actors_["1055ui_story"]) then
					arg_321_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1055ui_story"]) and arg_321_1.var_.characterEffect1055ui_story then
				arg_321_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_324_1 = 0
			local var_324_2 = 0.25

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(123112079).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 10 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 10)

				if (10 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 10)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play123112080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 123112080
		arg_325_1.duration_ = 17.1

		local var_325_0 = {
			zh = 9.833,
			ja = 17.1
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play123112081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1055ui_story"]) and arg_325_1.var_.characterEffect1055ui_story == nil then
				arg_325_1.var_.characterEffect1055ui_story = arg_325_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1055ui_story"]) then
				if arg_325_1.var_.characterEffect1055ui_story and not isNil(arg_325_1.actors_["1055ui_story"]) then
					arg_325_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1055ui_story"]) and arg_325_1.var_.characterEffect1055ui_story then
				arg_325_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_328_2 = 0
			local var_328_3 = 1.25

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:GetWordFromCfg(123112080)
				local var_328_5 = arg_325_1:FormatText(var_328_4.content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 50 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 50)

				if (50 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 50)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112080", "story_v_out_123112.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112080", "story_v_out_123112.awb") / 1000

					if var_328_8 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_2
					end

					if var_328_4.prefab_name ~= "" and arg_325_1.actors_[var_328_4.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_4.prefab_name].transform, "story_v_out_123112", "123112080", "story_v_out_123112.awb")

						arg_325_1:RecordAudio("123112080", var_328_9)
						arg_325_1:RecordAudio("123112080", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_123112", "123112080", "story_v_out_123112.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_123112", "123112080", "story_v_out_123112.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_10 and arg_325_1.time_ < var_328_2 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play123112081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 123112081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play123112082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1055ui_story"]) and arg_329_1.var_.characterEffect1055ui_story == nil then
				arg_329_1.var_.characterEffect1055ui_story = arg_329_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1055ui_story"]) then
				if arg_329_1.var_.characterEffect1055ui_story and not isNil(arg_329_1.actors_["1055ui_story"]) then
					arg_329_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1055ui_story"]) and arg_329_1.var_.characterEffect1055ui_story then
				arg_329_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 0.2

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(123112081).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 8 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 8)

				if (8 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 8)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play123112082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 123112082
		arg_333_1.duration_ = 2.27

		local var_333_0 = {
			zh = 2.266,
			ja = 1.999999999999
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play123112083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1055ui_story"]) and arg_333_1.var_.characterEffect1055ui_story == nil then
				arg_333_1.var_.characterEffect1055ui_story = arg_333_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1055ui_story"]) then
				if arg_333_1.var_.characterEffect1055ui_story and not isNil(arg_333_1.actors_["1055ui_story"]) then
					arg_333_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1055ui_story"]) and arg_333_1.var_.characterEffect1055ui_story then
				arg_333_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_336_2 = 0
			local var_336_3 = 0.2

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_2 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_4 = arg_333_1:GetWordFromCfg(123112082)
				local var_336_5 = arg_333_1:FormatText(var_336_4.content)

				arg_333_1.text_.text = var_336_5

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_7 = 8 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 8)

				if (8 <= 0 and var_336_3 or var_336_3 * (utf8.len(var_336_5) / 8)) > 0 and var_336_3 < var_336_7 then
					arg_333_1.talkMaxDuration = var_336_7

					if var_336_7 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_7 + var_336_2
					end
				end

				arg_333_1.text_.text = var_336_5
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112082", "story_v_out_123112.awb") ~= 0 then
					local var_336_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112082", "story_v_out_123112.awb") / 1000

					if var_336_8 + var_336_2 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_2
					end

					if var_336_4.prefab_name ~= "" and arg_333_1.actors_[var_336_4.prefab_name] ~= nil then
						local var_336_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_4.prefab_name].transform, "story_v_out_123112", "123112082", "story_v_out_123112.awb")

						arg_333_1:RecordAudio("123112082", var_336_9)
						arg_333_1:RecordAudio("123112082", var_336_9)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_123112", "123112082", "story_v_out_123112.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_123112", "123112082", "story_v_out_123112.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_10 = math.max(var_336_3, arg_333_1.talkMaxDuration)

			if var_336_2 <= arg_333_1.time_ and arg_333_1.time_ < var_336_2 + var_336_10 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_2) / var_336_10

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_2 + var_336_10 and arg_333_1.time_ < var_336_2 + var_336_10 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play123112083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 123112083
		arg_337_1.duration_ = 5.6

		local var_337_0 = {
			zh = 4.366,
			ja = 5.6
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play123112084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055actionlink/1055action452")
			end

			local var_340_0 = arg_337_1.actors_["1055ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1055ui_story == nil then
				arg_337_1.var_.characterEffect1055ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_1 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_1 and not isNil(var_340_0) then
				if arg_337_1.var_.characterEffect1055ui_story and not isNil(var_340_0) then
					arg_337_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_1 and arg_337_1.time_ < 0 + var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1055ui_story then
				arg_337_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			local var_340_3 = 0
			local var_340_4 = 0.575

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_3 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_5 = arg_337_1:GetWordFromCfg(123112083)
				local var_340_6 = arg_337_1:FormatText(var_340_5.content)

				arg_337_1.text_.text = var_340_6

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_8 = 23 <= 0 and var_340_4 or var_340_4 * (utf8.len(var_340_6) / 23)

				if (23 <= 0 and var_340_4 or var_340_4 * (utf8.len(var_340_6) / 23)) > 0 and var_340_4 < var_340_8 then
					arg_337_1.talkMaxDuration = var_340_8

					if var_340_8 + var_340_3 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_3
					end
				end

				arg_337_1.text_.text = var_340_6
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112083", "story_v_out_123112.awb") ~= 0 then
					local var_340_9 = manager.audio:GetVoiceLength("story_v_out_123112", "123112083", "story_v_out_123112.awb") / 1000

					if var_340_9 + var_340_3 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_3
					end

					if var_340_5.prefab_name ~= "" and arg_337_1.actors_[var_340_5.prefab_name] ~= nil then
						local var_340_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_5.prefab_name].transform, "story_v_out_123112", "123112083", "story_v_out_123112.awb")

						arg_337_1:RecordAudio("123112083", var_340_10)
						arg_337_1:RecordAudio("123112083", var_340_10)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_123112", "123112083", "story_v_out_123112.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_123112", "123112083", "story_v_out_123112.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_11 = math.max(var_340_4, arg_337_1.talkMaxDuration)

			if var_340_3 <= arg_337_1.time_ and arg_337_1.time_ < var_340_3 + var_340_11 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_3) / var_340_11

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_3 + var_340_11 and arg_337_1.time_ < var_340_3 + var_340_11 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play123112084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 123112084
		arg_341_1.duration_ = 13.93

		local var_341_0 = {
			zh = 10.566,
			ja = 13.933
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play123112085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 1.55

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:GetWordFromCfg(123112084)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 62 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 62)

				if (62 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 62)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112084", "story_v_out_123112.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_123112", "123112084", "story_v_out_123112.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_123112", "123112084", "story_v_out_123112.awb")

						arg_341_1:RecordAudio("123112084", var_344_6)
						arg_341_1:RecordAudio("123112084", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_123112", "123112084", "story_v_out_123112.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_123112", "123112084", "story_v_out_123112.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play123112085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 123112085
		arg_345_1.duration_ = 14.6

		local var_345_0 = {
			zh = 11.033,
			ja = 14.6
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play123112086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 1.45

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_1 = arg_345_1:GetWordFromCfg(123112085)
				local var_348_2 = arg_345_1:FormatText(var_348_1.content)

				arg_345_1.text_.text = var_348_2

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 58 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 58)

				if (58 <= 0 and var_348_0 or var_348_0 * (utf8.len(var_348_2) / 58)) > 0 and var_348_0 < var_348_4 then
					arg_345_1.talkMaxDuration = var_348_4

					if var_348_4 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_4 + 0
					end
				end

				arg_345_1.text_.text = var_348_2
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112085", "story_v_out_123112.awb") ~= 0 then
					local var_348_5 = manager.audio:GetVoiceLength("story_v_out_123112", "123112085", "story_v_out_123112.awb") / 1000

					if var_348_5 + 0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + 0
					end

					if var_348_1.prefab_name ~= "" and arg_345_1.actors_[var_348_1.prefab_name] ~= nil then
						local var_348_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_1.prefab_name].transform, "story_v_out_123112", "123112085", "story_v_out_123112.awb")

						arg_345_1:RecordAudio("123112085", var_348_6)
						arg_345_1:RecordAudio("123112085", var_348_6)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_123112", "123112085", "story_v_out_123112.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_123112", "123112085", "story_v_out_123112.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_0, arg_345_1.talkMaxDuration)

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - 0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play123112086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 123112086
		arg_349_1.duration_ = 6.9

		local var_349_0 = {
			zh = 6.9,
			ja = 4.933
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play123112087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action2_2")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_0 = 0
			local var_352_1 = 0.575

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_2 = arg_349_1:GetWordFromCfg(123112086)
				local var_352_3 = arg_349_1:FormatText(var_352_2.content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 23 <= 0 and var_352_1 or var_352_1 * (utf8.len(var_352_3) / 23)

				if (23 <= 0 and var_352_1 or var_352_1 * (utf8.len(var_352_3) / 23)) > 0 and var_352_1 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112086", "story_v_out_123112.awb") ~= 0 then
					local var_352_6 = manager.audio:GetVoiceLength("story_v_out_123112", "123112086", "story_v_out_123112.awb") / 1000

					if var_352_6 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_0
					end

					if var_352_2.prefab_name ~= "" and arg_349_1.actors_[var_352_2.prefab_name] ~= nil then
						local var_352_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_2.prefab_name].transform, "story_v_out_123112", "123112086", "story_v_out_123112.awb")

						arg_349_1:RecordAudio("123112086", var_352_7)
						arg_349_1:RecordAudio("123112086", var_352_7)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_123112", "123112086", "story_v_out_123112.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_123112", "123112086", "story_v_out_123112.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_8 and arg_349_1.time_ < var_352_0 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play123112087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 123112087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play123112088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1055ui_story"]) and arg_353_1.var_.characterEffect1055ui_story == nil then
				arg_353_1.var_.characterEffect1055ui_story = arg_353_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1055ui_story"]) then
				if arg_353_1.var_.characterEffect1055ui_story and not isNil(arg_353_1.actors_["1055ui_story"]) then
					arg_353_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1055ui_story"]) and arg_353_1.var_.characterEffect1055ui_story then
				arg_353_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 1.3

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_3 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(123112087).content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 52 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 52)

				if (52 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 52)) > 0 and var_356_2 < var_356_5 then
					arg_353_1.talkMaxDuration = var_356_5

					if var_356_5 + var_356_1 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_5 + var_356_1
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_6 = math.max(var_356_2, arg_353_1.talkMaxDuration)

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_6 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_1) / var_356_6

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_1 + var_356_6 and arg_353_1.time_ < var_356_1 + var_356_6 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play123112088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 123112088
		arg_357_1.duration_ = 9.73

		local var_357_0 = {
			zh = 6.7,
			ja = 9.733
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play123112089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1055ui_story"]) and arg_357_1.var_.characterEffect1055ui_story == nil then
				arg_357_1.var_.characterEffect1055ui_story = arg_357_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1055ui_story"]) then
				if arg_357_1.var_.characterEffect1055ui_story and not isNil(arg_357_1.actors_["1055ui_story"]) then
					arg_357_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1055ui_story"]) and arg_357_1.var_.characterEffect1055ui_story then
				arg_357_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_360_2 = 0
			local var_360_3 = 0.75

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:GetWordFromCfg(123112088)
				local var_360_5 = arg_357_1:FormatText(var_360_4.content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 30 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 30)

				if (30 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_5) / 30)) > 0 and var_360_3 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112088", "story_v_out_123112.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112088", "story_v_out_123112.awb") / 1000

					if var_360_8 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_2
					end

					if var_360_4.prefab_name ~= "" and arg_357_1.actors_[var_360_4.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_4.prefab_name].transform, "story_v_out_123112", "123112088", "story_v_out_123112.awb")

						arg_357_1:RecordAudio("123112088", var_360_9)
						arg_357_1:RecordAudio("123112088", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_123112", "123112088", "story_v_out_123112.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_123112", "123112088", "story_v_out_123112.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_10 and arg_357_1.time_ < var_360_2 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play123112089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 123112089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play123112090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1055ui_story"]) and arg_361_1.var_.characterEffect1055ui_story == nil then
				arg_361_1.var_.characterEffect1055ui_story = arg_361_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1055ui_story"]) then
				if arg_361_1.var_.characterEffect1055ui_story and not isNil(arg_361_1.actors_["1055ui_story"]) then
					arg_361_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1055ui_story"]) and arg_361_1.var_.characterEffect1055ui_story then
				arg_361_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.5

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(123112089).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 20 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 20)

				if (20 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 20)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play123112090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 123112090
		arg_365_1.duration_ = 4.07

		local var_365_0 = {
			zh = 2.566,
			ja = 4.066
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play123112091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1055ui_story"]) and arg_365_1.var_.characterEffect1055ui_story == nil then
				arg_365_1.var_.characterEffect1055ui_story = arg_365_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1055ui_story"]) then
				if arg_365_1.var_.characterEffect1055ui_story and not isNil(arg_365_1.actors_["1055ui_story"]) then
					arg_365_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1055ui_story"]) and arg_365_1.var_.characterEffect1055ui_story then
				arg_365_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_368_2 = 0
			local var_368_3 = 0.35

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:GetWordFromCfg(123112090)
				local var_368_5 = arg_365_1:FormatText(var_368_4.content)

				arg_365_1.text_.text = var_368_5

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_7 = 14 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 14)

				if (14 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_5) / 14)) > 0 and var_368_3 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_5
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112090", "story_v_out_123112.awb") ~= 0 then
					local var_368_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112090", "story_v_out_123112.awb") / 1000

					if var_368_8 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_8 + var_368_2
					end

					if var_368_4.prefab_name ~= "" and arg_365_1.actors_[var_368_4.prefab_name] ~= nil then
						local var_368_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_4.prefab_name].transform, "story_v_out_123112", "123112090", "story_v_out_123112.awb")

						arg_365_1:RecordAudio("123112090", var_368_9)
						arg_365_1:RecordAudio("123112090", var_368_9)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_123112", "123112090", "story_v_out_123112.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_123112", "123112090", "story_v_out_123112.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_10 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_10 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_10

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_10 and arg_365_1.time_ < var_368_2 + var_368_10 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play123112091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 123112091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play123112092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1055ui_story"]) and arg_369_1.var_.characterEffect1055ui_story == nil then
				arg_369_1.var_.characterEffect1055ui_story = arg_369_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1055ui_story"]) then
				if arg_369_1.var_.characterEffect1055ui_story and not isNil(arg_369_1.actors_["1055ui_story"]) then
					arg_369_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1055ui_story"]) and arg_369_1.var_.characterEffect1055ui_story then
				arg_369_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.45

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(123112091).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 18 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 18)

				if (18 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 18)) > 0 and var_372_2 < var_372_5 then
					arg_369_1.talkMaxDuration = var_372_5

					if var_372_5 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_5 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_6 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_6 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_6

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_6 and arg_369_1.time_ < var_372_1 + var_372_6 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play123112092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 123112092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play123112093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_376_0 = 0
			local var_376_1 = 0.75

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_2 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(123112092).content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 30 <= 0 and var_376_1 or var_376_1 * (utf8.len(var_376_2) / 30)

				if (30 <= 0 and var_376_1 or var_376_1 * (utf8.len(var_376_2) / 30)) > 0 and var_376_1 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_5 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_5 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_5

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_5 and arg_373_1.time_ < var_376_0 + var_376_5 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play123112093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 123112093
		arg_377_1.duration_ = 11.73

		local var_377_0 = {
			zh = 11,
			ja = 11.733
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play123112094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["1055ui_story"]) and arg_377_1.var_.characterEffect1055ui_story == nil then
				arg_377_1.var_.characterEffect1055ui_story = arg_377_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["1055ui_story"]) then
				if arg_377_1.var_.characterEffect1055ui_story and not isNil(arg_377_1.actors_["1055ui_story"]) then
					arg_377_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["1055ui_story"]) and arg_377_1.var_.characterEffect1055ui_story then
				arg_377_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action1_1")
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_380_2 = 0
			local var_380_3 = 1.375

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_2 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_4 = arg_377_1:GetWordFromCfg(123112093)
				local var_380_5 = arg_377_1:FormatText(var_380_4.content)

				arg_377_1.text_.text = var_380_5

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_7 = 55 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_5) / 55)

				if (55 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_5) / 55)) > 0 and var_380_3 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_2
					end
				end

				arg_377_1.text_.text = var_380_5
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112093", "story_v_out_123112.awb") ~= 0 then
					local var_380_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112093", "story_v_out_123112.awb") / 1000

					if var_380_8 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_2
					end

					if var_380_4.prefab_name ~= "" and arg_377_1.actors_[var_380_4.prefab_name] ~= nil then
						local var_380_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_4.prefab_name].transform, "story_v_out_123112", "123112093", "story_v_out_123112.awb")

						arg_377_1:RecordAudio("123112093", var_380_9)
						arg_377_1:RecordAudio("123112093", var_380_9)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_123112", "123112093", "story_v_out_123112.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_123112", "123112093", "story_v_out_123112.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_10 = math.max(var_380_3, arg_377_1.talkMaxDuration)

			if var_380_2 <= arg_377_1.time_ and arg_377_1.time_ < var_380_2 + var_380_10 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_2) / var_380_10

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_2 + var_380_10 and arg_377_1.time_ < var_380_2 + var_380_10 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play123112094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 123112094
		arg_381_1.duration_ = 11.9

		local var_381_0 = {
			zh = 5.566,
			ja = 11.9
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play123112095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_384_0 = 0
			local var_384_1 = 0.625

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_2 = arg_381_1:GetWordFromCfg(123112094)
				local var_384_3 = arg_381_1:FormatText(var_384_2.content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 25 <= 0 and var_384_1 or var_384_1 * (utf8.len(var_384_3) / 25)

				if (25 <= 0 and var_384_1 or var_384_1 * (utf8.len(var_384_3) / 25)) > 0 and var_384_1 < var_384_5 then
					arg_381_1.talkMaxDuration = var_384_5

					if var_384_5 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112094", "story_v_out_123112.awb") ~= 0 then
					local var_384_6 = manager.audio:GetVoiceLength("story_v_out_123112", "123112094", "story_v_out_123112.awb") / 1000

					if var_384_6 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_0
					end

					if var_384_2.prefab_name ~= "" and arg_381_1.actors_[var_384_2.prefab_name] ~= nil then
						local var_384_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_2.prefab_name].transform, "story_v_out_123112", "123112094", "story_v_out_123112.awb")

						arg_381_1:RecordAudio("123112094", var_384_7)
						arg_381_1:RecordAudio("123112094", var_384_7)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_123112", "123112094", "story_v_out_123112.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_123112", "123112094", "story_v_out_123112.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_8 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_8 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_8

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_8 and arg_381_1.time_ < var_384_0 + var_384_8 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play123112095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 123112095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play123112096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["1055ui_story"]) and arg_385_1.var_.characterEffect1055ui_story == nil then
				arg_385_1.var_.characterEffect1055ui_story = arg_385_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["1055ui_story"]) then
				if arg_385_1.var_.characterEffect1055ui_story and not isNil(arg_385_1.actors_["1055ui_story"]) then
					arg_385_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_0)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["1055ui_story"]) and arg_385_1.var_.characterEffect1055ui_story then
				arg_385_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_388_1 = 0
			local var_388_2 = 1.2

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(123112095).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 48 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 48)

				if (48 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 48)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play123112096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 123112096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play123112097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.85

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(123112096).content)

				arg_389_1.text_.text = var_392_1

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_3 = 34 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 34)

				if (34 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_1) / 34)) > 0 and var_392_0 < var_392_3 then
					arg_389_1.talkMaxDuration = var_392_3

					if var_392_3 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_3 + 0
					end
				end

				arg_389_1.text_.text = var_392_1
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_4 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_4

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play123112097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 123112097
		arg_393_1.duration_ = 11.5

		local var_393_0 = {
			zh = 10.1,
			ja = 11.5
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play123112098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1055ui_story"]) and arg_393_1.var_.characterEffect1055ui_story == nil then
				arg_393_1.var_.characterEffect1055ui_story = arg_393_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1055ui_story"]) then
				if arg_393_1.var_.characterEffect1055ui_story and not isNil(arg_393_1.actors_["1055ui_story"]) then
					arg_393_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1055ui_story"]) and arg_393_1.var_.characterEffect1055ui_story then
				arg_393_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/story1055/story1055action/1055action7_1")
			end

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_396_2 = 0
			local var_396_3 = 1.15

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_4 = arg_393_1:GetWordFromCfg(123112097)
				local var_396_5 = arg_393_1:FormatText(var_396_4.content)

				arg_393_1.text_.text = var_396_5

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_7 = 46 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 46)

				if (46 <= 0 and var_396_3 or var_396_3 * (utf8.len(var_396_5) / 46)) > 0 and var_396_3 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_5
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112097", "story_v_out_123112.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112097", "story_v_out_123112.awb") / 1000

					if var_396_8 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_2
					end

					if var_396_4.prefab_name ~= "" and arg_393_1.actors_[var_396_4.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_4.prefab_name].transform, "story_v_out_123112", "123112097", "story_v_out_123112.awb")

						arg_393_1:RecordAudio("123112097", var_396_9)
						arg_393_1:RecordAudio("123112097", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_123112", "123112097", "story_v_out_123112.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_123112", "123112097", "story_v_out_123112.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_2 <= arg_393_1.time_ and arg_393_1.time_ < var_396_2 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_2) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_2 + var_396_10 and arg_393_1.time_ < var_396_2 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play123112098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 123112098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play123112099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1055ui_story"]) and arg_397_1.var_.characterEffect1055ui_story == nil then
				arg_397_1.var_.characterEffect1055ui_story = arg_397_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1055ui_story"]) then
				if arg_397_1.var_.characterEffect1055ui_story and not isNil(arg_397_1.actors_["1055ui_story"]) then
					arg_397_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_0)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1055ui_story"]) and arg_397_1.var_.characterEffect1055ui_story then
				arg_397_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_400_1 = 0
			local var_400_2 = 0.2

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_3 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(123112098).content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 8 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 8)

				if (8 <= 0 and var_400_2 or var_400_2 * (utf8.len(var_400_3) / 8)) > 0 and var_400_2 < var_400_5 then
					arg_397_1.talkMaxDuration = var_400_5

					if var_400_5 + var_400_1 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_5 + var_400_1
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_6 = math.max(var_400_2, arg_397_1.talkMaxDuration)

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_6 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_1) / var_400_6

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_1 + var_400_6 and arg_397_1.time_ < var_400_1 + var_400_6 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play123112099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 123112099
		arg_401_1.duration_ = 4.7

		local var_401_0 = {
			zh = 4.7,
			ja = 3.133
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play123112100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1055ui_story"]) and arg_401_1.var_.characterEffect1055ui_story == nil then
				arg_401_1.var_.characterEffect1055ui_story = arg_401_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1055ui_story"]) then
				if arg_401_1.var_.characterEffect1055ui_story and not isNil(arg_401_1.actors_["1055ui_story"]) then
					arg_401_1.var_.characterEffect1055ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1055ui_story"]) and arg_401_1.var_.characterEffect1055ui_story then
				arg_401_1.var_.characterEffect1055ui_story.fillFlat = false
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1055ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_404_2 = 0
			local var_404_3 = 0.575

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[481].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_4 = arg_401_1:GetWordFromCfg(123112099)
				local var_404_5 = arg_401_1:FormatText(var_404_4.content)

				arg_401_1.text_.text = var_404_5

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_7 = 23 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 23)

				if (23 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_5) / 23)) > 0 and var_404_3 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_5
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112099", "story_v_out_123112.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_out_123112", "123112099", "story_v_out_123112.awb") / 1000

					if var_404_8 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_2
					end

					if var_404_4.prefab_name ~= "" and arg_401_1.actors_[var_404_4.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_4.prefab_name].transform, "story_v_out_123112", "123112099", "story_v_out_123112.awb")

						arg_401_1:RecordAudio("123112099", var_404_9)
						arg_401_1:RecordAudio("123112099", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_123112", "123112099", "story_v_out_123112.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_123112", "123112099", "story_v_out_123112.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_10 and arg_401_1.time_ < var_404_2 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play123112100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 123112100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play123112101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["1055ui_story"]) and arg_405_1.var_.characterEffect1055ui_story == nil then
				arg_405_1.var_.characterEffect1055ui_story = arg_405_1.actors_["1055ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["1055ui_story"]) then
				if arg_405_1.var_.characterEffect1055ui_story and not isNil(arg_405_1.actors_["1055ui_story"]) then
					arg_405_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_0)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["1055ui_story"]) and arg_405_1.var_.characterEffect1055ui_story then
				arg_405_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_408_1 = 0
			local var_408_2 = 0.475

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(123112100).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 19 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 19)

				if (19 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 19)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play123112101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 123112101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play123112102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1055ui_story = arg_409_1.actors_["1055ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1055ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1055ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1055ui_story"].transform.position).z)
				arg_409_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1055ui_story"].transform.localEulerAngles = arg_409_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1055ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.actors_["1055ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1055ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1055ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1055ui_story"].transform.position).z)
				arg_409_1.actors_["1055ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1055ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1055ui_story"].transform.localEulerAngles = arg_409_1.actors_["1055ui_story"].transform.localEulerAngles
			end

			local var_412_1 = arg_409_1.actors_["1055ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1055ui_story == nil then
				arg_409_1.var_.characterEffect1055ui_story = var_412_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_2 and not isNil(var_412_1) then
				if arg_409_1.var_.characterEffect1055ui_story and not isNil(var_412_1) then
					arg_409_1.var_.characterEffect1055ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1055ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_2)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_2 and arg_409_1.time_ < 0 + var_412_2 + arg_412_0 and not isNil(var_412_1) and arg_409_1.var_.characterEffect1055ui_story then
				arg_409_1.var_.characterEffect1055ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1055ui_story.fillRatio = 0.5
			end

			local var_412_3 = 0
			local var_412_4 = 0.7

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_3 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_5 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(123112101).content)

				arg_409_1.text_.text = var_412_5

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_7 = 28 <= 0 and var_412_4 or var_412_4 * (utf8.len(var_412_5) / 28)

				if (28 <= 0 and var_412_4 or var_412_4 * (utf8.len(var_412_5) / 28)) > 0 and var_412_4 < var_412_7 then
					arg_409_1.talkMaxDuration = var_412_7

					if var_412_7 + var_412_3 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_3
					end
				end

				arg_409_1.text_.text = var_412_5
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_8 = math.max(var_412_4, arg_409_1.talkMaxDuration)

			if var_412_3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_3 + var_412_8 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_3) / var_412_8

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_3 + var_412_8 and arg_409_1.time_ < var_412_3 + var_412_8 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1055ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play123112102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 123112102
		arg_413_1.duration_ = 6.27

		local var_413_0 = {
			zh = 3.666,
			ja = 6.266
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play123112103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1093ui_story = arg_413_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1093ui_story"].transform.position).z)
				arg_413_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1093ui_story"].transform.localEulerAngles = arg_413_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_413_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1093ui_story"].transform.position).z)
				arg_413_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1093ui_story"].transform.localEulerAngles = arg_413_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["1093ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1093ui_story == nil then
				arg_413_1.var_.characterEffect1093ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect1093ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1093ui_story then
				arg_413_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action2_1")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_416_4 = 0
			local var_416_5 = 0.375

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:GetWordFromCfg(123112102)
				local var_416_7 = arg_413_1:FormatText(var_416_6.content)

				arg_413_1.text_.text = var_416_7

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_9 = 15 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 15)

				if (15 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_7) / 15)) > 0 and var_416_5 < var_416_9 then
					arg_413_1.talkMaxDuration = var_416_9

					if var_416_9 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_9 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_7
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112102", "story_v_out_123112.awb") ~= 0 then
					local var_416_10 = manager.audio:GetVoiceLength("story_v_out_123112", "123112102", "story_v_out_123112.awb") / 1000

					if var_416_10 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_10 + var_416_4
					end

					if var_416_6.prefab_name ~= "" and arg_413_1.actors_[var_416_6.prefab_name] ~= nil then
						local var_416_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_6.prefab_name].transform, "story_v_out_123112", "123112102", "story_v_out_123112.awb")

						arg_413_1:RecordAudio("123112102", var_416_11)
						arg_413_1:RecordAudio("123112102", var_416_11)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_123112", "123112102", "story_v_out_123112.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_123112", "123112102", "story_v_out_123112.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_12 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_12 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_12

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_12 and arg_413_1.time_ < var_416_4 + var_416_12 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
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

		arg_413_1:InitPlayNodeList()
	end,
	Play123112103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 123112103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play123112104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["1093ui_story"]) and arg_417_1.var_.characterEffect1093ui_story == nil then
				arg_417_1.var_.characterEffect1093ui_story = arg_417_1.actors_["1093ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_0 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["1093ui_story"]) then
				if arg_417_1.var_.characterEffect1093ui_story and not isNil(arg_417_1.actors_["1093ui_story"]) then
					arg_417_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_0)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["1093ui_story"]) and arg_417_1.var_.characterEffect1093ui_story then
				arg_417_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_420_1 = 0
			local var_420_2 = 0.875

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_3 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(123112103).content)

				arg_417_1.text_.text = var_420_3

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 35 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 35)

				if (35 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_3) / 35)) > 0 and var_420_2 < var_420_5 then
					arg_417_1.talkMaxDuration = var_420_5

					if var_420_5 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_5 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_3
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_6 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_6 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_6

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_6 and arg_417_1.time_ < var_420_1 + var_420_6 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play123112104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 123112104
		arg_421_1.duration_ = 6.6

		local var_421_0 = {
			zh = 4.633,
			ja = 6.6
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
			arg_421_1.auto_ = false
		end

		function arg_421_1.playNext_(arg_423_0)
			arg_421_1.onStoryFinished_()
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1093ui_story = arg_421_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1093ui_story"].transform.position).z)
				arg_421_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1093ui_story"].transform.localEulerAngles = arg_421_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_421_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1093ui_story"].transform.position).z)
				arg_421_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1093ui_story"].transform.localEulerAngles = arg_421_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_424_1 = 0
			local var_424_2 = 0.45

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[485].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzaa")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:GetWordFromCfg(123112104)
				local var_424_4 = arg_421_1:FormatText(var_424_3.content)

				arg_421_1.text_.text = var_424_4

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_6 = 18 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_4) / 18)

				if (18 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_4) / 18)) > 0 and var_424_2 < var_424_6 then
					arg_421_1.talkMaxDuration = var_424_6

					if var_424_6 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_6 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_4
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_123112", "123112104", "story_v_out_123112.awb") ~= 0 then
					local var_424_7 = manager.audio:GetVoiceLength("story_v_out_123112", "123112104", "story_v_out_123112.awb") / 1000

					if var_424_7 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_1
					end

					if var_424_3.prefab_name ~= "" and arg_421_1.actors_[var_424_3.prefab_name] ~= nil then
						local var_424_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_3.prefab_name].transform, "story_v_out_123112", "123112104", "story_v_out_123112.awb")

						arg_421_1:RecordAudio("123112104", var_424_8)
						arg_421_1:RecordAudio("123112104", var_424_8)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_123112", "123112104", "story_v_out_123112.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_123112", "123112104", "story_v_out_123112.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_9 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_9 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_9

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_9 and arg_421_1.time_ < var_424_1 + var_424_9 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
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

		arg_421_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K06g",
		"TextureConfig/Background/K05g"
	},
	voices = {
		"story_v_out_123112.awb"
	}
}
