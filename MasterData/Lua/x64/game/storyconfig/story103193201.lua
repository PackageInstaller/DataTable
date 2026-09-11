return {
	Play319321001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319321001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319321002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I12f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I12f")
				var_4_0.name = "I12f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I12f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I12f

				arg_1_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I12f" then
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock")

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
			local var_4_15 = 1.15

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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319321001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 46 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 46)

				if (46 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 46)) > 0 and var_4_15 < var_4_19 then
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
	Play319321002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319321002
		arg_9_1.duration_ = 9.07

		local var_9_0 = {
			zh = 5.033,
			ja = 9.066
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
				arg_9_0:Play319321003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "4040ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["4040ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["4040ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["4040ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["4040ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["4040ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos4040ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["4040ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect4040ui_story == nil then
				arg_9_1.var_.characterEffect4040ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect4040ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect4040ui_story then
				arg_9_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = 0
			local var_12_9 = 0.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(319321002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 22 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 22)

				if (22 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 22)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321002", "story_v_out_319321.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_319321", "319321002", "story_v_out_319321.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_319321", "319321002", "story_v_out_319321.awb")

						arg_9_1:RecordAudio("319321002", var_12_15)
						arg_9_1:RecordAudio("319321002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319321", "319321002", "story_v_out_319321.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319321", "319321002", "story_v_out_319321.awb")
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
				actorName = "4040ui_story",
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
	Play319321003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319321003
		arg_13_1.duration_ = 1.27

		local var_13_0 = {
			zh = 1.233,
			ja = 1.266
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319321004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["4040ui_story"]) and arg_13_1.var_.characterEffect4040ui_story == nil then
				arg_13_1.var_.characterEffect4040ui_story = arg_13_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["4040ui_story"]) then
				if arg_13_1.var_.characterEffect4040ui_story and not isNil(arg_13_1.actors_["4040ui_story"]) then
					arg_13_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_13_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["4040ui_story"]) and arg_13_1.var_.characterEffect4040ui_story then
				arg_13_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_13_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.05

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(319321003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 2 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 2)

				if (2 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_4) / 2)) > 0 and var_16_2 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321003", "story_v_out_319321.awb") ~= 0 then
					local var_16_7 = manager.audio:GetVoiceLength("story_v_out_319321", "319321003", "story_v_out_319321.awb") / 1000

					if var_16_7 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_1
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_319321", "319321003", "story_v_out_319321.awb")

						arg_13_1:RecordAudio("319321003", var_16_8)
						arg_13_1:RecordAudio("319321003", var_16_8)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319321", "319321003", "story_v_out_319321.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319321", "319321003", "story_v_out_319321.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_9 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_9 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_9

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_9 and arg_13_1.time_ < var_16_1 + var_16_9 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319321004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319321004
		arg_17_1.duration_ = 6.87

		local var_17_0 = {
			zh = 4.333,
			ja = 6.866
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
				arg_17_0:Play319321005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["4040ui_story"]) and arg_17_1.var_.characterEffect4040ui_story == nil then
				arg_17_1.var_.characterEffect4040ui_story = arg_17_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["4040ui_story"]) then
				if arg_17_1.var_.characterEffect4040ui_story and not isNil(arg_17_1.actors_["4040ui_story"]) then
					arg_17_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["4040ui_story"]) and arg_17_1.var_.characterEffect4040ui_story then
				arg_17_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_2 = 0
			local var_20_3 = 0.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(319321004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 18 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 18)

				if (18 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 18)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321004", "story_v_out_319321.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_319321", "319321004", "story_v_out_319321.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_319321", "319321004", "story_v_out_319321.awb")

						arg_17_1:RecordAudio("319321004", var_20_9)
						arg_17_1:RecordAudio("319321004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319321", "319321004", "story_v_out_319321.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319321", "319321004", "story_v_out_319321.awb")
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
	Play319321005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319321005
		arg_21_1.duration_ = 8.23

		local var_21_0 = {
			zh = 7.466,
			ja = 8.233
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
				arg_21_0:Play319321006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["4040ui_story"]) and arg_21_1.var_.characterEffect4040ui_story == nil then
				arg_21_1.var_.characterEffect4040ui_story = arg_21_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["4040ui_story"]) then
				if arg_21_1.var_.characterEffect4040ui_story and not isNil(arg_21_1.actors_["4040ui_story"]) then
					arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["4040ui_story"]) and arg_21_1.var_.characterEffect4040ui_story then
				arg_21_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_24_2 = 0
			local var_24_3 = 0.925

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(319321005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 37 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 37)

				if (37 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 37)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321005", "story_v_out_319321.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_319321", "319321005", "story_v_out_319321.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_319321", "319321005", "story_v_out_319321.awb")

						arg_21_1:RecordAudio("319321005", var_24_9)
						arg_21_1:RecordAudio("319321005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319321", "319321005", "story_v_out_319321.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319321", "319321005", "story_v_out_319321.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319321006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319321006
		arg_25_1.duration_ = 3.33

		local var_25_0 = {
			zh = 3.333,
			ja = 3.133
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
				arg_25_0:Play319321007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "10079ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["10079ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["10079ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["10079ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["10079ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10079ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["10079ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect10079ui_story == nil then
				arg_25_1.var_.characterEffect10079ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect10079ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect10079ui_story then
				arg_25_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_8 = arg_25_1.actors_["4040ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos4040ui_story = var_28_8.localPosition
			end

			local var_28_9 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 then
				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_25_1.time_ - 0) / var_28_9)
				var_28_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_8.position).x, (manager.ui.mainCamera.transform.position - var_28_8.position).y, (manager.ui.mainCamera.transform.position - var_28_8.position).z)
				var_28_8.localEulerAngles.z = 0
				var_28_8.localEulerAngles.x = 0
				var_28_8.localEulerAngles = var_28_8.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_9 and arg_25_1.time_ < 0 + var_28_9 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_28_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_8.position).x, (manager.ui.mainCamera.transform.position - var_28_8.position).y, (manager.ui.mainCamera.transform.position - var_28_8.position).z)
				var_28_8.localEulerAngles.z = 0
				var_28_8.localEulerAngles.x = 0
				var_28_8.localEulerAngles = var_28_8.localEulerAngles
			end

			local var_28_10 = arg_25_1.actors_["4040ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect4040ui_story == nil then
				arg_25_1.var_.characterEffect4040ui_story = var_28_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_11 and not isNil(var_28_10) then
				if arg_25_1.var_.characterEffect4040ui_story and not isNil(var_28_10) then
					arg_25_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_25_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_11)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_11 and arg_25_1.time_ < 0 + var_28_11 + arg_28_0 and not isNil(var_28_10) and arg_25_1.var_.characterEffect4040ui_story then
				arg_25_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_25_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_28_12 = 0
			local var_28_13 = 0.05

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_14 = arg_25_1:GetWordFromCfg(319321006)
				local var_28_15 = arg_25_1:FormatText(var_28_14.content)

				arg_25_1.text_.text = var_28_15

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 2 <= 0 and var_28_13 or var_28_13 * (utf8.len(var_28_15) / 2)

				if (2 <= 0 and var_28_13 or var_28_13 * (utf8.len(var_28_15) / 2)) > 0 and var_28_13 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_15
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321006", "story_v_out_319321.awb") ~= 0 then
					local var_28_18 = manager.audio:GetVoiceLength("story_v_out_319321", "319321006", "story_v_out_319321.awb") / 1000

					if var_28_18 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_12
					end

					if var_28_14.prefab_name ~= "" and arg_25_1.actors_[var_28_14.prefab_name] ~= nil then
						local var_28_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_14.prefab_name].transform, "story_v_out_319321", "319321006", "story_v_out_319321.awb")

						arg_25_1:RecordAudio("319321006", var_28_19)
						arg_25_1:RecordAudio("319321006", var_28_19)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319321", "319321006", "story_v_out_319321.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319321", "319321006", "story_v_out_319321.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_20 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_20 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_20

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_20 and arg_25_1.time_ < var_28_12 + var_28_20 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319321007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319321007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319321008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10079ui_story"]) and arg_29_1.var_.characterEffect10079ui_story == nil then
				arg_29_1.var_.characterEffect10079ui_story = arg_29_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10079ui_story"]) then
				if arg_29_1.var_.characterEffect10079ui_story and not isNil(arg_29_1.actors_["10079ui_story"]) then
					arg_29_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10079ui_story"]) and arg_29_1.var_.characterEffect10079ui_story then
				arg_29_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 1

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319321007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 40 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 40)

				if (40 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 40)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319321008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319321008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319321009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.85

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

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(319321008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 34 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 34)

				if (34 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 34)) > 0 and var_36_0 < var_36_3 then
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
	Play319321009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319321009
		arg_37_1.duration_ = 4.7

		local var_37_0 = {
			zh = 4.7,
			ja = 2.4
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
				arg_37_0:Play319321010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["4040ui_story"]) and arg_37_1.var_.characterEffect4040ui_story == nil then
				arg_37_1.var_.characterEffect4040ui_story = arg_37_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["4040ui_story"]) then
				if arg_37_1.var_.characterEffect4040ui_story and not isNil(arg_37_1.actors_["4040ui_story"]) then
					arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["4040ui_story"]) and arg_37_1.var_.characterEffect4040ui_story then
				arg_37_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_40_2 = 0
			local var_40_3 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(319321009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 19 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 19)

				if (19 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 19)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321009", "story_v_out_319321.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_319321", "319321009", "story_v_out_319321.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_319321", "319321009", "story_v_out_319321.awb")

						arg_37_1:RecordAudio("319321009", var_40_9)
						arg_37_1:RecordAudio("319321009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319321", "319321009", "story_v_out_319321.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319321", "319321009", "story_v_out_319321.awb")
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
	Play319321010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319321010
		arg_41_1.duration_ = 3.5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play319321011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 4.44089209850063e-16 < arg_41_1.time_ and arg_41_1.time_ <= 4.44089209850063e-16 + arg_44_0 then
				arg_41_1.var_.moveOldPos4040ui_story = arg_41_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 4.44089209850063e-16 <= arg_41_1.time_ and arg_41_1.time_ < 4.44089209850063e-16 + var_44_0 then
				arg_41_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 4.44089209850063e-16) / var_44_0)
				arg_41_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).z)
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles = arg_41_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 4.44089209850063e-16 + var_44_0 and arg_41_1.time_ < 4.44089209850063e-16 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["4040ui_story"].transform.position).z)
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["4040ui_story"].transform.localEulerAngles = arg_41_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_44_1 = "STblack"

			if arg_41_1.bgs_.STblack == nil then
				local var_44_2 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_44_1)
				var_44_2.name = var_44_1
				var_44_2.transform.parent = arg_41_1.stage_.transform
				var_44_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_[var_44_1] = var_44_2
			end

			if 4.44089209850063e-16 < arg_41_1.time_ and arg_41_1.time_ <= 4.44089209850063e-16 + arg_44_0 then
				local var_44_3 = arg_41_1.bgs_.STblack

				arg_41_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_4 = var_44_3:GetComponent("SpriteRenderer")

				if var_44_4 and var_44_4.sprite then
					local var_44_5 = 2 * (var_44_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_3.transform.localScale = Vector3.New(var_44_5 / var_44_4.sprite.bounds.size.y < var_44_5 * manager.ui.mainCameraCom_.aspect / var_44_4.sprite.bounds.size.x and var_44_5 * manager.ui.mainCameraCom_.aspect / var_44_4.sprite.bounds.size.x or var_44_5 / var_44_4.sprite.bounds.size.y, var_44_5 / var_44_4.sprite.bounds.size.y < var_44_5 * manager.ui.mainCameraCom_.aspect / var_44_4.sprite.bounds.size.x and var_44_5 * manager.ui.mainCameraCom_.aspect / var_44_4.sprite.bounds.size.x or var_44_5 / var_44_4.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "STblack" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_6 = arg_41_1.actors_["10079ui_story"].transform

			if 4.44089209850063e-16 < arg_41_1.time_ and arg_41_1.time_ <= 4.44089209850063e-16 + arg_44_0 then
				arg_41_1.var_.moveOldPos10079ui_story = var_44_6.localPosition
			end

			local var_44_7 = 0.001

			if 4.44089209850063e-16 <= arg_41_1.time_ and arg_41_1.time_ < 4.44089209850063e-16 + var_44_7 then
				var_44_6.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 4.44089209850063e-16) / var_44_7)
				var_44_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_6.position).x, (manager.ui.mainCamera.transform.position - var_44_6.position).y, (manager.ui.mainCamera.transform.position - var_44_6.position).z)
				var_44_6.localEulerAngles.z = 0
				var_44_6.localEulerAngles.x = 0
				var_44_6.localEulerAngles = var_44_6.localEulerAngles
			end

			if arg_41_1.time_ >= 4.44089209850063e-16 + var_44_7 and arg_41_1.time_ < 4.44089209850063e-16 + var_44_7 + arg_44_0 then
				var_44_6.localPosition = Vector3.New(0, 100, 0)
				var_44_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_6.position).x, (manager.ui.mainCamera.transform.position - var_44_6.position).y, (manager.ui.mainCamera.transform.position - var_44_6.position).z)
				var_44_6.localEulerAngles.z = 0
				var_44_6.localEulerAngles.x = 0
				var_44_6.localEulerAngles = var_44_6.localEulerAngles
			end

			if 4.44089209850063e-16 < arg_41_1.time_ and arg_41_1.time_ <= 4.44089209850063e-16 + arg_44_0 then
				arg_41_1.cswbg_:SetActive(true)

				local var_44_8 = arg_41_1.cswt_:GetComponent("RectTransform")

				arg_41_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_44_8.offsetMin = Vector2.New(410, 330)
				var_44_8.offsetMax = Vector2.New(-400, -175)
				arg_41_1.cswt_.text = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(419007).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.cswt_)

				arg_41_1.cswt_.fontSize = 180
				arg_41_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_41_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_41_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.fswbg_:SetActive(true)
				arg_41_1.dialog_:SetActive(false)

				arg_41_1.fswtw_.percent = 0
				arg_41_1.fswt_.text = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(319321010).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.fswt_)

				arg_41_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_41_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_41_1.fswtw_:SetDirty()

				arg_41_1.typewritterCharCountI18N = 0

				SetActive(arg_41_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_41_1:ShowNextGo(false)
			end

			local var_44_9 = 0.333333333333333

			if 0.333333333333333 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.oldValueTypewriter = arg_41_1.fswtw_.percent

				SetActive(arg_41_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_41_1:ShowNextGo(false)
			end

			local var_44_10 = 6
			local var_44_11 = 0.4
			local var_44_12, var_44_13 = arg_41_1:GetPercentByPara(arg_41_1:FormatText(arg_41_1:GetWordFromCfg(319321010).content), 1)

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				local var_44_14 = var_44_10 <= 0 and var_44_11 or var_44_11 * ((var_44_13 - arg_41_1.typewritterCharCountI18N) / var_44_10)

				if (var_44_10 <= 0 and var_44_11 or var_44_11 * ((var_44_13 - arg_41_1.typewritterCharCountI18N) / var_44_10)) > 0 and var_44_11 < var_44_14 then
					arg_41_1.talkMaxDuration = var_44_14

					if var_44_14 + var_44_9 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_9
					end
				end
			end

			local var_44_15 = math.max(0.4, arg_41_1.talkMaxDuration)

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_15 then
				arg_41_1.fswtw_.percent = Mathf.Lerp(arg_41_1.var_.oldValueTypewriter, var_44_12, (arg_41_1.time_ - var_44_9) / var_44_15)
				arg_41_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_41_1.fswtw_:SetDirty()
			end

			if arg_41_1.time_ >= var_44_9 + var_44_15 and arg_41_1.time_ < var_44_9 + var_44_15 + arg_44_0 then
				arg_41_1.fswtw_.percent = var_44_12

				arg_41_1.fswtw_:SetDirty()
				arg_41_1:ShowNextGo(true)

				arg_41_1.typewritterCharCountI18N = var_44_13
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_16 = arg_41_1.fswbg_.transform:Find("textbox/adapt/content") or arg_41_1.fswbg_.transform:Find("textbox/content")
				local var_44_17 = arg_41_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_44_18 = var_44_16:GetComponent("RectTransform")

				var_44_16:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_44_18.offsetMin = Vector2.New(0, 0)
				var_44_18.offsetMax = Vector2.New(0, 0)
			end

			local var_44_19 = 0.333333333333333
			local var_44_20 = manager.audio:GetVoiceLength("story_v_out_319321", "319321010", "story_v_out_319321.awb") / 1000

			if var_44_20 > 0 and 3.166 < var_44_20 and var_44_20 + var_44_19 > arg_41_1.duration_ then
				arg_41_1.duration_ = var_44_20 + var_44_19
			end

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1:AudioAction("play", "voice", "story_v_out_319321", "319321010", "story_v_out_319321.awb")
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.44089209850063e-16,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.44089209850063e-16,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play319321011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319321011
		arg_45_1.duration_ = 3.87

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play319321012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.fswbg_:SetActive(true)
				arg_45_1.dialog_:SetActive(false)

				arg_45_1.fswtw_.percent = 0
				arg_45_1.fswt_.text = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(319321011).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.fswt_)

				arg_45_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_45_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_45_1.fswtw_:SetDirty()

				arg_45_1.typewritterCharCountI18N = 0

				SetActive(arg_45_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_45_1:ShowNextGo(false)
			end

			local var_48_0 = 0.166666666666667

			if 0.166666666666667 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.var_.oldValueTypewriter = arg_45_1.fswtw_.percent

				SetActive(arg_45_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_45_1:ShowNextGo(false)
			end

			local var_48_1 = 18
			local var_48_2 = 1.2
			local var_48_3, var_48_4 = arg_45_1:GetPercentByPara(arg_45_1:FormatText(arg_45_1:GetWordFromCfg(319321011).content), 1)

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				local var_48_5 = var_48_1 <= 0 and var_48_2 or var_48_2 * ((var_48_4 - arg_45_1.typewritterCharCountI18N) / var_48_1)

				if (var_48_1 <= 0 and var_48_2 or var_48_2 * ((var_48_4 - arg_45_1.typewritterCharCountI18N) / var_48_1)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end
			end

			local var_48_6 = math.max(1.2, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_6 then
				arg_45_1.fswtw_.percent = Mathf.Lerp(arg_45_1.var_.oldValueTypewriter, var_48_3, (arg_45_1.time_ - var_48_0) / var_48_6)
				arg_45_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_45_1.fswtw_:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_6 and arg_45_1.time_ < var_48_0 + var_48_6 + arg_48_0 then
				arg_45_1.fswtw_.percent = var_48_3

				arg_45_1.fswtw_:SetDirty()
				arg_45_1:ShowNextGo(true)

				arg_45_1.typewritterCharCountI18N = var_48_4
			end

			local var_48_7 = 0.166666666666667
			local var_48_8 = manager.audio:GetVoiceLength("story_v_out_319321", "319321011", "story_v_out_319321.awb") / 1000

			if var_48_8 > 0 and 3.7 < var_48_8 and var_48_8 + var_48_7 > arg_45_1.duration_ then
				arg_45_1.duration_ = var_48_8 + var_48_7
			end

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1:AudioAction("play", "voice", "story_v_out_319321", "319321011", "story_v_out_319321.awb")
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319321012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319321012
		arg_49_1.duration_ = 7.43

		local var_49_0 = {
			zh = 5.3,
			ja = 7.433
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
				arg_49_0:Play319321013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				local var_52_0 = arg_49_1.bgs_.I12f

				arg_49_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_1 = var_52_0:GetComponent("SpriteRenderer")

				if var_52_1 and var_52_1.sprite then
					local var_52_2 = 2 * (var_52_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_0.transform.localScale = Vector3.New(var_52_2 / var_52_1.sprite.bounds.size.y < var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x and var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x or var_52_2 / var_52_1.sprite.bounds.size.y, var_52_2 / var_52_1.sprite.bounds.size.y < var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x and var_52_2 * manager.ui.mainCameraCom_.aspect / var_52_1.sprite.bounds.size.x or var_52_2 / var_52_1.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "I12f" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_3 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_4 = 2

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_4 then
				local var_52_5 = Color.New(0, 0, 0)

				var_52_5.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_3) / var_52_4)
				arg_49_1.mask_.color = var_52_5
			end

			if arg_49_1.time_ >= var_52_3 + var_52_4 and arg_49_1.time_ < var_52_3 + var_52_4 + arg_52_0 then
				local var_52_6 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_6.a = 0
				arg_49_1.mask_.color = var_52_6
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.cswbg_:SetActive(false)
			end

			if 0.0340000018477435 < arg_49_1.time_ and arg_49_1.time_ <= 0.0340000018477435 + arg_52_0 then
				arg_49_1.fswbg_:SetActive(false)
				arg_49_1.dialog_:SetActive(false)
				SetActive(arg_49_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_49_1:ShowNextGo(false)
			end

			if 0.200666668514411 < arg_49_1.time_ and arg_49_1.time_ <= 0.200666668514411 + arg_52_0 then
				arg_49_1.fswbg_:SetActive(false)
				arg_49_1.dialog_:SetActive(false)
				SetActive(arg_49_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_49_1:ShowNextGo(false)
			end

			local var_52_7 = arg_49_1.actors_["10079ui_story"].transform

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				arg_49_1.var_.moveOldPos10079ui_story = var_52_7.localPosition
			end

			local var_52_8 = 0.001

			if 2 <= arg_49_1.time_ and arg_49_1.time_ < 2 + var_52_8 then
				var_52_7.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_49_1.time_ - 2) / var_52_8)
				var_52_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_7.position).x, (manager.ui.mainCamera.transform.position - var_52_7.position).y, (manager.ui.mainCamera.transform.position - var_52_7.position).z)
				var_52_7.localEulerAngles.z = 0
				var_52_7.localEulerAngles.x = 0
				var_52_7.localEulerAngles = var_52_7.localEulerAngles
			end

			if arg_49_1.time_ >= 2 + var_52_8 and arg_49_1.time_ < 2 + var_52_8 + arg_52_0 then
				var_52_7.localPosition = Vector3.New(0, -0.95, -6.05)
				var_52_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_7.position).x, (manager.ui.mainCamera.transform.position - var_52_7.position).y, (manager.ui.mainCamera.transform.position - var_52_7.position).z)
				var_52_7.localEulerAngles.z = 0
				var_52_7.localEulerAngles.x = 0
				var_52_7.localEulerAngles = var_52_7.localEulerAngles
			end

			local var_52_9 = arg_49_1.actors_["10079ui_story"]

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10079ui_story == nil then
				arg_49_1.var_.characterEffect10079ui_story = var_52_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_10 = 0.200000002980232

			if 2 <= arg_49_1.time_ and arg_49_1.time_ < 2 + var_52_10 and not isNil(var_52_9) then
				if arg_49_1.var_.characterEffect10079ui_story and not isNil(var_52_9) then
					arg_49_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 2 + var_52_10 and arg_49_1.time_ < 2 + var_52_10 + arg_52_0 and not isNil(var_52_9) and arg_49_1.var_.characterEffect10079ui_story then
				arg_49_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				arg_49_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				arg_49_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_12 = 2
			local var_52_13 = 0.15

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_14 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_14:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(319321012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_18 = 6 <= 0 and var_52_13 or var_52_13 * (utf8.len(var_52_16) / 6)

				if (6 <= 0 and var_52_13 or var_52_13 * (utf8.len(var_52_16) / 6)) > 0 and var_52_13 < var_52_18 then
					arg_49_1.talkMaxDuration = var_52_18
					var_52_12 = var_52_12 + 0.3

					if var_52_18 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321012", "story_v_out_319321.awb") ~= 0 then
					local var_52_19 = manager.audio:GetVoiceLength("story_v_out_319321", "319321012", "story_v_out_319321.awb") / 1000

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_319321", "319321012", "story_v_out_319321.awb")

						arg_49_1:RecordAudio("319321012", var_52_20)
						arg_49_1:RecordAudio("319321012", var_52_20)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319321", "319321012", "story_v_out_319321.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319321", "319321012", "story_v_out_319321.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_21 = var_52_12 + 0.3
			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_21) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_21 + var_52_22 and arg_49_1.time_ < var_52_21 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play319321013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319321013
		arg_55_1.duration_ = 10.1

		local var_55_0 = {
			zh = 3.166,
			ja = 10.1
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
				arg_55_0:Play319321014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["10079ui_story"]) and arg_55_1.var_.characterEffect10079ui_story == nil then
				arg_55_1.var_.characterEffect10079ui_story = arg_55_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["10079ui_story"]) then
				if arg_55_1.var_.characterEffect10079ui_story and not isNil(arg_55_1.actors_["10079ui_story"]) then
					arg_55_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["10079ui_story"]) and arg_55_1.var_.characterEffect10079ui_story then
				arg_55_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_58_1 = arg_55_1.actors_["4040ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect4040ui_story == nil then
				arg_55_1.var_.characterEffect4040ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect4040ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect4040ui_story then
				arg_55_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["4040ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos4040ui_story = var_58_4.localPosition
			end

			local var_58_5 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 then
				var_58_4.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_55_1.time_ - 0) / var_58_5)
				var_58_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_4.position).x, (manager.ui.mainCamera.transform.position - var_58_4.position).y, (manager.ui.mainCamera.transform.position - var_58_4.position).z)
				var_58_4.localEulerAngles.z = 0
				var_58_4.localEulerAngles.x = 0
				var_58_4.localEulerAngles = var_58_4.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 then
				var_58_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_58_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_4.position).x, (manager.ui.mainCamera.transform.position - var_58_4.position).y, (manager.ui.mainCamera.transform.position - var_58_4.position).z)
				var_58_4.localEulerAngles.z = 0
				var_58_4.localEulerAngles.x = 0
				var_58_4.localEulerAngles = var_58_4.localEulerAngles
			end

			local var_58_6 = arg_55_1.actors_["10079ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10079ui_story = var_58_6.localPosition
			end

			local var_58_7 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				var_58_6.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_55_1.time_ - 0) / var_58_7)
				var_58_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_6.position).x, (manager.ui.mainCamera.transform.position - var_58_6.position).y, (manager.ui.mainCamera.transform.position - var_58_6.position).z)
				var_58_6.localEulerAngles.z = 0
				var_58_6.localEulerAngles.x = 0
				var_58_6.localEulerAngles = var_58_6.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				var_58_6.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_58_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_6.position).x, (manager.ui.mainCamera.transform.position - var_58_6.position).y, (manager.ui.mainCamera.transform.position - var_58_6.position).z)
				var_58_6.localEulerAngles.z = 0
				var_58_6.localEulerAngles.x = 0
				var_58_6.localEulerAngles = var_58_6.localEulerAngles
			end

			local var_58_8 = 0
			local var_58_9 = 0.325

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(319321013)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 13 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 13)

				if (13 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 13)) > 0 and var_58_9 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321013", "story_v_out_319321.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_out_319321", "319321013", "story_v_out_319321.awb") / 1000

					if var_58_14 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_8
					end

					if var_58_10.prefab_name ~= "" and arg_55_1.actors_[var_58_10.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_10.prefab_name].transform, "story_v_out_319321", "319321013", "story_v_out_319321.awb")

						arg_55_1:RecordAudio("319321013", var_58_15)
						arg_55_1:RecordAudio("319321013", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319321", "319321013", "story_v_out_319321.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319321", "319321013", "story_v_out_319321.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_16 and arg_55_1.time_ < var_58_8 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319321014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319321014
		arg_59_1.duration_ = 7.93

		local var_59_0 = {
			zh = 5.433,
			ja = 7.933
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319321015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos4040ui_story = arg_59_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).z)
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles = arg_59_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_59_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["4040ui_story"].transform.position).z)
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["4040ui_story"].transform.localEulerAngles = arg_59_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["4040ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect4040ui_story == nil then
				arg_59_1.var_.characterEffect4040ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect4040ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect4040ui_story then
				arg_59_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = 0
			local var_62_5 = 0.55

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(319321014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 22 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 22)

				if (22 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 22)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321014", "story_v_out_319321.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321014", "story_v_out_319321.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_319321", "319321014", "story_v_out_319321.awb")

						arg_59_1:RecordAudio("319321014", var_62_11)
						arg_59_1:RecordAudio("319321014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319321", "319321014", "story_v_out_319321.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319321", "319321014", "story_v_out_319321.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play319321015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319321015
		arg_63_1.duration_ = 2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319321016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 4.44089209850063e-16 < arg_63_1.time_ and arg_63_1.time_ <= 4.44089209850063e-16 + arg_66_0 then
				local var_66_0 = arg_63_1.bgs_.STblack

				arg_63_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_66_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_66_1 = var_66_0:GetComponent("SpriteRenderer")

				if var_66_1 and var_66_1.sprite then
					local var_66_2 = 2 * (var_66_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_66_0.transform.localScale = Vector3.New(var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, var_66_2 / var_66_1.sprite.bounds.size.y < var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x and var_66_2 * manager.ui.mainCameraCom_.aspect / var_66_1.sprite.bounds.size.x or var_66_2 / var_66_1.sprite.bounds.size.y, 0)
				end

				for iter_66_0, iter_66_1 in pairs(arg_63_1.bgs_) do
					if iter_66_0 ~= "STblack" then
						iter_66_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_66_3 = arg_63_1.actors_["10079ui_story"].transform

			if 4.44089209850063e-16 < arg_63_1.time_ and arg_63_1.time_ <= 4.44089209850063e-16 + arg_66_0 then
				arg_63_1.var_.moveOldPos10079ui_story = var_66_3.localPosition
			end

			local var_66_4 = 0.001

			if 4.44089209850063e-16 <= arg_63_1.time_ and arg_63_1.time_ < 4.44089209850063e-16 + var_66_4 then
				var_66_3.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 4.44089209850063e-16) / var_66_4)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if arg_63_1.time_ >= 4.44089209850063e-16 + var_66_4 and arg_63_1.time_ < 4.44089209850063e-16 + var_66_4 + arg_66_0 then
				var_66_3.localPosition = Vector3.New(0, 100, 0)
				var_66_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_3.position).x, (manager.ui.mainCamera.transform.position - var_66_3.position).y, (manager.ui.mainCamera.transform.position - var_66_3.position).z)
				var_66_3.localEulerAngles.z = 0
				var_66_3.localEulerAngles.x = 0
				var_66_3.localEulerAngles = var_66_3.localEulerAngles
			end

			if 4.44089209850063e-16 < arg_63_1.time_ and arg_63_1.time_ <= 4.44089209850063e-16 + arg_66_0 then
				arg_63_1.cswbg_:SetActive(true)

				local var_66_5 = arg_63_1.cswt_:GetComponent("RectTransform")

				arg_63_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_66_5.offsetMin = Vector2.New(410, 330)
				var_66_5.offsetMax = Vector2.New(-400, -175)
				arg_63_1.cswt_.text = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(419008).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.cswt_)

				arg_63_1.cswt_.fontSize = 180
				arg_63_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_63_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_63_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.fswbg_:SetActive(true)
				arg_63_1.dialog_:SetActive(false)

				arg_63_1.fswtw_.percent = 0
				arg_63_1.fswt_.text = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(319321015).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.fswt_)

				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_63_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_63_1.fswtw_:SetDirty()

				arg_63_1.typewritterCharCountI18N = 0

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_6 = 0.366666666666667

			if 0.366666666666667 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.var_.oldValueTypewriter = arg_63_1.fswtw_.percent

				SetActive(arg_63_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_63_1:ShowNextGo(false)
			end

			local var_66_7 = 6
			local var_66_8 = 0.4
			local var_66_9, var_66_10 = arg_63_1:GetPercentByPara(arg_63_1:FormatText(arg_63_1:GetWordFromCfg(319321015).content), 1)

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				local var_66_11 = var_66_7 <= 0 and var_66_8 or var_66_8 * ((var_66_10 - arg_63_1.typewritterCharCountI18N) / var_66_7)

				if (var_66_7 <= 0 and var_66_8 or var_66_8 * ((var_66_10 - arg_63_1.typewritterCharCountI18N) / var_66_7)) > 0 and var_66_8 < var_66_11 then
					arg_63_1.talkMaxDuration = var_66_11

					if var_66_11 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_6
					end
				end
			end

			local var_66_12 = math.max(0.4, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_12 then
				arg_63_1.fswtw_.percent = Mathf.Lerp(arg_63_1.var_.oldValueTypewriter, var_66_9, (arg_63_1.time_ - var_66_6) / var_66_12)
				arg_63_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_63_1.fswtw_:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_12 and arg_63_1.time_ < var_66_6 + var_66_12 + arg_66_0 then
				arg_63_1.fswtw_.percent = var_66_9

				arg_63_1.fswtw_:SetDirty()
				arg_63_1:ShowNextGo(true)

				arg_63_1.typewritterCharCountI18N = var_66_10
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_13 = arg_63_1.fswbg_.transform:Find("textbox/adapt/content") or arg_63_1.fswbg_.transform:Find("textbox/content")
				local var_66_14 = arg_63_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_66_15 = var_66_13:GetComponent("RectTransform")

				var_66_13:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_66_15.offsetMin = Vector2.New(0, 0)
				var_66_15.offsetMax = Vector2.New(0, 0)
			end

			local var_66_16 = arg_63_1.actors_["4040ui_story"].transform

			if 4.44089209850063e-16 < arg_63_1.time_ and arg_63_1.time_ <= 4.44089209850063e-16 + arg_66_0 then
				arg_63_1.var_.moveOldPos4040ui_story = var_66_16.localPosition
			end

			local var_66_17 = 0.001

			if 4.44089209850063e-16 <= arg_63_1.time_ and arg_63_1.time_ < 4.44089209850063e-16 + var_66_17 then
				var_66_16.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 4.44089209850063e-16) / var_66_17)
				var_66_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_16.position).x, (manager.ui.mainCamera.transform.position - var_66_16.position).y, (manager.ui.mainCamera.transform.position - var_66_16.position).z)
				var_66_16.localEulerAngles.z = 0
				var_66_16.localEulerAngles.x = 0
				var_66_16.localEulerAngles = var_66_16.localEulerAngles
			end

			if arg_63_1.time_ >= 4.44089209850063e-16 + var_66_17 and arg_63_1.time_ < 4.44089209850063e-16 + var_66_17 + arg_66_0 then
				var_66_16.localPosition = Vector3.New(0, 100, 0)
				var_66_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_16.position).x, (manager.ui.mainCamera.transform.position - var_66_16.position).y, (manager.ui.mainCamera.transform.position - var_66_16.position).z)
				var_66_16.localEulerAngles.z = 0
				var_66_16.localEulerAngles.x = 0
				var_66_16.localEulerAngles = var_66_16.localEulerAngles
			end

			local var_66_18 = 0.366666666666667
			local var_66_19 = manager.audio:GetVoiceLength("story_v_out_319321", "319321015", "story_v_out_319321.awb") / 1000

			if var_66_19 > 0 and 0.266666666666667 < var_66_19 and var_66_19 + var_66_18 > arg_63_1.duration_ then
				arg_63_1.duration_ = var_66_19 + var_66_18
			end

			if var_66_18 < arg_63_1.time_ and arg_63_1.time_ <= var_66_18 + arg_66_0 then
				arg_63_1:AudioAction("play", "voice", "story_v_out_319321", "319321015", "story_v_out_319321.awb")
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.44089209850063e-16,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.44089209850063e-16,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play319321016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319321016
		arg_67_1.duration_ = 3.63

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319321017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.fswbg_:SetActive(true)
				arg_67_1.dialog_:SetActive(false)

				arg_67_1.fswtw_.percent = 0
				arg_67_1.fswt_.text = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(319321016).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.fswt_)

				arg_67_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_67_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_67_1.fswtw_:SetDirty()

				arg_67_1.typewritterCharCountI18N = 0

				SetActive(arg_67_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_67_1:ShowNextGo(false)
			end

			local var_70_0 = 0.166666666666667

			if 0.166666666666667 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.var_.oldValueTypewriter = arg_67_1.fswtw_.percent

				SetActive(arg_67_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_67_1:ShowNextGo(false)
			end

			local var_70_1 = 52
			local var_70_2 = 3.46666666666667
			local var_70_3, var_70_4 = arg_67_1:GetPercentByPara(arg_67_1:FormatText(arg_67_1:GetWordFromCfg(319321016).content), 1)

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				local var_70_5 = var_70_1 <= 0 and var_70_2 or var_70_2 * ((var_70_4 - arg_67_1.typewritterCharCountI18N) / var_70_1)

				if (var_70_1 <= 0 and var_70_2 or var_70_2 * ((var_70_4 - arg_67_1.typewritterCharCountI18N) / var_70_1)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_0
					end
				end
			end

			local var_70_6 = math.max(3.46666666666667, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_6 then
				arg_67_1.fswtw_.percent = Mathf.Lerp(arg_67_1.var_.oldValueTypewriter, var_70_3, (arg_67_1.time_ - var_70_0) / var_70_6)
				arg_67_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_67_1.fswtw_:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_6 and arg_67_1.time_ < var_70_0 + var_70_6 + arg_70_0 then
				arg_67_1.fswtw_.percent = var_70_3

				arg_67_1.fswtw_:SetDirty()
				arg_67_1:ShowNextGo(true)

				arg_67_1.typewritterCharCountI18N = var_70_4
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319321017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319321017
		arg_71_1.duration_ = 5.5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319321018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				local var_74_0 = arg_71_1.bgs_.I12f

				arg_71_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_1 = var_74_0:GetComponent("SpriteRenderer")

				if var_74_1 and var_74_1.sprite then
					local var_74_2 = 2 * (var_74_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_0.transform.localScale = Vector3.New(var_74_2 / var_74_1.sprite.bounds.size.y < var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x and var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x or var_74_2 / var_74_1.sprite.bounds.size.y, var_74_2 / var_74_1.sprite.bounds.size.y < var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x and var_74_2 * manager.ui.mainCameraCom_.aspect / var_74_1.sprite.bounds.size.x or var_74_2 / var_74_1.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "I12f" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.cswbg_:SetActive(false)
			end

			if 0.0340000018477435 < arg_71_1.time_ and arg_71_1.time_ <= 0.0340000018477435 + arg_74_0 then
				arg_71_1.fswbg_:SetActive(false)
				arg_71_1.dialog_:SetActive(false)
				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_71_1:ShowNextGo(false)
			end

			if 0.200666668514411 < arg_71_1.time_ and arg_71_1.time_ <= 0.200666668514411 + arg_74_0 then
				arg_71_1.fswbg_:SetActive(false)
				arg_71_1.dialog_:SetActive(false)
				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_71_1:ShowNextGo(false)
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_3 = 0.5
			local var_74_4 = 1.5

			if 0.5 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_5 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_5:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(319321017).content)

				arg_71_1.text_.text = var_74_6

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_8 = 60 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 60)

				if (60 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_6) / 60)) > 0 and var_74_4 < var_74_8 then
					arg_71_1.talkMaxDuration = var_74_8
					var_74_3 = var_74_3 + 0.3

					if var_74_8 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_6
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_9 = var_74_3 + 0.3
			local var_74_10 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 + 0.3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_9 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_9) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_9 + var_74_10 and arg_71_1.time_ < var_74_9 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319321018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319321018
		arg_77_1.duration_ = 5.67

		local var_77_0 = {
			zh = 5.666,
			ja = 4.566
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
				arg_77_0:Play319321019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10079ui_story = arg_77_1.actors_["10079ui_story"].transform.localPosition

				arg_77_1:ShowWeapon(arg_77_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10079ui_story"].transform.position).z)
				arg_77_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10079ui_story"].transform.localEulerAngles = arg_77_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_77_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10079ui_story"].transform.position).z)
				arg_77_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10079ui_story"].transform.localEulerAngles = arg_77_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["10079ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10079ui_story == nil then
				arg_77_1.var_.characterEffect10079ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect10079ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect10079ui_story then
				arg_77_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_80_4 = 0
			local var_80_5 = 0.675

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(319321018)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 27 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 27)

				if (27 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 27)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321018", "story_v_out_319321.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321018", "story_v_out_319321.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_319321", "319321018", "story_v_out_319321.awb")

						arg_77_1:RecordAudio("319321018", var_80_11)
						arg_77_1:RecordAudio("319321018", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319321", "319321018", "story_v_out_319321.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319321", "319321018", "story_v_out_319321.awb")
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
				actorName = "10079ui_story",
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
	Play319321019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319321019
		arg_81_1.duration_ = 7.13

		local var_81_0 = {
			zh = 3.166,
			ja = 7.133
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
				arg_81_0:Play319321020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10079ui_story"]) and arg_81_1.var_.characterEffect10079ui_story == nil then
				arg_81_1.var_.characterEffect10079ui_story = arg_81_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10079ui_story"]) then
				if arg_81_1.var_.characterEffect10079ui_story and not isNil(arg_81_1.actors_["10079ui_story"]) then
					arg_81_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10079ui_story"]) and arg_81_1.var_.characterEffect10079ui_story then
				arg_81_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_84_1 = arg_81_1.actors_["4040ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos4040ui_story = var_84_1.localPosition
			end

			local var_84_2 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 then
				var_84_1.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_81_1.time_ - 0) / var_84_2)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 then
				var_84_1.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_84_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_1.position).x, (manager.ui.mainCamera.transform.position - var_84_1.position).y, (manager.ui.mainCamera.transform.position - var_84_1.position).z)
				var_84_1.localEulerAngles.z = 0
				var_84_1.localEulerAngles.x = 0
				var_84_1.localEulerAngles = var_84_1.localEulerAngles
			end

			local var_84_3 = arg_81_1.actors_["4040ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect4040ui_story == nil then
				arg_81_1.var_.characterEffect4040ui_story = var_84_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_4 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 and not isNil(var_84_3) then
				if arg_81_1.var_.characterEffect4040ui_story and not isNil(var_84_3) then
					arg_81_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 and not isNil(var_84_3) and arg_81_1.var_.characterEffect4040ui_story then
				arg_81_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_6 = arg_81_1.actors_["10079ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10079ui_story = var_84_6.localPosition

				arg_81_1:ShowWeapon(arg_81_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_6.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_81_1.time_ - 0) / var_84_7)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_6.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_84_8 = 0
			local var_84_9 = 0.4

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(319321019)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 16 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 16)

				if (16 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 16)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321019", "story_v_out_319321.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_319321", "319321019", "story_v_out_319321.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_319321", "319321019", "story_v_out_319321.awb")

						arg_81_1:RecordAudio("319321019", var_84_15)
						arg_81_1:RecordAudio("319321019", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319321", "319321019", "story_v_out_319321.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319321", "319321019", "story_v_out_319321.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319321020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319321020
		arg_85_1.duration_ = 2.23

		local var_85_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_85_0:Play319321021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10079ui_story = arg_85_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10079ui_story"].transform.position).z)
				arg_85_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10079ui_story"].transform.localEulerAngles = arg_85_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_85_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10079ui_story"].transform.position).z)
				arg_85_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10079ui_story"].transform.localEulerAngles = arg_85_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10079ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10079ui_story == nil then
				arg_85_1.var_.characterEffect10079ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10079ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10079ui_story then
				arg_85_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = arg_85_1.actors_["4040ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect4040ui_story == nil then
				arg_85_1.var_.characterEffect4040ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_5 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 and not isNil(var_88_4) then
				if arg_85_1.var_.characterEffect4040ui_story and not isNil(var_88_4) then
					arg_85_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_85_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_5)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect4040ui_story then
				arg_85_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_85_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_88_6 = 0
			local var_88_7 = 0.225

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(319321020)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 9 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 9)

				if (9 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 9)) > 0 and var_88_7 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321020", "story_v_out_319321.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_319321", "319321020", "story_v_out_319321.awb") / 1000

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_out_319321", "319321020", "story_v_out_319321.awb")

						arg_85_1:RecordAudio("319321020", var_88_13)
						arg_85_1:RecordAudio("319321020", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319321", "319321020", "story_v_out_319321.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319321", "319321020", "story_v_out_319321.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319321021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319321021
		arg_89_1.duration_ = 7.4

		local var_89_0 = {
			zh = 6.833,
			ja = 7.4
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
				arg_89_0:Play319321022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10079ui_story"]) and arg_89_1.var_.characterEffect10079ui_story == nil then
				arg_89_1.var_.characterEffect10079ui_story = arg_89_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10079ui_story"]) then
				if arg_89_1.var_.characterEffect10079ui_story and not isNil(arg_89_1.actors_["10079ui_story"]) then
					arg_89_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10079ui_story"]) and arg_89_1.var_.characterEffect10079ui_story then
				arg_89_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_92_1 = arg_89_1.actors_["4040ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect4040ui_story == nil then
				arg_89_1.var_.characterEffect4040ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect4040ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect4040ui_story then
				arg_89_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_92_4 = 0
			local var_92_5 = 0.8

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(319321021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 32 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 32)

				if (32 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 32)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321021", "story_v_out_319321.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321021", "story_v_out_319321.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_319321", "319321021", "story_v_out_319321.awb")

						arg_89_1:RecordAudio("319321021", var_92_11)
						arg_89_1:RecordAudio("319321021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319321", "319321021", "story_v_out_319321.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319321", "319321021", "story_v_out_319321.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319321022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319321022
		arg_93_1.duration_ = 6.2

		local var_93_0 = {
			zh = 6.2,
			ja = 5.2
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
				arg_93_0:Play319321023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.625

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(319321022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 25 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 25)

				if (25 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 25)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321022", "story_v_out_319321.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_319321", "319321022", "story_v_out_319321.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_319321", "319321022", "story_v_out_319321.awb")

						arg_93_1:RecordAudio("319321022", var_96_6)
						arg_93_1:RecordAudio("319321022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319321", "319321022", "story_v_out_319321.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319321", "319321022", "story_v_out_319321.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319321023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319321023
		arg_97_1.duration_ = 8

		local var_97_0 = {
			zh = 3.4,
			ja = 8
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
				arg_97_0:Play319321024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos4040ui_story = arg_97_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).z)
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles = arg_97_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_97_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["4040ui_story"].transform.position).z)
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["4040ui_story"].transform.localEulerAngles = arg_97_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["4040ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect4040ui_story == nil then
				arg_97_1.var_.characterEffect4040ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect4040ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect4040ui_story then
				arg_97_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			local var_100_4 = 0
			local var_100_5 = 0.35

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(319321023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 14 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 14)

				if (14 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 14)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321023", "story_v_out_319321.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321023", "story_v_out_319321.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_319321", "319321023", "story_v_out_319321.awb")

						arg_97_1:RecordAudio("319321023", var_100_11)
						arg_97_1:RecordAudio("319321023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319321", "319321023", "story_v_out_319321.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319321", "319321023", "story_v_out_319321.awb")
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

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319321024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319321024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play319321025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["4040ui_story"]) and arg_101_1.var_.characterEffect4040ui_story == nil then
				arg_101_1.var_.characterEffect4040ui_story = arg_101_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["4040ui_story"]) then
				if arg_101_1.var_.characterEffect4040ui_story and not isNil(arg_101_1.actors_["4040ui_story"]) then
					arg_101_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_101_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["4040ui_story"]) and arg_101_1.var_.characterEffect4040ui_story then
				arg_101_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_101_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 1.175

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

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(319321024).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 47 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 47)

				if (47 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 47)) > 0 and var_104_2 < var_104_5 then
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
	Play319321025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319321025
		arg_105_1.duration_ = 6.3

		local var_105_0 = {
			zh = 5.633,
			ja = 6.3
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
				arg_105_0:Play319321026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["4040ui_story"]) and arg_105_1.var_.characterEffect4040ui_story == nil then
				arg_105_1.var_.characterEffect4040ui_story = arg_105_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["4040ui_story"]) then
				if arg_105_1.var_.characterEffect4040ui_story and not isNil(arg_105_1.actors_["4040ui_story"]) then
					arg_105_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["4040ui_story"]) and arg_105_1.var_.characterEffect4040ui_story then
				arg_105_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_108_2 = 0
			local var_108_3 = 0.55

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:GetWordFromCfg(319321025)
				local var_108_5 = arg_105_1:FormatText(var_108_4.content)

				arg_105_1.text_.text = var_108_5

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 22 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 22)

				if (22 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_5) / 22)) > 0 and var_108_3 < var_108_7 then
					arg_105_1.talkMaxDuration = var_108_7

					if var_108_7 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_5
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321025", "story_v_out_319321.awb") ~= 0 then
					local var_108_8 = manager.audio:GetVoiceLength("story_v_out_319321", "319321025", "story_v_out_319321.awb") / 1000

					if var_108_8 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_8 + var_108_2
					end

					if var_108_4.prefab_name ~= "" and arg_105_1.actors_[var_108_4.prefab_name] ~= nil then
						local var_108_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_4.prefab_name].transform, "story_v_out_319321", "319321025", "story_v_out_319321.awb")

						arg_105_1:RecordAudio("319321025", var_108_9)
						arg_105_1:RecordAudio("319321025", var_108_9)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319321", "319321025", "story_v_out_319321.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319321", "319321025", "story_v_out_319321.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_10 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_10 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_10

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_10 and arg_105_1.time_ < var_108_2 + var_108_10 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319321026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319321026
		arg_109_1.duration_ = 6.87

		local var_109_0 = {
			zh = 4.4,
			ja = 6.866
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
				arg_109_0:Play319321027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10079ui_story = arg_109_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).z)
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles = arg_109_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_109_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["10079ui_story"].transform.position).z)
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["10079ui_story"].transform.localEulerAngles = arg_109_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["10079ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10079ui_story == nil then
				arg_109_1.var_.characterEffect10079ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect10079ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect10079ui_story then
				arg_109_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action435")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_112_4 = arg_109_1.actors_["4040ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect4040ui_story == nil then
				arg_109_1.var_.characterEffect4040ui_story = var_112_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_5 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_5 and not isNil(var_112_4) then
				if arg_109_1.var_.characterEffect4040ui_story and not isNil(var_112_4) then
					arg_109_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_109_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_5)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_5 and arg_109_1.time_ < 0 + var_112_5 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect4040ui_story then
				arg_109_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_109_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_112_6 = 0
			local var_112_7 = 0.525

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(319321026)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 21 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 21)

				if (21 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 21)) > 0 and var_112_7 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321026", "story_v_out_319321.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_319321", "319321026", "story_v_out_319321.awb") / 1000

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_319321", "319321026", "story_v_out_319321.awb")

						arg_109_1:RecordAudio("319321026", var_112_13)
						arg_109_1:RecordAudio("319321026", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319321", "319321026", "story_v_out_319321.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319321", "319321026", "story_v_out_319321.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319321027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319321027
		arg_113_1.duration_ = 6.9

		local var_113_0 = {
			zh = 3.7,
			ja = 6.9
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
				arg_113_0:Play319321028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10079ui_story"]) and arg_113_1.var_.characterEffect10079ui_story == nil then
				arg_113_1.var_.characterEffect10079ui_story = arg_113_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10079ui_story"]) then
				if arg_113_1.var_.characterEffect10079ui_story and not isNil(arg_113_1.actors_["10079ui_story"]) then
					arg_113_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10079ui_story"]) and arg_113_1.var_.characterEffect10079ui_story then
				arg_113_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_116_1 = arg_113_1.actors_["4040ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect4040ui_story == nil then
				arg_113_1.var_.characterEffect4040ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect4040ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect4040ui_story then
				arg_113_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_116_4 = 0
			local var_116_5 = 0.35

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(319321027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 14 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 14)

				if (14 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 14)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321027", "story_v_out_319321.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321027", "story_v_out_319321.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_319321", "319321027", "story_v_out_319321.awb")

						arg_113_1:RecordAudio("319321027", var_116_11)
						arg_113_1:RecordAudio("319321027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319321", "319321027", "story_v_out_319321.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319321", "319321027", "story_v_out_319321.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319321028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319321028
		arg_117_1.duration_ = 7.53

		local var_117_0 = {
			zh = 2.1,
			ja = 7.533
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
				arg_117_0:Play319321029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10079ui_story"]) and arg_117_1.var_.characterEffect10079ui_story == nil then
				arg_117_1.var_.characterEffect10079ui_story = arg_117_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10079ui_story"]) then
				if arg_117_1.var_.characterEffect10079ui_story and not isNil(arg_117_1.actors_["10079ui_story"]) then
					arg_117_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10079ui_story"]) and arg_117_1.var_.characterEffect10079ui_story then
				arg_117_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_120_2 = arg_117_1.actors_["4040ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect4040ui_story == nil then
				arg_117_1.var_.characterEffect4040ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect4040ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_117_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect4040ui_story then
				arg_117_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_117_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_120_4 = 0
			local var_120_5 = 0.225

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(319321028)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 9 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 9)

				if (9 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 9)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321028", "story_v_out_319321.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321028", "story_v_out_319321.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_319321", "319321028", "story_v_out_319321.awb")

						arg_117_1:RecordAudio("319321028", var_120_11)
						arg_117_1:RecordAudio("319321028", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319321", "319321028", "story_v_out_319321.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319321", "319321028", "story_v_out_319321.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319321029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319321029
		arg_121_1.duration_ = 5.47

		local var_121_0 = {
			zh = 2.3,
			ja = 5.466
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
				arg_121_0:Play319321030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10079ui_story"]) and arg_121_1.var_.characterEffect10079ui_story == nil then
				arg_121_1.var_.characterEffect10079ui_story = arg_121_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10079ui_story"]) then
				if arg_121_1.var_.characterEffect10079ui_story and not isNil(arg_121_1.actors_["10079ui_story"]) then
					arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_0)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10079ui_story"]) and arg_121_1.var_.characterEffect10079ui_story then
				arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_124_1 = arg_121_1.actors_["4040ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect4040ui_story == nil then
				arg_121_1.var_.characterEffect4040ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect4040ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect4040ui_story then
				arg_121_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_124_4 = 0
			local var_124_5 = 0.275

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(319321029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 11 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 11)

				if (11 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 11)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321029", "story_v_out_319321.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321029", "story_v_out_319321.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_319321", "319321029", "story_v_out_319321.awb")

						arg_121_1:RecordAudio("319321029", var_124_11)
						arg_121_1:RecordAudio("319321029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319321", "319321029", "story_v_out_319321.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319321", "319321029", "story_v_out_319321.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319321030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319321030
		arg_125_1.duration_ = 15.63

		local var_125_0 = {
			zh = 7.466,
			ja = 15.633
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
				arg_125_0:Play319321031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos4040ui_story = arg_125_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["4040ui_story"].transform.position).z)
				arg_125_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["4040ui_story"].transform.localEulerAngles = arg_125_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_125_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["4040ui_story"].transform.position).z)
				arg_125_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["4040ui_story"].transform.localEulerAngles = arg_125_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["4040ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect4040ui_story == nil then
				arg_125_1.var_.characterEffect4040ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect4040ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect4040ui_story then
				arg_125_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_128_4 = 0
			local var_128_5 = 0.925

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(319321030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 37 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 37)

				if (37 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 37)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321030", "story_v_out_319321.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321030", "story_v_out_319321.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_319321", "319321030", "story_v_out_319321.awb")

						arg_125_1:RecordAudio("319321030", var_128_11)
						arg_125_1:RecordAudio("319321030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319321", "319321030", "story_v_out_319321.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319321", "319321030", "story_v_out_319321.awb")
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
				actorName = "4040ui_story",
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
	Play319321031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319321031
		arg_129_1.duration_ = 4.37

		local var_129_0 = {
			zh = 1.999999999999,
			ja = 4.366
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319321032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10079ui_story = arg_129_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10079ui_story"].transform.position).z)
				arg_129_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10079ui_story"].transform.localEulerAngles = arg_129_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_129_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["10079ui_story"].transform.position).z)
				arg_129_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["10079ui_story"].transform.localEulerAngles = arg_129_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["10079ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10079ui_story == nil then
				arg_129_1.var_.characterEffect10079ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect10079ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect10079ui_story then
				arg_129_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_132_4 = arg_129_1.actors_["4040ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect4040ui_story == nil then
				arg_129_1.var_.characterEffect4040ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_5 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 and not isNil(var_132_4) then
				if arg_129_1.var_.characterEffect4040ui_story and not isNil(var_132_4) then
					arg_129_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_129_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_5)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect4040ui_story then
				arg_129_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_129_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_132_6 = 0
			local var_132_7 = 0.175

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(319321031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 7 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 7)

				if (7 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 7)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321031", "story_v_out_319321.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_out_319321", "319321031", "story_v_out_319321.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_319321", "319321031", "story_v_out_319321.awb")

						arg_129_1:RecordAudio("319321031", var_132_13)
						arg_129_1:RecordAudio("319321031", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_319321", "319321031", "story_v_out_319321.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_319321", "319321031", "story_v_out_319321.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319321032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319321032
		arg_133_1.duration_ = 3.53

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 3.533
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play319321033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10079ui_story"]) and arg_133_1.var_.characterEffect10079ui_story == nil then
				arg_133_1.var_.characterEffect10079ui_story = arg_133_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10079ui_story"]) then
				if arg_133_1.var_.characterEffect10079ui_story and not isNil(arg_133_1.actors_["10079ui_story"]) then
					arg_133_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10079ui_story"]) and arg_133_1.var_.characterEffect10079ui_story then
				arg_133_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_136_1 = arg_133_1.actors_["4040ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect4040ui_story == nil then
				arg_133_1.var_.characterEffect4040ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect4040ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect4040ui_story then
				arg_133_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			local var_136_4 = 0
			local var_136_5 = 0.075

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(319321032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 3 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 3)

				if (3 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 3)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321032", "story_v_out_319321.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321032", "story_v_out_319321.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_319321", "319321032", "story_v_out_319321.awb")

						arg_133_1:RecordAudio("319321032", var_136_11)
						arg_133_1:RecordAudio("319321032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319321", "319321032", "story_v_out_319321.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319321", "319321032", "story_v_out_319321.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play319321033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319321033
		arg_137_1.duration_ = 3.23

		local var_137_0 = {
			zh = 1.999999999999,
			ja = 3.233
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play319321034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if arg_137_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_140_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_137_1.stage_.transform)

				var_140_0.name = "1095ui_story"
				var_140_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1095ui_story"] = var_140_0

				local var_140_1 = var_140_0:GetComponentInChildren(typeof(CharacterEffect))

				var_140_1.enabled = true

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_0, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end

				arg_137_1:ShowWeapon(var_140_1.transform, false)

				arg_137_1.var_["1095ui_story" .. "Animator"] = var_140_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_137_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_137_1.var_["1095ui_story" .. "LipSync"] = var_140_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_140_3 = arg_137_1.actors_["1095ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1095ui_story = var_140_3.localPosition
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_3.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_137_1.time_ - 0) / var_140_4)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			local var_140_5 = arg_137_1.actors_["1095ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect1095ui_story == nil then
				arg_137_1.var_.characterEffect1095ui_story = var_140_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_6 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 and not isNil(var_140_5) then
				if arg_137_1.var_.characterEffect1095ui_story and not isNil(var_140_5) then
					arg_137_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect1095ui_story then
				arg_137_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_140_8 = arg_137_1.actors_["4040ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos4040ui_story = var_140_8.localPosition
			end

			local var_140_9 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_9 then
				var_140_8.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_9)
				var_140_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_8.position).x, (manager.ui.mainCamera.transform.position - var_140_8.position).y, (manager.ui.mainCamera.transform.position - var_140_8.position).z)
				var_140_8.localEulerAngles.z = 0
				var_140_8.localEulerAngles.x = 0
				var_140_8.localEulerAngles = var_140_8.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_9 and arg_137_1.time_ < 0 + var_140_9 + arg_140_0 then
				var_140_8.localPosition = Vector3.New(0, 100, 0)
				var_140_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_8.position).x, (manager.ui.mainCamera.transform.position - var_140_8.position).y, (manager.ui.mainCamera.transform.position - var_140_8.position).z)
				var_140_8.localEulerAngles.z = 0
				var_140_8.localEulerAngles.x = 0
				var_140_8.localEulerAngles = var_140_8.localEulerAngles
			end

			local var_140_10 = arg_137_1.actors_["4040ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_10) and arg_137_1.var_.characterEffect4040ui_story == nil then
				arg_137_1.var_.characterEffect4040ui_story = var_140_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_11 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_11 and not isNil(var_140_10) then
				if arg_137_1.var_.characterEffect4040ui_story and not isNil(var_140_10) then
					arg_137_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_137_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_11)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_11 and arg_137_1.time_ < 0 + var_140_11 + arg_140_0 and not isNil(var_140_10) and arg_137_1.var_.characterEffect4040ui_story then
				arg_137_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_137_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_140_12 = arg_137_1.actors_["10079ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10079ui_story = var_140_12.localPosition
			end

			local var_140_13 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_13 then
				var_140_12.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_13)
				var_140_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_12.position).x, (manager.ui.mainCamera.transform.position - var_140_12.position).y, (manager.ui.mainCamera.transform.position - var_140_12.position).z)
				var_140_12.localEulerAngles.z = 0
				var_140_12.localEulerAngles.x = 0
				var_140_12.localEulerAngles = var_140_12.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_13 and arg_137_1.time_ < 0 + var_140_13 + arg_140_0 then
				var_140_12.localPosition = Vector3.New(0, 100, 0)
				var_140_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_12.position).x, (manager.ui.mainCamera.transform.position - var_140_12.position).y, (manager.ui.mainCamera.transform.position - var_140_12.position).z)
				var_140_12.localEulerAngles.z = 0
				var_140_12.localEulerAngles.x = 0
				var_140_12.localEulerAngles = var_140_12.localEulerAngles
			end

			local var_140_14 = arg_137_1.actors_["10079ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_14) and arg_137_1.var_.characterEffect10079ui_story == nil then
				arg_137_1.var_.characterEffect10079ui_story = var_140_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_15 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_15 and not isNil(var_140_14) then
				if arg_137_1.var_.characterEffect10079ui_story and not isNil(var_140_14) then
					arg_137_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_15)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_15 and arg_137_1.time_ < 0 + var_140_15 + arg_140_0 and not isNil(var_140_14) and arg_137_1.var_.characterEffect10079ui_story then
				arg_137_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_140_16 = 0
			local var_140_17 = 0.125

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 then
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

				local var_140_18 = arg_137_1:GetWordFromCfg(319321033)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_21 = 5 <= 0 and var_140_17 or var_140_17 * (utf8.len(var_140_19) / 5)

				if (5 <= 0 and var_140_17 or var_140_17 * (utf8.len(var_140_19) / 5)) > 0 and var_140_17 < var_140_21 then
					arg_137_1.talkMaxDuration = var_140_21

					if var_140_21 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_21 + var_140_16
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321033", "story_v_out_319321.awb") ~= 0 then
					local var_140_22 = manager.audio:GetVoiceLength("story_v_out_319321", "319321033", "story_v_out_319321.awb") / 1000

					if var_140_22 + var_140_16 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_16
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_319321", "319321033", "story_v_out_319321.awb")

						arg_137_1:RecordAudio("319321033", var_140_23)
						arg_137_1:RecordAudio("319321033", var_140_23)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319321", "319321033", "story_v_out_319321.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319321", "319321033", "story_v_out_319321.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_24 = math.max(var_140_17, arg_137_1.talkMaxDuration)

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_24 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_16) / var_140_24

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_16 + var_140_24 and arg_137_1.time_ < var_140_16 + var_140_24 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319321034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319321034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319321035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1095ui_story"]) and arg_141_1.var_.characterEffect1095ui_story == nil then
				arg_141_1.var_.characterEffect1095ui_story = arg_141_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1095ui_story"]) then
				if arg_141_1.var_.characterEffect1095ui_story and not isNil(arg_141_1.actors_["1095ui_story"]) then
					arg_141_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1095ui_story"]) and arg_141_1.var_.characterEffect1095ui_story then
				arg_141_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 1.25

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

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(319321034).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 50 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 50)

				if (50 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 50)) > 0 and var_144_2 < var_144_5 then
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
	Play319321035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319321035
		arg_145_1.duration_ = 5.07

		local var_145_0 = {
			zh = 4.833,
			ja = 5.066
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
				arg_145_0:Play319321036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) and arg_145_1.var_.characterEffect1095ui_story == nil then
				arg_145_1.var_.characterEffect1095ui_story = arg_145_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) then
				if arg_145_1.var_.characterEffect1095ui_story and not isNil(arg_145_1.actors_["1095ui_story"]) then
					arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1095ui_story"]) and arg_145_1.var_.characterEffect1095ui_story then
				arg_145_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_148_2 = 0
			local var_148_3 = 0.35

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:GetWordFromCfg(319321035)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 14 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 14)

				if (14 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 14)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321035", "story_v_out_319321.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_319321", "319321035", "story_v_out_319321.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_out_319321", "319321035", "story_v_out_319321.awb")

						arg_145_1:RecordAudio("319321035", var_148_9)
						arg_145_1:RecordAudio("319321035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319321", "319321035", "story_v_out_319321.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319321", "319321035", "story_v_out_319321.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_3, arg_145_1.talkMaxDuration)

			if var_148_2 <= arg_145_1.time_ and arg_145_1.time_ < var_148_2 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_2) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_2 + var_148_10 and arg_145_1.time_ < var_148_2 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play319321036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319321036
		arg_149_1.duration_ = 5.77

		local var_149_0 = {
			zh = 1.999999999999,
			ja = 5.766
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
				arg_149_0:Play319321037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos4040ui_story = arg_149_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4040ui_story"].transform.position).z)
				arg_149_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["4040ui_story"].transform.localEulerAngles = arg_149_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_149_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["4040ui_story"].transform.position).z)
				arg_149_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["4040ui_story"].transform.localEulerAngles = arg_149_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["4040ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect4040ui_story == nil then
				arg_149_1.var_.characterEffect4040ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect4040ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect4040ui_story then
				arg_149_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1095ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1095ui_story = var_152_4.localPosition
			end

			local var_152_5 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 then
				var_152_4.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_5)
				var_152_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_4.position).x, (manager.ui.mainCamera.transform.position - var_152_4.position).y, (manager.ui.mainCamera.transform.position - var_152_4.position).z)
				var_152_4.localEulerAngles.z = 0
				var_152_4.localEulerAngles.x = 0
				var_152_4.localEulerAngles = var_152_4.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 then
				var_152_4.localPosition = Vector3.New(0, 100, 0)
				var_152_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_4.position).x, (manager.ui.mainCamera.transform.position - var_152_4.position).y, (manager.ui.mainCamera.transform.position - var_152_4.position).z)
				var_152_4.localEulerAngles.z = 0
				var_152_4.localEulerAngles.x = 0
				var_152_4.localEulerAngles = var_152_4.localEulerAngles
			end

			local var_152_6 = arg_149_1.actors_["1095ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1095ui_story == nil then
				arg_149_1.var_.characterEffect1095ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_7 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 and not isNil(var_152_6) then
				if arg_149_1.var_.characterEffect1095ui_story and not isNil(var_152_6) then
					arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_7)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1095ui_story then
				arg_149_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_152_8 = 0
			local var_152_9 = 0.125

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_10 = arg_149_1:GetWordFromCfg(319321036)
				local var_152_11 = arg_149_1:FormatText(var_152_10.content)

				arg_149_1.text_.text = var_152_11

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_13 = 5 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 5)

				if (5 <= 0 and var_152_9 or var_152_9 * (utf8.len(var_152_11) / 5)) > 0 and var_152_9 < var_152_13 then
					arg_149_1.talkMaxDuration = var_152_13

					if var_152_13 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_13 + var_152_8
					end
				end

				arg_149_1.text_.text = var_152_11
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321036", "story_v_out_319321.awb") ~= 0 then
					local var_152_14 = manager.audio:GetVoiceLength("story_v_out_319321", "319321036", "story_v_out_319321.awb") / 1000

					if var_152_14 + var_152_8 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_14 + var_152_8
					end

					if var_152_10.prefab_name ~= "" and arg_149_1.actors_[var_152_10.prefab_name] ~= nil then
						local var_152_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_10.prefab_name].transform, "story_v_out_319321", "319321036", "story_v_out_319321.awb")

						arg_149_1:RecordAudio("319321036", var_152_15)
						arg_149_1:RecordAudio("319321036", var_152_15)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_319321", "319321036", "story_v_out_319321.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_319321", "319321036", "story_v_out_319321.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_16 = math.max(var_152_9, arg_149_1.talkMaxDuration)

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_16 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_8) / var_152_16

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_8 + var_152_16 and arg_149_1.time_ < var_152_8 + var_152_16 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319321037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319321037
		arg_153_1.duration_ = 10.83

		local var_153_0 = {
			zh = 6.966,
			ja = 10.833
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
				arg_153_0:Play319321038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10079ui_story = arg_153_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10079ui_story"].transform.position).z)
				arg_153_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10079ui_story"].transform.localEulerAngles = arg_153_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_153_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["10079ui_story"].transform.position).z)
				arg_153_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["10079ui_story"].transform.localEulerAngles = arg_153_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["10079ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10079ui_story == nil then
				arg_153_1.var_.characterEffect10079ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect10079ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect10079ui_story then
				arg_153_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_4 = arg_153_1.actors_["4040ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos4040ui_story = var_156_4.localPosition
			end

			local var_156_5 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_5 then
				var_156_4.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 0) / var_156_5)
				var_156_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_4.position).x, (manager.ui.mainCamera.transform.position - var_156_4.position).y, (manager.ui.mainCamera.transform.position - var_156_4.position).z)
				var_156_4.localEulerAngles.z = 0
				var_156_4.localEulerAngles.x = 0
				var_156_4.localEulerAngles = var_156_4.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_5 and arg_153_1.time_ < 0 + var_156_5 + arg_156_0 then
				var_156_4.localPosition = Vector3.New(0, 100, 0)
				var_156_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_4.position).x, (manager.ui.mainCamera.transform.position - var_156_4.position).y, (manager.ui.mainCamera.transform.position - var_156_4.position).z)
				var_156_4.localEulerAngles.z = 0
				var_156_4.localEulerAngles.x = 0
				var_156_4.localEulerAngles = var_156_4.localEulerAngles
			end

			local var_156_6 = arg_153_1.actors_["4040ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect4040ui_story == nil then
				arg_153_1.var_.characterEffect4040ui_story = var_156_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_7 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 and not isNil(var_156_6) then
				if arg_153_1.var_.characterEffect4040ui_story and not isNil(var_156_6) then
					arg_153_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_153_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_7)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 and not isNil(var_156_6) and arg_153_1.var_.characterEffect4040ui_story then
				arg_153_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_153_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_156_8 = 0
			local var_156_9 = 0.775

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_10 = arg_153_1:GetWordFromCfg(319321037)
				local var_156_11 = arg_153_1:FormatText(var_156_10.content)

				arg_153_1.text_.text = var_156_11

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 31 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 31)

				if (31 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 31)) > 0 and var_156_9 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_11
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321037", "story_v_out_319321.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_319321", "319321037", "story_v_out_319321.awb") / 1000

					if var_156_14 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_8
					end

					if var_156_10.prefab_name ~= "" and arg_153_1.actors_[var_156_10.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_10.prefab_name].transform, "story_v_out_319321", "319321037", "story_v_out_319321.awb")

						arg_153_1:RecordAudio("319321037", var_156_15)
						arg_153_1:RecordAudio("319321037", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_319321", "319321037", "story_v_out_319321.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_319321", "319321037", "story_v_out_319321.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_16 and arg_153_1.time_ < var_156_8 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319321038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319321038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play319321039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["10079ui_story"]) and arg_157_1.var_.characterEffect10079ui_story == nil then
				arg_157_1.var_.characterEffect10079ui_story = arg_157_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["10079ui_story"]) then
				if arg_157_1.var_.characterEffect10079ui_story and not isNil(arg_157_1.actors_["10079ui_story"]) then
					arg_157_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["10079ui_story"]) and arg_157_1.var_.characterEffect10079ui_story then
				arg_157_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 1.325

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(319321038).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 53 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 53)

				if (53 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 53)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play319321039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319321039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play319321040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.8

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(319321039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 32 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 32)

				if (32 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 32)) > 0 and var_164_0 < var_164_3 then
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
	Play319321040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319321040
		arg_165_1.duration_ = 1.8

		local var_165_0 = {
			zh = 1.366,
			ja = 1.8
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
				arg_165_0:Play319321041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1095ui_story = arg_165_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).z)
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles = arg_165_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_165_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1095ui_story"].transform.position).z)
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1095ui_story"].transform.localEulerAngles = arg_165_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1095ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1095ui_story == nil then
				arg_165_1.var_.characterEffect1095ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1095ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1095ui_story then
				arg_165_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["10079ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10079ui_story = var_168_4.localPosition
			end

			local var_168_5 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 then
				var_168_4.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_165_1.time_ - 0) / var_168_5)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 then
				var_168_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_168_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_4.position).x, (manager.ui.mainCamera.transform.position - var_168_4.position).y, (manager.ui.mainCamera.transform.position - var_168_4.position).z)
				var_168_4.localEulerAngles.z = 0
				var_168_4.localEulerAngles.x = 0
				var_168_4.localEulerAngles = var_168_4.localEulerAngles
			end

			local var_168_6 = 0
			local var_168_7 = 0.125

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(319321040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 5 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 5)

				if (5 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 5)) > 0 and var_168_7 < var_168_11 then
					arg_165_1.talkMaxDuration = var_168_11

					if var_168_11 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321040", "story_v_out_319321.awb") ~= 0 then
					local var_168_12 = manager.audio:GetVoiceLength("story_v_out_319321", "319321040", "story_v_out_319321.awb") / 1000

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_319321", "319321040", "story_v_out_319321.awb")

						arg_165_1:RecordAudio("319321040", var_168_13)
						arg_165_1:RecordAudio("319321040", var_168_13)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319321", "319321040", "story_v_out_319321.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319321", "319321040", "story_v_out_319321.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_14 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_14

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_14 and arg_165_1.time_ < var_168_6 + var_168_14 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319321041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319321041
		arg_169_1.duration_ = 12.27

		local var_169_0 = {
			zh = 9.6,
			ja = 12.266
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
				arg_169_0:Play319321042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_172_0 = 0
			local var_172_1 = 1.175

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(319321041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 47 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 47)

				if (47 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 47)) > 0 and var_172_1 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321041", "story_v_out_319321.awb") ~= 0 then
					local var_172_6 = manager.audio:GetVoiceLength("story_v_out_319321", "319321041", "story_v_out_319321.awb") / 1000

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end

					if var_172_2.prefab_name ~= "" and arg_169_1.actors_[var_172_2.prefab_name] ~= nil then
						local var_172_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_2.prefab_name].transform, "story_v_out_319321", "319321041", "story_v_out_319321.awb")

						arg_169_1:RecordAudio("319321041", var_172_7)
						arg_169_1:RecordAudio("319321041", var_172_7)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319321", "319321041", "story_v_out_319321.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319321", "319321041", "story_v_out_319321.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319321042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319321042
		arg_173_1.duration_ = 1.03

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319321043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1095ui_story"]) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = arg_173_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1095ui_story"]) then
				if arg_173_1.var_.characterEffect1095ui_story and not isNil(arg_173_1.actors_["1095ui_story"]) then
					arg_173_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_0)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1095ui_story"]) and arg_173_1.var_.characterEffect1095ui_story then
				arg_173_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_176_1 = arg_173_1.actors_["10079ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10079ui_story == nil then
				arg_173_1.var_.characterEffect10079ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect10079ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect10079ui_story then
				arg_173_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_176_4 = 0
			local var_176_5 = 0.05

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(319321042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 2 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 2)

				if (2 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 2)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321042", "story_v_out_319321.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321042", "story_v_out_319321.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_319321", "319321042", "story_v_out_319321.awb")

						arg_173_1:RecordAudio("319321042", var_176_11)
						arg_173_1:RecordAudio("319321042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319321", "319321042", "story_v_out_319321.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319321", "319321042", "story_v_out_319321.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319321043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319321043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319321044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["10079ui_story"]) and arg_177_1.var_.characterEffect10079ui_story == nil then
				arg_177_1.var_.characterEffect10079ui_story = arg_177_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["10079ui_story"]) then
				if arg_177_1.var_.characterEffect10079ui_story and not isNil(arg_177_1.actors_["10079ui_story"]) then
					arg_177_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["10079ui_story"]) and arg_177_1.var_.characterEffect10079ui_story then
				arg_177_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 1.325

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(319321043).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 53 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 53)

				if (53 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 53)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play319321044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319321044
		arg_181_1.duration_ = 4.03

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319321045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 2.03400000184774 < arg_181_1.time_ and arg_181_1.time_ <= 2.03400000184774 + arg_184_0 then
				arg_181_1.var_.moveOldPos1095ui_story = arg_181_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 2.03400000184774 <= arg_181_1.time_ and arg_181_1.time_ < 2.03400000184774 + var_184_0 then
				arg_181_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_181_1.time_ - 2.03400000184774) / var_184_0)
				arg_181_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1095ui_story"].transform.position).z)
				arg_181_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1095ui_story"].transform.localEulerAngles = arg_181_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 2.03400000184774 + var_184_0 and arg_181_1.time_ < 2.03400000184774 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_181_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1095ui_story"].transform.position).z)
				arg_181_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1095ui_story"].transform.localEulerAngles = arg_181_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1095ui_story"]

			if 2.03400000184774 < arg_181_1.time_ and arg_181_1.time_ <= 2.03400000184774 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1095ui_story == nil then
				arg_181_1.var_.characterEffect1095ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 2.03400000184774 <= arg_181_1.time_ and arg_181_1.time_ < 2.03400000184774 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1095ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 2.03400000184774 + var_184_2 and arg_181_1.time_ < 2.03400000184774 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1095ui_story then
				arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 2.03400000184774 < arg_181_1.time_ and arg_181_1.time_ <= 2.03400000184774 + arg_184_0 then
				arg_181_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 2.03400000184774 < arg_181_1.time_ and arg_181_1.time_ <= 2.03400000184774 + arg_184_0 then
				arg_181_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				local var_184_4 = arg_181_1.bgs_.I12f

				arg_181_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_184_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_5 = var_184_4:GetComponent("SpriteRenderer")

				if var_184_5 and var_184_5.sprite then
					local var_184_6 = 2 * (var_184_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_184_4.transform.localScale = Vector3.New(var_184_6 / var_184_5.sprite.bounds.size.y < var_184_6 * manager.ui.mainCameraCom_.aspect / var_184_5.sprite.bounds.size.x and var_184_6 * manager.ui.mainCameraCom_.aspect / var_184_5.sprite.bounds.size.x or var_184_6 / var_184_5.sprite.bounds.size.y, var_184_6 / var_184_5.sprite.bounds.size.y < var_184_6 * manager.ui.mainCameraCom_.aspect / var_184_5.sprite.bounds.size.x and var_184_6 * manager.ui.mainCameraCom_.aspect / var_184_5.sprite.bounds.size.x or var_184_6 / var_184_5.sprite.bounds.size.y, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "I12f" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				local var_184_7 = arg_181_1.bgs_.I12f

				arg_181_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_184_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_8 = var_184_7:GetComponent("SpriteRenderer")

				if var_184_8 and var_184_8.sprite then
					local var_184_9 = 2 * (var_184_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_184_7.transform.localScale = Vector3.New(var_184_9 / var_184_8.sprite.bounds.size.y < var_184_9 * manager.ui.mainCameraCom_.aspect / var_184_8.sprite.bounds.size.x and var_184_9 * manager.ui.mainCameraCom_.aspect / var_184_8.sprite.bounds.size.x or var_184_9 / var_184_8.sprite.bounds.size.y, var_184_9 / var_184_8.sprite.bounds.size.y < var_184_9 * manager.ui.mainCameraCom_.aspect / var_184_8.sprite.bounds.size.x and var_184_9 * manager.ui.mainCameraCom_.aspect / var_184_8.sprite.bounds.size.x or var_184_9 / var_184_8.sprite.bounds.size.y, 0)
				end

				for iter_184_2, iter_184_3 in pairs(arg_181_1.bgs_) do
					if iter_184_2 ~= "I12f" then
						iter_184_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_10 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_11 = 1

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 then
				local var_184_12 = Color.New(0, 0, 0)

				var_184_12.a = Mathf.Lerp(0, 1, (arg_181_1.time_ - var_184_10) / var_184_11)
				arg_181_1.mask_.color = var_184_12
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 then
				local var_184_13 = Color.New(0, 0, 0)

				var_184_13.a = 1
				arg_181_1.mask_.color = var_184_13
			end

			local var_184_14 = 1

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_15 = 1.03400000184774

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_15 then
				local var_184_16 = Color.New(0, 0, 0)

				var_184_16.a = Mathf.Lerp(1, 0, (arg_181_1.time_ - var_184_14) / var_184_15)
				arg_181_1.mask_.color = var_184_16
			end

			if arg_181_1.time_ >= var_184_14 + var_184_15 and arg_181_1.time_ < var_184_14 + var_184_15 + arg_184_0 then
				local var_184_17 = Color.New(0, 0, 0)

				arg_181_1.mask_.enabled = false
				var_184_17.a = 0
				arg_181_1.mask_.color = var_184_17
			end

			local var_184_18 = arg_181_1.actors_["1095ui_story"].transform

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1095ui_story = var_184_18.localPosition
			end

			local var_184_19 = 0.001

			if 1 <= arg_181_1.time_ and arg_181_1.time_ < 1 + var_184_19 then
				var_184_18.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 1) / var_184_19)
				var_184_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_18.position).x, (manager.ui.mainCamera.transform.position - var_184_18.position).y, (manager.ui.mainCamera.transform.position - var_184_18.position).z)
				var_184_18.localEulerAngles.z = 0
				var_184_18.localEulerAngles.x = 0
				var_184_18.localEulerAngles = var_184_18.localEulerAngles
			end

			if arg_181_1.time_ >= 1 + var_184_19 and arg_181_1.time_ < 1 + var_184_19 + arg_184_0 then
				var_184_18.localPosition = Vector3.New(0, 100, 0)
				var_184_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_18.position).x, (manager.ui.mainCamera.transform.position - var_184_18.position).y, (manager.ui.mainCamera.transform.position - var_184_18.position).z)
				var_184_18.localEulerAngles.z = 0
				var_184_18.localEulerAngles.x = 0
				var_184_18.localEulerAngles = var_184_18.localEulerAngles
			end

			local var_184_20 = arg_181_1.actors_["10079ui_story"].transform

			if 1 < arg_181_1.time_ and arg_181_1.time_ <= 1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10079ui_story = var_184_20.localPosition
			end

			local var_184_21 = 0.001

			if 1 <= arg_181_1.time_ and arg_181_1.time_ < 1 + var_184_21 then
				var_184_20.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 1) / var_184_21)
				var_184_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_20.position).x, (manager.ui.mainCamera.transform.position - var_184_20.position).y, (manager.ui.mainCamera.transform.position - var_184_20.position).z)
				var_184_20.localEulerAngles.z = 0
				var_184_20.localEulerAngles.x = 0
				var_184_20.localEulerAngles = var_184_20.localEulerAngles
			end

			if arg_181_1.time_ >= 1 + var_184_21 and arg_181_1.time_ < 1 + var_184_21 + arg_184_0 then
				var_184_20.localPosition = Vector3.New(0, 100, 0)
				var_184_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_20.position).x, (manager.ui.mainCamera.transform.position - var_184_20.position).y, (manager.ui.mainCamera.transform.position - var_184_20.position).z)
				var_184_20.localEulerAngles.z = 0
				var_184_20.localEulerAngles.x = 0
				var_184_20.localEulerAngles = var_184_20.localEulerAngles
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_22 = 2.03400000184774
			local var_184_23 = 0.1

			if 2.03400000184774 < arg_181_1.time_ and arg_181_1.time_ <= var_184_22 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_24 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_24:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_25 = arg_181_1:GetWordFromCfg(319321044)
				local var_184_26 = arg_181_1:FormatText(var_184_25.content)

				arg_181_1.text_.text = var_184_26

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_28 = 4 <= 0 and var_184_23 or var_184_23 * (utf8.len(var_184_26) / 4)

				if (4 <= 0 and var_184_23 or var_184_23 * (utf8.len(var_184_26) / 4)) > 0 and var_184_23 < var_184_28 then
					arg_181_1.talkMaxDuration = var_184_28
					var_184_22 = var_184_22 + 0.3

					if var_184_28 + var_184_22 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_28 + var_184_22
					end
				end

				arg_181_1.text_.text = var_184_26
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321044", "story_v_out_319321.awb") ~= 0 then
					local var_184_29 = manager.audio:GetVoiceLength("story_v_out_319321", "319321044", "story_v_out_319321.awb") / 1000

					if var_184_29 + var_184_22 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_29 + var_184_22
					end

					if var_184_25.prefab_name ~= "" and arg_181_1.actors_[var_184_25.prefab_name] ~= nil then
						local var_184_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_25.prefab_name].transform, "story_v_out_319321", "319321044", "story_v_out_319321.awb")

						arg_181_1:RecordAudio("319321044", var_184_30)
						arg_181_1:RecordAudio("319321044", var_184_30)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319321", "319321044", "story_v_out_319321.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319321", "319321044", "story_v_out_319321.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_31 = var_184_22 + 0.3
			local var_184_32 = math.max(var_184_23, arg_181_1.talkMaxDuration)

			if var_184_22 + 0.3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_31 + var_184_32 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_31) / var_184_32

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_31 + var_184_32 and arg_181_1.time_ < var_184_31 + var_184_32 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.03400000184774,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play319321045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319321045
		arg_187_1.duration_ = 4.7

		local var_187_0 = {
			zh = 2.3,
			ja = 4.7
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
				arg_187_0:Play319321046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10079ui_story = arg_187_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).z)
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles = arg_187_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_187_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["10079ui_story"].transform.position).z)
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["10079ui_story"].transform.localEulerAngles = arg_187_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["10079ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10079ui_story == nil then
				arg_187_1.var_.characterEffect10079ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect10079ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect10079ui_story then
				arg_187_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_190_4 = arg_187_1.actors_["1095ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect1095ui_story == nil then
				arg_187_1.var_.characterEffect1095ui_story = var_190_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_5 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_5 and not isNil(var_190_4) then
				if arg_187_1.var_.characterEffect1095ui_story and not isNil(var_190_4) then
					arg_187_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_5)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_5 and arg_187_1.time_ < 0 + var_190_5 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect1095ui_story then
				arg_187_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_190_6 = arg_187_1.actors_["1095ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1095ui_story = var_190_6.localPosition
			end

			local var_190_7 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				var_190_6.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 0) / var_190_7)
				var_190_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_6.position).x, (manager.ui.mainCamera.transform.position - var_190_6.position).y, (manager.ui.mainCamera.transform.position - var_190_6.position).z)
				var_190_6.localEulerAngles.z = 0
				var_190_6.localEulerAngles.x = 0
				var_190_6.localEulerAngles = var_190_6.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				var_190_6.localPosition = Vector3.New(0, 100, 0)
				var_190_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_6.position).x, (manager.ui.mainCamera.transform.position - var_190_6.position).y, (manager.ui.mainCamera.transform.position - var_190_6.position).z)
				var_190_6.localEulerAngles.z = 0
				var_190_6.localEulerAngles.x = 0
				var_190_6.localEulerAngles = var_190_6.localEulerAngles
			end

			local var_190_8 = 0
			local var_190_9 = 0.275

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(319321045)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 11 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 11)

				if (11 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 11)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321045", "story_v_out_319321.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_319321", "319321045", "story_v_out_319321.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_319321", "319321045", "story_v_out_319321.awb")

						arg_187_1:RecordAudio("319321045", var_190_15)
						arg_187_1:RecordAudio("319321045", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319321", "319321045", "story_v_out_319321.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319321", "319321045", "story_v_out_319321.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319321046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319321046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319321047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1095ui_story = arg_191_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1095ui_story"].transform.position).z)
				arg_191_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1095ui_story"].transform.localEulerAngles = arg_191_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1095ui_story"].transform.position).z)
				arg_191_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1095ui_story"].transform.localEulerAngles = arg_191_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1095ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1095ui_story == nil then
				arg_191_1.var_.characterEffect1095ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1095ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_2)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1095ui_story then
				arg_191_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_194_3 = arg_191_1.actors_["10079ui_story"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10079ui_story = var_194_3.localPosition
			end

			local var_194_4 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				var_194_3.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_191_1.time_ - 0) / var_194_4)
				var_194_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_3.position).x, (manager.ui.mainCamera.transform.position - var_194_3.position).y, (manager.ui.mainCamera.transform.position - var_194_3.position).z)
				var_194_3.localEulerAngles.z = 0
				var_194_3.localEulerAngles.x = 0
				var_194_3.localEulerAngles = var_194_3.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				var_194_3.localPosition = Vector3.New(0, 100, 0)
				var_194_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_194_3.position).x, (manager.ui.mainCamera.transform.position - var_194_3.position).y, (manager.ui.mainCamera.transform.position - var_194_3.position).z)
				var_194_3.localEulerAngles.z = 0
				var_194_3.localEulerAngles.x = 0
				var_194_3.localEulerAngles = var_194_3.localEulerAngles
			end

			local var_194_5 = arg_191_1.actors_["10079ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.characterEffect10079ui_story == nil then
				arg_191_1.var_.characterEffect10079ui_story = var_194_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_6 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_6 and not isNil(var_194_5) then
				if arg_191_1.var_.characterEffect10079ui_story and not isNil(var_194_5) then
					arg_191_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_6)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_6 and arg_191_1.time_ < 0 + var_194_6 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.characterEffect10079ui_story then
				arg_191_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_194_7 = 0
			local var_194_8 = 1.4

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_9 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(319321046).content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 56 <= 0 and var_194_8 or var_194_8 * (utf8.len(var_194_9) / 56)

				if (56 <= 0 and var_194_8 or var_194_8 * (utf8.len(var_194_9) / 56)) > 0 and var_194_8 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_7 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_7
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_8, arg_191_1.talkMaxDuration)

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_7) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_7 + var_194_12 and arg_191_1.time_ < var_194_7 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319321047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319321047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play319321048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.975

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(319321047).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 39 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 39)

				if (39 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 39)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319321048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319321048
		arg_199_1.duration_ = 8

		local var_199_0 = {
			zh = 6.566,
			ja = 8
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
				arg_199_0:Play319321049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 4 < arg_199_1.time_ and arg_199_1.time_ <= 4 + arg_202_0 then
				arg_199_1.var_.moveOldPos4040ui_story = arg_199_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 4 <= arg_199_1.time_ and arg_199_1.time_ < 4 + var_202_0 then
				arg_199_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_199_1.time_ - 4) / var_202_0)
				arg_199_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["4040ui_story"].transform.position).z)
				arg_199_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["4040ui_story"].transform.localEulerAngles = arg_199_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 4 + var_202_0 and arg_199_1.time_ < 4 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_199_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["4040ui_story"].transform.position).z)
				arg_199_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["4040ui_story"].transform.localEulerAngles = arg_199_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["4040ui_story"]

			if 4 < arg_199_1.time_ and arg_199_1.time_ <= 4 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect4040ui_story == nil then
				arg_199_1.var_.characterEffect4040ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 4 <= arg_199_1.time_ and arg_199_1.time_ < 4 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect4040ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 4 + var_202_2 and arg_199_1.time_ < 4 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect4040ui_story then
				arg_199_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 4 < arg_199_1.time_ and arg_199_1.time_ <= 4 + arg_202_0 then
				arg_199_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 4 < arg_199_1.time_ and arg_199_1.time_ <= 4 + arg_202_0 then
				arg_199_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				local var_202_4 = arg_199_1.bgs_.I12f

				arg_199_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_202_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_5 = var_202_4:GetComponent("SpriteRenderer")

				if var_202_5 and var_202_5.sprite then
					local var_202_6 = 2 * (var_202_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_202_4.transform.localScale = Vector3.New(var_202_6 / var_202_5.sprite.bounds.size.y < var_202_6 * manager.ui.mainCameraCom_.aspect / var_202_5.sprite.bounds.size.x and var_202_6 * manager.ui.mainCameraCom_.aspect / var_202_5.sprite.bounds.size.x or var_202_6 / var_202_5.sprite.bounds.size.y, var_202_6 / var_202_5.sprite.bounds.size.y < var_202_6 * manager.ui.mainCameraCom_.aspect / var_202_5.sprite.bounds.size.x and var_202_6 * manager.ui.mainCameraCom_.aspect / var_202_5.sprite.bounds.size.x or var_202_6 / var_202_5.sprite.bounds.size.y, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "I12f" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= 2 + arg_202_0 then
				local var_202_7 = arg_199_1.bgs_.I12f

				arg_199_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_202_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_8 = var_202_7:GetComponent("SpriteRenderer")

				if var_202_8 and var_202_8.sprite then
					local var_202_9 = 2 * (var_202_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_202_7.transform.localScale = Vector3.New(var_202_9 / var_202_8.sprite.bounds.size.y < var_202_9 * manager.ui.mainCameraCom_.aspect / var_202_8.sprite.bounds.size.x and var_202_9 * manager.ui.mainCameraCom_.aspect / var_202_8.sprite.bounds.size.x or var_202_9 / var_202_8.sprite.bounds.size.y, var_202_9 / var_202_8.sprite.bounds.size.y < var_202_9 * manager.ui.mainCameraCom_.aspect / var_202_8.sprite.bounds.size.x and var_202_9 * manager.ui.mainCameraCom_.aspect / var_202_8.sprite.bounds.size.x or var_202_9 / var_202_8.sprite.bounds.size.y, 0)
				end

				for iter_202_2, iter_202_3 in pairs(arg_199_1.bgs_) do
					if iter_202_2 ~= "I12f" then
						iter_202_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_10 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_11 = 2

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 then
				local var_202_12 = Color.New(0, 0, 0)

				var_202_12.a = Mathf.Lerp(0, 1, (arg_199_1.time_ - var_202_10) / var_202_11)
				arg_199_1.mask_.color = var_202_12
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 then
				local var_202_13 = Color.New(0, 0, 0)

				var_202_13.a = 1
				arg_199_1.mask_.color = var_202_13
			end

			local var_202_14 = 2

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_14 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_15 = 2

			if var_202_14 <= arg_199_1.time_ and arg_199_1.time_ < var_202_14 + var_202_15 then
				local var_202_16 = Color.New(0, 0, 0)

				var_202_16.a = Mathf.Lerp(1, 0, (arg_199_1.time_ - var_202_14) / var_202_15)
				arg_199_1.mask_.color = var_202_16
			end

			if arg_199_1.time_ >= var_202_14 + var_202_15 and arg_199_1.time_ < var_202_14 + var_202_15 + arg_202_0 then
				local var_202_17 = Color.New(0, 0, 0)

				arg_199_1.mask_.enabled = false
				var_202_17.a = 0
				arg_199_1.mask_.color = var_202_17
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_18 = 4
			local var_202_19 = 0.1

			if 4 < arg_199_1.time_ and arg_199_1.time_ <= var_202_18 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_20 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_20:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_21 = arg_199_1:GetWordFromCfg(319321048)
				local var_202_22 = arg_199_1:FormatText(var_202_21.content)

				arg_199_1.text_.text = var_202_22

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_24 = 4 <= 0 and var_202_19 or var_202_19 * (utf8.len(var_202_22) / 4)

				if (4 <= 0 and var_202_19 or var_202_19 * (utf8.len(var_202_22) / 4)) > 0 and var_202_19 < var_202_24 then
					arg_199_1.talkMaxDuration = var_202_24
					var_202_18 = var_202_18 + 0.3

					if var_202_24 + var_202_18 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_24 + var_202_18
					end
				end

				arg_199_1.text_.text = var_202_22
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321048", "story_v_out_319321.awb") ~= 0 then
					local var_202_25 = manager.audio:GetVoiceLength("story_v_out_319321", "319321048", "story_v_out_319321.awb") / 1000

					if var_202_25 + var_202_18 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_25 + var_202_18
					end

					if var_202_21.prefab_name ~= "" and arg_199_1.actors_[var_202_21.prefab_name] ~= nil then
						local var_202_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_21.prefab_name].transform, "story_v_out_319321", "319321048", "story_v_out_319321.awb")

						arg_199_1:RecordAudio("319321048", var_202_26)
						arg_199_1:RecordAudio("319321048", var_202_26)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319321", "319321048", "story_v_out_319321.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319321", "319321048", "story_v_out_319321.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_27 = var_202_18 + 0.3
			local var_202_28 = math.max(var_202_19, arg_199_1.talkMaxDuration)

			if var_202_18 + 0.3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_27 + var_202_28 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_27) / var_202_28

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_27 + var_202_28 and arg_199_1.time_ < var_202_27 + var_202_28 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play319321049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319321049
		arg_205_1.duration_ = 5.53

		local var_205_0 = {
			zh = 2.1,
			ja = 5.533
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play319321050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1095ui_story = arg_205_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1095ui_story"].transform.position).z)
				arg_205_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1095ui_story"].transform.localEulerAngles = arg_205_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_205_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1095ui_story"].transform.position).z)
				arg_205_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1095ui_story"].transform.localEulerAngles = arg_205_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1095ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1095ui_story == nil then
				arg_205_1.var_.characterEffect1095ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1095ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1095ui_story then
				arg_205_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_208_4 = arg_205_1.actors_["4040ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos4040ui_story = var_208_4.localPosition
			end

			local var_208_5 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_5 then
				var_208_4.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_205_1.time_ - 0) / var_208_5)
				var_208_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_4.position).x, (manager.ui.mainCamera.transform.position - var_208_4.position).y, (manager.ui.mainCamera.transform.position - var_208_4.position).z)
				var_208_4.localEulerAngles.z = 0
				var_208_4.localEulerAngles.x = 0
				var_208_4.localEulerAngles = var_208_4.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_5 and arg_205_1.time_ < 0 + var_208_5 + arg_208_0 then
				var_208_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_208_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_4.position).x, (manager.ui.mainCamera.transform.position - var_208_4.position).y, (manager.ui.mainCamera.transform.position - var_208_4.position).z)
				var_208_4.localEulerAngles.z = 0
				var_208_4.localEulerAngles.x = 0
				var_208_4.localEulerAngles = var_208_4.localEulerAngles
			end

			local var_208_6 = arg_205_1.actors_["4040ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect4040ui_story == nil then
				arg_205_1.var_.characterEffect4040ui_story = var_208_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_7 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 and not isNil(var_208_6) then
				if arg_205_1.var_.characterEffect4040ui_story and not isNil(var_208_6) then
					arg_205_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_205_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_7)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect4040ui_story then
				arg_205_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_205_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_208_8 = 0
			local var_208_9 = 0.25

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_10 = arg_205_1:GetWordFromCfg(319321049)
				local var_208_11 = arg_205_1:FormatText(var_208_10.content)

				arg_205_1.text_.text = var_208_11

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_13 = 10 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 10)

				if (10 <= 0 and var_208_9 or var_208_9 * (utf8.len(var_208_11) / 10)) > 0 and var_208_9 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_8
					end
				end

				arg_205_1.text_.text = var_208_11
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321049", "story_v_out_319321.awb") ~= 0 then
					local var_208_14 = manager.audio:GetVoiceLength("story_v_out_319321", "319321049", "story_v_out_319321.awb") / 1000

					if var_208_14 + var_208_8 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_14 + var_208_8
					end

					if var_208_10.prefab_name ~= "" and arg_205_1.actors_[var_208_10.prefab_name] ~= nil then
						local var_208_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_10.prefab_name].transform, "story_v_out_319321", "319321049", "story_v_out_319321.awb")

						arg_205_1:RecordAudio("319321049", var_208_15)
						arg_205_1:RecordAudio("319321049", var_208_15)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319321", "319321049", "story_v_out_319321.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319321", "319321049", "story_v_out_319321.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_16 = math.max(var_208_9, arg_205_1.talkMaxDuration)

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_16 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_8) / var_208_16

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_8 + var_208_16 and arg_205_1.time_ < var_208_8 + var_208_16 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play319321050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319321050
		arg_209_1.duration_ = 10.8

		local var_209_0 = {
			zh = 6.2,
			ja = 10.8
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play319321051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos4040ui_story = arg_209_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).z)
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles = arg_209_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_209_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["4040ui_story"].transform.position).z)
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["4040ui_story"].transform.localEulerAngles = arg_209_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["4040ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect4040ui_story == nil then
				arg_209_1.var_.characterEffect4040ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect4040ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect4040ui_story then
				arg_209_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["1095ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1095ui_story == nil then
				arg_209_1.var_.characterEffect1095ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_5 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 and not isNil(var_212_4) then
				if arg_209_1.var_.characterEffect1095ui_story and not isNil(var_212_4) then
					arg_209_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_5)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect1095ui_story then
				arg_209_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_6 = 0
			local var_212_7 = 0.875

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(319321050)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 35 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 35)

				if (35 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 35)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321050", "story_v_out_319321.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_319321", "319321050", "story_v_out_319321.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_out_319321", "319321050", "story_v_out_319321.awb")

						arg_209_1:RecordAudio("319321050", var_212_13)
						arg_209_1:RecordAudio("319321050", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319321", "319321050", "story_v_out_319321.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319321", "319321050", "story_v_out_319321.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play319321051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319321051
		arg_213_1.duration_ = 5.57

		local var_213_0 = {
			zh = 2.1,
			ja = 5.566
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play319321052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["4040ui_story"]) and arg_213_1.var_.characterEffect4040ui_story == nil then
				arg_213_1.var_.characterEffect4040ui_story = arg_213_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["4040ui_story"]) then
				if arg_213_1.var_.characterEffect4040ui_story and not isNil(arg_213_1.actors_["4040ui_story"]) then
					arg_213_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_213_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["4040ui_story"]) and arg_213_1.var_.characterEffect4040ui_story then
				arg_213_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_213_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_1 = arg_213_1.actors_["1095ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1095ui_story == nil then
				arg_213_1.var_.characterEffect1095ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1095ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1095ui_story then
				arg_213_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_216_4 = 0
			local var_216_5 = 0.125

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(319321051)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 5 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 5)

				if (5 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 5)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321051", "story_v_out_319321.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321051", "story_v_out_319321.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_319321", "319321051", "story_v_out_319321.awb")

						arg_213_1:RecordAudio("319321051", var_216_11)
						arg_213_1:RecordAudio("319321051", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319321", "319321051", "story_v_out_319321.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319321", "319321051", "story_v_out_319321.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319321052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319321052
		arg_217_1.duration_ = 6.1

		local var_217_0 = {
			zh = 4.933,
			ja = 6.1
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319321053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["4040ui_story"]) and arg_217_1.var_.characterEffect4040ui_story == nil then
				arg_217_1.var_.characterEffect4040ui_story = arg_217_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["4040ui_story"]) then
				if arg_217_1.var_.characterEffect4040ui_story and not isNil(arg_217_1.actors_["4040ui_story"]) then
					arg_217_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["4040ui_story"]) and arg_217_1.var_.characterEffect4040ui_story then
				arg_217_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_220_2 = arg_217_1.actors_["1095ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.characterEffect1095ui_story == nil then
				arg_217_1.var_.characterEffect1095ui_story = var_220_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_3 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.characterEffect1095ui_story and not isNil(var_220_2) then
					arg_217_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_3)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.characterEffect1095ui_story then
				arg_217_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_220_4 = 0
			local var_220_5 = 0.475

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:GetWordFromCfg(319321052)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 19 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 19)

				if (19 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 19)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321052", "story_v_out_319321.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321052", "story_v_out_319321.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_out_319321", "319321052", "story_v_out_319321.awb")

						arg_217_1:RecordAudio("319321052", var_220_11)
						arg_217_1:RecordAudio("319321052", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_319321", "319321052", "story_v_out_319321.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_319321", "319321052", "story_v_out_319321.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319321053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319321053
		arg_221_1.duration_ = 12

		local var_221_0 = {
			zh = 6.866,
			ja = 12
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
				arg_221_0:Play319321054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.8

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(319321053)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 32 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 32)

				if (32 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 32)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321053", "story_v_out_319321.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_319321", "319321053", "story_v_out_319321.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_319321", "319321053", "story_v_out_319321.awb")

						arg_221_1:RecordAudio("319321053", var_224_6)
						arg_221_1:RecordAudio("319321053", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319321", "319321053", "story_v_out_319321.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319321", "319321053", "story_v_out_319321.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play319321054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319321054
		arg_225_1.duration_ = 8.37

		local var_225_0 = {
			zh = 4.5,
			ja = 8.366
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319321055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["4040ui_story"]) and arg_225_1.var_.characterEffect4040ui_story == nil then
				arg_225_1.var_.characterEffect4040ui_story = arg_225_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["4040ui_story"]) then
				if arg_225_1.var_.characterEffect4040ui_story and not isNil(arg_225_1.actors_["4040ui_story"]) then
					arg_225_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_225_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["4040ui_story"]) and arg_225_1.var_.characterEffect4040ui_story then
				arg_225_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_225_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_228_1 = arg_225_1.actors_["1095ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1095ui_story == nil then
				arg_225_1.var_.characterEffect1095ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1095ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1095ui_story then
				arg_225_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_228_4 = 0
			local var_228_5 = 0.5

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(319321054)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 20 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 20)

				if (20 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 20)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321054", "story_v_out_319321.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321054", "story_v_out_319321.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_319321", "319321054", "story_v_out_319321.awb")

						arg_225_1:RecordAudio("319321054", var_228_11)
						arg_225_1:RecordAudio("319321054", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_319321", "319321054", "story_v_out_319321.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_319321", "319321054", "story_v_out_319321.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play319321055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319321055
		arg_229_1.duration_ = 7.03

		local var_229_0 = {
			zh = 4.066,
			ja = 7.033
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play319321056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["4040ui_story"]) and arg_229_1.var_.characterEffect4040ui_story == nil then
				arg_229_1.var_.characterEffect4040ui_story = arg_229_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["4040ui_story"]) then
				if arg_229_1.var_.characterEffect4040ui_story and not isNil(arg_229_1.actors_["4040ui_story"]) then
					arg_229_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["4040ui_story"]) and arg_229_1.var_.characterEffect4040ui_story then
				arg_229_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_232_2 = arg_229_1.actors_["1095ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1095ui_story == nil then
				arg_229_1.var_.characterEffect1095ui_story = var_232_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.characterEffect1095ui_story and not isNil(var_232_2) then
					arg_229_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_3)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1095ui_story then
				arg_229_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_232_4 = 0
			local var_232_5 = 0.525

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(319321055)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 21 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 21)

				if (21 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 21)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321055", "story_v_out_319321.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321055", "story_v_out_319321.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_319321", "319321055", "story_v_out_319321.awb")

						arg_229_1:RecordAudio("319321055", var_232_11)
						arg_229_1:RecordAudio("319321055", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319321", "319321055", "story_v_out_319321.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319321", "319321055", "story_v_out_319321.awb")
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

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play319321056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319321056
		arg_233_1.duration_ = 6.57

		local var_233_0 = {
			zh = 4,
			ja = 6.566
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play319321057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1095ui_story = arg_233_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).z)
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles = arg_233_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_233_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1095ui_story"].transform.position).z)
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1095ui_story"].transform.localEulerAngles = arg_233_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1095ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1095ui_story == nil then
				arg_233_1.var_.characterEffect1095ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1095ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1095ui_story then
				arg_233_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_236_4 = arg_233_1.actors_["4040ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect4040ui_story == nil then
				arg_233_1.var_.characterEffect4040ui_story = var_236_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_5 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_5 and not isNil(var_236_4) then
				if arg_233_1.var_.characterEffect4040ui_story and not isNil(var_236_4) then
					arg_233_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_233_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_5)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_5 and arg_233_1.time_ < 0 + var_236_5 + arg_236_0 and not isNil(var_236_4) and arg_233_1.var_.characterEffect4040ui_story then
				arg_233_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_233_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_236_6 = 0
			local var_236_7 = 0.375

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_8 = arg_233_1:GetWordFromCfg(319321056)
				local var_236_9 = arg_233_1:FormatText(var_236_8.content)

				arg_233_1.text_.text = var_236_9

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_11 = 15 <= 0 and var_236_7 or var_236_7 * (utf8.len(var_236_9) / 15)

				if (15 <= 0 and var_236_7 or var_236_7 * (utf8.len(var_236_9) / 15)) > 0 and var_236_7 < var_236_11 then
					arg_233_1.talkMaxDuration = var_236_11

					if var_236_11 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_6
					end
				end

				arg_233_1.text_.text = var_236_9
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321056", "story_v_out_319321.awb") ~= 0 then
					local var_236_12 = manager.audio:GetVoiceLength("story_v_out_319321", "319321056", "story_v_out_319321.awb") / 1000

					if var_236_12 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_12 + var_236_6
					end

					if var_236_8.prefab_name ~= "" and arg_233_1.actors_[var_236_8.prefab_name] ~= nil then
						local var_236_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_8.prefab_name].transform, "story_v_out_319321", "319321056", "story_v_out_319321.awb")

						arg_233_1:RecordAudio("319321056", var_236_13)
						arg_233_1:RecordAudio("319321056", var_236_13)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_319321", "319321056", "story_v_out_319321.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_319321", "319321056", "story_v_out_319321.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_14 = math.max(var_236_7, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_14 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_6) / var_236_14

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_14 and arg_233_1.time_ < var_236_6 + var_236_14 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play319321057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319321057
		arg_237_1.duration_ = 4.1

		local var_237_0 = {
			zh = 1.433,
			ja = 4.1
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
				arg_237_0:Play319321058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos4040ui_story = arg_237_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["4040ui_story"].transform.position).z)
				arg_237_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["4040ui_story"].transform.localEulerAngles = arg_237_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_237_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["4040ui_story"].transform.position).z)
				arg_237_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["4040ui_story"].transform.localEulerAngles = arg_237_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["4040ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect4040ui_story == nil then
				arg_237_1.var_.characterEffect4040ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect4040ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect4040ui_story then
				arg_237_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_240_4 = arg_237_1.actors_["1095ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1095ui_story == nil then
				arg_237_1.var_.characterEffect1095ui_story = var_240_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_5 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_5 and not isNil(var_240_4) then
				if arg_237_1.var_.characterEffect1095ui_story and not isNil(var_240_4) then
					arg_237_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_5)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_5 and arg_237_1.time_ < 0 + var_240_5 + arg_240_0 and not isNil(var_240_4) and arg_237_1.var_.characterEffect1095ui_story then
				arg_237_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_240_6 = 0
			local var_240_7 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(319321057)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 5 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 5)

				if (5 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 5)) > 0 and var_240_7 < var_240_11 then
					arg_237_1.talkMaxDuration = var_240_11

					if var_240_11 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321057", "story_v_out_319321.awb") ~= 0 then
					local var_240_12 = manager.audio:GetVoiceLength("story_v_out_319321", "319321057", "story_v_out_319321.awb") / 1000

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end

					if var_240_8.prefab_name ~= "" and arg_237_1.actors_[var_240_8.prefab_name] ~= nil then
						local var_240_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_8.prefab_name].transform, "story_v_out_319321", "319321057", "story_v_out_319321.awb")

						arg_237_1:RecordAudio("319321057", var_240_13)
						arg_237_1:RecordAudio("319321057", var_240_13)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_319321", "319321057", "story_v_out_319321.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_319321", "319321057", "story_v_out_319321.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319321058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319321058
		arg_241_1.duration_ = 6.8

		local var_241_0 = {
			zh = 2.766,
			ja = 6.8
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
				arg_241_0:Play319321059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["4040ui_story"]) and arg_241_1.var_.characterEffect4040ui_story == nil then
				arg_241_1.var_.characterEffect4040ui_story = arg_241_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["4040ui_story"]) then
				if arg_241_1.var_.characterEffect4040ui_story and not isNil(arg_241_1.actors_["4040ui_story"]) then
					arg_241_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_241_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_0)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["4040ui_story"]) and arg_241_1.var_.characterEffect4040ui_story then
				arg_241_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_241_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_244_1 = arg_241_1.actors_["1095ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1095ui_story == nil then
				arg_241_1.var_.characterEffect1095ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1095ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1095ui_story then
				arg_241_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_244_4 = 0
			local var_244_5 = 0.35

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:GetWordFromCfg(319321058)
				local var_244_7 = arg_241_1:FormatText(var_244_6.content)

				arg_241_1.text_.text = var_244_7

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_9 = 14 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 14)

				if (14 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_7) / 14)) > 0 and var_244_5 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_7
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321058", "story_v_out_319321.awb") ~= 0 then
					local var_244_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321058", "story_v_out_319321.awb") / 1000

					if var_244_10 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_4
					end

					if var_244_6.prefab_name ~= "" and arg_241_1.actors_[var_244_6.prefab_name] ~= nil then
						local var_244_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_6.prefab_name].transform, "story_v_out_319321", "319321058", "story_v_out_319321.awb")

						arg_241_1:RecordAudio("319321058", var_244_11)
						arg_241_1:RecordAudio("319321058", var_244_11)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_319321", "319321058", "story_v_out_319321.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_319321", "319321058", "story_v_out_319321.awb")
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

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319321059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319321059
		arg_245_1.duration_ = 9.23

		local var_245_0 = {
			zh = 5.3,
			ja = 9.233
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
				arg_245_0:Play319321060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1095ui_story = arg_245_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).z)
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles = arg_245_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_245_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1095ui_story"].transform.position).z)
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1095ui_story"].transform.localEulerAngles = arg_245_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1095ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1095ui_story == nil then
				arg_245_1.var_.characterEffect1095ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect1095ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect1095ui_story then
				arg_245_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_4 = 0
			local var_248_5 = 0.7

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(319321059)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 28 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 28)

				if (28 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 28)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321059", "story_v_out_319321.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321059", "story_v_out_319321.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_319321", "319321059", "story_v_out_319321.awb")

						arg_245_1:RecordAudio("319321059", var_248_11)
						arg_245_1:RecordAudio("319321059", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319321", "319321059", "story_v_out_319321.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319321", "319321059", "story_v_out_319321.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_12 = math.max(var_248_5, arg_245_1.talkMaxDuration)

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_12 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_4) / var_248_12

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_4 + var_248_12 and arg_245_1.time_ < var_248_4 + var_248_12 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play319321060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319321060
		arg_249_1.duration_ = 5.97

		local var_249_0 = {
			zh = 3.266,
			ja = 5.966
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play319321061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["4040ui_story"]) and arg_249_1.var_.characterEffect4040ui_story == nil then
				arg_249_1.var_.characterEffect4040ui_story = arg_249_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["4040ui_story"]) then
				if arg_249_1.var_.characterEffect4040ui_story and not isNil(arg_249_1.actors_["4040ui_story"]) then
					arg_249_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["4040ui_story"]) and arg_249_1.var_.characterEffect4040ui_story then
				arg_249_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_252_2 = arg_249_1.actors_["1095ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1095ui_story == nil then
				arg_249_1.var_.characterEffect1095ui_story = var_252_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_3 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 and not isNil(var_252_2) then
				if arg_249_1.var_.characterEffect1095ui_story and not isNil(var_252_2) then
					arg_249_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_3)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 and not isNil(var_252_2) and arg_249_1.var_.characterEffect1095ui_story then
				arg_249_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_252_4 = 0
			local var_252_5 = 0.425

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(319321060)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 17 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 17)

				if (17 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 17)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321060", "story_v_out_319321.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321060", "story_v_out_319321.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_319321", "319321060", "story_v_out_319321.awb")

						arg_249_1:RecordAudio("319321060", var_252_11)
						arg_249_1:RecordAudio("319321060", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_319321", "319321060", "story_v_out_319321.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_319321", "319321060", "story_v_out_319321.awb")
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

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play319321061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319321061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play319321062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["4040ui_story"]) and arg_253_1.var_.characterEffect4040ui_story == nil then
				arg_253_1.var_.characterEffect4040ui_story = arg_253_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["4040ui_story"]) then
				if arg_253_1.var_.characterEffect4040ui_story and not isNil(arg_253_1.actors_["4040ui_story"]) then
					arg_253_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_253_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["4040ui_story"]) and arg_253_1.var_.characterEffect4040ui_story then
				arg_253_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_253_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.65

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

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(319321061).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 26 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 26)

				if (26 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 26)) > 0 and var_256_2 < var_256_5 then
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
	Play319321062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319321062
		arg_257_1.duration_ = 9

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play319321063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				local var_260_0 = arg_257_1.bgs_.I12f

				arg_257_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_1 = var_260_0:GetComponent("SpriteRenderer")

				if var_260_1 and var_260_1.sprite then
					local var_260_2 = 2 * (var_260_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_0.transform.localScale = Vector3.New(var_260_2 / var_260_1.sprite.bounds.size.y < var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x and var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x or var_260_2 / var_260_1.sprite.bounds.size.y, var_260_2 / var_260_1.sprite.bounds.size.y < var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x and var_260_2 * manager.ui.mainCameraCom_.aspect / var_260_1.sprite.bounds.size.x or var_260_2 / var_260_1.sprite.bounds.size.y, 0)
				end

				for iter_260_0, iter_260_1 in pairs(arg_257_1.bgs_) do
					if iter_260_0 ~= "I12f" then
						iter_260_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= 2 + arg_260_0 then
				local var_260_3 = arg_257_1.bgs_.I12f

				arg_257_1.bgs_.I12f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_260_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_260_4 = var_260_3:GetComponent("SpriteRenderer")

				if var_260_4 and var_260_4.sprite then
					local var_260_5 = 2 * (var_260_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_260_3.transform.localScale = Vector3.New(var_260_5 / var_260_4.sprite.bounds.size.y < var_260_5 * manager.ui.mainCameraCom_.aspect / var_260_4.sprite.bounds.size.x and var_260_5 * manager.ui.mainCameraCom_.aspect / var_260_4.sprite.bounds.size.x or var_260_5 / var_260_4.sprite.bounds.size.y, var_260_5 / var_260_4.sprite.bounds.size.y < var_260_5 * manager.ui.mainCameraCom_.aspect / var_260_4.sprite.bounds.size.x and var_260_5 * manager.ui.mainCameraCom_.aspect / var_260_4.sprite.bounds.size.x or var_260_5 / var_260_4.sprite.bounds.size.y, 0)
				end

				for iter_260_2, iter_260_3 in pairs(arg_257_1.bgs_) do
					if iter_260_2 ~= "I12f" then
						iter_260_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_260_6 = 0

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_7 = 2

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_7 then
				local var_260_8 = Color.New(0, 0, 0)

				var_260_8.a = Mathf.Lerp(0, 1, (arg_257_1.time_ - var_260_6) / var_260_7)
				arg_257_1.mask_.color = var_260_8
			end

			if arg_257_1.time_ >= var_260_6 + var_260_7 and arg_257_1.time_ < var_260_6 + var_260_7 + arg_260_0 then
				local var_260_9 = Color.New(0, 0, 0)

				var_260_9.a = 1
				arg_257_1.mask_.color = var_260_9
			end

			local var_260_10 = 2

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1.mask_.enabled = true
				arg_257_1.mask_.raycastTarget = true

				arg_257_1:SetGaussion(false)
			end

			local var_260_11 = 2

			if var_260_10 <= arg_257_1.time_ and arg_257_1.time_ < var_260_10 + var_260_11 then
				local var_260_12 = Color.New(0, 0, 0)

				var_260_12.a = Mathf.Lerp(1, 0, (arg_257_1.time_ - var_260_10) / var_260_11)
				arg_257_1.mask_.color = var_260_12
			end

			if arg_257_1.time_ >= var_260_10 + var_260_11 and arg_257_1.time_ < var_260_10 + var_260_11 + arg_260_0 then
				local var_260_13 = Color.New(0, 0, 0)

				arg_257_1.mask_.enabled = false
				var_260_13.a = 0
				arg_257_1.mask_.color = var_260_13
			end

			local var_260_14 = arg_257_1.actors_["1095ui_story"].transform

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= 2 + arg_260_0 then
				arg_257_1.var_.moveOldPos1095ui_story = var_260_14.localPosition
			end

			local var_260_15 = 0.001

			if 2 <= arg_257_1.time_ and arg_257_1.time_ < 2 + var_260_15 then
				var_260_14.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 2) / var_260_15)
				var_260_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_14.position).x, (manager.ui.mainCamera.transform.position - var_260_14.position).y, (manager.ui.mainCamera.transform.position - var_260_14.position).z)
				var_260_14.localEulerAngles.z = 0
				var_260_14.localEulerAngles.x = 0
				var_260_14.localEulerAngles = var_260_14.localEulerAngles
			end

			if arg_257_1.time_ >= 2 + var_260_15 and arg_257_1.time_ < 2 + var_260_15 + arg_260_0 then
				var_260_14.localPosition = Vector3.New(0, 100, 0)
				var_260_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_14.position).x, (manager.ui.mainCamera.transform.position - var_260_14.position).y, (manager.ui.mainCamera.transform.position - var_260_14.position).z)
				var_260_14.localEulerAngles.z = 0
				var_260_14.localEulerAngles.x = 0
				var_260_14.localEulerAngles = var_260_14.localEulerAngles
			end

			local var_260_16 = arg_257_1.actors_["4040ui_story"].transform

			if 2 < arg_257_1.time_ and arg_257_1.time_ <= 2 + arg_260_0 then
				arg_257_1.var_.moveOldPos4040ui_story = var_260_16.localPosition
			end

			local var_260_17 = 0.001

			if 2 <= arg_257_1.time_ and arg_257_1.time_ < 2 + var_260_17 then
				var_260_16.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 2) / var_260_17)
				var_260_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_16.position).x, (manager.ui.mainCamera.transform.position - var_260_16.position).y, (manager.ui.mainCamera.transform.position - var_260_16.position).z)
				var_260_16.localEulerAngles.z = 0
				var_260_16.localEulerAngles.x = 0
				var_260_16.localEulerAngles = var_260_16.localEulerAngles
			end

			if arg_257_1.time_ >= 2 + var_260_17 and arg_257_1.time_ < 2 + var_260_17 + arg_260_0 then
				var_260_16.localPosition = Vector3.New(0, 100, 0)
				var_260_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_260_16.position).x, (manager.ui.mainCamera.transform.position - var_260_16.position).y, (manager.ui.mainCamera.transform.position - var_260_16.position).z)
				var_260_16.localEulerAngles.z = 0
				var_260_16.localEulerAngles.x = 0
				var_260_16.localEulerAngles = var_260_16.localEulerAngles
			end

			if arg_257_1.frameCnt_ <= 1 then
				arg_257_1.dialog_:SetActive(false)
			end

			local var_260_18 = 4
			local var_260_19 = 1.1

			if 4 < arg_257_1.time_ and arg_257_1.time_ <= var_260_18 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0

				arg_257_1.dialog_:SetActive(true)

				arg_257_1.dialogCg_.alpha = 0

				local var_260_20 = LeanTween.value(arg_257_1.dialog_, 0, 1, 0.3)

				var_260_20:setOnUpdate(LuaHelper.FloatAction(function(arg_261_0)
					arg_257_1.dialogCg_.alpha = arg_261_0
				end))
				var_260_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_257_1.dialog_)
					var_260_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_257_1.duration_ = arg_257_1.duration_ + 0.3

				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_21 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(319321062).content)

				arg_257_1.text_.text = var_260_21

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_23 = 44 <= 0 and var_260_19 or var_260_19 * (utf8.len(var_260_21) / 44)

				if (44 <= 0 and var_260_19 or var_260_19 * (utf8.len(var_260_21) / 44)) > 0 and var_260_19 < var_260_23 then
					arg_257_1.talkMaxDuration = var_260_23
					var_260_18 = var_260_18 + 0.3

					if var_260_23 + var_260_18 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_18
					end
				end

				arg_257_1.text_.text = var_260_21
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_24 = var_260_18 + 0.3
			local var_260_25 = math.max(var_260_19, arg_257_1.talkMaxDuration)

			if var_260_18 + 0.3 <= arg_257_1.time_ and arg_257_1.time_ < var_260_24 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_24) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_24 + var_260_25 and arg_257_1.time_ < var_260_24 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play319321063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 319321063
		arg_263_1.duration_ = 3.97

		local var_263_0 = {
			zh = 3.833,
			ja = 3.966
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play319321064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1095ui_story = arg_263_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1095ui_story"].transform.position).z)
				arg_263_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1095ui_story"].transform.localEulerAngles = arg_263_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_263_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1095ui_story"].transform.position).z)
				arg_263_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1095ui_story"].transform.localEulerAngles = arg_263_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1095ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1095ui_story == nil then
				arg_263_1.var_.characterEffect1095ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1095ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1095ui_story then
				arg_263_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_4 = 0
			local var_266_5 = 0.4

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(319321063)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 16 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 16)

				if (16 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 16)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321063", "story_v_out_319321.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321063", "story_v_out_319321.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_out_319321", "319321063", "story_v_out_319321.awb")

						arg_263_1:RecordAudio("319321063", var_266_11)
						arg_263_1:RecordAudio("319321063", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_319321", "319321063", "story_v_out_319321.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_319321", "319321063", "story_v_out_319321.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play319321064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 319321064
		arg_267_1.duration_ = 6.97

		local var_267_0 = {
			zh = 4.166,
			ja = 6.966
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play319321065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["4040ui_story"]) and arg_267_1.var_.characterEffect4040ui_story == nil then
				arg_267_1.var_.characterEffect4040ui_story = arg_267_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["4040ui_story"]) then
				if arg_267_1.var_.characterEffect4040ui_story and not isNil(arg_267_1.actors_["4040ui_story"]) then
					arg_267_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["4040ui_story"]) and arg_267_1.var_.characterEffect4040ui_story then
				arg_267_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_270_2 = arg_267_1.actors_["1095ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect1095ui_story == nil then
				arg_267_1.var_.characterEffect1095ui_story = var_270_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_3 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.characterEffect1095ui_story and not isNil(var_270_2) then
					arg_267_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_3)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect1095ui_story then
				arg_267_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_270_4 = arg_267_1.actors_["1095ui_story"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1095ui_story = var_270_4.localPosition
			end

			local var_270_5 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_5 then
				var_270_4.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_267_1.time_ - 0) / var_270_5)
				var_270_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_4.position).x, (manager.ui.mainCamera.transform.position - var_270_4.position).y, (manager.ui.mainCamera.transform.position - var_270_4.position).z)
				var_270_4.localEulerAngles.z = 0
				var_270_4.localEulerAngles.x = 0
				var_270_4.localEulerAngles = var_270_4.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_5 and arg_267_1.time_ < 0 + var_270_5 + arg_270_0 then
				var_270_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_270_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_4.position).x, (manager.ui.mainCamera.transform.position - var_270_4.position).y, (manager.ui.mainCamera.transform.position - var_270_4.position).z)
				var_270_4.localEulerAngles.z = 0
				var_270_4.localEulerAngles.x = 0
				var_270_4.localEulerAngles = var_270_4.localEulerAngles
			end

			local var_270_6 = arg_267_1.actors_["4040ui_story"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos4040ui_story = var_270_6.localPosition
			end

			local var_270_7 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				var_270_6.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_267_1.time_ - 0) / var_270_7)
				var_270_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_6.position).x, (manager.ui.mainCamera.transform.position - var_270_6.position).y, (manager.ui.mainCamera.transform.position - var_270_6.position).z)
				var_270_6.localEulerAngles.z = 0
				var_270_6.localEulerAngles.x = 0
				var_270_6.localEulerAngles = var_270_6.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				var_270_6.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_270_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_270_6.position).x, (manager.ui.mainCamera.transform.position - var_270_6.position).y, (manager.ui.mainCamera.transform.position - var_270_6.position).z)
				var_270_6.localEulerAngles.z = 0
				var_270_6.localEulerAngles.x = 0
				var_270_6.localEulerAngles = var_270_6.localEulerAngles
			end

			local var_270_8 = 0
			local var_270_9 = 0.5

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_8 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_10 = arg_267_1:GetWordFromCfg(319321064)
				local var_270_11 = arg_267_1:FormatText(var_270_10.content)

				arg_267_1.text_.text = var_270_11

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_13 = 20 <= 0 and var_270_9 or var_270_9 * (utf8.len(var_270_11) / 20)

				if (20 <= 0 and var_270_9 or var_270_9 * (utf8.len(var_270_11) / 20)) > 0 and var_270_9 < var_270_13 then
					arg_267_1.talkMaxDuration = var_270_13

					if var_270_13 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_13 + var_270_8
					end
				end

				arg_267_1.text_.text = var_270_11
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321064", "story_v_out_319321.awb") ~= 0 then
					local var_270_14 = manager.audio:GetVoiceLength("story_v_out_319321", "319321064", "story_v_out_319321.awb") / 1000

					if var_270_14 + var_270_8 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_14 + var_270_8
					end

					if var_270_10.prefab_name ~= "" and arg_267_1.actors_[var_270_10.prefab_name] ~= nil then
						local var_270_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_10.prefab_name].transform, "story_v_out_319321", "319321064", "story_v_out_319321.awb")

						arg_267_1:RecordAudio("319321064", var_270_15)
						arg_267_1:RecordAudio("319321064", var_270_15)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_319321", "319321064", "story_v_out_319321.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_319321", "319321064", "story_v_out_319321.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_16 = math.max(var_270_9, arg_267_1.talkMaxDuration)

			if var_270_8 <= arg_267_1.time_ and arg_267_1.time_ < var_270_8 + var_270_16 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_8) / var_270_16

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_8 + var_270_16 and arg_267_1.time_ < var_270_8 + var_270_16 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play319321065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 319321065
		arg_271_1.duration_ = 6.83

		local var_271_0 = {
			zh = 2.566,
			ja = 6.833
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play319321066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["4040ui_story"]) and arg_271_1.var_.characterEffect4040ui_story == nil then
				arg_271_1.var_.characterEffect4040ui_story = arg_271_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["4040ui_story"]) then
				if arg_271_1.var_.characterEffect4040ui_story and not isNil(arg_271_1.actors_["4040ui_story"]) then
					arg_271_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_271_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_0)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["4040ui_story"]) and arg_271_1.var_.characterEffect4040ui_story then
				arg_271_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_271_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_274_1 = arg_271_1.actors_["1095ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1095ui_story == nil then
				arg_271_1.var_.characterEffect1095ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect1095ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect1095ui_story then
				arg_271_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_274_4 = 0
			local var_274_5 = 0.25

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_6 = arg_271_1:GetWordFromCfg(319321065)
				local var_274_7 = arg_271_1:FormatText(var_274_6.content)

				arg_271_1.text_.text = var_274_7

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_9 = 10 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 10)

				if (10 <= 0 and var_274_5 or var_274_5 * (utf8.len(var_274_7) / 10)) > 0 and var_274_5 < var_274_9 then
					arg_271_1.talkMaxDuration = var_274_9

					if var_274_9 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_9 + var_274_4
					end
				end

				arg_271_1.text_.text = var_274_7
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321065", "story_v_out_319321.awb") ~= 0 then
					local var_274_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321065", "story_v_out_319321.awb") / 1000

					if var_274_10 + var_274_4 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_4
					end

					if var_274_6.prefab_name ~= "" and arg_271_1.actors_[var_274_6.prefab_name] ~= nil then
						local var_274_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_6.prefab_name].transform, "story_v_out_319321", "319321065", "story_v_out_319321.awb")

						arg_271_1:RecordAudio("319321065", var_274_11)
						arg_271_1:RecordAudio("319321065", var_274_11)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_319321", "319321065", "story_v_out_319321.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_319321", "319321065", "story_v_out_319321.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_12 = math.max(var_274_5, arg_271_1.talkMaxDuration)

			if var_274_4 <= arg_271_1.time_ and arg_271_1.time_ < var_274_4 + var_274_12 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_4) / var_274_12

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_4 + var_274_12 and arg_271_1.time_ < var_274_4 + var_274_12 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play319321066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 319321066
		arg_275_1.duration_ = 2.9

		local var_275_0 = {
			zh = 1.433,
			ja = 2.9
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play319321067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["4040ui_story"]) and arg_275_1.var_.characterEffect4040ui_story == nil then
				arg_275_1.var_.characterEffect4040ui_story = arg_275_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["4040ui_story"]) then
				if arg_275_1.var_.characterEffect4040ui_story and not isNil(arg_275_1.actors_["4040ui_story"]) then
					arg_275_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["4040ui_story"]) and arg_275_1.var_.characterEffect4040ui_story then
				arg_275_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_278_2 = arg_275_1.actors_["1095ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1095ui_story == nil then
				arg_275_1.var_.characterEffect1095ui_story = var_278_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_3 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.characterEffect1095ui_story and not isNil(var_278_2) then
					arg_275_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_3)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1095ui_story then
				arg_275_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_278_4 = 0
			local var_278_5 = 0.075

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(319321066)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 3 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 3)

				if (3 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 3)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321066", "story_v_out_319321.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321066", "story_v_out_319321.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_out_319321", "319321066", "story_v_out_319321.awb")

						arg_275_1:RecordAudio("319321066", var_278_11)
						arg_275_1:RecordAudio("319321066", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_319321", "319321066", "story_v_out_319321.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_319321", "319321066", "story_v_out_319321.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_12 and arg_275_1.time_ < var_278_4 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play319321067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 319321067
		arg_279_1.duration_ = 3.7

		local var_279_0 = {
			zh = 2,
			ja = 3.7
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play319321068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["4040ui_story"]) and arg_279_1.var_.characterEffect4040ui_story == nil then
				arg_279_1.var_.characterEffect4040ui_story = arg_279_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["4040ui_story"]) then
				if arg_279_1.var_.characterEffect4040ui_story and not isNil(arg_279_1.actors_["4040ui_story"]) then
					arg_279_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_279_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["4040ui_story"]) and arg_279_1.var_.characterEffect4040ui_story then
				arg_279_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_279_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_282_1 = arg_279_1.actors_["1095ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1095ui_story == nil then
				arg_279_1.var_.characterEffect1095ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1095ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1095ui_story then
				arg_279_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_282_4 = 0
			local var_282_5 = 0.25

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(319321067)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 10 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 10)

				if (10 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 10)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321067", "story_v_out_319321.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321067", "story_v_out_319321.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_out_319321", "319321067", "story_v_out_319321.awb")

						arg_279_1:RecordAudio("319321067", var_282_11)
						arg_279_1:RecordAudio("319321067", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_319321", "319321067", "story_v_out_319321.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_319321", "319321067", "story_v_out_319321.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play319321068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 319321068
		arg_283_1.duration_ = 3.63

		local var_283_0 = {
			zh = 3,
			ja = 3.633
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play319321069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos4040ui_story = arg_283_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).z)
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles = arg_283_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_283_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).z)
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles = arg_283_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["4040ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect4040ui_story == nil then
				arg_283_1.var_.characterEffect4040ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect4040ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect4040ui_story then
				arg_283_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_286_4 = arg_283_1.actors_["1095ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1095ui_story == nil then
				arg_283_1.var_.characterEffect1095ui_story = var_286_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_5 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_5 and not isNil(var_286_4) then
				if arg_283_1.var_.characterEffect1095ui_story and not isNil(var_286_4) then
					arg_283_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_5)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_5 and arg_283_1.time_ < 0 + var_286_5 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect1095ui_story then
				arg_283_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_6 = 0
			local var_286_7 = 0.25

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:GetWordFromCfg(319321068)
				local var_286_9 = arg_283_1:FormatText(var_286_8.content)

				arg_283_1.text_.text = var_286_9

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 10 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 10)

				if (10 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 10)) > 0 and var_286_7 < var_286_11 then
					arg_283_1.talkMaxDuration = var_286_11

					if var_286_11 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_9
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321068", "story_v_out_319321.awb") ~= 0 then
					local var_286_12 = manager.audio:GetVoiceLength("story_v_out_319321", "319321068", "story_v_out_319321.awb") / 1000

					if var_286_12 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_12 + var_286_6
					end

					if var_286_8.prefab_name ~= "" and arg_283_1.actors_[var_286_8.prefab_name] ~= nil then
						local var_286_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_8.prefab_name].transform, "story_v_out_319321", "319321068", "story_v_out_319321.awb")

						arg_283_1:RecordAudio("319321068", var_286_13)
						arg_283_1:RecordAudio("319321068", var_286_13)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_319321", "319321068", "story_v_out_319321.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_319321", "319321068", "story_v_out_319321.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play319321069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319321069
		arg_287_1.duration_ = 5.83

		local var_287_0 = {
			zh = 4.366,
			ja = 5.833
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play319321070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.45

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(319321069)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 18 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 18)

				if (18 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 18)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321069", "story_v_out_319321.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_319321", "319321069", "story_v_out_319321.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_319321", "319321069", "story_v_out_319321.awb")

						arg_287_1:RecordAudio("319321069", var_290_6)
						arg_287_1:RecordAudio("319321069", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319321", "319321069", "story_v_out_319321.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319321", "319321069", "story_v_out_319321.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play319321070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319321070
		arg_291_1.duration_ = 3.53

		local var_291_0 = {
			zh = 3.533,
			ja = 3.2
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play319321071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.225

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:GetWordFromCfg(319321070)
				local var_294_2 = arg_291_1:FormatText(var_294_1.content)

				arg_291_1.text_.text = var_294_2

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_4 = 9 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 9)

				if (9 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_2) / 9)) > 0 and var_294_0 < var_294_4 then
					arg_291_1.talkMaxDuration = var_294_4

					if var_294_4 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_4 + 0
					end
				end

				arg_291_1.text_.text = var_294_2
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321070", "story_v_out_319321.awb") ~= 0 then
					local var_294_5 = manager.audio:GetVoiceLength("story_v_out_319321", "319321070", "story_v_out_319321.awb") / 1000

					if var_294_5 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + 0
					end

					if var_294_1.prefab_name ~= "" and arg_291_1.actors_[var_294_1.prefab_name] ~= nil then
						local var_294_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_1.prefab_name].transform, "story_v_out_319321", "319321070", "story_v_out_319321.awb")

						arg_291_1:RecordAudio("319321070", var_294_6)
						arg_291_1:RecordAudio("319321070", var_294_6)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_319321", "319321070", "story_v_out_319321.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_319321", "319321070", "story_v_out_319321.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_7 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_7

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play319321071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319321071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play319321072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["4040ui_story"]) and arg_295_1.var_.characterEffect4040ui_story == nil then
				arg_295_1.var_.characterEffect4040ui_story = arg_295_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["4040ui_story"]) then
				if arg_295_1.var_.characterEffect4040ui_story and not isNil(arg_295_1.actors_["4040ui_story"]) then
					arg_295_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_295_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_0)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["4040ui_story"]) and arg_295_1.var_.characterEffect4040ui_story then
				arg_295_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_295_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_298_1 = 0
			local var_298_2 = 1.125

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(319321071).content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 45 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 45)

				if (45 <= 0 and var_298_2 or var_298_2 * (utf8.len(var_298_3) / 45)) > 0 and var_298_2 < var_298_5 then
					arg_295_1.talkMaxDuration = var_298_5

					if var_298_5 + var_298_1 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + var_298_1
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_6 = math.max(var_298_2, arg_295_1.talkMaxDuration)

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_6 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_1) / var_298_6

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_1 + var_298_6 and arg_295_1.time_ < var_298_1 + var_298_6 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play319321072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319321072
		arg_299_1.duration_ = 3.37

		local var_299_0 = {
			zh = 1.999999999999,
			ja = 3.366
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
				arg_299_0:Play319321073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1095ui_story = arg_299_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).z)
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles = arg_299_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_299_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1095ui_story"].transform.position).z)
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1095ui_story"].transform.localEulerAngles = arg_299_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1095ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1095ui_story == nil then
				arg_299_1.var_.characterEffect1095ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect1095ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1095ui_story then
				arg_299_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_302_4 = 0
			local var_302_5 = 0.225

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(319321072)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 9 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 9)

				if (9 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 9)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321072", "story_v_out_319321.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321072", "story_v_out_319321.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_out_319321", "319321072", "story_v_out_319321.awb")

						arg_299_1:RecordAudio("319321072", var_302_11)
						arg_299_1:RecordAudio("319321072", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_319321", "319321072", "story_v_out_319321.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_319321", "319321072", "story_v_out_319321.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play319321073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319321073
		arg_303_1.duration_ = 2.17

		local var_303_0 = {
			zh = 1.3,
			ja = 2.166
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
				arg_303_0:Play319321074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1095ui_story"]) and arg_303_1.var_.characterEffect1095ui_story == nil then
				arg_303_1.var_.characterEffect1095ui_story = arg_303_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1095ui_story"]) then
				if arg_303_1.var_.characterEffect1095ui_story and not isNil(arg_303_1.actors_["1095ui_story"]) then
					arg_303_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1095ui_story"]) and arg_303_1.var_.characterEffect1095ui_story then
				arg_303_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_306_1 = arg_303_1.actors_["4040ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect4040ui_story == nil then
				arg_303_1.var_.characterEffect4040ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect4040ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect4040ui_story then
				arg_303_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_306_4 = 0
			local var_306_5 = 0.1

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(319321073)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 4 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 4)

				if (4 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 4)) > 0 and var_306_5 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321073", "story_v_out_319321.awb") ~= 0 then
					local var_306_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321073", "story_v_out_319321.awb") / 1000

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end

					if var_306_6.prefab_name ~= "" and arg_303_1.actors_[var_306_6.prefab_name] ~= nil then
						local var_306_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_6.prefab_name].transform, "story_v_out_319321", "319321073", "story_v_out_319321.awb")

						arg_303_1:RecordAudio("319321073", var_306_11)
						arg_303_1:RecordAudio("319321073", var_306_11)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_319321", "319321073", "story_v_out_319321.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_319321", "319321073", "story_v_out_319321.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_12 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_12 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_12

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_12 and arg_303_1.time_ < var_306_4 + var_306_12 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play319321074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319321074
		arg_307_1.duration_ = 2

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
			arg_307_1.auto_ = false
		end

		function arg_307_1.playNext_(arg_309_0)
			arg_307_1.onStoryFinished_()
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos4040ui_story = arg_307_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).z)
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles = arg_307_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_307_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).z)
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles = arg_307_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["4040ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect4040ui_story == nil then
				arg_307_1.var_.characterEffect4040ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect4040ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect4040ui_story then
				arg_307_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_2")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_310_4 = 0
			local var_310_5 = 0.15

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(319321074)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 6 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 6)

				if (6 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 6)) > 0 and var_310_5 < var_310_9 then
					arg_307_1.talkMaxDuration = var_310_9

					if var_310_9 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319321", "319321074", "story_v_out_319321.awb") ~= 0 then
					local var_310_10 = manager.audio:GetVoiceLength("story_v_out_319321", "319321074", "story_v_out_319321.awb") / 1000

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end

					if var_310_6.prefab_name ~= "" and arg_307_1.actors_[var_310_6.prefab_name] ~= nil then
						local var_310_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_6.prefab_name].transform, "story_v_out_319321", "319321074", "story_v_out_319321.awb")

						arg_307_1:RecordAudio("319321074", var_310_11)
						arg_307_1:RecordAudio("319321074", var_310_11)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_319321", "319321074", "story_v_out_319321.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_319321", "319321074", "story_v_out_319321.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_12 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_12 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_12

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_12 and arg_307_1.time_ < var_310_4 + var_310_12 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I12f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319321.awb"
	}
}
