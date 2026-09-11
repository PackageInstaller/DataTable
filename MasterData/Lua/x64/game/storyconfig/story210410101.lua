return {
	Play1104101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104101001
		arg_1_1.duration_ = 11.97

		local var_1_0 = {
			zh = 11.966,
			ja = 11.6
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
				arg_1_0:Play1104101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F03_2 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F03_2")
				var_4_0.name = "F03_2"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F03_2 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F03_2

				arg_1_1.bgs_.F03_2.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F03_2" then
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

			local var_4_8 = "1041ui_story"

			if arg_1_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1041ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1041ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.11, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1041ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1041ui_story == nil then
				arg_1_1.var_.characterEffect1041ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1041ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1041ui_story then
				arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

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
			local var_4_24 = 1.05

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(1104101001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 42 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 42)

				if (42 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 42)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101001", "story_v_side_new_1104101.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101001", "story_v_side_new_1104101.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_side_new_1104101", "1104101001", "story_v_side_new_1104101.awb")

						arg_1_1:RecordAudio("1104101001", var_4_31)
						arg_1_1:RecordAudio("1104101001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101001", "story_v_side_new_1104101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101001", "story_v_side_new_1104101.awb")
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play1104101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1104101002
		arg_9_1.duration_ = 6.7

		local var_9_0 = {
			zh = 3.366,
			ja = 6.7
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
				arg_9_0:Play1104101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1041ui_story"]) and arg_9_1.var_.characterEffect1041ui_story == nil then
				arg_9_1.var_.characterEffect1041ui_story = arg_9_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1041ui_story"]) then
				if arg_9_1.var_.characterEffect1041ui_story and not isNil(arg_9_1.actors_["1041ui_story"]) then
					arg_9_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1041ui_story"]) and arg_9_1.var_.characterEffect1041ui_story then
				arg_9_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.425

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(1104101002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 17 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_4) / 17)

				if (17 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_4) / 17)) > 0 and var_12_2 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101002", "story_v_side_new_1104101.awb") ~= 0 then
					local var_12_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101002", "story_v_side_new_1104101.awb") / 1000

					if var_12_7 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_1
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_side_new_1104101", "1104101002", "story_v_side_new_1104101.awb")

						arg_9_1:RecordAudio("1104101002", var_12_8)
						arg_9_1:RecordAudio("1104101002", var_12_8)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101002", "story_v_side_new_1104101.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101002", "story_v_side_new_1104101.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_9 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_9 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_9

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_9 and arg_9_1.time_ < var_12_1 + var_12_9 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1104101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1104101003
		arg_13_1.duration_ = 7.6

		local var_13_0 = {
			zh = 7.6,
			ja = 5
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
				arg_13_0:Play1104101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1041ui_story = arg_13_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1041ui_story"].transform.position).z)
				arg_13_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1041ui_story"].transform.localEulerAngles = arg_13_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_13_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1041ui_story"].transform.position).z)
				arg_13_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1041ui_story"].transform.localEulerAngles = arg_13_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["1041ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1041ui_story == nil then
				arg_13_1.var_.characterEffect1041ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect1041ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect1041ui_story then
				arg_13_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_16_4 = 0
			local var_16_5 = 0.825

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(1104101003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 33 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 33)

				if (33 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 33)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101003", "story_v_side_new_1104101.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101003", "story_v_side_new_1104101.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_side_new_1104101", "1104101003", "story_v_side_new_1104101.awb")

						arg_13_1:RecordAudio("1104101003", var_16_11)
						arg_13_1:RecordAudio("1104101003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101003", "story_v_side_new_1104101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101003", "story_v_side_new_1104101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1104101004
		arg_17_1.duration_ = 6

		local var_17_0 = {
			zh = 6,
			ja = 5.166
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
				arg_17_0:Play1104101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) and arg_17_1.var_.characterEffect1041ui_story == nil then
				arg_17_1.var_.characterEffect1041ui_story = arg_17_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) then
				if arg_17_1.var_.characterEffect1041ui_story and not isNil(arg_17_1.actors_["1041ui_story"]) then
					arg_17_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1041ui_story"]) and arg_17_1.var_.characterEffect1041ui_story then
				arg_17_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.7

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(1104101004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 28 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 28)

				if (28 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_4) / 28)) > 0 and var_20_2 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101004", "story_v_side_new_1104101.awb") ~= 0 then
					local var_20_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101004", "story_v_side_new_1104101.awb") / 1000

					if var_20_7 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_1
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_side_new_1104101", "1104101004", "story_v_side_new_1104101.awb")

						arg_17_1:RecordAudio("1104101004", var_20_8)
						arg_17_1:RecordAudio("1104101004", var_20_8)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101004", "story_v_side_new_1104101.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101004", "story_v_side_new_1104101.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_9 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_9 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_9

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_9 and arg_17_1.time_ < var_20_1 + var_20_9 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play1104101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1104101005
		arg_21_1.duration_ = 2

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1104101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1041ui_story = arg_21_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1041ui_story"].transform.position).z)
				arg_21_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1041ui_story"].transform.localEulerAngles = arg_21_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_21_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1041ui_story"].transform.position).z)
				arg_21_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1041ui_story"].transform.localEulerAngles = arg_21_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1041ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1041ui_story == nil then
				arg_21_1.var_.characterEffect1041ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1041ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1041ui_story then
				arg_21_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_4 = 0
			local var_24_5 = 0.05

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(1104101005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 2 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 2)

				if (2 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 2)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101005", "story_v_side_new_1104101.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101005", "story_v_side_new_1104101.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_side_new_1104101", "1104101005", "story_v_side_new_1104101.awb")

						arg_21_1:RecordAudio("1104101005", var_24_11)
						arg_21_1:RecordAudio("1104101005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101005", "story_v_side_new_1104101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101005", "story_v_side_new_1104101.awb")
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
				actorName = "1041ui_story",
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
	Play1104101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1104101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1104101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1041ui_story"]) and arg_25_1.var_.characterEffect1041ui_story == nil then
				arg_25_1.var_.characterEffect1041ui_story = arg_25_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1041ui_story"]) then
				if arg_25_1.var_.characterEffect1041ui_story and not isNil(arg_25_1.actors_["1041ui_story"]) then
					arg_25_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1041ui_story"]) and arg_25_1.var_.characterEffect1041ui_story then
				arg_25_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.95

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(1104101006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 38 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 38)

				if (38 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 38)) > 0 and var_28_2 < var_28_5 then
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
	Play1104101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1104101007
		arg_29_1.duration_ = 5.27

		local var_29_0 = {
			zh = 4.333,
			ja = 5.266
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
				arg_29_0:Play1104101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.525

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(1104101007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 21 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 21)

				if (21 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 21)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101007", "story_v_side_new_1104101.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101007", "story_v_side_new_1104101.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_side_new_1104101", "1104101007", "story_v_side_new_1104101.awb")

						arg_29_1:RecordAudio("1104101007", var_32_6)
						arg_29_1:RecordAudio("1104101007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101007", "story_v_side_new_1104101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101007", "story_v_side_new_1104101.awb")
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
	Play1104101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1104101008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1104101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1041ui_story = arg_33_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1041ui_story"].transform.position).z)
				arg_33_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1041ui_story"].transform.localEulerAngles = arg_33_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_33_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1041ui_story"].transform.position).z)
				arg_33_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1041ui_story"].transform.localEulerAngles = arg_33_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1041ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1041ui_story == nil then
				arg_33_1.var_.characterEffect1041ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1041ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1041ui_story then
				arg_33_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(1104101008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 4 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 4)

				if (4 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 4)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101008", "story_v_side_new_1104101.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101008", "story_v_side_new_1104101.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_side_new_1104101", "1104101008", "story_v_side_new_1104101.awb")

						arg_33_1:RecordAudio("1104101008", var_36_11)
						arg_33_1:RecordAudio("1104101008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101008", "story_v_side_new_1104101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101008", "story_v_side_new_1104101.awb")
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

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1104101009
		arg_37_1.duration_ = 7.4

		local var_37_0 = {
			zh = 4.766,
			ja = 7.4
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
				arg_37_0:Play1104101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1041ui_story"]) and arg_37_1.var_.characterEffect1041ui_story == nil then
				arg_37_1.var_.characterEffect1041ui_story = arg_37_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1041ui_story"]) then
				if arg_37_1.var_.characterEffect1041ui_story and not isNil(arg_37_1.actors_["1041ui_story"]) then
					arg_37_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1041ui_story"]) and arg_37_1.var_.characterEffect1041ui_story then
				arg_37_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.6

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:GetWordFromCfg(1104101009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 24 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 24)

				if (24 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 24)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101009", "story_v_side_new_1104101.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101009", "story_v_side_new_1104101.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_side_new_1104101", "1104101009", "story_v_side_new_1104101.awb")

						arg_37_1:RecordAudio("1104101009", var_40_8)
						arg_37_1:RecordAudio("1104101009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101009", "story_v_side_new_1104101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101009", "story_v_side_new_1104101.awb")
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
	Play1104101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1104101010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1104101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.325

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

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(1104101010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 53 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 53)

				if (53 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 53)) > 0 and var_44_0 < var_44_3 then
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
	Play1104101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1104101011
		arg_45_1.duration_ = 10.47

		local var_45_0 = {
			zh = 10.466,
			ja = 10.1
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
				arg_45_0:Play1104101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1041ui_story = arg_45_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1041ui_story"].transform.position).z)
				arg_45_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1041ui_story"].transform.localEulerAngles = arg_45_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_45_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1041ui_story"].transform.position).z)
				arg_45_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1041ui_story"].transform.localEulerAngles = arg_45_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1041ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1041ui_story == nil then
				arg_45_1.var_.characterEffect1041ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1041ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1041ui_story then
				arg_45_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_4 = 0
			local var_48_5 = 1.225

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(1104101011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 49 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 49)

				if (49 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 49)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101011", "story_v_side_new_1104101.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101011", "story_v_side_new_1104101.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_side_new_1104101", "1104101011", "story_v_side_new_1104101.awb")

						arg_45_1:RecordAudio("1104101011", var_48_11)
						arg_45_1:RecordAudio("1104101011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101011", "story_v_side_new_1104101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101011", "story_v_side_new_1104101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1104101012
		arg_49_1.duration_ = 6.03

		local var_49_0 = {
			zh = 4.566,
			ja = 6.033
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
				arg_49_0:Play1104101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1041ui_story"]) and arg_49_1.var_.characterEffect1041ui_story == nil then
				arg_49_1.var_.characterEffect1041ui_story = arg_49_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1041ui_story"]) then
				if arg_49_1.var_.characterEffect1041ui_story and not isNil(arg_49_1.actors_["1041ui_story"]) then
					arg_49_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1041ui_story"]) and arg_49_1.var_.characterEffect1041ui_story then
				arg_49_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(1104101012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 18 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 18)

				if (18 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_4) / 18)) > 0 and var_52_2 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101012", "story_v_side_new_1104101.awb") ~= 0 then
					local var_52_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101012", "story_v_side_new_1104101.awb") / 1000

					if var_52_7 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_1
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_side_new_1104101", "1104101012", "story_v_side_new_1104101.awb")

						arg_49_1:RecordAudio("1104101012", var_52_8)
						arg_49_1:RecordAudio("1104101012", var_52_8)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101012", "story_v_side_new_1104101.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101012", "story_v_side_new_1104101.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_9 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_9 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_9

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_9 and arg_49_1.time_ < var_52_1 + var_52_9 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1104101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1104101013
		arg_53_1.duration_ = 11.3

		local var_53_0 = {
			zh = 11.3,
			ja = 8.2
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
				arg_53_0:Play1104101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1041ui_story = arg_53_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1041ui_story"].transform.position).z)
				arg_53_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1041ui_story"].transform.localEulerAngles = arg_53_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_53_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1041ui_story"].transform.position).z)
				arg_53_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1041ui_story"].transform.localEulerAngles = arg_53_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1041ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1041ui_story == nil then
				arg_53_1.var_.characterEffect1041ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1041ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1041ui_story then
				arg_53_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = 0
			local var_56_5 = 1.25

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(1104101013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 50 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 50)

				if (50 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 50)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101013", "story_v_side_new_1104101.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101013", "story_v_side_new_1104101.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_side_new_1104101", "1104101013", "story_v_side_new_1104101.awb")

						arg_53_1:RecordAudio("1104101013", var_56_11)
						arg_53_1:RecordAudio("1104101013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101013", "story_v_side_new_1104101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101013", "story_v_side_new_1104101.awb")
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
				actorName = "1041ui_story",
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
	Play1104101014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1104101014
		arg_57_1.duration_ = 8.53

		local var_57_0 = {
			zh = 8.533,
			ja = 7.2
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
				arg_57_0:Play1104101015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1041ui_story"]) and arg_57_1.var_.characterEffect1041ui_story == nil then
				arg_57_1.var_.characterEffect1041ui_story = arg_57_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1041ui_story"]) then
				if arg_57_1.var_.characterEffect1041ui_story and not isNil(arg_57_1.actors_["1041ui_story"]) then
					arg_57_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1041ui_story"]) and arg_57_1.var_.characterEffect1041ui_story then
				arg_57_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.825

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(1104101014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 33 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_4) / 33)

				if (33 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_4) / 33)) > 0 and var_60_2 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101014", "story_v_side_new_1104101.awb") ~= 0 then
					local var_60_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101014", "story_v_side_new_1104101.awb") / 1000

					if var_60_7 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_1
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_side_new_1104101", "1104101014", "story_v_side_new_1104101.awb")

						arg_57_1:RecordAudio("1104101014", var_60_8)
						arg_57_1:RecordAudio("1104101014", var_60_8)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101014", "story_v_side_new_1104101.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101014", "story_v_side_new_1104101.awb")
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
	Play1104101015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1104101015
		arg_61_1.duration_ = 7.63

		local var_61_0 = {
			zh = 6.133,
			ja = 7.633
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1104101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.725

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_1 = arg_61_1:GetWordFromCfg(1104101015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 29 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 29)

				if (29 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 29)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101015", "story_v_side_new_1104101.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101015", "story_v_side_new_1104101.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_side_new_1104101", "1104101015", "story_v_side_new_1104101.awb")

						arg_61_1:RecordAudio("1104101015", var_64_6)
						arg_61_1:RecordAudio("1104101015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101015", "story_v_side_new_1104101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101015", "story_v_side_new_1104101.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1104101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1104101016
		arg_65_1.duration_ = 7.6

		local var_65_0 = {
			zh = 5.566,
			ja = 7.6
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
				arg_65_0:Play1104101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1041ui_story = arg_65_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1041ui_story"].transform.position).z)
				arg_65_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1041ui_story"].transform.localEulerAngles = arg_65_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_65_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1041ui_story"].transform.position).z)
				arg_65_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1041ui_story"].transform.localEulerAngles = arg_65_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1041ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1041ui_story == nil then
				arg_65_1.var_.characterEffect1041ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1041ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1041ui_story then
				arg_65_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_68_4 = 0
			local var_68_5 = 0.75

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(1104101016)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101016", "story_v_side_new_1104101.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101016", "story_v_side_new_1104101.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_side_new_1104101", "1104101016", "story_v_side_new_1104101.awb")

						arg_65_1:RecordAudio("1104101016", var_68_11)
						arg_65_1:RecordAudio("1104101016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101016", "story_v_side_new_1104101.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101016", "story_v_side_new_1104101.awb")
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
				actorName = "1041ui_story",
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
	Play1104101017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1104101017
		arg_69_1.duration_ = 6.7

		local var_69_0 = {
			zh = 6.7,
			ja = 6.366
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
				arg_69_0:Play1104101018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1041ui_story"]) and arg_69_1.var_.characterEffect1041ui_story == nil then
				arg_69_1.var_.characterEffect1041ui_story = arg_69_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1041ui_story"]) then
				if arg_69_1.var_.characterEffect1041ui_story and not isNil(arg_69_1.actors_["1041ui_story"]) then
					arg_69_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1041ui_story"]) and arg_69_1.var_.characterEffect1041ui_story then
				arg_69_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.65

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(1104101017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 26 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 26)

				if (26 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 26)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101017", "story_v_side_new_1104101.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101017", "story_v_side_new_1104101.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_side_new_1104101", "1104101017", "story_v_side_new_1104101.awb")

						arg_69_1:RecordAudio("1104101017", var_72_8)
						arg_69_1:RecordAudio("1104101017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101017", "story_v_side_new_1104101.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101017", "story_v_side_new_1104101.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_9 and arg_69_1.time_ < var_72_1 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1104101018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1104101018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1104101019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_76_0 = 0
			local var_76_1 = 0.5

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(1104101018).content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 20 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_2) / 20)

				if (20 <= 0 and var_76_1 or var_76_1 * (utf8.len(var_76_2) / 20)) > 0 and var_76_1 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_5 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_5 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_5

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_5 and arg_73_1.time_ < var_76_0 + var_76_5 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1104101019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1104101019
		arg_77_1.duration_ = 11.5

		local var_77_0 = {
			zh = 11.5,
			ja = 9.9
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
				arg_77_0:Play1104101020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1041ui_story = arg_77_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).z)
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles = arg_77_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_77_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1041ui_story"].transform.position).z)
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1041ui_story"].transform.localEulerAngles = arg_77_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1041ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1041ui_story == nil then
				arg_77_1.var_.characterEffect1041ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1041ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1041ui_story then
				arg_77_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = 0
			local var_80_5 = 1.375

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(1104101019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 55 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 55)

				if (55 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 55)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101019", "story_v_side_new_1104101.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101019", "story_v_side_new_1104101.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_side_new_1104101", "1104101019", "story_v_side_new_1104101.awb")

						arg_77_1:RecordAudio("1104101019", var_80_11)
						arg_77_1:RecordAudio("1104101019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101019", "story_v_side_new_1104101.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101019", "story_v_side_new_1104101.awb")
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
				actorName = "1041ui_story",
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
	Play1104101020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1104101020
		arg_81_1.duration_ = 12.63

		local var_81_0 = {
			zh = 12.633,
			ja = 11.2
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
				arg_81_0:Play1104101021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.5

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(1104101020)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101020", "story_v_side_new_1104101.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101020", "story_v_side_new_1104101.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_side_new_1104101", "1104101020", "story_v_side_new_1104101.awb")

						arg_81_1:RecordAudio("1104101020", var_84_6)
						arg_81_1:RecordAudio("1104101020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101020", "story_v_side_new_1104101.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101020", "story_v_side_new_1104101.awb")
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
	Play1104101021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1104101021
		arg_85_1.duration_ = 14.07

		local var_85_0 = {
			zh = 14.066,
			ja = 11.1
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
				arg_85_0:Play1104101022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1041ui_story"]) and arg_85_1.var_.characterEffect1041ui_story == nil then
				arg_85_1.var_.characterEffect1041ui_story = arg_85_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1041ui_story"]) then
				if arg_85_1.var_.characterEffect1041ui_story and not isNil(arg_85_1.actors_["1041ui_story"]) then
					arg_85_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1041ui_story"]) and arg_85_1.var_.characterEffect1041ui_story then
				arg_85_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 1.25

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(1104101021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 50 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 50)

				if (50 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 50)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101021", "story_v_side_new_1104101.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101021", "story_v_side_new_1104101.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_side_new_1104101", "1104101021", "story_v_side_new_1104101.awb")

						arg_85_1:RecordAudio("1104101021", var_88_8)
						arg_85_1:RecordAudio("1104101021", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101021", "story_v_side_new_1104101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101021", "story_v_side_new_1104101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1104101022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1104101022
		arg_89_1.duration_ = 2

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1104101023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1041ui_story = arg_89_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1041ui_story"].transform.position).z)
				arg_89_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1041ui_story"].transform.localEulerAngles = arg_89_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_89_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1041ui_story"].transform.position).z)
				arg_89_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1041ui_story"].transform.localEulerAngles = arg_89_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1041ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1041ui_story == nil then
				arg_89_1.var_.characterEffect1041ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1041ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1041ui_story then
				arg_89_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_92_4 = 0
			local var_92_5 = 0.05

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(1104101022)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 2 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 2)

				if (2 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 2)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101022", "story_v_side_new_1104101.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101022", "story_v_side_new_1104101.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_side_new_1104101", "1104101022", "story_v_side_new_1104101.awb")

						arg_89_1:RecordAudio("1104101022", var_92_11)
						arg_89_1:RecordAudio("1104101022", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101022", "story_v_side_new_1104101.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101022", "story_v_side_new_1104101.awb")
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

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104101023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1104101023
		arg_93_1.duration_ = 9.03

		local var_93_0 = {
			zh = 9.033,
			ja = 8.966
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
				arg_93_0:Play1104101024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1041ui_story"]) and arg_93_1.var_.characterEffect1041ui_story == nil then
				arg_93_1.var_.characterEffect1041ui_story = arg_93_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1041ui_story"]) then
				if arg_93_1.var_.characterEffect1041ui_story and not isNil(arg_93_1.actors_["1041ui_story"]) then
					arg_93_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1041ui_story"]) and arg_93_1.var_.characterEffect1041ui_story then
				arg_93_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 1.1

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_3 = arg_93_1:GetWordFromCfg(1104101023)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 44 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 44)

				if (44 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_4) / 44)) > 0 and var_96_2 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101023", "story_v_side_new_1104101.awb") ~= 0 then
					local var_96_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101023", "story_v_side_new_1104101.awb") / 1000

					if var_96_7 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_1
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_side_new_1104101", "1104101023", "story_v_side_new_1104101.awb")

						arg_93_1:RecordAudio("1104101023", var_96_8)
						arg_93_1:RecordAudio("1104101023", var_96_8)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101023", "story_v_side_new_1104101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101023", "story_v_side_new_1104101.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_9 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_9 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_9

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_9 and arg_93_1.time_ < var_96_1 + var_96_9 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play1104101024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1104101024
		arg_97_1.duration_ = 2.7

		local var_97_0 = {
			zh = 2.366,
			ja = 2.7
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
				arg_97_0:Play1104101025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1041ui_story = arg_97_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1041ui_story"].transform.position).z)
				arg_97_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1041ui_story"].transform.localEulerAngles = arg_97_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_97_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1041ui_story"].transform.position).z)
				arg_97_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1041ui_story"].transform.localEulerAngles = arg_97_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["1041ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1041ui_story == nil then
				arg_97_1.var_.characterEffect1041ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect1041ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect1041ui_story then
				arg_97_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_100_4 = 0
			local var_100_5 = 0.225

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(1104101024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 9 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 9)

				if (9 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 9)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101024", "story_v_side_new_1104101.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101024", "story_v_side_new_1104101.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_side_new_1104101", "1104101024", "story_v_side_new_1104101.awb")

						arg_97_1:RecordAudio("1104101024", var_100_11)
						arg_97_1:RecordAudio("1104101024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101024", "story_v_side_new_1104101.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101024", "story_v_side_new_1104101.awb")
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
				actorName = "1041ui_story",
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
	Play1104101025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1104101025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1104101026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1041ui_story"]) and arg_101_1.var_.characterEffect1041ui_story == nil then
				arg_101_1.var_.characterEffect1041ui_story = arg_101_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1041ui_story"]) then
				if arg_101_1.var_.characterEffect1041ui_story and not isNil(arg_101_1.actors_["1041ui_story"]) then
					arg_101_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1041ui_story"]) and arg_101_1.var_.characterEffect1041ui_story then
				arg_101_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 1.375

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

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1104101025).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 55 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 55)

				if (55 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 55)) > 0 and var_104_2 < var_104_5 then
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
	Play1104101026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1104101026
		arg_105_1.duration_ = 3.83

		local var_105_0 = {
			zh = 3.033,
			ja = 3.833
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
				arg_105_0:Play1104101027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1041ui_story = arg_105_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1041ui_story"].transform.position).z)
				arg_105_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1041ui_story"].transform.localEulerAngles = arg_105_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_105_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1041ui_story"].transform.position).z)
				arg_105_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1041ui_story"].transform.localEulerAngles = arg_105_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["1041ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1041ui_story == nil then
				arg_105_1.var_.characterEffect1041ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect1041ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect1041ui_story then
				arg_105_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_108_4 = 0
			local var_108_5 = 0.55

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(1104101026)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 22 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 22)

				if (22 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 22)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101026", "story_v_side_new_1104101.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101026", "story_v_side_new_1104101.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_side_new_1104101", "1104101026", "story_v_side_new_1104101.awb")

						arg_105_1:RecordAudio("1104101026", var_108_11)
						arg_105_1:RecordAudio("1104101026", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101026", "story_v_side_new_1104101.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101026", "story_v_side_new_1104101.awb")
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

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play1104101027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1104101027
		arg_109_1.duration_ = 2.82

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1104101028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if arg_109_1.bgs_.STblack == nil then
				local var_112_0 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_112_0.name = "STblack"
				var_112_0.transform.parent = arg_109_1.stage_.transform
				var_112_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_.STblack = var_112_0
			end

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				local var_112_1 = arg_109_1.bgs_.STblack

				arg_109_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_2 = var_112_1:GetComponent("SpriteRenderer")

				if var_112_2 and var_112_2.sprite then
					local var_112_3 = 2 * (var_112_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_1.transform.localScale = Vector3.New(var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, var_112_3 / var_112_2.sprite.bounds.size.y < var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x and var_112_3 * manager.ui.mainCameraCom_.aspect / var_112_2.sprite.bounds.size.x or var_112_3 / var_112_2.sprite.bounds.size.y, 0)
				end

				for iter_112_0, iter_112_1 in pairs(arg_109_1.bgs_) do
					if iter_112_0 ~= "STblack" then
						iter_112_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_112_4 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_5 = 2

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_5 then
				local var_112_6 = Color.New(0, 0, 0)

				var_112_6.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_4) / var_112_5)
				arg_109_1.mask_.color = var_112_6
			end

			if arg_109_1.time_ >= var_112_4 + var_112_5 and arg_109_1.time_ < var_112_4 + var_112_5 + arg_112_0 then
				local var_112_7 = Color.New(0, 0, 0)

				var_112_7.a = 1
				arg_109_1.mask_.color = var_112_7
			end

			local var_112_8 = 2

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_9 = 0.416666666666667

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 then
				local var_112_10 = Color.New(0, 0, 0)

				var_112_10.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_8) / var_112_9)
				arg_109_1.mask_.color = var_112_10
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 then
				local var_112_11 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_11.a = 0
				arg_109_1.mask_.color = var_112_11
			end

			local var_112_12 = arg_109_1.actors_["1041ui_story"].transform

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				arg_109_1.var_.moveOldPos1041ui_story = var_112_12.localPosition
			end

			local var_112_13 = 0.001

			if 2 <= arg_109_1.time_ and arg_109_1.time_ < 2 + var_112_13 then
				var_112_12.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 2) / var_112_13)
				var_112_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_12.position).x, (manager.ui.mainCamera.transform.position - var_112_12.position).y, (manager.ui.mainCamera.transform.position - var_112_12.position).z)
				var_112_12.localEulerAngles.z = 0
				var_112_12.localEulerAngles.x = 0
				var_112_12.localEulerAngles = var_112_12.localEulerAngles
			end

			if arg_109_1.time_ >= 2 + var_112_13 and arg_109_1.time_ < 2 + var_112_13 + arg_112_0 then
				var_112_12.localPosition = Vector3.New(0, 100, 0)
				var_112_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_12.position).x, (manager.ui.mainCamera.transform.position - var_112_12.position).y, (manager.ui.mainCamera.transform.position - var_112_12.position).z)
				var_112_12.localEulerAngles.z = 0
				var_112_12.localEulerAngles.x = 0
				var_112_12.localEulerAngles = var_112_12.localEulerAngles
			end

			if 2 < arg_109_1.time_ and arg_109_1.time_ <= 2 + arg_112_0 then
				arg_109_1.fswbg_:SetActive(true)
				arg_109_1.dialog_:SetActive(false)

				arg_109_1.fswtw_.percent = 0
				arg_109_1.fswt_.text = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1104101027).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.fswt_)

				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_109_1.fswtw_:SetDirty()

				arg_109_1.typewritterCharCountI18N = 0

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_14 = 2.41666666666667

			if 2.41666666666667 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.var_.oldValueTypewriter = arg_109_1.fswtw_.percent

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_15 = 6
			local var_112_16 = 0.4
			local var_112_17, var_112_18 = arg_109_1:GetPercentByPara(arg_109_1:FormatText(arg_109_1:GetWordFromCfg(1104101027).content), 1)

			if var_112_14 < arg_109_1.time_ and arg_109_1.time_ <= var_112_14 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				local var_112_19 = var_112_15 <= 0 and var_112_16 or var_112_16 * ((var_112_18 - arg_109_1.typewritterCharCountI18N) / var_112_15)

				if (var_112_15 <= 0 and var_112_16 or var_112_16 * ((var_112_18 - arg_109_1.typewritterCharCountI18N) / var_112_15)) > 0 and var_112_16 < var_112_19 then
					arg_109_1.talkMaxDuration = var_112_19

					if var_112_19 + var_112_14 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_19 + var_112_14
					end
				end
			end

			local var_112_20 = math.max(0.4, arg_109_1.talkMaxDuration)

			if var_112_14 <= arg_109_1.time_ and arg_109_1.time_ < var_112_14 + var_112_20 then
				arg_109_1.fswtw_.percent = Mathf.Lerp(arg_109_1.var_.oldValueTypewriter, var_112_17, (arg_109_1.time_ - var_112_14) / var_112_20)
				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_109_1.fswtw_:SetDirty()
			end

			if arg_109_1.time_ >= var_112_14 + var_112_20 and arg_109_1.time_ < var_112_14 + var_112_20 + arg_112_0 then
				arg_109_1.fswtw_.percent = var_112_17

				arg_109_1.fswtw_:SetDirty()
				arg_109_1:ShowNextGo(true)

				arg_109_1.typewritterCharCountI18N = var_112_18
			end

			if 2.41666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 2.41666666666667 + arg_112_0 then
				local var_112_21 = arg_109_1.fswbg_.transform:Find("textbox/adapt/content") or arg_109_1.fswbg_.transform:Find("textbox/content")
				local var_112_22 = arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_112_23 = var_112_21:GetComponent("RectTransform")

				var_112_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_112_23.offsetMin = Vector2.New(0, 0)
				var_112_23.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play1104101028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1104101028
		arg_113_1.duration_ = 7

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1104101029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.bgs_.I03 == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I03")
				var_116_0.name = "I03"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.I03 = var_116_0
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.I03

				arg_113_1.bgs_.I03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "I03" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_5 = 2

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_5 then
				local var_116_6 = Color.New(0, 0, 0)

				var_116_6.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_4) / var_116_5)
				arg_113_1.mask_.color = var_116_6
			end

			if arg_113_1.time_ >= var_116_4 + var_116_5 and arg_113_1.time_ < var_116_4 + var_116_5 + arg_116_0 then
				local var_116_7 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_7.a = 0
				arg_113_1.mask_.color = var_116_7
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.fswbg_:SetActive(false)
				arg_113_1.dialog_:SetActive(false)
				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_113_1:ShowNextGo(false)
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_8 = 2
			local var_116_9 = 0.125

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_10 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_10:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

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

				local var_116_11 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1104101028).content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 5 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 5)

				if (5 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 5)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13
					var_116_8 = var_116_8 + 0.3

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = var_116_8 + 0.3
			local var_116_15 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_15 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_14) / var_116_15

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_14 + var_116_15 and arg_113_1.time_ < var_116_14 + var_116_15 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1104101029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1104101029
		arg_119_1.duration_ = 6.03

		local var_119_0 = {
			zh = 6.033,
			ja = 3.866
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
				arg_119_0:Play1104101030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if arg_119_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_122_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_119_1.stage_.transform)

				var_122_0.name = "1038ui_story"
				var_122_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1038ui_story"] = var_122_0

				local var_122_1 = var_122_0:GetComponentInChildren(typeof(CharacterEffect))

				var_122_1.enabled = true

				local var_122_2 = GameObjectTools.GetOrAddComponent(var_122_0, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(false)
				end

				arg_119_1:ShowWeapon(var_122_1.transform, false)

				arg_119_1.var_["1038ui_story" .. "Animator"] = var_122_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_119_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_119_1.var_["1038ui_story" .. "LipSync"] = var_122_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_122_3 = arg_119_1.actors_["1038ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1038ui_story = var_122_3.localPosition
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_3.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_119_1.time_ - 0) / var_122_4)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_3.localPosition = Vector3.New(0, -1.11, -5.9)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			local var_122_5 = arg_119_1.actors_["1038ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1038ui_story == nil then
				arg_119_1.var_.characterEffect1038ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.characterEffect1038ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1038ui_story then
				arg_119_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_122_8 = 0
			local var_122_9 = 0.5

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_8 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_10 = arg_119_1:GetWordFromCfg(1104101029)
				local var_122_11 = arg_119_1:FormatText(var_122_10.content)

				arg_119_1.text_.text = var_122_11

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_13 = 20 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 20)

				if (20 <= 0 and var_122_9 or var_122_9 * (utf8.len(var_122_11) / 20)) > 0 and var_122_9 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_8
					end
				end

				arg_119_1.text_.text = var_122_11
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101029", "story_v_side_new_1104101.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101029", "story_v_side_new_1104101.awb") / 1000

					if var_122_14 + var_122_8 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_8
					end

					if var_122_10.prefab_name ~= "" and arg_119_1.actors_[var_122_10.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_10.prefab_name].transform, "story_v_side_new_1104101", "1104101029", "story_v_side_new_1104101.awb")

						arg_119_1:RecordAudio("1104101029", var_122_15)
						arg_119_1:RecordAudio("1104101029", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101029", "story_v_side_new_1104101.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101029", "story_v_side_new_1104101.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_9, arg_119_1.talkMaxDuration)

			if var_122_8 <= arg_119_1.time_ and arg_119_1.time_ < var_122_8 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_8) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_8 + var_122_16 and arg_119_1.time_ < var_122_8 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play1104101030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1104101030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1104101031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1038ui_story"]) and arg_123_1.var_.characterEffect1038ui_story == nil then
				arg_123_1.var_.characterEffect1038ui_story = arg_123_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1038ui_story"]) then
				if arg_123_1.var_.characterEffect1038ui_story and not isNil(arg_123_1.actors_["1038ui_story"]) then
					arg_123_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1038ui_story"]) and arg_123_1.var_.characterEffect1038ui_story then
				arg_123_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 0.725

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1104101030).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 29 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 29)

				if (29 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 29)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1104101031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1104101031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1104101032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.35

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1104101031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 14 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 14)

				if (14 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 14)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1104101032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1104101032
		arg_131_1.duration_ = 8.37

		local var_131_0 = {
			zh = 7.8,
			ja = 8.366
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1104101033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1038ui_story = arg_131_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1038ui_story"].transform.position).z)
				arg_131_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1038ui_story"].transform.localEulerAngles = arg_131_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_131_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1038ui_story"].transform.position).z)
				arg_131_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1038ui_story"].transform.localEulerAngles = arg_131_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1038ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1038ui_story == nil then
				arg_131_1.var_.characterEffect1038ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1038ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1038ui_story then
				arg_131_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action2_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_134_4 = 0
			local var_134_5 = 1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(1104101032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 40 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 40)

				if (40 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 40)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101032", "story_v_side_new_1104101.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101032", "story_v_side_new_1104101.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_side_new_1104101", "1104101032", "story_v_side_new_1104101.awb")

						arg_131_1:RecordAudio("1104101032", var_134_11)
						arg_131_1:RecordAudio("1104101032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101032", "story_v_side_new_1104101.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101032", "story_v_side_new_1104101.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play1104101033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1104101033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1104101034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1038ui_story"]) and arg_135_1.var_.characterEffect1038ui_story == nil then
				arg_135_1.var_.characterEffect1038ui_story = arg_135_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1038ui_story"]) then
				if arg_135_1.var_.characterEffect1038ui_story and not isNil(arg_135_1.actors_["1038ui_story"]) then
					arg_135_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1038ui_story"]) and arg_135_1.var_.characterEffect1038ui_story then
				arg_135_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_138_1 = 0
			local var_138_2 = 0.175

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_3 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(1104101033).content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 7 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 7)

				if (7 <= 0 and var_138_2 or var_138_2 * (utf8.len(var_138_3) / 7)) > 0 and var_138_2 < var_138_5 then
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
	Play1104101034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1104101034
		arg_139_1.duration_ = 7.23

		local var_139_0 = {
			zh = 4.2,
			ja = 7.233
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
				arg_139_0:Play1104101035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1038ui_story = arg_139_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1038ui_story"].transform.position).z)
				arg_139_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1038ui_story"].transform.localEulerAngles = arg_139_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_139_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1038ui_story"].transform.position).z)
				arg_139_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1038ui_story"].transform.localEulerAngles = arg_139_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1038ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1038ui_story == nil then
				arg_139_1.var_.characterEffect1038ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1038ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1038ui_story then
				arg_139_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action2_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = 0
			local var_142_5 = 0.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(1104101034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 12 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 12)

				if (12 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 12)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101034", "story_v_side_new_1104101.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101034", "story_v_side_new_1104101.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_side_new_1104101", "1104101034", "story_v_side_new_1104101.awb")

						arg_139_1:RecordAudio("1104101034", var_142_11)
						arg_139_1:RecordAudio("1104101034", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101034", "story_v_side_new_1104101.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101034", "story_v_side_new_1104101.awb")
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
				actorName = "1038ui_story",
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
	Play1104101035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1104101035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1104101036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1038ui_story"]) and arg_143_1.var_.characterEffect1038ui_story == nil then
				arg_143_1.var_.characterEffect1038ui_story = arg_143_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1038ui_story"]) then
				if arg_143_1.var_.characterEffect1038ui_story and not isNil(arg_143_1.actors_["1038ui_story"]) then
					arg_143_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1038ui_story"]) and arg_143_1.var_.characterEffect1038ui_story then
				arg_143_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.8

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(1104101035).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 32 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 32)

				if (32 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 32)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1104101036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1104101036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1104101037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_150_0 = 0
			local var_150_1 = 0.825

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1104101036).content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 33 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_2) / 33)

				if (33 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_2) / 33)) > 0 and var_150_1 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_5 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_5 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_5

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_5 and arg_147_1.time_ < var_150_0 + var_150_5 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1104101037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1104101037
		arg_151_1.duration_ = 6.4

		local var_151_0 = {
			zh = 2.533,
			ja = 6.4
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
				arg_151_0:Play1104101038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1038ui_story = arg_151_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1038ui_story"].transform.position).z)
				arg_151_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1038ui_story"].transform.localEulerAngles = arg_151_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_151_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1038ui_story"].transform.position).z)
				arg_151_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1038ui_story"].transform.localEulerAngles = arg_151_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1038ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1038ui_story == nil then
				arg_151_1.var_.characterEffect1038ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1038ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1038ui_story then
				arg_151_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_154_4 = 0
			local var_154_5 = 0.3

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(1104101037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 12 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 12)

				if (12 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 12)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101037", "story_v_side_new_1104101.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101037", "story_v_side_new_1104101.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_side_new_1104101", "1104101037", "story_v_side_new_1104101.awb")

						arg_151_1:RecordAudio("1104101037", var_154_11)
						arg_151_1:RecordAudio("1104101037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101037", "story_v_side_new_1104101.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101037", "story_v_side_new_1104101.awb")
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

		arg_151_1.nodeConfigList_ = {
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

		arg_151_1:InitPlayNodeList()
	end,
	Play1104101038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1104101038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1104101039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1038ui_story"]) and arg_155_1.var_.characterEffect1038ui_story == nil then
				arg_155_1.var_.characterEffect1038ui_story = arg_155_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1038ui_story"]) then
				if arg_155_1.var_.characterEffect1038ui_story and not isNil(arg_155_1.actors_["1038ui_story"]) then
					arg_155_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_155_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1038ui_story"]) and arg_155_1.var_.characterEffect1038ui_story then
				arg_155_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_155_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_158_1 = 0
			local var_158_2 = 0.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(1104101038).content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 6 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 6)

				if (6 <= 0 and var_158_2 or var_158_2 * (utf8.len(var_158_3) / 6)) > 0 and var_158_2 < var_158_5 then
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
	Play1104101039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1104101039
		arg_159_1.duration_ = 7.43

		local var_159_0 = {
			zh = 7.433,
			ja = 6.666
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
				arg_159_0:Play1104101040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1038ui_story = arg_159_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1038ui_story"].transform.position).z)
				arg_159_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1038ui_story"].transform.localEulerAngles = arg_159_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_159_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1038ui_story"].transform.position).z)
				arg_159_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1038ui_story"].transform.localEulerAngles = arg_159_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1038ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1038ui_story == nil then
				arg_159_1.var_.characterEffect1038ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1038ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1038ui_story then
				arg_159_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_162_4 = 0
			local var_162_5 = 0.9

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(1104101039)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 36 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 36)

				if (36 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 36)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101039", "story_v_side_new_1104101.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101039", "story_v_side_new_1104101.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_side_new_1104101", "1104101039", "story_v_side_new_1104101.awb")

						arg_159_1:RecordAudio("1104101039", var_162_11)
						arg_159_1:RecordAudio("1104101039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101039", "story_v_side_new_1104101.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101039", "story_v_side_new_1104101.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play1104101040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1104101040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1104101041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1038ui_story"]) and arg_163_1.var_.characterEffect1038ui_story == nil then
				arg_163_1.var_.characterEffect1038ui_story = arg_163_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1038ui_story"]) then
				if arg_163_1.var_.characterEffect1038ui_story and not isNil(arg_163_1.actors_["1038ui_story"]) then
					arg_163_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1038ui_story"]) and arg_163_1.var_.characterEffect1038ui_story then
				arg_163_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.875

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_3 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(1104101040).content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 35 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 35)

				if (35 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_3) / 35)) > 0 and var_166_2 < var_166_5 then
					arg_163_1.talkMaxDuration = var_166_5

					if var_166_5 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_6 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_6 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_6

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_6 and arg_163_1.time_ < var_166_1 + var_166_6 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1104101041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1104101041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1104101042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.975

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1104101041).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 39 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 39)

				if (39 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 39)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1104101042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1104101042
		arg_171_1.duration_ = 6

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1104101043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1038ui_story = arg_171_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1038ui_story"].transform.position).z)
				arg_171_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1038ui_story"].transform.localEulerAngles = arg_171_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_171_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["1038ui_story"].transform.position).z)
				arg_171_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["1038ui_story"].transform.localEulerAngles = arg_171_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["1038ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1038ui_story == nil then
				arg_171_1.var_.characterEffect1038ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect1038ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect1038ui_story then
				arg_171_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_174_4 = 0
			local var_174_5 = 0.675

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(1104101042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 27 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 27)

				if (27 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 27)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101042", "story_v_side_new_1104101.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101042", "story_v_side_new_1104101.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_side_new_1104101", "1104101042", "story_v_side_new_1104101.awb")

						arg_171_1:RecordAudio("1104101042", var_174_11)
						arg_171_1:RecordAudio("1104101042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101042", "story_v_side_new_1104101.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101042", "story_v_side_new_1104101.awb")
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
				actorName = "1038ui_story",
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
	Play1104101043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1104101043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1104101044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1038ui_story"]) and arg_175_1.var_.characterEffect1038ui_story == nil then
				arg_175_1.var_.characterEffect1038ui_story = arg_175_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1038ui_story"]) then
				if arg_175_1.var_.characterEffect1038ui_story and not isNil(arg_175_1.actors_["1038ui_story"]) then
					arg_175_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1038ui_story"]) and arg_175_1.var_.characterEffect1038ui_story then
				arg_175_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0
			local var_178_2 = 0.325

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1104101043).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 13 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 13)

				if (13 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 13)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1104101044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1104101044
		arg_179_1.duration_ = 17.6

		local var_179_0 = {
			zh = 17.6,
			ja = 14.566
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
				arg_179_0:Play1104101045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1038ui_story = arg_179_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1038ui_story"].transform.position).z)
				arg_179_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1038ui_story"].transform.localEulerAngles = arg_179_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_179_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1038ui_story"].transform.position).z)
				arg_179_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1038ui_story"].transform.localEulerAngles = arg_179_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1038ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1038ui_story == nil then
				arg_179_1.var_.characterEffect1038ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1038ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1038ui_story then
				arg_179_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_2")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_182_4 = 0
			local var_182_5 = 1.8

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_4 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:GetWordFromCfg(1104101044)
				local var_182_7 = arg_179_1:FormatText(var_182_6.content)

				arg_179_1.text_.text = var_182_7

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_9 = 72 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 72)

				if (72 <= 0 and var_182_5 or var_182_5 * (utf8.len(var_182_7) / 72)) > 0 and var_182_5 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_4
					end
				end

				arg_179_1.text_.text = var_182_7
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101044", "story_v_side_new_1104101.awb") ~= 0 then
					local var_182_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101044", "story_v_side_new_1104101.awb") / 1000

					if var_182_10 + var_182_4 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_4
					end

					if var_182_6.prefab_name ~= "" and arg_179_1.actors_[var_182_6.prefab_name] ~= nil then
						local var_182_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_6.prefab_name].transform, "story_v_side_new_1104101", "1104101044", "story_v_side_new_1104101.awb")

						arg_179_1:RecordAudio("1104101044", var_182_11)
						arg_179_1:RecordAudio("1104101044", var_182_11)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101044", "story_v_side_new_1104101.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101044", "story_v_side_new_1104101.awb")
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

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play1104101045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1104101045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1104101046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1038ui_story"]) and arg_183_1.var_.characterEffect1038ui_story == nil then
				arg_183_1.var_.characterEffect1038ui_story = arg_183_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1038ui_story"]) then
				if arg_183_1.var_.characterEffect1038ui_story and not isNil(arg_183_1.actors_["1038ui_story"]) then
					arg_183_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1038ui_story"]) and arg_183_1.var_.characterEffect1038ui_story then
				arg_183_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_186_1 = 0
			local var_186_2 = 0.175

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(1104101045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 7 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 7)

				if (7 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 7)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1104101046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1104101046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1104101047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.7

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1104101046).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 28 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 28)

				if (28 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 28)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1104101047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1104101047
		arg_191_1.duration_ = 13.13

		local var_191_0 = {
			zh = 11.8,
			ja = 13.133
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
				arg_191_0:Play1104101048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1038ui_story = arg_191_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1038ui_story"].transform.position).z)
				arg_191_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1038ui_story"].transform.localEulerAngles = arg_191_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_191_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1038ui_story"].transform.position).z)
				arg_191_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1038ui_story"].transform.localEulerAngles = arg_191_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1038ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1038ui_story == nil then
				arg_191_1.var_.characterEffect1038ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1038ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1038ui_story then
				arg_191_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_4 = 0
			local var_194_5 = 1.15

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(1104101047)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 46 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 46)

				if (46 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 46)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101047", "story_v_side_new_1104101.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101047", "story_v_side_new_1104101.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_side_new_1104101", "1104101047", "story_v_side_new_1104101.awb")

						arg_191_1:RecordAudio("1104101047", var_194_11)
						arg_191_1:RecordAudio("1104101047", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101047", "story_v_side_new_1104101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101047", "story_v_side_new_1104101.awb")
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
				actorName = "1038ui_story",
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
	Play1104101048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1104101048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1104101049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1038ui_story"]) and arg_195_1.var_.characterEffect1038ui_story == nil then
				arg_195_1.var_.characterEffect1038ui_story = arg_195_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1038ui_story"]) then
				if arg_195_1.var_.characterEffect1038ui_story and not isNil(arg_195_1.actors_["1038ui_story"]) then
					arg_195_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1038ui_story"]) and arg_195_1.var_.characterEffect1038ui_story then
				arg_195_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.45

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1104101048).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 18 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 18)

				if (18 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 18)) > 0 and var_198_2 < var_198_5 then
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
	Play1104101049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1104101049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1104101050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.075

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(1104101049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 3 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 3)

				if (3 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 3)) > 0 and var_202_0 < var_202_3 then
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
	Play1104101050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1104101050
		arg_203_1.duration_ = 6.77

		local var_203_0 = {
			zh = 4.866,
			ja = 6.766
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
				arg_203_0:Play1104101051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1038ui_story = arg_203_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1038ui_story"].transform.position).z)
				arg_203_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1038ui_story"].transform.localEulerAngles = arg_203_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_203_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1038ui_story"].transform.position).z)
				arg_203_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1038ui_story"].transform.localEulerAngles = arg_203_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1038ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1038ui_story == nil then
				arg_203_1.var_.characterEffect1038ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1038ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1038ui_story then
				arg_203_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_2")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_4 = 0
			local var_206_5 = 0.6

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_6 = arg_203_1:GetWordFromCfg(1104101050)
				local var_206_7 = arg_203_1:FormatText(var_206_6.content)

				arg_203_1.text_.text = var_206_7

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 24 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 24)

				if (24 <= 0 and var_206_5 or var_206_5 * (utf8.len(var_206_7) / 24)) > 0 and var_206_5 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_7
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101050", "story_v_side_new_1104101.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101050", "story_v_side_new_1104101.awb") / 1000

					if var_206_10 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_4
					end

					if var_206_6.prefab_name ~= "" and arg_203_1.actors_[var_206_6.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_6.prefab_name].transform, "story_v_side_new_1104101", "1104101050", "story_v_side_new_1104101.awb")

						arg_203_1:RecordAudio("1104101050", var_206_11)
						arg_203_1:RecordAudio("1104101050", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101050", "story_v_side_new_1104101.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101050", "story_v_side_new_1104101.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_12 and arg_203_1.time_ < var_206_4 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
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

		arg_203_1:InitPlayNodeList()
	end,
	Play1104101051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1104101051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1104101052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1038ui_story"]) and arg_207_1.var_.characterEffect1038ui_story == nil then
				arg_207_1.var_.characterEffect1038ui_story = arg_207_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1038ui_story"]) then
				if arg_207_1.var_.characterEffect1038ui_story and not isNil(arg_207_1.actors_["1038ui_story"]) then
					arg_207_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1038ui_story"]) and arg_207_1.var_.characterEffect1038ui_story then
				arg_207_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_210_1 = 0
			local var_210_2 = 1.225

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_3 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1104101051).content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 49 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 49)

				if (49 <= 0 and var_210_2 or var_210_2 * (utf8.len(var_210_3) / 49)) > 0 and var_210_2 < var_210_5 then
					arg_207_1.talkMaxDuration = var_210_5

					if var_210_5 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_5 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_6 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_6 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_6

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_6 and arg_207_1.time_ < var_210_1 + var_210_6 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1104101052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1104101052
		arg_211_1.duration_ = 16.37

		local var_211_0 = {
			zh = 16.366,
			ja = 15.933
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
				arg_211_0:Play1104101053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1038ui_story = arg_211_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1038ui_story"].transform.position).z)
				arg_211_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1038ui_story"].transform.localEulerAngles = arg_211_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_211_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1038ui_story"].transform.position).z)
				arg_211_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1038ui_story"].transform.localEulerAngles = arg_211_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1038ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1038ui_story == nil then
				arg_211_1.var_.characterEffect1038ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1038ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1038ui_story then
				arg_211_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_214_4 = 0
			local var_214_5 = 1.7

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(1104101052)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 68 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 68)

				if (68 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 68)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101052", "story_v_side_new_1104101.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101052", "story_v_side_new_1104101.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_side_new_1104101", "1104101052", "story_v_side_new_1104101.awb")

						arg_211_1:RecordAudio("1104101052", var_214_11)
						arg_211_1:RecordAudio("1104101052", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101052", "story_v_side_new_1104101.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101052", "story_v_side_new_1104101.awb")
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

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play1104101053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1104101053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1104101054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1038ui_story"]) and arg_215_1.var_.characterEffect1038ui_story == nil then
				arg_215_1.var_.characterEffect1038ui_story = arg_215_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1038ui_story"]) then
				if arg_215_1.var_.characterEffect1038ui_story and not isNil(arg_215_1.actors_["1038ui_story"]) then
					arg_215_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1038ui_story"]) and arg_215_1.var_.characterEffect1038ui_story then
				arg_215_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.775

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
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

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1104101053).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 31 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 31)

				if (31 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 31)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1104101054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1104101054
		arg_219_1.duration_ = 9

		local var_219_0 = {
			zh = 9,
			ja = 6.6
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
				arg_219_0:Play1104101055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1038ui_story = arg_219_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1038ui_story"].transform.position).z)
				arg_219_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1038ui_story"].transform.localEulerAngles = arg_219_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_219_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1038ui_story"].transform.position).z)
				arg_219_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1038ui_story"].transform.localEulerAngles = arg_219_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1038ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1038ui_story == nil then
				arg_219_1.var_.characterEffect1038ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect1038ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect1038ui_story then
				arg_219_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_222_4 = 0
			local var_222_5 = 0.925

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(1104101054)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_9 = 37 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 37)

				if (37 <= 0 and var_222_5 or var_222_5 * (utf8.len(var_222_7) / 37)) > 0 and var_222_5 < var_222_9 then
					arg_219_1.talkMaxDuration = var_222_9

					if var_222_9 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_9 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101054", "story_v_side_new_1104101.awb") ~= 0 then
					local var_222_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101054", "story_v_side_new_1104101.awb") / 1000

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end

					if var_222_6.prefab_name ~= "" and arg_219_1.actors_[var_222_6.prefab_name] ~= nil then
						local var_222_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_6.prefab_name].transform, "story_v_side_new_1104101", "1104101054", "story_v_side_new_1104101.awb")

						arg_219_1:RecordAudio("1104101054", var_222_11)
						arg_219_1:RecordAudio("1104101054", var_222_11)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101054", "story_v_side_new_1104101.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101054", "story_v_side_new_1104101.awb")
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
				actorName = "1038ui_story",
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
	Play1104101055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1104101055
		arg_223_1.duration_ = 8.6

		local var_223_0 = {
			zh = 8.6,
			ja = 8.066
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
				arg_223_0:Play1104101056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1038ui_story = arg_223_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1038ui_story"].transform.position).z)
				arg_223_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1038ui_story"].transform.localEulerAngles = arg_223_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_223_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["1038ui_story"].transform.position).z)
				arg_223_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["1038ui_story"].transform.localEulerAngles = arg_223_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_2")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_1 = 0
			local var_226_2 = 1.075

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:GetWordFromCfg(1104101055)
				local var_226_4 = arg_223_1:FormatText(var_226_3.content)

				arg_223_1.text_.text = var_226_4

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_6 = 43 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_4) / 43)

				if (43 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_4) / 43)) > 0 and var_226_2 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_4
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101055", "story_v_side_new_1104101.awb") ~= 0 then
					local var_226_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101055", "story_v_side_new_1104101.awb") / 1000

					if var_226_7 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_1
					end

					if var_226_3.prefab_name ~= "" and arg_223_1.actors_[var_226_3.prefab_name] ~= nil then
						local var_226_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_3.prefab_name].transform, "story_v_side_new_1104101", "1104101055", "story_v_side_new_1104101.awb")

						arg_223_1:RecordAudio("1104101055", var_226_8)
						arg_223_1:RecordAudio("1104101055", var_226_8)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101055", "story_v_side_new_1104101.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101055", "story_v_side_new_1104101.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_9 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_9 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_9

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_9 and arg_223_1.time_ < var_226_1 + var_226_9 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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

		arg_223_1:InitPlayNodeList()
	end,
	Play1104101056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1104101056
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1104101057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1038ui_story"]) and arg_227_1.var_.characterEffect1038ui_story == nil then
				arg_227_1.var_.characterEffect1038ui_story = arg_227_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1038ui_story"]) then
				if arg_227_1.var_.characterEffect1038ui_story and not isNil(arg_227_1.actors_["1038ui_story"]) then
					arg_227_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1038ui_story"]) and arg_227_1.var_.characterEffect1038ui_story then
				arg_227_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_230_1 = 0
			local var_230_2 = 0.05

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_3 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1104101056).content)

				arg_227_1.text_.text = var_230_3

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 2 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 2)

				if (2 <= 0 and var_230_2 or var_230_2 * (utf8.len(var_230_3) / 2)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_1 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_1
					end
				end

				arg_227_1.text_.text = var_230_3
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_6 = math.max(var_230_2, arg_227_1.talkMaxDuration)

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_6 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_1) / var_230_6

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_1 + var_230_6 and arg_227_1.time_ < var_230_1 + var_230_6 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1104101057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1104101057
		arg_231_1.duration_ = 8.03

		local var_231_0 = {
			zh = 7.666,
			ja = 8.033
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
				arg_231_0:Play1104101058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1038ui_story = arg_231_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1038ui_story"].transform.position).z)
				arg_231_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1038ui_story"].transform.localEulerAngles = arg_231_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_231_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1038ui_story"].transform.position).z)
				arg_231_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1038ui_story"].transform.localEulerAngles = arg_231_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1038ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1038ui_story == nil then
				arg_231_1.var_.characterEffect1038ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1038ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1038ui_story then
				arg_231_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_4 = 0
			local var_234_5 = 0.9

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(1104101057)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 36 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 36)

				if (36 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 36)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101057", "story_v_side_new_1104101.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101057", "story_v_side_new_1104101.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_side_new_1104101", "1104101057", "story_v_side_new_1104101.awb")

						arg_231_1:RecordAudio("1104101057", var_234_11)
						arg_231_1:RecordAudio("1104101057", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101057", "story_v_side_new_1104101.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101057", "story_v_side_new_1104101.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play1104101058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1104101058
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1104101059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1038ui_story"]) and arg_235_1.var_.characterEffect1038ui_story == nil then
				arg_235_1.var_.characterEffect1038ui_story = arg_235_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1038ui_story"]) then
				if arg_235_1.var_.characterEffect1038ui_story and not isNil(arg_235_1.actors_["1038ui_story"]) then
					arg_235_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1038ui_story"]) and arg_235_1.var_.characterEffect1038ui_story then
				arg_235_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.15

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(1104101058).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 6 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 6)

				if (6 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 6)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1104101059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1104101059
		arg_239_1.duration_ = 11.53

		local var_239_0 = {
			zh = 11.533,
			ja = 8.7
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
				arg_239_0:Play1104101060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1038ui_story = arg_239_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1038ui_story, Vector3.New(0, -1.11, -5.9), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1038ui_story"].transform.position).z)
				arg_239_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1038ui_story"].transform.localEulerAngles = arg_239_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_239_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1038ui_story"].transform.position).z)
				arg_239_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1038ui_story"].transform.localEulerAngles = arg_239_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1038ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1038ui_story == nil then
				arg_239_1.var_.characterEffect1038ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1038ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1038ui_story then
				arg_239_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_242_4 = 0
			local var_242_5 = 1.2

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(1104101059)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 48 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 48)

				if (48 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 48)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101059", "story_v_side_new_1104101.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101059", "story_v_side_new_1104101.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_side_new_1104101", "1104101059", "story_v_side_new_1104101.awb")

						arg_239_1:RecordAudio("1104101059", var_242_11)
						arg_239_1:RecordAudio("1104101059", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101059", "story_v_side_new_1104101.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101059", "story_v_side_new_1104101.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play1104101060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1104101060
		arg_243_1.duration_ = 6.67

		local var_243_0 = {
			zh = 6.666,
			ja = 5.3
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
				arg_243_0:Play1104101061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.55

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_1 = arg_243_1:GetWordFromCfg(1104101060)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 22 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 22)

				if (22 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 22)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101060", "story_v_side_new_1104101.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101060", "story_v_side_new_1104101.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_side_new_1104101", "1104101060", "story_v_side_new_1104101.awb")

						arg_243_1:RecordAudio("1104101060", var_246_6)
						arg_243_1:RecordAudio("1104101060", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101060", "story_v_side_new_1104101.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101060", "story_v_side_new_1104101.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1104101061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1104101061
		arg_247_1.duration_ = 9

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1104101062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if arg_247_1.bgs_.ST22 == nil then
				local var_250_0 = Object.Instantiate(arg_247_1.paintGo_)

				var_250_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_250_0.name = "ST22"
				var_250_0.transform.parent = arg_247_1.stage_.transform
				var_250_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_247_1.bgs_.ST22 = var_250_0
			end

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 then
				local var_250_1 = arg_247_1.bgs_.ST22

				arg_247_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_250_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_250_2 = var_250_1:GetComponent("SpriteRenderer")

				if var_250_2 and var_250_2.sprite then
					local var_250_3 = 2 * (var_250_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_250_1.transform.localScale = Vector3.New(var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, var_250_3 / var_250_2.sprite.bounds.size.y < var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x and var_250_3 * manager.ui.mainCameraCom_.aspect / var_250_2.sprite.bounds.size.x or var_250_3 / var_250_2.sprite.bounds.size.y, 0)
				end

				for iter_250_0, iter_250_1 in pairs(arg_247_1.bgs_) do
					if iter_250_0 ~= "ST22" then
						iter_250_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_250_4 = 0

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_5 = 2

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_5 then
				local var_250_6 = Color.New(0, 0, 0)

				var_250_6.a = Mathf.Lerp(0, 1, (arg_247_1.time_ - var_250_4) / var_250_5)
				arg_247_1.mask_.color = var_250_6
			end

			if arg_247_1.time_ >= var_250_4 + var_250_5 and arg_247_1.time_ < var_250_4 + var_250_5 + arg_250_0 then
				local var_250_7 = Color.New(0, 0, 0)

				var_250_7.a = 1
				arg_247_1.mask_.color = var_250_7
			end

			local var_250_8 = 2

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.mask_.enabled = true
				arg_247_1.mask_.raycastTarget = true

				arg_247_1:SetGaussion(false)
			end

			local var_250_9 = 2

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_9 then
				local var_250_10 = Color.New(0, 0, 0)

				var_250_10.a = Mathf.Lerp(1, 0, (arg_247_1.time_ - var_250_8) / var_250_9)
				arg_247_1.mask_.color = var_250_10
			end

			if arg_247_1.time_ >= var_250_8 + var_250_9 and arg_247_1.time_ < var_250_8 + var_250_9 + arg_250_0 then
				local var_250_11 = Color.New(0, 0, 0)

				arg_247_1.mask_.enabled = false
				var_250_11.a = 0
				arg_247_1.mask_.color = var_250_11
			end

			local var_250_12 = arg_247_1.actors_["1038ui_story"].transform

			if 2 < arg_247_1.time_ and arg_247_1.time_ <= 2 + arg_250_0 then
				arg_247_1.var_.moveOldPos1038ui_story = var_250_12.localPosition
			end

			local var_250_13 = 0.001

			if 2 <= arg_247_1.time_ and arg_247_1.time_ < 2 + var_250_13 then
				var_250_12.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_247_1.time_ - 2) / var_250_13)
				var_250_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_12.position).x, (manager.ui.mainCamera.transform.position - var_250_12.position).y, (manager.ui.mainCamera.transform.position - var_250_12.position).z)
				var_250_12.localEulerAngles.z = 0
				var_250_12.localEulerAngles.x = 0
				var_250_12.localEulerAngles = var_250_12.localEulerAngles
			end

			if arg_247_1.time_ >= 2 + var_250_13 and arg_247_1.time_ < 2 + var_250_13 + arg_250_0 then
				var_250_12.localPosition = Vector3.New(0, 100, 0)
				var_250_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_250_12.position).x, (manager.ui.mainCamera.transform.position - var_250_12.position).y, (manager.ui.mainCamera.transform.position - var_250_12.position).z)
				var_250_12.localEulerAngles.z = 0
				var_250_12.localEulerAngles.x = 0
				var_250_12.localEulerAngles = var_250_12.localEulerAngles
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_14 = 4
			local var_250_15 = 1.325

			if 4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_16 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_16:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_17 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(1104101061).content)

				arg_247_1.text_.text = var_250_17

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_19 = 53 <= 0 and var_250_15 or var_250_15 * (utf8.len(var_250_17) / 53)

				if (53 <= 0 and var_250_15 or var_250_15 * (utf8.len(var_250_17) / 53)) > 0 and var_250_15 < var_250_19 then
					arg_247_1.talkMaxDuration = var_250_19
					var_250_14 = var_250_14 + 0.3

					if var_250_19 + var_250_14 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_19 + var_250_14
					end
				end

				arg_247_1.text_.text = var_250_17
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_20 = var_250_14 + 0.3
			local var_250_21 = math.max(var_250_15, arg_247_1.talkMaxDuration)

			if var_250_14 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_20 + var_250_21 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_20) / var_250_21

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_20 + var_250_21 and arg_247_1.time_ < var_250_20 + var_250_21 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play1104101062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1104101062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1104101063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.4

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(1104101062).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 56 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 56)

				if (56 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 56)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play1104101063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1104101063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1104101064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.9

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(1104101063).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 36 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 36)

				if (36 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 36)) > 0 and var_260_0 < var_260_3 then
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
	Play1104101064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1104101064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1104101065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.725

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(1104101064).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 29 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 29)

				if (29 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 29)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1104101065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1104101065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1104101066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.875

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(1104101065).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 35 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 35)

				if (35 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 35)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1104101066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1104101066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1104101067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.7

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(1104101066).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 28 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 28)

				if (28 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 28)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1104101067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1104101067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1104101068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.775

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(1104101067).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 31 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 31)

				if (31 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 31)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1104101068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1104101068
		arg_277_1.duration_ = 11.13

		local var_277_0 = {
			zh = 8.3,
			ja = 11.133
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
				arg_277_0:Play1104101069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[209].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2050")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(1104101068)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 40 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 40)

				if (40 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 40)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101068", "story_v_side_new_1104101.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101068", "story_v_side_new_1104101.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_side_new_1104101", "1104101068", "story_v_side_new_1104101.awb")

						arg_277_1:RecordAudio("1104101068", var_280_6)
						arg_277_1:RecordAudio("1104101068", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101068", "story_v_side_new_1104101.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101068", "story_v_side_new_1104101.awb")
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
	Play1104101069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1104101069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1104101070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.35

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(1104101069).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 14 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 14)

				if (14 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 14)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play1104101070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1104101070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1104101071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.9

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(1104101070).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 36 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 36)

				if (36 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 36)) > 0 and var_288_0 < var_288_3 then
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
	Play1104101071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1104101071
		arg_289_1.duration_ = 2.43

		local var_289_0 = {
			zh = 2.433,
			ja = 1.266
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
				arg_289_0:Play1104101072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.45

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(1104101071)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 18 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 18)

				if (18 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 18)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101071", "story_v_side_new_1104101.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101071", "story_v_side_new_1104101.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_side_new_1104101", "1104101071", "story_v_side_new_1104101.awb")

						arg_289_1:RecordAudio("1104101071", var_292_6)
						arg_289_1:RecordAudio("1104101071", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101071", "story_v_side_new_1104101.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101071", "story_v_side_new_1104101.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1104101072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1104101072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1104101073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.075

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(1104101072).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 43 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 43)

				if (43 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 43)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1104101073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1104101073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1104101074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.25

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(1104101073).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 10 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 10)

				if (10 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 10)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1104101074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1104101074
		arg_301_1.duration_ = 7.9

		local var_301_0 = {
			zh = 6.366,
			ja = 7.9
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1104101075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1041ui_story = arg_301_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1041ui_story"].transform.position).z)
				arg_301_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1041ui_story"].transform.localEulerAngles = arg_301_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_301_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1041ui_story"].transform.position).z)
				arg_301_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1041ui_story"].transform.localEulerAngles = arg_301_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1041ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1041ui_story == nil then
				arg_301_1.var_.characterEffect1041ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1041ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1041ui_story then
				arg_301_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_4 = 0
			local var_304_5 = 0.9

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(1104101074)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 36 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 36)

				if (36 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 36)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101074", "story_v_side_new_1104101.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101074", "story_v_side_new_1104101.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_side_new_1104101", "1104101074", "story_v_side_new_1104101.awb")

						arg_301_1:RecordAudio("1104101074", var_304_11)
						arg_301_1:RecordAudio("1104101074", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101074", "story_v_side_new_1104101.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101074", "story_v_side_new_1104101.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play1104101075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1104101075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1104101076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1041ui_story"]) and arg_305_1.var_.characterEffect1041ui_story == nil then
				arg_305_1.var_.characterEffect1041ui_story = arg_305_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1041ui_story"]) then
				if arg_305_1.var_.characterEffect1041ui_story and not isNil(arg_305_1.actors_["1041ui_story"]) then
					arg_305_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1041ui_story"]) and arg_305_1.var_.characterEffect1041ui_story then
				arg_305_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.45

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(1104101075).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 18 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 18)

				if (18 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 18)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1104101076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1104101076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1104101077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.225

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(1104101076).content)

				arg_309_1.text_.text = var_312_1

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_3 = 9 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 9)

				if (9 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_1) / 9)) > 0 and var_312_0 < var_312_3 then
					arg_309_1.talkMaxDuration = var_312_3

					if var_312_3 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_3 + 0
					end
				end

				arg_309_1.text_.text = var_312_1
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_4 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_4 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_4

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_4 and arg_309_1.time_ < 0 + var_312_4 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1104101077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1104101077
		arg_313_1.duration_ = 5.17

		local var_313_0 = {
			zh = 4.733,
			ja = 5.166
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
				arg_313_0:Play1104101078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1041ui_story = arg_313_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1041ui_story"].transform.position).z)
				arg_313_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1041ui_story"].transform.localEulerAngles = arg_313_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_313_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1041ui_story"].transform.position).z)
				arg_313_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1041ui_story"].transform.localEulerAngles = arg_313_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["1041ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1041ui_story == nil then
				arg_313_1.var_.characterEffect1041ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect1041ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect1041ui_story then
				arg_313_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_316_4 = 0
			local var_316_5 = 0.85

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(1104101077)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 34 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 34)

				if (34 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 34)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101077", "story_v_side_new_1104101.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101077", "story_v_side_new_1104101.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_new_1104101", "1104101077", "story_v_side_new_1104101.awb")

						arg_313_1:RecordAudio("1104101077", var_316_11)
						arg_313_1:RecordAudio("1104101077", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101077", "story_v_side_new_1104101.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101077", "story_v_side_new_1104101.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_12 = math.max(var_316_5, arg_313_1.talkMaxDuration)

			if var_316_4 <= arg_313_1.time_ and arg_313_1.time_ < var_316_4 + var_316_12 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_4) / var_316_12

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_4 + var_316_12 and arg_313_1.time_ < var_316_4 + var_316_12 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play1104101078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1104101078
		arg_317_1.duration_ = 10.67

		local var_317_0 = {
			zh = 10.666,
			ja = 6.6
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
				arg_317_0:Play1104101079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_320_0 = 0
			local var_320_1 = 1.425

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(1104101078)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 57 <= 0 and var_320_1 or var_320_1 * (utf8.len(var_320_3) / 57)

				if (57 <= 0 and var_320_1 or var_320_1 * (utf8.len(var_320_3) / 57)) > 0 and var_320_1 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101078", "story_v_side_new_1104101.awb") ~= 0 then
					local var_320_6 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101078", "story_v_side_new_1104101.awb") / 1000

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end

					if var_320_2.prefab_name ~= "" and arg_317_1.actors_[var_320_2.prefab_name] ~= nil then
						local var_320_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_2.prefab_name].transform, "story_v_side_new_1104101", "1104101078", "story_v_side_new_1104101.awb")

						arg_317_1:RecordAudio("1104101078", var_320_7)
						arg_317_1:RecordAudio("1104101078", var_320_7)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101078", "story_v_side_new_1104101.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101078", "story_v_side_new_1104101.awb")
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
	Play1104101079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1104101079
		arg_321_1.duration_ = 5.23

		local var_321_0 = {
			zh = 3.6,
			ja = 5.233
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1104101080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_324_0 = 0
			local var_324_1 = 0.375

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_2 = arg_321_1:GetWordFromCfg(1104101079)
				local var_324_3 = arg_321_1:FormatText(var_324_2.content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 15 <= 0 and var_324_1 or var_324_1 * (utf8.len(var_324_3) / 15)

				if (15 <= 0 and var_324_1 or var_324_1 * (utf8.len(var_324_3) / 15)) > 0 and var_324_1 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101079", "story_v_side_new_1104101.awb") ~= 0 then
					local var_324_6 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101079", "story_v_side_new_1104101.awb") / 1000

					if var_324_6 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_6 + var_324_0
					end

					if var_324_2.prefab_name ~= "" and arg_321_1.actors_[var_324_2.prefab_name] ~= nil then
						local var_324_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_2.prefab_name].transform, "story_v_side_new_1104101", "1104101079", "story_v_side_new_1104101.awb")

						arg_321_1:RecordAudio("1104101079", var_324_7)
						arg_321_1:RecordAudio("1104101079", var_324_7)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101079", "story_v_side_new_1104101.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101079", "story_v_side_new_1104101.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_8 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_8 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_8

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_8 and arg_321_1.time_ < var_324_0 + var_324_8 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1104101080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1104101080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1104101081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["1041ui_story"]) and arg_325_1.var_.characterEffect1041ui_story == nil then
				arg_325_1.var_.characterEffect1041ui_story = arg_325_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["1041ui_story"]) then
				if arg_325_1.var_.characterEffect1041ui_story and not isNil(arg_325_1.actors_["1041ui_story"]) then
					arg_325_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_0)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["1041ui_story"]) and arg_325_1.var_.characterEffect1041ui_story then
				arg_325_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_328_1 = 0
			local var_328_2 = 0.475

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(1104101080).content)

				arg_325_1.text_.text = var_328_3

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 19 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 19)

				if (19 <= 0 and var_328_2 or var_328_2 * (utf8.len(var_328_3) / 19)) > 0 and var_328_2 < var_328_5 then
					arg_325_1.talkMaxDuration = var_328_5

					if var_328_5 + var_328_1 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + var_328_1
					end
				end

				arg_325_1.text_.text = var_328_3
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_6 = math.max(var_328_2, arg_325_1.talkMaxDuration)

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_6 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_1) / var_328_6

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_1 + var_328_6 and arg_325_1.time_ < var_328_1 + var_328_6 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1104101081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1104101081
		arg_329_1.duration_ = 2.77

		local var_329_0 = {
			zh = 2.766,
			ja = 2.7
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1104101082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1041ui_story = arg_329_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1041ui_story"].transform.position).z)
				arg_329_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1041ui_story"].transform.localEulerAngles = arg_329_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_329_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1041ui_story"].transform.position).z)
				arg_329_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1041ui_story"].transform.localEulerAngles = arg_329_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1041ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1041ui_story == nil then
				arg_329_1.var_.characterEffect1041ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1041ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1041ui_story then
				arg_329_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_2")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_332_4 = 0
			local var_332_5 = 0.525

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(1104101081)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 21 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 21)

				if (21 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 21)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101081", "story_v_side_new_1104101.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101081", "story_v_side_new_1104101.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_side_new_1104101", "1104101081", "story_v_side_new_1104101.awb")

						arg_329_1:RecordAudio("1104101081", var_332_11)
						arg_329_1:RecordAudio("1104101081", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101081", "story_v_side_new_1104101.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101081", "story_v_side_new_1104101.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play1104101082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1104101082
		arg_333_1.duration_ = 10.37

		local var_333_0 = {
			zh = 10.366,
			ja = 7.7
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
				arg_333_0:Play1104101083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 1.475

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:GetWordFromCfg(1104101082)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 59 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 59)

				if (59 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 59)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101082", "story_v_side_new_1104101.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101082", "story_v_side_new_1104101.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_side_new_1104101", "1104101082", "story_v_side_new_1104101.awb")

						arg_333_1:RecordAudio("1104101082", var_336_6)
						arg_333_1:RecordAudio("1104101082", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101082", "story_v_side_new_1104101.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101082", "story_v_side_new_1104101.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1104101083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1104101083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1104101084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1041ui_story"]) and arg_337_1.var_.characterEffect1041ui_story == nil then
				arg_337_1.var_.characterEffect1041ui_story = arg_337_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1041ui_story"]) then
				if arg_337_1.var_.characterEffect1041ui_story and not isNil(arg_337_1.actors_["1041ui_story"]) then
					arg_337_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1041ui_story"]) and arg_337_1.var_.characterEffect1041ui_story then
				arg_337_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.975

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1104101083).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 39 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 39)

				if (39 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 39)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1104101084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1104101084
		arg_341_1.duration_ = 5.1

		local var_341_0 = {
			zh = 3.133,
			ja = 5.1
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
				arg_341_0:Play1104101085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1041ui_story = arg_341_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1041ui_story"].transform.position).z)
				arg_341_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1041ui_story"].transform.localEulerAngles = arg_341_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_341_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1041ui_story"].transform.position).z)
				arg_341_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1041ui_story"].transform.localEulerAngles = arg_341_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1041ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1041ui_story == nil then
				arg_341_1.var_.characterEffect1041ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1041ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1041ui_story then
				arg_341_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_344_4 = 0
			local var_344_5 = 0.65

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(1104101084)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 26 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 26)

				if (26 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 26)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101084", "story_v_side_new_1104101.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101084", "story_v_side_new_1104101.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_side_new_1104101", "1104101084", "story_v_side_new_1104101.awb")

						arg_341_1:RecordAudio("1104101084", var_344_11)
						arg_341_1:RecordAudio("1104101084", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101084", "story_v_side_new_1104101.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101084", "story_v_side_new_1104101.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play1104101085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1104101085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1104101086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["1041ui_story"]) and arg_345_1.var_.characterEffect1041ui_story == nil then
				arg_345_1.var_.characterEffect1041ui_story = arg_345_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["1041ui_story"]) then
				if arg_345_1.var_.characterEffect1041ui_story and not isNil(arg_345_1.actors_["1041ui_story"]) then
					arg_345_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_0)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["1041ui_story"]) and arg_345_1.var_.characterEffect1041ui_story then
				arg_345_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_348_1 = 0
			local var_348_2 = 1.1

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, true)
				arg_345_1.iconController_:SetSelectedState("hero")

				arg_345_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_345_1.callingController_:SetSelectedState("normal")

				arg_345_1.keyicon_.color = Color.New(1, 1, 1)
				arg_345_1.icon_.color = Color.New(1, 1, 1)

				local var_348_3 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(1104101085).content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 44 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 44)

				if (44 <= 0 and var_348_2 or var_348_2 * (utf8.len(var_348_3) / 44)) > 0 and var_348_2 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_1 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_1
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_6 = math.max(var_348_2, arg_345_1.talkMaxDuration)

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_6 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_1) / var_348_6

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_1 + var_348_6 and arg_345_1.time_ < var_348_1 + var_348_6 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1104101086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1104101086
		arg_349_1.duration_ = 10

		local var_349_0 = {
			zh = 10,
			ja = 6.2
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
				arg_349_0:Play1104101087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1041ui_story = arg_349_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1041ui_story"].transform.position).z)
				arg_349_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1041ui_story"].transform.localEulerAngles = arg_349_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_349_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1041ui_story"].transform.position).z)
				arg_349_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1041ui_story"].transform.localEulerAngles = arg_349_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1041ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1041ui_story == nil then
				arg_349_1.var_.characterEffect1041ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1041ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1041ui_story then
				arg_349_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_4 = 0
			local var_352_5 = 1.05

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_6 = arg_349_1:GetWordFromCfg(1104101086)
				local var_352_7 = arg_349_1:FormatText(var_352_6.content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 42 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 42)

				if (42 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 42)) > 0 and var_352_5 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101086", "story_v_side_new_1104101.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101086", "story_v_side_new_1104101.awb") / 1000

					if var_352_10 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_4
					end

					if var_352_6.prefab_name ~= "" and arg_349_1.actors_[var_352_6.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_6.prefab_name].transform, "story_v_side_new_1104101", "1104101086", "story_v_side_new_1104101.awb")

						arg_349_1:RecordAudio("1104101086", var_352_11)
						arg_349_1:RecordAudio("1104101086", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101086", "story_v_side_new_1104101.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101086", "story_v_side_new_1104101.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_12 and arg_349_1.time_ < var_352_4 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play1104101087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1104101087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1104101088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["1041ui_story"]) and arg_353_1.var_.characterEffect1041ui_story == nil then
				arg_353_1.var_.characterEffect1041ui_story = arg_353_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["1041ui_story"]) then
				if arg_353_1.var_.characterEffect1041ui_story and not isNil(arg_353_1.actors_["1041ui_story"]) then
					arg_353_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_0)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["1041ui_story"]) and arg_353_1.var_.characterEffect1041ui_story then
				arg_353_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_356_1 = 0
			local var_356_2 = 0.7

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, true)
				arg_353_1.iconController_:SetSelectedState("hero")

				arg_353_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_353_1.callingController_:SetSelectedState("normal")

				arg_353_1.keyicon_.color = Color.New(1, 1, 1)
				arg_353_1.icon_.color = Color.New(1, 1, 1)

				local var_356_3 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(1104101087).content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 28 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 28)

				if (28 <= 0 and var_356_2 or var_356_2 * (utf8.len(var_356_3) / 28)) > 0 and var_356_2 < var_356_5 then
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
	Play1104101088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1104101088
		arg_357_1.duration_ = 12.43

		local var_357_0 = {
			zh = 10.766,
			ja = 12.433
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
				arg_357_0:Play1104101089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1041ui_story = arg_357_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1041ui_story"].transform.position).z)
				arg_357_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1041ui_story"].transform.localEulerAngles = arg_357_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_357_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1041ui_story"].transform.position).z)
				arg_357_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1041ui_story"].transform.localEulerAngles = arg_357_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1041ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1041ui_story == nil then
				arg_357_1.var_.characterEffect1041ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1041ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1041ui_story then
				arg_357_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_360_4 = 0
			local var_360_5 = 0.975

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(1104101088)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 39 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 39)

				if (39 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 39)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101088", "story_v_side_new_1104101.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101088", "story_v_side_new_1104101.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_side_new_1104101", "1104101088", "story_v_side_new_1104101.awb")

						arg_357_1:RecordAudio("1104101088", var_360_11)
						arg_357_1:RecordAudio("1104101088", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101088", "story_v_side_new_1104101.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101088", "story_v_side_new_1104101.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play1104101089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1104101089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1104101090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1041ui_story"]) and arg_361_1.var_.characterEffect1041ui_story == nil then
				arg_361_1.var_.characterEffect1041ui_story = arg_361_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1041ui_story"]) then
				if arg_361_1.var_.characterEffect1041ui_story and not isNil(arg_361_1.actors_["1041ui_story"]) then
					arg_361_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1041ui_story"]) and arg_361_1.var_.characterEffect1041ui_story then
				arg_361_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.875

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1104101089).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 35 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 35)

				if (35 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 35)) > 0 and var_364_2 < var_364_5 then
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
	Play1104101090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1104101090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1104101091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.625

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(1104101090).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 25 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 25)

				if (25 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 25)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1104101091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1104101091
		arg_369_1.duration_ = 3.03

		local var_369_0 = {
			zh = 1.999999999999,
			ja = 3.033
		}
		local var_369_1 = manager.audio:GetLocalizationFlag()

		if var_369_0[var_369_1] ~= nil then
			arg_369_1.duration_ = var_369_0[var_369_1]
		end

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1104101092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1041ui_story = arg_369_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).z)
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles = arg_369_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_369_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1041ui_story"].transform.position).z)
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1041ui_story"].transform.localEulerAngles = arg_369_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["1041ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1041ui_story == nil then
				arg_369_1.var_.characterEffect1041ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1041ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1041ui_story then
				arg_369_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_372_4 = 0
			local var_372_5 = 0.125

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_6 = arg_369_1:GetWordFromCfg(1104101091)
				local var_372_7 = arg_369_1:FormatText(var_372_6.content)

				arg_369_1.text_.text = var_372_7

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_9 = 5 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 5)

				if (5 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_7) / 5)) > 0 and var_372_5 < var_372_9 then
					arg_369_1.talkMaxDuration = var_372_9

					if var_372_9 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_9 + var_372_4
					end
				end

				arg_369_1.text_.text = var_372_7
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101091", "story_v_side_new_1104101.awb") ~= 0 then
					local var_372_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101091", "story_v_side_new_1104101.awb") / 1000

					if var_372_10 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_4
					end

					if var_372_6.prefab_name ~= "" and arg_369_1.actors_[var_372_6.prefab_name] ~= nil then
						local var_372_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_6.prefab_name].transform, "story_v_side_new_1104101", "1104101091", "story_v_side_new_1104101.awb")

						arg_369_1:RecordAudio("1104101091", var_372_11)
						arg_369_1:RecordAudio("1104101091", var_372_11)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101091", "story_v_side_new_1104101.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101091", "story_v_side_new_1104101.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_12 = math.max(var_372_5, arg_369_1.talkMaxDuration)

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_12 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_4) / var_372_12

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_4 + var_372_12 and arg_369_1.time_ < var_372_4 + var_372_12 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play1104101092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1104101092
		arg_373_1.duration_ = 1.5

		SetActive(arg_373_1.tipsGo_, true)

		arg_373_1.tipsText_.text = StoryTipsCfg[104101].name

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"

			SetActive(arg_373_1.choicesGo_, true)

			for iter_374_0, iter_374_1 in ipairs(arg_373_1.choices_) do
				SetActive(iter_374_1.go, iter_374_0 <= 2)
			end

			arg_373_1.choices_[1].txt.text = arg_373_1:FormatText(StoryChoiceCfg[624].name)
			arg_373_1.choices_[2].txt.text = arg_373_1:FormatText(StoryChoiceCfg[625].name)
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				PlayerAction.UseStoryTrigger(1041011, 210410101, 1104101092, 1)
				arg_373_0:Play1104101093(arg_373_1)
			end

			if arg_375_0 == 2 then
				PlayerAction.UseStoryTrigger(1041011, 210410101, 1104101092, 2)
				arg_373_0:Play1104101093(arg_373_1)
			end

			arg_373_1:RecordChoiceLog(1104101092, 624, 625)
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1041ui_story"]) and arg_373_1.var_.characterEffect1041ui_story == nil then
				arg_373_1.var_.characterEffect1041ui_story = arg_373_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1041ui_story"]) then
				if arg_373_1.var_.characterEffect1041ui_story and not isNil(arg_373_1.actors_["1041ui_story"]) then
					arg_373_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_0)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1041ui_story"]) and arg_373_1.var_.characterEffect1041ui_story then
				arg_373_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_376_1 = 0

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 then
				arg_373_1.allBtn_.enabled = false
			end

			if arg_373_1.time_ >= var_376_1 + 1.5 and arg_373_1.time_ < var_376_1 + 1.5 + arg_376_0 then
				arg_373_1.allBtn_.enabled = true
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1104101093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1104101093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1104101094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.65

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(1104101093).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 26 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 26)

				if (26 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 26)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1104101094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1104101094
		arg_381_1.duration_ = 2

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1104101095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1041ui_story = arg_381_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1041ui_story"].transform.position).z)
				arg_381_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1041ui_story"].transform.localEulerAngles = arg_381_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_381_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1041ui_story"].transform.position).z)
				arg_381_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1041ui_story"].transform.localEulerAngles = arg_381_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1041ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1041ui_story == nil then
				arg_381_1.var_.characterEffect1041ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1041ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1041ui_story then
				arg_381_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_384_4 = 0
			local var_384_5 = 0.05

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:GetWordFromCfg(1104101094)
				local var_384_7 = arg_381_1:FormatText(var_384_6.content)

				arg_381_1.text_.text = var_384_7

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_9 = 2 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 2)

				if (2 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_7) / 2)) > 0 and var_384_5 < var_384_9 then
					arg_381_1.talkMaxDuration = var_384_9

					if var_384_9 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_9 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_7
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101094", "story_v_side_new_1104101.awb") ~= 0 then
					local var_384_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101094", "story_v_side_new_1104101.awb") / 1000

					if var_384_10 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_4
					end

					if var_384_6.prefab_name ~= "" and arg_381_1.actors_[var_384_6.prefab_name] ~= nil then
						local var_384_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_6.prefab_name].transform, "story_v_side_new_1104101", "1104101094", "story_v_side_new_1104101.awb")

						arg_381_1:RecordAudio("1104101094", var_384_11)
						arg_381_1:RecordAudio("1104101094", var_384_11)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101094", "story_v_side_new_1104101.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101094", "story_v_side_new_1104101.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_12 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_12 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_12

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_12 and arg_381_1.time_ < var_384_4 + var_384_12 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play1104101095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1104101095
		arg_385_1.duration_ = 2.3

		local var_385_0 = {
			zh = 2.166,
			ja = 2.3
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1104101096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.425

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(1104101095)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 17 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 17)

				if (17 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 17)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101095", "story_v_side_new_1104101.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101095", "story_v_side_new_1104101.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_side_new_1104101", "1104101095", "story_v_side_new_1104101.awb")

						arg_385_1:RecordAudio("1104101095", var_388_6)
						arg_385_1:RecordAudio("1104101095", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101095", "story_v_side_new_1104101.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101095", "story_v_side_new_1104101.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1104101096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1104101096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1104101097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1041ui_story"]) and arg_389_1.var_.characterEffect1041ui_story == nil then
				arg_389_1.var_.characterEffect1041ui_story = arg_389_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1041ui_story"]) then
				if arg_389_1.var_.characterEffect1041ui_story and not isNil(arg_389_1.actors_["1041ui_story"]) then
					arg_389_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_0)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1041ui_story"]) and arg_389_1.var_.characterEffect1041ui_story then
				arg_389_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_392_1 = 0
			local var_392_2 = 0.125

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
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

				local var_392_3 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(1104101096).content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 5 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 5)

				if (5 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 5)) > 0 and var_392_2 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_6 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_6 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_6

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_6 and arg_389_1.time_ < var_392_1 + var_392_6 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1104101097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1104101097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1104101098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 1.55

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(1104101097).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 62 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 62)

				if (62 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 62)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1104101098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1104101098
		arg_397_1.duration_ = 3.8

		local var_397_0 = {
			zh = 2.866,
			ja = 3.8
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1104101099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1041ui_story = arg_397_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_400_0 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 then
				arg_397_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_397_1.time_ - 0) / var_400_0)
				arg_397_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1041ui_story"].transform.position).z)
				arg_397_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1041ui_story"].transform.localEulerAngles = arg_397_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 then
				arg_397_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_397_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1041ui_story"].transform.position).z)
				arg_397_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1041ui_story"].transform.localEulerAngles = arg_397_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_400_1 = arg_397_1.actors_["1041ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1041ui_story == nil then
				arg_397_1.var_.characterEffect1041ui_story = var_400_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_2 and not isNil(var_400_1) then
				if arg_397_1.var_.characterEffect1041ui_story and not isNil(var_400_1) then
					arg_397_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_2 and arg_397_1.time_ < 0 + var_400_2 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1041ui_story then
				arg_397_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_400_4 = 0
			local var_400_5 = 0.375

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_6 = arg_397_1:GetWordFromCfg(1104101098)
				local var_400_7 = arg_397_1:FormatText(var_400_6.content)

				arg_397_1.text_.text = var_400_7

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_9 = 15 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 15)

				if (15 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 15)) > 0 and var_400_5 < var_400_9 then
					arg_397_1.talkMaxDuration = var_400_9

					if var_400_9 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_4
					end
				end

				arg_397_1.text_.text = var_400_7
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101098", "story_v_side_new_1104101.awb") ~= 0 then
					local var_400_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101098", "story_v_side_new_1104101.awb") / 1000

					if var_400_10 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_4
					end

					if var_400_6.prefab_name ~= "" and arg_397_1.actors_[var_400_6.prefab_name] ~= nil then
						local var_400_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_6.prefab_name].transform, "story_v_side_new_1104101", "1104101098", "story_v_side_new_1104101.awb")

						arg_397_1:RecordAudio("1104101098", var_400_11)
						arg_397_1:RecordAudio("1104101098", var_400_11)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101098", "story_v_side_new_1104101.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101098", "story_v_side_new_1104101.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_12 = math.max(var_400_5, arg_397_1.talkMaxDuration)

			if var_400_4 <= arg_397_1.time_ and arg_397_1.time_ < var_400_4 + var_400_12 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_4) / var_400_12

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_4 + var_400_12 and arg_397_1.time_ < var_400_4 + var_400_12 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play1104101099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1104101099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1104101100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["1041ui_story"]) and arg_401_1.var_.characterEffect1041ui_story == nil then
				arg_401_1.var_.characterEffect1041ui_story = arg_401_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_0 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["1041ui_story"]) then
				if arg_401_1.var_.characterEffect1041ui_story and not isNil(arg_401_1.actors_["1041ui_story"]) then
					arg_401_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_0)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["1041ui_story"]) and arg_401_1.var_.characterEffect1041ui_story then
				arg_401_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_404_1 = 0
			local var_404_2 = 0.4

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_3 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(1104101099).content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 16 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 16)

				if (16 <= 0 and var_404_2 or var_404_2 * (utf8.len(var_404_3) / 16)) > 0 and var_404_2 < var_404_5 then
					arg_401_1.talkMaxDuration = var_404_5

					if var_404_5 + var_404_1 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + var_404_1
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_6 = math.max(var_404_2, arg_401_1.talkMaxDuration)

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_6 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_1) / var_404_6

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_1 + var_404_6 and arg_401_1.time_ < var_404_1 + var_404_6 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1104101100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104101100
		arg_405_1.duration_ = 2.2

		local var_405_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104101101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1041ui_story = arg_405_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1041ui_story"].transform.position).z)
				arg_405_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1041ui_story"].transform.localEulerAngles = arg_405_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_405_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1041ui_story"].transform.position).z)
				arg_405_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1041ui_story"].transform.localEulerAngles = arg_405_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1041ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1041ui_story == nil then
				arg_405_1.var_.characterEffect1041ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1041ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1041ui_story then
				arg_405_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_408_4 = 0
			local var_408_5 = 0.075

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(1104101100)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 3 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 3)

				if (3 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 3)) > 0 and var_408_5 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101100", "story_v_side_new_1104101.awb") ~= 0 then
					local var_408_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101100", "story_v_side_new_1104101.awb") / 1000

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end

					if var_408_6.prefab_name ~= "" and arg_405_1.actors_[var_408_6.prefab_name] ~= nil then
						local var_408_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_6.prefab_name].transform, "story_v_side_new_1104101", "1104101100", "story_v_side_new_1104101.awb")

						arg_405_1:RecordAudio("1104101100", var_408_11)
						arg_405_1:RecordAudio("1104101100", var_408_11)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101100", "story_v_side_new_1104101.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101100", "story_v_side_new_1104101.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_12 and arg_405_1.time_ < var_408_4 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play1104101101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1104101101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1104101102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1041ui_story"]) and arg_409_1.var_.characterEffect1041ui_story == nil then
				arg_409_1.var_.characterEffect1041ui_story = arg_409_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1041ui_story"]) then
				if arg_409_1.var_.characterEffect1041ui_story and not isNil(arg_409_1.actors_["1041ui_story"]) then
					arg_409_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1041ui_story"]) and arg_409_1.var_.characterEffect1041ui_story then
				arg_409_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.6

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(1104101101).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 24 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 24)

				if (24 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 24)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1104101102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1104101102
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1104101103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.85

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1104101102).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 34 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 34)

				if (34 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 34)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1104101103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1104101103
		arg_417_1.duration_ = 7

		local var_417_0 = {
			zh = 4.533,
			ja = 7
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1104101104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1041ui_story = arg_417_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1041ui_story"].transform.position).z)
				arg_417_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1041ui_story"].transform.localEulerAngles = arg_417_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_417_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1041ui_story"].transform.position).z)
				arg_417_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1041ui_story"].transform.localEulerAngles = arg_417_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["1041ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1041ui_story == nil then
				arg_417_1.var_.characterEffect1041ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect1041ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1041ui_story then
				arg_417_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_420_4 = 0
			local var_420_5 = 0.5

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_6 = arg_417_1:GetWordFromCfg(1104101103)
				local var_420_7 = arg_417_1:FormatText(var_420_6.content)

				arg_417_1.text_.text = var_420_7

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_9 = 20 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 20)

				if (20 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 20)) > 0 and var_420_5 < var_420_9 then
					arg_417_1.talkMaxDuration = var_420_9

					if var_420_9 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_9 + var_420_4
					end
				end

				arg_417_1.text_.text = var_420_7
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101103", "story_v_side_new_1104101.awb") ~= 0 then
					local var_420_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101103", "story_v_side_new_1104101.awb") / 1000

					if var_420_10 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_4
					end

					if var_420_6.prefab_name ~= "" and arg_417_1.actors_[var_420_6.prefab_name] ~= nil then
						local var_420_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_6.prefab_name].transform, "story_v_side_new_1104101", "1104101103", "story_v_side_new_1104101.awb")

						arg_417_1:RecordAudio("1104101103", var_420_11)
						arg_417_1:RecordAudio("1104101103", var_420_11)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101103", "story_v_side_new_1104101.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101103", "story_v_side_new_1104101.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_12 = math.max(var_420_5, arg_417_1.talkMaxDuration)

			if var_420_4 <= arg_417_1.time_ and arg_417_1.time_ < var_420_4 + var_420_12 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_4) / var_420_12

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_4 + var_420_12 and arg_417_1.time_ < var_420_4 + var_420_12 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play1104101104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1104101104
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1104101105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1041ui_story"]) and arg_421_1.var_.characterEffect1041ui_story == nil then
				arg_421_1.var_.characterEffect1041ui_story = arg_421_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1041ui_story"]) then
				if arg_421_1.var_.characterEffect1041ui_story and not isNil(arg_421_1.actors_["1041ui_story"]) then
					arg_421_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_0)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1041ui_story"]) and arg_421_1.var_.characterEffect1041ui_story then
				arg_421_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_424_1 = 0
			local var_424_2 = 0.725

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(1104101104).content)

				arg_421_1.text_.text = var_424_3

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 29 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 29)

				if (29 <= 0 and var_424_2 or var_424_2 * (utf8.len(var_424_3) / 29)) > 0 and var_424_2 < var_424_5 then
					arg_421_1.talkMaxDuration = var_424_5

					if var_424_5 + var_424_1 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + var_424_1
					end
				end

				arg_421_1.text_.text = var_424_3
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_6 = math.max(var_424_2, arg_421_1.talkMaxDuration)

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_6 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_1) / var_424_6

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_1 + var_424_6 and arg_421_1.time_ < var_424_1 + var_424_6 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1104101105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1104101105
		arg_425_1.duration_ = 4.2

		local var_425_0 = {
			zh = 1.999999999999,
			ja = 4.2
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1104101106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1041ui_story = arg_425_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1041ui_story"].transform.position).z)
				arg_425_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1041ui_story"].transform.localEulerAngles = arg_425_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_425_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1041ui_story"].transform.position).z)
				arg_425_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1041ui_story"].transform.localEulerAngles = arg_425_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1041ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1041ui_story == nil then
				arg_425_1.var_.characterEffect1041ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect1041ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1041ui_story then
				arg_425_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_428_4 = 0
			local var_428_5 = 0.25

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_6 = arg_425_1:GetWordFromCfg(1104101105)
				local var_428_7 = arg_425_1:FormatText(var_428_6.content)

				arg_425_1.text_.text = var_428_7

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_9 = 10 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 10)

				if (10 <= 0 and var_428_5 or var_428_5 * (utf8.len(var_428_7) / 10)) > 0 and var_428_5 < var_428_9 then
					arg_425_1.talkMaxDuration = var_428_9

					if var_428_9 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_9 + var_428_4
					end
				end

				arg_425_1.text_.text = var_428_7
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101105", "story_v_side_new_1104101.awb") ~= 0 then
					local var_428_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101105", "story_v_side_new_1104101.awb") / 1000

					if var_428_10 + var_428_4 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_10 + var_428_4
					end

					if var_428_6.prefab_name ~= "" and arg_425_1.actors_[var_428_6.prefab_name] ~= nil then
						local var_428_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_6.prefab_name].transform, "story_v_side_new_1104101", "1104101105", "story_v_side_new_1104101.awb")

						arg_425_1:RecordAudio("1104101105", var_428_11)
						arg_425_1:RecordAudio("1104101105", var_428_11)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101105", "story_v_side_new_1104101.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101105", "story_v_side_new_1104101.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_12 = math.max(var_428_5, arg_425_1.talkMaxDuration)

			if var_428_4 <= arg_425_1.time_ and arg_425_1.time_ < var_428_4 + var_428_12 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_4) / var_428_12

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_4 + var_428_12 and arg_425_1.time_ < var_428_4 + var_428_12 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play1104101106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104101106
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104101107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1041ui_story"]) and arg_429_1.var_.characterEffect1041ui_story == nil then
				arg_429_1.var_.characterEffect1041ui_story = arg_429_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1041ui_story"]) then
				if arg_429_1.var_.characterEffect1041ui_story and not isNil(arg_429_1.actors_["1041ui_story"]) then
					arg_429_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_0)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1041ui_story"]) and arg_429_1.var_.characterEffect1041ui_story then
				arg_429_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_432_1 = 0
			local var_432_2 = 0.275

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_3 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(1104101106).content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 11 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 11)

				if (11 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 11)) > 0 and var_432_2 < var_432_5 then
					arg_429_1.talkMaxDuration = var_432_5

					if var_432_5 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_6 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_6 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_6

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_6 and arg_429_1.time_ < var_432_1 + var_432_6 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104101107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104101107
		arg_433_1.duration_ = 5.63

		local var_433_0 = {
			zh = 5.4,
			ja = 5.633
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104101108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1041ui_story = arg_433_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1041ui_story"].transform.position).z)
				arg_433_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1041ui_story"].transform.localEulerAngles = arg_433_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_433_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1041ui_story"].transform.position).z)
				arg_433_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1041ui_story"].transform.localEulerAngles = arg_433_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1041ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1041ui_story == nil then
				arg_433_1.var_.characterEffect1041ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect1041ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1041ui_story then
				arg_433_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_436_4 = 0
			local var_436_5 = 0.45

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_6 = arg_433_1:GetWordFromCfg(1104101107)
				local var_436_7 = arg_433_1:FormatText(var_436_6.content)

				arg_433_1.text_.text = var_436_7

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_9 = 18 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 18)

				if (18 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 18)) > 0 and var_436_5 < var_436_9 then
					arg_433_1.talkMaxDuration = var_436_9

					if var_436_9 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_9 + var_436_4
					end
				end

				arg_433_1.text_.text = var_436_7
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101107", "story_v_side_new_1104101.awb") ~= 0 then
					local var_436_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101107", "story_v_side_new_1104101.awb") / 1000

					if var_436_10 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_4
					end

					if var_436_6.prefab_name ~= "" and arg_433_1.actors_[var_436_6.prefab_name] ~= nil then
						local var_436_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_6.prefab_name].transform, "story_v_side_new_1104101", "1104101107", "story_v_side_new_1104101.awb")

						arg_433_1:RecordAudio("1104101107", var_436_11)
						arg_433_1:RecordAudio("1104101107", var_436_11)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101107", "story_v_side_new_1104101.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101107", "story_v_side_new_1104101.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_12 = math.max(var_436_5, arg_433_1.talkMaxDuration)

			if var_436_4 <= arg_433_1.time_ and arg_433_1.time_ < var_436_4 + var_436_12 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_4) / var_436_12

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_4 + var_436_12 and arg_433_1.time_ < var_436_4 + var_436_12 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play1104101108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104101108
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104101109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1041ui_story"]) and arg_437_1.var_.characterEffect1041ui_story == nil then
				arg_437_1.var_.characterEffect1041ui_story = arg_437_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1041ui_story"]) then
				if arg_437_1.var_.characterEffect1041ui_story and not isNil(arg_437_1.actors_["1041ui_story"]) then
					arg_437_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1041ui_story"]) and arg_437_1.var_.characterEffect1041ui_story then
				arg_437_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_440_1 = 0
			local var_440_2 = 0.0329999998211861

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(1104101108).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 1 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 1)

				if (1 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 1)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1104101109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104101109
		arg_441_1.duration_ = 7.93

		local var_441_0 = {
			zh = 2.4,
			ja = 7.933
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104101110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos1041ui_story = arg_441_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_444_0 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 then
				arg_441_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_441_1.time_ - 0) / var_444_0)
				arg_441_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1041ui_story"].transform.position).z)
				arg_441_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1041ui_story"].transform.localEulerAngles = arg_441_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 then
				arg_441_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_441_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_441_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_441_1.actors_["1041ui_story"].transform.position).z)
				arg_441_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_441_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_441_1.actors_["1041ui_story"].transform.localEulerAngles = arg_441_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_444_1 = arg_441_1.actors_["1041ui_story"]

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1041ui_story == nil then
				arg_441_1.var_.characterEffect1041ui_story = var_444_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_2 and not isNil(var_444_1) then
				if arg_441_1.var_.characterEffect1041ui_story and not isNil(var_444_1) then
					arg_441_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_2 and arg_441_1.time_ < 0 + var_444_2 + arg_444_0 and not isNil(var_444_1) and arg_441_1.var_.characterEffect1041ui_story then
				arg_441_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_444_4 = 0
			local var_444_5 = 0.525

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_6 = arg_441_1:GetWordFromCfg(1104101109)
				local var_444_7 = arg_441_1:FormatText(var_444_6.content)

				arg_441_1.text_.text = var_444_7

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_9 = 21 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 21)

				if (21 <= 0 and var_444_5 or var_444_5 * (utf8.len(var_444_7) / 21)) > 0 and var_444_5 < var_444_9 then
					arg_441_1.talkMaxDuration = var_444_9

					if var_444_9 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_9 + var_444_4
					end
				end

				arg_441_1.text_.text = var_444_7
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101109", "story_v_side_new_1104101.awb") ~= 0 then
					local var_444_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101109", "story_v_side_new_1104101.awb") / 1000

					if var_444_10 + var_444_4 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_10 + var_444_4
					end

					if var_444_6.prefab_name ~= "" and arg_441_1.actors_[var_444_6.prefab_name] ~= nil then
						local var_444_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_6.prefab_name].transform, "story_v_side_new_1104101", "1104101109", "story_v_side_new_1104101.awb")

						arg_441_1:RecordAudio("1104101109", var_444_11)
						arg_441_1:RecordAudio("1104101109", var_444_11)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101109", "story_v_side_new_1104101.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101109", "story_v_side_new_1104101.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_12 = math.max(var_444_5, arg_441_1.talkMaxDuration)

			if var_444_4 <= arg_441_1.time_ and arg_441_1.time_ < var_444_4 + var_444_12 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_4) / var_444_12

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_4 + var_444_12 and arg_441_1.time_ < var_444_4 + var_444_12 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104101110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104101110
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104101111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1041ui_story"]) and arg_445_1.var_.characterEffect1041ui_story == nil then
				arg_445_1.var_.characterEffect1041ui_story = arg_445_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1041ui_story"]) then
				if arg_445_1.var_.characterEffect1041ui_story and not isNil(arg_445_1.actors_["1041ui_story"]) then
					arg_445_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_0)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1041ui_story"]) and arg_445_1.var_.characterEffect1041ui_story then
				arg_445_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_448_1 = 0
			local var_448_2 = 0.1

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_3 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1104101110).content)

				arg_445_1.text_.text = var_448_3

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_5 = 4 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 4)

				if (4 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_3) / 4)) > 0 and var_448_2 < var_448_5 then
					arg_445_1.talkMaxDuration = var_448_5

					if var_448_5 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_3
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_6 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_6 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_6

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_6 and arg_445_1.time_ < var_448_1 + var_448_6 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1104101111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104101111
		arg_449_1.duration_ = 7

		local var_449_0 = {
			zh = 6,
			ja = 7
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104101112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1041ui_story = arg_449_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1041ui_story"].transform.position).z)
				arg_449_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1041ui_story"].transform.localEulerAngles = arg_449_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_449_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1041ui_story"].transform.position).z)
				arg_449_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1041ui_story"].transform.localEulerAngles = arg_449_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["1041ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1041ui_story == nil then
				arg_449_1.var_.characterEffect1041ui_story = var_452_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 and not isNil(var_452_1) then
				if arg_449_1.var_.characterEffect1041ui_story and not isNil(var_452_1) then
					arg_449_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1041ui_story then
				arg_449_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_452_4 = 0
			local var_452_5 = 1.225

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_4 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_6 = arg_449_1:GetWordFromCfg(1104101111)
				local var_452_7 = arg_449_1:FormatText(var_452_6.content)

				arg_449_1.text_.text = var_452_7

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_9 = 49 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 49)

				if (49 <= 0 and var_452_5 or var_452_5 * (utf8.len(var_452_7) / 49)) > 0 and var_452_5 < var_452_9 then
					arg_449_1.talkMaxDuration = var_452_9

					if var_452_9 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_9 + var_452_4
					end
				end

				arg_449_1.text_.text = var_452_7
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101111", "story_v_side_new_1104101.awb") ~= 0 then
					local var_452_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101111", "story_v_side_new_1104101.awb") / 1000

					if var_452_10 + var_452_4 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_4
					end

					if var_452_6.prefab_name ~= "" and arg_449_1.actors_[var_452_6.prefab_name] ~= nil then
						local var_452_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_6.prefab_name].transform, "story_v_side_new_1104101", "1104101111", "story_v_side_new_1104101.awb")

						arg_449_1:RecordAudio("1104101111", var_452_11)
						arg_449_1:RecordAudio("1104101111", var_452_11)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101111", "story_v_side_new_1104101.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101111", "story_v_side_new_1104101.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_12 = math.max(var_452_5, arg_449_1.talkMaxDuration)

			if var_452_4 <= arg_449_1.time_ and arg_449_1.time_ < var_452_4 + var_452_12 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_4) / var_452_12

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_4 + var_452_12 and arg_449_1.time_ < var_452_4 + var_452_12 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104101112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104101112
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104101113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["1041ui_story"]) and arg_453_1.var_.characterEffect1041ui_story == nil then
				arg_453_1.var_.characterEffect1041ui_story = arg_453_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_0 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["1041ui_story"]) then
				if arg_453_1.var_.characterEffect1041ui_story and not isNil(arg_453_1.actors_["1041ui_story"]) then
					arg_453_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_0)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["1041ui_story"]) and arg_453_1.var_.characterEffect1041ui_story then
				arg_453_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_456_1 = 0
			local var_456_2 = 0.675

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_3 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(1104101112).content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 27 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 27)

				if (27 <= 0 and var_456_2 or var_456_2 * (utf8.len(var_456_3) / 27)) > 0 and var_456_2 < var_456_5 then
					arg_453_1.talkMaxDuration = var_456_5

					if var_456_5 + var_456_1 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + var_456_1
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_6 = math.max(var_456_2, arg_453_1.talkMaxDuration)

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_6 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_1) / var_456_6

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_1 + var_456_6 and arg_453_1.time_ < var_456_1 + var_456_6 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104101113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104101113
		arg_457_1.duration_ = 9.57

		local var_457_0 = {
			zh = 8.8,
			ja = 9.566
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104101114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1041ui_story = arg_457_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1041ui_story"].transform.position).z)
				arg_457_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1041ui_story"].transform.localEulerAngles = arg_457_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_457_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1041ui_story"].transform.position).z)
				arg_457_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1041ui_story"].transform.localEulerAngles = arg_457_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1041ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1041ui_story == nil then
				arg_457_1.var_.characterEffect1041ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect1041ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1041ui_story then
				arg_457_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_460_4 = 0
			local var_460_5 = 0.825

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_6 = arg_457_1:GetWordFromCfg(1104101113)
				local var_460_7 = arg_457_1:FormatText(var_460_6.content)

				arg_457_1.text_.text = var_460_7

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_9 = 33 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 33)

				if (33 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 33)) > 0 and var_460_5 < var_460_9 then
					arg_457_1.talkMaxDuration = var_460_9

					if var_460_9 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_4
					end
				end

				arg_457_1.text_.text = var_460_7
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101113", "story_v_side_new_1104101.awb") ~= 0 then
					local var_460_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101113", "story_v_side_new_1104101.awb") / 1000

					if var_460_10 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_4
					end

					if var_460_6.prefab_name ~= "" and arg_457_1.actors_[var_460_6.prefab_name] ~= nil then
						local var_460_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_6.prefab_name].transform, "story_v_side_new_1104101", "1104101113", "story_v_side_new_1104101.awb")

						arg_457_1:RecordAudio("1104101113", var_460_11)
						arg_457_1:RecordAudio("1104101113", var_460_11)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101113", "story_v_side_new_1104101.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101113", "story_v_side_new_1104101.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_12 = math.max(var_460_5, arg_457_1.talkMaxDuration)

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_12 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_4) / var_460_12

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_4 + var_460_12 and arg_457_1.time_ < var_460_4 + var_460_12 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play1104101114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104101114
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104101115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1041ui_story"]) and arg_461_1.var_.characterEffect1041ui_story == nil then
				arg_461_1.var_.characterEffect1041ui_story = arg_461_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1041ui_story"]) then
				if arg_461_1.var_.characterEffect1041ui_story and not isNil(arg_461_1.actors_["1041ui_story"]) then
					arg_461_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1041ui_story"]) and arg_461_1.var_.characterEffect1041ui_story then
				arg_461_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 0.35

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(1104101114).content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 14 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 14)

				if (14 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_3) / 14)) > 0 and var_464_2 < var_464_5 then
					arg_461_1.talkMaxDuration = var_464_5

					if var_464_5 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_5 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_6 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_6 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_6

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_6 and arg_461_1.time_ < var_464_1 + var_464_6 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104101115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104101115
		arg_465_1.duration_ = 10.77

		local var_465_0 = {
			zh = 10.766,
			ja = 6.3
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104101116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1041ui_story = arg_465_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).z)
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles = arg_465_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_465_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1041ui_story"].transform.position).z)
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1041ui_story"].transform.localEulerAngles = arg_465_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["1041ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1041ui_story == nil then
				arg_465_1.var_.characterEffect1041ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect1041ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1041ui_story then
				arg_465_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_468_4 = 0
			local var_468_5 = 1.475

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_6 = arg_465_1:GetWordFromCfg(1104101115)
				local var_468_7 = arg_465_1:FormatText(var_468_6.content)

				arg_465_1.text_.text = var_468_7

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_9 = 59 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 59)

				if (59 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_7) / 59)) > 0 and var_468_5 < var_468_9 then
					arg_465_1.talkMaxDuration = var_468_9

					if var_468_9 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_9 + var_468_4
					end
				end

				arg_465_1.text_.text = var_468_7
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101115", "story_v_side_new_1104101.awb") ~= 0 then
					local var_468_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101115", "story_v_side_new_1104101.awb") / 1000

					if var_468_10 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_10 + var_468_4
					end

					if var_468_6.prefab_name ~= "" and arg_465_1.actors_[var_468_6.prefab_name] ~= nil then
						local var_468_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_6.prefab_name].transform, "story_v_side_new_1104101", "1104101115", "story_v_side_new_1104101.awb")

						arg_465_1:RecordAudio("1104101115", var_468_11)
						arg_465_1:RecordAudio("1104101115", var_468_11)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101115", "story_v_side_new_1104101.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101115", "story_v_side_new_1104101.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_12 = math.max(var_468_5, arg_465_1.talkMaxDuration)

			if var_468_4 <= arg_465_1.time_ and arg_465_1.time_ < var_468_4 + var_468_12 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_4) / var_468_12

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_4 + var_468_12 and arg_465_1.time_ < var_468_4 + var_468_12 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104101116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104101116
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104101117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1041ui_story"]) and arg_469_1.var_.characterEffect1041ui_story == nil then
				arg_469_1.var_.characterEffect1041ui_story = arg_469_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1041ui_story"]) then
				if arg_469_1.var_.characterEffect1041ui_story and not isNil(arg_469_1.actors_["1041ui_story"]) then
					arg_469_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1041ui_story"]) and arg_469_1.var_.characterEffect1041ui_story then
				arg_469_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_472_1 = 0
			local var_472_2 = 0.325

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_3 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1104101116).content)

				arg_469_1.text_.text = var_472_3

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_5 = 13 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 13)

				if (13 <= 0 and var_472_2 or var_472_2 * (utf8.len(var_472_3) / 13)) > 0 and var_472_2 < var_472_5 then
					arg_469_1.talkMaxDuration = var_472_5

					if var_472_5 + var_472_1 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + var_472_1
					end
				end

				arg_469_1.text_.text = var_472_3
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_6 = math.max(var_472_2, arg_469_1.talkMaxDuration)

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_6 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_1) / var_472_6

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_1 + var_472_6 and arg_469_1.time_ < var_472_1 + var_472_6 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play1104101117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104101117
		arg_473_1.duration_ = 12.57

		local var_473_0 = {
			zh = 12.566,
			ja = 11.033
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104101118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1041ui_story = arg_473_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1041ui_story"].transform.position).z)
				arg_473_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1041ui_story"].transform.localEulerAngles = arg_473_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_473_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1041ui_story"].transform.position).z)
				arg_473_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1041ui_story"].transform.localEulerAngles = arg_473_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["1041ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1041ui_story == nil then
				arg_473_1.var_.characterEffect1041ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1041ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1041ui_story then
				arg_473_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_476_4 = 0
			local var_476_5 = 1.5

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(1104101117)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 60 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 60)

				if (60 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 60)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101117", "story_v_side_new_1104101.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101117", "story_v_side_new_1104101.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_side_new_1104101", "1104101117", "story_v_side_new_1104101.awb")

						arg_473_1:RecordAudio("1104101117", var_476_11)
						arg_473_1:RecordAudio("1104101117", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101117", "story_v_side_new_1104101.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101117", "story_v_side_new_1104101.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104101118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104101118
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104101119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["1041ui_story"]) and arg_477_1.var_.characterEffect1041ui_story == nil then
				arg_477_1.var_.characterEffect1041ui_story = arg_477_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["1041ui_story"]) then
				if arg_477_1.var_.characterEffect1041ui_story and not isNil(arg_477_1.actors_["1041ui_story"]) then
					arg_477_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["1041ui_story"]) and arg_477_1.var_.characterEffect1041ui_story then
				arg_477_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_480_1 = 0
			local var_480_2 = 0.35

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(1104101118).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 14 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 14)

				if (14 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 14)) > 0 and var_480_2 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_1 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_1
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_6 = math.max(var_480_2, arg_477_1.talkMaxDuration)

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_6 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_1) / var_480_6

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_1 + var_480_6 and arg_477_1.time_ < var_480_1 + var_480_6 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1104101119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104101119
		arg_481_1.duration_ = 7.37

		local var_481_0 = {
			zh = 7.366,
			ja = 5.733
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104101120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1041ui_story = arg_481_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1041ui_story"].transform.position).z)
				arg_481_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1041ui_story"].transform.localEulerAngles = arg_481_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_481_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1041ui_story"].transform.position).z)
				arg_481_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1041ui_story"].transform.localEulerAngles = arg_481_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1041ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1041ui_story == nil then
				arg_481_1.var_.characterEffect1041ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect1041ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1041ui_story then
				arg_481_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_2")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_484_4 = 0
			local var_484_5 = 0.75

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_6 = arg_481_1:GetWordFromCfg(1104101119)
				local var_484_7 = arg_481_1:FormatText(var_484_6.content)

				arg_481_1.text_.text = var_484_7

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_9 = 30 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 30)

				if (30 <= 0 and var_484_5 or var_484_5 * (utf8.len(var_484_7) / 30)) > 0 and var_484_5 < var_484_9 then
					arg_481_1.talkMaxDuration = var_484_9

					if var_484_9 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_9 + var_484_4
					end
				end

				arg_481_1.text_.text = var_484_7
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101119", "story_v_side_new_1104101.awb") ~= 0 then
					local var_484_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101119", "story_v_side_new_1104101.awb") / 1000

					if var_484_10 + var_484_4 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_4
					end

					if var_484_6.prefab_name ~= "" and arg_481_1.actors_[var_484_6.prefab_name] ~= nil then
						local var_484_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_6.prefab_name].transform, "story_v_side_new_1104101", "1104101119", "story_v_side_new_1104101.awb")

						arg_481_1:RecordAudio("1104101119", var_484_11)
						arg_481_1:RecordAudio("1104101119", var_484_11)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101119", "story_v_side_new_1104101.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101119", "story_v_side_new_1104101.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_12 = math.max(var_484_5, arg_481_1.talkMaxDuration)

			if var_484_4 <= arg_481_1.time_ and arg_481_1.time_ < var_484_4 + var_484_12 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_4) / var_484_12

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_4 + var_484_12 and arg_481_1.time_ < var_484_4 + var_484_12 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104101120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104101120
		arg_485_1.duration_ = 9

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1104101121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if arg_485_1.bgs_.F04 == nil then
				local var_488_0 = Object.Instantiate(arg_485_1.paintGo_)

				var_488_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F04")
				var_488_0.name = "F04"
				var_488_0.transform.parent = arg_485_1.stage_.transform
				var_488_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_485_1.bgs_.F04 = var_488_0
			end

			if 2 < arg_485_1.time_ and arg_485_1.time_ <= 2 + arg_488_0 then
				local var_488_1 = arg_485_1.bgs_.F04

				arg_485_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_488_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_488_2 = var_488_1:GetComponent("SpriteRenderer")

				if var_488_2 and var_488_2.sprite then
					local var_488_3 = 2 * (var_488_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_488_1.transform.localScale = Vector3.New(var_488_3 / var_488_2.sprite.bounds.size.y < var_488_3 * manager.ui.mainCameraCom_.aspect / var_488_2.sprite.bounds.size.x and var_488_3 * manager.ui.mainCameraCom_.aspect / var_488_2.sprite.bounds.size.x or var_488_3 / var_488_2.sprite.bounds.size.y, var_488_3 / var_488_2.sprite.bounds.size.y < var_488_3 * manager.ui.mainCameraCom_.aspect / var_488_2.sprite.bounds.size.x and var_488_3 * manager.ui.mainCameraCom_.aspect / var_488_2.sprite.bounds.size.x or var_488_3 / var_488_2.sprite.bounds.size.y, 0)
				end

				for iter_488_0, iter_488_1 in pairs(arg_485_1.bgs_) do
					if iter_488_0 ~= "F04" then
						iter_488_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_488_4 = 0

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_4 + arg_488_0 then
				arg_485_1.mask_.enabled = true
				arg_485_1.mask_.raycastTarget = true

				arg_485_1:SetGaussion(false)
			end

			local var_488_5 = 2

			if var_488_4 <= arg_485_1.time_ and arg_485_1.time_ < var_488_4 + var_488_5 then
				local var_488_6 = Color.New(0, 0, 0)

				var_488_6.a = Mathf.Lerp(0, 1, (arg_485_1.time_ - var_488_4) / var_488_5)
				arg_485_1.mask_.color = var_488_6
			end

			if arg_485_1.time_ >= var_488_4 + var_488_5 and arg_485_1.time_ < var_488_4 + var_488_5 + arg_488_0 then
				local var_488_7 = Color.New(0, 0, 0)

				var_488_7.a = 1
				arg_485_1.mask_.color = var_488_7
			end

			local var_488_8 = 2

			if 2 < arg_485_1.time_ and arg_485_1.time_ <= var_488_8 + arg_488_0 then
				arg_485_1.mask_.enabled = true
				arg_485_1.mask_.raycastTarget = true

				arg_485_1:SetGaussion(false)
			end

			local var_488_9 = 2

			if var_488_8 <= arg_485_1.time_ and arg_485_1.time_ < var_488_8 + var_488_9 then
				local var_488_10 = Color.New(0, 0, 0)

				var_488_10.a = Mathf.Lerp(1, 0, (arg_485_1.time_ - var_488_8) / var_488_9)
				arg_485_1.mask_.color = var_488_10
			end

			if arg_485_1.time_ >= var_488_8 + var_488_9 and arg_485_1.time_ < var_488_8 + var_488_9 + arg_488_0 then
				local var_488_11 = Color.New(0, 0, 0)

				arg_485_1.mask_.enabled = false
				var_488_11.a = 0
				arg_485_1.mask_.color = var_488_11
			end

			local var_488_12 = arg_485_1.actors_["1041ui_story"].transform

			if 2 < arg_485_1.time_ and arg_485_1.time_ <= 2 + arg_488_0 then
				arg_485_1.var_.moveOldPos1041ui_story = var_488_12.localPosition
			end

			local var_488_13 = 0.001

			if 2 <= arg_485_1.time_ and arg_485_1.time_ < 2 + var_488_13 then
				var_488_12.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_485_1.time_ - 2) / var_488_13)
				var_488_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_12.position).x, (manager.ui.mainCamera.transform.position - var_488_12.position).y, (manager.ui.mainCamera.transform.position - var_488_12.position).z)
				var_488_12.localEulerAngles.z = 0
				var_488_12.localEulerAngles.x = 0
				var_488_12.localEulerAngles = var_488_12.localEulerAngles
			end

			if arg_485_1.time_ >= 2 + var_488_13 and arg_485_1.time_ < 2 + var_488_13 + arg_488_0 then
				var_488_12.localPosition = Vector3.New(0, 100, 0)
				var_488_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_12.position).x, (manager.ui.mainCamera.transform.position - var_488_12.position).y, (manager.ui.mainCamera.transform.position - var_488_12.position).z)
				var_488_12.localEulerAngles.z = 0
				var_488_12.localEulerAngles.x = 0
				var_488_12.localEulerAngles = var_488_12.localEulerAngles
			end

			if arg_485_1.frameCnt_ <= 1 then
				arg_485_1.dialog_:SetActive(false)
			end

			local var_488_14 = 4
			local var_488_15 = 0.05

			if 4 < arg_485_1.time_ and arg_485_1.time_ <= var_488_14 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0

				arg_485_1.dialog_:SetActive(true)

				arg_485_1.dialogCg_.alpha = 0

				local var_488_16 = LeanTween.value(arg_485_1.dialog_, 0, 1, 0.3)

				var_488_16:setOnUpdate(LuaHelper.FloatAction(function(arg_489_0)
					arg_485_1.dialogCg_.alpha = arg_489_0
				end))
				var_488_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_485_1.dialog_)
					var_488_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_485_1.duration_ = arg_485_1.duration_ + 0.3

				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_17 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(1104101120).content)

				arg_485_1.text_.text = var_488_17

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_19 = 2 <= 0 and var_488_15 or var_488_15 * (utf8.len(var_488_17) / 2)

				if (2 <= 0 and var_488_15 or var_488_15 * (utf8.len(var_488_17) / 2)) > 0 and var_488_15 < var_488_19 then
					arg_485_1.talkMaxDuration = var_488_19
					var_488_14 = var_488_14 + 0.3

					if var_488_19 + var_488_14 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_19 + var_488_14
					end
				end

				arg_485_1.text_.text = var_488_17
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_20 = var_488_14 + 0.3
			local var_488_21 = math.max(var_488_15, arg_485_1.talkMaxDuration)

			if var_488_14 + 0.3 <= arg_485_1.time_ and arg_485_1.time_ < var_488_20 + var_488_21 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_20) / var_488_21

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_20 + var_488_21 and arg_485_1.time_ < var_488_20 + var_488_21 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play1104101121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1104101121
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1104101122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.allBtn_.enabled = false
			end

			if arg_491_1.time_ >= 0 + 0.3 and arg_491_1.time_ < 0 + 0.3 + arg_494_0 then
				arg_491_1.allBtn_.enabled = true
			end

			local var_494_0 = 0
			local var_494_1 = 0.3

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0

				arg_491_1.dialog_:SetActive(true)

				arg_491_1.dialogCg_.alpha = 0

				local var_494_2 = LeanTween.value(arg_491_1.dialog_, 0, 1, 0.3)

				var_494_2:setOnUpdate(LuaHelper.FloatAction(function(arg_495_0)
					arg_491_1.dialogCg_.alpha = arg_495_0
				end))
				var_494_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_491_1.dialog_)
					var_494_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_491_1.duration_ = arg_491_1.duration_ + 0.3

				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_3 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(1104101121).content)

				arg_491_1.text_.text = var_494_3

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_5 = 12 <= 0 and var_494_1 or var_494_1 * (utf8.len(var_494_3) / 12)

				if (12 <= 0 and var_494_1 or var_494_1 * (utf8.len(var_494_3) / 12)) > 0 and var_494_1 < var_494_5 then
					arg_491_1.talkMaxDuration = var_494_5
					var_494_0 = var_494_0 + 0.3

					if var_494_5 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_5 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_3
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_6 = var_494_0 + 0.3
			local var_494_7 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 + 0.3 <= arg_491_1.time_ and arg_491_1.time_ < var_494_6 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_6) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_6 + var_494_7 and arg_491_1.time_ < var_494_6 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1104101122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1104101122
		arg_497_1.duration_ = 6.67

		local var_497_0 = {
			zh = 6.666,
			ja = 5.7
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1104101123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1041ui_story = arg_497_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_500_0 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				arg_497_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).z)
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles = arg_497_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				arg_497_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_497_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1041ui_story"].transform.position).z)
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1041ui_story"].transform.localEulerAngles = arg_497_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_500_1 = arg_497_1.actors_["1041ui_story"]

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1041ui_story == nil then
				arg_497_1.var_.characterEffect1041ui_story = var_500_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_2 and not isNil(var_500_1) then
				if arg_497_1.var_.characterEffect1041ui_story and not isNil(var_500_1) then
					arg_497_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_2 and arg_497_1.time_ < 0 + var_500_2 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1041ui_story then
				arg_497_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action6_1")
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_500_4 = 0
			local var_500_5 = 1

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_4 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_6 = arg_497_1:GetWordFromCfg(1104101122)
				local var_500_7 = arg_497_1:FormatText(var_500_6.content)

				arg_497_1.text_.text = var_500_7

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_9 = 40 <= 0 and var_500_5 or var_500_5 * (utf8.len(var_500_7) / 40)

				if (40 <= 0 and var_500_5 or var_500_5 * (utf8.len(var_500_7) / 40)) > 0 and var_500_5 < var_500_9 then
					arg_497_1.talkMaxDuration = var_500_9

					if var_500_9 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_4
					end
				end

				arg_497_1.text_.text = var_500_7
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101122", "story_v_side_new_1104101.awb") ~= 0 then
					local var_500_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101122", "story_v_side_new_1104101.awb") / 1000

					if var_500_10 + var_500_4 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_10 + var_500_4
					end

					if var_500_6.prefab_name ~= "" and arg_497_1.actors_[var_500_6.prefab_name] ~= nil then
						local var_500_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_6.prefab_name].transform, "story_v_side_new_1104101", "1104101122", "story_v_side_new_1104101.awb")

						arg_497_1:RecordAudio("1104101122", var_500_11)
						arg_497_1:RecordAudio("1104101122", var_500_11)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101122", "story_v_side_new_1104101.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101122", "story_v_side_new_1104101.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_12 = math.max(var_500_5, arg_497_1.talkMaxDuration)

			if var_500_4 <= arg_497_1.time_ and arg_497_1.time_ < var_500_4 + var_500_12 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_4) / var_500_12

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_4 + var_500_12 and arg_497_1.time_ < var_500_4 + var_500_12 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play1104101123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1104101123
		arg_501_1.duration_ = 2.53

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1104101124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["1041ui_story"]) and arg_501_1.var_.characterEffect1041ui_story == nil then
				arg_501_1.var_.characterEffect1041ui_story = arg_501_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_0 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["1041ui_story"]) then
				if arg_501_1.var_.characterEffect1041ui_story and not isNil(arg_501_1.actors_["1041ui_story"]) then
					arg_501_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_501_1.time_ - 0) / var_504_0)
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["1041ui_story"]) and arg_501_1.var_.characterEffect1041ui_story then
				arg_501_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_504_1 = arg_501_1.actors_["1041ui_story"].transform

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1041ui_story = var_504_1.localPosition
			end

			local var_504_2 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_2 then
				var_504_1.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_501_1.time_ - 0) / var_504_2)
				var_504_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_1.position).x, (manager.ui.mainCamera.transform.position - var_504_1.position).y, (manager.ui.mainCamera.transform.position - var_504_1.position).z)
				var_504_1.localEulerAngles.z = 0
				var_504_1.localEulerAngles.x = 0
				var_504_1.localEulerAngles = var_504_1.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_2 and arg_501_1.time_ < 0 + var_504_2 + arg_504_0 then
				var_504_1.localPosition = Vector3.New(0, -1.11, -5.9)
				var_504_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_1.position).x, (manager.ui.mainCamera.transform.position - var_504_1.position).y, (manager.ui.mainCamera.transform.position - var_504_1.position).z)
				var_504_1.localEulerAngles.z = 0
				var_504_1.localEulerAngles.x = 0
				var_504_1.localEulerAngles = var_504_1.localEulerAngles
			end

			local var_504_3 = 0
			local var_504_4 = 0.175

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_3 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_5 = arg_501_1:GetWordFromCfg(1104101123)
				local var_504_6 = arg_501_1:FormatText(var_504_5.content)

				arg_501_1.text_.text = var_504_6

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_8 = 7 <= 0 and var_504_4 or var_504_4 * (utf8.len(var_504_6) / 7)

				if (7 <= 0 and var_504_4 or var_504_4 * (utf8.len(var_504_6) / 7)) > 0 and var_504_4 < var_504_8 then
					arg_501_1.talkMaxDuration = var_504_8

					if var_504_8 + var_504_3 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_8 + var_504_3
					end
				end

				arg_501_1.text_.text = var_504_6
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101123", "story_v_side_new_1104101.awb") ~= 0 then
					local var_504_9 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101123", "story_v_side_new_1104101.awb") / 1000

					if var_504_9 + var_504_3 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_9 + var_504_3
					end

					if var_504_5.prefab_name ~= "" and arg_501_1.actors_[var_504_5.prefab_name] ~= nil then
						local var_504_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_5.prefab_name].transform, "story_v_side_new_1104101", "1104101123", "story_v_side_new_1104101.awb")

						arg_501_1:RecordAudio("1104101123", var_504_10)
						arg_501_1:RecordAudio("1104101123", var_504_10)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101123", "story_v_side_new_1104101.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101123", "story_v_side_new_1104101.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_11 = math.max(var_504_4, arg_501_1.talkMaxDuration)

			if var_504_3 <= arg_501_1.time_ and arg_501_1.time_ < var_504_3 + var_504_11 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_3) / var_504_11

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_3 + var_504_11 and arg_501_1.time_ < var_504_3 + var_504_11 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play1104101124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1104101124
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1104101125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos1041ui_story = arg_505_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_508_0 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 then
				arg_505_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_505_1.time_ - 0) / var_508_0)
				arg_505_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_505_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1041ui_story"].transform.position).z)
				arg_505_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_505_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_505_1.actors_["1041ui_story"].transform.localEulerAngles = arg_505_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 then
				arg_505_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_505_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_505_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_505_1.actors_["1041ui_story"].transform.position).z)
				arg_505_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_505_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_505_1.actors_["1041ui_story"].transform.localEulerAngles = arg_505_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_508_1 = 0
			local var_508_2 = 0.65

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_3 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(1104101124).content)

				arg_505_1.text_.text = var_508_3

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_5 = 26 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 26)

				if (26 <= 0 and var_508_2 or var_508_2 * (utf8.len(var_508_3) / 26)) > 0 and var_508_2 < var_508_5 then
					arg_505_1.talkMaxDuration = var_508_5

					if var_508_5 + var_508_1 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_5 + var_508_1
					end
				end

				arg_505_1.text_.text = var_508_3
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_6 = math.max(var_508_2, arg_505_1.talkMaxDuration)

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_6 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_1) / var_508_6

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_1 + var_508_6 and arg_505_1.time_ < var_508_1 + var_508_6 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play1104101125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1104101125
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play1104101126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 1.1

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_1 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(1104101125).content)

				arg_509_1.text_.text = var_512_1

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_3 = 44 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 44)

				if (44 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 44)) > 0 and var_512_0 < var_512_3 then
					arg_509_1.talkMaxDuration = var_512_3

					if var_512_3 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_3 + 0
					end
				end

				arg_509_1.text_.text = var_512_1
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_4 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_4 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_4

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_4 and arg_509_1.time_ < 0 + var_512_4 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1104101126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1104101126
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1104101127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 1.2

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(1104101126).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 48 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 48)

				if (48 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 48)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1104101127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1104101127
		arg_517_1.duration_ = 4.27

		local var_517_0 = {
			zh = 4.266,
			ja = 3.6
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1104101128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.var_.moveOldPos1041ui_story = arg_517_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_520_0 = 0.001

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_0 then
				arg_517_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_517_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_517_1.time_ - 0) / var_520_0)
				arg_517_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1041ui_story"].transform.position).z)
				arg_517_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1041ui_story"].transform.localEulerAngles = arg_517_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_517_1.time_ >= 0 + var_520_0 and arg_517_1.time_ < 0 + var_520_0 + arg_520_0 then
				arg_517_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_517_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_517_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_517_1.actors_["1041ui_story"].transform.position).z)
				arg_517_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_517_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_517_1.actors_["1041ui_story"].transform.localEulerAngles = arg_517_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_520_1 = arg_517_1.actors_["1041ui_story"]

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 and not isNil(var_520_1) and arg_517_1.var_.characterEffect1041ui_story == nil then
				arg_517_1.var_.characterEffect1041ui_story = var_520_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_2 = 0.200000002980232

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_2 and not isNil(var_520_1) then
				if arg_517_1.var_.characterEffect1041ui_story and not isNil(var_520_1) then
					arg_517_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= 0 + var_520_2 and arg_517_1.time_ < 0 + var_520_2 + arg_520_0 and not isNil(var_520_1) and arg_517_1.var_.characterEffect1041ui_story then
				arg_517_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_520_4 = 0
			local var_520_5 = 0.4

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= var_520_4 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_6 = arg_517_1:GetWordFromCfg(1104101127)
				local var_520_7 = arg_517_1:FormatText(var_520_6.content)

				arg_517_1.text_.text = var_520_7

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_9 = 16 <= 0 and var_520_5 or var_520_5 * (utf8.len(var_520_7) / 16)

				if (16 <= 0 and var_520_5 or var_520_5 * (utf8.len(var_520_7) / 16)) > 0 and var_520_5 < var_520_9 then
					arg_517_1.talkMaxDuration = var_520_9

					if var_520_9 + var_520_4 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_9 + var_520_4
					end
				end

				arg_517_1.text_.text = var_520_7
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101127", "story_v_side_new_1104101.awb") ~= 0 then
					local var_520_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101127", "story_v_side_new_1104101.awb") / 1000

					if var_520_10 + var_520_4 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_10 + var_520_4
					end

					if var_520_6.prefab_name ~= "" and arg_517_1.actors_[var_520_6.prefab_name] ~= nil then
						local var_520_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_6.prefab_name].transform, "story_v_side_new_1104101", "1104101127", "story_v_side_new_1104101.awb")

						arg_517_1:RecordAudio("1104101127", var_520_11)
						arg_517_1:RecordAudio("1104101127", var_520_11)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101127", "story_v_side_new_1104101.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101127", "story_v_side_new_1104101.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_12 = math.max(var_520_5, arg_517_1.talkMaxDuration)

			if var_520_4 <= arg_517_1.time_ and arg_517_1.time_ < var_520_4 + var_520_12 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_4) / var_520_12

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_4 + var_520_12 and arg_517_1.time_ < var_520_4 + var_520_12 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_517_1:InitPlayNodeList()
	end,
	Play1104101128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1104101128
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1104101129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1041ui_story"]) and arg_521_1.var_.characterEffect1041ui_story == nil then
				arg_521_1.var_.characterEffect1041ui_story = arg_521_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.200000002980232

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1041ui_story"]) then
				if arg_521_1.var_.characterEffect1041ui_story and not isNil(arg_521_1.actors_["1041ui_story"]) then
					arg_521_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_0)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1041ui_story"]) and arg_521_1.var_.characterEffect1041ui_story then
				arg_521_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_524_1 = 0
			local var_524_2 = 0.05

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_3 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1104101128).content)

				arg_521_1.text_.text = var_524_3

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_5 = 2 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 2)

				if (2 <= 0 and var_524_2 or var_524_2 * (utf8.len(var_524_3) / 2)) > 0 and var_524_2 < var_524_5 then
					arg_521_1.talkMaxDuration = var_524_5

					if var_524_5 + var_524_1 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + var_524_1
					end
				end

				arg_521_1.text_.text = var_524_3
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_6 = math.max(var_524_2, arg_521_1.talkMaxDuration)

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_6 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_1) / var_524_6

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_1 + var_524_6 and arg_521_1.time_ < var_524_1 + var_524_6 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1104101129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1104101129
		arg_525_1.duration_ = 10.1

		local var_525_0 = {
			zh = 9.333,
			ja = 10.1
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play1104101130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos1041ui_story = arg_525_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_528_0 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 then
				arg_525_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_525_1.time_ - 0) / var_528_0)
				arg_525_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).z)
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles = arg_525_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 then
				arg_525_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_525_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_525_1.actors_["1041ui_story"].transform.position).z)
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_525_1.actors_["1041ui_story"].transform.localEulerAngles = arg_525_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_528_1 = arg_525_1.actors_["1041ui_story"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1041ui_story == nil then
				arg_525_1.var_.characterEffect1041ui_story = var_528_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.200000002980232

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_2 and not isNil(var_528_1) then
				if arg_525_1.var_.characterEffect1041ui_story and not isNil(var_528_1) then
					arg_525_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_2 and arg_525_1.time_ < 0 + var_528_2 + arg_528_0 and not isNil(var_528_1) and arg_525_1.var_.characterEffect1041ui_story then
				arg_525_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_528_4 = 0
			local var_528_5 = 0.825

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_4 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_6 = arg_525_1:GetWordFromCfg(1104101129)
				local var_528_7 = arg_525_1:FormatText(var_528_6.content)

				arg_525_1.text_.text = var_528_7

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_9 = 33 <= 0 and var_528_5 or var_528_5 * (utf8.len(var_528_7) / 33)

				if (33 <= 0 and var_528_5 or var_528_5 * (utf8.len(var_528_7) / 33)) > 0 and var_528_5 < var_528_9 then
					arg_525_1.talkMaxDuration = var_528_9

					if var_528_9 + var_528_4 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_9 + var_528_4
					end
				end

				arg_525_1.text_.text = var_528_7
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101129", "story_v_side_new_1104101.awb") ~= 0 then
					local var_528_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101129", "story_v_side_new_1104101.awb") / 1000

					if var_528_10 + var_528_4 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_10 + var_528_4
					end

					if var_528_6.prefab_name ~= "" and arg_525_1.actors_[var_528_6.prefab_name] ~= nil then
						local var_528_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_6.prefab_name].transform, "story_v_side_new_1104101", "1104101129", "story_v_side_new_1104101.awb")

						arg_525_1:RecordAudio("1104101129", var_528_11)
						arg_525_1:RecordAudio("1104101129", var_528_11)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101129", "story_v_side_new_1104101.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101129", "story_v_side_new_1104101.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_12 = math.max(var_528_5, arg_525_1.talkMaxDuration)

			if var_528_4 <= arg_525_1.time_ and arg_525_1.time_ < var_528_4 + var_528_12 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_4) / var_528_12

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_4 + var_528_12 and arg_525_1.time_ < var_528_4 + var_528_12 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play1104101130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 1104101130
		arg_529_1.duration_ = 1.83

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play1104101131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 and not isNil(arg_529_1.actors_["1041ui_story"]) and arg_529_1.var_.characterEffect1041ui_story == nil then
				arg_529_1.var_.characterEffect1041ui_story = arg_529_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_0 = 0.200000002980232

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 and not isNil(arg_529_1.actors_["1041ui_story"]) then
				if arg_529_1.var_.characterEffect1041ui_story and not isNil(arg_529_1.actors_["1041ui_story"]) then
					arg_529_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_529_1.time_ - 0) / var_532_0)
				end
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 and not isNil(arg_529_1.actors_["1041ui_story"]) and arg_529_1.var_.characterEffect1041ui_story then
				arg_529_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_532_1 = 0
			local var_532_2 = 0.1

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				arg_529_1.leftNameTxt_.text = arg_529_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_3 = arg_529_1:GetWordFromCfg(1104101130)
				local var_532_4 = arg_529_1:FormatText(var_532_3.content)

				arg_529_1.text_.text = var_532_4

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_6 = 4 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_4) / 4)

				if (4 <= 0 and var_532_2 or var_532_2 * (utf8.len(var_532_4) / 4)) > 0 and var_532_2 < var_532_6 then
					arg_529_1.talkMaxDuration = var_532_6

					if var_532_6 + var_532_1 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_6 + var_532_1
					end
				end

				arg_529_1.text_.text = var_532_4
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101130", "story_v_side_new_1104101.awb") ~= 0 then
					local var_532_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101130", "story_v_side_new_1104101.awb") / 1000

					if var_532_7 + var_532_1 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_1
					end

					if var_532_3.prefab_name ~= "" and arg_529_1.actors_[var_532_3.prefab_name] ~= nil then
						local var_532_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_529_1.actors_[var_532_3.prefab_name].transform, "story_v_side_new_1104101", "1104101130", "story_v_side_new_1104101.awb")

						arg_529_1:RecordAudio("1104101130", var_532_8)
						arg_529_1:RecordAudio("1104101130", var_532_8)
					else
						arg_529_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101130", "story_v_side_new_1104101.awb")
					end

					arg_529_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101130", "story_v_side_new_1104101.awb")
				end

				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_9 = math.max(var_532_2, arg_529_1.talkMaxDuration)

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_9 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_1) / var_532_9

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_1 + var_532_9 and arg_529_1.time_ < var_532_1 + var_532_9 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play1104101131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 1104101131
		arg_533_1.duration_ = 7.4

		local var_533_0 = {
			zh = 4.333,
			ja = 7.4
		}
		local var_533_1 = manager.audio:GetLocalizationFlag()

		if var_533_0[var_533_1] ~= nil then
			arg_533_1.duration_ = var_533_0[var_533_1]
		end

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play1104101132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.var_.moveOldPos1041ui_story = arg_533_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_536_0 = 0.001

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_0 then
				arg_533_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_533_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_533_1.time_ - 0) / var_536_0)
				arg_533_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).z)
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles = arg_533_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_533_1.time_ >= 0 + var_536_0 and arg_533_1.time_ < 0 + var_536_0 + arg_536_0 then
				arg_533_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_533_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_533_1.actors_["1041ui_story"].transform.position).z)
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_533_1.actors_["1041ui_story"].transform.localEulerAngles = arg_533_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_536_1 = arg_533_1.actors_["1041ui_story"]

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 and not isNil(var_536_1) and arg_533_1.var_.characterEffect1041ui_story == nil then
				arg_533_1.var_.characterEffect1041ui_story = var_536_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_2 = 0.200000002980232

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_2 and not isNil(var_536_1) then
				if arg_533_1.var_.characterEffect1041ui_story and not isNil(var_536_1) then
					arg_533_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= 0 + var_536_2 and arg_533_1.time_ < 0 + var_536_2 + arg_536_0 and not isNil(var_536_1) and arg_533_1.var_.characterEffect1041ui_story then
				arg_533_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_536_4 = 0
			local var_536_5 = 0.45

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= var_536_4 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				arg_533_1.leftNameTxt_.text = arg_533_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_6 = arg_533_1:GetWordFromCfg(1104101131)
				local var_536_7 = arg_533_1:FormatText(var_536_6.content)

				arg_533_1.text_.text = var_536_7

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_9 = 18 <= 0 and var_536_5 or var_536_5 * (utf8.len(var_536_7) / 18)

				if (18 <= 0 and var_536_5 or var_536_5 * (utf8.len(var_536_7) / 18)) > 0 and var_536_5 < var_536_9 then
					arg_533_1.talkMaxDuration = var_536_9

					if var_536_9 + var_536_4 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_9 + var_536_4
					end
				end

				arg_533_1.text_.text = var_536_7
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101131", "story_v_side_new_1104101.awb") ~= 0 then
					local var_536_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101131", "story_v_side_new_1104101.awb") / 1000

					if var_536_10 + var_536_4 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_10 + var_536_4
					end

					if var_536_6.prefab_name ~= "" and arg_533_1.actors_[var_536_6.prefab_name] ~= nil then
						local var_536_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_533_1.actors_[var_536_6.prefab_name].transform, "story_v_side_new_1104101", "1104101131", "story_v_side_new_1104101.awb")

						arg_533_1:RecordAudio("1104101131", var_536_11)
						arg_533_1:RecordAudio("1104101131", var_536_11)
					else
						arg_533_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101131", "story_v_side_new_1104101.awb")
					end

					arg_533_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101131", "story_v_side_new_1104101.awb")
				end

				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_12 = math.max(var_536_5, arg_533_1.talkMaxDuration)

			if var_536_4 <= arg_533_1.time_ and arg_533_1.time_ < var_536_4 + var_536_12 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_4) / var_536_12

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_4 + var_536_12 and arg_533_1.time_ < var_536_4 + var_536_12 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_533_1:InitPlayNodeList()
	end,
	Play1104101132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1104101132
		arg_537_1.duration_ = 2.57

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1104101133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(arg_537_1.actors_["1041ui_story"]) and arg_537_1.var_.characterEffect1041ui_story == nil then
				arg_537_1.var_.characterEffect1041ui_story = arg_537_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_540_0 = 0.200000002980232

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 and not isNil(arg_537_1.actors_["1041ui_story"]) then
				if arg_537_1.var_.characterEffect1041ui_story and not isNil(arg_537_1.actors_["1041ui_story"]) then
					arg_537_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_537_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_537_1.time_ - 0) / var_540_0)
				end
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 and not isNil(arg_537_1.actors_["1041ui_story"]) and arg_537_1.var_.characterEffect1041ui_story then
				arg_537_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_537_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_540_1 = 0
			local var_540_2 = 0.2

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_3 = arg_537_1:GetWordFromCfg(1104101132)
				local var_540_4 = arg_537_1:FormatText(var_540_3.content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_6 = 8 <= 0 and var_540_2 or var_540_2 * (utf8.len(var_540_4) / 8)

				if (8 <= 0 and var_540_2 or var_540_2 * (utf8.len(var_540_4) / 8)) > 0 and var_540_2 < var_540_6 then
					arg_537_1.talkMaxDuration = var_540_6

					if var_540_6 + var_540_1 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_6 + var_540_1
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101132", "story_v_side_new_1104101.awb") ~= 0 then
					local var_540_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101132", "story_v_side_new_1104101.awb") / 1000

					if var_540_7 + var_540_1 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_1
					end

					if var_540_3.prefab_name ~= "" and arg_537_1.actors_[var_540_3.prefab_name] ~= nil then
						local var_540_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_3.prefab_name].transform, "story_v_side_new_1104101", "1104101132", "story_v_side_new_1104101.awb")

						arg_537_1:RecordAudio("1104101132", var_540_8)
						arg_537_1:RecordAudio("1104101132", var_540_8)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101132", "story_v_side_new_1104101.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101132", "story_v_side_new_1104101.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_9 = math.max(var_540_2, arg_537_1.talkMaxDuration)

			if var_540_1 <= arg_537_1.time_ and arg_537_1.time_ < var_540_1 + var_540_9 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_1) / var_540_9

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_1 + var_540_9 and arg_537_1.time_ < var_540_1 + var_540_9 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1104101133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1104101133
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1104101134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:AudioAction("play", "effect", "se_story_side_1041", "se_story_side_1041_horse5", "")
			end

			local var_544_1 = 0
			local var_544_2 = 0.925

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, false)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(1104101133).content)

				arg_541_1.text_.text = var_544_3

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 37 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 37)

				if (37 <= 0 and var_544_2 or var_544_2 * (utf8.len(var_544_3) / 37)) > 0 and var_544_2 < var_544_5 then
					arg_541_1.talkMaxDuration = var_544_5

					if var_544_5 + var_544_1 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_5 + var_544_1
					end
				end

				arg_541_1.text_.text = var_544_3
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_6 = math.max(var_544_2, arg_541_1.talkMaxDuration)

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_6 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_1) / var_544_6

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_1 + var_544_6 and arg_541_1.time_ < var_544_1 + var_544_6 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1104101134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1104101134
		arg_545_1.duration_ = 12.1

		local var_545_0 = {
			zh = 11.566,
			ja = 12.1
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1104101135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1041ui_story = arg_545_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_548_0 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				arg_545_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_545_1.time_ - 0) / var_548_0)
				arg_545_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).z)
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles = arg_545_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				arg_545_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_545_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1041ui_story"].transform.position).z)
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1041ui_story"].transform.localEulerAngles = arg_545_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_548_1 = arg_545_1.actors_["1041ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1041ui_story == nil then
				arg_545_1.var_.characterEffect1041ui_story = var_548_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_2 and not isNil(var_548_1) then
				if arg_545_1.var_.characterEffect1041ui_story and not isNil(var_548_1) then
					arg_545_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_2 and arg_545_1.time_ < 0 + var_548_2 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1041ui_story then
				arg_545_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_1")
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_548_4 = 0
			local var_548_5 = 1.1

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_4 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_6 = arg_545_1:GetWordFromCfg(1104101134)
				local var_548_7 = arg_545_1:FormatText(var_548_6.content)

				arg_545_1.text_.text = var_548_7

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 44 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 44)

				if (44 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 44)) > 0 and var_548_5 < var_548_9 then
					arg_545_1.talkMaxDuration = var_548_9

					if var_548_9 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_4
					end
				end

				arg_545_1.text_.text = var_548_7
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101134", "story_v_side_new_1104101.awb") ~= 0 then
					local var_548_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101134", "story_v_side_new_1104101.awb") / 1000

					if var_548_10 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_10 + var_548_4
					end

					if var_548_6.prefab_name ~= "" and arg_545_1.actors_[var_548_6.prefab_name] ~= nil then
						local var_548_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_6.prefab_name].transform, "story_v_side_new_1104101", "1104101134", "story_v_side_new_1104101.awb")

						arg_545_1:RecordAudio("1104101134", var_548_11)
						arg_545_1:RecordAudio("1104101134", var_548_11)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101134", "story_v_side_new_1104101.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101134", "story_v_side_new_1104101.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_12 = math.max(var_548_5, arg_545_1.talkMaxDuration)

			if var_548_4 <= arg_545_1.time_ and arg_545_1.time_ < var_548_4 + var_548_12 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_4) / var_548_12

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_4 + var_548_12 and arg_545_1.time_ < var_548_4 + var_548_12 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play1104101135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1104101135
		arg_549_1.duration_ = 1.7

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1104101136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(arg_549_1.actors_["1041ui_story"]) and arg_549_1.var_.characterEffect1041ui_story == nil then
				arg_549_1.var_.characterEffect1041ui_story = arg_549_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_0 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 and not isNil(arg_549_1.actors_["1041ui_story"]) then
				if arg_549_1.var_.characterEffect1041ui_story and not isNil(arg_549_1.actors_["1041ui_story"]) then
					arg_549_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_549_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_0)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 and not isNil(arg_549_1.actors_["1041ui_story"]) and arg_549_1.var_.characterEffect1041ui_story then
				arg_549_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_549_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_552_1 = 0
			local var_552_2 = 0.1

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:GetWordFromCfg(1104101135)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_6 = 4 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_4) / 4)

				if (4 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_4) / 4)) > 0 and var_552_2 < var_552_6 then
					arg_549_1.talkMaxDuration = var_552_6

					if var_552_6 + var_552_1 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_6 + var_552_1
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101135", "story_v_side_new_1104101.awb") ~= 0 then
					local var_552_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101135", "story_v_side_new_1104101.awb") / 1000

					if var_552_7 + var_552_1 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_1
					end

					if var_552_3.prefab_name ~= "" and arg_549_1.actors_[var_552_3.prefab_name] ~= nil then
						local var_552_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_3.prefab_name].transform, "story_v_side_new_1104101", "1104101135", "story_v_side_new_1104101.awb")

						arg_549_1:RecordAudio("1104101135", var_552_8)
						arg_549_1:RecordAudio("1104101135", var_552_8)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101135", "story_v_side_new_1104101.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101135", "story_v_side_new_1104101.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_9 = math.max(var_552_2, arg_549_1.talkMaxDuration)

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_9 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_1) / var_552_9

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_1 + var_552_9 and arg_549_1.time_ < var_552_1 + var_552_9 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1104101136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1104101136
		arg_553_1.duration_ = 10.77

		local var_553_0 = {
			zh = 10.2,
			ja = 10.766
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1104101137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1041ui_story = arg_553_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_556_0 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 then
				arg_553_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_553_1.time_ - 0) / var_556_0)
				arg_553_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).z)
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles = arg_553_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 then
				arg_553_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_553_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1041ui_story"].transform.position).z)
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1041ui_story"].transform.localEulerAngles = arg_553_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_556_1 = arg_553_1.actors_["1041ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1041ui_story == nil then
				arg_553_1.var_.characterEffect1041ui_story = var_556_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_2 and not isNil(var_556_1) then
				if arg_553_1.var_.characterEffect1041ui_story and not isNil(var_556_1) then
					arg_553_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_2 and arg_553_1.time_ < 0 + var_556_2 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1041ui_story then
				arg_553_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_556_4 = 0
			local var_556_5 = 0.875

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_6 = arg_553_1:GetWordFromCfg(1104101136)
				local var_556_7 = arg_553_1:FormatText(var_556_6.content)

				arg_553_1.text_.text = var_556_7

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_9 = 35 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 35)

				if (35 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 35)) > 0 and var_556_5 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_4
					end
				end

				arg_553_1.text_.text = var_556_7
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101136", "story_v_side_new_1104101.awb") ~= 0 then
					local var_556_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101136", "story_v_side_new_1104101.awb") / 1000

					if var_556_10 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_4
					end

					if var_556_6.prefab_name ~= "" and arg_553_1.actors_[var_556_6.prefab_name] ~= nil then
						local var_556_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_6.prefab_name].transform, "story_v_side_new_1104101", "1104101136", "story_v_side_new_1104101.awb")

						arg_553_1:RecordAudio("1104101136", var_556_11)
						arg_553_1:RecordAudio("1104101136", var_556_11)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101136", "story_v_side_new_1104101.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101136", "story_v_side_new_1104101.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_12 = math.max(var_556_5, arg_553_1.talkMaxDuration)

			if var_556_4 <= arg_553_1.time_ and arg_553_1.time_ < var_556_4 + var_556_12 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_4) / var_556_12

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_4 + var_556_12 and arg_553_1.time_ < var_556_4 + var_556_12 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play1104101137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1104101137
		arg_557_1.duration_ = 1.67

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1104101138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1041ui_story"]) and arg_557_1.var_.characterEffect1041ui_story == nil then
				arg_557_1.var_.characterEffect1041ui_story = arg_557_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1041ui_story"]) then
				if arg_557_1.var_.characterEffect1041ui_story and not isNil(arg_557_1.actors_["1041ui_story"]) then
					arg_557_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_557_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_557_1.time_ - 0) / var_560_0)
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1041ui_story"]) and arg_557_1.var_.characterEffect1041ui_story then
				arg_557_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_557_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_560_1 = 0
			local var_560_2 = 0.075

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_3 = arg_557_1:GetWordFromCfg(1104101137)
				local var_560_4 = arg_557_1:FormatText(var_560_3.content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_6 = 3 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_4) / 3)

				if (3 <= 0 and var_560_2 or var_560_2 * (utf8.len(var_560_4) / 3)) > 0 and var_560_2 < var_560_6 then
					arg_557_1.talkMaxDuration = var_560_6

					if var_560_6 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_6 + var_560_1
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101137", "story_v_side_new_1104101.awb") ~= 0 then
					local var_560_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101137", "story_v_side_new_1104101.awb") / 1000

					if var_560_7 + var_560_1 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_1
					end

					if var_560_3.prefab_name ~= "" and arg_557_1.actors_[var_560_3.prefab_name] ~= nil then
						local var_560_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_3.prefab_name].transform, "story_v_side_new_1104101", "1104101137", "story_v_side_new_1104101.awb")

						arg_557_1:RecordAudio("1104101137", var_560_8)
						arg_557_1:RecordAudio("1104101137", var_560_8)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101137", "story_v_side_new_1104101.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101137", "story_v_side_new_1104101.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_9 = math.max(var_560_2, arg_557_1.talkMaxDuration)

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_9 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_1) / var_560_9

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_1 + var_560_9 and arg_557_1.time_ < var_560_1 + var_560_9 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1104101138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1104101138
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1104101139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0.3

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_1 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(1104101138).content)

				arg_561_1.text_.text = var_564_1

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_3 = 12 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 12)

				if (12 <= 0 and var_564_0 or var_564_0 * (utf8.len(var_564_1) / 12)) > 0 and var_564_0 < var_564_3 then
					arg_561_1.talkMaxDuration = var_564_3

					if var_564_3 + 0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_3 + 0
					end
				end

				arg_561_1.text_.text = var_564_1
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_4 = math.max(var_564_0, arg_561_1.talkMaxDuration)

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_4 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - 0) / var_564_4

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= 0 + var_564_4 and arg_561_1.time_ < 0 + var_564_4 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1104101139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1104101139
		arg_565_1.duration_ = 9.7

		local var_565_0 = {
			zh = 5.2,
			ja = 9.7
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1104101140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.var_.moveOldPos1041ui_story = arg_565_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_568_0 = 0.001

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 then
				arg_565_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_565_1.time_ - 0) / var_568_0)
				arg_565_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_565_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1041ui_story"].transform.position).z)
				arg_565_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_565_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_565_1.actors_["1041ui_story"].transform.localEulerAngles = arg_565_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 then
				arg_565_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_565_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_565_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_565_1.actors_["1041ui_story"].transform.position).z)
				arg_565_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_565_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_565_1.actors_["1041ui_story"].transform.localEulerAngles = arg_565_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_568_1 = arg_565_1.actors_["1041ui_story"]

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(var_568_1) and arg_565_1.var_.characterEffect1041ui_story == nil then
				arg_565_1.var_.characterEffect1041ui_story = var_568_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.200000002980232

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_2 and not isNil(var_568_1) then
				if arg_565_1.var_.characterEffect1041ui_story and not isNil(var_568_1) then
					arg_565_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= 0 + var_568_2 and arg_565_1.time_ < 0 + var_568_2 + arg_568_0 and not isNil(var_568_1) and arg_565_1.var_.characterEffect1041ui_story then
				arg_565_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action5_2")
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_568_4 = 0
			local var_568_5 = 0.5

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_4 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_6 = arg_565_1:GetWordFromCfg(1104101139)
				local var_568_7 = arg_565_1:FormatText(var_568_6.content)

				arg_565_1.text_.text = var_568_7

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_9 = 20 <= 0 and var_568_5 or var_568_5 * (utf8.len(var_568_7) / 20)

				if (20 <= 0 and var_568_5 or var_568_5 * (utf8.len(var_568_7) / 20)) > 0 and var_568_5 < var_568_9 then
					arg_565_1.talkMaxDuration = var_568_9

					if var_568_9 + var_568_4 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_9 + var_568_4
					end
				end

				arg_565_1.text_.text = var_568_7
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101139", "story_v_side_new_1104101.awb") ~= 0 then
					local var_568_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101139", "story_v_side_new_1104101.awb") / 1000

					if var_568_10 + var_568_4 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_10 + var_568_4
					end

					if var_568_6.prefab_name ~= "" and arg_565_1.actors_[var_568_6.prefab_name] ~= nil then
						local var_568_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_6.prefab_name].transform, "story_v_side_new_1104101", "1104101139", "story_v_side_new_1104101.awb")

						arg_565_1:RecordAudio("1104101139", var_568_11)
						arg_565_1:RecordAudio("1104101139", var_568_11)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101139", "story_v_side_new_1104101.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101139", "story_v_side_new_1104101.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_12 = math.max(var_568_5, arg_565_1.talkMaxDuration)

			if var_568_4 <= arg_565_1.time_ and arg_565_1.time_ < var_568_4 + var_568_12 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_4) / var_568_12

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_4 + var_568_12 and arg_565_1.time_ < var_568_4 + var_568_12 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play1104101140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1104101140
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1104101141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(arg_569_1.actors_["1041ui_story"]) and arg_569_1.var_.characterEffect1041ui_story == nil then
				arg_569_1.var_.characterEffect1041ui_story = arg_569_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_0 = 0.200000002980232

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 and not isNil(arg_569_1.actors_["1041ui_story"]) then
				if arg_569_1.var_.characterEffect1041ui_story and not isNil(arg_569_1.actors_["1041ui_story"]) then
					arg_569_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_569_1.time_ - 0) / var_572_0)
				end
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 and not isNil(arg_569_1.actors_["1041ui_story"]) and arg_569_1.var_.characterEffect1041ui_story then
				arg_569_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_572_1 = 0
			local var_572_2 = 1.2

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, false)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_3 = arg_569_1:FormatText(arg_569_1:GetWordFromCfg(1104101140).content)

				arg_569_1.text_.text = var_572_3

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 48 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_3) / 48)

				if (48 <= 0 and var_572_2 or var_572_2 * (utf8.len(var_572_3) / 48)) > 0 and var_572_2 < var_572_5 then
					arg_569_1.talkMaxDuration = var_572_5

					if var_572_5 + var_572_1 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_5 + var_572_1
					end
				end

				arg_569_1.text_.text = var_572_3
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_6 = math.max(var_572_2, arg_569_1.talkMaxDuration)

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_6 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_1) / var_572_6

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_1 + var_572_6 and arg_569_1.time_ < var_572_1 + var_572_6 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1104101141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1104101141
		arg_573_1.duration_ = 2.27

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1104101142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0.1

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_1 = arg_573_1:GetWordFromCfg(1104101141)
				local var_576_2 = arg_573_1:FormatText(var_576_1.content)

				arg_573_1.text_.text = var_576_2

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_4 = 4 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_2) / 4)

				if (4 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_2) / 4)) > 0 and var_576_0 < var_576_4 then
					arg_573_1.talkMaxDuration = var_576_4

					if var_576_4 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_4 + 0
					end
				end

				arg_573_1.text_.text = var_576_2
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101141", "story_v_side_new_1104101.awb") ~= 0 then
					local var_576_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101141", "story_v_side_new_1104101.awb") / 1000

					if var_576_5 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_5 + 0
					end

					if var_576_1.prefab_name ~= "" and arg_573_1.actors_[var_576_1.prefab_name] ~= nil then
						local var_576_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_1.prefab_name].transform, "story_v_side_new_1104101", "1104101141", "story_v_side_new_1104101.awb")

						arg_573_1:RecordAudio("1104101141", var_576_6)
						arg_573_1:RecordAudio("1104101141", var_576_6)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101141", "story_v_side_new_1104101.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101141", "story_v_side_new_1104101.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_7 = math.max(var_576_0, arg_573_1.talkMaxDuration)

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_7 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - 0) / var_576_7

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= 0 + var_576_7 and arg_573_1.time_ < 0 + var_576_7 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1104101142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1104101142
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1104101143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0.65

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_1 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(1104101142).content)

				arg_577_1.text_.text = var_580_1

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_3 = 26 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_1) / 26)

				if (26 <= 0 and var_580_0 or var_580_0 * (utf8.len(var_580_1) / 26)) > 0 and var_580_0 < var_580_3 then
					arg_577_1.talkMaxDuration = var_580_3

					if var_580_3 + 0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_3 + 0
					end
				end

				arg_577_1.text_.text = var_580_1
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_4 = math.max(var_580_0, arg_577_1.talkMaxDuration)

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_4 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - 0) / var_580_4

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= 0 + var_580_4 and arg_577_1.time_ < 0 + var_580_4 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1104101143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1104101143
		arg_581_1.duration_ = 2.23

		local var_581_0 = {
			zh = 2.033,
			ja = 2.233
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1104101144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos1041ui_story = arg_581_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_584_0 = 0.001

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 then
				arg_581_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_581_1.time_ - 0) / var_584_0)
				arg_581_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1041ui_story"].transform.position).z)
				arg_581_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1041ui_story"].transform.localEulerAngles = arg_581_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 then
				arg_581_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_581_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1041ui_story"].transform.position).z)
				arg_581_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1041ui_story"].transform.localEulerAngles = arg_581_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_584_1 = arg_581_1.actors_["1041ui_story"]

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(var_584_1) and arg_581_1.var_.characterEffect1041ui_story == nil then
				arg_581_1.var_.characterEffect1041ui_story = var_584_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.200000002980232

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_2 and not isNil(var_584_1) then
				if arg_581_1.var_.characterEffect1041ui_story and not isNil(var_584_1) then
					arg_581_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= 0 + var_584_2 and arg_581_1.time_ < 0 + var_584_2 + arg_584_0 and not isNil(var_584_1) and arg_581_1.var_.characterEffect1041ui_story then
				arg_581_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_584_4 = 0
			local var_584_5 = 0.15

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_4 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_6 = arg_581_1:GetWordFromCfg(1104101143)
				local var_584_7 = arg_581_1:FormatText(var_584_6.content)

				arg_581_1.text_.text = var_584_7

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_9 = 6 <= 0 and var_584_5 or var_584_5 * (utf8.len(var_584_7) / 6)

				if (6 <= 0 and var_584_5 or var_584_5 * (utf8.len(var_584_7) / 6)) > 0 and var_584_5 < var_584_9 then
					arg_581_1.talkMaxDuration = var_584_9

					if var_584_9 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_9 + var_584_4
					end
				end

				arg_581_1.text_.text = var_584_7
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101143", "story_v_side_new_1104101.awb") ~= 0 then
					local var_584_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101143", "story_v_side_new_1104101.awb") / 1000

					if var_584_10 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_10 + var_584_4
					end

					if var_584_6.prefab_name ~= "" and arg_581_1.actors_[var_584_6.prefab_name] ~= nil then
						local var_584_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_6.prefab_name].transform, "story_v_side_new_1104101", "1104101143", "story_v_side_new_1104101.awb")

						arg_581_1:RecordAudio("1104101143", var_584_11)
						arg_581_1:RecordAudio("1104101143", var_584_11)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101143", "story_v_side_new_1104101.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101143", "story_v_side_new_1104101.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_12 = math.max(var_584_5, arg_581_1.talkMaxDuration)

			if var_584_4 <= arg_581_1.time_ and arg_581_1.time_ < var_584_4 + var_584_12 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_4) / var_584_12

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_4 + var_584_12 and arg_581_1.time_ < var_584_4 + var_584_12 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_581_1:InitPlayNodeList()
	end,
	Play1104101144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1104101144
		arg_585_1.duration_ = 1.3

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1104101145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(arg_585_1.actors_["1041ui_story"]) and arg_585_1.var_.characterEffect1041ui_story == nil then
				arg_585_1.var_.characterEffect1041ui_story = arg_585_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_0 = 0.200000002980232

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_0 and not isNil(arg_585_1.actors_["1041ui_story"]) then
				if arg_585_1.var_.characterEffect1041ui_story and not isNil(arg_585_1.actors_["1041ui_story"]) then
					arg_585_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_585_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_585_1.time_ - 0) / var_588_0)
				end
			end

			if arg_585_1.time_ >= 0 + var_588_0 and arg_585_1.time_ < 0 + var_588_0 + arg_588_0 and not isNil(arg_585_1.actors_["1041ui_story"]) and arg_585_1.var_.characterEffect1041ui_story then
				arg_585_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_585_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_588_1 = 0
			local var_588_2 = 0.075

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_3 = arg_585_1:GetWordFromCfg(1104101144)
				local var_588_4 = arg_585_1:FormatText(var_588_3.content)

				arg_585_1.text_.text = var_588_4

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_6 = 3 <= 0 and var_588_2 or var_588_2 * (utf8.len(var_588_4) / 3)

				if (3 <= 0 and var_588_2 or var_588_2 * (utf8.len(var_588_4) / 3)) > 0 and var_588_2 < var_588_6 then
					arg_585_1.talkMaxDuration = var_588_6

					if var_588_6 + var_588_1 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_6 + var_588_1
					end
				end

				arg_585_1.text_.text = var_588_4
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101144", "story_v_side_new_1104101.awb") ~= 0 then
					local var_588_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101144", "story_v_side_new_1104101.awb") / 1000

					if var_588_7 + var_588_1 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_7 + var_588_1
					end

					if var_588_3.prefab_name ~= "" and arg_585_1.actors_[var_588_3.prefab_name] ~= nil then
						local var_588_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_3.prefab_name].transform, "story_v_side_new_1104101", "1104101144", "story_v_side_new_1104101.awb")

						arg_585_1:RecordAudio("1104101144", var_588_8)
						arg_585_1:RecordAudio("1104101144", var_588_8)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101144", "story_v_side_new_1104101.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101144", "story_v_side_new_1104101.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_9 = math.max(var_588_2, arg_585_1.talkMaxDuration)

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_9 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_1) / var_588_9

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_1 + var_588_9 and arg_585_1.time_ < var_588_1 + var_588_9 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1104101145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1104101145
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1104101146(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 1

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_1 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(1104101145).content)

				arg_589_1.text_.text = var_592_1

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_3 = 40 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 40)

				if (40 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_1) / 40)) > 0 and var_592_0 < var_592_3 then
					arg_589_1.talkMaxDuration = var_592_3

					if var_592_3 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_3 + 0
					end
				end

				arg_589_1.text_.text = var_592_1
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_4 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_4

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1104101146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1104101146
		arg_593_1.duration_ = 6.83

		local var_593_0 = {
			zh = 6.633,
			ja = 6.833
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1104101147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.var_.moveOldPos1041ui_story = arg_593_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_596_0 = 0.001

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_0 then
				arg_593_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_593_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_593_1.time_ - 0) / var_596_0)
				arg_593_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_593_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1041ui_story"].transform.position).z)
				arg_593_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_593_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_593_1.actors_["1041ui_story"].transform.localEulerAngles = arg_593_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_593_1.time_ >= 0 + var_596_0 and arg_593_1.time_ < 0 + var_596_0 + arg_596_0 then
				arg_593_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_593_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_593_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1041ui_story"].transform.position).z)
				arg_593_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_593_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_593_1.actors_["1041ui_story"].transform.localEulerAngles = arg_593_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_596_1 = arg_593_1.actors_["1041ui_story"]

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(var_596_1) and arg_593_1.var_.characterEffect1041ui_story == nil then
				arg_593_1.var_.characterEffect1041ui_story = var_596_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_2 and not isNil(var_596_1) then
				if arg_593_1.var_.characterEffect1041ui_story and not isNil(var_596_1) then
					arg_593_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= 0 + var_596_2 and arg_593_1.time_ < 0 + var_596_2 + arg_596_0 and not isNil(var_596_1) and arg_593_1.var_.characterEffect1041ui_story then
				arg_593_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_2")
			end

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_596_4 = 0
			local var_596_5 = 0.65

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_4 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_6 = arg_593_1:GetWordFromCfg(1104101146)
				local var_596_7 = arg_593_1:FormatText(var_596_6.content)

				arg_593_1.text_.text = var_596_7

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_9 = 26 <= 0 and var_596_5 or var_596_5 * (utf8.len(var_596_7) / 26)

				if (26 <= 0 and var_596_5 or var_596_5 * (utf8.len(var_596_7) / 26)) > 0 and var_596_5 < var_596_9 then
					arg_593_1.talkMaxDuration = var_596_9

					if var_596_9 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_9 + var_596_4
					end
				end

				arg_593_1.text_.text = var_596_7
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101146", "story_v_side_new_1104101.awb") ~= 0 then
					local var_596_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101146", "story_v_side_new_1104101.awb") / 1000

					if var_596_10 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_10 + var_596_4
					end

					if var_596_6.prefab_name ~= "" and arg_593_1.actors_[var_596_6.prefab_name] ~= nil then
						local var_596_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_6.prefab_name].transform, "story_v_side_new_1104101", "1104101146", "story_v_side_new_1104101.awb")

						arg_593_1:RecordAudio("1104101146", var_596_11)
						arg_593_1:RecordAudio("1104101146", var_596_11)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101146", "story_v_side_new_1104101.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101146", "story_v_side_new_1104101.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_12 = math.max(var_596_5, arg_593_1.talkMaxDuration)

			if var_596_4 <= arg_593_1.time_ and arg_593_1.time_ < var_596_4 + var_596_12 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_4) / var_596_12

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_4 + var_596_12 and arg_593_1.time_ < var_596_4 + var_596_12 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_593_1:InitPlayNodeList()
	end,
	Play1104101147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1104101147
		arg_597_1.duration_ = 4.47

		local var_597_0 = {
			zh = 3.6,
			ja = 4.466
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1104101148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_600_0 = 0
			local var_600_1 = 0.35

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_2 = arg_597_1:GetWordFromCfg(1104101147)
				local var_600_3 = arg_597_1:FormatText(var_600_2.content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 14 <= 0 and var_600_1 or var_600_1 * (utf8.len(var_600_3) / 14)

				if (14 <= 0 and var_600_1 or var_600_1 * (utf8.len(var_600_3) / 14)) > 0 and var_600_1 < var_600_5 then
					arg_597_1.talkMaxDuration = var_600_5

					if var_600_5 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + var_600_0
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101147", "story_v_side_new_1104101.awb") ~= 0 then
					local var_600_6 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101147", "story_v_side_new_1104101.awb") / 1000

					if var_600_6 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_6 + var_600_0
					end

					if var_600_2.prefab_name ~= "" and arg_597_1.actors_[var_600_2.prefab_name] ~= nil then
						local var_600_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_2.prefab_name].transform, "story_v_side_new_1104101", "1104101147", "story_v_side_new_1104101.awb")

						arg_597_1:RecordAudio("1104101147", var_600_7)
						arg_597_1:RecordAudio("1104101147", var_600_7)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101147", "story_v_side_new_1104101.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101147", "story_v_side_new_1104101.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_8 = math.max(var_600_1, arg_597_1.talkMaxDuration)

			if var_600_0 <= arg_597_1.time_ and arg_597_1.time_ < var_600_0 + var_600_8 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_0) / var_600_8

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_0 + var_600_8 and arg_597_1.time_ < var_600_0 + var_600_8 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1104101148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1104101148
		arg_601_1.duration_ = 2.03

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1104101149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(arg_601_1.actors_["1041ui_story"]) and arg_601_1.var_.characterEffect1041ui_story == nil then
				arg_601_1.var_.characterEffect1041ui_story = arg_601_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_0 = 0.200000002980232

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 and not isNil(arg_601_1.actors_["1041ui_story"]) then
				if arg_601_1.var_.characterEffect1041ui_story and not isNil(arg_601_1.actors_["1041ui_story"]) then
					arg_601_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_601_1.time_ - 0) / var_604_0)
				end
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 and not isNil(arg_601_1.actors_["1041ui_story"]) and arg_601_1.var_.characterEffect1041ui_story then
				arg_601_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_604_1 = 0
			local var_604_2 = 0.125

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_3 = arg_601_1:GetWordFromCfg(1104101148)
				local var_604_4 = arg_601_1:FormatText(var_604_3.content)

				arg_601_1.text_.text = var_604_4

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_6 = 5 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_4) / 5)

				if (5 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_4) / 5)) > 0 and var_604_2 < var_604_6 then
					arg_601_1.talkMaxDuration = var_604_6

					if var_604_6 + var_604_1 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_6 + var_604_1
					end
				end

				arg_601_1.text_.text = var_604_4
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101148", "story_v_side_new_1104101.awb") ~= 0 then
					local var_604_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101148", "story_v_side_new_1104101.awb") / 1000

					if var_604_7 + var_604_1 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_7 + var_604_1
					end

					if var_604_3.prefab_name ~= "" and arg_601_1.actors_[var_604_3.prefab_name] ~= nil then
						local var_604_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_3.prefab_name].transform, "story_v_side_new_1104101", "1104101148", "story_v_side_new_1104101.awb")

						arg_601_1:RecordAudio("1104101148", var_604_8)
						arg_601_1:RecordAudio("1104101148", var_604_8)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101148", "story_v_side_new_1104101.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101148", "story_v_side_new_1104101.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_9 = math.max(var_604_2, arg_601_1.talkMaxDuration)

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_9 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_1) / var_604_9

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_1 + var_604_9 and arg_601_1.time_ < var_604_1 + var_604_9 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play1104101149 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1104101149
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1104101150(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 1.1

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, false)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_1 = arg_605_1:FormatText(arg_605_1:GetWordFromCfg(1104101149).content)

				arg_605_1.text_.text = var_608_1

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_3 = 44 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 44)

				if (44 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 44)) > 0 and var_608_0 < var_608_3 then
					arg_605_1.talkMaxDuration = var_608_3

					if var_608_3 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_3 + 0
					end
				end

				arg_605_1.text_.text = var_608_1
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_4 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_4 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_4

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_4 and arg_605_1.time_ < 0 + var_608_4 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1104101150 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1104101150
		arg_609_1.duration_ = 6.37

		local var_609_0 = {
			zh = 5.933,
			ja = 6.366
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1104101151(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.var_.moveOldPos1041ui_story = arg_609_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_612_0 = 0.001

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_0 then
				arg_609_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_609_1.time_ - 0) / var_612_0)
				arg_609_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_609_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1041ui_story"].transform.position).z)
				arg_609_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_609_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_609_1.actors_["1041ui_story"].transform.localEulerAngles = arg_609_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_609_1.time_ >= 0 + var_612_0 and arg_609_1.time_ < 0 + var_612_0 + arg_612_0 then
				arg_609_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_609_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_609_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_609_1.actors_["1041ui_story"].transform.position).z)
				arg_609_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_609_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_609_1.actors_["1041ui_story"].transform.localEulerAngles = arg_609_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_612_1 = arg_609_1.actors_["1041ui_story"]

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 and not isNil(var_612_1) and arg_609_1.var_.characterEffect1041ui_story == nil then
				arg_609_1.var_.characterEffect1041ui_story = var_612_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_2 = 0.200000002980232

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_2 and not isNil(var_612_1) then
				if arg_609_1.var_.characterEffect1041ui_story and not isNil(var_612_1) then
					arg_609_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_609_1.time_ >= 0 + var_612_2 and arg_609_1.time_ < 0 + var_612_2 + arg_612_0 and not isNil(var_612_1) and arg_609_1.var_.characterEffect1041ui_story then
				arg_609_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_612_4 = 0
			local var_612_5 = 0.925

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_4 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_6 = arg_609_1:GetWordFromCfg(1104101150)
				local var_612_7 = arg_609_1:FormatText(var_612_6.content)

				arg_609_1.text_.text = var_612_7

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_9 = 36 <= 0 and var_612_5 or var_612_5 * (utf8.len(var_612_7) / 36)

				if (36 <= 0 and var_612_5 or var_612_5 * (utf8.len(var_612_7) / 36)) > 0 and var_612_5 < var_612_9 then
					arg_609_1.talkMaxDuration = var_612_9

					if var_612_9 + var_612_4 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_9 + var_612_4
					end
				end

				arg_609_1.text_.text = var_612_7
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101150", "story_v_side_new_1104101.awb") ~= 0 then
					local var_612_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101150", "story_v_side_new_1104101.awb") / 1000

					if var_612_10 + var_612_4 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_10 + var_612_4
					end

					if var_612_6.prefab_name ~= "" and arg_609_1.actors_[var_612_6.prefab_name] ~= nil then
						local var_612_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_6.prefab_name].transform, "story_v_side_new_1104101", "1104101150", "story_v_side_new_1104101.awb")

						arg_609_1:RecordAudio("1104101150", var_612_11)
						arg_609_1:RecordAudio("1104101150", var_612_11)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101150", "story_v_side_new_1104101.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101150", "story_v_side_new_1104101.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_12 = math.max(var_612_5, arg_609_1.talkMaxDuration)

			if var_612_4 <= arg_609_1.time_ and arg_609_1.time_ < var_612_4 + var_612_12 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_4) / var_612_12

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_4 + var_612_12 and arg_609_1.time_ < var_612_4 + var_612_12 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_609_1:InitPlayNodeList()
	end,
	Play1104101151 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1104101151
		arg_613_1.duration_ = 5

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1104101152(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(arg_613_1.actors_["1041ui_story"]) and arg_613_1.var_.characterEffect1041ui_story == nil then
				arg_613_1.var_.characterEffect1041ui_story = arg_613_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_0 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_0 and not isNil(arg_613_1.actors_["1041ui_story"]) then
				if arg_613_1.var_.characterEffect1041ui_story and not isNil(arg_613_1.actors_["1041ui_story"]) then
					arg_613_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_613_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_613_1.time_ - 0) / var_616_0)
				end
			end

			if arg_613_1.time_ >= 0 + var_616_0 and arg_613_1.time_ < 0 + var_616_0 + arg_616_0 and not isNil(arg_613_1.actors_["1041ui_story"]) and arg_613_1.var_.characterEffect1041ui_story then
				arg_613_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_613_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_616_1 = 0
			local var_616_2 = 0.275

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, true)
				arg_613_1.iconController_:SetSelectedState("hero")

				arg_613_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_613_1.callingController_:SetSelectedState("normal")

				arg_613_1.keyicon_.color = Color.New(1, 1, 1)
				arg_613_1.icon_.color = Color.New(1, 1, 1)

				local var_616_3 = arg_613_1:FormatText(arg_613_1:GetWordFromCfg(1104101151).content)

				arg_613_1.text_.text = var_616_3

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_5 = 11 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_3) / 11)

				if (11 <= 0 and var_616_2 or var_616_2 * (utf8.len(var_616_3) / 11)) > 0 and var_616_2 < var_616_5 then
					arg_613_1.talkMaxDuration = var_616_5

					if var_616_5 + var_616_1 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_5 + var_616_1
					end
				end

				arg_613_1.text_.text = var_616_3
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)
				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_6 = math.max(var_616_2, arg_613_1.talkMaxDuration)

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_6 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_1) / var_616_6

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_1 + var_616_6 and arg_613_1.time_ < var_616_1 + var_616_6 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play1104101152 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1104101152
		arg_617_1.duration_ = 3.7

		local var_617_0 = {
			zh = 2.033,
			ja = 3.7
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1104101153(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.var_.moveOldPos1041ui_story = arg_617_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_620_0 = 0.001

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 then
				arg_617_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_617_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_617_1.time_ - 0) / var_620_0)
				arg_617_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_617_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1041ui_story"].transform.position).z)
				arg_617_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_617_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_617_1.actors_["1041ui_story"].transform.localEulerAngles = arg_617_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 then
				arg_617_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_617_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_617_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_617_1.actors_["1041ui_story"].transform.position).z)
				arg_617_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_617_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_617_1.actors_["1041ui_story"].transform.localEulerAngles = arg_617_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_620_1 = arg_617_1.actors_["1041ui_story"]

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(var_620_1) and arg_617_1.var_.characterEffect1041ui_story == nil then
				arg_617_1.var_.characterEffect1041ui_story = var_620_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_2 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_2 and not isNil(var_620_1) then
				if arg_617_1.var_.characterEffect1041ui_story and not isNil(var_620_1) then
					arg_617_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_617_1.time_ >= 0 + var_620_2 and arg_617_1.time_ < 0 + var_620_2 + arg_620_0 and not isNil(var_620_1) and arg_617_1.var_.characterEffect1041ui_story then
				arg_617_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_620_4 = 0
			local var_620_5 = 0.225

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_4 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_6 = arg_617_1:GetWordFromCfg(1104101152)
				local var_620_7 = arg_617_1:FormatText(var_620_6.content)

				arg_617_1.text_.text = var_620_7

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_9 = 9 <= 0 and var_620_5 or var_620_5 * (utf8.len(var_620_7) / 9)

				if (9 <= 0 and var_620_5 or var_620_5 * (utf8.len(var_620_7) / 9)) > 0 and var_620_5 < var_620_9 then
					arg_617_1.talkMaxDuration = var_620_9

					if var_620_9 + var_620_4 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_9 + var_620_4
					end
				end

				arg_617_1.text_.text = var_620_7
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101152", "story_v_side_new_1104101.awb") ~= 0 then
					local var_620_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101152", "story_v_side_new_1104101.awb") / 1000

					if var_620_10 + var_620_4 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_10 + var_620_4
					end

					if var_620_6.prefab_name ~= "" and arg_617_1.actors_[var_620_6.prefab_name] ~= nil then
						local var_620_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_6.prefab_name].transform, "story_v_side_new_1104101", "1104101152", "story_v_side_new_1104101.awb")

						arg_617_1:RecordAudio("1104101152", var_620_11)
						arg_617_1:RecordAudio("1104101152", var_620_11)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101152", "story_v_side_new_1104101.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101152", "story_v_side_new_1104101.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_12 = math.max(var_620_5, arg_617_1.talkMaxDuration)

			if var_620_4 <= arg_617_1.time_ and arg_617_1.time_ < var_620_4 + var_620_12 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_4) / var_620_12

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_4 + var_620_12 and arg_617_1.time_ < var_620_4 + var_620_12 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_617_1:InitPlayNodeList()
	end,
	Play1104101153 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1104101153
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1104101154(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 and not isNil(arg_621_1.actors_["1041ui_story"]) and arg_621_1.var_.characterEffect1041ui_story == nil then
				arg_621_1.var_.characterEffect1041ui_story = arg_621_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_624_0 = 0.200000002980232

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_0 and not isNil(arg_621_1.actors_["1041ui_story"]) then
				if arg_621_1.var_.characterEffect1041ui_story and not isNil(arg_621_1.actors_["1041ui_story"]) then
					arg_621_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_621_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_621_1.time_ - 0) / var_624_0)
				end
			end

			if arg_621_1.time_ >= 0 + var_624_0 and arg_621_1.time_ < 0 + var_624_0 + arg_624_0 and not isNil(arg_621_1.actors_["1041ui_story"]) and arg_621_1.var_.characterEffect1041ui_story then
				arg_621_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_621_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_624_1 = 0
			local var_624_2 = 0.225

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_1 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_3 = arg_621_1:FormatText(arg_621_1:GetWordFromCfg(1104101153).content)

				arg_621_1.text_.text = var_624_3

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 9 <= 0 and var_624_2 or var_624_2 * (utf8.len(var_624_3) / 9)

				if (9 <= 0 and var_624_2 or var_624_2 * (utf8.len(var_624_3) / 9)) > 0 and var_624_2 < var_624_5 then
					arg_621_1.talkMaxDuration = var_624_5

					if var_624_5 + var_624_1 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + var_624_1
					end
				end

				arg_621_1.text_.text = var_624_3
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_6 = math.max(var_624_2, arg_621_1.talkMaxDuration)

			if var_624_1 <= arg_621_1.time_ and arg_621_1.time_ < var_624_1 + var_624_6 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_1) / var_624_6

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_1 + var_624_6 and arg_621_1.time_ < var_624_1 + var_624_6 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1104101154 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1104101154
		arg_625_1.duration_ = 1

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1104101155(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.1

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, true)
				arg_625_1.iconController_:SetSelectedState("hero")

				arg_625_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_625_1.callingController_:SetSelectedState("normal")

				arg_625_1.keyicon_.color = Color.New(1, 1, 1)
				arg_625_1.icon_.color = Color.New(1, 1, 1)

				local var_628_1 = arg_625_1:GetWordFromCfg(1104101154)
				local var_628_2 = arg_625_1:FormatText(var_628_1.content)

				arg_625_1.text_.text = var_628_2

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_4 = 4 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_2) / 4)

				if (4 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_2) / 4)) > 0 and var_628_0 < var_628_4 then
					arg_625_1.talkMaxDuration = var_628_4

					if var_628_4 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_4 + 0
					end
				end

				arg_625_1.text_.text = var_628_2
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101154", "story_v_side_new_1104101.awb") ~= 0 then
					local var_628_5 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101154", "story_v_side_new_1104101.awb") / 1000

					if var_628_5 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_5 + 0
					end

					if var_628_1.prefab_name ~= "" and arg_625_1.actors_[var_628_1.prefab_name] ~= nil then
						local var_628_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_1.prefab_name].transform, "story_v_side_new_1104101", "1104101154", "story_v_side_new_1104101.awb")

						arg_625_1:RecordAudio("1104101154", var_628_6)
						arg_625_1:RecordAudio("1104101154", var_628_6)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101154", "story_v_side_new_1104101.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101154", "story_v_side_new_1104101.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_7 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_7 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_7

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_7 and arg_625_1.time_ < 0 + var_628_7 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play1104101155 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1104101155
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1104101156(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 1.125

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_1 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(1104101155).content)

				arg_629_1.text_.text = var_632_1

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_3 = 45 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 45)

				if (45 <= 0 and var_632_0 or var_632_0 * (utf8.len(var_632_1) / 45)) > 0 and var_632_0 < var_632_3 then
					arg_629_1.talkMaxDuration = var_632_3

					if var_632_3 + 0 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_3 + 0
					end
				end

				arg_629_1.text_.text = var_632_1
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_4 = math.max(var_632_0, arg_629_1.talkMaxDuration)

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_4 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - 0) / var_632_4

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= 0 + var_632_4 and arg_629_1.time_ < 0 + var_632_4 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1104101156 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1104101156
		arg_633_1.duration_ = 6.57

		local var_633_0 = {
			zh = 3.333,
			ja = 6.566
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1104101157(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1.var_.moveOldPos1041ui_story = arg_633_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_636_0 = 0.001

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_0 then
				arg_633_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_633_1.time_ - 0) / var_636_0)
				arg_633_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_633_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1041ui_story"].transform.position).z)
				arg_633_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_633_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_633_1.actors_["1041ui_story"].transform.localEulerAngles = arg_633_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_633_1.time_ >= 0 + var_636_0 and arg_633_1.time_ < 0 + var_636_0 + arg_636_0 then
				arg_633_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_633_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_633_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1041ui_story"].transform.position).z)
				arg_633_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_633_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_633_1.actors_["1041ui_story"].transform.localEulerAngles = arg_633_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_636_1 = arg_633_1.actors_["1041ui_story"]

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 and not isNil(var_636_1) and arg_633_1.var_.characterEffect1041ui_story == nil then
				arg_633_1.var_.characterEffect1041ui_story = var_636_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_2 = 0.200000002980232

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_2 and not isNil(var_636_1) then
				if arg_633_1.var_.characterEffect1041ui_story and not isNil(var_636_1) then
					arg_633_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= 0 + var_636_2 and arg_633_1.time_ < 0 + var_636_2 + arg_636_0 and not isNil(var_636_1) and arg_633_1.var_.characterEffect1041ui_story then
				arg_633_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_636_4 = 0
			local var_636_5 = 0.575

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_4 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_6 = arg_633_1:GetWordFromCfg(1104101156)
				local var_636_7 = arg_633_1:FormatText(var_636_6.content)

				arg_633_1.text_.text = var_636_7

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_9 = 23 <= 0 and var_636_5 or var_636_5 * (utf8.len(var_636_7) / 23)

				if (23 <= 0 and var_636_5 or var_636_5 * (utf8.len(var_636_7) / 23)) > 0 and var_636_5 < var_636_9 then
					arg_633_1.talkMaxDuration = var_636_9

					if var_636_9 + var_636_4 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_9 + var_636_4
					end
				end

				arg_633_1.text_.text = var_636_7
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101156", "story_v_side_new_1104101.awb") ~= 0 then
					local var_636_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101156", "story_v_side_new_1104101.awb") / 1000

					if var_636_10 + var_636_4 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_10 + var_636_4
					end

					if var_636_6.prefab_name ~= "" and arg_633_1.actors_[var_636_6.prefab_name] ~= nil then
						local var_636_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_6.prefab_name].transform, "story_v_side_new_1104101", "1104101156", "story_v_side_new_1104101.awb")

						arg_633_1:RecordAudio("1104101156", var_636_11)
						arg_633_1:RecordAudio("1104101156", var_636_11)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101156", "story_v_side_new_1104101.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101156", "story_v_side_new_1104101.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_12 = math.max(var_636_5, arg_633_1.talkMaxDuration)

			if var_636_4 <= arg_633_1.time_ and arg_633_1.time_ < var_636_4 + var_636_12 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_4) / var_636_12

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_4 + var_636_12 and arg_633_1.time_ < var_636_4 + var_636_12 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play1104101157 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1104101157
		arg_637_1.duration_ = 1.93

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1104101158(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 and not isNil(arg_637_1.actors_["1041ui_story"]) and arg_637_1.var_.characterEffect1041ui_story == nil then
				arg_637_1.var_.characterEffect1041ui_story = arg_637_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_0 = 0.200000002980232

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_0 and not isNil(arg_637_1.actors_["1041ui_story"]) then
				if arg_637_1.var_.characterEffect1041ui_story and not isNil(arg_637_1.actors_["1041ui_story"]) then
					arg_637_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_637_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_637_1.time_ - 0) / var_640_0)
				end
			end

			if arg_637_1.time_ >= 0 + var_640_0 and arg_637_1.time_ < 0 + var_640_0 + arg_640_0 and not isNil(arg_637_1.actors_["1041ui_story"]) and arg_637_1.var_.characterEffect1041ui_story then
				arg_637_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_637_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_640_1 = 0
			local var_640_2 = 0.075

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[615].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_horsea")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_3 = arg_637_1:GetWordFromCfg(1104101157)
				local var_640_4 = arg_637_1:FormatText(var_640_3.content)

				arg_637_1.text_.text = var_640_4

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_6 = 3 <= 0 and var_640_2 or var_640_2 * (utf8.len(var_640_4) / 3)

				if (3 <= 0 and var_640_2 or var_640_2 * (utf8.len(var_640_4) / 3)) > 0 and var_640_2 < var_640_6 then
					arg_637_1.talkMaxDuration = var_640_6

					if var_640_6 + var_640_1 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_6 + var_640_1
					end
				end

				arg_637_1.text_.text = var_640_4
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101157", "story_v_side_new_1104101.awb") ~= 0 then
					local var_640_7 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101157", "story_v_side_new_1104101.awb") / 1000

					if var_640_7 + var_640_1 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_7 + var_640_1
					end

					if var_640_3.prefab_name ~= "" and arg_637_1.actors_[var_640_3.prefab_name] ~= nil then
						local var_640_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_3.prefab_name].transform, "story_v_side_new_1104101", "1104101157", "story_v_side_new_1104101.awb")

						arg_637_1:RecordAudio("1104101157", var_640_8)
						arg_637_1:RecordAudio("1104101157", var_640_8)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101157", "story_v_side_new_1104101.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101157", "story_v_side_new_1104101.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_9 = math.max(var_640_2, arg_637_1.talkMaxDuration)

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_9 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_1) / var_640_9

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_1 + var_640_9 and arg_637_1.time_ < var_640_1 + var_640_9 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1104101158 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1104101158
		arg_641_1.duration_ = 5.87

		local var_641_0 = {
			zh = 5.866,
			ja = 5.4
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1104101159(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.var_.moveOldPos1041ui_story = arg_641_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_644_0 = 0.001

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_0 then
				arg_641_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_641_1.time_ - 0) / var_644_0)
				arg_641_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_641_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1041ui_story"].transform.position).z)
				arg_641_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_641_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_641_1.actors_["1041ui_story"].transform.localEulerAngles = arg_641_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_641_1.time_ >= 0 + var_644_0 and arg_641_1.time_ < 0 + var_644_0 + arg_644_0 then
				arg_641_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_641_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_641_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1041ui_story"].transform.position).z)
				arg_641_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_641_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_641_1.actors_["1041ui_story"].transform.localEulerAngles = arg_641_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_644_1 = arg_641_1.actors_["1041ui_story"]

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 and not isNil(var_644_1) and arg_641_1.var_.characterEffect1041ui_story == nil then
				arg_641_1.var_.characterEffect1041ui_story = var_644_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_2 = 0.200000002980232

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_2 and not isNil(var_644_1) then
				if arg_641_1.var_.characterEffect1041ui_story and not isNil(var_644_1) then
					arg_641_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= 0 + var_644_2 and arg_641_1.time_ < 0 + var_644_2 + arg_644_0 and not isNil(var_644_1) and arg_641_1.var_.characterEffect1041ui_story then
				arg_641_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_644_4 = 0
			local var_644_5 = 0.6

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_4 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_6 = arg_641_1:GetWordFromCfg(1104101158)
				local var_644_7 = arg_641_1:FormatText(var_644_6.content)

				arg_641_1.text_.text = var_644_7

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_9 = 24 <= 0 and var_644_5 or var_644_5 * (utf8.len(var_644_7) / 24)

				if (24 <= 0 and var_644_5 or var_644_5 * (utf8.len(var_644_7) / 24)) > 0 and var_644_5 < var_644_9 then
					arg_641_1.talkMaxDuration = var_644_9

					if var_644_9 + var_644_4 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_9 + var_644_4
					end
				end

				arg_641_1.text_.text = var_644_7
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101158", "story_v_side_new_1104101.awb") ~= 0 then
					local var_644_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101158", "story_v_side_new_1104101.awb") / 1000

					if var_644_10 + var_644_4 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_10 + var_644_4
					end

					if var_644_6.prefab_name ~= "" and arg_641_1.actors_[var_644_6.prefab_name] ~= nil then
						local var_644_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_6.prefab_name].transform, "story_v_side_new_1104101", "1104101158", "story_v_side_new_1104101.awb")

						arg_641_1:RecordAudio("1104101158", var_644_11)
						arg_641_1:RecordAudio("1104101158", var_644_11)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101158", "story_v_side_new_1104101.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101158", "story_v_side_new_1104101.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_12 = math.max(var_644_5, arg_641_1.talkMaxDuration)

			if var_644_4 <= arg_641_1.time_ and arg_641_1.time_ < var_644_4 + var_644_12 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_4) / var_644_12

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_4 + var_644_12 and arg_641_1.time_ < var_644_4 + var_644_12 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_641_1:InitPlayNodeList()
	end,
	Play1104101159 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1104101159
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1104101160(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 and not isNil(arg_645_1.actors_["1041ui_story"]) and arg_645_1.var_.characterEffect1041ui_story == nil then
				arg_645_1.var_.characterEffect1041ui_story = arg_645_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_648_0 = 0.200000002980232

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_0 and not isNil(arg_645_1.actors_["1041ui_story"]) then
				if arg_645_1.var_.characterEffect1041ui_story and not isNil(arg_645_1.actors_["1041ui_story"]) then
					arg_645_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_645_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_645_1.time_ - 0) / var_648_0)
				end
			end

			if arg_645_1.time_ >= 0 + var_648_0 and arg_645_1.time_ < 0 + var_648_0 + arg_648_0 and not isNil(arg_645_1.actors_["1041ui_story"]) and arg_645_1.var_.characterEffect1041ui_story then
				arg_645_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_645_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_648_1 = 0
			local var_648_2 = 1.475

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_1 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_3 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(1104101159).content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 59 <= 0 and var_648_2 or var_648_2 * (utf8.len(var_648_3) / 59)

				if (59 <= 0 and var_648_2 or var_648_2 * (utf8.len(var_648_3) / 59)) > 0 and var_648_2 < var_648_5 then
					arg_645_1.talkMaxDuration = var_648_5

					if var_648_5 + var_648_1 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_5 + var_648_1
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_6 = math.max(var_648_2, arg_645_1.talkMaxDuration)

			if var_648_1 <= arg_645_1.time_ and arg_645_1.time_ < var_648_1 + var_648_6 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_1) / var_648_6

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_1 + var_648_6 and arg_645_1.time_ < var_648_1 + var_648_6 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1104101160 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1104101160
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play1104101161(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0.325

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				arg_649_1.leftNameTxt_.text = arg_649_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, true)
				arg_649_1.iconController_:SetSelectedState("hero")

				arg_649_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_649_1.callingController_:SetSelectedState("normal")

				arg_649_1.keyicon_.color = Color.New(1, 1, 1)
				arg_649_1.icon_.color = Color.New(1, 1, 1)

				local var_652_1 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(1104101160).content)

				arg_649_1.text_.text = var_652_1

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_3 = 13 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 13)

				if (13 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 13)) > 0 and var_652_0 < var_652_3 then
					arg_649_1.talkMaxDuration = var_652_3

					if var_652_3 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_3 + 0
					end
				end

				arg_649_1.text_.text = var_652_1
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_4 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_4 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_4

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_4 and arg_649_1.time_ < 0 + var_652_4 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play1104101161 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 1104101161
		arg_653_1.duration_ = 4.23

		local var_653_0 = {
			zh = 4.133,
			ja = 4.233
		}
		local var_653_1 = manager.audio:GetLocalizationFlag()

		if var_653_0[var_653_1] ~= nil then
			arg_653_1.duration_ = var_653_0[var_653_1]
		end

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play1104101162(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1.var_.moveOldPos1041ui_story = arg_653_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_656_0 = 0.001

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_0 then
				arg_653_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_653_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_653_1.time_ - 0) / var_656_0)
				arg_653_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_653_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1041ui_story"].transform.position).z)
				arg_653_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_653_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_653_1.actors_["1041ui_story"].transform.localEulerAngles = arg_653_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_653_1.time_ >= 0 + var_656_0 and arg_653_1.time_ < 0 + var_656_0 + arg_656_0 then
				arg_653_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_653_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_653_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_653_1.actors_["1041ui_story"].transform.position).z)
				arg_653_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_653_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_653_1.actors_["1041ui_story"].transform.localEulerAngles = arg_653_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_656_1 = arg_653_1.actors_["1041ui_story"]

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 and not isNil(var_656_1) and arg_653_1.var_.characterEffect1041ui_story == nil then
				arg_653_1.var_.characterEffect1041ui_story = var_656_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_656_2 = 0.200000002980232

			if 0 <= arg_653_1.time_ and arg_653_1.time_ < 0 + var_656_2 and not isNil(var_656_1) then
				if arg_653_1.var_.characterEffect1041ui_story and not isNil(var_656_1) then
					arg_653_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_653_1.time_ >= 0 + var_656_2 and arg_653_1.time_ < 0 + var_656_2 + arg_656_0 and not isNil(var_656_1) and arg_653_1.var_.characterEffect1041ui_story then
				arg_653_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= 0 + arg_656_0 then
				arg_653_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_656_4 = 0
			local var_656_5 = 0.775

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_4 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, true)

				arg_653_1.leftNameTxt_.text = arg_653_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_653_1.leftNameTxt_.transform)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1.leftNameTxt_.text)
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_6 = arg_653_1:GetWordFromCfg(1104101161)
				local var_656_7 = arg_653_1:FormatText(var_656_6.content)

				arg_653_1.text_.text = var_656_7

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_9 = 31 <= 0 and var_656_5 or var_656_5 * (utf8.len(var_656_7) / 31)

				if (31 <= 0 and var_656_5 or var_656_5 * (utf8.len(var_656_7) / 31)) > 0 and var_656_5 < var_656_9 then
					arg_653_1.talkMaxDuration = var_656_9

					if var_656_9 + var_656_4 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_9 + var_656_4
					end
				end

				arg_653_1.text_.text = var_656_7
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101161", "story_v_side_new_1104101.awb") ~= 0 then
					local var_656_10 = manager.audio:GetVoiceLength("story_v_side_new_1104101", "1104101161", "story_v_side_new_1104101.awb") / 1000

					if var_656_10 + var_656_4 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_10 + var_656_4
					end

					if var_656_6.prefab_name ~= "" and arg_653_1.actors_[var_656_6.prefab_name] ~= nil then
						local var_656_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_653_1.actors_[var_656_6.prefab_name].transform, "story_v_side_new_1104101", "1104101161", "story_v_side_new_1104101.awb")

						arg_653_1:RecordAudio("1104101161", var_656_11)
						arg_653_1:RecordAudio("1104101161", var_656_11)
					else
						arg_653_1:AudioAction("play", "voice", "story_v_side_new_1104101", "1104101161", "story_v_side_new_1104101.awb")
					end

					arg_653_1:RecordHistoryTalkVoice("story_v_side_new_1104101", "1104101161", "story_v_side_new_1104101.awb")
				end

				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_12 = math.max(var_656_5, arg_653_1.talkMaxDuration)

			if var_656_4 <= arg_653_1.time_ and arg_653_1.time_ < var_656_4 + var_656_12 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_4) / var_656_12

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_4 + var_656_12 and arg_653_1.time_ < var_656_4 + var_656_12 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_653_1:InitPlayNodeList()
	end,
	Play1104101162 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 1104101162
		arg_657_1.duration_ = 5

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
			arg_657_1.auto_ = false
		end

		function arg_657_1.playNext_(arg_659_0)
			arg_657_1.onStoryFinished_()
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 and not isNil(arg_657_1.actors_["1041ui_story"]) and arg_657_1.var_.characterEffect1041ui_story == nil then
				arg_657_1.var_.characterEffect1041ui_story = arg_657_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_660_0 = 0.200000002980232

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_0 and not isNil(arg_657_1.actors_["1041ui_story"]) then
				if arg_657_1.var_.characterEffect1041ui_story and not isNil(arg_657_1.actors_["1041ui_story"]) then
					arg_657_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_657_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_657_1.time_ - 0) / var_660_0)
				end
			end

			if arg_657_1.time_ >= 0 + var_660_0 and arg_657_1.time_ < 0 + var_660_0 + arg_660_0 and not isNil(arg_657_1.actors_["1041ui_story"]) and arg_657_1.var_.characterEffect1041ui_story then
				arg_657_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_657_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_660_1 = 0
			local var_660_2 = 0.05

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= var_660_1 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, true)
				arg_657_1.iconController_:SetSelectedState("hero")

				arg_657_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_657_1.callingController_:SetSelectedState("normal")

				arg_657_1.keyicon_.color = Color.New(1, 1, 1)
				arg_657_1.icon_.color = Color.New(1, 1, 1)

				local var_660_3 = arg_657_1:FormatText(arg_657_1:GetWordFromCfg(1104101162).content)

				arg_657_1.text_.text = var_660_3

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_5 = 2 <= 0 and var_660_2 or var_660_2 * (utf8.len(var_660_3) / 2)

				if (2 <= 0 and var_660_2 or var_660_2 * (utf8.len(var_660_3) / 2)) > 0 and var_660_2 < var_660_5 then
					arg_657_1.talkMaxDuration = var_660_5

					if var_660_5 + var_660_1 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_5 + var_660_1
					end
				end

				arg_657_1.text_.text = var_660_3
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)
				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_6 = math.max(var_660_2, arg_657_1.talkMaxDuration)

			if var_660_1 <= arg_657_1.time_ and arg_657_1.time_ < var_660_1 + var_660_6 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - var_660_1) / var_660_6

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= var_660_1 + var_660_6 and arg_657_1.time_ < var_660_1 + var_660_6 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F03_2",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I03",
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/F04"
	},
	voices = {
		"story_v_side_new_1104101.awb"
	}
}
