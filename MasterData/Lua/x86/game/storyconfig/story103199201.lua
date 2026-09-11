return {
	Play319921001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319921001
		arg_1_1.duration_ = 6.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319921002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST74 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74")
				var_4_0.name = "ST74"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST74 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST74

				arg_1_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST74" then
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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

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

			local var_4_14 = 1.9
			local var_4_15 = 1.4

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
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

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319921001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 56 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 56)

				if (56 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 56)) > 0 and var_4_15 < var_4_19 then
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
	Play319921002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319921002
		arg_9_1.duration_ = 2.6

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_9_0:Play319921003(arg_9_1)
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
			local var_12_9 = 0.125

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

				local var_12_10 = arg_9_1:GetWordFromCfg(319921002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 5 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 5)

				if (5 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 5)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921002", "story_v_out_319921.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_319921", "319921002", "story_v_out_319921.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_319921", "319921002", "story_v_out_319921.awb")

						arg_9_1:RecordAudio("319921002", var_12_15)
						arg_9_1:RecordAudio("319921002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319921", "319921002", "story_v_out_319921.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319921", "319921002", "story_v_out_319921.awb")
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
	Play319921003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319921003
		arg_13_1.duration_ = 5.73

		local var_13_0 = {
			zh = 4.666,
			ja = 5.733
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
				arg_13_0:Play319921004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1084ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1084ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1084ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1084ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1084ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1084ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1084ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1084ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1084ui_story then
				arg_13_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_16_8 = arg_13_1.actors_["4040ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos4040ui_story = var_16_8.localPosition
			end

			local var_16_9 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_13_1.time_ - 0) / var_16_9)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_16_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_8.position).x, (manager.ui.mainCamera.transform.position - var_16_8.position).y, (manager.ui.mainCamera.transform.position - var_16_8.position).z)
				var_16_8.localEulerAngles.z = 0
				var_16_8.localEulerAngles.x = 0
				var_16_8.localEulerAngles = var_16_8.localEulerAngles
			end

			local var_16_10 = arg_13_1.actors_["4040ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect4040ui_story == nil then
				arg_13_1.var_.characterEffect4040ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect4040ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_13_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect4040ui_story then
				arg_13_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_13_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_16_12 = 0
			local var_16_13 = 0.7

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:GetWordFromCfg(319921003)
				local var_16_15 = arg_13_1:FormatText(var_16_14.content)

				arg_13_1.text_.text = var_16_15

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 28 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 28)

				if (28 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_15) / 28)) > 0 and var_16_13 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_15
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921003", "story_v_out_319921.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_319921", "319921003", "story_v_out_319921.awb") / 1000

					if var_16_18 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_12
					end

					if var_16_14.prefab_name ~= "" and arg_13_1.actors_[var_16_14.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_14.prefab_name].transform, "story_v_out_319921", "319921003", "story_v_out_319921.awb")

						arg_13_1:RecordAudio("319921003", var_16_19)
						arg_13_1:RecordAudio("319921003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319921", "319921003", "story_v_out_319921.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319921", "319921003", "story_v_out_319921.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_20 and arg_13_1.time_ < var_16_12 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play319921004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319921004
		arg_17_1.duration_ = 11.4

		local var_17_0 = {
			zh = 6.833,
			ja = 11.4
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
				arg_17_0:Play319921005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = arg_17_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(arg_17_1.actors_["1084ui_story"]) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_20_1 = arg_17_1.actors_["4040ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect4040ui_story == nil then
				arg_17_1.var_.characterEffect4040ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect4040ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect4040ui_story then
				arg_17_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_4 = 0
			local var_20_5 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
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

				local var_20_6 = arg_17_1:GetWordFromCfg(319921004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 28 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 28)

				if (28 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 28)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921004", "story_v_out_319921.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921004", "story_v_out_319921.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_319921", "319921004", "story_v_out_319921.awb")

						arg_17_1:RecordAudio("319921004", var_20_11)
						arg_17_1:RecordAudio("319921004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319921", "319921004", "story_v_out_319921.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319921", "319921004", "story_v_out_319921.awb")
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

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319921005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319921005
		arg_21_1.duration_ = 2

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319921006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = arg_21_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) then
				if arg_21_1.var_.characterEffect1084ui_story and not isNil(arg_21_1.actors_["1084ui_story"]) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1084ui_story"]) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_2 = arg_21_1.actors_["4040ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect4040ui_story == nil then
				arg_21_1.var_.characterEffect4040ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect4040ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_21_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect4040ui_story then
				arg_21_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_21_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_24_4 = 0
			local var_24_5 = 0.2

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(319921005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 8 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 8)

				if (8 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 8)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921005", "story_v_out_319921.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921005", "story_v_out_319921.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_319921", "319921005", "story_v_out_319921.awb")

						arg_21_1:RecordAudio("319921005", var_24_11)
						arg_21_1:RecordAudio("319921005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319921", "319921005", "story_v_out_319921.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319921", "319921005", "story_v_out_319921.awb")
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
	Play319921006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319921006
		arg_25_1.duration_ = 1

		local var_25_0 = {
			zh = 1,
			ja = 0.999999999999
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
				arg_25_0:Play319921007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["4040ui_story"]) and arg_25_1.var_.characterEffect4040ui_story == nil then
				arg_25_1.var_.characterEffect4040ui_story = arg_25_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["4040ui_story"]) then
				if arg_25_1.var_.characterEffect4040ui_story and not isNil(arg_25_1.actors_["4040ui_story"]) then
					arg_25_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["4040ui_story"]) and arg_25_1.var_.characterEffect4040ui_story then
				arg_25_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_28_2 = arg_25_1.actors_["1084ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.05

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(319921006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 2 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 2)

				if (2 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 2)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921006", "story_v_out_319921.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921006", "story_v_out_319921.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_319921", "319921006", "story_v_out_319921.awb")

						arg_25_1:RecordAudio("319921006", var_28_11)
						arg_25_1:RecordAudio("319921006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319921", "319921006", "story_v_out_319921.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319921", "319921006", "story_v_out_319921.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319921007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319921007
		arg_29_1.duration_ = 5.1

		local var_29_0 = {
			zh = 2.933,
			ja = 5.1
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
				arg_29_0:Play319921008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = arg_29_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) then
				if arg_29_1.var_.characterEffect1084ui_story and not isNil(arg_29_1.actors_["1084ui_story"]) then
					arg_29_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story then
				arg_29_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["4040ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect4040ui_story == nil then
				arg_29_1.var_.characterEffect4040ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect4040ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_29_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect4040ui_story then
				arg_29_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_29_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_32_4 = 0
			local var_32_5 = 0.35

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(319921007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 14 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 14)

				if (14 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 14)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921007", "story_v_out_319921.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921007", "story_v_out_319921.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_319921", "319921007", "story_v_out_319921.awb")

						arg_29_1:RecordAudio("319921007", var_32_11)
						arg_29_1:RecordAudio("319921007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319921", "319921007", "story_v_out_319921.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319921", "319921007", "story_v_out_319921.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319921008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319921008
		arg_33_1.duration_ = 5.53

		local var_33_0 = {
			zh = 4.066,
			ja = 5.533
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
				arg_33_0:Play319921009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1084ui_story"]) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = arg_33_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1084ui_story"]) then
				if arg_33_1.var_.characterEffect1084ui_story and not isNil(arg_33_1.actors_["1084ui_story"]) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_0)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1084ui_story"]) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_36_1 = arg_33_1.actors_["4040ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect4040ui_story == nil then
				arg_33_1.var_.characterEffect4040ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect4040ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect4040ui_story then
				arg_33_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.45

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(319921008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 18 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 18)

				if (18 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 18)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921008", "story_v_out_319921.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921008", "story_v_out_319921.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_319921", "319921008", "story_v_out_319921.awb")

						arg_33_1:RecordAudio("319921008", var_36_11)
						arg_33_1:RecordAudio("319921008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319921", "319921008", "story_v_out_319921.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319921", "319921008", "story_v_out_319921.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319921009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319921009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play319921010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1084ui_story = arg_37_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).z)
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles = arg_37_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1084ui_story"].transform.position).z)
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1084ui_story"].transform.localEulerAngles = arg_37_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["4040ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos4040ui_story = var_40_1.localPosition
			end

			local var_40_2 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 then
				var_40_1.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_2)
				var_40_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_1.position).x, (manager.ui.mainCamera.transform.position - var_40_1.position).y, (manager.ui.mainCamera.transform.position - var_40_1.position).z)
				var_40_1.localEulerAngles.z = 0
				var_40_1.localEulerAngles.x = 0
				var_40_1.localEulerAngles = var_40_1.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 then
				var_40_1.localPosition = Vector3.New(0, 100, 0)
				var_40_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_1.position).x, (manager.ui.mainCamera.transform.position - var_40_1.position).y, (manager.ui.mainCamera.transform.position - var_40_1.position).z)
				var_40_1.localEulerAngles.z = 0
				var_40_1.localEulerAngles.x = 0
				var_40_1.localEulerAngles = var_40_1.localEulerAngles
			end

			local var_40_3 = 0
			local var_40_4 = 1.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_5 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(319921009).content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 51 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 51)

				if (51 <= 0 and var_40_4 or var_40_4 * (utf8.len(var_40_5) / 51)) > 0 and var_40_4 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_3 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_3
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_4, arg_37_1.talkMaxDuration)

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_3) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_3 + var_40_8 and arg_37_1.time_ < var_40_3 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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
				actorName = "4040ui_story",
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
	Play319921010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319921010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play319921011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.75

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(319921010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 30 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 30)

				if (30 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 30)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319921011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319921011
		arg_45_1.duration_ = 5.73

		local var_45_0 = {
			zh = 5.733,
			ja = 3.933
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
				arg_45_0:Play319921012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1084ui_story = arg_45_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1084ui_story"].transform.position).z)
				arg_45_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1084ui_story"].transform.localEulerAngles = arg_45_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_45_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1084ui_story"].transform.position).z)
				arg_45_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1084ui_story"].transform.localEulerAngles = arg_45_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["4040ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos4040ui_story = var_48_1.localPosition
			end

			local var_48_2 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 then
				var_48_1.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_45_1.time_ - 0) / var_48_2)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 then
				var_48_1.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_48_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_1.position).x, (manager.ui.mainCamera.transform.position - var_48_1.position).y, (manager.ui.mainCamera.transform.position - var_48_1.position).z)
				var_48_1.localEulerAngles.z = 0
				var_48_1.localEulerAngles.x = 0
				var_48_1.localEulerAngles = var_48_1.localEulerAngles
			end

			local var_48_3 = arg_45_1.actors_["4040ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect4040ui_story == nil then
				arg_45_1.var_.characterEffect4040ui_story = var_48_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_4 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 and not isNil(var_48_3) then
				if arg_45_1.var_.characterEffect4040ui_story and not isNil(var_48_3) then
					arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.characterEffect4040ui_story then
				arg_45_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_48_6 = 0
			local var_48_7 = 0.8

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(319921011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 32 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 32)

				if (32 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 32)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921011", "story_v_out_319921.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_319921", "319921011", "story_v_out_319921.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_319921", "319921011", "story_v_out_319921.awb")

						arg_45_1:RecordAudio("319921011", var_48_13)
						arg_45_1:RecordAudio("319921011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319921", "319921011", "story_v_out_319921.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319921", "319921011", "story_v_out_319921.awb")
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
				actorName = "4040ui_story",
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
	Play319921012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319921012
		arg_49_1.duration_ = 5.03

		local var_49_0 = {
			zh = 4.7,
			ja = 5.033
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
				arg_49_0:Play319921013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_0 = 0
			local var_52_1 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(319921012)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 24 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 24)

				if (24 <= 0 and var_52_1 or var_52_1 * (utf8.len(var_52_3) / 24)) > 0 and var_52_1 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921012", "story_v_out_319921.awb") ~= 0 then
					local var_52_6 = manager.audio:GetVoiceLength("story_v_out_319921", "319921012", "story_v_out_319921.awb") / 1000

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end

					if var_52_2.prefab_name ~= "" and arg_49_1.actors_[var_52_2.prefab_name] ~= nil then
						local var_52_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_2.prefab_name].transform, "story_v_out_319921", "319921012", "story_v_out_319921.awb")

						arg_49_1:RecordAudio("319921012", var_52_7)
						arg_49_1:RecordAudio("319921012", var_52_7)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319921", "319921012", "story_v_out_319921.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319921", "319921012", "story_v_out_319921.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319921013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319921013
		arg_53_1.duration_ = 7.17

		local var_53_0 = {
			zh = 3.8,
			ja = 7.166
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
				arg_53_0:Play319921014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1084ui_story = arg_53_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1084ui_story"].transform.position).z)
				arg_53_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1084ui_story"].transform.localEulerAngles = arg_53_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_53_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1084ui_story"].transform.position).z)
				arg_53_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1084ui_story"].transform.localEulerAngles = arg_53_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1084ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1084ui_story == nil then
				arg_53_1.var_.characterEffect1084ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1084ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1084ui_story then
				arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_56_4 = arg_53_1.actors_["4040ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect4040ui_story == nil then
				arg_53_1.var_.characterEffect4040ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_5 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_5 and not isNil(var_56_4) then
				if arg_53_1.var_.characterEffect4040ui_story and not isNil(var_56_4) then
					arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_53_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_5)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_5 and arg_53_1.time_ < 0 + var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect4040ui_story then
				arg_53_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_53_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_56_6 = 0
			local var_56_7 = 0.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(319921013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 12 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 12)

				if (12 <= 0 and var_56_7 or var_56_7 * (utf8.len(var_56_9) / 12)) > 0 and var_56_7 < var_56_11 then
					arg_53_1.talkMaxDuration = var_56_11

					if var_56_11 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921013", "story_v_out_319921.awb") ~= 0 then
					local var_56_12 = manager.audio:GetVoiceLength("story_v_out_319921", "319921013", "story_v_out_319921.awb") / 1000

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end

					if var_56_8.prefab_name ~= "" and arg_53_1.actors_[var_56_8.prefab_name] ~= nil then
						local var_56_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_8.prefab_name].transform, "story_v_out_319921", "319921013", "story_v_out_319921.awb")

						arg_53_1:RecordAudio("319921013", var_56_13)
						arg_53_1:RecordAudio("319921013", var_56_13)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319921", "319921013", "story_v_out_319921.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319921", "319921013", "story_v_out_319921.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play319921014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319921014
		arg_57_1.duration_ = 4.5

		local var_57_0 = {
			zh = 2.3,
			ja = 4.5
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
				arg_57_0:Play319921015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = arg_57_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(arg_57_1.actors_["1084ui_story"]) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1084ui_story"]) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_60_1 = arg_57_1.actors_["4040ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect4040ui_story == nil then
				arg_57_1.var_.characterEffect4040ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect4040ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect4040ui_story then
				arg_57_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_60_4 = 0
			local var_60_5 = 0.25

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(319921014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 10 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 10)

				if (10 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 10)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921014", "story_v_out_319921.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921014", "story_v_out_319921.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_319921", "319921014", "story_v_out_319921.awb")

						arg_57_1:RecordAudio("319921014", var_60_11)
						arg_57_1:RecordAudio("319921014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319921", "319921014", "story_v_out_319921.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319921", "319921014", "story_v_out_319921.awb")
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
	Play319921015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319921015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319921016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["4040ui_story"]) and arg_61_1.var_.characterEffect4040ui_story == nil then
				arg_61_1.var_.characterEffect4040ui_story = arg_61_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["4040ui_story"]) then
				if arg_61_1.var_.characterEffect4040ui_story and not isNil(arg_61_1.actors_["4040ui_story"]) then
					arg_61_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_61_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["4040ui_story"]) and arg_61_1.var_.characterEffect4040ui_story then
				arg_61_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_61_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_64_1 = arg_61_1.actors_["4040ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos4040ui_story = var_64_1.localPosition
			end

			local var_64_2 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_2)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0, 100, 0)
				var_64_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_1.position).x, (manager.ui.mainCamera.transform.position - var_64_1.position).y, (manager.ui.mainCamera.transform.position - var_64_1.position).z)
				var_64_1.localEulerAngles.z = 0
				var_64_1.localEulerAngles.x = 0
				var_64_1.localEulerAngles = var_64_1.localEulerAngles
			end

			local var_64_3 = 0
			local var_64_4 = 0.65

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

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(319921015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 26 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 26)

				if (26 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 26)) > 0 and var_64_4 < var_64_7 then
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
				actorName = "4040ui_story",
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
	Play319921016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319921016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play319921017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos4040ui_story = arg_65_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).z)
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles = arg_65_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_65_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["4040ui_story"].transform.position).z)
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["4040ui_story"].transform.localEulerAngles = arg_65_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["4040ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect4040ui_story == nil then
				arg_65_1.var_.characterEffect4040ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect4040ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect4040ui_story then
				arg_65_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action6_2")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.05

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(319921016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 2 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 2)

				if (2 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 2)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921016", "story_v_out_319921.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921016", "story_v_out_319921.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_319921", "319921016", "story_v_out_319921.awb")

						arg_65_1:RecordAudio("319921016", var_68_11)
						arg_65_1:RecordAudio("319921016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319921", "319921016", "story_v_out_319921.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319921", "319921016", "story_v_out_319921.awb")
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
				actorName = "4040ui_story",
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
	Play319921017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319921017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play319921018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["4040ui_story"]) and arg_69_1.var_.characterEffect4040ui_story == nil then
				arg_69_1.var_.characterEffect4040ui_story = arg_69_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["4040ui_story"]) then
				if arg_69_1.var_.characterEffect4040ui_story and not isNil(arg_69_1.actors_["4040ui_story"]) then
					arg_69_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_69_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["4040ui_story"]) and arg_69_1.var_.characterEffect4040ui_story then
				arg_69_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_69_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_72_1 = arg_69_1.actors_["1084ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_72_4 = 0
			local var_72_5 = 0.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(319921017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 6 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 6)

				if (6 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 6)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921017", "story_v_out_319921.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921017", "story_v_out_319921.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_319921", "319921017", "story_v_out_319921.awb")

						arg_69_1:RecordAudio("319921017", var_72_11)
						arg_69_1:RecordAudio("319921017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319921", "319921017", "story_v_out_319921.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319921", "319921017", "story_v_out_319921.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319921018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319921018
		arg_73_1.duration_ = 6.03

		local var_73_0 = {
			zh = 6.033,
			ja = 4.3
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
				arg_73_0:Play319921019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["4040ui_story"]) and arg_73_1.var_.characterEffect4040ui_story == nil then
				arg_73_1.var_.characterEffect4040ui_story = arg_73_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["4040ui_story"]) then
				if arg_73_1.var_.characterEffect4040ui_story and not isNil(arg_73_1.actors_["4040ui_story"]) then
					arg_73_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["4040ui_story"]) and arg_73_1.var_.characterEffect4040ui_story then
				arg_73_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_76_2 = arg_73_1.actors_["1084ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_3 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_3)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_76_4 = 0
			local var_76_5 = 0.625

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_6 = arg_73_1:GetWordFromCfg(319921018)
				local var_76_7 = arg_73_1:FormatText(var_76_6.content)

				arg_73_1.text_.text = var_76_7

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_9 = 25 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 25)

				if (25 <= 0 and var_76_5 or var_76_5 * (utf8.len(var_76_7) / 25)) > 0 and var_76_5 < var_76_9 then
					arg_73_1.talkMaxDuration = var_76_9

					if var_76_9 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_4
					end
				end

				arg_73_1.text_.text = var_76_7
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921018", "story_v_out_319921.awb") ~= 0 then
					local var_76_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921018", "story_v_out_319921.awb") / 1000

					if var_76_10 + var_76_4 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_4
					end

					if var_76_6.prefab_name ~= "" and arg_73_1.actors_[var_76_6.prefab_name] ~= nil then
						local var_76_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_6.prefab_name].transform, "story_v_out_319921", "319921018", "story_v_out_319921.awb")

						arg_73_1:RecordAudio("319921018", var_76_11)
						arg_73_1:RecordAudio("319921018", var_76_11)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319921", "319921018", "story_v_out_319921.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319921", "319921018", "story_v_out_319921.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_12 = math.max(var_76_5, arg_73_1.talkMaxDuration)

			if var_76_4 <= arg_73_1.time_ and arg_73_1.time_ < var_76_4 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_4) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_4 + var_76_12 and arg_73_1.time_ < var_76_4 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319921019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319921019
		arg_77_1.duration_ = 7

		local var_77_0 = {
			zh = 6.733,
			ja = 7
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
				arg_77_0:Play319921020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action3_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_80_0 = 0
			local var_80_1 = 0.75

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(319921019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 30 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 30)

				if (30 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 30)) > 0 and var_80_1 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921019", "story_v_out_319921.awb") ~= 0 then
					local var_80_6 = manager.audio:GetVoiceLength("story_v_out_319921", "319921019", "story_v_out_319921.awb") / 1000

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end

					if var_80_2.prefab_name ~= "" and arg_77_1.actors_[var_80_2.prefab_name] ~= nil then
						local var_80_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_2.prefab_name].transform, "story_v_out_319921", "319921019", "story_v_out_319921.awb")

						arg_77_1:RecordAudio("319921019", var_80_7)
						arg_77_1:RecordAudio("319921019", var_80_7)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319921", "319921019", "story_v_out_319921.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319921", "319921019", "story_v_out_319921.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319921020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319921020
		arg_81_1.duration_ = 7.83

		local var_81_0 = {
			zh = 5.166,
			ja = 7.833
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
				arg_81_0:Play319921021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.bgs_.ST71 == nil then
				local var_84_0 = Object.Instantiate(arg_81_1.paintGo_)

				var_84_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71")
				var_84_0.name = "ST71"
				var_84_0.transform.parent = arg_81_1.stage_.transform
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.bgs_.ST71 = var_84_0
			end

			if 1.2 < arg_81_1.time_ and arg_81_1.time_ <= 1.2 + arg_84_0 then
				local var_84_1 = arg_81_1.bgs_.ST71

				arg_81_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_2 = var_84_1:GetComponent("SpriteRenderer")

				if var_84_2 and var_84_2.sprite then
					local var_84_3 = 2 * (var_84_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_1.transform.localScale = Vector3.New(var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, var_84_3 / var_84_2.sprite.bounds.size.y < var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x and var_84_3 * manager.ui.mainCameraCom_.aspect / var_84_2.sprite.bounds.size.x or var_84_3 / var_84_2.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "ST71" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_4 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.allBtn_.enabled = false
			end

			if arg_81_1.time_ >= var_84_4 + 0.3 and arg_81_1.time_ < var_84_4 + 0.3 + arg_84_0 then
				arg_81_1.allBtn_.enabled = true
			end

			local var_84_5 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_6 = 1.2

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 then
				local var_84_7 = Color.New(0, 0, 0)

				var_84_7.a = Mathf.Lerp(0, 1, (arg_81_1.time_ - var_84_5) / var_84_6)
				arg_81_1.mask_.color = var_84_7
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 then
				local var_84_8 = Color.New(0, 0, 0)

				var_84_8.a = 1
				arg_81_1.mask_.color = var_84_8
			end

			local var_84_9 = 1.2

			if 1.2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_9 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_10 = 2

			if var_84_9 <= arg_81_1.time_ and arg_81_1.time_ < var_84_9 + var_84_10 then
				local var_84_11 = Color.New(0, 0, 0)

				var_84_11.a = Mathf.Lerp(1, 0, (arg_81_1.time_ - var_84_9) / var_84_10)
				arg_81_1.mask_.color = var_84_11
			end

			if arg_81_1.time_ >= var_84_9 + var_84_10 and arg_81_1.time_ < var_84_9 + var_84_10 + arg_84_0 then
				local var_84_12 = Color.New(0, 0, 0)

				arg_81_1.mask_.enabled = false
				var_84_12.a = 0
				arg_81_1.mask_.color = var_84_12
			end

			local var_84_13 = "10075ui_story"

			if arg_81_1.actors_["10075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10075ui_story"))) then
				local var_84_14 = Object.Instantiate(Asset.Load("Char/" .. "10075ui_story"), arg_81_1.stage_.transform)

				var_84_14.name = var_84_13
				var_84_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_[var_84_13] = var_84_14

				local var_84_15 = var_84_14:GetComponentInChildren(typeof(CharacterEffect))

				var_84_15.enabled = true

				local var_84_16 = GameObjectTools.GetOrAddComponent(var_84_14, typeof(DynamicBoneHelper))

				if var_84_16 then
					var_84_16:EnableDynamicBone(false)
				end

				arg_81_1:ShowWeapon(var_84_15.transform, false)

				arg_81_1.var_[var_84_13 .. "Animator"] = var_84_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_81_1.var_[var_84_13 .. "Animator"].applyRootMotion = true
				arg_81_1.var_[var_84_13 .. "LipSync"] = var_84_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_84_17 = arg_81_1.actors_["10075ui_story"].transform

			if 3.06666666666667 < arg_81_1.time_ and arg_81_1.time_ <= 3.06666666666667 + arg_84_0 then
				arg_81_1.var_.moveOldPos10075ui_story = var_84_17.localPosition
			end

			local var_84_18 = 0.001

			if 3.06666666666667 <= arg_81_1.time_ and arg_81_1.time_ < 3.06666666666667 + var_84_18 then
				var_84_17.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10075ui_story, Vector3.New(0, -0.715, -6.15), (arg_81_1.time_ - 3.06666666666667) / var_84_18)
				var_84_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_17.position).x, (manager.ui.mainCamera.transform.position - var_84_17.position).y, (manager.ui.mainCamera.transform.position - var_84_17.position).z)
				var_84_17.localEulerAngles.z = 0
				var_84_17.localEulerAngles.x = 0
				var_84_17.localEulerAngles = var_84_17.localEulerAngles
			end

			if arg_81_1.time_ >= 3.06666666666667 + var_84_18 and arg_81_1.time_ < 3.06666666666667 + var_84_18 + arg_84_0 then
				var_84_17.localPosition = Vector3.New(0, -0.715, -6.15)
				var_84_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_17.position).x, (manager.ui.mainCamera.transform.position - var_84_17.position).y, (manager.ui.mainCamera.transform.position - var_84_17.position).z)
				var_84_17.localEulerAngles.z = 0
				var_84_17.localEulerAngles.x = 0
				var_84_17.localEulerAngles = var_84_17.localEulerAngles
			end

			local var_84_19 = arg_81_1.actors_["10075ui_story"]

			if 3.06666666666667 < arg_81_1.time_ and arg_81_1.time_ <= 3.06666666666667 + arg_84_0 and not isNil(var_84_19) and arg_81_1.var_.characterEffect10075ui_story == nil then
				arg_81_1.var_.characterEffect10075ui_story = var_84_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_20 = 0.200000002980232

			if 3.06666666666667 <= arg_81_1.time_ and arg_81_1.time_ < 3.06666666666667 + var_84_20 and not isNil(var_84_19) then
				if arg_81_1.var_.characterEffect10075ui_story and not isNil(var_84_19) then
					arg_81_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 3.06666666666667 + var_84_20 and arg_81_1.time_ < 3.06666666666667 + var_84_20 + arg_84_0 and not isNil(var_84_19) and arg_81_1.var_.characterEffect10075ui_story then
				arg_81_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 3.06666666666667 < arg_81_1.time_ and arg_81_1.time_ <= 3.06666666666667 + arg_84_0 then
				arg_81_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 3.06666666666667 < arg_81_1.time_ and arg_81_1.time_ <= 3.06666666666667 + arg_84_0 then
				arg_81_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_22 = arg_81_1.actors_["1084ui_story"].transform

			if 1.2 < arg_81_1.time_ and arg_81_1.time_ <= 1.2 + arg_84_0 then
				arg_81_1.var_.moveOldPos1084ui_story = var_84_22.localPosition
			end

			local var_84_23 = 0.001

			if 1.2 <= arg_81_1.time_ and arg_81_1.time_ < 1.2 + var_84_23 then
				var_84_22.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 1.2) / var_84_23)
				var_84_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_22.position).x, (manager.ui.mainCamera.transform.position - var_84_22.position).y, (manager.ui.mainCamera.transform.position - var_84_22.position).z)
				var_84_22.localEulerAngles.z = 0
				var_84_22.localEulerAngles.x = 0
				var_84_22.localEulerAngles = var_84_22.localEulerAngles
			end

			if arg_81_1.time_ >= 1.2 + var_84_23 and arg_81_1.time_ < 1.2 + var_84_23 + arg_84_0 then
				var_84_22.localPosition = Vector3.New(0, 100, 0)
				var_84_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_22.position).x, (manager.ui.mainCamera.transform.position - var_84_22.position).y, (manager.ui.mainCamera.transform.position - var_84_22.position).z)
				var_84_22.localEulerAngles.z = 0
				var_84_22.localEulerAngles.x = 0
				var_84_22.localEulerAngles = var_84_22.localEulerAngles
			end

			local var_84_24 = arg_81_1.actors_["4040ui_story"].transform

			if 1.2 < arg_81_1.time_ and arg_81_1.time_ <= 1.2 + arg_84_0 then
				arg_81_1.var_.moveOldPos4040ui_story = var_84_24.localPosition
			end

			local var_84_25 = 0.001

			if 1.2 <= arg_81_1.time_ and arg_81_1.time_ < 1.2 + var_84_25 then
				var_84_24.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 1.2) / var_84_25)
				var_84_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_24.position).x, (manager.ui.mainCamera.transform.position - var_84_24.position).y, (manager.ui.mainCamera.transform.position - var_84_24.position).z)
				var_84_24.localEulerAngles.z = 0
				var_84_24.localEulerAngles.x = 0
				var_84_24.localEulerAngles = var_84_24.localEulerAngles
			end

			if arg_81_1.time_ >= 1.2 + var_84_25 and arg_81_1.time_ < 1.2 + var_84_25 + arg_84_0 then
				var_84_24.localPosition = Vector3.New(0, 100, 0)
				var_84_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_24.position).x, (manager.ui.mainCamera.transform.position - var_84_24.position).y, (manager.ui.mainCamera.transform.position - var_84_24.position).z)
				var_84_24.localEulerAngles.z = 0
				var_84_24.localEulerAngles.x = 0
				var_84_24.localEulerAngles = var_84_24.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_84_28 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_28 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_28

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_28
						arg_81_1.bgmTxt2_.text = var_84_28
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_81_1.time_ and arg_81_1.time_ <= 0.233333333333333 + arg_84_0 then
				arg_81_1:AudioAction("play", "music", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_84_31 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

				if "" ~= "" then
					if arg_81_1.bgmTxt_.text ~= var_84_31 and arg_81_1.bgmTxt_.text ~= "" then
						if arg_81_1.bgmTxt2_.text ~= "" then
							arg_81_1.bgmTxt_.text = arg_81_1.bgmTxt2_.text
						end

						arg_81_1.bgmTxt2_.text = var_84_31

						arg_81_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_81_1.bgmTxt_.text = var_84_31
						arg_81_1.bgmTxt2_.text = var_84_31
					end

					if arg_81_1.bgmTimer then
						arg_81_1.bgmTimer:Stop()

						arg_81_1.bgmTimer = nil
					end

					if arg_81_1.settingData.show_music_name == 1 then
						arg_81_1.musicController:SetSelectedState("show")
						arg_81_1.musicAnimator_:Play("open", 0, 0)

						if arg_81_1.settingData.music_time ~= 0 then
							arg_81_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_81_1.settingData.music_time), function()
								if arg_81_1 == nil or isNil(arg_81_1.bgmTxt_) then
									return
								end

								arg_81_1.musicController:SetSelectedState("hide")
								arg_81_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_32 = 3.2
			local var_84_33 = 0.225

			if 3.2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_32 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_34 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_34:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_81_1.dialogCg_.alpha = arg_87_0
				end))
				var_84_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_35 = arg_81_1:GetWordFromCfg(319921020)
				local var_84_36 = arg_81_1:FormatText(var_84_35.content)

				arg_81_1.text_.text = var_84_36

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_38 = 9 <= 0 and var_84_33 or var_84_33 * (utf8.len(var_84_36) / 9)

				if (9 <= 0 and var_84_33 or var_84_33 * (utf8.len(var_84_36) / 9)) > 0 and var_84_33 < var_84_38 then
					arg_81_1.talkMaxDuration = var_84_38
					var_84_32 = var_84_32 + 0.3

					if var_84_38 + var_84_32 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_38 + var_84_32
					end
				end

				arg_81_1.text_.text = var_84_36
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921020", "story_v_out_319921.awb") ~= 0 then
					local var_84_39 = manager.audio:GetVoiceLength("story_v_out_319921", "319921020", "story_v_out_319921.awb") / 1000

					if var_84_39 + var_84_32 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_39 + var_84_32
					end

					if var_84_35.prefab_name ~= "" and arg_81_1.actors_[var_84_35.prefab_name] ~= nil then
						local var_84_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_35.prefab_name].transform, "story_v_out_319921", "319921020", "story_v_out_319921.awb")

						arg_81_1:RecordAudio("319921020", var_84_40)
						arg_81_1:RecordAudio("319921020", var_84_40)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319921", "319921020", "story_v_out_319921.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319921", "319921020", "story_v_out_319921.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_41 = var_84_32 + 0.3
			local var_84_42 = math.max(var_84_33, arg_81_1.talkMaxDuration)

			if var_84_32 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_41 + var_84_42 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_41) / var_84_42

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_41 + var_84_42 and arg_81_1.time_ < var_84_41 + var_84_42 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play319921021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319921021
		arg_89_1.duration_ = 2.67

		local var_89_0 = {
			zh = 2.266,
			ja = 2.666
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
				arg_89_0:Play319921022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1084ui_story = arg_89_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).z)
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles = arg_89_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_89_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).z)
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles = arg_89_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1084ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1084ui_story then
				arg_89_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_4 = arg_89_1.actors_["10075ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos10075ui_story = var_92_4.localPosition
			end

			local var_92_5 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 then
				var_92_4.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_89_1.time_ - 0) / var_92_5)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 then
				var_92_4.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_92_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_4.position).x, (manager.ui.mainCamera.transform.position - var_92_4.position).y, (manager.ui.mainCamera.transform.position - var_92_4.position).z)
				var_92_4.localEulerAngles.z = 0
				var_92_4.localEulerAngles.x = 0
				var_92_4.localEulerAngles = var_92_4.localEulerAngles
			end

			local var_92_6 = arg_89_1.actors_["10075ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect10075ui_story == nil then
				arg_89_1.var_.characterEffect10075ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_7 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 and not isNil(var_92_6) then
				if arg_89_1.var_.characterEffect10075ui_story and not isNil(var_92_6) then
					arg_89_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_7)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect10075ui_story then
				arg_89_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_92_8 = 0
			local var_92_9 = 0.175

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_10 = arg_89_1:GetWordFromCfg(319921021)
				local var_92_11 = arg_89_1:FormatText(var_92_10.content)

				arg_89_1.text_.text = var_92_11

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_13 = 7 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 7)

				if (7 <= 0 and var_92_9 or var_92_9 * (utf8.len(var_92_11) / 7)) > 0 and var_92_9 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_8
					end
				end

				arg_89_1.text_.text = var_92_11
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921021", "story_v_out_319921.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_319921", "319921021", "story_v_out_319921.awb") / 1000

					if var_92_14 + var_92_8 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_8
					end

					if var_92_10.prefab_name ~= "" and arg_89_1.actors_[var_92_10.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_10.prefab_name].transform, "story_v_out_319921", "319921021", "story_v_out_319921.awb")

						arg_89_1:RecordAudio("319921021", var_92_15)
						arg_89_1:RecordAudio("319921021", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319921", "319921021", "story_v_out_319921.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319921", "319921021", "story_v_out_319921.awb")
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
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play319921022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319921022
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319921023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1084ui_story"]) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = arg_93_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1084ui_story"]) then
				if arg_93_1.var_.characterEffect1084ui_story and not isNil(arg_93_1.actors_["1084ui_story"]) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1084ui_story"]) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.875

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(319921022).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 35 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 35)

				if (35 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 35)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319921023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319921023
		arg_97_1.duration_ = 6.43

		local var_97_0 = {
			zh = 3.066,
			ja = 6.433
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
				arg_97_0:Play319921024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10075ui_story"]) and arg_97_1.var_.characterEffect10075ui_story == nil then
				arg_97_1.var_.characterEffect10075ui_story = arg_97_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10075ui_story"]) then
				if arg_97_1.var_.characterEffect10075ui_story and not isNil(arg_97_1.actors_["10075ui_story"]) then
					arg_97_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10075ui_story"]) and arg_97_1.var_.characterEffect10075ui_story then
				arg_97_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_2 = 0
			local var_100_3 = 0.35

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(319921023)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 14 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 14)

				if (14 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 14)) > 0 and var_100_3 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921023", "story_v_out_319921.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921023", "story_v_out_319921.awb") / 1000

					if var_100_8 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_2
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_out_319921", "319921023", "story_v_out_319921.awb")

						arg_97_1:RecordAudio("319921023", var_100_9)
						arg_97_1:RecordAudio("319921023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319921", "319921023", "story_v_out_319921.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319921", "319921023", "story_v_out_319921.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_10 and arg_97_1.time_ < var_100_2 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319921024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319921024
		arg_101_1.duration_ = 9.67

		local var_101_0 = {
			zh = 6,
			ja = 9.666
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
				arg_101_0:Play319921025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10075ui_story"]) and arg_101_1.var_.characterEffect10075ui_story == nil then
				arg_101_1.var_.characterEffect10075ui_story = arg_101_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10075ui_story"]) then
				if arg_101_1.var_.characterEffect10075ui_story and not isNil(arg_101_1.actors_["10075ui_story"]) then
					arg_101_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10075ui_story"]) and arg_101_1.var_.characterEffect10075ui_story then
				arg_101_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_104_1 = arg_101_1.actors_["1084ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_104_4 = 0
			local var_104_5 = 0.65

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(319921024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 26 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 26)

				if (26 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 26)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921024", "story_v_out_319921.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921024", "story_v_out_319921.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_319921", "319921024", "story_v_out_319921.awb")

						arg_101_1:RecordAudio("319921024", var_104_11)
						arg_101_1:RecordAudio("319921024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319921", "319921024", "story_v_out_319921.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319921", "319921024", "story_v_out_319921.awb")
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

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319921025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319921025
		arg_105_1.duration_ = 6.27

		local var_105_0 = {
			zh = 2.3,
			ja = 6.266
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
				arg_105_0:Play319921026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10075ui_story"]) and arg_105_1.var_.characterEffect10075ui_story == nil then
				arg_105_1.var_.characterEffect10075ui_story = arg_105_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10075ui_story"]) then
				if arg_105_1.var_.characterEffect10075ui_story and not isNil(arg_105_1.actors_["10075ui_story"]) then
					arg_105_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10075ui_story"]) and arg_105_1.var_.characterEffect10075ui_story then
				arg_105_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_108_2 = arg_105_1.actors_["1084ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect1084ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_3)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect1084ui_story then
				arg_105_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_108_4 = 0
			local var_108_5 = 0.25

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(319921025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 10 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 10)

				if (10 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 10)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921025", "story_v_out_319921.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921025", "story_v_out_319921.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_319921", "319921025", "story_v_out_319921.awb")

						arg_105_1:RecordAudio("319921025", var_108_11)
						arg_105_1:RecordAudio("319921025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319921", "319921025", "story_v_out_319921.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319921", "319921025", "story_v_out_319921.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319921026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319921026
		arg_109_1.duration_ = 3.6

		local var_109_0 = {
			zh = 2.233,
			ja = 3.6
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
				arg_109_0:Play319921027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = arg_109_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) then
				if arg_109_1.var_.characterEffect1084ui_story and not isNil(arg_109_1.actors_["1084ui_story"]) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_2 = arg_109_1.actors_["10075ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect10075ui_story == nil then
				arg_109_1.var_.characterEffect10075ui_story = var_112_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.characterEffect10075ui_story and not isNil(var_112_2) then
					arg_109_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_3)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect10075ui_story then
				arg_109_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_4 = 0.5
			local var_112_5 = 0.233333333333333

			if 0.5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_6 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_6:setOnUpdate(LuaHelper.FloatAction(function(arg_113_0)
					arg_109_1.dialogCg_.alpha = arg_113_0
				end))
				var_112_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(319921026)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 10 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_8) / 10)

				if (10 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_8) / 10)) > 0 and var_112_5 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10
					var_112_4 = var_112_4 + 0.3

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921026", "story_v_out_319921.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_319921", "319921026", "story_v_out_319921.awb") / 1000

					if var_112_11 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_4
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_319921", "319921026", "story_v_out_319921.awb")

						arg_109_1:RecordAudio("319921026", var_112_12)
						arg_109_1:RecordAudio("319921026", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319921", "319921026", "story_v_out_319921.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319921", "319921026", "story_v_out_319921.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = var_112_4 + 0.3
			local var_112_14 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_13 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_13) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_13 + var_112_14 and arg_109_1.time_ < var_112_13 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319921027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319921027
		arg_115_1.duration_ = 9.7

		local var_115_0 = {
			zh = 9.7,
			ja = 6.5
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play319921028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10075ui_story = arg_115_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10075ui_story"].transform.position).z)
				arg_115_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10075ui_story"].transform.localEulerAngles = arg_115_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_115_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["10075ui_story"].transform.position).z)
				arg_115_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["10075ui_story"].transform.localEulerAngles = arg_115_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["10075ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10075ui_story == nil then
				arg_115_1.var_.characterEffect10075ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect10075ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect10075ui_story then
				arg_115_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			local var_118_4 = arg_115_1.actors_["1084ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_5 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 and not isNil(var_118_4) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_4) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_5)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_118_6 = 0
			local var_118_7 = 1.025

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(319921027)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 41 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 41)

				if (41 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_9) / 41)) > 0 and var_118_7 < var_118_11 then
					arg_115_1.talkMaxDuration = var_118_11

					if var_118_11 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921027", "story_v_out_319921.awb") ~= 0 then
					local var_118_12 = manager.audio:GetVoiceLength("story_v_out_319921", "319921027", "story_v_out_319921.awb") / 1000

					if var_118_12 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_6
					end

					if var_118_8.prefab_name ~= "" and arg_115_1.actors_[var_118_8.prefab_name] ~= nil then
						local var_118_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_8.prefab_name].transform, "story_v_out_319921", "319921027", "story_v_out_319921.awb")

						arg_115_1:RecordAudio("319921027", var_118_13)
						arg_115_1:RecordAudio("319921027", var_118_13)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319921", "319921027", "story_v_out_319921.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319921", "319921027", "story_v_out_319921.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play319921028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319921028
		arg_119_1.duration_ = 13.77

		local var_119_0 = {
			zh = 8.6,
			ja = 13.766
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
				arg_119_0:Play319921029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.975

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(319921028)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 39 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 39)

				if (39 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 39)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921028", "story_v_out_319921.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_319921", "319921028", "story_v_out_319921.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_319921", "319921028", "story_v_out_319921.awb")

						arg_119_1:RecordAudio("319921028", var_122_6)
						arg_119_1:RecordAudio("319921028", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319921", "319921028", "story_v_out_319921.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319921", "319921028", "story_v_out_319921.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play319921029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319921029
		arg_123_1.duration_ = 3.87

		local var_123_0 = {
			zh = 3.5,
			ja = 3.866
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
				arg_123_0:Play319921030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1084ui_story = arg_123_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).z)
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles = arg_123_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_123_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1084ui_story"].transform.position).z)
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1084ui_story"].transform.localEulerAngles = arg_123_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1084ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_126_4 = arg_123_1.actors_["10075ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect10075ui_story == nil then
				arg_123_1.var_.characterEffect10075ui_story = var_126_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_5 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 and not isNil(var_126_4) then
				if arg_123_1.var_.characterEffect10075ui_story and not isNil(var_126_4) then
					arg_123_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_5)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 and not isNil(var_126_4) and arg_123_1.var_.characterEffect10075ui_story then
				arg_123_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_126_6 = 0
			local var_126_7 = 0.4

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
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

				local var_126_8 = arg_123_1:GetWordFromCfg(319921029)
				local var_126_9 = arg_123_1:FormatText(var_126_8.content)

				arg_123_1.text_.text = var_126_9

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_11 = 16 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 16)

				if (16 <= 0 and var_126_7 or var_126_7 * (utf8.len(var_126_9) / 16)) > 0 and var_126_7 < var_126_11 then
					arg_123_1.talkMaxDuration = var_126_11

					if var_126_11 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_6
					end
				end

				arg_123_1.text_.text = var_126_9
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921029", "story_v_out_319921.awb") ~= 0 then
					local var_126_12 = manager.audio:GetVoiceLength("story_v_out_319921", "319921029", "story_v_out_319921.awb") / 1000

					if var_126_12 + var_126_6 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_6
					end

					if var_126_8.prefab_name ~= "" and arg_123_1.actors_[var_126_8.prefab_name] ~= nil then
						local var_126_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_8.prefab_name].transform, "story_v_out_319921", "319921029", "story_v_out_319921.awb")

						arg_123_1:RecordAudio("319921029", var_126_13)
						arg_123_1:RecordAudio("319921029", var_126_13)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319921", "319921029", "story_v_out_319921.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319921", "319921029", "story_v_out_319921.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_14 = math.max(var_126_7, arg_123_1.talkMaxDuration)

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_14 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_6) / var_126_14

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_6 + var_126_14 and arg_123_1.time_ < var_126_6 + var_126_14 + arg_126_0 then
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
	Play319921030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319921030
		arg_127_1.duration_ = 5.33

		local var_127_0 = {
			zh = 1.999999999999,
			ja = 5.333
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
				arg_127_0:Play319921031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = arg_127_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(arg_127_1.actors_["1084ui_story"]) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1084ui_story"]) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_130_1 = arg_127_1.actors_["10075ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10075ui_story == nil then
				arg_127_1.var_.characterEffect10075ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect10075ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect10075ui_story then
				arg_127_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_130_4 = 0
			local var_130_5 = 0.125

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(319921030)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 5 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 5)

				if (5 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 5)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921030", "story_v_out_319921.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921030", "story_v_out_319921.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_319921", "319921030", "story_v_out_319921.awb")

						arg_127_1:RecordAudio("319921030", var_130_11)
						arg_127_1:RecordAudio("319921030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319921", "319921030", "story_v_out_319921.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319921", "319921030", "story_v_out_319921.awb")
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

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319921031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319921031
		arg_131_1.duration_ = 2

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play319921032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1084ui_story = arg_131_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1084ui_story"].transform.position).z)
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1084ui_story"].transform.localEulerAngles = arg_131_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
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
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = arg_131_1.actors_["10075ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10075ui_story == nil then
				arg_131_1.var_.characterEffect10075ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_5 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 and not isNil(var_134_4) then
				if arg_131_1.var_.characterEffect10075ui_story and not isNil(var_134_4) then
					arg_131_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_5)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect10075ui_story then
				arg_131_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_134_6 = 0.7
			local var_134_7 = 0.1

			if 0.7 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:GetWordFromCfg(319921031)
				local var_134_9 = arg_131_1:FormatText(var_134_8.content)

				arg_131_1.text_.text = var_134_9

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_11 = 4 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 4)

				if (4 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_9) / 4)) > 0 and var_134_7 < var_134_11 then
					arg_131_1.talkMaxDuration = var_134_11

					if var_134_11 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_9
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921031", "story_v_out_319921.awb") ~= 0 then
					local var_134_12 = manager.audio:GetVoiceLength("story_v_out_319921", "319921031", "story_v_out_319921.awb") / 1000

					if var_134_12 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_12 + var_134_6
					end

					if var_134_8.prefab_name ~= "" and arg_131_1.actors_[var_134_8.prefab_name] ~= nil then
						local var_134_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_8.prefab_name].transform, "story_v_out_319921", "319921031", "story_v_out_319921.awb")

						arg_131_1:RecordAudio("319921031", var_134_13)
						arg_131_1:RecordAudio("319921031", var_134_13)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319921", "319921031", "story_v_out_319921.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319921", "319921031", "story_v_out_319921.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_14 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_14 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_14

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_14 and arg_131_1.time_ < var_134_6 + var_134_14 + arg_134_0 then
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
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play319921032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319921032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play319921033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = arg_135_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) then
				if arg_135_1.var_.characterEffect1084ui_story and not isNil(arg_135_1.actors_["1084ui_story"]) then
					arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1084ui_story"]) and arg_135_1.var_.characterEffect1084ui_story then
				arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.75

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(319921032).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 30 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 30)

				if (30 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 30)) > 0 and var_138_2 < var_138_5 then
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
	Play319921033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319921033
		arg_139_1.duration_ = 10.73

		local var_139_0 = {
			zh = 10.733,
			ja = 9.766
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
				arg_139_0:Play319921034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10075ui_story = arg_139_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10075ui_story"].transform.position).z)
				arg_139_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10075ui_story"].transform.localEulerAngles = arg_139_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_139_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10075ui_story"].transform.position).z)
				arg_139_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10075ui_story"].transform.localEulerAngles = arg_139_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10075ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10075ui_story == nil then
				arg_139_1.var_.characterEffect10075ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10075ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10075ui_story then
				arg_139_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = 0
			local var_142_5 = 1.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(319921033)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 45 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 45)

				if (45 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 45)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921033", "story_v_out_319921.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921033", "story_v_out_319921.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_319921", "319921033", "story_v_out_319921.awb")

						arg_139_1:RecordAudio("319921033", var_142_11)
						arg_139_1:RecordAudio("319921033", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319921", "319921033", "story_v_out_319921.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319921", "319921033", "story_v_out_319921.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319921034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319921034
		arg_143_1.duration_ = 11.77

		local var_143_0 = {
			zh = 9.766,
			ja = 11.766
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
				arg_143_0:Play319921035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.875

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(319921034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 35 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 35)

				if (35 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 35)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921034", "story_v_out_319921.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_319921", "319921034", "story_v_out_319921.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_319921", "319921034", "story_v_out_319921.awb")

						arg_143_1:RecordAudio("319921034", var_146_6)
						arg_143_1:RecordAudio("319921034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319921", "319921034", "story_v_out_319921.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319921", "319921034", "story_v_out_319921.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319921035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319921035
		arg_147_1.duration_ = 13

		local var_147_0 = {
			zh = 13,
			ja = 6.533
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
				arg_147_0:Play319921036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action3_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_150_0 = 0
			local var_150_1 = 1.2

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(319921035)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 48 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 48)

				if (48 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_3) / 48)) > 0 and var_150_1 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921035", "story_v_out_319921.awb") ~= 0 then
					local var_150_6 = manager.audio:GetVoiceLength("story_v_out_319921", "319921035", "story_v_out_319921.awb") / 1000

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end

					if var_150_2.prefab_name ~= "" and arg_147_1.actors_[var_150_2.prefab_name] ~= nil then
						local var_150_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_2.prefab_name].transform, "story_v_out_319921", "319921035", "story_v_out_319921.awb")

						arg_147_1:RecordAudio("319921035", var_150_7)
						arg_147_1:RecordAudio("319921035", var_150_7)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319921", "319921035", "story_v_out_319921.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319921", "319921035", "story_v_out_319921.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319921036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319921036
		arg_151_1.duration_ = 19.93

		local var_151_0 = {
			zh = 10.2,
			ja = 19.933
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
				arg_151_0:Play319921037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_0 = 0
			local var_154_1 = 0.925

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(319921036)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 37 <= 0 and var_154_1 or var_154_1 * (utf8.len(var_154_3) / 37)

				if (37 <= 0 and var_154_1 or var_154_1 * (utf8.len(var_154_3) / 37)) > 0 and var_154_1 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921036", "story_v_out_319921.awb") ~= 0 then
					local var_154_6 = manager.audio:GetVoiceLength("story_v_out_319921", "319921036", "story_v_out_319921.awb") / 1000

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end

					if var_154_2.prefab_name ~= "" and arg_151_1.actors_[var_154_2.prefab_name] ~= nil then
						local var_154_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_2.prefab_name].transform, "story_v_out_319921", "319921036", "story_v_out_319921.awb")

						arg_151_1:RecordAudio("319921036", var_154_7)
						arg_151_1:RecordAudio("319921036", var_154_7)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319921", "319921036", "story_v_out_319921.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319921", "319921036", "story_v_out_319921.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_8 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_8 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_8

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_8 and arg_151_1.time_ < var_154_0 + var_154_8 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319921037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319921037
		arg_155_1.duration_ = 10.63

		local var_155_0 = {
			zh = 10.6,
			ja = 10.633
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
				arg_155_0:Play319921038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.95

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(319921037)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 38 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 38)

				if (38 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 38)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921037", "story_v_out_319921.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_319921", "319921037", "story_v_out_319921.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_319921", "319921037", "story_v_out_319921.awb")

						arg_155_1:RecordAudio("319921037", var_158_6)
						arg_155_1:RecordAudio("319921037", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319921", "319921037", "story_v_out_319921.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319921", "319921037", "story_v_out_319921.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319921038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319921038
		arg_159_1.duration_ = 9.03

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play319921039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				SetActive(arg_159_1.dialog_, false)
				SetActive(arg_159_1.allBtn_.gameObject, false)
				arg_159_1.hideBtnsController_:SetSelectedIndex(1)
				arg_159_1:PlayOnlyBgm()

				arg_159_1.marker = "tingzhi"

				manager.video:Play("SofdecAsset/story/story_1031992.usm", function(arg_163_0)
					if arg_159_1.state_ == "playing" then
						arg_159_1:JumpToEnd()
					end

					if arg_159_1.playNext_ and not arg_159_1.auto_ then
						arg_159_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_164_0)
					arg_159_1.state_ = arg_164_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_162_0 = 9.03333333333333

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				-- block empty
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.marker = ""
			end

			local var_162_1 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.allBtn_.enabled = false
			end

			if arg_159_1.time_ >= var_162_1 + 9.03333333333333 and arg_159_1.time_ < var_162_1 + 9.03333333333333 + arg_162_0 then
				arg_159_1.allBtn_.enabled = true
			end

			local var_162_2 = arg_159_1.actors_["1084ui_story"].transform

			if 0.0333333333333333 < arg_159_1.time_ and arg_159_1.time_ <= 0.0333333333333333 + arg_162_0 then
				arg_159_1.var_.moveOldPos1084ui_story = var_162_2.localPosition
			end

			local var_162_3 = 0.1

			if 0.0333333333333333 <= arg_159_1.time_ and arg_159_1.time_ < 0.0333333333333333 + var_162_3 then
				var_162_2.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0.0333333333333333) / var_162_3)
				var_162_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_2.position).x, (manager.ui.mainCamera.transform.position - var_162_2.position).y, (manager.ui.mainCamera.transform.position - var_162_2.position).z)
				var_162_2.localEulerAngles.z = 0
				var_162_2.localEulerAngles.x = 0
				var_162_2.localEulerAngles = var_162_2.localEulerAngles
			end

			if arg_159_1.time_ >= 0.0333333333333333 + var_162_3 and arg_159_1.time_ < 0.0333333333333333 + var_162_3 + arg_162_0 then
				var_162_2.localPosition = Vector3.New(0, 100, 0)
				var_162_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_2.position).x, (manager.ui.mainCamera.transform.position - var_162_2.position).y, (manager.ui.mainCamera.transform.position - var_162_2.position).z)
				var_162_2.localEulerAngles.z = 0
				var_162_2.localEulerAngles.x = 0
				var_162_2.localEulerAngles = var_162_2.localEulerAngles
			end

			local var_162_4 = arg_159_1.actors_["10075ui_story"].transform

			if 0.0333333333333333 < arg_159_1.time_ and arg_159_1.time_ <= 0.0333333333333333 + arg_162_0 then
				arg_159_1.var_.moveOldPos10075ui_story = var_162_4.localPosition
			end

			local var_162_5 = 0.1

			if 0.0333333333333333 <= arg_159_1.time_ and arg_159_1.time_ < 0.0333333333333333 + var_162_5 then
				var_162_4.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0.0333333333333333) / var_162_5)
				var_162_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_4.position).x, (manager.ui.mainCamera.transform.position - var_162_4.position).y, (manager.ui.mainCamera.transform.position - var_162_4.position).z)
				var_162_4.localEulerAngles.z = 0
				var_162_4.localEulerAngles.x = 0
				var_162_4.localEulerAngles = var_162_4.localEulerAngles
			end

			if arg_159_1.time_ >= 0.0333333333333333 + var_162_5 and arg_159_1.time_ < 0.0333333333333333 + var_162_5 + arg_162_0 then
				var_162_4.localPosition = Vector3.New(0, 100, 0)
				var_162_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_4.position).x, (manager.ui.mainCamera.transform.position - var_162_4.position).y, (manager.ui.mainCamera.transform.position - var_162_4.position).z)
				var_162_4.localEulerAngles.z = 0
				var_162_4.localEulerAngles.x = 0
				var_162_4.localEulerAngles = var_162_4.localEulerAngles
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play319921039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319921039
		arg_165_1.duration_ = 4.8

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319921040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 2.8 < arg_165_1.time_ and arg_165_1.time_ <= 2.8 + arg_168_0 then
				arg_165_1.var_.moveOldPos1084ui_story = arg_165_1.actors_["1084ui_story"].transform.localPosition

				arg_165_1:ShowWeapon(arg_165_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_168_0 = 0.001

			if 2.8 <= arg_165_1.time_ and arg_165_1.time_ < 2.8 + var_168_0 then
				arg_165_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_165_1.time_ - 2.8) / var_168_0)
				arg_165_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).z)
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles = arg_165_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 2.8 + var_168_0 and arg_165_1.time_ < 2.8 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_165_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1084ui_story"].transform.position).z)
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1084ui_story"].transform.localEulerAngles = arg_165_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1084ui_story"]

			if 2.8 < arg_165_1.time_ and arg_165_1.time_ <= 2.8 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1084ui_story == nil then
				arg_165_1.var_.characterEffect1084ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 2.8 <= arg_165_1.time_ and arg_165_1.time_ < 2.8 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1084ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 2.8 + var_168_2 and arg_165_1.time_ < 2.8 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1084ui_story then
				arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 2.8 < arg_165_1.time_ and arg_165_1.time_ <= 2.8 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 2.8 < arg_165_1.time_ and arg_165_1.time_ <= 2.8 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(false)
				arg_165_1.dialog_:SetActive(false)
				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			if 0.133333333333333 < arg_165_1.time_ and arg_165_1.time_ <= 0.133333333333333 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(false)
				arg_165_1.dialog_:SetActive(false)
				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_4 = arg_165_1.bgs_.ST71

				arg_165_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_168_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_5 = var_168_4:GetComponent("SpriteRenderer")

				if var_168_5 and var_168_5.sprite then
					local var_168_6 = 2 * (var_168_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_168_4.transform.localScale = Vector3.New(var_168_6 / var_168_5.sprite.bounds.size.y < var_168_6 * manager.ui.mainCameraCom_.aspect / var_168_5.sprite.bounds.size.x and var_168_6 * manager.ui.mainCameraCom_.aspect / var_168_5.sprite.bounds.size.x or var_168_6 / var_168_5.sprite.bounds.size.y, var_168_6 / var_168_5.sprite.bounds.size.y < var_168_6 * manager.ui.mainCameraCom_.aspect / var_168_5.sprite.bounds.size.x and var_168_6 * manager.ui.mainCameraCom_.aspect / var_168_5.sprite.bounds.size.x or var_168_6 / var_168_5.sprite.bounds.size.y, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "ST71" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_7 = arg_165_1.actors_["1084ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1084ui_story = var_168_7.localPosition
			end

			local var_168_8 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_8 then
				var_168_7.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_8)
				var_168_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_7.position).x, (manager.ui.mainCamera.transform.position - var_168_7.position).y, (manager.ui.mainCamera.transform.position - var_168_7.position).z)
				var_168_7.localEulerAngles.z = 0
				var_168_7.localEulerAngles.x = 0
				var_168_7.localEulerAngles = var_168_7.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_8 and arg_165_1.time_ < 0 + var_168_8 + arg_168_0 then
				var_168_7.localPosition = Vector3.New(0, 100, 0)
				var_168_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_7.position).x, (manager.ui.mainCamera.transform.position - var_168_7.position).y, (manager.ui.mainCamera.transform.position - var_168_7.position).z)
				var_168_7.localEulerAngles.z = 0
				var_168_7.localEulerAngles.x = 0
				var_168_7.localEulerAngles = var_168_7.localEulerAngles
			end

			local var_168_9 = arg_165_1.actors_["10075ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10075ui_story = var_168_9.localPosition
			end

			local var_168_10 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_10 then
				var_168_9.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_10)
				var_168_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_9.position).x, (manager.ui.mainCamera.transform.position - var_168_9.position).y, (manager.ui.mainCamera.transform.position - var_168_9.position).z)
				var_168_9.localEulerAngles.z = 0
				var_168_9.localEulerAngles.x = 0
				var_168_9.localEulerAngles = var_168_9.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_10 and arg_165_1.time_ < 0 + var_168_10 + arg_168_0 then
				var_168_9.localPosition = Vector3.New(0, 100, 0)
				var_168_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_9.position).x, (manager.ui.mainCamera.transform.position - var_168_9.position).y, (manager.ui.mainCamera.transform.position - var_168_9.position).z)
				var_168_9.localEulerAngles.z = 0
				var_168_9.localEulerAngles.x = 0
				var_168_9.localEulerAngles = var_168_9.localEulerAngles
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.cswbg_:SetActive(false)
			end

			local var_168_11 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_12 = 3

			if var_168_11 <= arg_165_1.time_ and arg_165_1.time_ < var_168_11 + var_168_12 then
				local var_168_13 = Color.New(0, 0, 0)

				var_168_13.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - var_168_11) / var_168_12)
				arg_165_1.mask_.color = var_168_13
			end

			if arg_165_1.time_ >= var_168_11 + var_168_12 and arg_165_1.time_ < var_168_11 + var_168_12 + arg_168_0 then
				local var_168_14 = Color.New(0, 0, 0)

				arg_165_1.mask_.enabled = false
				var_168_14.a = 0
				arg_165_1.mask_.color = var_168_14
			end

			local var_168_15 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				SetActive(arg_165_1.dialog_, true)
				SetActive(arg_165_1.allBtn_.gameObject, true)
				arg_165_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_165_1.isInLoopVideo = false
			end

			local var_168_16 = 0.1

			if var_168_15 <= arg_165_1.time_ and arg_165_1.time_ < var_168_15 + var_168_16 then
				-- block empty
			end

			if arg_165_1.time_ >= var_168_15 + var_168_16 and arg_165_1.time_ < var_168_15 + var_168_16 + arg_168_0 then
				-- block empty
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_17 = 3.00000000298023
			local var_168_18 = 0.125

			if 3.00000000298023 < arg_165_1.time_ and arg_165_1.time_ <= var_168_17 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_19 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_19:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_20 = arg_165_1:GetWordFromCfg(319921039)
				local var_168_21 = arg_165_1:FormatText(var_168_20.content)

				arg_165_1.text_.text = var_168_21

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_23 = 5 <= 0 and var_168_18 or var_168_18 * (utf8.len(var_168_21) / 5)

				if (5 <= 0 and var_168_18 or var_168_18 * (utf8.len(var_168_21) / 5)) > 0 and var_168_18 < var_168_23 then
					arg_165_1.talkMaxDuration = var_168_23
					var_168_17 = var_168_17 + 0.3

					if var_168_23 + var_168_17 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_23 + var_168_17
					end
				end

				arg_165_1.text_.text = var_168_21
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921039", "story_v_out_319921.awb") ~= 0 then
					local var_168_24 = manager.audio:GetVoiceLength("story_v_out_319921", "319921039", "story_v_out_319921.awb") / 1000

					if var_168_24 + var_168_17 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_24 + var_168_17
					end

					if var_168_20.prefab_name ~= "" and arg_165_1.actors_[var_168_20.prefab_name] ~= nil then
						local var_168_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_20.prefab_name].transform, "story_v_out_319921", "319921039", "story_v_out_319921.awb")

						arg_165_1:RecordAudio("319921039", var_168_25)
						arg_165_1:RecordAudio("319921039", var_168_25)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_319921", "319921039", "story_v_out_319921.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_319921", "319921039", "story_v_out_319921.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_26 = var_168_17 + 0.3
			local var_168_27 = math.max(var_168_18, arg_165_1.talkMaxDuration)

			if var_168_17 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_26 + var_168_27 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_26) / var_168_27

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_26 + var_168_27 and arg_165_1.time_ < var_168_26 + var_168_27 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.8,
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
			},
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319921040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319921040
		arg_171_1.duration_ = 12.03

		local var_171_0 = {
			zh = 5.633,
			ja = 12.033
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
				arg_171_0:Play319921041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10075ui_story = arg_171_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10075ui_story"].transform.position).z)
				arg_171_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10075ui_story"].transform.localEulerAngles = arg_171_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_171_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10075ui_story"].transform.position).z)
				arg_171_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10075ui_story"].transform.localEulerAngles = arg_171_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10075ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10075ui_story == nil then
				arg_171_1.var_.characterEffect10075ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10075ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10075ui_story then
				arg_171_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_174_4 = arg_171_1.actors_["1084ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1084ui_story == nil then
				arg_171_1.var_.characterEffect1084ui_story = var_174_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_5 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_5 and not isNil(var_174_4) then
				if arg_171_1.var_.characterEffect1084ui_story and not isNil(var_174_4) then
					arg_171_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_5)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_5 and arg_171_1.time_ < 0 + var_174_5 + arg_174_0 and not isNil(var_174_4) and arg_171_1.var_.characterEffect1084ui_story then
				arg_171_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_174_6 = 0
			local var_174_7 = 0.625

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_8 = arg_171_1:GetWordFromCfg(319921040)
				local var_174_9 = arg_171_1:FormatText(var_174_8.content)

				arg_171_1.text_.text = var_174_9

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 25 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 25)

				if (25 <= 0 and var_174_7 or var_174_7 * (utf8.len(var_174_9) / 25)) > 0 and var_174_7 < var_174_11 then
					arg_171_1.talkMaxDuration = var_174_11

					if var_174_11 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_9
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921040", "story_v_out_319921.awb") ~= 0 then
					local var_174_12 = manager.audio:GetVoiceLength("story_v_out_319921", "319921040", "story_v_out_319921.awb") / 1000

					if var_174_12 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_12 + var_174_6
					end

					if var_174_8.prefab_name ~= "" and arg_171_1.actors_[var_174_8.prefab_name] ~= nil then
						local var_174_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_8.prefab_name].transform, "story_v_out_319921", "319921040", "story_v_out_319921.awb")

						arg_171_1:RecordAudio("319921040", var_174_13)
						arg_171_1:RecordAudio("319921040", var_174_13)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319921", "319921040", "story_v_out_319921.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319921", "319921040", "story_v_out_319921.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_14 and arg_171_1.time_ < var_174_6 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319921041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319921041
		arg_175_1.duration_ = 9.8

		local var_175_0 = {
			zh = 7.866,
			ja = 9.8
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
				arg_175_0:Play319921042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.675

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(319921041)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 27 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 27)

				if (27 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 27)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921041", "story_v_out_319921.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_319921", "319921041", "story_v_out_319921.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_319921", "319921041", "story_v_out_319921.awb")

						arg_175_1:RecordAudio("319921041", var_178_6)
						arg_175_1:RecordAudio("319921041", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_319921", "319921041", "story_v_out_319921.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_319921", "319921041", "story_v_out_319921.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319921042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319921042
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319921043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10075ui_story"]) and arg_179_1.var_.characterEffect10075ui_story == nil then
				arg_179_1.var_.characterEffect10075ui_story = arg_179_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10075ui_story"]) then
				if arg_179_1.var_.characterEffect10075ui_story and not isNil(arg_179_1.actors_["10075ui_story"]) then
					arg_179_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_0)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10075ui_story"]) and arg_179_1.var_.characterEffect10075ui_story then
				arg_179_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_182_1 = 0
			local var_182_2 = 0.8

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

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(319921042).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 32 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 32)

				if (32 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 32)) > 0 and var_182_2 < var_182_5 then
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
	Play319921043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319921043
		arg_183_1.duration_ = 6.9

		local var_183_0 = {
			zh = 6.6,
			ja = 6.9
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
				arg_183_0:Play319921044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) and arg_183_1.var_.characterEffect1084ui_story == nil then
				arg_183_1.var_.characterEffect1084ui_story = arg_183_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) then
				if arg_183_1.var_.characterEffect1084ui_story and not isNil(arg_183_1.actors_["1084ui_story"]) then
					arg_183_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) and arg_183_1.var_.characterEffect1084ui_story then
				arg_183_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_186_2 = 0
			local var_186_3 = 0.7

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_4 = arg_183_1:GetWordFromCfg(319921043)
				local var_186_5 = arg_183_1:FormatText(var_186_4.content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 28 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_5) / 28)

				if (28 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_5) / 28)) > 0 and var_186_3 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921043", "story_v_out_319921.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921043", "story_v_out_319921.awb") / 1000

					if var_186_8 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_2
					end

					if var_186_4.prefab_name ~= "" and arg_183_1.actors_[var_186_4.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_4.prefab_name].transform, "story_v_out_319921", "319921043", "story_v_out_319921.awb")

						arg_183_1:RecordAudio("319921043", var_186_9)
						arg_183_1:RecordAudio("319921043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319921", "319921043", "story_v_out_319921.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319921", "319921043", "story_v_out_319921.awb")
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
	Play319921044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319921044
		arg_187_1.duration_ = 13.63

		local var_187_0 = {
			zh = 8.3,
			ja = 13.633
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
				arg_187_0:Play319921045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10075ui_story"]) and arg_187_1.var_.characterEffect10075ui_story == nil then
				arg_187_1.var_.characterEffect10075ui_story = arg_187_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10075ui_story"]) then
				if arg_187_1.var_.characterEffect10075ui_story and not isNil(arg_187_1.actors_["10075ui_story"]) then
					arg_187_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10075ui_story"]) and arg_187_1.var_.characterEffect10075ui_story then
				arg_187_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_190_2 = arg_187_1.actors_["1084ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect1084ui_story == nil then
				arg_187_1.var_.characterEffect1084ui_story = var_190_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_3 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.characterEffect1084ui_story and not isNil(var_190_2) then
					arg_187_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_3)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect1084ui_story then
				arg_187_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_190_4 = 0
			local var_190_5 = 0.775

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(319921044)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 31 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 31)

				if (31 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 31)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921044", "story_v_out_319921.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921044", "story_v_out_319921.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_319921", "319921044", "story_v_out_319921.awb")

						arg_187_1:RecordAudio("319921044", var_190_11)
						arg_187_1:RecordAudio("319921044", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319921", "319921044", "story_v_out_319921.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319921", "319921044", "story_v_out_319921.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319921045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319921045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319921046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10075ui_story"]) and arg_191_1.var_.characterEffect10075ui_story == nil then
				arg_191_1.var_.characterEffect10075ui_story = arg_191_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10075ui_story"]) then
				if arg_191_1.var_.characterEffect10075ui_story and not isNil(arg_191_1.actors_["10075ui_story"]) then
					arg_191_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10075ui_story"]) and arg_191_1.var_.characterEffect10075ui_story then
				arg_191_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_194_1 = 0
			local var_194_2 = 1.05

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(319921045).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 42 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 42)

				if (42 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 42)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319921046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319921046
		arg_195_1.duration_ = 12.6

		local var_195_0 = {
			zh = 7.8,
			ja = 12.6
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
				arg_195_0:Play319921047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10075ui_story"]) and arg_195_1.var_.characterEffect10075ui_story == nil then
				arg_195_1.var_.characterEffect10075ui_story = arg_195_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10075ui_story"]) then
				if arg_195_1.var_.characterEffect10075ui_story and not isNil(arg_195_1.actors_["10075ui_story"]) then
					arg_195_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10075ui_story"]) and arg_195_1.var_.characterEffect10075ui_story then
				arg_195_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action11_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_198_2 = 0
			local var_198_3 = 0.825

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_2 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_4 = arg_195_1:GetWordFromCfg(319921046)
				local var_198_5 = arg_195_1:FormatText(var_198_4.content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 33 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 33)

				if (33 <= 0 and var_198_3 or var_198_3 * (utf8.len(var_198_5) / 33)) > 0 and var_198_3 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_2
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921046", "story_v_out_319921.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921046", "story_v_out_319921.awb") / 1000

					if var_198_8 + var_198_2 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_2
					end

					if var_198_4.prefab_name ~= "" and arg_195_1.actors_[var_198_4.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_4.prefab_name].transform, "story_v_out_319921", "319921046", "story_v_out_319921.awb")

						arg_195_1:RecordAudio("319921046", var_198_9)
						arg_195_1:RecordAudio("319921046", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319921", "319921046", "story_v_out_319921.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319921", "319921046", "story_v_out_319921.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_3, arg_195_1.talkMaxDuration)

			if var_198_2 <= arg_195_1.time_ and arg_195_1.time_ < var_198_2 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_2) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_2 + var_198_10 and arg_195_1.time_ < var_198_2 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319921047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319921047
		arg_199_1.duration_ = 7.77

		local var_199_0 = {
			zh = 7.766,
			ja = 6.833
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
				arg_199_0:Play319921048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.95

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(319921047)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 38 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 38)

				if (38 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 38)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921047", "story_v_out_319921.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_319921", "319921047", "story_v_out_319921.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_319921", "319921047", "story_v_out_319921.awb")

						arg_199_1:RecordAudio("319921047", var_202_6)
						arg_199_1:RecordAudio("319921047", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_319921", "319921047", "story_v_out_319921.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_319921", "319921047", "story_v_out_319921.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play319921048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319921048
		arg_203_1.duration_ = 12.6

		local var_203_0 = {
			zh = 4.133,
			ja = 12.6
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
				arg_203_0:Play319921049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10075ui_story = arg_203_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10075ui_story"].transform.position).z)
				arg_203_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10075ui_story"].transform.localEulerAngles = arg_203_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_203_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["10075ui_story"].transform.position).z)
				arg_203_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["10075ui_story"].transform.localEulerAngles = arg_203_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action11_2")
			end

			local var_206_1 = 0
			local var_206_2 = 0.35

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(319921048)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_6 = 14 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_4) / 14)

				if (14 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_4) / 14)) > 0 and var_206_2 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921048", "story_v_out_319921.awb") ~= 0 then
					local var_206_7 = manager.audio:GetVoiceLength("story_v_out_319921", "319921048", "story_v_out_319921.awb") / 1000

					if var_206_7 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_1
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_319921", "319921048", "story_v_out_319921.awb")

						arg_203_1:RecordAudio("319921048", var_206_8)
						arg_203_1:RecordAudio("319921048", var_206_8)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319921", "319921048", "story_v_out_319921.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319921", "319921048", "story_v_out_319921.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_9 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_9 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_9

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_9 and arg_203_1.time_ < var_206_1 + var_206_9 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10075ui_story",
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
	Play319921049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319921049
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play319921050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1084ui_story = arg_207_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).z)
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles = arg_207_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).z)
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles = arg_207_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				local var_210_1 = arg_207_1.fswbg_.transform:Find("textbox/adapt/content") or arg_207_1.fswbg_.transform:Find("textbox/content")
				local var_210_2 = arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_210_3 = var_210_1:GetComponent("RectTransform")

				var_210_1:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_210_3.offsetMin = Vector2.New(0, 0)
				var_210_3.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(true)
				arg_207_1.dialog_:SetActive(false)

				arg_207_1.fswtw_.percent = 0
				arg_207_1.fswt_.text = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(319921049).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.fswt_)

				arg_207_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_207_1.fswtw_:SetDirty()

				arg_207_1.typewritterCharCountI18N = 0

				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_4 = 0.866666666666667

			if 0.866666666666667 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.var_.oldValueTypewriter = arg_207_1.fswtw_.percent

				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_5 = 15
			local var_210_6 = 1
			local var_210_7, var_210_8 = arg_207_1:GetPercentByPara(arg_207_1:FormatText(arg_207_1:GetWordFromCfg(319921049).content), 1)

			if var_210_4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				local var_210_9 = var_210_5 <= 0 and var_210_6 or var_210_6 * ((var_210_8 - arg_207_1.typewritterCharCountI18N) / var_210_5)

				if (var_210_5 <= 0 and var_210_6 or var_210_6 * ((var_210_8 - arg_207_1.typewritterCharCountI18N) / var_210_5)) > 0 and var_210_6 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end
			end

			local var_210_10 = math.max(1, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_10 then
				arg_207_1.fswtw_.percent = Mathf.Lerp(arg_207_1.var_.oldValueTypewriter, var_210_7, (arg_207_1.time_ - var_210_4) / var_210_10)
				arg_207_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_207_1.fswtw_:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_10 and arg_207_1.time_ < var_210_4 + var_210_10 + arg_210_0 then
				arg_207_1.fswtw_.percent = var_210_7

				arg_207_1.fswtw_:SetDirty()
				arg_207_1:ShowNextGo(true)

				arg_207_1.typewritterCharCountI18N = var_210_8
			end

			local var_210_11 = "STblack"

			if arg_207_1.bgs_.STblack == nil then
				local var_210_12 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_210_11)
				var_210_12.name = var_210_11
				var_210_12.transform.parent = arg_207_1.stage_.transform
				var_210_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_[var_210_11] = var_210_12
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				local var_210_13 = arg_207_1.bgs_.STblack

				arg_207_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_14 = var_210_13:GetComponent("SpriteRenderer")

				if var_210_14 and var_210_14.sprite then
					local var_210_15 = 2 * (var_210_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_13.transform.localScale = Vector3.New(var_210_15 / var_210_14.sprite.bounds.size.y < var_210_15 * manager.ui.mainCameraCom_.aspect / var_210_14.sprite.bounds.size.x and var_210_15 * manager.ui.mainCameraCom_.aspect / var_210_14.sprite.bounds.size.x or var_210_15 / var_210_14.sprite.bounds.size.y, var_210_15 / var_210_14.sprite.bounds.size.y < var_210_15 * manager.ui.mainCameraCom_.aspect / var_210_14.sprite.bounds.size.x and var_210_15 * manager.ui.mainCameraCom_.aspect / var_210_14.sprite.bounds.size.x or var_210_15 / var_210_14.sprite.bounds.size.y, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "STblack" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_16 = arg_207_1.actors_["10075ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10075ui_story = var_210_16.localPosition
			end

			local var_210_17 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_17 then
				var_210_16.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10075ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_17)
				var_210_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_16.position).x, (manager.ui.mainCamera.transform.position - var_210_16.position).y, (manager.ui.mainCamera.transform.position - var_210_16.position).z)
				var_210_16.localEulerAngles.z = 0
				var_210_16.localEulerAngles.x = 0
				var_210_16.localEulerAngles = var_210_16.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_17 and arg_207_1.time_ < 0 + var_210_17 + arg_210_0 then
				var_210_16.localPosition = Vector3.New(0, 100, 0)
				var_210_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_16.position).x, (manager.ui.mainCamera.transform.position - var_210_16.position).y, (manager.ui.mainCamera.transform.position - var_210_16.position).z)
				var_210_16.localEulerAngles.z = 0
				var_210_16.localEulerAngles.x = 0
				var_210_16.localEulerAngles = var_210_16.localEulerAngles
			end

			local var_210_18 = 0.866666666666667
			local var_210_19 = manager.audio:GetVoiceLength("story_v_out_319921", "319921049", "story_v_out_319921.awb") / 1000

			if var_210_19 > 0 and 3 < var_210_19 and var_210_19 + var_210_18 > arg_207_1.duration_ then
				arg_207_1.duration_ = var_210_19 + var_210_18
			end

			if var_210_18 < arg_207_1.time_ and arg_207_1.time_ <= var_210_18 + arg_210_0 then
				arg_207_1:AudioAction("play", "voice", "story_v_out_319921", "319921049", "story_v_out_319921.awb")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.cswbg_:SetActive(true)

				local var_210_21 = arg_207_1.cswt_:GetComponent("RectTransform")

				arg_207_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_210_21.offsetMin = Vector2.New(410, 330)
				var_210_21.offsetMax = Vector2.New(-400, -175)
				arg_207_1.cswt_.text = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(419076).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.cswt_)

				arg_207_1.cswt_.fontSize = 180
				arg_207_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_207_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_207_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_207_1.nodeConfigList_ = {
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
				actorName = "10075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play319921050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319921050
		arg_211_1.duration_ = 10.57

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play319921051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.fswbg_:SetActive(true)
				arg_211_1.dialog_:SetActive(false)

				arg_211_1.fswtw_.percent = 0
				arg_211_1.fswt_.text = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(319921050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.fswt_)

				arg_211_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_211_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_211_1.fswtw_:SetDirty()

				arg_211_1.typewritterCharCountI18N = 0

				SetActive(arg_211_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_211_1:ShowNextGo(false)
			end

			local var_214_0 = 0.866666666666667

			if 0.866666666666667 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.var_.oldValueTypewriter = arg_211_1.fswtw_.percent

				SetActive(arg_211_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_211_1:ShowNextGo(false)
			end

			local var_214_1 = 41
			local var_214_2 = 2.73333333333333
			local var_214_3, var_214_4 = arg_211_1:GetPercentByPara(arg_211_1:FormatText(arg_211_1:GetWordFromCfg(319921050).content), 1)

			if var_214_0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				local var_214_5 = var_214_1 <= 0 and var_214_2 or var_214_2 * ((var_214_4 - arg_211_1.typewritterCharCountI18N) / var_214_1)

				if (var_214_1 <= 0 and var_214_2 or var_214_2 * ((var_214_4 - arg_211_1.typewritterCharCountI18N) / var_214_1)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_0
					end
				end
			end

			local var_214_6 = math.max(2.73333333333333, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_6 then
				arg_211_1.fswtw_.percent = Mathf.Lerp(arg_211_1.var_.oldValueTypewriter, var_214_3, (arg_211_1.time_ - var_214_0) / var_214_6)
				arg_211_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_211_1.fswtw_:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_6 and arg_211_1.time_ < var_214_0 + var_214_6 + arg_214_0 then
				arg_211_1.fswtw_.percent = var_214_3

				arg_211_1.fswtw_:SetDirty()
				arg_211_1:ShowNextGo(true)

				arg_211_1.typewritterCharCountI18N = var_214_4
			end

			local var_214_7 = 0.866666666666667
			local var_214_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921050", "story_v_out_319921.awb") / 1000

			if var_214_8 > 0 and 9.7 < var_214_8 and var_214_8 + var_214_7 > arg_211_1.duration_ then
				arg_211_1.duration_ = var_214_8 + var_214_7
			end

			if var_214_7 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1:AudioAction("play", "voice", "story_v_out_319921", "319921050", "story_v_out_319921.awb")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.cswbg_:SetActive(true)

				local var_214_10 = arg_211_1.cswt_:GetComponent("RectTransform")

				arg_211_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_214_10.offsetMin = Vector2.New(0, 120)
				var_214_10.offsetMax = Vector2.New(0, 0)
				arg_211_1.cswt_.text = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(419077).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.cswt_)

				arg_211_1.cswt_.fontSize = 140
				arg_211_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_211_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_211_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play319921051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319921051
		arg_215_1.duration_ = 4.9

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319921052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.fswbg_:SetActive(true)
				arg_215_1.dialog_:SetActive(false)

				arg_215_1.fswtw_.percent = 0
				arg_215_1.fswt_.text = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(319921051).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.fswt_)

				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_215_1.fswtw_:SetDirty()

				arg_215_1.typewritterCharCountI18N = 0

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_0 = 0.5

			if 0.5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.var_.oldValueTypewriter = arg_215_1.fswtw_.percent

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_1 = 19
			local var_218_2 = 1.26666666666667
			local var_218_3, var_218_4 = arg_215_1:GetPercentByPara(arg_215_1:FormatText(arg_215_1:GetWordFromCfg(319921051).content), 1)

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				local var_218_5 = var_218_1 <= 0 and var_218_2 or var_218_2 * ((var_218_4 - arg_215_1.typewritterCharCountI18N) / var_218_1)

				if (var_218_1 <= 0 and var_218_2 or var_218_2 * ((var_218_4 - arg_215_1.typewritterCharCountI18N) / var_218_1)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_0
					end
				end
			end

			local var_218_6 = math.max(1.26666666666667, arg_215_1.talkMaxDuration)

			if var_218_0 <= arg_215_1.time_ and arg_215_1.time_ < var_218_0 + var_218_6 then
				arg_215_1.fswtw_.percent = Mathf.Lerp(arg_215_1.var_.oldValueTypewriter, var_218_3, (arg_215_1.time_ - var_218_0) / var_218_6)
				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_215_1.fswtw_:SetDirty()
			end

			if arg_215_1.time_ >= var_218_0 + var_218_6 and arg_215_1.time_ < var_218_0 + var_218_6 + arg_218_0 then
				arg_215_1.fswtw_.percent = var_218_3

				arg_215_1.fswtw_:SetDirty()
				arg_215_1:ShowNextGo(true)

				arg_215_1.typewritterCharCountI18N = var_218_4
			end

			local var_218_7 = 0.5
			local var_218_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921051", "story_v_out_319921.awb") / 1000

			if var_218_8 > 0 and 4.4 < var_218_8 and var_218_8 + var_218_7 > arg_215_1.duration_ then
				arg_215_1.duration_ = var_218_8 + var_218_7
			end

			if var_218_7 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 then
				arg_215_1:AudioAction("play", "voice", "story_v_out_319921", "319921051", "story_v_out_319921.awb")
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play319921052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319921052
		arg_219_1.duration_ = 2.57

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play319921053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(true)
				arg_219_1.dialog_:SetActive(false)

				arg_219_1.fswtw_.percent = 0
				arg_219_1.fswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(319921052).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.fswt_)

				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_219_1.fswtw_:SetDirty()

				arg_219_1.typewritterCharCountI18N = 0

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_0 = 0.866666666666667

			if 0.866666666666667 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_1 = 7
			local var_222_2 = 0.466666666666667
			local var_222_3, var_222_4 = arg_219_1:GetPercentByPara(arg_219_1:FormatText(arg_219_1:GetWordFromCfg(319921052).content), 1)

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_5 = var_222_1 <= 0 and var_222_2 or var_222_2 * ((var_222_4 - arg_219_1.typewritterCharCountI18N) / var_222_1)

				if (var_222_1 <= 0 and var_222_2 or var_222_2 * ((var_222_4 - arg_219_1.typewritterCharCountI18N) / var_222_1)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end
			end

			local var_222_6 = math.max(0.466666666666667, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_6 then
				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_3, (arg_219_1.time_ - var_222_0) / var_222_6)
				arg_219_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_6 and arg_219_1.time_ < var_222_0 + var_222_6 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_3

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_4
			end

			local var_222_7 = 0.866666666666667
			local var_222_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921052", "story_v_out_319921.awb") / 1000

			if var_222_8 > 0 and 1.7 < var_222_8 and var_222_8 + var_222_7 > arg_219_1.duration_ then
				arg_219_1.duration_ = var_222_8 + var_222_7
			end

			if var_222_7 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1:AudioAction("play", "voice", "story_v_out_319921", "319921052", "story_v_out_319921.awb")
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319921053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319921053
		arg_223_1.duration_ = 10.37

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play319921054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.fswbg_:SetActive(true)
				arg_223_1.dialog_:SetActive(false)

				arg_223_1.fswtw_.percent = 0
				arg_223_1.fswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(319921053).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.fswt_)

				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_223_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_223_1.fswtw_:SetDirty()

				arg_223_1.typewritterCharCountI18N = 0

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_0 = 0.733333333333333

			if 0.733333333333333 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.var_.oldValueTypewriter = arg_223_1.fswtw_.percent

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_1 = 28
			local var_226_2 = 1.86666666666667
			local var_226_3, var_226_4 = arg_223_1:GetPercentByPara(arg_223_1:FormatText(arg_223_1:GetWordFromCfg(319921053).content), 1)

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				local var_226_5 = var_226_1 <= 0 and var_226_2 or var_226_2 * ((var_226_4 - arg_223_1.typewritterCharCountI18N) / var_226_1)

				if (var_226_1 <= 0 and var_226_2 or var_226_2 * ((var_226_4 - arg_223_1.typewritterCharCountI18N) / var_226_1)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_0
					end
				end
			end

			local var_226_6 = math.max(1.86666666666667, arg_223_1.talkMaxDuration)

			if var_226_0 <= arg_223_1.time_ and arg_223_1.time_ < var_226_0 + var_226_6 then
				arg_223_1.fswtw_.percent = Mathf.Lerp(arg_223_1.var_.oldValueTypewriter, var_226_3, (arg_223_1.time_ - var_226_0) / var_226_6)
				arg_223_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.fswtw_:SetDirty()
			end

			if arg_223_1.time_ >= var_226_0 + var_226_6 and arg_223_1.time_ < var_226_0 + var_226_6 + arg_226_0 then
				arg_223_1.fswtw_.percent = var_226_3

				arg_223_1.fswtw_:SetDirty()
				arg_223_1:ShowNextGo(true)

				arg_223_1.typewritterCharCountI18N = var_226_4
			end

			local var_226_7 = 0.733333333333333
			local var_226_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921053", "story_v_out_319921.awb") / 1000

			if var_226_8 > 0 and 9.633 < var_226_8 and var_226_8 + var_226_7 > arg_223_1.duration_ then
				arg_223_1.duration_ = var_226_8 + var_226_7
			end

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1:AudioAction("play", "voice", "story_v_out_319921", "319921053", "story_v_out_319921.awb")
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play319921054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 319921054
		arg_227_1.duration_ = 5.87

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play319921055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.fswbg_:SetActive(true)
				arg_227_1.dialog_:SetActive(false)

				arg_227_1.fswtw_.percent = 0
				arg_227_1.fswt_.text = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(319921054).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.fswt_)

				arg_227_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_227_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_227_1.fswtw_:SetDirty()

				arg_227_1.typewritterCharCountI18N = 0

				SetActive(arg_227_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_227_1:ShowNextGo(false)
			end

			local var_230_0 = 0.5

			if 0.5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.var_.oldValueTypewriter = arg_227_1.fswtw_.percent

				SetActive(arg_227_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_227_1:ShowNextGo(false)
			end

			local var_230_1 = 30
			local var_230_2 = 2
			local var_230_3, var_230_4 = arg_227_1:GetPercentByPara(arg_227_1:FormatText(arg_227_1:GetWordFromCfg(319921054).content), 1)

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				local var_230_5 = var_230_1 <= 0 and var_230_2 or var_230_2 * ((var_230_4 - arg_227_1.typewritterCharCountI18N) / var_230_1)

				if (var_230_1 <= 0 and var_230_2 or var_230_2 * ((var_230_4 - arg_227_1.typewritterCharCountI18N) / var_230_1)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end
			end

			local var_230_6 = math.max(2, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_6 then
				arg_227_1.fswtw_.percent = Mathf.Lerp(arg_227_1.var_.oldValueTypewriter, var_230_3, (arg_227_1.time_ - var_230_0) / var_230_6)
				arg_227_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_227_1.fswtw_:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_6 and arg_227_1.time_ < var_230_0 + var_230_6 + arg_230_0 then
				arg_227_1.fswtw_.percent = var_230_3

				arg_227_1.fswtw_:SetDirty()
				arg_227_1:ShowNextGo(true)

				arg_227_1.typewritterCharCountI18N = var_230_4
			end

			local var_230_7 = 0.5
			local var_230_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921054", "story_v_out_319921.awb") / 1000

			if var_230_8 > 0 and 5.366 < var_230_8 and var_230_8 + var_230_7 > arg_227_1.duration_ then
				arg_227_1.duration_ = var_230_8 + var_230_7
			end

			if var_230_7 < arg_227_1.time_ and arg_227_1.time_ <= var_230_7 + arg_230_0 then
				arg_227_1:AudioAction("play", "voice", "story_v_out_319921", "319921054", "story_v_out_319921.awb")
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play319921055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319921055
		arg_231_1.duration_ = 2.33

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play319921056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.fswbg_:SetActive(true)
				arg_231_1.dialog_:SetActive(false)

				arg_231_1.fswtw_.percent = 0
				arg_231_1.fswt_.text = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(319921055).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.fswt_)

				arg_231_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_231_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_231_1.fswtw_:SetDirty()

				arg_231_1.typewritterCharCountI18N = 0

				SetActive(arg_231_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_231_1:ShowNextGo(false)
			end

			local var_234_0 = 0.866666666666667

			if 0.866666666666667 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.var_.oldValueTypewriter = arg_231_1.fswtw_.percent

				SetActive(arg_231_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_231_1:ShowNextGo(false)
			end

			local var_234_1 = 22
			local var_234_2 = 1.46666666666667
			local var_234_3, var_234_4 = arg_231_1:GetPercentByPara(arg_231_1:FormatText(arg_231_1:GetWordFromCfg(319921055).content), 1)

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				local var_234_5 = var_234_1 <= 0 and var_234_2 or var_234_2 * ((var_234_4 - arg_231_1.typewritterCharCountI18N) / var_234_1)

				if (var_234_1 <= 0 and var_234_2 or var_234_2 * ((var_234_4 - arg_231_1.typewritterCharCountI18N) / var_234_1)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_0
					end
				end
			end

			local var_234_6 = math.max(1.46666666666667, arg_231_1.talkMaxDuration)

			if var_234_0 <= arg_231_1.time_ and arg_231_1.time_ < var_234_0 + var_234_6 then
				arg_231_1.fswtw_.percent = Mathf.Lerp(arg_231_1.var_.oldValueTypewriter, var_234_3, (arg_231_1.time_ - var_234_0) / var_234_6)
				arg_231_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_231_1.fswtw_:SetDirty()
			end

			if arg_231_1.time_ >= var_234_0 + var_234_6 and arg_231_1.time_ < var_234_0 + var_234_6 + arg_234_0 then
				arg_231_1.fswtw_.percent = var_234_3

				arg_231_1.fswtw_:SetDirty()
				arg_231_1:ShowNextGo(true)

				arg_231_1.typewritterCharCountI18N = var_234_4
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.cswbg_:SetActive(true)

				local var_234_7 = arg_231_1.cswt_:GetComponent("RectTransform")

				arg_231_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_234_7.offsetMin = Vector2.New(410, 330)
				var_234_7.offsetMax = Vector2.New(-400, -175)
				arg_231_1.cswt_.text = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(419078).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.cswt_)

				arg_231_1.cswt_.fontSize = 180
				arg_231_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_231_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_231_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play319921056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319921056
		arg_235_1.duration_ = 2.77

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play319921057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.fswbg_:SetActive(true)
				arg_235_1.dialog_:SetActive(false)

				arg_235_1.fswtw_.percent = 0
				arg_235_1.fswt_.text = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(319921056).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.fswt_)

				arg_235_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_235_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_235_1.fswtw_:SetDirty()

				arg_235_1.typewritterCharCountI18N = 0

				SetActive(arg_235_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_235_1:ShowNextGo(false)
			end

			local var_238_0 = 0.766666666666667

			if 0.766666666666667 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.var_.oldValueTypewriter = arg_235_1.fswtw_.percent

				SetActive(arg_235_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_235_1:ShowNextGo(false)
			end

			local var_238_1 = 12
			local var_238_2 = 0.8
			local var_238_3, var_238_4 = arg_235_1:GetPercentByPara(arg_235_1:FormatText(arg_235_1:GetWordFromCfg(319921056).content), 1)

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				local var_238_5 = var_238_1 <= 0 and var_238_2 or var_238_2 * ((var_238_4 - arg_235_1.typewritterCharCountI18N) / var_238_1)

				if (var_238_1 <= 0 and var_238_2 or var_238_2 * ((var_238_4 - arg_235_1.typewritterCharCountI18N) / var_238_1)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_0
					end
				end
			end

			local var_238_6 = math.max(0.8, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_6 then
				arg_235_1.fswtw_.percent = Mathf.Lerp(arg_235_1.var_.oldValueTypewriter, var_238_3, (arg_235_1.time_ - var_238_0) / var_238_6)
				arg_235_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_235_1.fswtw_:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_6 and arg_235_1.time_ < var_238_0 + var_238_6 + arg_238_0 then
				arg_235_1.fswtw_.percent = var_238_3

				arg_235_1.fswtw_:SetDirty()
				arg_235_1:ShowNextGo(true)

				arg_235_1.typewritterCharCountI18N = var_238_4
			end

			local var_238_7 = 0.766666666666667
			local var_238_8 = manager.audio:GetVoiceLength("story_v_out_319921", "319921056", "story_v_out_319921.awb") / 1000

			if var_238_8 > 0 and 2 < var_238_8 and var_238_8 + var_238_7 > arg_235_1.duration_ then
				arg_235_1.duration_ = var_238_8 + var_238_7
			end

			if var_238_7 < arg_235_1.time_ and arg_235_1.time_ <= var_238_7 + arg_238_0 then
				arg_235_1:AudioAction("play", "voice", "story_v_out_319921", "319921056", "story_v_out_319921.awb")
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play319921057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319921057
		arg_239_1.duration_ = 7.33

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play319921058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0.6 < arg_239_1.time_ and arg_239_1.time_ <= 0.6 + arg_242_0 then
				local var_242_0 = arg_239_1.bgs_.ST71

				arg_239_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_242_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_1 = var_242_0:GetComponent("SpriteRenderer")

				if var_242_1 and var_242_1.sprite then
					local var_242_2 = 2 * (var_242_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_242_0.transform.localScale = Vector3.New(var_242_2 / var_242_1.sprite.bounds.size.y < var_242_2 * manager.ui.mainCameraCom_.aspect / var_242_1.sprite.bounds.size.x and var_242_2 * manager.ui.mainCameraCom_.aspect / var_242_1.sprite.bounds.size.x or var_242_2 / var_242_1.sprite.bounds.size.y, var_242_2 / var_242_1.sprite.bounds.size.y < var_242_2 * manager.ui.mainCameraCom_.aspect / var_242_1.sprite.bounds.size.x and var_242_2 * manager.ui.mainCameraCom_.aspect / var_242_1.sprite.bounds.size.x or var_242_2 / var_242_1.sprite.bounds.size.y, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "ST71" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_242_3 = 0

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_3 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_4 = 0.6

			if var_242_3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_3 + var_242_4 then
				local var_242_5 = Color.New(0, 0, 0)

				var_242_5.a = Mathf.Lerp(0, 1, (arg_239_1.time_ - var_242_3) / var_242_4)
				arg_239_1.mask_.color = var_242_5
			end

			if arg_239_1.time_ >= var_242_3 + var_242_4 and arg_239_1.time_ < var_242_3 + var_242_4 + arg_242_0 then
				local var_242_6 = Color.New(0, 0, 0)

				var_242_6.a = 1
				arg_239_1.mask_.color = var_242_6
			end

			local var_242_7 = 0.6

			if 0.6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_7 + arg_242_0 then
				arg_239_1.mask_.enabled = true
				arg_239_1.mask_.raycastTarget = true

				arg_239_1:SetGaussion(false)
			end

			local var_242_8 = 2

			if var_242_7 <= arg_239_1.time_ and arg_239_1.time_ < var_242_7 + var_242_8 then
				local var_242_9 = Color.New(0, 0, 0)

				var_242_9.a = Mathf.Lerp(1, 0, (arg_239_1.time_ - var_242_7) / var_242_8)
				arg_239_1.mask_.color = var_242_9
			end

			if arg_239_1.time_ >= var_242_7 + var_242_8 and arg_239_1.time_ < var_242_7 + var_242_8 + arg_242_0 then
				local var_242_10 = Color.New(0, 0, 0)

				arg_239_1.mask_.enabled = false
				var_242_10.a = 0
				arg_239_1.mask_.color = var_242_10
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.fswbg_:SetActive(false)
				arg_239_1.dialog_:SetActive(false)
				SetActive(arg_239_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_239_1:ShowNextGo(false)
			end

			if 0.1 < arg_239_1.time_ and arg_239_1.time_ <= 0.1 + arg_242_0 then
				arg_239_1.fswbg_:SetActive(false)
				arg_239_1.dialog_:SetActive(false)
				SetActive(arg_239_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_239_1:ShowNextGo(false)
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.cswbg_:SetActive(false)
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_11 = 2.33333333333333
			local var_242_12 = 0.775

			if 2.33333333333333 < arg_239_1.time_ and arg_239_1.time_ <= var_242_11 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_13 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_13:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_14 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(319921057).content)

				arg_239_1.text_.text = var_242_14

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_16 = 31 <= 0 and var_242_12 or var_242_12 * (utf8.len(var_242_14) / 31)

				if (31 <= 0 and var_242_12 or var_242_12 * (utf8.len(var_242_14) / 31)) > 0 and var_242_12 < var_242_16 then
					arg_239_1.talkMaxDuration = var_242_16
					var_242_11 = var_242_11 + 0.3

					if var_242_16 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_16 + var_242_11
					end
				end

				arg_239_1.text_.text = var_242_14
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_17 = var_242_11 + 0.3
			local var_242_18 = math.max(var_242_12, arg_239_1.talkMaxDuration)

			if var_242_11 + 0.3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_17 + var_242_18 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_17) / var_242_18

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_17 + var_242_18 and arg_239_1.time_ < var_242_17 + var_242_18 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play319921058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319921058
		arg_245_1.duration_ = 5.53

		local var_245_0 = {
			zh = 2.6,
			ja = 5.533
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
				arg_245_0:Play319921059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10075ui_story = arg_245_1.actors_["10075ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["10075ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10075ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10075ui_story"].transform.position).z)
				arg_245_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["10075ui_story"].transform.localEulerAngles = arg_245_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["10075ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_245_1.actors_["10075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["10075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10075ui_story"].transform.position).z)
				arg_245_1.actors_["10075ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["10075ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["10075ui_story"].transform.localEulerAngles = arg_245_1.actors_["10075ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["10075ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect10075ui_story == nil then
				arg_245_1.var_.characterEffect10075ui_story = var_248_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 and not isNil(var_248_1) then
				if arg_245_1.var_.characterEffect10075ui_story and not isNil(var_248_1) then
					arg_245_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 and not isNil(var_248_1) and arg_245_1.var_.characterEffect10075ui_story then
				arg_245_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action5_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_248_4 = 0
			local var_248_5 = 0.3

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_6 = arg_245_1:GetWordFromCfg(319921058)
				local var_248_7 = arg_245_1:FormatText(var_248_6.content)

				arg_245_1.text_.text = var_248_7

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_9 = 12 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 12)

				if (12 <= 0 and var_248_5 or var_248_5 * (utf8.len(var_248_7) / 12)) > 0 and var_248_5 < var_248_9 then
					arg_245_1.talkMaxDuration = var_248_9

					if var_248_9 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_9 + var_248_4
					end
				end

				arg_245_1.text_.text = var_248_7
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921058", "story_v_out_319921.awb") ~= 0 then
					local var_248_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921058", "story_v_out_319921.awb") / 1000

					if var_248_10 + var_248_4 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_10 + var_248_4
					end

					if var_248_6.prefab_name ~= "" and arg_245_1.actors_[var_248_6.prefab_name] ~= nil then
						local var_248_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_6.prefab_name].transform, "story_v_out_319921", "319921058", "story_v_out_319921.awb")

						arg_245_1:RecordAudio("319921058", var_248_11)
						arg_245_1:RecordAudio("319921058", var_248_11)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319921", "319921058", "story_v_out_319921.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319921", "319921058", "story_v_out_319921.awb")
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
				actorName = "10075ui_story",
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
	Play319921059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319921059
		arg_249_1.duration_ = 6.13

		local var_249_0 = {
			zh = 5.2,
			ja = 6.133
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
				arg_249_0:Play319921060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1084ui_story = arg_249_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).z)
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles = arg_249_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_249_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["1084ui_story"].transform.position).z)
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["1084ui_story"].transform.localEulerAngles = arg_249_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["1084ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_252_4 = arg_249_1.actors_["10075ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect10075ui_story == nil then
				arg_249_1.var_.characterEffect10075ui_story = var_252_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_5 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_5 and not isNil(var_252_4) then
				if arg_249_1.var_.characterEffect10075ui_story and not isNil(var_252_4) then
					arg_249_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_5)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_5 and arg_249_1.time_ < 0 + var_252_5 + arg_252_0 and not isNil(var_252_4) and arg_249_1.var_.characterEffect10075ui_story then
				arg_249_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			local var_252_6 = 0
			local var_252_7 = 0.65

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_8 = arg_249_1:GetWordFromCfg(319921059)
				local var_252_9 = arg_249_1:FormatText(var_252_8.content)

				arg_249_1.text_.text = var_252_9

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 26 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_9) / 26)

				if (26 <= 0 and var_252_7 or var_252_7 * (utf8.len(var_252_9) / 26)) > 0 and var_252_7 < var_252_11 then
					arg_249_1.talkMaxDuration = var_252_11

					if var_252_11 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_9
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921059", "story_v_out_319921.awb") ~= 0 then
					local var_252_12 = manager.audio:GetVoiceLength("story_v_out_319921", "319921059", "story_v_out_319921.awb") / 1000

					if var_252_12 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_6
					end

					if var_252_8.prefab_name ~= "" and arg_249_1.actors_[var_252_8.prefab_name] ~= nil then
						local var_252_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_8.prefab_name].transform, "story_v_out_319921", "319921059", "story_v_out_319921.awb")

						arg_249_1:RecordAudio("319921059", var_252_13)
						arg_249_1:RecordAudio("319921059", var_252_13)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_319921", "319921059", "story_v_out_319921.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_319921", "319921059", "story_v_out_319921.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_14 and arg_249_1.time_ < var_252_6 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play319921060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319921060
		arg_253_1.duration_ = 3.7

		local var_253_0 = {
			zh = 1.999999999999,
			ja = 3.7
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play319921061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = arg_253_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) then
				if arg_253_1.var_.characterEffect1084ui_story and not isNil(arg_253_1.actors_["1084ui_story"]) then
					arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story then
				arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action5_2")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_1 = arg_253_1.actors_["10075ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect10075ui_story == nil then
				arg_253_1.var_.characterEffect10075ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect10075ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect10075ui_story then
				arg_253_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_256_4 = 0
			local var_256_5 = 0.2

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_6 = arg_253_1:GetWordFromCfg(319921060)
				local var_256_7 = arg_253_1:FormatText(var_256_6.content)

				arg_253_1.text_.text = var_256_7

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_9 = 8 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 8)

				if (8 <= 0 and var_256_5 or var_256_5 * (utf8.len(var_256_7) / 8)) > 0 and var_256_5 < var_256_9 then
					arg_253_1.talkMaxDuration = var_256_9

					if var_256_9 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_9 + var_256_4
					end
				end

				arg_253_1.text_.text = var_256_7
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921060", "story_v_out_319921.awb") ~= 0 then
					local var_256_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921060", "story_v_out_319921.awb") / 1000

					if var_256_10 + var_256_4 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_10 + var_256_4
					end

					if var_256_6.prefab_name ~= "" and arg_253_1.actors_[var_256_6.prefab_name] ~= nil then
						local var_256_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_6.prefab_name].transform, "story_v_out_319921", "319921060", "story_v_out_319921.awb")

						arg_253_1:RecordAudio("319921060", var_256_11)
						arg_253_1:RecordAudio("319921060", var_256_11)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_319921", "319921060", "story_v_out_319921.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_319921", "319921060", "story_v_out_319921.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_12 = math.max(var_256_5, arg_253_1.talkMaxDuration)

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_12 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_4) / var_256_12

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_4 + var_256_12 and arg_253_1.time_ < var_256_4 + var_256_12 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play319921061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319921061
		arg_257_1.duration_ = 6.77

		local var_257_0 = {
			zh = 2.633,
			ja = 6.766
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play319921062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) and arg_257_1.var_.characterEffect1084ui_story == nil then
				arg_257_1.var_.characterEffect1084ui_story = arg_257_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) then
				if arg_257_1.var_.characterEffect1084ui_story and not isNil(arg_257_1.actors_["1084ui_story"]) then
					arg_257_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1084ui_story"]) and arg_257_1.var_.characterEffect1084ui_story then
				arg_257_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_260_2 = arg_257_1.actors_["10075ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect10075ui_story == nil then
				arg_257_1.var_.characterEffect10075ui_story = var_260_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_3 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.characterEffect10075ui_story and not isNil(var_260_2) then
					arg_257_1.var_.characterEffect10075ui_story.fillFlat = true
					arg_257_1.var_.characterEffect10075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_3)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect10075ui_story then
				arg_257_1.var_.characterEffect10075ui_story.fillFlat = true
				arg_257_1.var_.characterEffect10075ui_story.fillRatio = 0.5
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_260_4 = 0
			local var_260_5 = 0.3

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:GetWordFromCfg(319921061)
				local var_260_7 = arg_257_1:FormatText(var_260_6.content)

				arg_257_1.text_.text = var_260_7

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_9 = 12 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 12)

				if (12 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_7) / 12)) > 0 and var_260_5 < var_260_9 then
					arg_257_1.talkMaxDuration = var_260_9

					if var_260_9 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_9 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_7
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921061", "story_v_out_319921.awb") ~= 0 then
					local var_260_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921061", "story_v_out_319921.awb") / 1000

					if var_260_10 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_10 + var_260_4
					end

					if var_260_6.prefab_name ~= "" and arg_257_1.actors_[var_260_6.prefab_name] ~= nil then
						local var_260_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_6.prefab_name].transform, "story_v_out_319921", "319921061", "story_v_out_319921.awb")

						arg_257_1:RecordAudio("319921061", var_260_11)
						arg_257_1:RecordAudio("319921061", var_260_11)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_319921", "319921061", "story_v_out_319921.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_319921", "319921061", "story_v_out_319921.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_12 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_12 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_12

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_12 and arg_257_1.time_ < var_260_4 + var_260_12 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319921062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319921062
		arg_261_1.duration_ = 5.43

		local var_261_0 = {
			zh = 5.433,
			ja = 2
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
				arg_261_0:Play319921063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["10075ui_story"]) and arg_261_1.var_.characterEffect10075ui_story == nil then
				arg_261_1.var_.characterEffect10075ui_story = arg_261_1.actors_["10075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["10075ui_story"]) then
				if arg_261_1.var_.characterEffect10075ui_story and not isNil(arg_261_1.actors_["10075ui_story"]) then
					arg_261_1.var_.characterEffect10075ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["10075ui_story"]) and arg_261_1.var_.characterEffect10075ui_story then
				arg_261_1.var_.characterEffect10075ui_story.fillFlat = false
			end

			local var_264_2 = arg_261_1.actors_["1084ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.characterEffect1084ui_story == nil then
				arg_261_1.var_.characterEffect1084ui_story = var_264_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_3 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.characterEffect1084ui_story and not isNil(var_264_2) then
					arg_261_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_3)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.characterEffect1084ui_story then
				arg_261_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_264_4 = 0
			local var_264_5 = 0.6

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_6 = arg_261_1:GetWordFromCfg(319921062)
				local var_264_7 = arg_261_1:FormatText(var_264_6.content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 24 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 24)

				if (24 <= 0 and var_264_5 or var_264_5 * (utf8.len(var_264_7) / 24)) > 0 and var_264_5 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921062", "story_v_out_319921.awb") ~= 0 then
					local var_264_10 = manager.audio:GetVoiceLength("story_v_out_319921", "319921062", "story_v_out_319921.awb") / 1000

					if var_264_10 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_4
					end

					if var_264_6.prefab_name ~= "" and arg_261_1.actors_[var_264_6.prefab_name] ~= nil then
						local var_264_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_6.prefab_name].transform, "story_v_out_319921", "319921062", "story_v_out_319921.awb")

						arg_261_1:RecordAudio("319921062", var_264_11)
						arg_261_1:RecordAudio("319921062", var_264_11)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319921", "319921062", "story_v_out_319921.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319921", "319921062", "story_v_out_319921.awb")
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

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play319921063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319921063
		arg_265_1.duration_ = 7.6

		local var_265_0 = {
			zh = 7.16666666666667,
			ja = 7.59966666666667
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
			arg_265_1.auto_ = false
		end

		function arg_265_1.playNext_(arg_267_0)
			arg_265_1.onStoryFinished_()
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_0 = 0.766666666666667
			local var_268_1 = 0.65

			if 0.766666666666667 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_2 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_2:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(319921063)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_6 = 26 <= 0 and var_268_1 or var_268_1 * (utf8.len(var_268_4) / 26)

				if (26 <= 0 and var_268_1 or var_268_1 * (utf8.len(var_268_4) / 26)) > 0 and var_268_1 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6
					var_268_0 = var_268_0 + 0.3

					if var_268_6 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_0
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319921", "319921063", "story_v_out_319921.awb") ~= 0 then
					local var_268_7 = manager.audio:GetVoiceLength("story_v_out_319921", "319921063", "story_v_out_319921.awb") / 1000

					if var_268_7 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_7 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_319921", "319921063", "story_v_out_319921.awb")

						arg_265_1:RecordAudio("319921063", var_268_8)
						arg_265_1:RecordAudio("319921063", var_268_8)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319921", "319921063", "story_v_out_319921.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319921", "319921063", "story_v_out_319921.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_9 = var_268_0 + 0.3
			local var_268_10 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_10 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_9) / var_268_10

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_9 + var_268_10 and arg_265_1.time_ < var_268_9 + var_268_10 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/ST71",
		"SofdecAsset/story/story_1031992.usm",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319921.awb"
	},
	skipMarkers = {
		319921038
	}
}
