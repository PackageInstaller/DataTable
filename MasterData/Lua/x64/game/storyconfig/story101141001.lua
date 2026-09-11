return {
	Play114101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114101001
		arg_1_1.duration_ = 12.1

		local var_1_0 = {
			ja = 12.1,
			ko = 7.566,
			zh = 7.8,
			en = 7.6
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F04 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F04")
				var_4_0.name = "F04"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F04 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F04

				arg_1_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F04" then
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

			local var_4_8 = "1068ui_story"

			if arg_1_1.actors_["1068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1068ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1068ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1068ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.95, -5.88)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_4_14 = arg_1_1.actors_["1068ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1068ui_story == nil then
				arg_1_1.var_.characterEffect1068ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1068ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1068ui_story then
				arg_1_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 2
			local var_4_24 = 0.7

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(114101001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 28 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 28)

				if (28 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 28)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101001", "story_v_out_114101.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_114101", "114101001", "story_v_out_114101.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_114101", "114101001", "story_v_out_114101.awb")

						arg_1_1:RecordAudio("114101001", var_4_31)
						arg_1_1:RecordAudio("114101001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114101", "114101001", "story_v_out_114101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114101", "114101001", "story_v_out_114101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play114101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1068ui_story = arg_9_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1068ui_story"].transform.position).z)
				arg_9_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1068ui_story"].transform.localEulerAngles = arg_9_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1068ui_story"].transform.position).z)
				arg_9_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1068ui_story"].transform.localEulerAngles = arg_9_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_12_1 = 0
			local var_12_2 = 1.05

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(114101002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 42 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 42)

				if (42 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 42)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play114101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114101003
		arg_13_1.duration_ = 7.17

		local var_13_0 = {
			ja = 6.3,
			ko = 5.133,
			zh = 4.7,
			en = 7.166
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
				arg_13_0:Play114101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.675

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(114101003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 27 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 27)

				if (27 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 27)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101003", "story_v_out_114101.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_114101", "114101003", "story_v_out_114101.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_114101", "114101003", "story_v_out_114101.awb")

						arg_13_1:RecordAudio("114101003", var_16_6)
						arg_13_1:RecordAudio("114101003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114101", "114101003", "story_v_out_114101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114101", "114101003", "story_v_out_114101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114101004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.975

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(114101004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 39 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 39)

				if (39 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 39)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114101005
		arg_21_1.duration_ = 13.53

		local var_21_0 = {
			ja = 13.533,
			ko = 11.4,
			zh = 9.466,
			en = 10.566
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
				arg_21_0:Play114101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1068ui_story = arg_21_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1068ui_story"].transform.position).z)
				arg_21_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1068ui_story"].transform.localEulerAngles = arg_21_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_21_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1068ui_story"].transform.position).z)
				arg_21_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1068ui_story"].transform.localEulerAngles = arg_21_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_24_1 = arg_21_1.actors_["1068ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1068ui_story == nil then
				arg_21_1.var_.characterEffect1068ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1068ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1068ui_story then
				arg_21_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_24_4 = 0
			local var_24_5 = 1.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(114101005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 50 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 50)

				if (50 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 50)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101005", "story_v_out_114101.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101005", "story_v_out_114101.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_114101", "114101005", "story_v_out_114101.awb")

						arg_21_1:RecordAudio("114101005", var_24_11)
						arg_21_1:RecordAudio("114101005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114101", "114101005", "story_v_out_114101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114101", "114101005", "story_v_out_114101.awb")
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

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play114101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114101006
		arg_25_1.duration_ = 11.67

		local var_25_0 = {
			ja = 8.2,
			ko = 9.9,
			zh = 7.166,
			en = 11.666
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
				arg_25_0:Play114101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1068ui_story"]) and arg_25_1.var_.characterEffect1068ui_story == nil then
				arg_25_1.var_.characterEffect1068ui_story = arg_25_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1068ui_story"]) then
				if arg_25_1.var_.characterEffect1068ui_story and not isNil(arg_25_1.actors_["1068ui_story"]) then
					arg_25_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1068ui_story"]) and arg_25_1.var_.characterEffect1068ui_story then
				arg_25_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.025

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(114101006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 41 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 41)

				if (41 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 41)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101006", "story_v_out_114101.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_114101", "114101006", "story_v_out_114101.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_114101", "114101006", "story_v_out_114101.awb")

						arg_25_1:RecordAudio("114101006", var_28_8)
						arg_25_1:RecordAudio("114101006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114101", "114101006", "story_v_out_114101.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114101", "114101006", "story_v_out_114101.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114101007
		arg_29_1.duration_ = 3.4

		local var_29_0 = {
			ja = 3.4,
			ko = 3.133,
			zh = 3.2,
			en = 3
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
				arg_29_0:Play114101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_32_0 = arg_29_1.actors_["1068ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1068ui_story == nil then
				arg_29_1.var_.characterEffect1068ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_1 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 and not isNil(var_32_0) then
				if arg_29_1.var_.characterEffect1068ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1068ui_story then
				arg_29_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_32_3 = 0
			local var_32_4 = 0.3

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:GetWordFromCfg(114101007)
				local var_32_6 = arg_29_1:FormatText(var_32_5.content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 12 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_6) / 12)

				if (12 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_6) / 12)) > 0 and var_32_4 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101007", "story_v_out_114101.awb") ~= 0 then
					local var_32_9 = manager.audio:GetVoiceLength("story_v_out_114101", "114101007", "story_v_out_114101.awb") / 1000

					if var_32_9 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_3
					end

					if var_32_5.prefab_name ~= "" and arg_29_1.actors_[var_32_5.prefab_name] ~= nil then
						local var_32_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_5.prefab_name].transform, "story_v_out_114101", "114101007", "story_v_out_114101.awb")

						arg_29_1:RecordAudio("114101007", var_32_10)
						arg_29_1:RecordAudio("114101007", var_32_10)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114101", "114101007", "story_v_out_114101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114101", "114101007", "story_v_out_114101.awb")
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
	Play114101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114101008
		arg_33_1.duration_ = 6.97

		local var_33_0 = {
			ja = 5.933,
			ko = 6.966,
			zh = 6.8,
			en = 6.066
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
				arg_33_0:Play114101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_1")
			end

			local var_36_0 = 0
			local var_36_1 = 0.925

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(114101008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 37 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 37)

				if (37 <= 0 and var_36_1 or var_36_1 * (utf8.len(var_36_3) / 37)) > 0 and var_36_1 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101008", "story_v_out_114101.awb") ~= 0 then
					local var_36_6 = manager.audio:GetVoiceLength("story_v_out_114101", "114101008", "story_v_out_114101.awb") / 1000

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end

					if var_36_2.prefab_name ~= "" and arg_33_1.actors_[var_36_2.prefab_name] ~= nil then
						local var_36_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_2.prefab_name].transform, "story_v_out_114101", "114101008", "story_v_out_114101.awb")

						arg_33_1:RecordAudio("114101008", var_36_7)
						arg_33_1:RecordAudio("114101008", var_36_7)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114101", "114101008", "story_v_out_114101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114101", "114101008", "story_v_out_114101.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114101009
		arg_37_1.duration_ = 6.1

		local var_37_0 = {
			ja = 6.1,
			ko = 5.933,
			zh = 3.9,
			en = 3.4
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
				arg_37_0:Play114101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1068ui_story"]) and arg_37_1.var_.characterEffect1068ui_story == nil then
				arg_37_1.var_.characterEffect1068ui_story = arg_37_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1068ui_story"]) then
				if arg_37_1.var_.characterEffect1068ui_story and not isNil(arg_37_1.actors_["1068ui_story"]) then
					arg_37_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1068ui_story"]) and arg_37_1.var_.characterEffect1068ui_story then
				arg_37_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.45

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(114101009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 18 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 18)

				if (18 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 18)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101009", "story_v_out_114101.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_114101", "114101009", "story_v_out_114101.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_114101", "114101009", "story_v_out_114101.awb")

						arg_37_1:RecordAudio("114101009", var_40_8)
						arg_37_1:RecordAudio("114101009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114101", "114101009", "story_v_out_114101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114101", "114101009", "story_v_out_114101.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114101010
		arg_41_1.duration_ = 2.53

		local var_41_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.533,
			en = 1.999999999999
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
				arg_41_0:Play114101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_44_0 = arg_41_1.actors_["1068ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1068ui_story == nil then
				arg_41_1.var_.characterEffect1068ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_1 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 and not isNil(var_44_0) then
				if arg_41_1.var_.characterEffect1068ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1068ui_story then
				arg_41_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_44_3 = 0
			local var_44_4 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:GetWordFromCfg(114101010)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_8 = 5 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 5)

				if (5 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_6) / 5)) > 0 and var_44_4 < var_44_8 then
					arg_41_1.talkMaxDuration = var_44_8

					if var_44_8 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101010", "story_v_out_114101.awb") ~= 0 then
					local var_44_9 = manager.audio:GetVoiceLength("story_v_out_114101", "114101010", "story_v_out_114101.awb") / 1000

					if var_44_9 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_3
					end

					if var_44_5.prefab_name ~= "" and arg_41_1.actors_[var_44_5.prefab_name] ~= nil then
						local var_44_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_5.prefab_name].transform, "story_v_out_114101", "114101010", "story_v_out_114101.awb")

						arg_41_1:RecordAudio("114101010", var_44_10)
						arg_41_1:RecordAudio("114101010", var_44_10)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114101", "114101010", "story_v_out_114101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114101", "114101010", "story_v_out_114101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_11 and arg_41_1.time_ < var_44_3 + var_44_11 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play114101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114101011
		arg_45_1.duration_ = 13.07

		local var_45_0 = {
			ja = 10.933,
			ko = 13.066,
			zh = 10.133,
			en = 11.533
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
				arg_45_0:Play114101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1068ui_story"]) and arg_45_1.var_.characterEffect1068ui_story == nil then
				arg_45_1.var_.characterEffect1068ui_story = arg_45_1.actors_["1068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1068ui_story"]) then
				if arg_45_1.var_.characterEffect1068ui_story and not isNil(arg_45_1.actors_["1068ui_story"]) then
					arg_45_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1068ui_story"]) and arg_45_1.var_.characterEffect1068ui_story then
				arg_45_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 1.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(114101011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 54 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 54)

				if (54 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_4) / 54)) > 0 and var_48_2 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101011", "story_v_out_114101.awb") ~= 0 then
					local var_48_7 = manager.audio:GetVoiceLength("story_v_out_114101", "114101011", "story_v_out_114101.awb") / 1000

					if var_48_7 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_1
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_114101", "114101011", "story_v_out_114101.awb")

						arg_45_1:RecordAudio("114101011", var_48_8)
						arg_45_1:RecordAudio("114101011", var_48_8)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114101", "114101011", "story_v_out_114101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114101", "114101011", "story_v_out_114101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_9 and arg_45_1.time_ < var_48_1 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114101012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play114101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1068ui_story = arg_49_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1068ui_story"].transform.position).z)
				arg_49_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1068ui_story"].transform.localEulerAngles = arg_49_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1068ui_story"].transform.position).z)
				arg_49_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1068ui_story"].transform.localEulerAngles = arg_49_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_52_1 = 0
			local var_52_2 = 1.05

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

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(114101012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 42 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 42)

				if (42 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 42)) > 0 and var_52_2 < var_52_5 then
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

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play114101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114101013
		arg_53_1.duration_ = 11.9

		local var_53_0 = {
			ja = 11.9,
			ko = 2.866,
			zh = 3.133,
			en = 2.7
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
				arg_53_0:Play114101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1068ui_story = arg_53_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1068ui_story"].transform.position).z)
				arg_53_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1068ui_story"].transform.localEulerAngles = arg_53_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_53_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1068ui_story"].transform.position).z)
				arg_53_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1068ui_story"].transform.localEulerAngles = arg_53_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_56_1 = arg_53_1.actors_["1068ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1068ui_story == nil then
				arg_53_1.var_.characterEffect1068ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1068ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1068ui_story then
				arg_53_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_56_4 = 0
			local var_56_5 = 0.425

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(114101013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 17 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 17)

				if (17 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 17)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101013", "story_v_out_114101.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101013", "story_v_out_114101.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_114101", "114101013", "story_v_out_114101.awb")

						arg_53_1:RecordAudio("114101013", var_56_11)
						arg_53_1:RecordAudio("114101013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114101", "114101013", "story_v_out_114101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114101", "114101013", "story_v_out_114101.awb")
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

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play114101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114101014
		arg_57_1.duration_ = 9.53

		local var_57_0 = {
			ja = 9.533,
			ko = 6.4,
			zh = 6.933,
			en = 6.8
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
				arg_57_0:Play114101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_0 = 0
			local var_60_1 = 0.7

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(114101014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 28 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 28)

				if (28 <= 0 and var_60_1 or var_60_1 * (utf8.len(var_60_3) / 28)) > 0 and var_60_1 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101014", "story_v_out_114101.awb") ~= 0 then
					local var_60_6 = manager.audio:GetVoiceLength("story_v_out_114101", "114101014", "story_v_out_114101.awb") / 1000

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end

					if var_60_2.prefab_name ~= "" and arg_57_1.actors_[var_60_2.prefab_name] ~= nil then
						local var_60_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_2.prefab_name].transform, "story_v_out_114101", "114101014", "story_v_out_114101.awb")

						arg_57_1:RecordAudio("114101014", var_60_7)
						arg_57_1:RecordAudio("114101014", var_60_7)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114101", "114101014", "story_v_out_114101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114101", "114101014", "story_v_out_114101.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_8 and arg_57_1.time_ < var_60_0 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114101015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1068ui_story = arg_61_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1068ui_story"].transform.position).z)
				arg_61_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1068ui_story"].transform.localEulerAngles = arg_61_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1068ui_story"].transform.position).z)
				arg_61_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1068ui_story"].transform.localEulerAngles = arg_61_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_64_1 = 0
			local var_64_2 = 1.525

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(114101015).content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 61 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 61)

				if (61 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_3) / 61)) > 0 and var_64_2 < var_64_5 then
					arg_61_1.talkMaxDuration = var_64_5

					if var_64_5 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_6 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_6 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_6

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_6 and arg_61_1.time_ < var_64_1 + var_64_6 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play114101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114101016
		arg_65_1.duration_ = 7.13

		local var_65_0 = {
			ja = 7.133,
			ko = 5.833,
			zh = 5.666,
			en = 5.866
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
				arg_65_0:Play114101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1068ui_story = arg_65_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1068ui_story"].transform.position).z)
				arg_65_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1068ui_story"].transform.localEulerAngles = arg_65_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_65_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1068ui_story"].transform.position).z)
				arg_65_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1068ui_story"].transform.localEulerAngles = arg_65_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_68_1 = arg_65_1.actors_["1068ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1068ui_story == nil then
				arg_65_1.var_.characterEffect1068ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1068ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1068ui_story then
				arg_65_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_68_4 = 0
			local var_68_5 = 0.75

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(114101016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 30 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 30)

				if (30 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 30)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101016", "story_v_out_114101.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101016", "story_v_out_114101.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_114101", "114101016", "story_v_out_114101.awb")

						arg_65_1:RecordAudio("114101016", var_68_11)
						arg_65_1:RecordAudio("114101016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114101", "114101016", "story_v_out_114101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114101", "114101016", "story_v_out_114101.awb")
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
				actorName = "1068ui_story",
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
	Play114101017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114101017
		arg_69_1.duration_ = 9.93

		local var_69_0 = {
			ja = 9.933,
			ko = 7.166,
			zh = 9.3,
			en = 6.9
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
				arg_69_0:Play114101018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1068ui_story = arg_69_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1068ui_story"].transform.position).z)
				arg_69_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1068ui_story"].transform.localEulerAngles = arg_69_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1068ui_story"].transform.position).z)
				arg_69_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1068ui_story"].transform.localEulerAngles = arg_69_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_72_1 = "6045_story"

			if arg_69_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_72_2 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_69_1.stage_.transform)

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

			local var_72_5 = arg_69_1.actors_["6045_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos6045_story = var_72_5.localPosition

				local var_72_6 = GameObjectTools.GetOrAddComponent(var_72_5.gameObject, typeof(DynamicBoneHelper))

				if var_72_6 then
					var_72_6:EnableDynamicBone(false)
				end
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_69_1.time_ - 0) / var_72_7)
				var_72_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_5.position).x, (manager.ui.mainCamera.transform.position - var_72_5.position).y, (manager.ui.mainCamera.transform.position - var_72_5.position).z)
				var_72_5.localEulerAngles.z = 0
				var_72_5.localEulerAngles.x = 0
				var_72_5.localEulerAngles = var_72_5.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_72_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_5.position).x, (manager.ui.mainCamera.transform.position - var_72_5.position).y, (manager.ui.mainCamera.transform.position - var_72_5.position).z)
				var_72_5.localEulerAngles.z = 0
				var_72_5.localEulerAngles.x = 0
				var_72_5.localEulerAngles = var_72_5.localEulerAngles

				local var_72_8 = GameObjectTools.GetOrAddComponent(var_72_5.gameObject, typeof(DynamicBoneHelper))

				if var_72_8 then
					var_72_8:EnableDynamicBone(true)
				end
			end

			local var_72_9 = "6046_story"

			if arg_69_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_72_10 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_69_1.stage_.transform)

				var_72_10.name = var_72_9
				var_72_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_[var_72_9] = var_72_10

				local var_72_11 = var_72_10:GetComponentInChildren(typeof(CharacterEffect))

				var_72_11.enabled = true

				local var_72_12 = GameObjectTools.GetOrAddComponent(var_72_10, typeof(DynamicBoneHelper))

				if var_72_12 then
					var_72_12:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_11.transform, false)

				arg_69_1.var_[var_72_9 .. "Animator"] = var_72_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_[var_72_9 .. "Animator"].applyRootMotion = true
				arg_69_1.var_[var_72_9 .. "LipSync"] = var_72_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_13 = arg_69_1.actors_["6046_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos6046_story = var_72_13.localPosition

				local var_72_14 = GameObjectTools.GetOrAddComponent(var_72_13.gameObject, typeof(DynamicBoneHelper))

				if var_72_14 then
					var_72_14:EnableDynamicBone(false)
				end
			end

			local var_72_15 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_15 then
				var_72_13.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_69_1.time_ - 0) / var_72_15)
				var_72_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_13.position).x, (manager.ui.mainCamera.transform.position - var_72_13.position).y, (manager.ui.mainCamera.transform.position - var_72_13.position).z)
				var_72_13.localEulerAngles.z = 0
				var_72_13.localEulerAngles.x = 0
				var_72_13.localEulerAngles = var_72_13.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_15 and arg_69_1.time_ < 0 + var_72_15 + arg_72_0 then
				var_72_13.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_72_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_13.position).x, (manager.ui.mainCamera.transform.position - var_72_13.position).y, (manager.ui.mainCamera.transform.position - var_72_13.position).z)
				var_72_13.localEulerAngles.z = 0
				var_72_13.localEulerAngles.x = 0
				var_72_13.localEulerAngles = var_72_13.localEulerAngles

				local var_72_16 = GameObjectTools.GetOrAddComponent(var_72_13.gameObject, typeof(DynamicBoneHelper))

				if var_72_16 then
					var_72_16:EnableDynamicBone(true)
				end
			end

			local var_72_17 = arg_69_1.actors_["6045_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_17) and arg_69_1.var_.characterEffect6045_story == nil then
				arg_69_1.var_.characterEffect6045_story = var_72_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_18 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_18 and not isNil(var_72_17) then
				if arg_69_1.var_.characterEffect6045_story and not isNil(var_72_17) then
					arg_69_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_18 and arg_69_1.time_ < 0 + var_72_18 + arg_72_0 and not isNil(var_72_17) and arg_69_1.var_.characterEffect6045_story then
				arg_69_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_1")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_1")
			end

			local var_72_20 = 0
			local var_72_21 = 0.85

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_22 = arg_69_1:GetWordFromCfg(114101017)
				local var_72_23 = arg_69_1:FormatText(var_72_22.content)

				arg_69_1.text_.text = var_72_23

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_25 = 34 <= 0 and var_72_21 or var_72_21 * (utf8.len(var_72_23) / 34)

				if (34 <= 0 and var_72_21 or var_72_21 * (utf8.len(var_72_23) / 34)) > 0 and var_72_21 < var_72_25 then
					arg_69_1.talkMaxDuration = var_72_25

					if var_72_25 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_25 + var_72_20
					end
				end

				arg_69_1.text_.text = var_72_23
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101017", "story_v_out_114101.awb") ~= 0 then
					local var_72_26 = manager.audio:GetVoiceLength("story_v_out_114101", "114101017", "story_v_out_114101.awb") / 1000

					if var_72_26 + var_72_20 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_26 + var_72_20
					end

					if var_72_22.prefab_name ~= "" and arg_69_1.actors_[var_72_22.prefab_name] ~= nil then
						local var_72_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_22.prefab_name].transform, "story_v_out_114101", "114101017", "story_v_out_114101.awb")

						arg_69_1:RecordAudio("114101017", var_72_27)
						arg_69_1:RecordAudio("114101017", var_72_27)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114101", "114101017", "story_v_out_114101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114101", "114101017", "story_v_out_114101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_28 = math.max(var_72_21, arg_69_1.talkMaxDuration)

			if var_72_20 <= arg_69_1.time_ and arg_69_1.time_ < var_72_20 + var_72_28 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_20) / var_72_28

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_20 + var_72_28 and arg_69_1.time_ < var_72_20 + var_72_28 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play114101018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114101018
		arg_73_1.duration_ = 7.73

		local var_73_0 = {
			ja = 7.733,
			ko = 6.433,
			zh = 6.6,
			en = 6.1
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
				arg_73_0:Play114101019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action432")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_76_0 = arg_73_1.actors_["6046_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect6046_story == nil then
				arg_73_1.var_.characterEffect6046_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_1 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 and not isNil(var_76_0) then
				if arg_73_1.var_.characterEffect6046_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect6046_story then
				arg_73_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_76_3 = arg_73_1.actors_["6045_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect6045_story == nil then
				arg_73_1.var_.characterEffect6045_story = var_76_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 and not isNil(var_76_3) then
				if arg_73_1.var_.characterEffect6045_story and not isNil(var_76_3) then
					arg_73_1.var_.characterEffect6045_story.fillFlat = true
					arg_73_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_4)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 and not isNil(var_76_3) and arg_73_1.var_.characterEffect6045_story then
				arg_73_1.var_.characterEffect6045_story.fillFlat = true
				arg_73_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_76_5 = 0
			local var_76_6 = 0.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(114101018)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 23 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 23)

				if (23 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 23)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101018", "story_v_out_114101.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_114101", "114101018", "story_v_out_114101.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_114101", "114101018", "story_v_out_114101.awb")

						arg_73_1:RecordAudio("114101018", var_76_12)
						arg_73_1:RecordAudio("114101018", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114101", "114101018", "story_v_out_114101.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114101", "114101018", "story_v_out_114101.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_13 and arg_73_1.time_ < var_76_5 + var_76_13 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114101019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114101019
		arg_77_1.duration_ = 5.87

		local var_77_0 = {
			ja = 5.666,
			ko = 5.166,
			zh = 5.866,
			en = 5.066
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
				arg_77_0:Play114101020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_80_0 = arg_77_1.actors_["6046_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect6046_story == nil then
				arg_77_1.var_.characterEffect6046_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_1 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 and not isNil(var_80_0) then
				if arg_77_1.var_.characterEffect6046_story and not isNil(var_80_0) then
					arg_77_1.var_.characterEffect6046_story.fillFlat = true
					arg_77_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_1)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect6046_story then
				arg_77_1.var_.characterEffect6046_story.fillFlat = true
				arg_77_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_80_2 = arg_77_1.actors_["6045_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect6045_story == nil then
				arg_77_1.var_.characterEffect6045_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect6045_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect6045_story then
				arg_77_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_80_5 = 0
			local var_80_6 = 0.475

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(114101019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 19 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 19)

				if (19 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 19)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101019", "story_v_out_114101.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_114101", "114101019", "story_v_out_114101.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_114101", "114101019", "story_v_out_114101.awb")

						arg_77_1:RecordAudio("114101019", var_80_12)
						arg_77_1:RecordAudio("114101019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114101", "114101019", "story_v_out_114101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114101", "114101019", "story_v_out_114101.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_13 = math.max(var_80_6, arg_77_1.talkMaxDuration)

			if var_80_5 <= arg_77_1.time_ and arg_77_1.time_ < var_80_5 + var_80_13 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_5) / var_80_13

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_5 + var_80_13 and arg_77_1.time_ < var_80_5 + var_80_13 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114101020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114101020
		arg_81_1.duration_ = 6.6

		local var_81_0 = {
			ja = 6.6,
			ko = 4.066,
			zh = 4.066,
			en = 4.6
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
				arg_81_0:Play114101021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1068ui_story = arg_81_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1068ui_story"].transform.position).z)
				arg_81_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1068ui_story"].transform.localEulerAngles = arg_81_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_81_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1068ui_story"].transform.position).z)
				arg_81_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1068ui_story"].transform.localEulerAngles = arg_81_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_84_1 = arg_81_1.actors_["1068ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1068ui_story == nil then
				arg_81_1.var_.characterEffect1068ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1068ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1068ui_story then
				arg_81_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["6046_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos6046_story = var_84_4.localPosition

				local var_84_5 = GameObjectTools.GetOrAddComponent(var_84_4.gameObject, typeof(DynamicBoneHelper))

				if var_84_5 then
					var_84_5:EnableDynamicBone(false)
				end
			end

			local var_84_6 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 then
				var_84_4.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_6)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 then
				var_84_4.localPosition = Vector3.New(0, 100, 0)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles

				local var_84_7 = GameObjectTools.GetOrAddComponent(var_84_4.gameObject, typeof(DynamicBoneHelper))

				if var_84_7 then
					var_84_7:EnableDynamicBone(true)
				end
			end

			local var_84_8 = arg_81_1.actors_["6045_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos6045_story = var_84_8.localPosition

				local var_84_9 = GameObjectTools.GetOrAddComponent(var_84_8.gameObject, typeof(DynamicBoneHelper))

				if var_84_9 then
					var_84_9:EnableDynamicBone(false)
				end
			end

			local var_84_10 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_10 then
				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_10)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_10 and arg_81_1.time_ < 0 + var_84_10 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(0, 100, 0)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles

				local var_84_11 = GameObjectTools.GetOrAddComponent(var_84_8.gameObject, typeof(DynamicBoneHelper))

				if var_84_11 then
					var_84_11:EnableDynamicBone(true)
				end
			end

			local var_84_12 = 0
			local var_84_13 = 0.275

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:GetWordFromCfg(114101020)
				local var_84_15 = arg_81_1:FormatText(var_84_14.content)

				arg_81_1.text_.text = var_84_15

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_17 = 11 <= 0 and var_84_13 or var_84_13 * (utf8.len(var_84_15) / 11)

				if (11 <= 0 and var_84_13 or var_84_13 * (utf8.len(var_84_15) / 11)) > 0 and var_84_13 < var_84_17 then
					arg_81_1.talkMaxDuration = var_84_17

					if var_84_17 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_12
					end
				end

				arg_81_1.text_.text = var_84_15
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101020", "story_v_out_114101.awb") ~= 0 then
					local var_84_18 = manager.audio:GetVoiceLength("story_v_out_114101", "114101020", "story_v_out_114101.awb") / 1000

					if var_84_18 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_12
					end

					if var_84_14.prefab_name ~= "" and arg_81_1.actors_[var_84_14.prefab_name] ~= nil then
						local var_84_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_14.prefab_name].transform, "story_v_out_114101", "114101020", "story_v_out_114101.awb")

						arg_81_1:RecordAudio("114101020", var_84_19)
						arg_81_1:RecordAudio("114101020", var_84_19)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114101", "114101020", "story_v_out_114101.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114101", "114101020", "story_v_out_114101.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_20 = math.max(var_84_13, arg_81_1.talkMaxDuration)

			if var_84_12 <= arg_81_1.time_ and arg_81_1.time_ < var_84_12 + var_84_20 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_12) / var_84_20

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_12 + var_84_20 and arg_81_1.time_ < var_84_12 + var_84_20 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play114101021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114101021
		arg_85_1.duration_ = 5.03

		local var_85_0 = {
			ja = 3.5,
			ko = 3.966,
			zh = 5.033,
			en = 4.266
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
				arg_85_0:Play114101022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_88_0 = 0
			local var_88_1 = 0.6

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:GetWordFromCfg(114101021)
				local var_88_3 = arg_85_1:FormatText(var_88_2.content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 24 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 24)

				if (24 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_3) / 24)) > 0 and var_88_1 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101021", "story_v_out_114101.awb") ~= 0 then
					local var_88_6 = manager.audio:GetVoiceLength("story_v_out_114101", "114101021", "story_v_out_114101.awb") / 1000

					if var_88_6 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_0
					end

					if var_88_2.prefab_name ~= "" and arg_85_1.actors_[var_88_2.prefab_name] ~= nil then
						local var_88_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_2.prefab_name].transform, "story_v_out_114101", "114101021", "story_v_out_114101.awb")

						arg_85_1:RecordAudio("114101021", var_88_7)
						arg_85_1:RecordAudio("114101021", var_88_7)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114101", "114101021", "story_v_out_114101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114101", "114101021", "story_v_out_114101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114101022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114101022
		arg_89_1.duration_ = 5

		local var_89_0 = {
			ja = 4.333,
			ko = 4.8,
			zh = 5,
			en = 3.3
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
				arg_89_0:Play114101023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1068ui_story = arg_89_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1068ui_story"].transform.position).z)
				arg_89_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1068ui_story"].transform.localEulerAngles = arg_89_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1068ui_story"].transform.position).z)
				arg_89_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1068ui_story"].transform.localEulerAngles = arg_89_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["6045_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos6045_story = var_92_1.localPosition

				local var_92_2 = GameObjectTools.GetOrAddComponent(var_92_1.gameObject, typeof(DynamicBoneHelper))

				if var_92_2 then
					var_92_2:EnableDynamicBone(false)
				end
			end

			local var_92_3 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_89_1.time_ - 0) / var_92_3)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles

				local var_92_4 = GameObjectTools.GetOrAddComponent(var_92_1.gameObject, typeof(DynamicBoneHelper))

				if var_92_4 then
					var_92_4:EnableDynamicBone(true)
				end
			end

			local var_92_5 = arg_89_1.actors_["6046_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos6046_story = var_92_5.localPosition

				local var_92_6 = GameObjectTools.GetOrAddComponent(var_92_5.gameObject, typeof(DynamicBoneHelper))

				if var_92_6 then
					var_92_6:EnableDynamicBone(false)
				end
			end

			local var_92_7 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				var_92_5.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_89_1.time_ - 0) / var_92_7)
				var_92_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_5.position).x, (manager.ui.mainCamera.transform.position - var_92_5.position).y, (manager.ui.mainCamera.transform.position - var_92_5.position).z)
				var_92_5.localEulerAngles.z = 0
				var_92_5.localEulerAngles.x = 0
				var_92_5.localEulerAngles = var_92_5.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				var_92_5.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_92_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_5.position).x, (manager.ui.mainCamera.transform.position - var_92_5.position).y, (manager.ui.mainCamera.transform.position - var_92_5.position).z)
				var_92_5.localEulerAngles.z = 0
				var_92_5.localEulerAngles.x = 0
				var_92_5.localEulerAngles = var_92_5.localEulerAngles

				local var_92_8 = GameObjectTools.GetOrAddComponent(var_92_5.gameObject, typeof(DynamicBoneHelper))

				if var_92_8 then
					var_92_8:EnableDynamicBone(true)
				end
			end

			local var_92_9 = arg_89_1.actors_["6045_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect6045_story == nil then
				arg_89_1.var_.characterEffect6045_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_10 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_10 and not isNil(var_92_9) then
				if arg_89_1.var_.characterEffect6045_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_10 and arg_89_1.time_ < 0 + var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect6045_story then
				arg_89_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_92_12 = 0
			local var_92_13 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_14 = arg_89_1:GetWordFromCfg(114101022)
				local var_92_15 = arg_89_1:FormatText(var_92_14.content)

				arg_89_1.text_.text = var_92_15

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 18 <= 0 and var_92_13 or var_92_13 * (utf8.len(var_92_15) / 18)

				if (18 <= 0 and var_92_13 or var_92_13 * (utf8.len(var_92_15) / 18)) > 0 and var_92_13 < var_92_17 then
					arg_89_1.talkMaxDuration = var_92_17

					if var_92_17 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_12
					end
				end

				arg_89_1.text_.text = var_92_15
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101022", "story_v_out_114101.awb") ~= 0 then
					local var_92_18 = manager.audio:GetVoiceLength("story_v_out_114101", "114101022", "story_v_out_114101.awb") / 1000

					if var_92_18 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_18 + var_92_12
					end

					if var_92_14.prefab_name ~= "" and arg_89_1.actors_[var_92_14.prefab_name] ~= nil then
						local var_92_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_14.prefab_name].transform, "story_v_out_114101", "114101022", "story_v_out_114101.awb")

						arg_89_1:RecordAudio("114101022", var_92_19)
						arg_89_1:RecordAudio("114101022", var_92_19)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_114101", "114101022", "story_v_out_114101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_114101", "114101022", "story_v_out_114101.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_20 = math.max(var_92_13, arg_89_1.talkMaxDuration)

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_20 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_12) / var_92_20

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_12 + var_92_20 and arg_89_1.time_ < var_92_12 + var_92_20 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play114101023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114101023
		arg_93_1.duration_ = 5.73

		local var_93_0 = {
			ja = 5.733,
			ko = 2.966,
			zh = 4.1,
			en = 3.2
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
				arg_93_0:Play114101024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["6045_story"]) and arg_93_1.var_.characterEffect6045_story == nil then
				arg_93_1.var_.characterEffect6045_story = arg_93_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["6045_story"]) then
				if arg_93_1.var_.characterEffect6045_story and not isNil(arg_93_1.actors_["6045_story"]) then
					arg_93_1.var_.characterEffect6045_story.fillFlat = true
					arg_93_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["6045_story"]) and arg_93_1.var_.characterEffect6045_story then
				arg_93_1.var_.characterEffect6045_story.fillFlat = true
				arg_93_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_96_1 = arg_93_1.actors_["6046_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect6046_story == nil then
				arg_93_1.var_.characterEffect6046_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect6046_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect6046_story then
				arg_93_1.var_.characterEffect6046_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_96_4 = 0
			local var_96_5 = 0.35

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(114101023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 14 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 14)

				if (14 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 14)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101023", "story_v_out_114101.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101023", "story_v_out_114101.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_114101", "114101023", "story_v_out_114101.awb")

						arg_93_1:RecordAudio("114101023", var_96_11)
						arg_93_1:RecordAudio("114101023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_114101", "114101023", "story_v_out_114101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_114101", "114101023", "story_v_out_114101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114101024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114101024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114101025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos6045_story = arg_97_1.actors_["6045_story"].transform.localPosition

				local var_100_0 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_0 then
					var_100_0:EnableDynamicBone(false)
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_1)
				arg_97_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["6045_story"].transform.position).z)
				arg_97_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["6045_story"].transform.localEulerAngles = arg_97_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["6045_story"].transform.position).z)
				arg_97_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["6045_story"].transform.localEulerAngles = arg_97_1.actors_["6045_story"].transform.localEulerAngles

				local var_100_2 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(true)
				end
			end

			local var_100_3 = arg_97_1.actors_["6046_story"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos6046_story = var_100_3.localPosition

				local var_100_4 = GameObjectTools.GetOrAddComponent(var_100_3.gameObject, typeof(DynamicBoneHelper))

				if var_100_4 then
					var_100_4:EnableDynamicBone(false)
				end
			end

			local var_100_5 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 then
				var_100_3.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_5)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 then
				var_100_3.localPosition = Vector3.New(0, 100, 0)
				var_100_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_100_3.position).x, (manager.ui.mainCamera.transform.position - var_100_3.position).y, (manager.ui.mainCamera.transform.position - var_100_3.position).z)
				var_100_3.localEulerAngles.z = 0
				var_100_3.localEulerAngles.x = 0
				var_100_3.localEulerAngles = var_100_3.localEulerAngles

				local var_100_6 = GameObjectTools.GetOrAddComponent(var_100_3.gameObject, typeof(DynamicBoneHelper))

				if var_100_6 then
					var_100_6:EnableDynamicBone(true)
				end
			end

			local var_100_7 = 0
			local var_100_8 = 1.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_7 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_9 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(114101024).content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 45 <= 0 and var_100_8 or var_100_8 * (utf8.len(var_100_9) / 45)

				if (45 <= 0 and var_100_8 or var_100_8 * (utf8.len(var_100_9) / 45)) > 0 and var_100_8 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_7 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_7
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_8, arg_97_1.talkMaxDuration)

			if var_100_7 <= arg_97_1.time_ and arg_97_1.time_ < var_100_7 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_7) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_7 + var_100_12 and arg_97_1.time_ < var_100_7 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play114101025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114101025
		arg_101_1.duration_ = 5.5

		local var_101_0 = {
			ja = 5.5,
			ko = 3.733,
			zh = 3.9,
			en = 2.866
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
				arg_101_0:Play114101026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1068ui_story = arg_101_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1068ui_story"].transform.position).z)
				arg_101_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1068ui_story"].transform.localEulerAngles = arg_101_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_101_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1068ui_story"].transform.position).z)
				arg_101_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1068ui_story"].transform.localEulerAngles = arg_101_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_104_1 = arg_101_1.actors_["1068ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1068ui_story == nil then
				arg_101_1.var_.characterEffect1068ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1068ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1068ui_story then
				arg_101_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_104_4 = 0
			local var_104_5 = 0.45

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(114101025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 18 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 18)

				if (18 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 18)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101025", "story_v_out_114101.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101025", "story_v_out_114101.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_114101", "114101025", "story_v_out_114101.awb")

						arg_101_1:RecordAudio("114101025", var_104_11)
						arg_101_1:RecordAudio("114101025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114101", "114101025", "story_v_out_114101.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114101", "114101025", "story_v_out_114101.awb")
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
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play114101026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114101026
		arg_105_1.duration_ = 3.57

		local var_105_0 = {
			ja = 3,
			ko = 2.733,
			zh = 3.566,
			en = 2.266
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
				arg_105_0:Play114101027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_108_0 = 0
			local var_108_1 = 0.275

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(114101026)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 11 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 11)

				if (11 <= 0 and var_108_1 or var_108_1 * (utf8.len(var_108_3) / 11)) > 0 and var_108_1 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101026", "story_v_out_114101.awb") ~= 0 then
					local var_108_6 = manager.audio:GetVoiceLength("story_v_out_114101", "114101026", "story_v_out_114101.awb") / 1000

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end

					if var_108_2.prefab_name ~= "" and arg_105_1.actors_[var_108_2.prefab_name] ~= nil then
						local var_108_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_2.prefab_name].transform, "story_v_out_114101", "114101026", "story_v_out_114101.awb")

						arg_105_1:RecordAudio("114101026", var_108_7)
						arg_105_1:RecordAudio("114101026", var_108_7)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114101", "114101026", "story_v_out_114101.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114101", "114101026", "story_v_out_114101.awb")
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
	Play114101027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114101027
		arg_109_1.duration_ = 8.9

		local var_109_0 = {
			ja = 8.9,
			ko = 5.533,
			zh = 6.733,
			en = 6.833
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
				arg_109_0:Play114101028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1068ui_story = arg_109_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1068ui_story"].transform.position).z)
				arg_109_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1068ui_story"].transform.localEulerAngles = arg_109_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1068ui_story"].transform.position).z)
				arg_109_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1068ui_story"].transform.localEulerAngles = arg_109_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["6046_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos6046_story = var_112_1.localPosition

				local var_112_2 = GameObjectTools.GetOrAddComponent(var_112_1.gameObject, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(false)
				end
			end

			local var_112_3 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 then
				var_112_1.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_109_1.time_ - 0) / var_112_3)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 then
				var_112_1.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles

				local var_112_4 = GameObjectTools.GetOrAddComponent(var_112_1.gameObject, typeof(DynamicBoneHelper))

				if var_112_4 then
					var_112_4:EnableDynamicBone(true)
				end
			end

			local var_112_5 = arg_109_1.actors_["6045_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect6045_story == nil then
				arg_109_1.var_.characterEffect6045_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect6045_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect6045_story then
				arg_109_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_112_8 = arg_109_1.actors_["6045_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos6045_story = var_112_8.localPosition

				local var_112_9 = GameObjectTools.GetOrAddComponent(var_112_8.gameObject, typeof(DynamicBoneHelper))

				if var_112_9 then
					var_112_9:EnableDynamicBone(false)
				end
			end

			local var_112_10 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_10 then
				var_112_8.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos6045_story, Vector3.New(-0.7, -0.5, -6.3), (arg_109_1.time_ - 0) / var_112_10)
				var_112_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_8.position).x, (manager.ui.mainCamera.transform.position - var_112_8.position).y, (manager.ui.mainCamera.transform.position - var_112_8.position).z)
				var_112_8.localEulerAngles.z = 0
				var_112_8.localEulerAngles.x = 0
				var_112_8.localEulerAngles = var_112_8.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_10 and arg_109_1.time_ < 0 + var_112_10 + arg_112_0 then
				var_112_8.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_112_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_8.position).x, (manager.ui.mainCamera.transform.position - var_112_8.position).y, (manager.ui.mainCamera.transform.position - var_112_8.position).z)
				var_112_8.localEulerAngles.z = 0
				var_112_8.localEulerAngles.x = 0
				var_112_8.localEulerAngles = var_112_8.localEulerAngles

				local var_112_11 = GameObjectTools.GetOrAddComponent(var_112_8.gameObject, typeof(DynamicBoneHelper))

				if var_112_11 then
					var_112_11:EnableDynamicBone(true)
				end
			end

			local var_112_12 = arg_109_1.actors_["6046_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_12) and arg_109_1.var_.characterEffect6046_story == nil then
				arg_109_1.var_.characterEffect6046_story = var_112_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_13 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_13 and not isNil(var_112_12) then
				if arg_109_1.var_.characterEffect6046_story and not isNil(var_112_12) then
					arg_109_1.var_.characterEffect6046_story.fillFlat = true
					arg_109_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_13)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_13 and arg_109_1.time_ < 0 + var_112_13 + arg_112_0 and not isNil(var_112_12) and arg_109_1.var_.characterEffect6046_story then
				arg_109_1.var_.characterEffect6046_story.fillFlat = true
				arg_109_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_112_14 = 0
			local var_112_15 = 0.6

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_16 = arg_109_1:GetWordFromCfg(114101027)
				local var_112_17 = arg_109_1:FormatText(var_112_16.content)

				arg_109_1.text_.text = var_112_17

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_19 = 24 <= 0 and var_112_15 or var_112_15 * (utf8.len(var_112_17) / 24)

				if (24 <= 0 and var_112_15 or var_112_15 * (utf8.len(var_112_17) / 24)) > 0 and var_112_15 < var_112_19 then
					arg_109_1.talkMaxDuration = var_112_19

					if var_112_19 + var_112_14 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_14
					end
				end

				arg_109_1.text_.text = var_112_17
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101027", "story_v_out_114101.awb") ~= 0 then
					local var_112_20 = manager.audio:GetVoiceLength("story_v_out_114101", "114101027", "story_v_out_114101.awb") / 1000

					if var_112_20 + var_112_14 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_20 + var_112_14
					end

					if var_112_16.prefab_name ~= "" and arg_109_1.actors_[var_112_16.prefab_name] ~= nil then
						local var_112_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_16.prefab_name].transform, "story_v_out_114101", "114101027", "story_v_out_114101.awb")

						arg_109_1:RecordAudio("114101027", var_112_21)
						arg_109_1:RecordAudio("114101027", var_112_21)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114101", "114101027", "story_v_out_114101.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114101", "114101027", "story_v_out_114101.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_22 = math.max(var_112_15, arg_109_1.talkMaxDuration)

			if var_112_14 <= arg_109_1.time_ and arg_109_1.time_ < var_112_14 + var_112_22 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_14) / var_112_22

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_14 + var_112_22 and arg_109_1.time_ < var_112_14 + var_112_22 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play114101028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114101028
		arg_113_1.duration_ = 3.87

		local var_113_0 = {
			ja = 3.866,
			ko = 2.9,
			zh = 3.033,
			en = 2.566
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
				arg_113_0:Play114101029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_116_0 = arg_113_1.actors_["6046_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect6046_story == nil then
				arg_113_1.var_.characterEffect6046_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_1 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 and not isNil(var_116_0) then
				if arg_113_1.var_.characterEffect6046_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect6046_story then
				arg_113_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_116_3 = arg_113_1.actors_["6045_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect6045_story == nil then
				arg_113_1.var_.characterEffect6045_story = var_116_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_4 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 and not isNil(var_116_3) then
				if arg_113_1.var_.characterEffect6045_story and not isNil(var_116_3) then
					arg_113_1.var_.characterEffect6045_story.fillFlat = true
					arg_113_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_4)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 and not isNil(var_116_3) and arg_113_1.var_.characterEffect6045_story then
				arg_113_1.var_.characterEffect6045_story.fillFlat = true
				arg_113_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_116_5 = 0
			local var_116_6 = 0.3

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(114101028)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 12 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 12)

				if (12 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 12)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101028", "story_v_out_114101.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_114101", "114101028", "story_v_out_114101.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_114101", "114101028", "story_v_out_114101.awb")

						arg_113_1:RecordAudio("114101028", var_116_12)
						arg_113_1:RecordAudio("114101028", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114101", "114101028", "story_v_out_114101.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114101", "114101028", "story_v_out_114101.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_13 and arg_113_1.time_ < var_116_5 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114101029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114101029
		arg_117_1.duration_ = 6.57

		local var_117_0 = {
			ja = 6.566,
			ko = 5.6,
			zh = 5.966,
			en = 5.2
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
				arg_117_0:Play114101030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["6045_story"]) and arg_117_1.var_.characterEffect6045_story == nil then
				arg_117_1.var_.characterEffect6045_story = arg_117_1.actors_["6045_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["6045_story"]) then
				if arg_117_1.var_.characterEffect6045_story and not isNil(arg_117_1.actors_["6045_story"]) then
					arg_117_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["6045_story"]) and arg_117_1.var_.characterEffect6045_story then
				arg_117_1.var_.characterEffect6045_story.fillFlat = false
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_120_2 = arg_117_1.actors_["6046_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect6046_story == nil then
				arg_117_1.var_.characterEffect6046_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect6046_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect6046_story.fillFlat = true
					arg_117_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_3)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect6046_story then
				arg_117_1.var_.characterEffect6046_story.fillFlat = true
				arg_117_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_120_4 = 0
			local var_120_5 = 0.525

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_6 = arg_117_1:GetWordFromCfg(114101029)
				local var_120_7 = arg_117_1:FormatText(var_120_6.content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 21 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 21)

				if (21 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 21)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101029", "story_v_out_114101.awb") ~= 0 then
					local var_120_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101029", "story_v_out_114101.awb") / 1000

					if var_120_10 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_4
					end

					if var_120_6.prefab_name ~= "" and arg_117_1.actors_[var_120_6.prefab_name] ~= nil then
						local var_120_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_6.prefab_name].transform, "story_v_out_114101", "114101029", "story_v_out_114101.awb")

						arg_117_1:RecordAudio("114101029", var_120_11)
						arg_117_1:RecordAudio("114101029", var_120_11)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114101", "114101029", "story_v_out_114101.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114101", "114101029", "story_v_out_114101.awb")
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
	Play114101030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114101030
		arg_121_1.duration_ = 8.37

		local var_121_0 = {
			ja = 8.366,
			ko = 5.966,
			zh = 6.3,
			en = 5.6
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
				arg_121_0:Play114101031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_124_0 = arg_121_1.actors_["6046_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect6046_story == nil then
				arg_121_1.var_.characterEffect6046_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_1 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 and not isNil(var_124_0) then
				if arg_121_1.var_.characterEffect6046_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect6046_story then
				arg_121_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_124_3 = arg_121_1.actors_["6045_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect6045_story == nil then
				arg_121_1.var_.characterEffect6045_story = var_124_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_4 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 and not isNil(var_124_3) then
				if arg_121_1.var_.characterEffect6045_story and not isNil(var_124_3) then
					arg_121_1.var_.characterEffect6045_story.fillFlat = true
					arg_121_1.var_.characterEffect6045_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_4)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 and not isNil(var_124_3) and arg_121_1.var_.characterEffect6045_story then
				arg_121_1.var_.characterEffect6045_story.fillFlat = true
				arg_121_1.var_.characterEffect6045_story.fillRatio = 0.5
			end

			local var_124_5 = 0
			local var_124_6 = 0.625

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:GetWordFromCfg(114101030)
				local var_124_8 = arg_121_1:FormatText(var_124_7.content)

				arg_121_1.text_.text = var_124_8

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 25 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 25)

				if (25 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_8) / 25)) > 0 and var_124_6 < var_124_10 then
					arg_121_1.talkMaxDuration = var_124_10

					if var_124_10 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_8
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101030", "story_v_out_114101.awb") ~= 0 then
					local var_124_11 = manager.audio:GetVoiceLength("story_v_out_114101", "114101030", "story_v_out_114101.awb") / 1000

					if var_124_11 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_5
					end

					if var_124_7.prefab_name ~= "" and arg_121_1.actors_[var_124_7.prefab_name] ~= nil then
						local var_124_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_7.prefab_name].transform, "story_v_out_114101", "114101030", "story_v_out_114101.awb")

						arg_121_1:RecordAudio("114101030", var_124_12)
						arg_121_1:RecordAudio("114101030", var_124_12)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114101", "114101030", "story_v_out_114101.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114101", "114101030", "story_v_out_114101.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_13 and arg_121_1.time_ < var_124_5 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play114101031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114101031
		arg_125_1.duration_ = 5.23

		local var_125_0 = {
			ja = 4.166,
			ko = 4.033,
			zh = 5.233,
			en = 4.166
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
				arg_125_0:Play114101032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_128_0 = arg_125_1.actors_["6046_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect6046_story == nil then
				arg_125_1.var_.characterEffect6046_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_1 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 and not isNil(var_128_0) then
				if arg_125_1.var_.characterEffect6046_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect6046_story.fillFlat = true
					arg_125_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_1)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect6046_story then
				arg_125_1.var_.characterEffect6046_story.fillFlat = true
				arg_125_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_128_2 = arg_125_1.actors_["6045_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect6045_story == nil then
				arg_125_1.var_.characterEffect6045_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect6045_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect6045_story then
				arg_125_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_128_5 = 0
			local var_128_6 = 0.4

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_7 = arg_125_1:GetWordFromCfg(114101031)
				local var_128_8 = arg_125_1:FormatText(var_128_7.content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 16 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 16)

				if (16 <= 0 and var_128_6 or var_128_6 * (utf8.len(var_128_8) / 16)) > 0 and var_128_6 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_5
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101031", "story_v_out_114101.awb") ~= 0 then
					local var_128_11 = manager.audio:GetVoiceLength("story_v_out_114101", "114101031", "story_v_out_114101.awb") / 1000

					if var_128_11 + var_128_5 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_5
					end

					if var_128_7.prefab_name ~= "" and arg_125_1.actors_[var_128_7.prefab_name] ~= nil then
						local var_128_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_7.prefab_name].transform, "story_v_out_114101", "114101031", "story_v_out_114101.awb")

						arg_125_1:RecordAudio("114101031", var_128_12)
						arg_125_1:RecordAudio("114101031", var_128_12)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_114101", "114101031", "story_v_out_114101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_114101", "114101031", "story_v_out_114101.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_13 = math.max(var_128_6, arg_125_1.talkMaxDuration)

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_13 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_5) / var_128_13

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_5 + var_128_13 and arg_125_1.time_ < var_128_5 + var_128_13 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114101032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114101032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play114101033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos6045_story = arg_129_1.actors_["6045_story"].transform.localPosition

				local var_132_0 = GameObjectTools.GetOrAddComponent(arg_129_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_132_0 then
					var_132_0:EnableDynamicBone(false)
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_1)
				arg_129_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["6045_story"].transform.position).z)
				arg_129_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["6045_story"].transform.localEulerAngles = arg_129_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["6045_story"].transform.position).z)
				arg_129_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["6045_story"].transform.localEulerAngles = arg_129_1.actors_["6045_story"].transform.localEulerAngles

				local var_132_2 = GameObjectTools.GetOrAddComponent(arg_129_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_132_2 then
					var_132_2:EnableDynamicBone(true)
				end
			end

			local var_132_3 = arg_129_1.actors_["6046_story"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos6046_story = var_132_3.localPosition

				local var_132_4 = GameObjectTools.GetOrAddComponent(var_132_3.gameObject, typeof(DynamicBoneHelper))

				if var_132_4 then
					var_132_4:EnableDynamicBone(false)
				end
			end

			local var_132_5 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 then
				var_132_3.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_5)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 then
				var_132_3.localPosition = Vector3.New(0, 100, 0)
				var_132_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_3.position).x, (manager.ui.mainCamera.transform.position - var_132_3.position).y, (manager.ui.mainCamera.transform.position - var_132_3.position).z)
				var_132_3.localEulerAngles.z = 0
				var_132_3.localEulerAngles.x = 0
				var_132_3.localEulerAngles = var_132_3.localEulerAngles

				local var_132_6 = GameObjectTools.GetOrAddComponent(var_132_3.gameObject, typeof(DynamicBoneHelper))

				if var_132_6 then
					var_132_6:EnableDynamicBone(true)
				end
			end

			local var_132_7 = 0
			local var_132_8 = 0.675

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_9 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(114101032).content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 27 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_9) / 27)

				if (27 <= 0 and var_132_8 or var_132_8 * (utf8.len(var_132_9) / 27)) > 0 and var_132_8 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_7 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_7
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_8, arg_129_1.talkMaxDuration)

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_7) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_7 + var_132_12 and arg_129_1.time_ < var_132_7 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
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
	Play114101033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114101033
		arg_133_1.duration_ = 5.87

		local var_133_0 = {
			ja = 5.866,
			ko = 4.1,
			zh = 4.7,
			en = 4.533
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
				arg_133_0:Play114101034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1068ui_story = arg_133_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1068ui_story"].transform.position).z)
				arg_133_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1068ui_story"].transform.localEulerAngles = arg_133_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_133_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1068ui_story"].transform.position).z)
				arg_133_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1068ui_story"].transform.localEulerAngles = arg_133_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action4_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_136_1 = arg_133_1.actors_["1068ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1068ui_story == nil then
				arg_133_1.var_.characterEffect1068ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1068ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1068ui_story then
				arg_133_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_136_4 = 0
			local var_136_5 = 0.5

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(114101033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 20 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 20)

				if (20 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 20)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101033", "story_v_out_114101.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101033", "story_v_out_114101.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_114101", "114101033", "story_v_out_114101.awb")

						arg_133_1:RecordAudio("114101033", var_136_11)
						arg_133_1:RecordAudio("114101033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114101", "114101033", "story_v_out_114101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114101", "114101033", "story_v_out_114101.awb")
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

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play114101034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114101034
		arg_137_1.duration_ = 3.57

		local var_137_0 = {
			ja = 2.2,
			ko = 3.133,
			zh = 3,
			en = 3.566
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
				arg_137_0:Play114101035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_140_0 = 0
			local var_140_1 = 0.325

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(114101034)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 13 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 13)

				if (13 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 13)) > 0 and var_140_1 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101034", "story_v_out_114101.awb") ~= 0 then
					local var_140_6 = manager.audio:GetVoiceLength("story_v_out_114101", "114101034", "story_v_out_114101.awb") / 1000

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end

					if var_140_2.prefab_name ~= "" and arg_137_1.actors_[var_140_2.prefab_name] ~= nil then
						local var_140_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_2.prefab_name].transform, "story_v_out_114101", "114101034", "story_v_out_114101.awb")

						arg_137_1:RecordAudio("114101034", var_140_7)
						arg_137_1:RecordAudio("114101034", var_140_7)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114101", "114101034", "story_v_out_114101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114101", "114101034", "story_v_out_114101.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play114101035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114101035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play114101036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1068ui_story = arg_141_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1068ui_story"].transform.position).z)
				arg_141_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1068ui_story"].transform.localEulerAngles = arg_141_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1068ui_story"].transform.position).z)
				arg_141_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1068ui_story"].transform.localEulerAngles = arg_141_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_144_1 = 0
			local var_144_2 = 0.95

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

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(114101035).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 38 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 38)

				if (38 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 38)) > 0 and var_144_2 < var_144_5 then
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

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play114101036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114101036
		arg_145_1.duration_ = 2.77

		local var_145_0 = {
			ja = 2.766,
			ko = 1.7,
			zh = 1.4,
			en = 2.166
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
				arg_145_0:Play114101037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.15

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1068")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(114101036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 6 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 6)

				if (6 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 6)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101036", "story_v_out_114101.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_114101", "114101036", "story_v_out_114101.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_114101", "114101036", "story_v_out_114101.awb")

						arg_145_1:RecordAudio("114101036", var_148_6)
						arg_145_1:RecordAudio("114101036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_114101", "114101036", "story_v_out_114101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_114101", "114101036", "story_v_out_114101.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play114101037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114101037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play114101038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.975

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(114101037).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 39 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 39)

				if (39 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 39)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play114101038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114101038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play114101039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.375

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(114101038).content)

				arg_153_1.text_.text = var_156_1

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_3 = 55 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 55)

				if (55 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_1) / 55)) > 0 and var_156_0 < var_156_3 then
					arg_153_1.talkMaxDuration = var_156_3

					if var_156_3 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_3 + 0
					end
				end

				arg_153_1.text_.text = var_156_1
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_4 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_4

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play114101039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114101039
		arg_157_1.duration_ = 4.87

		local var_157_0 = {
			ja = 3.366,
			ko = 3.166,
			zh = 3.466,
			en = 4.866
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play114101040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1068ui_story = arg_157_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1068ui_story"].transform.position).z)
				arg_157_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1068ui_story"].transform.localEulerAngles = arg_157_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_157_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1068ui_story"].transform.position).z)
				arg_157_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1068ui_story"].transform.localEulerAngles = arg_157_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_160_1 = arg_157_1.actors_["1068ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1068ui_story == nil then
				arg_157_1.var_.characterEffect1068ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1068ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1068ui_story then
				arg_157_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_160_4 = 0
			local var_160_5 = 0.35

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(114101039)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 14 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 14)

				if (14 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 14)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101039", "story_v_out_114101.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101039", "story_v_out_114101.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_114101", "114101039", "story_v_out_114101.awb")

						arg_157_1:RecordAudio("114101039", var_160_11)
						arg_157_1:RecordAudio("114101039", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114101", "114101039", "story_v_out_114101.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114101", "114101039", "story_v_out_114101.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play114101040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114101040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play114101041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1068ui_story = arg_161_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1068ui_story"].transform.position).z)
				arg_161_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1068ui_story"].transform.localEulerAngles = arg_161_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1068ui_story"].transform.position).z)
				arg_161_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1068ui_story"].transform.localEulerAngles = arg_161_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_164_1 = 0
			local var_164_2 = 0.625

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(114101040).content)

				arg_161_1.text_.text = var_164_3

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 25 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 25)

				if (25 <= 0 and var_164_2 or var_164_2 * (utf8.len(var_164_3) / 25)) > 0 and var_164_2 < var_164_5 then
					arg_161_1.talkMaxDuration = var_164_5

					if var_164_5 + var_164_1 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + var_164_1
					end
				end

				arg_161_1.text_.text = var_164_3
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_6 = math.max(var_164_2, arg_161_1.talkMaxDuration)

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_6 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_1) / var_164_6

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_1 + var_164_6 and arg_161_1.time_ < var_164_1 + var_164_6 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play114101041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114101041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play114101042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.225

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(114101041).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 49 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 49)

				if (49 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 49)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play114101042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114101042
		arg_169_1.duration_ = 6.4

		local var_169_0 = {
			ja = 6.4,
			ko = 5.866,
			zh = 5.766,
			en = 4.8
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
				arg_169_0:Play114101043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_172_0 = arg_169_1.actors_["1068ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1068ui_story = var_172_0.localPosition
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_169_1.time_ - 0) / var_172_1)
				var_172_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_0.position).x, (manager.ui.mainCamera.transform.position - var_172_0.position).y, (manager.ui.mainCamera.transform.position - var_172_0.position).z)
				var_172_0.localEulerAngles.z = 0
				var_172_0.localEulerAngles.x = 0
				var_172_0.localEulerAngles = var_172_0.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0, -0.95, -5.88)
				var_172_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_0.position).x, (manager.ui.mainCamera.transform.position - var_172_0.position).y, (manager.ui.mainCamera.transform.position - var_172_0.position).z)
				var_172_0.localEulerAngles.z = 0
				var_172_0.localEulerAngles.x = 0
				var_172_0.localEulerAngles = var_172_0.localEulerAngles
			end

			local var_172_2 = 0
			local var_172_3 = 0.725

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_4 = arg_169_1:GetWordFromCfg(114101042)
				local var_172_5 = arg_169_1:FormatText(var_172_4.content)

				arg_169_1.text_.text = var_172_5

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 29 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 29)

				if (29 <= 0 and var_172_3 or var_172_3 * (utf8.len(var_172_5) / 29)) > 0 and var_172_3 < var_172_7 then
					arg_169_1.talkMaxDuration = var_172_7

					if var_172_7 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_5
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101042", "story_v_out_114101.awb") ~= 0 then
					local var_172_8 = manager.audio:GetVoiceLength("story_v_out_114101", "114101042", "story_v_out_114101.awb") / 1000

					if var_172_8 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_8 + var_172_2
					end

					if var_172_4.prefab_name ~= "" and arg_169_1.actors_[var_172_4.prefab_name] ~= nil then
						local var_172_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_4.prefab_name].transform, "story_v_out_114101", "114101042", "story_v_out_114101.awb")

						arg_169_1:RecordAudio("114101042", var_172_9)
						arg_169_1:RecordAudio("114101042", var_172_9)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114101", "114101042", "story_v_out_114101.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114101", "114101042", "story_v_out_114101.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play114101043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114101043
		arg_173_1.duration_ = 5.33

		local var_173_0 = {
			ja = 5.333,
			ko = 4.833,
			zh = 5,
			en = 4.9
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play114101044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_176_0 = 0
			local var_176_1 = 0.525

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_2 = arg_173_1:GetWordFromCfg(114101043)
				local var_176_3 = arg_173_1:FormatText(var_176_2.content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 21 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 21)

				if (21 <= 0 and var_176_1 or var_176_1 * (utf8.len(var_176_3) / 21)) > 0 and var_176_1 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_0
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101043", "story_v_out_114101.awb") ~= 0 then
					local var_176_6 = manager.audio:GetVoiceLength("story_v_out_114101", "114101043", "story_v_out_114101.awb") / 1000

					if var_176_6 + var_176_0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_6 + var_176_0
					end

					if var_176_2.prefab_name ~= "" and arg_173_1.actors_[var_176_2.prefab_name] ~= nil then
						local var_176_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_2.prefab_name].transform, "story_v_out_114101", "114101043", "story_v_out_114101.awb")

						arg_173_1:RecordAudio("114101043", var_176_7)
						arg_173_1:RecordAudio("114101043", var_176_7)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114101", "114101043", "story_v_out_114101.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114101", "114101043", "story_v_out_114101.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_8 = math.max(var_176_1, arg_173_1.talkMaxDuration)

			if var_176_0 <= arg_173_1.time_ and arg_173_1.time_ < var_176_0 + var_176_8 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_0) / var_176_8

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_0 + var_176_8 and arg_173_1.time_ < var_176_0 + var_176_8 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play114101044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114101044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play114101045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1068ui_story = arg_177_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1068ui_story"].transform.position).z)
				arg_177_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1068ui_story"].transform.localEulerAngles = arg_177_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1068ui_story"].transform.position).z)
				arg_177_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1068ui_story"].transform.localEulerAngles = arg_177_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_180_1 = 0
			local var_180_2 = 0.7

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

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(114101044).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 28 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 28)

				if (28 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 28)) > 0 and var_180_2 < var_180_5 then
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

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play114101045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114101045
		arg_181_1.duration_ = 9.07

		local var_181_0 = {
			ja = 9.066,
			ko = 6.6,
			zh = 6.833,
			en = 8.1
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play114101046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1068ui_story = arg_181_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1068ui_story, Vector3.New(0, -0.95, -5.88), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1068ui_story"].transform.position).z)
				arg_181_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1068ui_story"].transform.localEulerAngles = arg_181_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_181_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1068ui_story"].transform.position).z)
				arg_181_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1068ui_story"].transform.localEulerAngles = arg_181_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action3_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_184_1 = arg_181_1.actors_["1068ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1068ui_story == nil then
				arg_181_1.var_.characterEffect1068ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1068ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1068ui_story then
				arg_181_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_184_4 = 0
			local var_184_5 = 0.8

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(114101045)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 32 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 32)

				if (32 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 32)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101045", "story_v_out_114101.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_114101", "114101045", "story_v_out_114101.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_114101", "114101045", "story_v_out_114101.awb")

						arg_181_1:RecordAudio("114101045", var_184_11)
						arg_181_1:RecordAudio("114101045", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114101", "114101045", "story_v_out_114101.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114101", "114101045", "story_v_out_114101.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
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
	Play114101046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114101046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play114101047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1068ui_story = arg_185_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1068ui_story"].transform.position).z)
				arg_185_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1068ui_story"].transform.localEulerAngles = arg_185_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_185_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1068ui_story"].transform.position).z)
				arg_185_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1068ui_story"].transform.localEulerAngles = arg_185_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_188_1 = 0
			local var_188_2 = 0.725

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(114101046).content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 29 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 29)

				if (29 <= 0 and var_188_2 or var_188_2 * (utf8.len(var_188_3) / 29)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_1 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_1
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_6 = math.max(var_188_2, arg_185_1.talkMaxDuration)

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_6 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_1) / var_188_6

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_1 + var_188_6 and arg_185_1.time_ < var_188_1 + var_188_6 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play114101047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114101047
		arg_189_1.duration_ = 8

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play114101048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if arg_189_1.bgs_.ST23 == nil then
				local var_192_0 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST23")
				var_192_0.name = "ST23"
				var_192_0.transform.parent = arg_189_1.stage_.transform
				var_192_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_.ST23 = var_192_0
			end

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				local var_192_1 = arg_189_1.bgs_.ST23

				arg_189_1.bgs_.ST23.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_2 = var_192_1:GetComponent("SpriteRenderer")

				if var_192_2 and var_192_2.sprite then
					local var_192_3 = 2 * (var_192_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_1.transform.localScale = Vector3.New(var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "ST23" then
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
				local var_192_6 = Color.New(0, 0, 0)

				var_192_6.a = Mathf.Lerp(0, 1, (arg_189_1.time_ - var_192_4) / var_192_5)
				arg_189_1.mask_.color = var_192_6
			end

			if arg_189_1.time_ >= var_192_4 + var_192_5 and arg_189_1.time_ < var_192_4 + var_192_5 + arg_192_0 then
				local var_192_7 = Color.New(0, 0, 0)

				var_192_7.a = 1
				arg_189_1.mask_.color = var_192_7
			end

			local var_192_8 = 2

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_9 = 2

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 then
				local var_192_10 = Color.New(0, 0, 0)

				var_192_10.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_8) / var_192_9)
				arg_189_1.mask_.color = var_192_10
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 then
				local var_192_11 = Color.New(0, 0, 0)

				arg_189_1.mask_.enabled = false
				var_192_11.a = 0
				arg_189_1.mask_.color = var_192_11
			end

			local var_192_12 = manager.ui.mainCamera.transform

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				arg_189_1.var_.shakeOldPos = var_192_12.localPosition
			end

			local var_192_13 = 1

			if 2 <= arg_189_1.time_ and arg_189_1.time_ < 2 + var_192_13 then
				local var_192_14, var_192_15 = math.modf((arg_189_1.time_ - 2) / 0.066)

				var_192_12.localPosition = Vector3.New(var_192_15 * 0.13, var_192_15 * 0.13, var_192_15 * 0.13) + arg_189_1.var_.shakeOldPos
			end

			if arg_189_1.time_ >= 2 + var_192_13 and arg_189_1.time_ < 2 + var_192_13 + arg_192_0 then
				var_192_12.localPosition = arg_189_1.var_.shakeOldPos
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_16 = 3
			local var_192_17 = 1

			if 3 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_18 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_18:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_19 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(114101047).content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_21 = 40 <= 0 and var_192_17 or var_192_17 * (utf8.len(var_192_19) / 40)

				if (40 <= 0 and var_192_17 or var_192_17 * (utf8.len(var_192_19) / 40)) > 0 and var_192_17 < var_192_21 then
					arg_189_1.talkMaxDuration = var_192_21
					var_192_16 = var_192_16 + 0.3

					if var_192_21 + var_192_16 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_21 + var_192_16
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_22 = var_192_16 + 0.3
			local var_192_23 = math.max(var_192_17, arg_189_1.talkMaxDuration)

			if var_192_16 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_22 + var_192_23 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_22) / var_192_23

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_22 + var_192_23 and arg_189_1.time_ < var_192_22 + var_192_23 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play114101048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 114101048
		arg_195_1.duration_ = 3.33

		local var_195_0 = {
			ja = 3.333,
			ko = 1.9,
			zh = 1.866,
			en = 2
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
				arg_195_0:Play114101049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.25

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1068")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(114101048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 10 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 10)

				if (10 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 10)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101048", "story_v_out_114101.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_114101", "114101048", "story_v_out_114101.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_114101", "114101048", "story_v_out_114101.awb")

						arg_195_1:RecordAudio("114101048", var_198_6)
						arg_195_1:RecordAudio("114101048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_114101", "114101048", "story_v_out_114101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_114101", "114101048", "story_v_out_114101.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play114101049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114101049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play114101050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.725

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(114101049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 29 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 29)

				if (29 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 29)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play114101050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114101050
		arg_203_1.duration_ = 3.1

		local var_203_0 = {
			ja = 3.1,
			ko = 2.066,
			zh = 2.066,
			en = 1.933
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
				arg_203_0:Play114101051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.175

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1068")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(114101050)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 7 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 7)

				if (7 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 7)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101050", "story_v_out_114101.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_114101", "114101050", "story_v_out_114101.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_114101", "114101050", "story_v_out_114101.awb")

						arg_203_1:RecordAudio("114101050", var_206_6)
						arg_203_1:RecordAudio("114101050", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_114101", "114101050", "story_v_out_114101.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_114101", "114101050", "story_v_out_114101.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play114101051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114101051
		arg_207_1.duration_ = 8.5

		local var_207_0 = {
			ja = 7.333,
			ko = 7.266,
			zh = 8.5,
			en = 6.1
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
				arg_207_0:Play114101052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.575

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:GetWordFromCfg(114101051)
				local var_210_2 = arg_207_1:FormatText(var_210_1.content)

				arg_207_1.text_.text = var_210_2

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 23 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 23)

				if (23 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_2) / 23)) > 0 and var_210_0 < var_210_4 then
					arg_207_1.talkMaxDuration = var_210_4

					if var_210_4 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_4 + 0
					end
				end

				arg_207_1.text_.text = var_210_2
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101051", "story_v_out_114101.awb") ~= 0 then
					local var_210_5 = manager.audio:GetVoiceLength("story_v_out_114101", "114101051", "story_v_out_114101.awb") / 1000

					if var_210_5 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + 0
					end

					if var_210_1.prefab_name ~= "" and arg_207_1.actors_[var_210_1.prefab_name] ~= nil then
						local var_210_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_1.prefab_name].transform, "story_v_out_114101", "114101051", "story_v_out_114101.awb")

						arg_207_1:RecordAudio("114101051", var_210_6)
						arg_207_1:RecordAudio("114101051", var_210_6)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_114101", "114101051", "story_v_out_114101.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_114101", "114101051", "story_v_out_114101.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play114101052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114101052
		arg_211_1.duration_ = 2.6

		local var_211_0 = {
			ja = 2,
			ko = 2.6,
			zh = 1.4,
			en = 2.533
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
				arg_211_0:Play114101053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_214_0 = 0.6

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				local var_214_1, var_214_2 = math.modf((arg_211_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_214_2 * 0.13, var_214_2 * 0.13, var_214_2 * 0.13) + arg_211_1.var_.shakeOldPos
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				manager.ui.mainCamera.transform.localPosition = arg_211_1.var_.shakeOldPos
			end

			local var_214_3 = 0

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_3 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_3 + 0.6 and arg_211_1.time_ < var_214_3 + 0.6 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:AudioAction("play", "effect", "se_story_11", "se_story_11_kick02", "")
			end

			local var_214_5 = 0
			local var_214_6 = 0.15

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1068")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_7 = arg_211_1:GetWordFromCfg(114101052)
				local var_214_8 = arg_211_1:FormatText(var_214_7.content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 6 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 6)

				if (6 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 6)) > 0 and var_214_6 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114101", "114101052", "story_v_out_114101.awb") ~= 0 then
					local var_214_11 = manager.audio:GetVoiceLength("story_v_out_114101", "114101052", "story_v_out_114101.awb") / 1000

					if var_214_11 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_5
					end

					if var_214_7.prefab_name ~= "" and arg_211_1.actors_[var_214_7.prefab_name] ~= nil then
						local var_214_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_7.prefab_name].transform, "story_v_out_114101", "114101052", "story_v_out_114101.awb")

						arg_211_1:RecordAudio("114101052", var_214_12)
						arg_211_1:RecordAudio("114101052", var_214_12)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_114101", "114101052", "story_v_out_114101.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_114101", "114101052", "story_v_out_114101.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_13 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_13 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_13

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_13 and arg_211_1.time_ < var_214_5 + var_214_13 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play114101053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 114101053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
			arg_215_1.auto_ = false
		end

		function arg_215_1.playNext_(arg_217_0)
			arg_215_1.onStoryFinished_()
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				local var_218_0 = arg_215_1.bgs_.ST23:GetComponent("SpriteRenderer")

				if var_218_0 then
					arg_215_1.var_.alphaOldValueST23 = var_218_0.color.a
					arg_215_1.var_.alphaMatValueST23 = var_218_0
				end

				arg_215_1.var_.alphaOldValueST23 = 1
			end

			local var_218_1 = 2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				if arg_215_1.var_.alphaMatValueST23 then
					arg_215_1.var_.alphaMatValueST23.color.a = Mathf.Lerp(arg_215_1.var_.alphaOldValueST23, 0, (arg_215_1.time_ - 0) / var_218_1)
					arg_215_1.var_.alphaMatValueST23.color = arg_215_1.var_.alphaMatValueST23.color
				end
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 and arg_215_1.var_.alphaMatValueST23 then
				arg_215_1.var_.alphaMatValueST23.color.a = 0
				arg_215_1.var_.alphaMatValueST23.color = arg_215_1.var_.alphaMatValueST23.color
			end

			local var_218_2 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			if arg_215_1.time_ >= var_218_2 + 2 and arg_215_1.time_ < var_218_2 + 2 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_3 = 0
			local var_218_4 = 1.325

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_5 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(114101053).content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_7 = 53 <= 0 and var_218_4 or var_218_4 * (utf8.len(var_218_5) / 53)

				if (53 <= 0 and var_218_4 or var_218_4 * (utf8.len(var_218_5) / 53)) > 0 and var_218_4 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_3 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_3
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_8 = math.max(var_218_4, arg_215_1.talkMaxDuration)

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_8 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_3) / var_218_8

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_3 + var_218_8 and arg_215_1.time_ < var_218_3 + var_218_8 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/ST23"
	},
	voices = {
		"story_v_out_114101.awb"
	}
}
